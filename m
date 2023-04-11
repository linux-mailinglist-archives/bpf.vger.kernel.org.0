Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646746DD4B1
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 09:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjDKH6L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 03:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDKH6K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 03:58:10 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AD2709;
        Tue, 11 Apr 2023 00:58:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PwdJD4yVWz9xFGL;
        Tue, 11 Apr 2023 15:48:44 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCnJgLuEjVkOuQUAg--.727S2;
        Tue, 11 Apr 2023 08:57:44 +0100 (CET)
Message-ID: <0d73e16cb3697ed7ba227bc530883dfafa74b1aa.camel@huaweicloud.com>
Subject: Re: [PATCH v10 3/4] evm: Align evm_inode_init_security() definition
 with LSM infrastructure
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 11 Apr 2023 09:58:59 +0200
In-Reply-To: <404a022216d33063ff8f8b4f0d31d9d38a2da4d4.camel@linux.ibm.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
         <20230331123221.3273328-4-roberto.sassu@huaweicloud.com>
         <404a022216d33063ff8f8b4f0d31d9d38a2da4d4.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCnJgLuEjVkOuQUAg--.727S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4DuryUXr4ftr4UGw1rZwb_yoW7Xw15pF
        WDta1UCrn5JFyUWr9YyF47u3WSg3yrGr4UtrZ3GryjyFnrtrn7tryFyr15uryrXrW8Gr1v
        qa12vrn3urn0y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUo0eHDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4fT8wAAsU
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-04-11 at 03:22 -0400, Mimi Zohar wrote:
> On Fri, 2023-03-31 at 14:32 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Change the evm_inode_init_security() definition to align with the LSM
> > infrastructure. Keep the existing behavior of including in the HMAC
> > calculation only the first xattr provided by LSMs.
> > 
> > Changing the evm_inode_init_security() definition requires passing the
> > xattr array allocated by security_inode_init_security(), and the number of
> > xattrs filled by previously invoked LSMs.
> > 
> > Use the newly introduced lsm_get_xattr_slot() to position EVM correctly in
> > the xattrs array, like a regular LSM, and to increment the number of filled
> > slots. For now, the LSM infrastructure allocates enough xattrs slots to
> > store the EVM xattr, without using the reservation mechanism.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/evm.h               | 13 +++++++------
> >  security/integrity/evm/evm_main.c | 16 ++++++++++------
> >  security/security.c               |  6 +++---
> >  3 files changed, 20 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/evm.h b/include/linux/evm.h
> > index 7dc1ee74169..597632c71c7 100644
> > --- a/include/linux/evm.h
> > +++ b/include/linux/evm.h
> > @@ -56,9 +56,9 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
> >  {
> >  	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
> >  }
> > -extern int evm_inode_init_security(struct inode *inode,
> > -				   const struct xattr *xattr_array,
> > -				   struct xattr *evm);
> > +extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > +				   const struct qstr *qstr,
> > +				   struct xattr *xattrs, int *xattr_count);
> >  extern bool evm_revalidate_status(const char *xattr_name);
> >  extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
> >  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
> > @@ -157,9 +157,10 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
> >  	return;
> >  }
> >  
> > -static inline int evm_inode_init_security(struct inode *inode,
> > -					  const struct xattr *xattr_array,
> > -					  struct xattr *evm)
> > +static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > +					  const struct qstr *qstr,
> > +					  struct xattr *xattrs,
> > +					  int *xattr_count)
> >  {
> >  	return 0;
> >  }
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index cf24c525558..475196ce712 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/evm.h>
> >  #include <linux/magic.h>
> >  #include <linux/posix_acl_xattr.h>
> > +#include <linux/lsm_hooks.h>
> >  
> >  #include <crypto/hash.h>
> >  #include <crypto/hash_info.h>
> > @@ -864,23 +865,26 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
> >  /*
> >   * evm_inode_init_security - initializes security.evm HMAC value
> >   */
> > -int evm_inode_init_security(struct inode *inode,
> > -				 const struct xattr *lsm_xattr,
> > -				 struct xattr *evm_xattr)
> > +int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > +			    const struct qstr *qstr, struct xattr *xattrs,
> > +			    int *xattr_count)
> >  {
> >  	struct evm_xattr *xattr_data;
> > +	struct xattr *evm_xattr;
> >  	int rc;
> >  
> > -	if (!(evm_initialized & EVM_INIT_HMAC) ||
> > -	    !evm_protected_xattr(lsm_xattr->name))
> > +	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs ||
> > +	    !evm_protected_xattr(xattrs->name))
> >  		return 0;
> >  
> > +	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
> > +
> >  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> >  	if (!xattr_data)
> >  		return -ENOMEM;
> >  
> >  	xattr_data->data.type = EVM_XATTR_HMAC;
> > -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> > +	rc = evm_init_hmac(inode, xattrs, xattr_data->digest);
> >  	if (rc < 0)
> >  		goto out;
> >  
> > diff --git a/security/security.c b/security/security.c
> > index 1aeaa8ce449..ef7779ec8b2 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1645,9 +1645,9 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> >  	if (!xattr_count)
> >  		goto out;
> >  
> > -	ret = evm_inode_init_security(inode, new_xattrs,
> > -				      new_xattrs + xattr_count);
> > -	if (ret)
> > +	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs,
> > +				      &xattr_count);
> > +	if (ret && ret != -EOPNOTSUPP)
> 
> As previously discussed, -EOPNOTSUPP originally meant that the
> filesystem itself did not support writing xattrs.  So there was no
> point in trying to write the EVM security xattr.   With the change in
> -EOPNOTSUPP meaning, it will now try to write the EVM security xattr. 
> Instead of glossing over the change in behavior, it needs to at least
> be mentioned in the patch description.

Oh, my mistake. I forgot to update this part (evm_inode_init_security()
now returns zero instead of -EOPNOTSUPP).

Thanks

Roberto

> >  		goto out;
> >  	ret = initxattrs(inode, new_xattrs, fs_data);
> >  out:

