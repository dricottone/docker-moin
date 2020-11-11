# docker-moin

Deploy a moinmoin wiki using Docker.


## Setup

In `nginx/moinmoin.conf`, configure the server name (`s/example.com/your_domain_name_here/g`).

In `moinmoin/wikiconfig.py`, configure the wiki name (`s/Untitled Wiki/your_wiki_name_here`). Also configure the security section to suit your needs.

{{{
    # Security ----------------------------------------------------------

    # This is checked by some rather critical and potentially harmful actions,
    # like despam or PackageInstaller action:
    superuser = [u"your_name_here"]

    # Some actions are by default only enabled for superusers and disabled
    # for everybody else.
    # 'newaccount' is one of these (used to let visitors create new accounts).
    # You can create wiki users on the shell by using "moin account create".
    # A superuser also can use "Settings" -> "Switch user" to create users.
    # If you need the newaccount action for everybody (e.g. to create your
    # very first [superuser] account), you can (temporarily) enable it:
    #actions_superuser = multiconfig.DefaultConfig.actions_superuser[:]
    #actions_superuser.remove('newaccount')

    # IMPORTANT: grant yourself admin rights! replace YourName with
    # your user name. See HelpOnAccessControlLists for more help.
    # All acl_rights_xxx options must use unicode [Unicode]
    acl_rights_before = u"your_name_here:read,write,delete,revert,admin"

    # This is the default ACL that applies to pages without an ACL.
    # Adapt it to your needs, consider using an EditorGroup.
    acl_rights_default = u"Trusted:read,write,delete,revert Known:read,write,delete,revert All:read"

    # The default (ENABLED) password_checker will keep users from choosing too
    # short or too easy passwords. If you don't like this and your site has
    # rather low security requirements, feel free to DISABLE the checker by:
    #password_checker = None # None means "don't do any password strength checks"

    # Link spam protection for public wikis (Uncomment to enable)
    # Needs a reliable internet connection.
    #from MoinMoin.security.antispam import SecurityPolicy
}}}

The web server will be accessible on port 8080.


## Security

The stable release of moinmoin (v1.9) is written for python2. It is a complex
(i.e. multiple vendored libraries), web-facing (i.e. interprets and executes
user input) service. There have been high-risk CVE's as recently as November
2020 (see CVE-2020-15275).

Python 2.7 is unsupported as of January 2020.

Alpine Linux v3.10 (the last to support critical python2 dependencies) receives
security fixes only and will reach end of life in November 2021.

Good luck.


