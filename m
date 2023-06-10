Return-Path: <bpf+bounces-2310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D2372A9B7
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 09:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5899D1C20D1F
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D979C6;
	Sat, 10 Jun 2023 07:10:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654DC1878
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 07:10:35 +0000 (UTC)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C33A9B;
	Sat, 10 Jun 2023 00:10:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QdTLc3Hx7z9xFrh;
	Sat, 10 Jun 2023 14:58:32 +0800 (CST)
Received: from [10.81.219.229] (unknown [10.81.219.229])
	by APP2 (Coremail) with SMTP id GxC2BwCXPjXBIYRk43ofAw--.4331S2;
	Sat, 10 Jun 2023 08:10:05 +0100 (CET)
Message-ID: <809521fb-044b-fb5d-d7a5-654e633d41aa@huaweicloud.com>
Date: Sat, 10 Jun 2023 09:09:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 2/4] smack: Set the SMACK64TRANSMUTE xattr in
 smack_inode_init_security()
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
 nicolas.bouchinet@clip-os.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
 <20230603191518.1397490-3-roberto.sassu@huaweicloud.com>
 <5f8d8e67a7803ede8847d30ffe3204723b4ac7a7.camel@linux.ibm.com>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <5f8d8e67a7803ede8847d30ffe3204723b4ac7a7.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCXPjXBIYRk43ofAw--.4331S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw43ZrW3Xr1rAw4xCF47CFg_yoW7ZFWrpF
	WUt3W3KFs5tFnrGrWSyF45W34S9a1rKr4UWr9xWrZav3ZrJw1xKFWvqr1Y9F17Xrykuw1F
	qF4jqry3XFn0y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWwZcUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj45+QAAAsA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/9/2023 9:35 PM, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Sat, 2023-06-03 at 21:15 +0200, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> With the newly added ability of LSMs to supply multiple xattrs, set
>> SMACK64TRASMUTE in smack_inode_init_security(), instead of d_instantiate().
>> Do it by incrementing SMACK_INODE_INIT_XATTRS to 2 and by calling
>> lsm_get_xattr_slot() a second time, if the transmuting conditions are met.
>>
>> The LSM infrastructure passes all xattrs provided by LSMs to the
>> filesystems through the initxattrs() callback, so that filesystems can
>> store xattrs in the disk.
>>
>> After the change, the SMK_INODE_TRANSMUTE inode flag is always set by
>> d_instantiate() after fetching SMACK64TRANSMUTE from the disk. Before it
>> was done by smack_inode_post_setxattr() as result of the __vfs_setxattr()
>> call.
>>
>> Removing __vfs_setxattr() also prevents invalidating the EVM HMAC, by
>> adding a new xattr without checking and updating the existing HMAC.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Just a few comments/nits inline.
> 
>> ---
>>   security/smack/smack.h     |  2 +-
>>   security/smack/smack_lsm.c | 43 +++++++++++++++++++++++---------------
>>   2 files changed, 27 insertions(+), 18 deletions(-)
>>
>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>> index aa15ff56ed6..041688e5a77 100644
>> --- a/security/smack/smack.h
>> +++ b/security/smack/smack.h
>> @@ -128,7 +128,7 @@ struct task_smack {
>>   
>>   #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
>>   #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
>> -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
>> +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
>>   #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
>>   
>>   /*
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index a1c30275692..b67d901ee74 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -52,7 +52,14 @@
>>   #define SMK_RECEIVING	1
>>   #define SMK_SENDING	2
>>   
>> -#define SMACK_INODE_INIT_XATTRS 1
>> +/*
>> + * Smack uses multiple xattrs.
>> + * SMACK64 - for access control,
>> + * SMACK64TRANSMUTE - label initialization,
>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
>> + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
>> + */
>> +#define SMACK_INODE_INIT_XATTRS 2
>>   
>>   #ifdef SMACK_IPV6_PORT_LABELING
>>   static DEFINE_MUTEX(smack_ipv6_lock);
>> @@ -935,7 +942,6 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>   				     struct xattr *xattrs, int *xattr_count)
>>   {
>>   	struct task_smack *tsp = smack_cred(current_cred());
>> -	struct inode_smack *issp = smack_inode(inode);
>>   	struct smack_known *skp = smk_of_task(tsp);
>>   	struct smack_known *isp = smk_of_inode(inode);
>>   	struct smack_known *dsp = smk_of_inode(dir);
>> @@ -963,6 +969,8 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>   		if ((tsp->smk_task == tsp->smk_transmuted) ||
>>   		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>>   		     smk_inode_transmutable(dir))) {
>> +			struct xattr *xattr_transmute;
>> +
> 
> Variables should be defined at the beginning of the function.

Casey asked to declare the variable in this block.

> Is there a reason for beginning the function with "if (xattr) {"
> instead "if (!xattr) return 0;".  This causes unnecessary indenting.

I revisited this part and made few fixes:

https://lore.kernel.org/linux-security-module/20230607123612.2791303-1-roberto.sassu@huaweicloud.com/

Patch 3 should address your concern.

>>   			/*
>>   			 * The caller of smack_dentry_create_files_as()
>>   			 * should have overridden the current cred, so the
>> @@ -971,7 +979,16 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>   			 */
>>   			if (tsp->smk_task != tsp->smk_transmuted)
>>   				isp = dsp;
>> -			issp->smk_flags |= SMK_INODE_CHANGED;
>> +			xattr_transmute = lsm_get_xattr_slot(xattrs, xattr_count);
>> +			if (xattr_transmute) {
>> +				xattr_transmute->value = kmemdup(TRANS_TRUE,
>> +						TRANS_TRUE_SIZE, GFP_NOFS);
> 
> script/checkpatch --strict complains here.

Thanks, I didn't know about it.

It seems that they are more stylistic things. Probably, not worth to 
respin the patch set just for those (unless you prefer I do it).

Thanks

Roberto

>> +				if (xattr_transmute->value == NULL)
>> +					return -ENOMEM;
>> +
>> +				xattr_transmute->value_len = TRANS_TRUE_SIZE;
>> +				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
>> +			}
>>   		}
>>   
>>   		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
>> @@ -3518,20 +3535,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>>   			 * If there is a transmute attribute on the
>>   			 * directory mark the inode.
>>   			 */
>> -			if (isp->smk_flags & SMK_INODE_CHANGED) {
>> -				isp->smk_flags &= ~SMK_INODE_CHANGED;
>> -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
>> -					XATTR_NAME_SMACKTRANSMUTE,
>> -					TRANS_TRUE, TRANS_TRUE_SIZE,
>> -					0);
>> -			} else {
>> -				rc = __vfs_getxattr(dp, inode,
>> -					XATTR_NAME_SMACKTRANSMUTE, trattr,
>> -					TRANS_TRUE_SIZE);
>> -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>> -						       TRANS_TRUE_SIZE) != 0)
>> -					rc = -EINVAL;
>> -			}
>> +			rc = __vfs_getxattr(dp, inode,
>> +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
>> +					    TRANS_TRUE_SIZE);
>> +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>> +					       TRANS_TRUE_SIZE) != 0)
>> +				rc = -EINVAL;
>>   			if (rc >= 0)
>>   				transflag = SMK_INODE_TRANSMUTE;
>>   		}
> 
> 


