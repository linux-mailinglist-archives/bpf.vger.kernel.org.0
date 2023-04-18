Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B686E68D9
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 18:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjDRQC3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 12:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjDRQCX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 12:02:23 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB97C678
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681833738; bh=gyYP0XE0KFif+H5tr3Gvrza9gmrQu7ufy2A6G+vxQJc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=j8TZNbyzmmwqIr3Xv9e3GUHzCLJ/118tqQ5FyB1duzwCO7dgolLmLdw1WZnVOJWgTt9up3h7unsBsYBfIsj5N+cA9akmfJDpROGQfiUCqX71wT+Ue/VQ4+8JjcJIZcMGYJHSGcaWlECfFk+2FwMVdhuipyLuNwf4SHazj3Smma5UEe2wIzIsIVZ74GSL/7E5triaSkJMBiPsfa7cIBHuCwL2bZLcAomurt9m/nrRcm+/nBGqmHlPlYa5WhiYcLltoLerxtCdErCqzBePEO730jHtMADdyDYqIhw7MsJyH2H7zSsrxVh3eQ0UUbpNdSiM4zAfyEOSludgteFeQTBP6Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681833738; bh=8HdeFcOkbtXdaiT9EczCNygFCuvg9BNICEDFbRTfu7H=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OG44gtJUd92DX4CWdmdcRnxw/RPtcxDrLaNqSDPILDsR4qPhl2Ym3B2F27e0rh0xk7ZTl/P4jbkI6P+QuW+F1B/2Ct94lEJP1Ccpdfqy3n8L76qiKsfdkQbMzaO2b6SABbMaFaFQ1OU4oxQ2vDLyjXguG9p3muaMMGYvjHhkfVvYsVarBot8pbvQDXnUCzPM25GMUUbMWsUCT+K+dGE6/nw/JSsg1AOV50HnHihl0cZzl3yfOS6iYTUOPtmxM72hnWrMLN3V1N9Py0CBQAo4POKiuY19N7JAzlp8JHO/6guZggWfL5zZ7d8y9+CI7b2SsBHB0xNBQnjDhcTfGAs8ng==
X-YMail-OSG: LiPAftoVM1lwKgjIE5v6h.2hhzf6in_njnJwVWQ1ZggiZA0IcxbHZiODDaP_iqL
 4YuUSNFU3M4XxPBciCxNuYZeqsA3f1M24BzERa.6lAIRkC821edX3HDCrK3TvN.Gpht9pT8wv6Yf
 TqKIgjT3MEsatRJWk3SF3KyQKuBh39lhoBE9kQ8sD0rHAabYaE0sALIClw_pMxFBwbRV0..eqOGX
 GVC4vfHKDWqm9pq3XVFQ9qopdBopRUCpRJpeLabi_v_.gZPeY0Ksct4WZM6mWoEhRpFKBBpGzuiH
 UMeVAQMos2v9fMxyt8uNN6ZFQ_2C1UUY.ppMym.O38fQ0xQyztYzJW3hU5X3imjZrTrDlKvcDw55
 jjvJ7lh_UUiVFK6.hssEy9GXinXW7tDeIzvn6ynO7cdF5AvwIxnxbD98K0LDgyiTM_RyWCW8T4Km
 mFVurI.d10OrxVKNJXqnScpZazt0sfhDyHMg5ySJrquwo7djItxSgvepVIb.Lz2uRUmEMHqv96KE
 p9QC.p5k5224C2QGvfM7c4e0tbDV9NZVFu81Sqr2WXguDUiFjX97xyJB1eR6bUrWvlQYdbfhV8FW
 RqcvhFAcF1t_KPQ0xraRGtEO1OhbkBuhpPbQDIoVEXbw2QLiZG6hqrykpgrt2S_Mfp280WRSHZPC
 uICdgPy6l_pjntlubJnzaDQ3eVVD1n1wRz1dDt5Mtpf8.o7ziahbCd.h2lL_LrxGKv27xV28nvcl
 mn4WzXi3vp9PZxcOhYa9ZUOIewgDk2cM98nr3fFJeGaGhddGh.WvTQh82ZNS.5Cp_ZAPkDA4E62e
 Q.WuZT67IMFSXVAxZFg.s_F9ud02Weh83.MlpAkUXSY7d9wkLn68hTRrdxS.NKGnMntSPgFYyWzA
 Y0m8VrhG6YN_NEibFfOUfobcwtaa67ytYPVVufDel55FoXrAGhyMATdyZiP.tpJfB62V4Ns._1QD
 77o_3oPglsQrfHiggM3wAihw0xe4BukH7Q3M4CExevc4lt1ZnAavstmJU2sjSAcIaRST7SIwDTXE
 650AbhYGQDnnaLC2C3sVKEUzzL1tVyXY9tSqrrZyOlWESaEwYG57ArYVtZAD7E7b_hTSuJrhmUFB
 DqpqDRgWi1qdk4VWiPYCEWEJbQdnbWaUGkMXPSG7Wsb0rIMPjDsbJH9_fBeoDDOP_NYTEkU81Qq2
 26TY7rOzc2mFPgxtkCsM4.Fv5FWSSA2BIyyDAebFjo1Sk9Cw2mMfmM.JbJrKIURBeBmFVDXCzJ9v
 KdgcFPMk8bHePVgxfg0vboXs5G45FQjyan2eUd.1Dl1bNoLFqPwt7C9cqGv8bfXoN2PRaY7H_UHZ
 502sZYMNP00sOB1vEEwJaPGy1fqkSjL9ICOQ3xudOh.dodnJGDNDZ7lYl5ik.ysmbJTvSe8i391U
 .Jbc0NYoPKcLqJm43jsC.9vzGlUoUzkCBEkPtGOa2ydNYdlctaVmhNcy1EJhUY5xxz3UCAHEFlY.
 I57n0C.lYz7wwk1FUTpktlGxkc4U5VFdiyIEFLwfT5ROwLGq_NRXjZbxv8F_6mD_tqROVBLaQhd8
 .BbFwO6DEGr1f2T9K5Q0N6MufDXMMLIm8JrU.amuc5v6te.r3Fl8BaMwI5CdjJXyFq5tTe1gAZlI
 rSbCADuysmBrQ3H_g14WzZxrLm.SfaA2JLaC2WhrDNm3x7WIJKNl2QXmgjP5fBzsSUe45hn3_vdC
 Xw0Lv51UMcjLM_dasOXn1_q7K2IrMs45DD2uCVH_d5vjsPyrrT7_AiBNWdzK5RfoMBssdjHTzsLz
 fvtogFx6S8ZrGYkVgJSl.ATZ8uZBonHTrphqEqcKg.BFxQDEjPZhHAhHukEd6AJYD2je3EIg70yX
 H8Zt3tGpKq4B2iDR.PAXRGMA.662lR_jrCo2jyY3T5Pam1P3UA06QKVbDFeQNvIbmdGts5meZBeU
 RTNfkOacBLi_8eFnOM8cS6TfMUVsvg_Lb0PexHOhRuk8hIswIG2oWbqZOoK64XlxYLCrdEU61ezt
 VrccqIbSKzsnm2IZf23XwMRMPtI0R9QP6bU5g7gFobH17xcaf.5yQc_U6U1HRoeuzbsvw2zYCpFg
 0CTCg_fZehSAfyB0AyZUPgRPupWqtvBtpy4mQM_OtsvQ9C7uyXN.6TXAWtwvuiINqA76X7lTy8dA
 AyyOwUkz4_tR00akCffUD2.o2bUhSvmJBhwOzZXFJsZL9cslfFAxQw0r6VPESRf6NM4wqMxNGzaT
 YYGhXkBzhMfSmEoec46.cPZseClSDQH2l1eLdXARh7jaPXm_Yyq.zZi9lUJObp15rLh.pqNzzfIG
 D62ZMLgJOFcZexQCrtpo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5ae514e7-f6f5-4d02-8db5-03d2182c05d6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Apr 2023 16:02:18 +0000
Received: by hermes--production-bf1-5f9df5c5c4-lwjq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b330da93699903cefde61594b2a9de8b;
          Tue, 18 Apr 2023 16:02:17 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------f9iv2DS0EpZb0jMgMv08kvbp"
Message-ID: <48c6073f-59b0-f5d1-532e-fe4b912b939d@schaufler-ca.com>
Date:   Tue, 18 Apr 2023 09:02:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Smack modifications for: security: Allow all LSMs to
 provide xattrs for inode_init_security hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
 <20230411172337.340518-1-roberto.sassu@huaweicloud.com>
 <2dc6486f-ce9b-f171-14fe-48a90386e1b7@schaufler-ca.com>
 <8e7705972a0f306922d8bc4893cf940e319abb19.camel@huaweicloud.com>
 <72b46d0f-75c7-ac18-4984-2bf1d6dad352@schaufler-ca.com>
 <82ee6ddf66bb34470aa7b591df4d70783fdb2422.camel@huaweicloud.com>
 <91f05dc4-a4b7-b40a-ba1a-0ccc489c84b2@schaufler-ca.com>
 <5c50d98f1e5745c88270ae4ad3de6d9a803db4c6.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <5c50d98f1e5745c88270ae4ad3de6d9a803db4c6.camel@huaweicloud.com>
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a multi-part message in MIME format.
--------------f9iv2DS0EpZb0jMgMv08kvbp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/2023 12:05 AM, Roberto Sassu wrote:
> On Mon, 2023-04-17 at 09:41 -0700, Casey Schaufler wrote:
>> On 4/13/2023 12:11 AM, Roberto Sassu wrote:
>>> On Wed, 2023-04-12 at 13:29 -0700, Casey Schaufler wrote:
>>>> On 4/12/2023 12:22 AM, Roberto Sassu wrote:
>>>>> On Tue, 2023-04-11 at 10:54 -0700, Casey Schaufler wrote:
>>>>>> On 4/11/2023 10:23 AM, Roberto Sassu wrote:
>>>>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>>>
>>>>>>> Very very quick modification. Not tested.
>>>>>>>
>>>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>>> ---
>>>>>>>  security/smack/smack.h     |  2 +-
>>>>>>>  security/smack/smack_lsm.c | 42 ++++++++++++++++++++------------------
>>>>>>>  2 files changed, 23 insertions(+), 21 deletions(-)
>>>>>>>
>>>>>>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>>>>>>> index e2239be7bd6..f00c8498c60 100644
>>>>>>> --- a/security/smack/smack.h
>>>>>>> +++ b/security/smack/smack.h
>>>>>>> @@ -127,7 +127,7 @@ struct task_smack {
>>>>>>>  
>>>>>>>  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
>>>>>>>  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
>>>>>>> -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
>>>>>>> +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
>>>>>> See below ...
>>>>>>
>>>>>>>  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
>>>>>>>  
>>>>>>>  /*
>>>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>>>>> index 8392983334b..b43820bdbd0 100644
>>>>>>> --- a/security/smack/smack_lsm.c
>>>>>>> +++ b/security/smack/smack_lsm.c
>>>>>>> @@ -54,12 +54,12 @@
>>>>>>>  
>>>>>>>  /*
>>>>>>>   * Smack uses multiple xattrs.
>>>>>>> - * SMACK64 - for access control, SMACK64EXEC - label for the program,
>>>>>>> - * SMACK64MMAP - controls library loading,
>>>>>>> + * SMACK64 - for access control,
>>>>>>>   * SMACK64TRANSMUTE - label initialization,
>>>>>>> - * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>>>>>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
>>>>>>> + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
>>>>>>>   */
>>>>>>> -#define SMACK_INODE_INIT_XATTRS 4
>>>>>>> +#define SMACK_INODE_INIT_XATTRS 2
>>>>>>>  
>>>>>>>  #ifdef SMACK_IPV6_PORT_LABELING
>>>>>>>  static DEFINE_MUTEX(smack_ipv6_lock);
>>>>>>> @@ -957,11 +957,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>>>>>>  				     const struct qstr *qstr,
>>>>>>>  				     struct xattr *xattrs, int *xattr_count)
>>>>>>>  {
>>>>>>> -	struct inode_smack *issp = smack_inode(inode);
>>>>>>>  	struct smack_known *skp = smk_of_current();
>>>>>>>  	struct smack_known *isp = smk_of_inode(inode);
>>>>>>>  	struct smack_known *dsp = smk_of_inode(dir);
>>>>>>>  	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>>>>>>> +	struct xattr *xattr2;
>>>>>> I'm going to channel Paul and suggest this be xattr_transmute instead of xattr2.
>>>>>> It also looks like it could move to be declared in the if clause.
>>>>>>
>>>>>>>  	int may;
>>>>>>>  
>>>>>>>  	if (xattr) {
>>>>>>> @@ -979,7 +979,17 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>>>>>>  		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>>>>>>>  		    smk_inode_transmutable(dir)) {
>>>>>>>  			isp = dsp;
>>>>>>> -			issp->smk_flags |= SMK_INODE_CHANGED;
>>>>>> I think you need to keep this. More below.
>>>>>>
>>>>>>> +			xattr2 = lsm_get_xattr_slot(xattrs, xattr_count);
>>>>>>> +			if (xattr2) {
>>>>>>> +				xattr2->value = kmemdup(TRANS_TRUE,
>>>>>>> +							TRANS_TRUE_SIZE,
>>>>>>> +							GFP_NOFS);
>>>>>>> +				if (xattr2->value == NULL)
>>>>>>> +					return -ENOMEM;
>>>>>>> +
>>>>>>> +				xattr2->value_len = TRANS_TRUE_SIZE;
>>>>>>> +				xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
>>>>>>> +			}
>>>>>>>  		}
>>>>>>>  
>>>>>>>  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
>>>>>>> @@ -3512,20 +3522,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>>>>>>>  			 * If there is a transmute attribute on the
>>>>>>>  			 * directory mark the inode.
>>>>>>>  			 */
>>>>>>> -			if (isp->smk_flags & SMK_INODE_CHANGED) {
>>>>>>> -				isp->smk_flags &= ~SMK_INODE_CHANGED;
>>>>>>> -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
>>>>>>> -					XATTR_NAME_SMACKTRANSMUTE,
>>>>>>> -					TRANS_TRUE, TRANS_TRUE_SIZE,
>>>>>>> -					0);
>>>>>>> -			} else {
>>>>>>> -				rc = __vfs_getxattr(dp, inode,
>>>>>>> -					XATTR_NAME_SMACKTRANSMUTE, trattr,
>>>>>>> -					TRANS_TRUE_SIZE);
>>>>>>> -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>>>>>>> -						       TRANS_TRUE_SIZE) != 0)
>>>>>>> -					rc = -EINVAL;
>>>>>>> -			}
>>>>>>> +			rc = __vfs_getxattr(dp, inode,
>>>>>>> +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
>>>>>>> +					    TRANS_TRUE_SIZE);
>>>>>>> +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>>>>>>> +					       TRANS_TRUE_SIZE) != 0)
>>>>>>> +				rc = -EINVAL;
>>>>>> Where is the SMACK64_TRANSMUTE attribute going to get set on the file?
>>>>>> It's not going to get set in smack_init_inode_security(). The inode will
>>>>> Isn't that the purpose of the inode_init_security hook?
>>>> No. It initializes the in-memory inode. 
>>> I hope I'm not mistaken here...
>>>
>>> I make a small example. Filesystems call
>>> security_inode_init_security(). Ext4 does:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/xattr_security.c?h=v6.3-rc6#n54
>>>
>>> security_inode_init_security() allocates new_xattrs. Each LSM fills
>>> new_xattrs. At the end of the loop, if there is at least one xattr
>>> filled, the initxattrs() callback passed by the caller of
>>> security_inode_init_security() is called.
>>>
>>> The ext4 initxattrs() callback is:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/xattr_security.c?h=v6.3-rc6#n35
>>>
>>> which scans the xattr array and, for each xattr,
>>> calls ext4_xattr_set_handle().
>>>
>>> Maybe I'm overlooking it, but ext4_xattr_set_handle() is setting xattrs
>>> on the disk. Am I wrong?
>> Yes, you're wrong. I tried your change, and the SMACK64_TRANSMUTE isn't
>> set on the sub-directory when it's created. The __vfs_setxattr() call really
>> is necessary. 
> Could you please also check if there is any change with this fix:
>
> Replace:
>
> 	xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
>
> with:
>
> 	xattr2->name = XATTR_SMACK_TRANSMUTE;
>
> Thanks

Unless I'm missing something really obvious there's no way that any
of the evm/ima changes would obviate the need for the __vfs_setxattr() call.
It's real easy to verify correct behavior, see the attached script.
(you'll want to change the "notroot" value to a user on your system)

>
> Roberto
>
>>> Thanks
>>>
>>> Roberto
>>>
>>>>> After all LSMs provide one or multiple xattrs, xattrs are going to be
>>>>> written to the disk with the initxattr() callback of filesystems.
>>>>>
>>>>> There is a small mistake above (XATTR_SMACK_TRANSMUTE instead
>>>>> of XATTR_NAME_SMACKTRANSMUTE, as we are providing just the suffix).
>>>> but I'm pretty sure the __vfs_setxattr() call is necessary to get
>>>> the attribute written out. With your change the in-memory inode will
>>>> get the attribute, but if you reboot it won't be on the directory.
>>>>
>>>>> 95 Passed, 0 Failed, 100% Success rate
>>>>>
>>>>> There was a test failing in dir-transmute.sh, before I fixed the xattr
>>>>> name.
>>>>>
>>>>> Thanks
>>>>>
>>>>> Roberto
>>>>>
>>>>>> know it's transmuting, but it won't get to disk without the __vfs_setxattr()
>>>>>> here in smack_d_instantiate(). Now, it's been a long time since that code
>>>>>> was written, so I could be wrong, but I'm pretty sure about that.
>>>>>>
>>>>>> I think that you should be fine with the changes in smack_init_inode_security(),
>>>>>> and leaving smack_d_instantiate() untouched. 
>>>>>>
>>>>>>>  			if (rc >= 0)
>>>>>>>  				transflag = SMK_INODE_TRANSMUTE;
>>>>>>>  		}
--------------f9iv2DS0EpZb0jMgMv08kvbp
Content-Type: text/plain; charset=UTF-8; name="testtransmute.sh"
Content-Disposition: attachment; filename="testtransmute.sh"
Content-Transfer-Encoding: base64

IyEgL2Jpbi9zaAojCiMKClRFU1RESVI9Ii90bXAvdHJhbnNtdXRlLXRlc3QiClRFU1RGSUxF
PSIkVEVTVERJUiIvZmlsZQpURVNUU1VCRElSPSIkVEVTVERJUiIvc3ViZGlyClRFU1RTVUIy
RElSPSIkVEVTVFNVQkRJUiIvc3ViZGlyClRFU1RTVUIzRElSPSIkVEVTVFNVQjJESVIiL3N1
YmRpcgpVU0VSSUQ9YC91c3IvYmluL2lkIC11YApMT0FEPS9zeXMvZnMvc21hY2tmcy9sb2Fk
MgoKaWYgWyAiJFVTRVJJRCIgIT0gIjAiIF0KdGhlbgoJZWNobyBVc2VyIElEICRVU0VSSUQg
aXMgbm90IHJvb3QuCglleGl0IDEKZmkKCm5vdHJvb3Q9ImNzY2hhdWZsZXIiCiMgTk9UUk9P
VD1gdGFpbCAtMSAvZXRjL3Bhc3N3ZCB8IHNlZCAtZSAncy86LiovLydgCiMgZWNobyBVc2lu
ZyAnIickTk9UUk9PVCciJyBhcyBhIHRlc3QgdXNlci4KClJVTkFTPWBjYXQgL3Byb2Mvc2Vs
Zi9hdHRyL2N1cnJlbnRgCgpybSAtcmYgJFRFU1RESVIKbWtkaXIgJFRFU1RESVIKZ3JlcCBg
Y2F0IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50YCAkTE9BRAplY2hvIERpcjogYGF0dHIgLXEg
LVMgLWcgU01BQ0s2NCAkVEVTVERJUiAyPiAvZGV2L251bGxgIGBscyAtaWQgJFRFU1RESVJg
IGBhdHRyIC1xIC1TIC1nIFNNQUNLNjRUUkFOU01VVEUgJFRFU1RESVIgMj4gL2Rldi9udWxs
YAoKIwojIFNpbXBsZSBzZXQvbGlzdC9nZXQgdGVzdHMKIwpUTEFCRUw9YGF0dHIgLXEgLVMg
LWcgU01BQ0s2NFRSQU5TTVVURSAkVEVTVERJUiAyPiAvZGV2L251bGxgCmlmIFsgIngiIiRU
TEFCRUwiICE9ICJ4IiBdCnRoZW4KCWVjaG8gSW5pdGlhbCB0cmFuc211dGUgbGFiZWwgaXMg
dW5leHBlY3RlZGx5ICciJyIkVExBQkVMIiciJy4KCWV4aXQgMQpmaQoKYXR0ciAtcSAtUyAt
cyBTTUFDSzY0VFJBTlNNVVRFIC1WIFdJTEwgJFRFU1RESVIgMj4gL2Rldi9udWxsClRMQUJF
TD1gYXR0ciAtcSAtUyAtZyBTTUFDSzY0VFJBTlNNVVRFICRURVNURElSIDI+IC9kZXYvbnVs
bGAKaWYgWyAieCIiJFRMQUJFTCIgIT0gIngiIF0KdGhlbgoJZWNobyBTZXR0aW5nIHRyYW5z
bXV0ZSBsYWJlbCBzaG91bGQgbm90IGhhdmUgZ290dGVuICciJyIkVExBQkVMIiciJy4KCWV4
aXQgMQpmaQoKVExJU1Q9YGF0dHIgLXEgLVMgLWwgJFRFU1RESVIgfCBncmVwIFRSQU5TTVVU
RWAKaWYgWyAieCIiJFRMSVNUIiAhPSAieCIgXQp0aGVuCgllY2hvIFNldHRpbmcgdHJhbnNt
dXRlIGxhYmVsIGxpc3RlZCBpbmNvcnJlY3RseSBhcyAnIiciJFRMSVNUIiciJy4KCWV4aXQg
MQpmaQoKYXR0ciAtcSAtUyAtcyBTTUFDSzY0VFJBTlNNVVRFIC1WIFRSVUUgJFRFU1RESVIg
Mj4gL2Rldi9udWxsClRMQUJFTD1gYXR0ciAtcSAtUyAtZyBTTUFDSzY0VFJBTlNNVVRFICRU
RVNURElSIDI+IC9kZXYvbnVsbGAKaWYgWyAieCIiJFRMQUJFTCIgIT0gInhUUlVFIiBdCnRo
ZW4KCWVjaG8gU2V0dGluZyB0cmFuc211dGUgbGFiZWwgc2hvdWxkIG5vdCBoYXZlIGdvdHRl
biAnIiciJFRMQUJFTCInIicuCglleGl0IDEKZmkKClRMSVNUPWBhdHRyIC1xIC1TIC1sICRU
RVNURElSIHwgZ3JlcCBUUkFOU01VVEVgCmlmIFsgIngiIiRUTElTVCIgIT0gInhTTUFDSzY0
VFJBTlNNVVRFIiBdCnRoZW4KCWVjaG8gU2V0dGluZyB0cmFuc211dGUgbGFiZWwgbGlzdGVk
IGluY29ycmVjdGx5IGFzICciJyIkVExJU1QiJyInLgoJZXhpdCAxCmZpCgphdHRyIC1xIC1T
IC1yIFNNQUNLNjRUUkFOU01VVEUgJFRFU1RESVIgMj4gL2Rldi9udWxsClRMQUJFTD1gYXR0
ciAtcSAtUyAtZyBTTUFDSzY0VFJBTlNNVVRFICRURVNURElSIDI+IC9kZXYvbnVsbGAKaWYg
WyAieCIiJFRMQUJFTCIgIT0gIngiIF0KdGhlbgoJZWNobyBSZW1vdmluZyB0cmFuc211dGUg
bGFiZWwgbGVmdCAnIiciJFRMQUJFTCInIicgYmVoaW5kLgoJZXhpdCAxCmZpCgpybSAtcmYg
JFRFU1RESVIKCiMKIyBSdWxlIHNldHRpbmcgdGVzdHMKIwojICAgICAgICAgIDEgICAgICAg
ICAyICAgICAgICAgMyAgICAgICAgIDQgICAgICAgICA1ICAgICAgICAgNgojIDEyMzQ1Njc4
OTAxMjM0NTY3ODkwMTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTIzNDU2Nzg5MDEy
MzQ1Njc4OTAKIyBzdWJqZWN0LWxhYmVsLi4uLi4uLi4uLiBvYmplY3QtbGFiZWwuLi4uLi4u
Li4uLiByd3hhdAojCgojICAgICAgICAgICAgICAgICAxICAgICAgICAgMiAgICAgICAgIDMK
IyAgICAgICAgMTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwClNVQkpFQ1Q9IlNuYXAg
ICAgICAgICAgICAgICAgICAgIgpTVUJOQU1FPSJTbmFwIgoKIyAgICAgICAgICAgICAgICAx
ICAgICAgICAgMiAgICAgICAgIDMKIyAgICAgICAxMjM0NTY3ODkwMTIzNDU2Nzg5MDEyMzQ1
Njc4OTAKT0JKRUNUPSJDcmFja2xlICAgICAgICAgICAgICAgICIKT0JOQU1FPSJDcmFja2xl
IgoKT0xEUlVMRT1gZ3JlcCAnXiciJFNVQk5BTUUiJyAnIiRPQk5BTUUiICRMT0FEYAoKZWNo
byAtbiAiJFNVQkpFQ1QiJyAnIiRPQkpFQ1QiJyAnJ3J3eGEnID4gJExPQUQKUlVMRT1gZ3Jl
cCAnXiciJFNVQk5BTUUiJyAnIiRPQk5BTUUiICRMT0FEYAppZiBbICJ4IiIkUlVMRSIgIT0g
IngiIiRTVUJOQU1FIicgJyIkT0JOQU1FIicgcnd4YScgXQp0aGVuCgllY2hvIFNldHRpbmcg
cnVsZSB3aXRob3V0ICciJ3QnIicgdW5leHBlY3RlZGx5ICciJyIkUlVMRSInIicuCglleGl0
IDEKZmkKCmVjaG8gLW4gIiRTVUJKRUNUIicgJyIkT0JKRUNUIicgJydyd3hhdCcgPiAkTE9B
RApSVUxFPWBncmVwICdeJyIkU1VCTkFNRSInICciJE9CTkFNRSIgJExPQURgCmlmIFsgIngi
IiRSVUxFIiAhPSAieCIiJFNVQk5BTUUiJyAnIiRPQk5BTUUiJyByd3hhdCcgXQp0aGVuCgll
Y2hvIFNldHRpbmcgcnVsZSB3aXRoICciJ3QnIicgdW5leHBlY3RlZGx5ICciJyIkUlVMRSIn
IicuCglleGl0IDEKZmkKCiMKIyBWZXJpZnkgY29ycmVjdCBsYWJlbCBiZWhhdmlvciB3aXRo
IG5laXRoZXIgYSB0cmFuc211dGUKIyBkaXJlY3Rvcnkgbm9yIGEgdHJhbnNtdXRlIHJ1bGUu
CiMKCnJtIC1yZiAkVEVTVERJUgpta2RpciAkVEVTVERJUgpncmVwIGBjYXQgL3Byb2Mvc2Vs
Zi9hdHRyL2N1cnJlbnRgICRMT0FECmVjaG8gRGlyOiBgYXR0ciAtcSAtUyAtZyBTTUFDSzY0
ICRURVNURElSIDI+IC9kZXYvbnVsbGAgYGxzIC1pZCAkVEVTVERJUmAgYGF0dHIgLXEgLVMg
LWcgU01BQ0s2NFRSQU5TTVVURSAkVEVTVERJUiAyPiAvZGV2L251bGxgCmNobW9kIDc3NyAk
VEVTVERJUgphdHRyIC1xIC1TIC1zIFNNQUNLNjQgLVYgJE9CTkFNRSAkVEVTVERJUgplY2hv
IC1uICIkU1VCSkVDVCInICciJE9CSkVDVCInICcncnd4YScgPiAkTE9BRAoKZWNobyAiJFNV
Qk5BTUUiID4gL3Byb2Mvc2VsZi9hdHRyL2N1cnJlbnQKc3UgLSAkTk9UUk9PVCAtYyAiZGF0
ZSA+ICRURVNURklMRSIKZWNobyAiJFJVTkFTIiA+IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50
CkdPVD1gYXR0ciAtcSAtUyAtZyBTTUFDSzY0ICRURVNURklMRWAKCmlmIFsgJ3gnIiRTVUJO
QU1FIiAhPSAneCciJEdPVCIgXQp0aGVuCgllY2hvIEV4cGVjdGVkICciJyRTVUJOQU1FJyIn
IGJ1dCBnb3QgJyInJEdPVCciJy4KCWV4aXQgMQpmaQoKIwojIFZlcmlmeSBjb3JyZWN0IGxh
YmVsIGJlaGF2aW9yIHdpdGggYSB0cmFuc211dGUKIyBkaXJlY3RvcnkgYnV0IG5vdCBhIHRy
YW5zbXV0ZSBydWxlLgojCgpybSAtcmYgJFRFU1RESVIKbWtkaXIgJFRFU1RESVIKZ3JlcCBg
Y2F0IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50YCAkTE9BRAplY2hvIERpcjogYGF0dHIgLXEg
LVMgLWcgU01BQ0s2NCAkVEVTVERJUiAyPiAvZGV2L251bGxgIGBscyAtaWQgJFRFU1RESVJg
IGBhdHRyIC1xIC1TIC1nIFNNQUNLNjRUUkFOU01VVEUgJFRFU1RESVIgMj4gL2Rldi9udWxs
YApjaG1vZCA3NzcgJFRFU1RESVIKYXR0ciAtcSAtUyAtcyBTTUFDSzY0IC1WICRPQk5BTUUg
JFRFU1RESVIKYXR0ciAtcSAtUyAtcyBTTUFDSzY0VFJBTlNNVVRFIC1WIFRSVUUgJFRFU1RE
SVIKZWNobyAtbiAiJFNVQkpFQ1QiJyAnIiRPQkpFQ1QiJyAnJ3J3eGEnID4gJExPQUQKCmVj
aG8gIiRTVUJOQU1FIiA+IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50CnN1IC0gJE5PVFJPT1Qg
LWMgImRhdGUgPiAkVEVTVEZJTEUiCmVjaG8gIiRSVU5BUyIgPiAvcHJvYy9zZWxmL2F0dHIv
Y3VycmVudApHT1Q9YGF0dHIgLXEgLVMgLWcgU01BQ0s2NCAkVEVTVEZJTEVgCgppZiBbICd4
JyIkU1VCTkFNRSIgIT0gJ3gnIiRHT1QiIF0KdGhlbgoJZWNobyBFeHBlY3RlZCAnIickU1VC
TkFNRSciJyBidXQgZ290ICciJyRHT1QnIicuCglleGl0IDEKZmkKCiMKIyBWZXJpZnkgY29y
cmVjdCBsYWJlbCBiZWhhdmlvciB3aXRob3V0ICBhIHRyYW5zbXV0ZQojIGRpcmVjdG9yeSBi
dXQgd2l0aCBhIHRyYW5zbXV0ZSBydWxlLgojCgpybSAtcmYgJFRFU1RESVIKbWtkaXIgJFRF
U1RESVIKZ3JlcCBgY2F0IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50YCAkTE9BRAplY2hvIERp
cjogYGF0dHIgLXEgLVMgLWcgU01BQ0s2NCAkVEVTVERJUiAyPiAvZGV2L251bGxgIGBscyAt
aWQgJFRFU1RESVJgIGBhdHRyIC1xIC1TIC1nIFNNQUNLNjRUUkFOU01VVEUgJFRFU1RESVIg
Mj4gL2Rldi9udWxsYApjaG1vZCA3NzcgJFRFU1RESVIKYXR0ciAtcSAtUyAtcyBTTUFDSzY0
IC1WICRPQk5BTUUgJFRFU1RESVIKZWNobyAtbiAiJFNVQkpFQ1QiJyAnIiRPQkpFQ1QiJyAn
J3J3eGF0JyA+ICRMT0FECgplY2hvICIkU1VCTkFNRSIgPiAvcHJvYy9zZWxmL2F0dHIvY3Vy
cmVudApzdSAtICROT1RST09UIC1jICJkYXRlID4gJFRFU1RGSUxFIgplY2hvICIkUlVOQVMi
ID4gL3Byb2Mvc2VsZi9hdHRyL2N1cnJlbnQKR09UPWBhdHRyIC1xIC1TIC1nIFNNQUNLNjQg
JFRFU1RGSUxFYAoKaWYgWyAneCciJFNVQk5BTUUiICE9ICd4JyIkR09UIiBdCnRoZW4KCWVj
aG8gRXhwZWN0ZWQgJyInJFNVQk5BTUUnIicgYnV0IGdvdCAnIickR09UJyInLgoJZXhpdCAx
CmZpCgojCiMgVmVyaWZ5IGNvcnJlY3QgbGFiZWwgYmVoYXZpb3Igd2l0aCBhIHRyYW5zbXV0
ZQojIGRpcmVjdG9yeSBhbmQgYSB0cmFuc211dGUgcnVsZS4KIwoKcm0gLXJmICRURVNURElS
Cm1rZGlyICRURVNURElSCmdyZXAgYGNhdCAvcHJvYy9zZWxmL2F0dHIvY3VycmVudGAgJExP
QUQKZWNobyBEaXI6IGBhdHRyIC1xIC1TIC1nIFNNQUNLNjQgJFRFU1RESVIgMj4gL2Rldi9u
dWxsYCBgbHMgLWlkICRURVNURElSYCBgYXR0ciAtcSAtUyAtZyBTTUFDSzY0VFJBTlNNVVRF
ICRURVNURElSIDI+IC9kZXYvbnVsbGAKY2htb2QgNzc3ICRURVNURElSCmF0dHIgLXEgLVMg
LXMgU01BQ0s2NCAtViAkT0JOQU1FICRURVNURElSCmF0dHIgLXEgLVMgLXMgU01BQ0s2NFRS
QU5TTVVURSAtViBUUlVFICRURVNURElSCmdyZXAgYGNhdCAvcHJvYy9zZWxmL2F0dHIvY3Vy
cmVudGAgJExPQUQKZWNobyBEaXI6IGBhdHRyIC1xIC1TIC1nIFNNQUNLNjQgJFRFU1RESVIg
Mj4gL2Rldi9udWxsYCBgbHMgLWlkICRURVNURElSYCBgYXR0ciAtcSAtUyAtZyBTTUFDSzY0
VFJBTlNNVVRFICRURVNURElSIDI+IC9kZXYvbnVsbGAKZWNobyAtbiAiJFNVQkpFQ1QiJyAn
IiRPQkpFQ1QiJyAnJ3J3eGF0JyA+ICRMT0FECgplY2hvICIkU1VCTkFNRSIgPiAvcHJvYy9z
ZWxmL2F0dHIvY3VycmVudApzdSAtICROT1RST09UIC1jICJkYXRlID4gJFRFU1RGSUxFIgpl
Y2hvICIkUlVOQVMiID4gL3Byb2Mvc2VsZi9hdHRyL2N1cnJlbnQKR09UPWBhdHRyIC1xIC1T
IC1nIFNNQUNLNjQgJFRFU1RGSUxFYAoKaWYgWyAneCciJE9CTkFNRSIgIT0gJ3gnIiRHT1Qi
IF0KdGhlbgoJZWNobyBFeHBlY3RlZCAnIickT0JOQU1FJyInIGJ1dCBnb3QgJyInJEdPVCci
Jy4KCWF0dHIgLWwgLVMgJFRFU1RESVIKCWF0dHIgLVMgLWcgU01BQ0s2NCAkVEVTVEZJTEUK
CWdyZXAgJ14nIiRTVUJOQU1FIicgJyIkT0JOQU1FIiAkTE9BRAoJZXhpdCAxCmVsc2UKCWVj
aG8gRXhwZWN0ZWQgJyInJE9CTkFNRSciJyBhbmQgZ290ICciJyRHT1QnIicgc3VjY2Vzc2Z1
bGx5LgpmaQoKIwojIFZlcmlmeSBjb3JyZWN0IGxhYmVsIGJlaGF2aW9yIHdpdGggYSB0cmFu
c211dGUKIyBkaXJlY3RvcnkgYW5kIHN1YmRpcmVjdG9yaWVzCiMKCmVjaG8gIiRTVUJOQU1F
IiA+IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50CnJtIC1yZiAkVEVTVFNVQkRJUgpzdSAtICRO
T1RST09UIC1jICJta2RpciAkVEVTVFNVQkRJUiIKZ3JlcCBgY2F0IC9wcm9jL3NlbGYvYXR0
ci9jdXJyZW50YCAkTE9BRAplY2hvIERpcjogYGF0dHIgLXEgLVMgLWcgU01BQ0s2NCAkVEVT
VERJUiAyPiAvZGV2L251bGxgIGBscyAtaWQgJFRFU1RESVJgIGBhdHRyIC1xIC1TIC1nIFNN
QUNLNjRUUkFOU01VVEUgJFRFU1RESVIgMj4gL2Rldi9udWxsYAplY2hvIERpcjogYGF0dHIg
LXEgLVMgLWcgU01BQ0s2NCAkVEVTVFNVQkRJUiAyPiAvZGV2L251bGxgIGBscyAtaWQgJFRF
U1RTVUJESVJgIGBhdHRyIC1xIC1TIC1nIFNNQUNLNjRUUkFOU01VVEUgJFRFU1RTVUJESVIg
Mj4gL2Rldi9udWxsYAplY2hvICIkUlVOQVMiID4gL3Byb2Mvc2VsZi9hdHRyL2N1cnJlbnQK
R09UPWBhdHRyIC1xIC1TIC1nIFNNQUNLNjQgJFRFU1RTVUJESVJgCmlmIFsgJ3gnIiRPQk5B
TUUiICE9ICd4JyIkR09UIiBdCnRoZW4KCWVjaG8gRXhwZWN0ZWQgJyInJE9CTkFNRSciJyBi
dXQgZ290ICciJyRHT1QnIicuCmVsc2UKCWVjaG8gRXhwZWN0ZWQgJyInJE9CTkFNRSciJyBh
bmQgZ290ICciJyRHT1QnIicgc3VjY2Vzc2Z1bGx5LgpmaQoKZWNobyAiJFNVQk5BTUUiID4g
L3Byb2Mvc2VsZi9hdHRyL2N1cnJlbnQKcm0gLXJmICRURVNUU1VCMkRJUgpzdSAtICROT1RS
T09UIC1jICJta2RpciAkVEVTVFNVQjJESVIiCmdyZXAgYGNhdCAvcHJvYy9zZWxmL2F0dHIv
Y3VycmVudGAgJExPQUQKZWNobyBEaXI6IGBhdHRyIC1xIC1TIC1nIFNNQUNLNjQgJFRFU1RE
SVIgMj4gL2Rldi9udWxsYCBgbHMgLWlkICRURVNURElSYCBgYXR0ciAtcSAtUyAtZyBTTUFD
SzY0VFJBTlNNVVRFICRURVNURElSIDI+IC9kZXYvbnVsbGAKZWNobyBEaXI6IGBhdHRyIC1x
IC1TIC1nIFNNQUNLNjQgJFRFU1RTVUJESVIgMj4gL2Rldi9udWxsYCBgbHMgLWlkICRURVNU
U1VCRElSYCBgYXR0ciAtcSAtUyAtZyBTTUFDSzY0VFJBTlNNVVRFICRURVNUU1VCRElSIDI+
IC9kZXYvbnVsbGAKZWNobyBEaXI6IGBhdHRyIC1xIC1TIC1nIFNNQUNLNjQgJFRFU1RTVUIy
RElSIDI+IC9kZXYvbnVsbGAgYGxzIC1pZCAkVEVTVFNVQjJESVJgIGBhdHRyIC1xIC1TIC1n
IFNNQUNLNjRUUkFOU01VVEUgJFRFU1RTVUIyRElSIDI+IC9kZXYvbnVsbGAKZWNobyAiJFJV
TkFTIiA+IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50CkdPVD1gYXR0ciAtcSAtUyAtZyBTTUFD
SzY0ICRURVNUU1VCMkRJUmAKaWYgWyAneCciJE9CTkFNRSIgIT0gJ3gnIiRHT1QiIF0KdGhl
bgoJZWNobyBFeHBlY3RlZCAnIickT0JOQU1FJyInIGJ1dCBnb3QgJyInJEdPVCciJy4KZWxz
ZQoJZWNobyBFeHBlY3RlZCAnIickT0JOQU1FJyInIGFuZCBnb3QgJyInJEdPVCciJyBzdWNj
ZXNzZnVsbHkuCmZpCgplY2hvICIkU1VCTkFNRSIgPiAvcHJvYy9zZWxmL2F0dHIvY3VycmVu
dApybSAtcmYgJFRFU1RTVUIzRElSCnN1IC0gJE5PVFJPT1QgLWMgIm1rZGlyICRURVNUU1VC
M0RJUiIKZ3JlcCBgY2F0IC9wcm9jL3NlbGYvYXR0ci9jdXJyZW50YCAkTE9BRAplY2hvIERp
cjogYGF0dHIgLXEgLVMgLWcgU01BQ0s2NCAkVEVTVERJUiAyPiAvZGV2L251bGxgIGBscyAt
aWQgJFRFU1RESVJgIGBhdHRyIC1xIC1TIC1nIFNNQUNLNjRUUkFOU01VVEUgJFRFU1RESVIg
Mj4gL2Rldi9udWxsYAplY2hvIERpcjogYGF0dHIgLXEgLVMgLWcgU01BQ0s2NCAkVEVTVFNV
QkRJUiAyPiAvZGV2L251bGxgIGBscyAtaWQgJFRFU1RTVUJESVJgIGBhdHRyIC1xIC1TIC1n
IFNNQUNLNjRUUkFOU01VVEUgJFRFU1RTVUJESVIgMj4gL2Rldi9udWxsYAplY2hvIERpcjog
YGF0dHIgLXEgLVMgLWcgU01BQ0s2NCAkVEVTVFNVQjJESVIgMj4gL2Rldi9udWxsYCBgbHMg
LWlkICRURVNUU1VCMkRJUmAgYGF0dHIgLXEgLVMgLWcgU01BQ0s2NFRSQU5TTVVURSAkVEVT
VFNVQjJESVIgMj4gL2Rldi9udWxsYAplY2hvIERpcjogYGF0dHIgLXEgLVMgLWcgU01BQ0s2
NCAkVEVTVFNVQjNESVIgMj4gL2Rldi9udWxsYCBgbHMgLWlkICRURVNUU1VCM0RJUmAgYGF0
dHIgLXEgLVMgLWcgU01BQ0s2NFRSQU5TTVVURSAkVEVTVFNVQjNESVIgMj4gL2Rldi9udWxs
YAplY2hvICIkUlVOQVMiID4gL3Byb2Mvc2VsZi9hdHRyL2N1cnJlbnQKR09UPWBhdHRyIC1x
IC1TIC1nIFNNQUNLNjQgJFRFU1RTVUIzRElSYAppZiBbICd4JyIkT0JOQU1FIiAhPSAneCci
JEdPVCIgXQp0aGVuCgllY2hvIEV4cGVjdGVkICciJyRPQk5BTUUnIicgYnV0IGdvdCAnIick
R09UJyInLgplbHNlCgllY2hvIEV4cGVjdGVkICciJyRPQk5BTUUnIicgYW5kIGdvdCAnIick
R09UJyInIHN1Y2Nlc3NmdWxseS4KZmkKCiMKIyB0ZXN0IFNNQUNLNjRUUkFOU01VVEUgcmVt
b3ZhbAojCmVjaG8gdGVzdCBTTUFDSzY0VFJBTlNNVVRFIHJlbW92YWwKCmF0dHIgLVMgLWcg
U01BQ0s2NFRSQU5TTVVURSAkVEVTVFNVQjNESVIKcm0gLXJmICRURVNUU1VCM0RJUgphdHRy
IC1TIC1yIFNNQUNLNjRUUkFOU01VVEUgJFRFU1RTVUIyRElSCnN1IC0gJE5PVFJPT1QgLWMg
Im1rZGlyICRURVNUU1VCM0RJUiIKYXR0ciAtUyAtZyBTTUFDSzY0VFJBTlNNVVRFICRURVNU
U1VCMkRJUgphdHRyIC1TIC1nIFNNQUNLNjRUUkFOU01VVEUgJFRFU1RTVUIzRElSCgpybSAt
cmYgJFRFU1RESVIKIwojIFJlc3RvcmUgb2xkIGxhYmVsIHJ1bGUuCiMKaWYgWyAieCIiJE9M
RFJVTEUiICE9ICJ4IiBdCnRoZW4KCVJBV09MRE1PREU9YGVjaG8gJE9MRFJVTEUgfCBzZWQg
LWUgJ3MvLiogLy8nYAoKCUk9YGVjaG8gJFJBV09MRE1PREUgfCBncmVwICdyJ2AKCWlmIFsg
IngiIiRJIiA9ICJ4IiBdCgl0aGVuCgkJT0xETU9ERT0iLSIKCWVsc2UKCQlPTERNT0RFPSJy
IgoJZmkKCUk9YGVjaG8gJFJBV09MRE1PREUgfCBncmVwICd3J2AKCWlmIFsgIngiIiRJIiA9
ICJ4IiBdCgl0aGVuCgkJT0xETU9ERT0iJE9MRE1PREUiIi0iCgllbHNlCgkJT0xETU9ERT0i
JE9MRE1PREUiInciCglmaQoJST1gZWNobyAkUkFXT0xETU9ERSB8IGdyZXAgJ3gnYAoJaWYg
WyAieCIiJEkiID0gIngiIF0KCXRoZW4KCQlPTERNT0RFPSIkT0xETU9ERSIiLSIKCWVsc2UK
CQlPTERNT0RFPSIkT0xETU9ERSIieCIKCWZpCglJPWBlY2hvICRSQVdPTERNT0RFIHwgZ3Jl
cCAnYSdgCglpZiBbICJ4IiIkSSIgPSAieCIgXQoJdGhlbgoJCU9MRE1PREU9IiRPTERNT0RF
IiItIgoJZWxzZQoJCU9MRE1PREU9IiRPTERNT0RFIiJhIgoJZmkKCUk9YGVjaG8gJFJBV09M
RE1PREUgfCBncmVwICd0J2AKCWlmIFsgIngiIiRJIiA9ICJ4IiBdCgl0aGVuCgkJT0xETU9E
RT0iJE9MRE1PREUiIi0iCgllbHNlCgkJT0xETU9ERT0iJE9MRE1PREUiInQiCglmaQoKCWVj
aG8gLW4gIiRTVUJKRUNUIicgJyIkT0JKRUNUIicgJyIkT0xETU9ERSIgPiAkTE9BRAoJIyBl
Y2hvIFJ1bGUgcmVzZXQgdG8gJyInIiRTVUJOQU1FIicgJyIkT0JOQU1FIicgJyIkT0xETU9E
RSInIicKZWxzZQoJZWNobyAtbiAiJFNVQkpFQ1QiJyAnIiRPQkpFQ1QiJyAnJy0tLS0tJyA+
ICRMT0FECgkjIGVjaG8gUnVsZSByZXNldCB0byAnIiciJFNVQk5BTUUiJyAnIiRPQk5BTUUi
JyAnIi0tLS0tIiciJwpmaQoKZWNobyAiJFJVTkFTIiA+IC9wcm9jL3NlbGYvYXR0ci9jdXJy
ZW50CnJtIC1yZiAkVEVTVERJUgoKZXhpdCAwCg==

--------------f9iv2DS0EpZb0jMgMv08kvbp--
