Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8814F6DEC7E
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDLHXV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLHXU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 03:23:20 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBEAFA;
        Wed, 12 Apr 2023 00:23:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PxDTV0DqHz9v7Vm;
        Wed, 12 Apr 2023 15:13:50 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA35z1CXDZkH5EWAg--.802S2;
        Wed, 12 Apr 2023 08:22:52 +0100 (CET)
Message-ID: <8e7705972a0f306922d8bc4893cf940e319abb19.camel@huaweicloud.com>
Subject: Re: [PATCH] Smack modifications for: security: Allow all LSMs to
 provide xattrs for inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 12 Apr 2023 09:22:38 +0200
In-Reply-To: <2dc6486f-ce9b-f171-14fe-48a90386e1b7@schaufler-ca.com>
References: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
         <20230411172337.340518-1-roberto.sassu@huaweicloud.com>
         <2dc6486f-ce9b-f171-14fe-48a90386e1b7@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwA35z1CXDZkH5EWAg--.802S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw48uFyfZF1fJrWkuF4kWFg_yoW7Xry3pF
        WUK3W3KF4FyF9rGryFya1UW34a9a1fGr4UGwn3Xrsav3ZrJr1xKrykXr1YkFy7XrykZr1F
        vr4jqr9xWFn0y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4fg6gABs+
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-04-11 at 10:54 -0700, Casey Schaufler wrote:
> On 4/11/2023 10:23 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Very very quick modification. Not tested.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/smack/smack.h     |  2 +-
> >  security/smack/smack_lsm.c | 42 ++++++++++++++++++++------------------
> >  2 files changed, 23 insertions(+), 21 deletions(-)
> > 
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index e2239be7bd6..f00c8498c60 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -127,7 +127,7 @@ struct task_smack {
> >  
> >  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
> >  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
> > -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
> > +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
> 
> See below ...
> 
> >  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
> >  
> >  /*
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 8392983334b..b43820bdbd0 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -54,12 +54,12 @@
> >  
> >  /*
> >   * Smack uses multiple xattrs.
> > - * SMACK64 - for access control, SMACK64EXEC - label for the program,
> > - * SMACK64MMAP - controls library loading,
> > + * SMACK64 - for access control,
> >   * SMACK64TRANSMUTE - label initialization,
> > - * Not saved on files - SMACK64IPIN and SMACK64IPOUT
> > + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
> > + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
> >   */
> > -#define SMACK_INODE_INIT_XATTRS 4
> > +#define SMACK_INODE_INIT_XATTRS 2
> >  
> >  #ifdef SMACK_IPV6_PORT_LABELING
> >  static DEFINE_MUTEX(smack_ipv6_lock);
> > @@ -957,11 +957,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> >  				     const struct qstr *qstr,
> >  				     struct xattr *xattrs, int *xattr_count)
> >  {
> > -	struct inode_smack *issp = smack_inode(inode);
> >  	struct smack_known *skp = smk_of_current();
> >  	struct smack_known *isp = smk_of_inode(inode);
> >  	struct smack_known *dsp = smk_of_inode(dir);
> >  	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
> > +	struct xattr *xattr2;
> 
> I'm going to channel Paul and suggest this be xattr_transmute instead of xattr2.
> It also looks like it could move to be declared in the if clause.
> 
> >  	int may;
> >  
> >  	if (xattr) {
> > @@ -979,7 +979,17 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> >  		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
> >  		    smk_inode_transmutable(dir)) {
> >  			isp = dsp;
> > -			issp->smk_flags |= SMK_INODE_CHANGED;
> 
> I think you need to keep this. More below.
> 
> > +			xattr2 = lsm_get_xattr_slot(xattrs, xattr_count);
> > +			if (xattr2) {
> > +				xattr2->value = kmemdup(TRANS_TRUE,
> > +							TRANS_TRUE_SIZE,
> > +							GFP_NOFS);
> > +				if (xattr2->value == NULL)
> > +					return -ENOMEM;
> > +
> > +				xattr2->value_len = TRANS_TRUE_SIZE;
> > +				xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
> > +			}
> >  		}
> >  
> >  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> > @@ -3512,20 +3522,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
> >  			 * If there is a transmute attribute on the
> >  			 * directory mark the inode.
> >  			 */
> > -			if (isp->smk_flags & SMK_INODE_CHANGED) {
> > -				isp->smk_flags &= ~SMK_INODE_CHANGED;
> > -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
> > -					XATTR_NAME_SMACKTRANSMUTE,
> > -					TRANS_TRUE, TRANS_TRUE_SIZE,
> > -					0);
> > -			} else {
> > -				rc = __vfs_getxattr(dp, inode,
> > -					XATTR_NAME_SMACKTRANSMUTE, trattr,
> > -					TRANS_TRUE_SIZE);
> > -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> > -						       TRANS_TRUE_SIZE) != 0)
> > -					rc = -EINVAL;
> > -			}
> > +			rc = __vfs_getxattr(dp, inode,
> > +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
> > +					    TRANS_TRUE_SIZE);
> > +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> > +					       TRANS_TRUE_SIZE) != 0)
> > +				rc = -EINVAL;
> 
> Where is the SMACK64_TRANSMUTE attribute going to get set on the file?
> It's not going to get set in smack_init_inode_security(). The inode will

Isn't that the purpose of the inode_init_security hook?

After all LSMs provide one or multiple xattrs, xattrs are going to be
written to the disk with the initxattr() callback of filesystems.

There is a small mistake above (XATTR_SMACK_TRANSMUTE instead
of XATTR_NAME_SMACKTRANSMUTE, as we are providing just the suffix).

After fixing that, Smack tests succeed:

95 Passed, 0 Failed, 100% Success rate

There was a test failing in dir-transmute.sh, before I fixed the xattr
name.

Thanks

Roberto

> know it's transmuting, but it won't get to disk without the __vfs_setxattr()
> here in smack_d_instantiate(). Now, it's been a long time since that code
> was written, so I could be wrong, but I'm pretty sure about that.
> 
> I think that you should be fine with the changes in smack_init_inode_security(),
> and leaving smack_d_instantiate() untouched. 
> 
> >  			if (rc >= 0)
> >  				transflag = SMK_INODE_TRANSMUTE;
> >  		}

