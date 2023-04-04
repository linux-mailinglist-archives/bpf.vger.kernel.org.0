Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981A96D6CB3
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjDDSyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 14:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjDDSym (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 14:54:42 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BC35BD
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 11:54:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r187so39915213ybr.6
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680634474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAMntFuVUxcjQGjqKOsMqjrYANqS7QLDtG6HbUrikjo=;
        b=fvrkJCt6AnbuJE0OSNy20WcD+mEb8oQXQd6kmRBDlwbT1Z35fyCJmpNLWYeT1oAYhF
         Yp/7kDDUCdPzoyVtn0p8+d8QmSMOOWuP6/ZyAEZF1qv4yAkMCjEuKgUq8YS/BR9Bj/jb
         vy+3I58Oqz4TW7PXKPe36YNIpAhrFlXfvcUuW+2OHDc0oGqHL+KJ0fmbLBN4S9/fpdBg
         cN6L6WDWbppLc3MO4D8iSnIQbxPC9hiWwnsAys4UDfVSIsgOYOAp33K7j14esUOeTrni
         dIKpHgeQeHi9oXPqoOeyXocjyVW9/m0JqbzzpQVifd82l6BnvJDhHIxtdSW5P0tMt1nD
         kTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAMntFuVUxcjQGjqKOsMqjrYANqS7QLDtG6HbUrikjo=;
        b=BA7XG6sRyjBA8CsecgLt1m3jwZgWIUv5en/flVlPpjNT26FXnSrU8GmZYSqhj4DQxw
         CW34+qSxoJ9b1LkL+GQt0gFtpzaZehP1b3g8P2H2j2UTwWlVF4opFIx3mnnYHsVypar4
         /+WWbzgSMQEJXfzAq8Z1panEwBEPqwScaC6CeAzzILuRQOiYmZKTVPvVVLCq9SCqI76A
         ch5BtuyCVlIy/b/gNQahthaKRCkYTLkGLUe2jwfxVs4glXBVlNDTQvbAeo3OtpfctLHA
         yXlqyD/f+w0JwknpDL49Va748o/zO13dTygaG1xz1GRtlnF6qTyYG990xI6GkLiLORcG
         nExA==
X-Gm-Message-State: AAQBX9euzpbsZ1TCWExGR28pGB37/oGM1FxIALJFCc3ER+5ipu+z4Kqe
        Hz/pzMQ5NovCvYJG3fE6v+o8qqezXCiH7OZH5yNJ
X-Google-Smtp-Source: AKy350ZlpQ3G+TPq3lVKv8ybQiekC2uNbxt3eDV0PZaFtAt/VJQcw3YTwBr1TPputpWdpI1dPijSYidu4+moUJ/Q93M=
X-Received: by 2002:a25:d1c6:0:b0:b68:7a4a:5258 with SMTP id
 i189-20020a25d1c6000000b00b687a4a5258mr2519686ybg.3.1680634474358; Tue, 04
 Apr 2023 11:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com> <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 4 Apr 2023 14:54:23 -0400
Message-ID: <CAHC9VhSbGdij6xz9D49my37kD9qYrBmh2x7=cNFFDL2dZ=EZTw@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 31, 2023 at 8:33=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Currently, security_inode_init_security() supports only one LSM providing
> an xattr and EVM calculating the HMAC on that xattr, plus other inode
> metadata.
>
> Allow all LSMs to provide one or multiple xattrs, by extending the securi=
ty
> blob reservation mechanism. Introduce the new lbs_xattr_count field of th=
e
> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> needs, and the LSM infrastructure knows how many xattr slots it should
> allocate.
>
> Dynamically allocate the new_xattrs array to be populated by LSMs with th=
e
> inode_init_security hook, and pass it to the latter instead of the
> name/value/len triple. Unify the !initxattrs and initxattrs case, simply
> don't allocate the new_xattrs array in the former.
>
> Also, pass to the hook the number of xattrs filled by each LSM, so that
> there are no gaps when the next LSM fills the array. Gaps might occur
> because an LSM can legitimately request xattrs to the LSM infrastructure,
> but not fill the reserved slots, if it was not initialized.
>
> Update the documentation of security_inode_init_security() to reflect the
> changes, and fix the description of the xattr name, as it is not allocate=
d
> anymore.
>
> Finally, adapt both SELinux and Smack to use the new definition of the
> inode_init_security hook, and to fill the reserved slots in the xattr
> array. Introduce the lsm_get_xattr_slot() helper to retrieve an available
> slot to fill, and to increment the number of filled slots.
>
> Move the xattr->name assignment after the xattr->value one, so that it is
> done only in case of successful memory allocation. For Smack, also reserv=
e
> space for the other defined xattrs although they are not set yet in
> smack_inode_init_security().
>
> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash=
)
> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  6 +--
>  include/linux/lsm_hooks.h     | 20 ++++++++++
>  security/security.c           | 71 +++++++++++++++++++++++------------
>  security/selinux/hooks.c      | 17 +++++----
>  security/smack/smack_lsm.c    | 32 ++++++++++------
>  5 files changed, 99 insertions(+), 47 deletions(-)

This looks good aside from a few small things (below).  From what I
can see, there are only two outstanding issues to answer: the number
of Smack xattrs, sign-off from Casey for the Smack bits.

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 6bb55e61e8e..a1896f90089 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -111,9 +111,9 @@ LSM_HOOK(int, 0, path_notify, const struct path *path=
, u64 mask,
>          unsigned int obj_type)
>  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> -        struct inode *dir, const struct qstr *qstr, const char **name,
> -        void **value, size_t *len)
> +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
> +        struct inode *dir, const struct qstr *qstr, struct xattr *xattrs=
,
> +        int *xattr_count)
>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>          const struct qstr *name, const struct inode *context_inode)
>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c2be66c669a..9eb9b686493 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -28,6 +28,7 @@
>  #include <linux/security.h>
>  #include <linux/init.h>
>  #include <linux/rculist.h>
> +#include <linux/xattr.h>
>
>  union security_list_options {
>         #define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__=
);
> @@ -63,8 +64,27 @@ struct lsm_blob_sizes {
>         int     lbs_ipc;
>         int     lbs_msg_msg;
>         int     lbs_task;
> +       int     lbs_xattr_count; /* number of xattr slots in new_xattrs a=
rray */
>  };
>
> +/**
> + * lsm_get_xattr_slot - Return the next available slot and increment the=
 index
> + * @xattrs: array storing LSM-provided xattrs
> + * @xattr_count: number of already stored xattrs (updated)
> + *
> + * Retrieve the first available slot in the @xattrs array to fill with a=
n xattr,
> + * and increment @xattr_count.
> + *
> + * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
> + */
> +static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
> +                                              int *xattr_count)
> +{
> +       if (unlikely(!xattrs))
> +               return NULL;
> +       return xattrs + (*xattr_count)++;
> +}
> +
>  /*
>   * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for=
 void
>   * LSM hooks (in include/linux/lsm_hook_defs.h).
> diff --git a/security/security.c b/security/security.c
> index f4170efcddd..1aeaa8ce449 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -31,8 +31,6 @@
>  #include <linux/msg.h>
>  #include <net/flow.h>
>
> -#define MAX_LSM_EVM_XATTR      2
> -
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>
> @@ -212,6 +210,8 @@ static void __init lsm_set_blob_sizes(struct lsm_blob=
_sizes *needed)
>         lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>         lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superb=
lock);
>         lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> +       lsm_set_blob_size(&needed->lbs_xattr_count,
> +                         &blob_sizes.lbs_xattr_count);
>  }
>
>  /* Prepare LSM for initialization. */
> @@ -378,6 +378,7 @@ static void __init ordered_lsm_init(void)
>         init_debug("msg_msg blob size    =3D %d\n", blob_sizes.lbs_msg_ms=
g);
>         init_debug("superblock blob size =3D %d\n", blob_sizes.lbs_superb=
lock);
>         init_debug("task blob size       =3D %d\n", blob_sizes.lbs_task);
> +       init_debug("xattr slots          =3D %d\n", blob_sizes.lbs_xattr_=
count);
>
>         /*
>          * Create any kmem_caches needed for blobs
> @@ -1591,11 +1592,15 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
>   * created inode and set up the incore security field for the new inode.=
  This
>   * hook is called by the fs code as part of the inode creation transacti=
on and
>   * provides for atomic labeling of the inode, unlike the post_create/mkd=
ir/...
> - * hooks called by the VFS.  The hook function is expected to allocate t=
he name
> - * and value via kmalloc, with the caller being responsible for calling =
kfree
> - * after using them.  If the security module does not use security attri=
butes
> - * or does not wish to put a security attribute on this particular inode=
, then
> - * it should return -EOPNOTSUPP to skip this processing.
> + * hooks called by the VFS.  The hook function is expected to populate t=
he
> + * @xattrs array, by calling lsm_get_xattr_slot() to retrieve the slots
> + * reserved by the security module with the lbs_xattr_count field of the
> + * lsm_blob_sizes structure.  For each slot, the hook function should se=
t ->name
> + * to the attribute name suffix (e.g. selinux), to allocate ->value (wil=
l be
> + * freed by the caller) and set it to the attribute value, to set ->valu=
e_len to
> + * the length of the value.  If the security module does not use securit=
y
> + * attributes or does not wish to put a security attribute on this parti=
cular
> + * inode, then it should return -EOPNOTSUPP to skip this processing.
>   *
>   * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
>   * needed, or -ENOMEM on memory allocation failure.
> @@ -1604,33 +1609,51 @@ int security_inode_init_security(struct inode *in=
ode, struct inode *dir,
>                                  const struct qstr *qstr,
>                                  const initxattrs initxattrs, void *fs_da=
ta)
>  {
> -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> -       int ret;
> +       struct security_hook_list *P;
> +       struct xattr *new_xattrs =3D NULL;
> +       int ret =3D -EOPNOTSUPP, xattr_count =3D 0;
>
>         if (unlikely(IS_PRIVATE(inode)))
>                 return 0;
>
> -       if (!initxattrs)
> -               return call_int_hook(inode_init_security, -EOPNOTSUPP, in=
ode,
> -                                    dir, qstr, NULL, NULL, NULL);
> -       memset(new_xattrs, 0, sizeof(new_xattrs));
> -       lsm_xattr =3D new_xattrs;
> -       ret =3D call_int_hook(inode_init_security, -EOPNOTSUPP, inode, di=
r, qstr,
> -                           &lsm_xattr->name,
> -                           &lsm_xattr->value,
> -                           &lsm_xattr->value_len);
> -       if (ret)
> +       if (!blob_sizes.lbs_xattr_count)
> +               return 0;
> +
> +       if (initxattrs) {
> +               /* Allocate +1 for EVM and +1 as terminator. */
> +               new_xattrs =3D kcalloc(blob_sizes.lbs_xattr_count + 2,
> +                                    sizeof(*new_xattrs), GFP_NOFS);
> +               if (!new_xattrs)
> +                       return -ENOMEM;
> +       }
> +
> +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> +                            list) {
> +               ret =3D P->hook.inode_init_security(inode, dir, qstr, new=
_xattrs,
> +                                                 &xattr_count);
> +               if (ret && ret !=3D -EOPNOTSUPP)
> +                       goto out;
> +               /*
> +                * As documented in lsm_hooks.h, -EOPNOTSUPP in this cont=
ext
> +                * means that the LSM is not willing to provide an xattr,=
 not
> +                * that it wants to signal an error. Thus, continue to in=
voke
> +                * the remaining LSMs.
> +                */
> +       }
> +
> +       /* If initxattrs() is NULL, xattr_count is zero, skip the call. *=
/
> +       if (!xattr_count)
>                 goto out;
>
> -       evm_xattr =3D lsm_xattr + 1;
> -       ret =3D evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +       ret =3D evm_inode_init_security(inode, new_xattrs,
> +                                     new_xattrs + xattr_count);

I think it's cleaner to write '&new_xattrs[xattr_count]' for the third
parameter above (no concerns around pointer math), and stylistically
it matches better with the for-kfree loop below.

>         if (ret)
>                 goto out;
>         ret =3D initxattrs(inode, new_xattrs, fs_data);
>  out:
> -       for (xattr =3D new_xattrs; xattr->value !=3D NULL; xattr++)
> -               kfree(xattr->value);
> +       for (; xattr_count > 0; xattr_count--)
> +               kfree(new_xattrs[xattr_count - 1].value);
> +       kfree(new_xattrs);
>         return (ret =3D=3D -EOPNOTSUPP) ? 0 : ret;
>  }
>  EXPORT_SYMBOL(security_inode_init_security);

...

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index cfcbb748da2..8392983334b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -52,6 +52,15 @@
>  #define SMK_RECEIVING  1
>  #define SMK_SENDING    2
>
> +/*
> + * Smack uses multiple xattrs.
> + * SMACK64 - for access control, SMACK64EXEC - label for the program,

I think it would be good to move SMACK64EXEC to its own line; it took
me a minute to figure out why SMACK_INODE_INIT_XATTRS was set to '4'
when I only say three comment lines ... ;)

> + * SMACK64MMAP - controls library loading,
> + * SMACK64TRANSMUTE - label initialization,
> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
> + */
> +#define SMACK_INODE_INIT_XATTRS 4

If smack_inode_init_security() only ever populates a single xattr, and
that is the only current user of SMACK_INODE_INIT_XATTRS, can we make
this '1' and shrink the xattr allocation a bit?

>  #ifdef SMACK_IPV6_PORT_LABELING
>  static DEFINE_MUTEX(smack_ipv6_lock);
>  static LIST_HEAD(smk_ipv6_port_list);
> @@ -939,26 +948,23 @@ static int smack_inode_alloc_security(struct inode =
*inode)
>   * @inode: the newly created inode
>   * @dir: containing directory object
>   * @qstr: unused
> - * @name: where to put the attribute name
> - * @value: where to put the attribute value
> - * @len: where to put the length of the attribute
> + * @xattrs: where to put the attributes
> + * @xattr_count: current number of LSM-provided xattrs (updated)
>   *
>   * Returns 0 if it all works out, -ENOMEM if there's no memory
>   */
>  static int smack_inode_init_security(struct inode *inode, struct inode *=
dir,
> -                                    const struct qstr *qstr, const char =
**name,
> -                                    void **value, size_t *len)
> +                                    const struct qstr *qstr,
> +                                    struct xattr *xattrs, int *xattr_cou=
nt)
>  {
>         struct inode_smack *issp =3D smack_inode(inode);
>         struct smack_known *skp =3D smk_of_current();
>         struct smack_known *isp =3D smk_of_inode(inode);
>         struct smack_known *dsp =3D smk_of_inode(dir);
> +       struct xattr *xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
>         int may;
>
> -       if (name)
> -               *name =3D XATTR_SMACK_SUFFIX;
> -
> -       if (value && len) {
> +       if (xattr) {
>                 rcu_read_lock();
>                 may =3D smk_access_entry(skp->smk_known, dsp->smk_known,
>                                        &skp->smk_rules);
> @@ -976,11 +982,12 @@ static int smack_inode_init_security(struct inode *=
inode, struct inode *dir,
>                         issp->smk_flags |=3D SMK_INODE_CHANGED;
>                 }
>
> -               *value =3D kstrdup(isp->smk_known, GFP_NOFS);
> -               if (*value =3D=3D NULL)
> +               xattr->value =3D kstrdup(isp->smk_known, GFP_NOFS);
> +               if (xattr->value =3D=3D NULL)
>                         return -ENOMEM;
>
> -               *len =3D strlen(isp->smk_known);
> +               xattr->value_len =3D strlen(isp->smk_known);
> +               xattr->name =3D XATTR_SMACK_SUFFIX;
>         }
>
>         return 0;
> @@ -4854,6 +4861,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_aft=
er_init =3D {
>         .lbs_ipc =3D sizeof(struct smack_known *),
>         .lbs_msg_msg =3D sizeof(struct smack_known *),
>         .lbs_superblock =3D sizeof(struct superblock_smack),
> +       .lbs_xattr_count =3D SMACK_INODE_INIT_XATTRS,
>  };
>
>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init =3D {
> --
> 2.25.1

--=20
paul-moore.com
