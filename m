Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CE56D1857
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 09:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCaHSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 03:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCaHST (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 03:18:19 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0C3EF8E;
        Fri, 31 Mar 2023 00:18:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PnrxL1mgCz9xHvH;
        Fri, 31 Mar 2023 15:08:54 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3OQUJiSZkcN3jAQ--.5065S2;
        Fri, 31 Mar 2023 08:17:42 +0100 (CET)
Message-ID: <35f2b3e04fba01d9002e549a1a3e9f5771053793.camel@huaweicloud.com>
Subject: Re: [PATCH v9 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 31 Mar 2023 09:17:25 +0200
In-Reply-To: <CAHC9VhTTcejig61X1Qf_rXWzjyz8HNLNg=KqExRqDH7+McChkw@mail.gmail.com>
References: <20230329130415.2312521-1-roberto.sassu@huaweicloud.com>
         <20230329130415.2312521-3-roberto.sassu@huaweicloud.com>
         <CAHC9VhTTcejig61X1Qf_rXWzjyz8HNLNg=KqExRqDH7+McChkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3OQUJiSZkcN3jAQ--.5065S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uF15Cw1kGFy3JFyDuw1fXrb_yoW8ArWDuo
        WxJwnrJrW0qr13GrW5Was7JFZruayrWw48Jr4Yvr45A3W3tw1jkw13Xay8Xa13WFyrKr4U
        K3s7A340qFZFqas8n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj4tiywABsa
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-03-30 at 18:50 -0400, Paul Moore wrote:
> On Wed, Mar 29, 2023 at 9:05 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Currently, security_inode_init_security() supports only one LSM providing
> > an xattr and EVM calculating the HMAC on that xattr, plus other inode
> > metadata.
> > 
> > Allow all LSMs to provide one or multiple xattrs, by extending the security
> > blob reservation mechanism. Introduce the new lbs_xattr_count field of the
> > lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> > needs, and the LSM infrastructure knows how many xattr slots it should
> > allocate.
> > 
> > Dynamically allocate the new_xattrs array to be populated by LSMs with the
> > inode_init_security hook, and pass it to the latter instead of the
> > name/value/len triple.
> > 
> > Also, pass to the hook the number of xattrs filled by each LSM, so that
> > there are no gaps when the next LSM fills the array. Gaps might occur
> > because an LSM can legitimately request xattrs to the LSM infrastructure,
> > but not fill the reserved slots, if it was not initialized.
> > 
> > Update the documentation of security_inode_init_security() to reflect the
> > changes, and fix the description of the xattr name, as it is not allocated
> > anymore.
> > 
> > On the security_inode_init_security() side, ensure that if LSMs returned
> > zero from the hook, they correctly filled a new_xattrs slot. Consequently,
> > change the default return value of the hook to -EOPNOTSUPP, so that BPF LSM
> > returns that, and does not cause security_inode_init_security() to fail.
> > 
> > Finally, adapt both SELinux and Smack to use the new definition of the
> > inode_init_security hook, and to fill the reserved slots in the xattr
> > array. Introduce the lsm_find_xattr_slot() helper to retrieve an available
> > slot to fill, and to increment the number of filled slots.
> > 
> > Move the xattr->name assignment after the xattr->value one, so that it is
> > done only in case of successful memory allocation. For Smack, also reserve
> > space for the other defined xattrs although they are not set yet in
> > smack_inode_init_security().
> > 
> > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
> > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  6 +--
> >  include/linux/lsm_hooks.h     | 14 ++++++
> >  security/security.c           | 92 +++++++++++++++++++++++++++--------
> >  security/selinux/hooks.c      | 18 ++++---
> >  security/smack/smack_lsm.c    | 33 ++++++++-----
> >  5 files changed, 120 insertions(+), 43 deletions(-)
> > 
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 6bb55e61e8e..1fd95db0087 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -111,9 +111,9 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
> >          unsigned int obj_type)
> >  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
> >  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> > -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> > -        struct inode *dir, const struct qstr *qstr, const char **name,
> > -        void **value, size_t *len)
> > +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
> > +        struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
> > +        int *num_filled_xattrs)
> >  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> >          const struct qstr *name, const struct inode *context_inode)
> >  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index c2be66c669a..b60de5f2f34 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -28,6 +28,7 @@
> >  #include <linux/security.h>
> >  #include <linux/init.h>
> >  #include <linux/rculist.h>
> > +#include <linux/xattr.h>
> > 
> >  union security_list_options {
> >         #define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
> > @@ -63,8 +64,21 @@ struct lsm_blob_sizes {
> >         int     lbs_ipc;
> >         int     lbs_msg_msg;
> >         int     lbs_task;
> > +       int     lbs_xattr_count; /* number of xattr slots in new_xattrs array */
> >  };
> > 
> > +/*
> > + * Retrieve the first available slot to fill with an xattr, and increment
> > + * the number of filled slots.
> > + */
> > +static inline struct xattr *lsm_find_xattr_slot(struct xattr *xattrs,
> > +                                               int *num_filled_xattrs)
> > +{
> > +       if (unlikely(!xattrs))
> > +               return NULL;
> > +       return xattrs + (*num_filled_xattrs)++;
> > +}
> 
> Since this function increments the @num_filled_xattrs parameter in
> addition to returning the next available xattr array slot, let's
> replace the "find" with "get" so there is some hint that the state is
> changing, i.e. the count is being bumped (similar to the "get" and
> "put" concept).
> 
> It would also be nice if you could use the kdoc style for the function
> comment block; if nothing else it is a known format and consistent
> documentation is good, even if it never makes it out of the source
> file.

Ok, will do.

> >  /*
> >   * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for void
> >   * LSM hooks (in include/linux/lsm_hook_defs.h).
> > diff --git a/security/security.c b/security/security.c
> > index f4170efcddd..be33d643a81 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -31,8 +31,6 @@
> >  #include <linux/msg.h>
> >  #include <net/flow.h>
> > 
> > -#define MAX_LSM_EVM_XATTR      2
> > -
> >  /* How many LSMs were built into the kernel? */
> >  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> > 
> > @@ -212,6 +210,8 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> >         lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> >         lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> >         lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> > +       lsm_set_blob_size(&needed->lbs_xattr_count,
> > +                         &blob_sizes.lbs_xattr_count);
> >  }
> > 
> >  /* Prepare LSM for initialization. */
> > @@ -378,6 +378,7 @@ static void __init ordered_lsm_init(void)
> >         init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
> >         init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> >         init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> > +       init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
> > 
> >         /*
> >          * Create any kmem_caches needed for blobs
> > @@ -1591,11 +1592,15 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
> >   * created inode and set up the incore security field for the new inode.  This
> >   * hook is called by the fs code as part of the inode creation transaction and
> >   * provides for atomic labeling of the inode, unlike the post_create/mkdir/...
> > - * hooks called by the VFS.  The hook function is expected to allocate the name
> > - * and value via kmalloc, with the caller being responsible for calling kfree
> > - * after using them.  If the security module does not use security attributes
> > - * or does not wish to put a security attribute on this particular inode, then
> > - * it should return -EOPNOTSUPP to skip this processing.
> > + * hooks called by the VFS.  The hook function is expected to populate the
> > + * @xattrs array, by calling lsm_find_xattr_slot() to retrieve the slots
> > + * reserved by the security module with the lbs_xattr_count field of the
> > + * lsm_blob_sizes structure.  For each slot, the hook function should set ->name
> > + * to the attribute name suffix (e.g. selinux), to allocate ->value (will be
> > + * freed by the caller) and set it to the attribute value, to set ->value_len to
> > + * the length of the value.  If the security module does not use security
> > + * attributes or does not wish to put a security attribute on this particular
> > + * inode, then it should return -EOPNOTSUPP to skip this processing.
> >   *
> >   * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
> >   * needed, or -ENOMEM on memory allocation failure.
> > @@ -1604,33 +1609,80 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> >                                  const struct qstr *qstr,
> >                                  const initxattrs initxattrs, void *fs_data)
> >  {
> > -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> > -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > -       int ret;
> > +       struct security_hook_list *P;
> > +       struct xattr *new_xattrs;
> > +       struct xattr *xattr;
> > +       int num_filled_xattrs = 0, old_num_filled_xattrs;
> 
> I think you can get rid of @old_num_filled_xattrs (see below), but how
> about changing @num_filled_xattrs to @xattr_count, it's shorter and
> just as accurate.

Ok.

> > +       int ret = -EOPNOTSUPP, i;
> > 
> >         if (unlikely(IS_PRIVATE(inode)))
> >                 return 0;
> > 
> > +       if (!blob_sizes.lbs_xattr_count)
> > +               return 0;
> > +
> >         if (!initxattrs)
> >                 return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> > -                                    dir, qstr, NULL, NULL, NULL);
> 
> I would have expected the !initxattrs case to still be handled in the
> hook loop below, is there a reason why we don't want to do that?  If
> including it in the loop below is too much of a hassle (conditional
> array allocation, etc.), should we at least put it in it's own loop?
> It seems wrong that we wouldn't run through all of the LSM hooks in
> this case ...

Uhm, you are right. If you add another loop, the function starts to be
too long. I would just check if initxattrs is not NULL below.

> > -       memset(new_xattrs, 0, sizeof(new_xattrs));
> > -       lsm_xattr = new_xattrs;
> > -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> > -                           &lsm_xattr->name,
> > -                           &lsm_xattr->value,
> > -                           &lsm_xattr->value_len);
> > -       if (ret)
> > +                                   dir, qstr, NULL, NULL);
> > +       /* Allocate +1 for EVM and +1 as terminator. */
> > +       new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 2,
> > +                            sizeof(*new_xattrs), GFP_NOFS);
> > +       if (!new_xattrs)
> > +               return -ENOMEM;
> > +
> > +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> > +                            list) {
> > +               old_num_filled_xattrs = num_filled_xattrs;
> > +
> > +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs,
> > +                                                 &num_filled_xattrs);
> > +               if (ret && ret != -EOPNOTSUPP)
> > +                       goto out;
> > +               /*
> > +                * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
> > +                * means that the LSM is not willing to provide an xattr, not
> > +                * that it wants to signal an error. Thus, continue to invoke
> > +                * the remaining LSMs.
> > +                */
> > +               if (ret == -EOPNOTSUPP)
> > +                       continue;
> > +
> > +               /* LSM should fill new_xattrs if it returns zero. */
> > +               if (old_num_filled_xattrs == num_filled_xattrs) {
> > +                       WARN_ONCE(1, "LSM %s: returned zero but didn't fill any slot\n",
> > +                                 P->lsm);
> > +                       ret = -EINVAL;
> > +                       goto out;
> > +               }
> 
> Do we really need this check?  We don't currently check that LSMs
> setup their xattrs properly and we are doing okay.
> 
> > +               /*
> > +                * For filled xattr slots, name and value must be non-NULL.
> > +                *
> > +                * NULL value is interpreted by filesystems as a remove op, see
> > +                * ext4_xattr_set_handle() for more details.
> > +                */
> > +               for (i = old_num_filled_xattrs; i < num_filled_xattrs; i++) {
> > +                       if (!new_xattrs[i].name || !new_xattrs[i].value) {
> > +                               WARN_ONCE(1, "LSM %s: NULL xattr name and/or value\n",
> > +                                         P->lsm);
> > +                               ret = -EINVAL;
> > +                               goto out;
> > +                       }
> > +               }
> 
> Same here.  I worry this is extra processing with little benefit.  The
> LSM updates the xattr count and we should trust it is correct.

Ok, no problem for me to remove.

Sometimes more checks help to detect undesired changes in other parts
of the code.

> > +       }
> > +
> > +       if (!num_filled_xattrs)
> >                 goto out;
> > 
> > -       evm_xattr = lsm_xattr + 1;
> > -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> > +       ret = evm_inode_init_security(inode, new_xattrs,
> > +                                     new_xattrs + num_filled_xattrs);
> >         if (ret)
> >                 goto out;
> >         ret = initxattrs(inode, new_xattrs, fs_data);
> >  out:
> >         for (xattr = new_xattrs; xattr->value != NULL; xattr++)
> >                 kfree(xattr->value);
> 
> We can probably drop the need for the @xattr variable by using @xattr_count.
> 
>   for (; xattr_count > 0; xattr_count--)
>     kfree(new_xattrs[xattr_count - 1]->value);

Ok.

> > +       kfree(new_xattrs);
> >         return (ret == -EOPNOTSUPP) ? 0 : ret;
> >  }
> >  EXPORT_SYMBOL(security_inode_init_security);
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 9a5bdfc2131..dc349cf34e8 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -104,6 +104,8 @@
> >  #include "audit.h"
> >  #include "avc_ss.h"
> > 
> > +#define SELINUX_INODE_INIT_XATTRS 1
> > +
> >  struct selinux_state selinux_state;
> > 
> >  /* SECMARK reference count */
> > @@ -2868,11 +2870,12 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
> > 
> >  static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >                                        const struct qstr *qstr,
> > -                                      const char **name,
> > -                                      void **value, size_t *len)
> > +                                      struct xattr *xattrs,
> > +                                      int *num_filled_xattrs)
> 
> Use 'xattr_count'.
> 
> >  {
> >         const struct task_security_struct *tsec = selinux_cred(current_cred());
> >         struct superblock_security_struct *sbsec;
> > +       struct xattr *xattr = lsm_find_xattr_slot(xattrs, num_filled_xattrs);
> >         u32 newsid, clen;
> >         int rc;
> >         char *context;
> > @@ -2899,16 +2902,14 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >             !(sbsec->flags & SBLABEL_MNT))
> >                 return -EOPNOTSUPP;
> > 
> > -       if (name)
> > -               *name = XATTR_SELINUX_SUFFIX;
> > -
> > -       if (value && len) {
> > +       if (xattr) {
> >                 rc = security_sid_to_context_force(&selinux_state, newsid,
> >                                                    &context, &clen);
> >                 if (rc)
> >                         return rc;
> > -               *value = context;
> > -               *len = clen;
> > +               xattr->value = context;
> > +               xattr->value_len = clen;
> > +               xattr->name = XATTR_SELINUX_SUFFIX;
> >         }
> > 
> >         return 0;
> > @@ -6918,6 +6919,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
> >         .lbs_ipc = sizeof(struct ipc_security_struct),
> >         .lbs_msg_msg = sizeof(struct msg_security_struct),
> >         .lbs_superblock = sizeof(struct superblock_security_struct),
> > +       .lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
> >  };
> > 
> >  #ifdef CONFIG_PERF_EVENTS
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index cfcbb748da2..ba10f4e8632 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -52,6 +52,15 @@
> >  #define SMK_RECEIVING  1
> >  #define SMK_SENDING    2
> > 
> > +/*
> > + * Smack uses multiple xattrs.
> > + * SMACK64 - for access control, SMACK64EXEC - label for the program,
> > + * SMACK64MMAP - controls library loading,
> > + * SMACK64TRANSMUTE - label initialization,
> > + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
> > + */
> > +#define SMACK_INODE_INIT_XATTRS 4
> > +
> >  #ifdef SMACK_IPV6_PORT_LABELING
> >  static DEFINE_MUTEX(smack_ipv6_lock);
> >  static LIST_HEAD(smk_ipv6_port_list);
> > @@ -939,26 +948,24 @@ static int smack_inode_alloc_security(struct inode *inode)
> >   * @inode: the newly created inode
> >   * @dir: containing directory object
> >   * @qstr: unused
> > - * @name: where to put the attribute name
> > - * @value: where to put the attribute value
> > - * @len: where to put the length of the attribute
> > + * @xattrs: where to put the attributes
> > + * @num_filled_xattrs: current number of filled xattrs (updated)
> >   *
> >   * Returns 0 if it all works out, -ENOMEM if there's no memory
> >   */
> >  static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> > -                                    const struct qstr *qstr, const char **name,
> > -                                    void **value, size_t *len)
> > +                                    const struct qstr *qstr,
> > +                                    struct xattr *xattrs,
> > +                                    int *num_filled_xattrs)
> 
> I'll leave this up to Casey, but 'xattr_count' would be my vote :)

Ok, fine also for me.

Thanks

Roberto

> >  {
> >         struct inode_smack *issp = smack_inode(inode);
> >         struct smack_known *skp = smk_of_current();
> >         struct smack_known *isp = smk_of_inode(inode);
> >         struct smack_known *dsp = smk_of_inode(dir);
> > +       struct xattr *xattr = lsm_find_xattr_slot(xattrs, num_filled_xattrs);
> >         int may;
> > 
> > -       if (name)
> > -               *name = XATTR_SMACK_SUFFIX;
> > -
> > -       if (value && len) {
> > +       if (xattr) {
> >                 rcu_read_lock();
> >                 may = smk_access_entry(skp->smk_known, dsp->smk_known,
> >                                        &skp->smk_rules);
> > @@ -976,11 +983,12 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> >                         issp->smk_flags |= SMK_INODE_CHANGED;
> >                 }
> > 
> > -               *value = kstrdup(isp->smk_known, GFP_NOFS);
> > -               if (*value == NULL)
> > +               xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> > +               if (xattr->value == NULL)
> >                         return -ENOMEM;
> > 
> > -               *len = strlen(isp->smk_known);
> > +               xattr->value_len = strlen(isp->smk_known);
> > +               xattr->name = XATTR_SMACK_SUFFIX;
> >         }
> > 
> >         return 0;
> > @@ -4854,6 +4862,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
> >         .lbs_ipc = sizeof(struct smack_known *),
> >         .lbs_msg_msg = sizeof(struct smack_known *),
> >         .lbs_superblock = sizeof(struct superblock_smack),
> > +       .lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
> >  };
> > 
> >  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
> > --
> > 2.25.1

