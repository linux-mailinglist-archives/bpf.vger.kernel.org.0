Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BA66E4E71
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 18:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDQQld (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDQQlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 12:41:32 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2217DBB
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681749687; bh=yqhBXS4YKf1UBk0F+AjrahKi6VCKry4pP3XAJtVAQUw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hgwtIzgDWfAPI1dsH67X0IVaLYqVviMRXMgLMiAcw5RqKY01IAjD5RIvnzyIFozXvxPlml5uO2CSYrlucUNMClFD2Sz8Y20NqezZdeIRi5fGwi79L/5LGfvIAZBxvs5GGUUyavT8sjOaBrCnJRsvBVsHWjrpimO3XFY5g1+Kqp03rBkMdbOZ0fbu8bHpgnDjZbNAawX07EYvfyxH/H6ZJmsRReWE/xt4q1gMXVf1iwFes1KYf6SpTrCO5kevh/oBX2XgVFW0rROJ8PMazI8J19opunpBiAo2fOlA84EC2sAXmLgwTKW6l1/29xtQHylOXuq4k2IjSrnwYR1ofs54Yg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681749687; bh=rGuypqlb7LXIXNxP6jrGT0fWRWcTQ7GhBm/U7rodiE6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bAxU9O1w2+3LAPuENatsquaxajuKguO1GCEcDtskIqLHd/iuUBqA+xBWmUBDxkHKA2yd8vjACoibk27rCA3g0ePx44cGpfxLP7rKJtjmIDYg6BRVLYSzz59s1h0Olh1n50oY4/6ZIvEVrkpgIJ9id7gDHX8diak5UuH74dBILl8WL7G1Q90g1d5U01y2ls6hlCQf0fuzheh26aEQ/4DS3+mRHib7GkBr1+Pv4PGZwXoTl3uD1S+SQR2TZD+WSKnRt2qb9Dc5S9KNE29mQWwmzX+k6W+wb5BR4ehYduOGPyx+b9C3JKRrov0Kr07XtCJgZy5IRgSIuVJ6CXTKZnV30w==
X-YMail-OSG: XDodL20VM1mdqVj4j3tyVveKdfxxdQEGrsqYKD.B4p3vLZswgzfnbq6RH8oRohG
 sTazvlDq0iCxkL25wI9vwHic.ID_HDLOdxDoj.kRbYdPx2UQ94OTX_zIe9UJqBv_KnWyKOXsOzAL
 IVBZuPg7SpC0LBa6kPEzpPtomi9dTB_eKV64VvuWTClQUrlU1ErU65oj4QopvY_np4yK2LwESsUu
 4MvdU6qRTP.DQWBItsExWsfUk_H1AgLSLrHhXIaf7ub6PIMQZ4TNkVSI7o0I2f89qKWQff8T4Hx_
 gNj0gyXott7wY412iEJgXJ6sx2z5BUsQflm8wQUAIrlJoZ8x3223soPY5jvisfsBGkfJrMsqFlmf
 G0w6xV4UGpB8c.vrPNrIMfVnSu02Pv8CS_hj5lc1gwLL71pDr9gPWdakQqG745r8tbP51fm20o48
 1jxNZVn9nJmWl6CZk7GvQ7ugZFxjeHnzNmcx6E0_gHV0yYPPa9a0OYlsTc9AKRTM5KYy5JTnebMr
 MDqCceb0wE21ruuQLRCwSVm7C7w9Br5rEMssiLkkgA.IxQT5prRkpn8N3hG3B9sYkBD0U2G6ySsv
 Wz2foGN.czVjQNHQ7r5Xtv1i1_s6Zi_g2jFnoNGO0E2i.zUWwx.efKYc1aq_4H5uC3LHE6RXAew5
 _N6BfUpcLYFxNqJS_vt8zV3gkUuI.kygOpZbHBHcHD4eJL6kBI.8VpFprDO6cX8HjiRSQu7iwda5
 T95EVJxQqmkMZUhQLFlVW2ehshW9GhvtykXkiEEkmx6B2Y60dEK7ToaznCyTrLIJ8y2V.fCpyQ.Y
 koRseMfgS.glrY_GnJxH33l49OjxZxu.e2CQczsJc0kpwvE0Kb0o423eYHq8hyXKcQYESCd.LLd4
 N1c8CELmhitNR.4rcM42PVBeUFAPH4dJJfQQrRZV3_bPETpxxL1jWHjtH2fdDmp2erAh7KPtSQnO
 CIomjZT32NAXBysqTOjgpWHzl9.AoMH.mAQgADxSfG_jWRQJ0AsxazYH3I4u7sF2E3.G07ekTNXJ
 SNDpyUgwhzpwLTAG_EUPG_n6VmrWODMjpaEQLYZtHNPLk_Eo.YCl12prLH8xh.TmPEFXAfS_p_4W
 uPC2QeRaN68duww44mhIPDAsOpKZ..uiHVr9WihKTjEs6LhkEjb1IWBd5fD.I4CM6BNJ8f592pn3
 N65B4uIpJKgvdR.0EWL61pljBopqI91hEryWsMgF2YsuD27IismejhTjEF3h4r5TKniBz3VZt5oV
 DUYixTezq0GSxtWbQC1oALNX08FY1OP9BEpa8K3hOZcSPrhGjLCNsmFdfHxRBmtDCxOmxHIql0D8
 EB1e6mgLoioeP4fQ5EXnfwm8wy8hN3qOE1oW4a2vVeI_c5lz9KzZ6MAQFYLphoHprY5PIMMei33R
 GJaqVG1eOdPDxGfjKNP.xIxB3HPmOJwX9gDaNO5ua5junEjE6fv6lrSls87bwQcxrApOcI7QoCZa
 zz7XaRNyZjtaZHAe5oIiVMsYQZmfE3439JkX3ODrjoSQW3hZ6EhdUONUojVpwi237EBgvvxOsVKM
 m.wFm3AC8kjvFWJgwdwsTbps9ha73QShibqSaCtXRtUu3cT8H82RGFSZ17DZ0NPk6Xbsffy0o_4R
 myk0jRyxcjYddG11uuDK3QqquHKfePXJDc1Re2VB4dxzA8X8kbM0KDvwkqRY5v6ERs5NO5gNgB1z
 Q9TWFB.MteWa6zUMgzgBXuLTfKfk8gYOevbkV4Lp0ENfyPgUNEh2KHCwmHxg2mCmMEmcuSpdtZyu
 .Zh0zZ00Y9KwxLkOJuUR66tyyJAHkccpX03ciXSrbw6vmYb5ZBgtxRnb0uOPB_v.ms523CVwgmMx
 GTzAWP7c82nY1o32y3TeX_.Azbo5KPRCAbfAYfnWtwN7oK53xCr_w9crBOE_cVEx79BUqSsuoBIe
 qEWoq_4E2Tob5.6e2aGlJNH6mBCY2ZnEgokm0ODcXleFI06x1fLhQj2yabnNNQk5MC2Ank2QNsiq
 ul_oe886S.xBx6GynkfbT1gU_qG.7RliNLyJEsfNug8oaOtEM_wYCgUKb3.dbQvhZvdEPf3Mrnea
 aOKjYetzNuMGCIobZcEWvf3dMTqPGKsJg_5J7IUrXNPXCeTLy2T6ZRn8sWfFfNJ8AIHzsTPdBRtd
 B.gOZ5f3WXkh8bGkJXljsEgMQFBVkZA_OUnitgMxxGLwsjgvrNQaaYuo5NMwVDoDYQG9FimTsgSu
 JK.7Cyyj4kuuqRUAkxk8l8oLeqZnWT3rrrXs4c8Bd.mYP8M_ngGhsZITgNv70.Hun9au_Crw1Wyh
 kHRZXB3EB1V8HTw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 69276f55-b839-4927-a8ce-a9a900bcc8ae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 17 Apr 2023 16:41:27 +0000
Received: by hermes--production-bf1-5f9df5c5c4-8dccp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a44fae997d8c567dba192ef9fc91bf6c;
          Mon, 17 Apr 2023 16:41:25 +0000 (UTC)
Message-ID: <91f05dc4-a4b7-b40a-ba1a-0ccc489c84b2@schaufler-ca.com>
Date:   Mon, 17 Apr 2023 09:41:21 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <82ee6ddf66bb34470aa7b591df4d70783fdb2422.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/13/2023 12:11 AM, Roberto Sassu wrote:
> On Wed, 2023-04-12 at 13:29 -0700, Casey Schaufler wrote:
>> On 4/12/2023 12:22 AM, Roberto Sassu wrote:
>>> On Tue, 2023-04-11 at 10:54 -0700, Casey Schaufler wrote:
>>>> On 4/11/2023 10:23 AM, Roberto Sassu wrote:
>>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>
>>>>> Very very quick modification. Not tested.
>>>>>
>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>> ---
>>>>>  security/smack/smack.h     |  2 +-
>>>>>  security/smack/smack_lsm.c | 42 ++++++++++++++++++++------------------
>>>>>  2 files changed, 23 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>>>>> index e2239be7bd6..f00c8498c60 100644
>>>>> --- a/security/smack/smack.h
>>>>> +++ b/security/smack/smack.h
>>>>> @@ -127,7 +127,7 @@ struct task_smack {
>>>>>  
>>>>>  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
>>>>>  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
>>>>> -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
>>>>> +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
>>>> See below ...
>>>>
>>>>>  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
>>>>>  
>>>>>  /*
>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>>> index 8392983334b..b43820bdbd0 100644
>>>>> --- a/security/smack/smack_lsm.c
>>>>> +++ b/security/smack/smack_lsm.c
>>>>> @@ -54,12 +54,12 @@
>>>>>  
>>>>>  /*
>>>>>   * Smack uses multiple xattrs.
>>>>> - * SMACK64 - for access control, SMACK64EXEC - label for the program,
>>>>> - * SMACK64MMAP - controls library loading,
>>>>> + * SMACK64 - for access control,
>>>>>   * SMACK64TRANSMUTE - label initialization,
>>>>> - * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>>>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
>>>>> + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
>>>>>   */
>>>>> -#define SMACK_INODE_INIT_XATTRS 4
>>>>> +#define SMACK_INODE_INIT_XATTRS 2
>>>>>  
>>>>>  #ifdef SMACK_IPV6_PORT_LABELING
>>>>>  static DEFINE_MUTEX(smack_ipv6_lock);
>>>>> @@ -957,11 +957,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>>>>  				     const struct qstr *qstr,
>>>>>  				     struct xattr *xattrs, int *xattr_count)
>>>>>  {
>>>>> -	struct inode_smack *issp = smack_inode(inode);
>>>>>  	struct smack_known *skp = smk_of_current();
>>>>>  	struct smack_known *isp = smk_of_inode(inode);
>>>>>  	struct smack_known *dsp = smk_of_inode(dir);
>>>>>  	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>>>>> +	struct xattr *xattr2;
>>>> I'm going to channel Paul and suggest this be xattr_transmute instead of xattr2.
>>>> It also looks like it could move to be declared in the if clause.
>>>>
>>>>>  	int may;
>>>>>  
>>>>>  	if (xattr) {
>>>>> @@ -979,7 +979,17 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>>>>  		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>>>>>  		    smk_inode_transmutable(dir)) {
>>>>>  			isp = dsp;
>>>>> -			issp->smk_flags |= SMK_INODE_CHANGED;
>>>> I think you need to keep this. More below.
>>>>
>>>>> +			xattr2 = lsm_get_xattr_slot(xattrs, xattr_count);
>>>>> +			if (xattr2) {
>>>>> +				xattr2->value = kmemdup(TRANS_TRUE,
>>>>> +							TRANS_TRUE_SIZE,
>>>>> +							GFP_NOFS);
>>>>> +				if (xattr2->value == NULL)
>>>>> +					return -ENOMEM;
>>>>> +
>>>>> +				xattr2->value_len = TRANS_TRUE_SIZE;
>>>>> +				xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
>>>>> +			}
>>>>>  		}
>>>>>  
>>>>>  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
>>>>> @@ -3512,20 +3522,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>>>>>  			 * If there is a transmute attribute on the
>>>>>  			 * directory mark the inode.
>>>>>  			 */
>>>>> -			if (isp->smk_flags & SMK_INODE_CHANGED) {
>>>>> -				isp->smk_flags &= ~SMK_INODE_CHANGED;
>>>>> -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
>>>>> -					XATTR_NAME_SMACKTRANSMUTE,
>>>>> -					TRANS_TRUE, TRANS_TRUE_SIZE,
>>>>> -					0);
>>>>> -			} else {
>>>>> -				rc = __vfs_getxattr(dp, inode,
>>>>> -					XATTR_NAME_SMACKTRANSMUTE, trattr,
>>>>> -					TRANS_TRUE_SIZE);
>>>>> -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>>>>> -						       TRANS_TRUE_SIZE) != 0)
>>>>> -					rc = -EINVAL;
>>>>> -			}
>>>>> +			rc = __vfs_getxattr(dp, inode,
>>>>> +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
>>>>> +					    TRANS_TRUE_SIZE);
>>>>> +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>>>>> +					       TRANS_TRUE_SIZE) != 0)
>>>>> +				rc = -EINVAL;
>>>> Where is the SMACK64_TRANSMUTE attribute going to get set on the file?
>>>> It's not going to get set in smack_init_inode_security(). The inode will
>>> Isn't that the purpose of the inode_init_security hook?
>> No. It initializes the in-memory inode. 
> I hope I'm not mistaken here...
>
> I make a small example. Filesystems call
> security_inode_init_security(). Ext4 does:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/xattr_security.c?h=v6.3-rc6#n54
>
> security_inode_init_security() allocates new_xattrs. Each LSM fills
> new_xattrs. At the end of the loop, if there is at least one xattr
> filled, the initxattrs() callback passed by the caller of
> security_inode_init_security() is called.
>
> The ext4 initxattrs() callback is:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/xattr_security.c?h=v6.3-rc6#n35
>
> which scans the xattr array and, for each xattr,
> calls ext4_xattr_set_handle().
>
> Maybe I'm overlooking it, but ext4_xattr_set_handle() is setting xattrs
> on the disk. Am I wrong?

Yes, you're wrong. I tried your change, and the SMACK64_TRANSMUTE isn't
set on the sub-directory when it's created. The __vfs_setxattr() call really
is necessary. 

>
> Thanks
>
> Roberto
>
>>> After all LSMs provide one or multiple xattrs, xattrs are going to be
>>> written to the disk with the initxattr() callback of filesystems.
>>>
>>> There is a small mistake above (XATTR_SMACK_TRANSMUTE instead
>>> of XATTR_NAME_SMACKTRANSMUTE, as we are providing just the suffix).
>>>
>>> After fixing that, Smack tests succeed:
>> It's over a decade since I seriously looked at this code path,
>> but I'm pretty sure the __vfs_setxattr() call is necessary to get
>> the attribute written out. With your change the in-memory inode will
>> get the attribute, but if you reboot it won't be on the directory.
>>
>>> 95 Passed, 0 Failed, 100% Success rate
>>>
>>> There was a test failing in dir-transmute.sh, before I fixed the xattr
>>> name.
>>>
>>> Thanks
>>>
>>> Roberto
>>>
>>>> know it's transmuting, but it won't get to disk without the __vfs_setxattr()
>>>> here in smack_d_instantiate(). Now, it's been a long time since that code
>>>> was written, so I could be wrong, but I'm pretty sure about that.
>>>>
>>>> I think that you should be fine with the changes in smack_init_inode_security(),
>>>> and leaving smack_d_instantiate() untouched. 
>>>>
>>>>>  			if (rc >= 0)
>>>>>  				transflag = SMK_INODE_TRANSMUTE;
>>>>>  		}
