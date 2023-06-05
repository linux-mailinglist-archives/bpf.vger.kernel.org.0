Return-Path: <bpf+bounces-1800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81DF722131
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 10:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73275281248
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 08:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB2525F;
	Mon,  5 Jun 2023 08:39:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4D196
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 08:39:20 +0000 (UTC)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CCFB0;
	Mon,  5 Jun 2023 01:39:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QZRYV6S2zz9xtV7;
	Mon,  5 Jun 2023 16:27:26 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAH110In31k6doIAw--.3833S2;
	Mon, 05 Jun 2023 09:38:47 +0100 (CET)
Message-ID: <9f4b7bef5d090da9de50ed1aa1e103abc19b125f.camel@huaweicloud.com>
Subject: Re: [PATCH v11 2/4] smack: Set the SMACK64TRANSMUTE xattr in
 smack_inode_init_security()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mengchi Cheng <mengcc@amazon.com>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org, kamatam@amazon.com, 
 yoonjaeh@amazon.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
 stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com,  linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org,  bpf@vger.kernel.org, kpsingh@kernel.org,
 keescook@chromium.org,  nicolas.bouchinet@clip-os.org, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Mon, 05 Jun 2023 10:38:29 +0200
In-Reply-To: <20230603191518.1397490-3-roberto.sassu@huaweicloud.com>
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
	 <20230603191518.1397490-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAH110In31k6doIAw--.3833S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw43ZrykCFyrJrWfWr1kAFb_yoW7Xr4rpF
	WUKa43Kr4rtF1DGrWFyF4UW3ya9ayrGrWUW3sxWrWfZ3ZrXr1xKrykXr1YkF17XrykurnY
	qF4jvry5Xrn0y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4o2BAAAsc
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-06-03 at 21:15 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> With the newly added ability of LSMs to supply multiple xattrs, set
> SMACK64TRASMUTE in smack_inode_init_security(), instead of d_instantiate().
> Do it by incrementing SMACK_INODE_INIT_XATTRS to 2 and by calling
> lsm_get_xattr_slot() a second time, if the transmuting conditions are met.
> 
> The LSM infrastructure passes all xattrs provided by LSMs to the
> filesystems through the initxattrs() callback, so that filesystems can
> store xattrs in the disk.
> 
> After the change, the SMK_INODE_TRANSMUTE inode flag is always set by
> d_instantiate() after fetching SMACK64TRANSMUTE from the disk. Before it
> was done by smack_inode_post_setxattr() as result of the __vfs_setxattr()
> call.
> 
> Removing __vfs_setxattr() also prevents invalidating the EVM HMAC, by
> adding a new xattr without checking and updating the existing HMAC.

Hi Mengchi

could you please redo your tests with this patch set applied?

https://lore.kernel.org/linux-integrity/20230603191518.1397490-1-roberto.sassu@huaweicloud.com/

You need:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/log/?h=next

https://github.com/cschaufler/smack-next/commits/next

Thanks

Roberto

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/smack/smack.h     |  2 +-
>  security/smack/smack_lsm.c | 43 +++++++++++++++++++++++---------------
>  2 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index aa15ff56ed6..041688e5a77 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -128,7 +128,7 @@ struct task_smack {
>  
>  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
>  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
> -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
> +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
>  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
>  
>  /*
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a1c30275692..b67d901ee74 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -52,7 +52,14 @@
>  #define SMK_RECEIVING	1
>  #define SMK_SENDING	2
>  
> -#define SMACK_INODE_INIT_XATTRS 1
> +/*
> + * Smack uses multiple xattrs.
> + * SMACK64 - for access control,
> + * SMACK64TRANSMUTE - label initialization,
> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
> + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
> + */
> +#define SMACK_INODE_INIT_XATTRS 2
>  
>  #ifdef SMACK_IPV6_PORT_LABELING
>  static DEFINE_MUTEX(smack_ipv6_lock);
> @@ -935,7 +942,6 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  				     struct xattr *xattrs, int *xattr_count)
>  {
>  	struct task_smack *tsp = smack_cred(current_cred());
> -	struct inode_smack *issp = smack_inode(inode);
>  	struct smack_known *skp = smk_of_task(tsp);
>  	struct smack_known *isp = smk_of_inode(inode);
>  	struct smack_known *dsp = smk_of_inode(dir);
> @@ -963,6 +969,8 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  		if ((tsp->smk_task == tsp->smk_transmuted) ||
>  		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>  		     smk_inode_transmutable(dir))) {
> +			struct xattr *xattr_transmute;
> +
>  			/*
>  			 * The caller of smack_dentry_create_files_as()
>  			 * should have overridden the current cred, so the
> @@ -971,7 +979,16 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  			 */
>  			if (tsp->smk_task != tsp->smk_transmuted)
>  				isp = dsp;
> -			issp->smk_flags |= SMK_INODE_CHANGED;
> +			xattr_transmute = lsm_get_xattr_slot(xattrs, xattr_count);
> +			if (xattr_transmute) {
> +				xattr_transmute->value = kmemdup(TRANS_TRUE,
> +						TRANS_TRUE_SIZE, GFP_NOFS);
> +				if (xattr_transmute->value == NULL)
> +					return -ENOMEM;
> +
> +				xattr_transmute->value_len = TRANS_TRUE_SIZE;
> +				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
> +			}
>  		}
>  
>  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> @@ -3518,20 +3535,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  			 * If there is a transmute attribute on the
>  			 * directory mark the inode.
>  			 */
> -			if (isp->smk_flags & SMK_INODE_CHANGED) {
> -				isp->smk_flags &= ~SMK_INODE_CHANGED;
> -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
> -					XATTR_NAME_SMACKTRANSMUTE,
> -					TRANS_TRUE, TRANS_TRUE_SIZE,
> -					0);
> -			} else {
> -				rc = __vfs_getxattr(dp, inode,
> -					XATTR_NAME_SMACKTRANSMUTE, trattr,
> -					TRANS_TRUE_SIZE);
> -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> -						       TRANS_TRUE_SIZE) != 0)
> -					rc = -EINVAL;
> -			}
> +			rc = __vfs_getxattr(dp, inode,
> +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
> +					    TRANS_TRUE_SIZE);
> +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> +					       TRANS_TRUE_SIZE) != 0)
> +				rc = -EINVAL;
>  			if (rc >= 0)
>  				transflag = SMK_INODE_TRANSMUTE;
>  		}


