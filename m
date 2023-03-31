Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7336D2004
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjCaMVQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 08:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjCaMU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 08:20:59 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7584B1F788;
        Fri, 31 Mar 2023 05:20:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pnzct19HTz9v7gV;
        Fri, 31 Mar 2023 20:10:06 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAn+V+lzyZkRqPiAQ--.4795S2;
        Fri, 31 Mar 2023 13:18:56 +0100 (CET)
Message-ID: <ca6d4080b0f234b5321d965fb1350bfcd291646e.camel@huaweicloud.com>
Subject: Re: [PATCH v9 3/4] evm: Align evm_inode_init_security() definition
 with LSM infrastructure
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
Date:   Fri, 31 Mar 2023 14:18:42 +0200
In-Reply-To: <bfe74fff24a5a7a8059acc00c29ac957bf0b7880.camel@huaweicloud.com>
References: <20230329130415.2312521-1-roberto.sassu@huaweicloud.com>
         <20230329130415.2312521-4-roberto.sassu@huaweicloud.com>
         <CAHC9VhSDVv30ce2652kridRU7iaQQ19tiGubWpyP0mi7pf+JJw@mail.gmail.com>
         <bfe74fff24a5a7a8059acc00c29ac957bf0b7880.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAn+V+lzyZkRqPiAQ--.4795S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4rurWrtr1Uuw1kurykXwb_yoWxGF4DpF
        WDta1Uurs8JFy5WryFvF4Uu3WS93yrGr4jqr93G34jyF1Dtrn7try0yr15uFyrWrW8Gr1v
        qw42vF4furn8t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj4dr6AABs-
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-31 at 09:32 +0200, Roberto Sassu wrote:
> On Thu, 2023-03-30 at 18:55 -0400, Paul Moore wrote:
> > On Wed, Mar 29, 2023 at 9:05 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Change the evm_inode_init_security() definition to align with the LSM
> > > infrastructure. Keep the existing behavior of including in the HMAC
> > > calculation only the first xattr provided by LSMs.
> > > 
> > > Changing the evm_inode_init_security() definition requires passing the
> > > xattr array allocated by security_inode_init_security(), and the number of
> > > xattrs filled by previously invoked LSMs.
> > > 
> > > Use the newly introduced lsm_find_xattr_slot() to position EVM correctly in
> > > the xattrs array, like a regular LSM, and to increment the number of filled
> > > slots. For now, the LSM infrastructure allocates enough xattrs slots to
> > > store the EVM xattr, without using the reservation mechanism.
> > > 
> > > Finally, make evm_inode_init_security() return value compatible with the
> > > inode_init_security hook conventions, i.e. return -EOPNOTSUPP if it is not
> > > setting an xattr.
> > > 
> > > EVM is a bit tricky, because xattrs is both an input and an output. If it
> > > was just output, EVM should have returned zero if xattrs is NULL. But,
> > > since xattrs is also input, EVM is unable to do its calculations, so return
> > > -EOPNOTSUPP and handle this error in security_inode_init_security().
> > 
> > I don't quite understand why EVM would return EOPNOTSUPP if it is
> > enabled but there are not xattrs to measure.  It seems like EVM should
> > return success/0 in the no-xattr case; there were no xattrs to
> > measure, so it succeeded in measuring nothing.  Am I missing
> > something?
> 
> From a very quick look at what other LSMs do, it seems that they return
> zero even if they are not initialized.
> 
> So, it makes sense to return zero also here.

Oh, actually there was a reason to do that. If an LSM does not wish to
provide an xattr, it should return -EOPNOTSUPP.

As we are not checking this convention anymore, it is probably fine to
return zero. I already made the change, will send the new version
shortly.

Thanks

Roberto

> Thanks
> 
> Roberto
> 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/evm.h               | 14 ++++++++------
> > >  security/integrity/evm/evm_main.c | 18 +++++++++++-------
> > >  security/security.c               |  6 +++---
> > >  3 files changed, 22 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/include/linux/evm.h b/include/linux/evm.h
> > > index 7dc1ee74169..3c0e8591b69 100644
> > > --- a/include/linux/evm.h
> > > +++ b/include/linux/evm.h
> > > @@ -56,9 +56,10 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
> > >  {
> > >         return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
> > >  }
> > > -extern int evm_inode_init_security(struct inode *inode,
> > > -                                  const struct xattr *xattr_array,
> > > -                                  struct xattr *evm);
> > > +extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > > +                                  const struct qstr *qstr,
> > > +                                  struct xattr *xattrs,
> > > +                                  int *num_filled_xattrs);
> > >  extern bool evm_revalidate_status(const char *xattr_name);
> > >  extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
> > >  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
> > > @@ -157,9 +158,10 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
> > >         return;
> > >  }
> > > 
> > > -static inline int evm_inode_init_security(struct inode *inode,
> > > -                                         const struct xattr *xattr_array,
> > > -                                         struct xattr *evm)
> > > +static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > > +                                         const struct qstr *qstr,
> > > +                                         struct xattr *xattrs,
> > > +                                         int *num_filled_xattrs)
> > >  {
> > >         return 0;
> > >  }
> > > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > > index cf24c525558..9e75759150c 100644
> > > --- a/security/integrity/evm/evm_main.c
> > > +++ b/security/integrity/evm/evm_main.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/evm.h>
> > >  #include <linux/magic.h>
> > >  #include <linux/posix_acl_xattr.h>
> > > +#include <linux/lsm_hooks.h>
> > > 
> > >  #include <crypto/hash.h>
> > >  #include <crypto/hash_info.h>
> > > @@ -864,23 +865,26 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
> > >  /*
> > >   * evm_inode_init_security - initializes security.evm HMAC value
> > >   */
> > > -int evm_inode_init_security(struct inode *inode,
> > > -                                const struct xattr *lsm_xattr,
> > > -                                struct xattr *evm_xattr)
> > > +int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > > +                           const struct qstr *qstr, struct xattr *xattrs,
> > > +                           int *num_filled_xattrs)
> > >  {
> > >         struct evm_xattr *xattr_data;
> > > +       struct xattr *evm_xattr;
> > >         int rc;
> > > 
> > > -       if (!(evm_initialized & EVM_INIT_HMAC) ||
> > > -           !evm_protected_xattr(lsm_xattr->name))
> > > -               return 0;
> > > +       if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs ||
> > > +           !evm_protected_xattr(xattrs->name))
> > > +               return -EOPNOTSUPP;
> > > +
> > > +       evm_xattr = lsm_find_xattr_slot(xattrs, num_filled_xattrs);
> > > 
> > >         xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> > >         if (!xattr_data)
> > >                 return -ENOMEM;
> > > 
> > >         xattr_data->data.type = EVM_XATTR_HMAC;
> > > -       rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> > > +       rc = evm_init_hmac(inode, xattrs, xattr_data->digest);
> > >         if (rc < 0)
> > >                 goto out;
> > > 
> > > diff --git a/security/security.c b/security/security.c
> > > index be33d643a81..22ab4fb7ebf 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1674,9 +1674,9 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> > >         if (!num_filled_xattrs)
> > >                 goto out;
> > > 
> > > -       ret = evm_inode_init_security(inode, new_xattrs,
> > > -                                     new_xattrs + num_filled_xattrs);
> > > -       if (ret)
> > > +       ret = evm_inode_init_security(inode, dir, qstr, new_xattrs,
> > > +                                     &num_filled_xattrs);
> > > +       if (ret && ret != -EOPNOTSUPP)
> > >                 goto out;
> > >         ret = initxattrs(inode, new_xattrs, fs_data);
> > >  out:
> > > --
> > > 2.25.1
> > > 

