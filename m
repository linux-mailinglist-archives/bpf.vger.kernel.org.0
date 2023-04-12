Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FB76DFFD7
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 22:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjDLU3x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDLU3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 16:29:52 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7DD72BE
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681331385; bh=2/Rleu8Lgu7q0ljiF/HtbOjKUdbZsdOnZo+57VAAZvM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZNQe0acWsnezWAr9imAaYciSRhEGmpeG1bneEIx+25R7FTEUE04Urvs3s0T3Ws0mAhAzF2YOZM10zL87RJGe/BMhmpQjp4xkpiNYctVpJLoztHCo2UgefsRxv1JNMkWyKKQjVFx8xhGAKdwUKl4XZruZrXqkHCGSUTqQoTY5b9DAsaIAZo9V3vXa9EH5k5fcg3vxc4uuS36sunTxJDFOCmWWzQvbbXg97/KdmqWNcjfMeD2xFFMbHAI7WX2WMh0B4x1hRT5Nomx0Jmk0rd/H+UIDvXM8WEHw6LF/O2h8jo9Xo8dUhWuucog/Fen7PpBqP+ricJsmESMSAp3/YGtP2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681331385; bh=pEkyF/PatcQqQRZrHQ9GwTvSug0vj03Fb50IJLp0Cw3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=C5/O7f7f7raRw9BlUAaOkn+5NjHtpbTT95hCLTcSwCdbecrQnCsM1b9tBGIFruNxxm2pBCkAM9zprtH7RZ3FGkVeRRZpn613CWWjPZ1VTV4ImlXn6zsAGFOxnx91nd0g8mV6E9jrx3n7O4i+JBJdoO8Fc1bYF7qVRd3RgGg49iNsP60SycW7q5sE1l6cBfHjnF1a00t6cqaEkgSw3g5o8bzIyCtcLML537nyL6ZfIroH0fY36URfzxM+smoNrTL2in5PgHhfHhg/Mbg7Kw16Xe9y2tjQ06b8hW+p7Nk+/3rbbKaZSMMMBeH0cLT85poen4bNc6dr3xi6cW6aKIJF6g==
X-YMail-OSG: eoJgcs0VM1nIcuNV.uaSNAP7obN8iAUnHSqwWwH3zMj1hZiI_c1c.pZXh6GiF3M
 oVOQOc57.W8uqNrVidygXtWUv4A1Ubm1XQ42OA535bO_RZqWL8gLUZeDmn3j7mLB3m9H7jj5Qmo1
 zVXCCMTP8H89OhyWjqud90b2ieWws9OXCy9no21MJEu3FYzzUlUn_RMJb_KuQIGA3TVrETGdrGe8
 nOWkmmPaFqP48rTY5j.sUX2qDCVbohJaA_Md8yx6h8NKELM_EFKV62sThYIbOISuYFWEq8KNrQAG
 V536IbvccJZ2W3emWfHLyKYs1LV3ZiFs3U1FmHHEZSIZ6_8t9z3ihsWUBV_8wofCRAd3PcXp_io8
 DYqYGAEVDlfXkCMVyRc2QWcGXDJHrQv98bGhmmAFu8Jm.lVRrOf8CIQXf4GDBe6LnNI1AtPaIc1m
 X4VDrQgq8ya5.dUYrOQuOLVXcQB3h.Hbx64KZUfFYJJS1xNTwX_E5mduWZMzOAcDCc2YSZ5uoATo
 0mXkf6nRCJcCn3nkZ0.s4uP2mUJwovwXU3l1R1Uy8j6yJ4uc5o4cJwz5BG0IdQQx5XtvlAu98A2P
 mCBwkNctA_bdHnS6EhKIkk_OCCCfeaEwpMKTmR2J.uiiYwyAB0xbCRd72jsic4YKfObYC_RpX7PO
 8cmWuGQ0vpyMRYJAqO.zHQiw2TxuXQdGh9Q8JUtscL8zB8Djw7Y0HuhUK58fmhS9ppH2FlZ1XC25
 IQf_n3_U_4O27F5p6lzv.GeehOvS4MjsxkVNhUEIAs5CebDOWPh_Wvm2Ze1GB1VEDXIvAMc7nTju
 Gqjbipt5iI_DBXteYW2lTFtUimBKWDS9qCdTddMD8gx6F419By.1JOATFjRK0aGqiF3hNDaxbJEe
 9Yzt1l9ayaWFaqvuQiVD.oEKtxXoaJHKHaaMgkgNnk9Ee3DrUAY26RrgH2tPpkwuu6n5Kbic_Jml
 cw0nJ95hE1p._bN7yWUEVzXblbWeQZ5hkMZVC1CsD716XzPpT0ApfKoKLcV_6y4hlbYAQKj3nlZN
 WZviERcgi8Q7D6B0fBeuKSh8xOB4Q90M0e6U0uKZoemXE1pmSMkFeGe0Sq2M4781_3ojasXUOF2X
 FCs8kgghuGgG1FRXBoF2RnpwVPgV5IlKZgsXPOdjlOt27Y2cE1mUW2y5cpMHysCWmNJHbIIW3Ds1
 cxPp8VzTBHwMvrBiAr5y22B6enpbT93mzYYXzQb.FdrXVdu46RZ1Qfo_6Ij7Q.T6peb3.mhVRkHI
 GdcWv5WdZzJM_wboyYPbxRIL2i9o3c8WAeXVspdG8_TQKZB84s4Ucu0STHvO2WhA2WBLm.z6jVTh
 jZzVSAHM.LSZ597V4LQVHMvjAZD9QAGkj_PAK4vysDOTF5O1xJpifNO7ZbQEenMQ7D8pxQdDplkN
 q3BQGbHjdYq87XUp3FLxTwXK2JclEXVI8IezG7r0cGFxvY48U8RNejkOcQjpmgcX1bx9cueNfbMn
 tT.MdMPddrJE4_MN50on0Bl_LIvMWpiJARI4YgYV6Bnlc558zHzd5JsgO6RAuJkR4QKFGk_qlS3I
 zvVCNtwM0YS28gzrkcbQ_xbSwWjYUr47g9W_4sMvStMFkMBWgXT0vuvmSeECC6M743.asIC5txqG
 ZUzmuYA5cQI1_vffpfRMM5K2I8SGcNfgmE.DTZsy3D8YCk7ogorC3vxlhiAx1R0RYH6_QnblE.Sw
 MiI4mm5i9I5QLH1CQ5X_Hkx8QcEeQqdLHD89oplZrSr2w2pnQ0119QqfZcki8txpNNEFifb8Am6p
 RletxWOTUHp0C8wrU9HcelPFnfmVD4YxSs8Z1aHI.3Uk1ZUNB7uN3q6dGM_8LoPqBvPwe.sApmKH
 RaRZaJTsDrFdU0BMTCGRKV7YP08ODbMqBWbY4LEc1pdv4wpD1gy1HbALBYQzpH_cwXTqgYklyOtG
 YopeNZyCE6G2ZqZ8EhugqVetgWjGEARZIEKSvjyaxfJLTbR_GTkgssvenxkEoFz6SkdQvrtPZzy2
 PUL8LMIHiw.UwXiBWE1OypE4OytM4e9gFzaT1QfTMIcK6xgz28mXi1elUvOEMV_xIgsgX1c38Nuh
 V0PBUY80jP0vlzN3ktUpHtUrXptrsxooC0wPSxxqqzQ03D1OLsaK3ffStqfye0BDdETZLKyQlQXw
 cxAPwlLnEhtQOnzdGlzEuFfrTZtU5OG5nT7smF_RhbJK7rkd_802gRzs.HyVdRDXGL0S.uj5WYaY
 EceGeDDnhY4sQi_sDj_C1hZ8T6lAjdfDgorbezExMcOqSc_j9RQsn2aA6JNcTEzUvM7CXLIjHDly
 RKyWVqrYVq2qzC2Ay
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9a43225b-4c57-443c-8941-a6d373658187
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Apr 2023 20:29:45 +0000
Received: by hermes--production-bf1-5f9df5c5c4-bqwvr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b1668afe2a93b144acd4394e0275b411;
          Wed, 12 Apr 2023 20:29:41 +0000 (UTC)
Message-ID: <72b46d0f-75c7-ac18-4984-2bf1d6dad352@schaufler-ca.com>
Date:   Wed, 12 Apr 2023 13:29:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <8e7705972a0f306922d8bc4893cf940e319abb19.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/12/2023 12:22 AM, Roberto Sassu wrote:
> On Tue, 2023-04-11 at 10:54 -0700, Casey Schaufler wrote:
>> On 4/11/2023 10:23 AM, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> Very very quick modification. Not tested.
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> ---
>>>  security/smack/smack.h     |  2 +-
>>>  security/smack/smack_lsm.c | 42 ++++++++++++++++++++------------------
>>>  2 files changed, 23 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>>> index e2239be7bd6..f00c8498c60 100644
>>> --- a/security/smack/smack.h
>>> +++ b/security/smack/smack.h
>>> @@ -127,7 +127,7 @@ struct task_smack {
>>>  
>>>  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
>>>  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
>>> -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
>>> +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
>> See below ...
>>
>>>  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
>>>  
>>>  /*
>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>> index 8392983334b..b43820bdbd0 100644
>>> --- a/security/smack/smack_lsm.c
>>> +++ b/security/smack/smack_lsm.c
>>> @@ -54,12 +54,12 @@
>>>  
>>>  /*
>>>   * Smack uses multiple xattrs.
>>> - * SMACK64 - for access control, SMACK64EXEC - label for the program,
>>> - * SMACK64MMAP - controls library loading,
>>> + * SMACK64 - for access control,
>>>   * SMACK64TRANSMUTE - label initialization,
>>> - * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
>>> + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
>>>   */
>>> -#define SMACK_INODE_INIT_XATTRS 4
>>> +#define SMACK_INODE_INIT_XATTRS 2
>>>  
>>>  #ifdef SMACK_IPV6_PORT_LABELING
>>>  static DEFINE_MUTEX(smack_ipv6_lock);
>>> @@ -957,11 +957,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>>  				     const struct qstr *qstr,
>>>  				     struct xattr *xattrs, int *xattr_count)
>>>  {
>>> -	struct inode_smack *issp = smack_inode(inode);
>>>  	struct smack_known *skp = smk_of_current();
>>>  	struct smack_known *isp = smk_of_inode(inode);
>>>  	struct smack_known *dsp = smk_of_inode(dir);
>>>  	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>>> +	struct xattr *xattr2;
>> I'm going to channel Paul and suggest this be xattr_transmute instead of xattr2.
>> It also looks like it could move to be declared in the if clause.
>>
>>>  	int may;
>>>  
>>>  	if (xattr) {
>>> @@ -979,7 +979,17 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>>  		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>>>  		    smk_inode_transmutable(dir)) {
>>>  			isp = dsp;
>>> -			issp->smk_flags |= SMK_INODE_CHANGED;
>> I think you need to keep this. More below.
>>
>>> +			xattr2 = lsm_get_xattr_slot(xattrs, xattr_count);
>>> +			if (xattr2) {
>>> +				xattr2->value = kmemdup(TRANS_TRUE,
>>> +							TRANS_TRUE_SIZE,
>>> +							GFP_NOFS);
>>> +				if (xattr2->value == NULL)
>>> +					return -ENOMEM;
>>> +
>>> +				xattr2->value_len = TRANS_TRUE_SIZE;
>>> +				xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
>>> +			}
>>>  		}
>>>  
>>>  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
>>> @@ -3512,20 +3522,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>>>  			 * If there is a transmute attribute on the
>>>  			 * directory mark the inode.
>>>  			 */
>>> -			if (isp->smk_flags & SMK_INODE_CHANGED) {
>>> -				isp->smk_flags &= ~SMK_INODE_CHANGED;
>>> -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
>>> -					XATTR_NAME_SMACKTRANSMUTE,
>>> -					TRANS_TRUE, TRANS_TRUE_SIZE,
>>> -					0);
>>> -			} else {
>>> -				rc = __vfs_getxattr(dp, inode,
>>> -					XATTR_NAME_SMACKTRANSMUTE, trattr,
>>> -					TRANS_TRUE_SIZE);
>>> -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>>> -						       TRANS_TRUE_SIZE) != 0)
>>> -					rc = -EINVAL;
>>> -			}
>>> +			rc = __vfs_getxattr(dp, inode,
>>> +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
>>> +					    TRANS_TRUE_SIZE);
>>> +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>>> +					       TRANS_TRUE_SIZE) != 0)
>>> +				rc = -EINVAL;
>> Where is the SMACK64_TRANSMUTE attribute going to get set on the file?
>> It's not going to get set in smack_init_inode_security(). The inode will
> Isn't that the purpose of the inode_init_security hook?

No. It initializes the in-memory inode. 

> After all LSMs provide one or multiple xattrs, xattrs are going to be
> written to the disk with the initxattr() callback of filesystems.
>
> There is a small mistake above (XATTR_SMACK_TRANSMUTE instead
> of XATTR_NAME_SMACKTRANSMUTE, as we are providing just the suffix).
>
> After fixing that, Smack tests succeed:

It's over a decade since I seriously looked at this code path,
but I'm pretty sure the __vfs_setxattr() call is necessary to get
the attribute written out. With your change the in-memory inode will
get the attribute, but if you reboot it won't be on the directory.

>
> 95 Passed, 0 Failed, 100% Success rate
>
> There was a test failing in dir-transmute.sh, before I fixed the xattr
> name.
>
> Thanks
>
> Roberto
>
>> know it's transmuting, but it won't get to disk without the __vfs_setxattr()
>> here in smack_d_instantiate(). Now, it's been a long time since that code
>> was written, so I could be wrong, but I'm pretty sure about that.
>>
>> I think that you should be fine with the changes in smack_init_inode_security(),
>> and leaving smack_d_instantiate() untouched. 
>>
>>>  			if (rc >= 0)
>>>  				transflag = SMK_INODE_TRANSMUTE;
>>>  		}
