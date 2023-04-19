Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288E6E82F4
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 23:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjDSVA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjDSVA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 17:00:58 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AC759E3
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681938053; bh=+1plC04mXTaEE0pLCxgiFIuK3kJC3CyU45VC5Uaqtro=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sJkqjUxCxJKFpx7VNPLJK8Y43wwfyMgK6JGtQL4CKubN2AlfPLdDeZuyGcJZfkXjezoILumqzATYL7QSI0Iw27RUXovs6WnoT9IfqCiirEijg9HgEBsGCb9JBZ5qXNKF+oR6cCG//hUdR8oH59RM+E5Dmi9QxonZxmuPgjeVUmJLrdfQ5earVSJBQNYfRvNiqdBfwad0EWIJQqHoH/VkM8cCMdbPoNgWPe4q3CY7asCoelPbGuFXvnnWTq+DQdO+Ve2QuVsziQZVrmNh+Ov9pWCsh47lKp4epSB8xZYiFlXbegPnFTAb3m5Vv0g5V7x9BX+GQNNI6LIQ6B/rm9rFQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681938053; bh=ri5N1DgBGSfEV7LKgDfAcndruTQcK201lgNhDs+Jp1j=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Ru2Wo4BsqUOAV7EYIZahGHqu+TDq1fSBrfLDFD0QAWi8TBdUjaahWA3qO1OW5wBPfdU3IudpMDgm7D4+2NMpDpxPloMe+RmlA4xeNmY112vwmezvw/gE3lFbsqBtJgJHnYqWsBzMwwocbPQF5WjnDbljLTxT0pvYBWxkdybggwMIOcnehQf0m6ObKqNjtR7a74mnONpdTTH8HECNGu3SU/BKuwZ7mQCAaO20NKrVXm4oYQ50K4Xe/h31M8GQL4RsN0m1Vzt5228GWxRF3Nsq3J4UhVEtxaAWnhQqp0XTMOxuvDaX2e/j61wDtgzdhJS0mSJix6rVEql02utYv+OCKw==
X-YMail-OSG: 6pk1CPQVM1k.0F3YA7OFhN5mhuTGKfW2JemosMTk2NJhQQx3FG9iahUjyfWI39i
 RSWa4QxlAjcJ.I5p8DXjad6NtHzeH5yi_li4txm9cOvW6FKUJd8EB2Yd09RzeM2Eog1CUrBpu281
 4Ctbp8zJYjROLby73x7y89.zOE0cXhT_IGMG.Mco2IdrKYFJfnJUeP78HejHrKLK8J5mIPWLB4nr
 k2i7f7IBDPF0Egzg5gSYuCzRJzPSmuRF42ZRVJtiNLoDOYvmoQYoxXc9ZGIX2hzB.bBgpf4sLZu9
 Uv_SfpipcAJNe26AFm_e9RsyaWWYtgXfcpVT9l9vWboYB4XWKwYie9cWQuIzPF2lEAnD.GrhmQ0z
 rLTp2qbFaAht0KPNI_XjtWpjb.WBtjh.EBiS_bRaLCirZ_pCq08FGC58SXRPefYZnBPYsqtL1LMf
 t8niFg09cdPMLcfmlspsaQZ3aY_RL22uxWiQpuW0_rEws.DtbhzTEYX._2QcHcYoGUDyum1BtQ7Q
 9y3RBR2xggzHgnVEsEp1MhlEYCDkxTPMNBRj4_JnqhW8uEetm_3cBf_rYVsbpMA0rDX2.jjlYxrg
 t8vzH1bkszA2TYiluOE3ckjE4X4Ks7gE1J..USOS2H1SbpdslJcxnzHcGqqbhRgkgCOcBrnmTaql
 4dmL_LxD9HTnyGieIpicvTpgDM9lADa8os7gNyEDsk7OGI2trl7Kc9Txhn_DzzadCZx6iKU7b_oc
 bnkfJVjCPNzYj8guIzk1PkntxbEpj0weAPBcBv11Dp_MsiWpYPEcg2rMVKMUjNolfhmXIea81IQZ
 EfbY2I52a4_bEjmD94sAU7G3nedsNL7v.z4g_tCwhETziRFEg7spBvhHY9fBAK7SfkQ9qYvTLHz2
 XeXIg6bugPO8LhmQjR_IgJgryvZuKXld2qoKkaO3I52FQmf2JzvjxZBkmoclsH.4TBP5xOm.seXE
 G1fId4P1lyWqE5aw.SZ2sokGIH3EGajw_uskuMxU6_cuBJX9GpEiMdWzWNUxsHGxbWsLf7MwIwpP
 VigPOTODHodPxTunSe8D7juVWbui74_KfHl_0tnV_OTwRKSQcqw1Oob7t_hHB5UDB1y0MbU1y1Oy
 VOWsq_6MHH4KFu4eOyRu9HcNlQHqf_Z46eHI1wnWUIfB6c_3gcp4rn6M6kjaoUuhFa9ufgKdExmi
 9uZmEHah0pz8xxeA2I4NjcuIGyzQqqAzUuDB9iWumHV8PwPU8gPbxmM2C_dEs_EiU_SEhxlUDZKN
 hj9Eppr5vtbIcU4ojSFFXJFWaD2XXBbAUaJVfwf0s8L7btEvp85gseqqAJ45iwH.u7ng9.QTITzz
 lFG6CiN3Hqp0SvUAzLJATVKrAVEvkhSRyhG.2BJ.ugJNSTYjwOEAK9SGnCHf3NY094r_CP6Vj11d
 UEokIylMLS8igvzOEXsBxuybO.84ZWGGboAYsZUkOlggNK9lFG4NE8tKqGUCZ3in1MOUAsM.yhX5
 arSM8L2vGh8n3noG9qMnnir3UfEvVAjtUeTR8MJLkfI7jNQwpSswyhxUmU70PFPMAbmzvv7mBLCF
 JTO_TdBsZBOuzzynfJ_O8Y3b0d987PqVnDJPJB.hlO1IWPNGlvqxgilCuXJon.5e0MzEPTA6Y11o
 VlTA9eaApbvLf95QH2PtsKR_b7BiRBXxh840kwGO.aQw4V.lY3BPXyslisGyHTwpMyV.cKxASzf.
 2wGA6w8zhymz4bXVSWVBY4zgUI0oXXMthPHiwFrjM.fSTfgzUhd_UhcGFQAgwbWULv7PM.1yFN1O
 cC6bq9AyuEjgOyU8SC34RfKhfzuiV9wLxCC.wm5jNfrb9zHs3ONI7eokMz.N7gDvBEkvoHqV.Ou2
 5gdJY3453S.K1UG.HXhWvUtXIgMMLDudZoB76Wvsee.GlKAbAD7Rbevt1T4URcDO9TSY4fijdmVO
 CzExGOdVQbLDOHWAHG9pRn4JZAplZP1Do0KnDnnpSDza3FApZWHSVuGxMz4pb3KAW5XzSHC8x8e5
 pSin78zs_u0CDL3ByWaStAUtjVmhkhXUtE1M.WImdxHGVg0uwLUWMlSIDzk_UEqAENMJwfRGHpRP
 hHzyZ6Lu_A0WZ6KZjQ__QGz360r0lGtoy0A685DXPN.bXeTdlIy72cbGWfx6p.wBoubk_MtOYMC1
 UqjQhmE1PyYKZy0hqU.1QUKx31MrMTxE8g2_gqTMBWmQkPo5hRpoyC7V8DLPPgIGS.cQGpOSq3.s
 M9BNe2uw0ccU36W4ZAX2WbdZd_hknByZ97b3Kjj9_6h5AHJi.pD2vjfi.c4HU
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3349cbd9-7002-4c38-b2f0-6f1fa2b4aa35
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Apr 2023 21:00:53 +0000
Received: by hermes--production-bf1-5f9df5c5c4-nnnf9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f4da88f521bc765527e6f45641da90ea;
          Wed, 19 Apr 2023 21:00:49 +0000 (UTC)
Message-ID: <c16dd895-f488-241d-0be8-e56e5f0c1adb@schaufler-ca.com>
Date:   Wed, 19 Apr 2023 14:00:44 -0700
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
        Mengchi Cheng <mengcc@amazon.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, kamatam@amazon.com,
        yoonjaeh@amazon.com, Casey Schaufler <casey@schaufler-ca.com>
References: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
 <20230411172337.340518-1-roberto.sassu@huaweicloud.com>
 <2dc6486f-ce9b-f171-14fe-48a90386e1b7@schaufler-ca.com>
 <8e7705972a0f306922d8bc4893cf940e319abb19.camel@huaweicloud.com>
 <72b46d0f-75c7-ac18-4984-2bf1d6dad352@schaufler-ca.com>
 <82ee6ddf66bb34470aa7b591df4d70783fdb2422.camel@huaweicloud.com>
 <91f05dc4-a4b7-b40a-ba1a-0ccc489c84b2@schaufler-ca.com>
 <5c50d98f1e5745c88270ae4ad3de6d9a803db4c6.camel@huaweicloud.com>
 <48c6073f-59b0-f5d1-532e-fe4b912b939d@schaufler-ca.com>
 <0fccab67e496f10f4ee7bf2220e70a655013935f.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <0fccab67e496f10f4ee7bf2220e70a655013935f.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/19/2023 6:46 AM, Roberto Sassu wrote:
> On Tue, 2023-04-18 at 09:02 -0700, Casey Schaufler wrote:
>> On 4/18/2023 12:05 AM, Roberto Sassu wrote:
>>> On Mon, 2023-04-17 at 09:41 -0700, Casey Schaufler wrote:
>>>> On 4/13/2023 12:11 AM, Roberto Sassu wrote:
>>>>> On Wed, 2023-04-12 at 13:29 -0700, Casey Schaufler wrote:
>>>>>> On 4/12/2023 12:22 AM, Roberto Sassu wrote:
>>>>>>> On Tue, 2023-04-11 at 10:54 -0700, Casey Schaufler wrote:
>>>>>>>> On 4/11/2023 10:23 AM, Roberto Sassu wrote:
>>>>>>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>>>>>
>>>>>>>>> Very very quick modification. Not tested.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>>>>> ---
>>>>>>>>>  security/smack/smack.h     |  2 +-
>>>>>>>>>  security/smack/smack_lsm.c | 42 ++++++++++++++++++++------------------
>>>>>>>>>  2 files changed, 23 insertions(+), 21 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>>>>>>>>> index e2239be7bd6..f00c8498c60 100644
>>>>>>>>> --- a/security/smack/smack.h
>>>>>>>>> +++ b/security/smack/smack.h
>>>>>>>>> @@ -127,7 +127,7 @@ struct task_smack {
>>>>>>>>>  
>>>>>>>>>  #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
>>>>>>>>>  #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
>>>>>>>>> -#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
>>>>>>>>> +#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
>>>>>>>> See below ...
>>>>>>>>
>>>>>>>>>  #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
>>>>>>>>>  
>>>>>>>>>  /*
>>>>>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>>>>>>> index 8392983334b..b43820bdbd0 100644
>>>>>>>>> --- a/security/smack/smack_lsm.c
>>>>>>>>> +++ b/security/smack/smack_lsm.c
>>>>>>>>> @@ -54,12 +54,12 @@
>>>>>>>>>  
>>>>>>>>>  /*
>>>>>>>>>   * Smack uses multiple xattrs.
>>>>>>>>> - * SMACK64 - for access control, SMACK64EXEC - label for the program,
>>>>>>>>> - * SMACK64MMAP - controls library loading,
>>>>>>>>> + * SMACK64 - for access control,
>>>>>>>>>   * SMACK64TRANSMUTE - label initialization,
>>>>>>>>> - * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>>>>>>>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
>>>>>>>>> + * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
>>>>>>>>>   */
>>>>>>>>> -#define SMACK_INODE_INIT_XATTRS 4
>>>>>>>>> +#define SMACK_INODE_INIT_XATTRS 2
>>>>>>>>>  
>>>>>>>>>  #ifdef SMACK_IPV6_PORT_LABELING
>>>>>>>>>  static DEFINE_MUTEX(smack_ipv6_lock);
>>>>>>>>> @@ -957,11 +957,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>>>>>>>>  				     const struct qstr *qstr,
>>>>>>>>>  				     struct xattr *xattrs, int *xattr_count)
>>>>>>>>>  {
>>>>>>>>> -	struct inode_smack *issp = smack_inode(inode);
>>>>>>>>>  	struct smack_known *skp = smk_of_current();
>>>>>>>>>  	struct smack_known *isp = smk_of_inode(inode);
>>>>>>>>>  	struct smack_known *dsp = smk_of_inode(dir);
>>>>>>>>>  	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>>>>>>>>> +	struct xattr *xattr2;
>>>>>>>> I'm going to channel Paul and suggest this be xattr_transmute instead of xattr2.
>>>>>>>> It also looks like it could move to be declared in the if clause.
>>>>>>>>
>>>>>>>>>  	int may;
>>>>>>>>>  
>>>>>>>>>  	if (xattr) {
>>>>>>>>> @@ -979,7 +979,17 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>>>>>>>>  		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
>>>>>>>>>  		    smk_inode_transmutable(dir)) {
>>>>>>>>>  			isp = dsp;
>>>>>>>>> -			issp->smk_flags |= SMK_INODE_CHANGED;
>>>>>>>> I think you need to keep this. More below.
>>>>>>>>
>>>>>>>>> +			xattr2 = lsm_get_xattr_slot(xattrs, xattr_count);
>>>>>>>>> +			if (xattr2) {
>>>>>>>>> +				xattr2->value = kmemdup(TRANS_TRUE,
>>>>>>>>> +							TRANS_TRUE_SIZE,
>>>>>>>>> +							GFP_NOFS);
>>>>>>>>> +				if (xattr2->value == NULL)
>>>>>>>>> +					return -ENOMEM;
>>>>>>>>> +
>>>>>>>>> +				xattr2->value_len = TRANS_TRUE_SIZE;
>>>>>>>>> +				xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
>>>>>>>>> +			}
>>>>>>>>>  		}
>>>>>>>>>  
>>>>>>>>>  		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
>>>>>>>>> @@ -3512,20 +3522,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>>>>>>>>>  			 * If there is a transmute attribute on the
>>>>>>>>>  			 * directory mark the inode.
>>>>>>>>>  			 */
>>>>>>>>> -			if (isp->smk_flags & SMK_INODE_CHANGED) {
>>>>>>>>> -				isp->smk_flags &= ~SMK_INODE_CHANGED;
>>>>>>>>> -				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
>>>>>>>>> -					XATTR_NAME_SMACKTRANSMUTE,
>>>>>>>>> -					TRANS_TRUE, TRANS_TRUE_SIZE,
>>>>>>>>> -					0);
>>>>>>>>> -			} else {
>>>>>>>>> -				rc = __vfs_getxattr(dp, inode,
>>>>>>>>> -					XATTR_NAME_SMACKTRANSMUTE, trattr,
>>>>>>>>> -					TRANS_TRUE_SIZE);
>>>>>>>>> -				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>>>>>>>>> -						       TRANS_TRUE_SIZE) != 0)
>>>>>>>>> -					rc = -EINVAL;
>>>>>>>>> -			}
>>>>>>>>> +			rc = __vfs_getxattr(dp, inode,
>>>>>>>>> +					    XATTR_NAME_SMACKTRANSMUTE, trattr,
>>>>>>>>> +					    TRANS_TRUE_SIZE);
>>>>>>>>> +			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>>>>>>>>> +					       TRANS_TRUE_SIZE) != 0)
>>>>>>>>> +				rc = -EINVAL;
>>>>>>>> Where is the SMACK64_TRANSMUTE attribute going to get set on the file?
>>>>>>>> It's not going to get set in smack_init_inode_security(). The inode will
>>>>>>> Isn't that the purpose of the inode_init_security hook?
>>>>>> No. It initializes the in-memory inode. 
>>>>> I hope I'm not mistaken here...
>>>>>
>>>>> I make a small example. Filesystems call
>>>>> security_inode_init_security(). Ext4 does:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/xattr_security.c?h=v6.3-rc6#n54
>>>>>
>>>>> security_inode_init_security() allocates new_xattrs. Each LSM fills
>>>>> new_xattrs. At the end of the loop, if there is at least one xattr
>>>>> filled, the initxattrs() callback passed by the caller of
>>>>> security_inode_init_security() is called.
>>>>>
>>>>> The ext4 initxattrs() callback is:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/xattr_security.c?h=v6.3-rc6#n35
>>>>>
>>>>> which scans the xattr array and, for each xattr,
>>>>> calls ext4_xattr_set_handle().
>>>>>
>>>>> Maybe I'm overlooking it, but ext4_xattr_set_handle() is setting xattrs
>>>>> on the disk. Am I wrong?
>>>> Yes, you're wrong. I tried your change, and the SMACK64_TRANSMUTE isn't
>>>> set on the sub-directory when it's created. The __vfs_setxattr() call really
>>>> is necessary. 
>>> Could you please also check if there is any change with this fix:
>>>
>>> Replace:
>>>
>>> 	xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
>>>
>>> with:
>>>
>>> 	xattr2->name = XATTR_SMACK_TRANSMUTE;
>>>
>>> Thanks
>> Unless I'm missing something really obvious there's no way that any
>> of the evm/ima changes would obviate the need for the __vfs_setxattr() call.
>> It's real easy to verify correct behavior, see the attached script.
>> (you'll want to change the "notroot" value to a user on your system)
> I got some errors during xattr removal, so not sure if my patch was
> working properly or not (it happened also without it, didn't
> investigate more).

The script is demonstrating that those xattrs don't exist when they
shouldn't, si all is good there.

>
> However, I saw another discussion related to transmute:
>
> https://lore.kernel.org/linux-security-module/20230419002338.566487-1-mengcc@amazon.com/
>
> I add the people in CC.
>
> The steps described were so easy to understand and executed, I tried
> without and with overlayfs.
>
> Without:
>
> # echo "_ system rwxatl" > /sys/fs/smackfs/load2
> # mkdir /data
> # chsmack -a "system" /data
> # chsmack -t /data
> # mkdir -p /data/dir1/dir2
> # chsmack /data/dir1
> /data/dir1 access="system" transmute="TRUE"
> # chsmack /data/dir1/dir2
> /data/dir1/dir2 access="system" transmute="TRUE"
>
> It seems to work, right?
>
> With overlay fs it didn't work, same result as the one Mengchi
> reported. Since Mengchi's solution was to set SMK_INODE_CHANGED, and I
> want to get rid of it, I thought to investigate more.
>
> Looking at smack_dentry_create_files_as(), I see that the label of the
> process is overwritten with the label of the transmuting directory.
>
> That causes smack_inode_init_security() to lookup the transmuting rule
> on the overridden credential, and not on the original one.
>
> In the example above, it means that, when overlayfs is creating the new
> inode, the label of the process is system, not _. So no transmute
> permission, and also the xattr will not be added, as observed by
> Mengchi.

OK, I see that. Looks like the original implementation was poorly
thought out/tested.

> Hopefully I undertood the code, so in this particular case we would not
> need to override the label of the process in smack_dentry_create_files_
> as().
>
> If you see smack_inode_init_security():
>
> 	struct smack_known *skp = smk_of_current();
> 	struct smack_known *isp = smk_of_inode(inode);
> 	struct smack_known *dsp = smk_of_inode(dir);
>
> [...]
>
> 		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
> 		    smk_inode_transmutable(dir)) {
> 			isp = dsp;
> [...]
>
> 		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
>
> This code is telling, if there is a transmute rule, and the directory
> is transmuting, set the label of the new inode to the label of the
> directory. That should be already the result that we wanted to obtain.
>
> The current code should have been doing it by overriding the label of
> the process in smack_dentry_create_files_as() with the label of the
> parent directory, and letting the inode being created with the
> overridden label of the process. The transmute xattr is not set due to
> the problem described above.

That would explain the observed behavior.

> So, as a quick test, I kept this patch with the change to xattr2->name, 
> and skipped the label override in smack_dentry_create_files_as(). It
> worked, I get the same result as without overlayfs. Wondering if the
> process label override is necessary in other cases.

It's possible. It's been a long time since I've looked at this.
I'm tempted to take a change to make overlayfs work upstream and
then worry about the ima changes. There seems to be a lot more
going on with the ima changes than is obvious from what's in the
Smack code.

>
> Roberto
>
>>> Roberto
>>>
>>>>> Thanks
>>>>>
>>>>> Roberto
>>>>>
>>>>>>> After all LSMs provide one or multiple xattrs, xattrs are going to be
>>>>>>> written to the disk with the initxattr() callback of filesystems.
>>>>>>>
>>>>>>> There is a small mistake above (XATTR_SMACK_TRANSMUTE instead
>>>>>>> of XATTR_NAME_SMACKTRANSMUTE, as we are providing just the suffix).
>>>>>> but I'm pretty sure the __vfs_setxattr() call is necessary to get
>>>>>> the attribute written out. With your change the in-memory inode will
>>>>>> get the attribute, but if you reboot it won't be on the directory.
>>>>>>
>>>>>>> 95 Passed, 0 Failed, 100% Success rate
>>>>>>>
>>>>>>> There was a test failing in dir-transmute.sh, before I fixed the xattr
>>>>>>> name.
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Roberto
>>>>>>>
>>>>>>>> know it's transmuting, but it won't get to disk without the __vfs_setxattr()
>>>>>>>> here in smack_d_instantiate(). Now, it's been a long time since that code
>>>>>>>> was written, so I could be wrong, but I'm pretty sure about that.
>>>>>>>>
>>>>>>>> I think that you should be fine with the changes in smack_init_inode_security(),
>>>>>>>> and leaving smack_d_instantiate() untouched. 
>>>>>>>>
>>>>>>>>>  			if (rc >= 0)
>>>>>>>>>  				transflag = SMK_INODE_TRANSMUTE;
>>>>>>>>>  		}
