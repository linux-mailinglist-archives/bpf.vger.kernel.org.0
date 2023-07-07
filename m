Return-Path: <bpf+bounces-4452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E159774B575
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF7C1C2102D
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EA81119C;
	Fri,  7 Jul 2023 16:54:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E4D511
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:54:37 +0000 (UTC)
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE82736
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688748848; bh=7dUG/tEyuCsnWvgTF+ykPusSsDtzDF4QTHRG8+l4fWM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=k33JwQsSTksi1u+D4jg0dnnvzQuJoiIQuMELZK73bYM19E5jrrEVHxkKBATJ3CIQy4agP2hErjjpbFK76q7HdCYIMzMFXwxR7fAl1kg39dx1afZXa8eKMkvl9J4gBbWgVUT9ovyjCxIIgtauM7BidhyVu39YfW4acPysfAEXVYvuZl7B3sCiA131t6GRwKBU0juqrfNQMbtFlzBuWxz/ZEvEaCXXZ9tBx8wxwd4WHAQqDikU1cyFjooBiQyDkM3iMsb9y4e8QOgU6U25gxxleIijzzeJbZiiOKHYfAQxY/f70pXWSBHRz3+yS1xQrsrB+5ZRALrb4aTXkI2a4cwxWw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688748848; bh=tx9k0TN1T8vin8wdHwO2nG4qX/v/r09tkKCH6Un2w5v=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=emeh3ncUq7JgNSue0N0j/Fgm2DlP2UHlUPyz3SHcLXk7/4WXmnygV/tkPu/tzU5Pdhk1HmJ3HhbQvuf3ujiGDlVD+MSsnbUanpaym0EOWXUuOF7lKHQPZNOEovV8mO3Ptziljka2f9Wa3cs3iITZTrxWwEBmFjqX7z1Pv83lss9PkL6FRrn6OPHVkgyUDIpGowNv3zInoCvxakXnwdq31asOYiQ4u+GsrLPNpjVl7FTpHSfqdgObppaIBzwISsVq7C8fiK9pHUJuR7DF1AKM6EJW7T1L38YCdEPKGq73+BF4nvP9IWUYhp+bKOQlMxOJRPoqEXJ9BSVNBFT0LOVvoA==
X-YMail-OSG: 3cMWPXEVM1ksAsW6ExbAWo3xHajlrtgcL1H_yMZEUdZajHEEbDWayzDJl9unhFx
 V2I46457HBKjxa8YP9y9f1u7E2dRKrSawhO23vd.M4HcGojwyiRn6BEPRWf97aLuC1mflAnCm6tM
 WlczvkiigYXMFAWN3M2lpUd3aqyPu8u1pdBLbQsbWZ_zgEO3JXhcbAoVt0hz4_tuLMXFJZwbS5dq
 Q3lCh_w3aoC4DEytKBscnH5l_D_U5GAQG.hmNekYBnKtlQZN5V0GxmLcvqFBnmMIOaFl1g9oDXGg
 nOrtwRP61KHzW2nnxz0PVeW1qfevQ76WEKtjmFLMz8qjipv7oAG25p0iv1yqrnF9lzwyWWT8ycbq
 zcmilJsaDYje5auB6zVrV4YZcmxW0bEkHhOvupWVMZwvzyZKIMxGfofOVldwWz4yoaC1Hn7u72YR
 JtTz_aWAB6OFYHfjz8Uho0tT5dN2lLbmlS7t8Djh0kcyEZi.IjLlIsVJAvUfGg.TWWZl_95AyaJZ
 ObS9vycfzaNh0yNu1S1GeUoBkFQ1ep.bQq.OJscU9mjajdkcKE4kM7ZeiaaGrgH6_93_I_RfFj1I
 pWZ1mwpcWl0k.00tbVj4LFpBqlXg9ebnsDrSo8isUeecWGnetLsbKhXJT2jI5Hw6XgnAWLqo6mSW
 TOeKXX5ev0XF23DHQCj6tfN9TqAbmrHOXyEqjicTRaCOhQTztTSv3lvVSIxHH1EV0I8R1Q0tNMgF
 N1GsjrBW6AY6ds5Kgz_gBzPq8mpz.G3QX_lYEUf5hz5vEpvJ3qSnrUpOas_3Ahnnr5s_CWxLWG9V
 INjKYK4zVW84Me_kGJGqTp1NHHd_8AMvFCm_SktAmH7MddZnt6J6.jW0g11rjp7DSw_CqHNVdxs.
 efsQ_I6gtbLE6KLDw1s86Ky8WWT8.I6qQQIoBNT1czh8JumJb_Q9ALfGk2cm4FD2x0FVmmMQXYOy
 1vptlrjZjD4A9KFEUDi.a2Sij2cUpwT3dDCvPevmhfwB55fYUXW9oBG9p6KLDXWQbpO._S4N25Mo
 Pa9dIiWCcSqhNZJlCRUFVCfK8ZNxJl.szRY6aYZfQmIOwmdorJQICm2KyjS0PRUxlfzXGHZZNMfO
 4_hNr0d1HaRuprP9dz5rdIs8SO8X4FuAOPFBgKX.AG_6ei9y675CSr1dnhjDUWPWjEzwOSR6E31n
 eHrQM3hqPVOcMl3ILksF3a9poPzgwHE76Kf44UBZMCUNbZZhX7fcLvudutA25XNmxIx4iU8WUwTV
 22mVXAZ3KFkOnNuBybve7TeQ82xSbgsC1qszhx4q2.3ygpDXhGRVeB4cuOC7omxDJJl472esmlLK
 6OWWOkksKlawCNnw2ZfdSxnzHLNr6fXZw5Fy3hKPBQHjiegdLrb3vOaQWNFfKxeztI1UOMFqAgb1
 QveMIRWGYJwnd19GzrCkm20G2QQgzCJ5weBGd7TtxJ.RMAl.9mOnnF8z9GmNkZ8M7.Ql4K1zHxCS
 5ILM49RYVmo9mEKRR9bQq5P.g3Hl2OjbCRKj0Rkoi23a0FsdA_enxgTUrwZAwg2VVClPLjU9lWw0
 eGwf9I9yecWmm.hnZ2Nhqc4Dxh7OisHW.GnBhxV7FbVuRDfqOU6G76wKBu9ElqHb62ZtaX0ati1F
 rwcGJbxMYgttxxvVOYa1Vf01GtMGZF4SDriwYiGdF2UiKU40GXZqHKHzKCkGXYd8vPEXp4b0twqk
 jj3TUHl6L.5zYYjjGo6b5UVUEMyyFbNSI.2t5XaRmq57Mo9N8mUbFxYZkMa4_eQvJ5isj4rDayPl
 W82bKlmpH_K3MXQVIlo6uKVnOrXkJDT1LHHLV75zNiSL_CoKoealpTCQRoX89LWDuemeKSKchEtD
 Z70z9z6TdKdFBCe7520rZCD_9pfY1EVwWzA28celp3YG.y0WmrysXXF9oXrzwU.M8i6LDKpuqT33
 .OzOUOLKgLmjD4RHP39pFa5uwWJYDLuGr_55ipZLcVUU9UJ1iE6rly3dbQDqyKVkxGgZ7QArEGQQ
 6g5LHA8dDXtRjG4z3B7vGht8zmpVxM_H3nJUCpo4VontlqyNDXnN9b5_WllLCj1Sa3T9CM1rOB2d
 AtkiisZnRZjay67spOW1b2wib6ERZECTBRS.MNbmxRsLcZQd4rh0BoKAU9Nqy7Lt13.mTIbdExOy
 M8BtBJofjnnuIv21rHyKUwqDktBEXsv9O6ZfaEVPdWLe2f2hwdVJO0MfV7G5g.QmYeUCUUjQjkCo
 E5WGcnNmqH9xhqf9z2RMo9YzdRv0R.ccKma_5yP3jm4fOO6u2Cx9zYXrQKXzZIojrsNOSJqa8NhA
 cN5yEA_XMQQ3W
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8a7232ca-1467-48de-b49b-55042b582814
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Jul 2023 16:54:08 +0000
Received: by hermes--production-bf1-5d96b4b9f-2ghnc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 74f4f2705c6e8c4c65d3815b934ef2a1;
          Fri, 07 Jul 2023 16:54:02 +0000 (UTC)
Message-ID: <a28c8fce-741b-e088-af5e-8a83daa7e25d@schaufler-ca.com>
Date: Fri, 7 Jul 2023 09:53:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
 stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
 nicolas.bouchinet@clip-os.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
 <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21638 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/6/2023 6:43 PM, Paul Moore wrote:
> On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>> Currently, the LSM infrastructure supports only one LSM providing an xattr
>> and EVM calculating the HMAC on that xattr, plus other inode metadata.
>>
>> Allow all LSMs to provide one or multiple xattrs, by extending the security
>> blob reservation mechanism. Introduce the new lbs_xattr_count field of the
>> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
>> needs, and the LSM infrastructure knows how many xattr slots it should
>> allocate.
>>
>> Modify the inode_init_security hook definition, by passing the full
>> xattr array allocated in security_inode_init_security(), and the current
>> number of xattr slots in that array filled by LSMs. The first parameter
>> would allow EVM to access and calculate the HMAC on xattrs supplied by
>> other LSMs, the second to not leave gaps in the xattr array, when an LSM
>> requested but did not provide xattrs (e.g. if it is not initialized).
>>
>> Introduce lsm_get_xattr_slot(), which LSMs can call as many times as the
>> number specified in the lbs_xattr_count field of the lsm_blob_sizes
>> structure. During each call, lsm_get_xattr_slot() increments the number of
>> filled xattrs, so that at the next invocation it returns the next xattr
>> slot to fill.
>>
>> Cleanup security_inode_init_security(). Unify the !initxattrs and
>> initxattrs case by simply not allocating the new_xattrs array in the
>> former. Update the documentation to reflect the changes, and fix the
>> description of the xattr name, as it is not allocated anymore.
>>
>> Adapt both SELinux and Smack to use the new definition of the
>> inode_init_security hook, and to call lsm_get_xattr_slot() to obtain and
>> fill the reserved slots in the xattr array.
>>
>> Move the xattr->name assignment after the xattr->value one, so that it is
>> done only in case of successful memory allocation.
>>
>> Finally, change the default return value of the inode_init_security hook
>> from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
>> conventions.
>>
>> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
>> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>  include/linux/lsm_hook_defs.h |  6 +--
>>  include/linux/lsm_hooks.h     | 20 ++++++++++
>>  security/security.c           | 71 +++++++++++++++++++++++------------
>>  security/selinux/hooks.c      | 17 +++++----
>>  security/smack/smack_lsm.c    | 25 ++++++------
>>  5 files changed, 92 insertions(+), 47 deletions(-)
> Two *very* small suggestions below, but I can make those during the
> merge if you are okay with that Roberto?
>
> I'm also going to assume that Casey is okay with the Smack portion of
> this patchset?  It looks fine to me, and considering his ACK on the
> other Smack patch in this patchset I'm assuming he is okay with this
> one as well ... ?

Yes, please feel free to add my Acked-by as needed.

>
>> diff --git a/security/security.c b/security/security.c
>> index ee4f1cc4902..d5ef7df1ce4 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1591,11 +1592,15 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
>>   * created inode and set up the incore security field for the new inode.  This
>>   * hook is called by the fs code as part of the inode creation transaction and
>>   * provides for atomic labeling of the inode, unlike the post_create/mkdir/...
>> - * hooks called by the VFS.  The hook function is expected to allocate the name
>> - * and value via kmalloc, with the caller being responsible for calling kfree
>> - * after using them.  If the security module does not use security attributes
>> - * or does not wish to put a security attribute on this particular inode, then
>> - * it should return -EOPNOTSUPP to skip this processing.
>> + * hooks called by the VFS.  The hook function is expected to populate the
>> + * @xattrs array, by calling lsm_get_xattr_slot() to retrieve the slots
> I think we want to change "@xattrs array" to just "xattrs array" as
> there is no function parameter named "xattrs" in the LSM/security_XXX
> hook itself, just in the 'inode_init_security' hook implementation.
>
> I might also break the new text describing the hook implementation
> into a new paragraph.
>
>> + * reserved by the security module with the lbs_xattr_count field of the
>> + * lsm_blob_sizes structure.  For each slot, the hook function should set ->name
>> + * to the attribute name suffix (e.g. selinux), to allocate ->value (will be
>> + * freed by the caller) and set it to the attribute value, to set ->value_len to
>> + * the length of the value.  If the security module does not use security
>> + * attributes or does not wish to put a security attribute on this particular
>> + * inode, then it should return -EOPNOTSUPP to skip this processing.
>>   *
>>   * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
>>   * needed, or -ENOMEM on memory allocation failure.
>> @@ -1604,33 +1609,51 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>>  				 const struct qstr *qstr,
>>  				 const initxattrs initxattrs, void *fs_data)
>>  {
>> -	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>> -	struct xattr *lsm_xattr, *evm_xattr, *xattr;
>> -	int ret;
>> +	struct security_hook_list *P;
> The above comments were nitpicky, this one is even more so ...
> convention within security/security.c is to call the
> security_hook_list pointer "hp", not "P" (although I recognize P is
> used in the macro).
>
>> +	struct xattr *new_xattrs = NULL;
>> +	int ret = -EOPNOTSUPP, xattr_count = 0;
> --
> paul-moore.com

