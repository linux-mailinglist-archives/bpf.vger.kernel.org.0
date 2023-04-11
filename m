Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE316DE2D6
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 19:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjDKRla (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDKRlR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 13:41:17 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A90359CA
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681234833; bh=CoX/1kMuppKD03pjH1ilRnYMKCAkeOsMHAIAIKVvjIQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=m85RXdslqAXGZiL2M+YsxJUG5nrrYFRYvrcCYdpesf/hDsiG0ZW/FAS7RYzFCstFzRSmNiLxnWu2dr3N0JN35ZuFjt/TGyxWmk0xgC9k1+0rG/w9PXXLFpbw8fDcs7VeJwgeTd/9ZsAkQ8D7kMagHCLwgqwW9hj2yTDvegGogd1WRpF8d0zg9NYHmhQnSpeGYPCMpcZ9/f45PVtiAQv8r3cIuLs4qnUDQ4K5/yeL2Dhm+PMBac74itOomZ2T5K4dWGbFJj+VZPtd6QQxd3/fxoNZBnKkHcxhsO25xr69nUt5UBla7RgkxjUArJFjBUy7vEYWUvy4iEQZq8BZSXqK0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681234833; bh=HUGy1sLYedvXwmVTmDWHp8NmtgMIN57UYhNvHWx4z7C=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Qmb9FJSB/KErmPlewtCtOEU+JwiMc+VK5I3Ys34A25wTBmhIX4UTR106v0CSLFPVy2Onp7lYLAVKw/CumVD+4GVBb3kqYjPFcRqy5yy6WqRs5lZ1DAObXKs6olXlREkF/ykGDpk5900EuqE9nd+CPjB2Ho3TlZlWAhHeOfNyrHtz/c+vTZNh8vAFGCKgacdhXhNKyYWJcA57QxunDrQxLrmpc/txhRMlDJJzY7IJYgcPMyUEg20278ZCxWjW1gvpWWIhnFfuIe34HISA3Vy/93N3J5Jh/DKpHaj0VofsbTG/DK2c2PdC9P0wHamftpGwZLAi/jWr3W6FrEkltR6fsw==
X-YMail-OSG: _xtNrbIVM1knc08DZaIJ1wawTHdIu4A9JWkXIpZhmZ29ODtpg5vL7E6t6BeKSux
 ZT7GS2rWPN_fIAZpo74xt5SlfJCs2vWQo3JUqqMrqNa0zgDIG71Cy7VXz0XVee.CEoBXaUkLeEEm
 svW3iFqnEjQNn65MDjmyo1MKwPkPQ8jq.T8zwCAnzKc.GRpvjz4Xi9YoXIv2TdDAs4HTsphcOE1a
 n6Y0TsFUN8FJWLtfOrerSl25F.UHRqUdY0jSOOX9nQokNVoWIQWixTPDKFaTKgzobFOcd_MV8uzf
 dMjbs5IlnXBxmTDWcdueUvFR3nkJCpNaaDXvn.W8YlVlBIfJ5K5gHnBh6A0RoPi051LafWHGgEbi
 sQgeeS62il8V2vnI.pum.Ymlt51CkEn04J4ipnZUDbAeM_iApexV.thx3.ogaE.wjrZbgbvmgdT3
 Zybkpp3plsGtga672RgVvLwu_8NwjzZRQN.rNmIPvkMcyKcRsdFKcjpZXxIMy.2LKU4JMAk3HQhq
 oo2t7ak5AqWwDToag3g18azi0iO_hbJ17OB_q_rZJUjIPEcsftbtNPX2BqN7TN6J4oUWVb3tgq.j
 dGF_uvdYIskK7VVzQ3ZmB961BY22xazow5yqKJ15qFk.mRyNYh4Zuk6hTweBF6cwDChgfgsrUJPR
 DlAdVgXRscW1fzG04t3eOQLI_mAdOpd4fw036HCadTXmHwyj1RVAW6QSIX3ZXUl_f7gQF6I6hJ9R
 nO2eVgtJ86a_gdLaT4daCMFHM_W4wXbL4w5xtUzNEW8JwwfPFROaZlxzCKWHU3IQ.UsvYO_Q_XUF
 xejfQRLMgLJgwSNCVOVWGQvs6T4z_P3ubOkTaEoylp9YxfIJ50CmF3DOj57A5toPe7tv.wvXOpcL
 LEHGrjRwOFi_mLMFPqlcrUr7thcdSO4JNLnz1sXVQGFHMG7CX4RdEQPB62fcAPVKM0RFtYZ94Vfo
 6aCGZyUPjJogBkVjOGc90mnCFGoPoBYhSARjuLHQ38fVEuDe1W5DnstJ_AreVcFhSMmzxsaX2SEs
 xB5C1PtNecXjixd7zY.MiHEb2bkEDFypS4kT1GBT9WAo8rTPI01qQ_VG9e8v1XEMSLjVDI6BoBSs
 Z6H3ucVfcYVxluiuZMtJqeOplWkYZgGNkZYfF7JWMjGXlaQ4hHni94AL6CLom8uYNUqWMM1I98_7
 Zb27.xiKLIF2P7nZPqujJlm9HzyBMtWiDDXPKD0XJKHhl7A46uWMpL84ffmmDDkXDPGpdBzJthjJ
 g.HorL.V.y3uKZsNKicb9T273De73o6xNn_LOSz9fazYJlFJ5HR8eemsU574LK9gLOmZqk4p3KdC
 D.IBOGKPUOD.s_MoIqoDNZg6Tnd4l_CMXpqbVCI2vJkDbXnWR7uq.7tP_hLE235R.7DUPlXzaZGr
 Lr53sR3Qoyk.ApXSz3GO9V_ZD4eRPEu8pTVYvHu70mTU55brijdUlQ4uaqc3nBbEbbu9QY2dwHTW
 3BDvYy3RvObCe64NI7RdhlfyggVWgSl8P.J71yfxD945kY8KlwjaJA.s1tNcXNGe9lglUEA3lze4
 JBBHQv75ON4yfh8I7zOKYPJFB.ZUxmubOH_sFoL.Sby0VsYJ4fg0CSkHvz3jsVIOe20FE3SNJlvm
 dhMUUyF77Tz._WX.Kfe2RwlxIHDehLGYy1nQjU9g44B7RFB97nn2ss3xjDSf8F.6ucveVLgSfuEd
 MIFtcloXlcNs3r.EpVEDF4XEkABnfNqS0P_LzhD0l3qEEdhHeD96QbIzDDKiDNber_2krxOnc9Jh
 Xq23zCD5Vb7zdskgumWkDUdVOXBNpQLYk63wzKADry5lsZPJwSiNEwBATOVYI1LhSE6behCYztGh
 1ISi5WxURs6e51pu_Z0lNU25BscX.V_3M158in8moEe0okkk7TtRTDDv69tCBCYFvFxwx33EJ8qG
 dz_6Ni1H0OvfmIx5RF49GIKuT9wEFFMtM3qlSU6nVFb6IOp5qlp6KOg80.3_XLJFTQTv0KVizRGs
 Big2TU.UOt6_LHAoxkoq3b4.b6VECIjXJZIPYFvQAGAMeVufNd0WVlsvma2.tO1hLT8S4oOLOo5H
 xRBQi7keKHTdQW9HAq8liw.NxzbgRxa35yZbDl0J8k5Pv9JSAYHOL_gJ6xnWG9E53yXw_pYeV7Z2
 RyifcxdiGI.hdywBZ_Sl2j.PNRTUEOB4lnlY.GDm8NKC1YXegarbXSqAoKpo3LqZuktryFWepjgc
 vNOGkfTFjtelGiBtcFL7Iv0MZThJ_oC4bDAWhxxIq0vOJVHqA1OR.m8e9m80wfFnClHzsdJZLV9K
 kCoNHkN.5_fRNDyvu_b7T847kWDCZT8sd
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 77ecec08-8f74-4683-906c-9a3d97c588ac
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 17:40:33 +0000
Received: by hermes--production-ne1-7dbd98dd99-znv4z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 250d474f6a917934edff60a5d255f833;
          Tue, 11 Apr 2023 17:40:30 +0000 (UTC)
Message-ID: <e753bbaa-36f5-2067-d6b0-00e9865e8d9b@schaufler-ca.com>
Date:   Tue, 11 Apr 2023 10:40:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
 <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
 <e65b6ea91d66b78c382acdec14003d3665fcfd3e.camel@linux.ibm.com>
 <64d8dcae509beca4cd763acb148d2665b805ee6e.camel@huaweicloud.com>
 <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
 <6c48e6df58e9762607cf7f8287cc95f6a161c064.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6c48e6df58e9762607cf7f8287cc95f6a161c064.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/11/2023 10:25 AM, Roberto Sassu wrote:
> On Tue, 2023-04-11 at 09:42 -0700, Casey Schaufler wrote:
>> On 4/11/2023 12:53 AM, Roberto Sassu wrote:
>>> On Tue, 2023-04-11 at 03:22 -0400, Mimi Zohar wrote:
>>>> Hi Roberto,
>>>>
>>>> Sorry for the delay in responding...
>>> Hi Mimi
>>>
>>> no worries!
>>>
>>>> The patch description reads as though support for per LSM multiple
>>>> xattrs is being added in this patch, though lsm_get_xattr_slot() only
>>>> ever is incremented once for each LSM.  To simplify review, it would be
>>>> nice to mention that lsm_get_xattr_slot() would be called multiple
>>>> times per LSM xattr.
>>> Ok, I will mention it.
>>>
>>>> On Fri, 2023-03-31 at 14:32 +0200, Roberto Sassu wrote:
>>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>
>>>>> Currently, security_inode_init_security() supports only one LSM providing
>>>>> an xattr and EVM calculating the HMAC on that xattr, plus other inode
>>>>> metadata.
>>>>>
>>>>> Allow all LSMs to provide one or multiple xattrs, by extending the security
>>>>> blob reservation mechanism. Introduce the new lbs_xattr_count field of the
>>>>> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
>>>>> needs, and the LSM infrastructure knows how many xattr slots it should
>>>>> allocate.
>>>>>
>>>>> Dynamically allocate the new_xattrs array to be populated by LSMs with the
>>>>> inode_init_security hook, and pass it to the latter instead of the
>>>>> name/value/len triple. Unify the !initxattrs and initxattrs case, simply
>>>>> don't allocate the new_xattrs array in the former.
>>>>>
>>>>> Also, pass to the hook the number of xattrs filled by each LSM, so that
>>>>> there are no gaps when the next LSM fills the array. Gaps might occur
>>>>> because an LSM can legitimately request xattrs to the LSM infrastructure,
>>>>> but not fill the reserved slots, if it was not initialized.
>>>> The number of security xattrs permitted per LSM was discussed in the
>>>> second paragraph.  The first line of this paragraph needs to be updated
>>>> to reflect the current number of security xattrs used, though that is
>>>> more related to the new lsm_get_xattr_slot().  Or perhaps the entire
>>>> paragraph is unnecessary, a remnant from
>>>> security_check_compact_filled_xattrs(), and should be removed.  
>>> I would probably say in that paragraph that the number specified for
>>> the lbs_xattr_count field determines how many times an LSM can call
>>> lsm_get_xattr_slot().
>>>
>>>>> Update the documentation of security_inode_init_security() to reflect the
>>>>> changes, and fix the description of the xattr name, as it is not allocated
>>>>> anymore.
>>>>>
>>>>> Finally, adapt both SELinux and Smack to use the new definition of the
>>>>> inode_init_security hook, and to fill the reserved slots in the xattr
>>>>> array. Introduce the lsm_get_xattr_slot() helper to retrieve an available
>>>>> slot to fill, and to increment the number of filled slots.
>>>>>
>>>>> Move the xattr->name assignment after the xattr->value one, so that it is
>>>>> done only in case of successful memory allocation. For Smack, also reserve
>>>>> space for the other defined xattrs although they are not set yet in
>>>>> smack_inode_init_security().
>>>> This Smack comment should be moved to the previous paragraph and even
>>>> expanded explaining that lsm_get_xattr_slot() will be called for each
>>>> additional security xattr.
>>>> From previous Paul's and Casey's comments, Smack will have just two
>>> xattrs, assuming that security.SMACK_TRASMUTE64 can be set in
>>> smack_inode_init_security(). I will change this part accordingly once
>>> Casey can have a look at the function.
>> To be clear, Smack may use two xattrs from smack_inode_init_security(),
>> SMACK64 and SMACK64_TRANSMUTE. SMACK64_TRANSMUTE is only set on directories.
>> SMACK64_MMAP and SMACK64_EXEC can be set on files, but they have to be
>> set explicitly. A file may have three xattrs, but only one from
>> smack_inode_init_security().
>>
>> I'm looking at the existing Smack function, and it includes checking for
>> the transmute attribute. Your patch seems to have dropped this important
>> behavior. That needs to be restored in any case. You can tell that you need
>> to include the SMACK64_TRANSMUTE xattr if setting it is detected.
> Uhm, I think it is simply omitted in the patch, not deleted.

Oops. Right you are.

>
> I just sent a draft of the modifications required to set
> SMACK64_TRANSMUTE in smack_inode_init_security().

Yup. I'll comment on that.

>
> Roberto
>
>>>>> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
>>>>> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>> ---
>>>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>>>> index c2be66c669a..9eb9b686493 100644
>>>>> --- a/include/linux/lsm_hooks.h
>>>>> +++ b/include/linux/lsm_hooks.h
>>>>> @@ -28,6 +28,7 @@
>>>>>  #include <linux/security.h>
>>>>>  #include <linux/init.h>
>>>>>  #include <linux/rculist.h>
>>>>> +#include <linux/xattr.h>
>>>>>  
>>>>>  union security_list_options {
>>>>>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
>>>>> @@ -63,8 +64,27 @@ struct lsm_blob_sizes {
>>>>>  	int	lbs_ipc;
>>>>>  	int	lbs_msg_msg;
>>>>>  	int	lbs_task;
>>>>> +	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
>>>>>  };
>>>>>  
>>>>> +/**
>>>>> + * lsm_get_xattr_slot - Return the next available slot and increment the index
>>>>> + * @xattrs: array storing LSM-provided xattrs
>>>>> + * @xattr_count: number of already stored xattrs (updated)
>>>>> + *
>>>>> + * Retrieve the first available slot in the @xattrs array to fill with an xattr,
>>>>> + * and increment @xattr_count.
>>>>> + *
>>>>> + * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
>>>>> + */
>>>>> +static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>>>>> +					       int *xattr_count)
>>>>> +{
>>>>> +	if (unlikely(!xattrs))
>>>>> +		return NULL;
>>>>> +	return xattrs + (*xattr_count)++;
>>>> At some point, since lsm_get_xattr_slot() could be called multiple
>>>> times from the same LSM, shouldn't there be some sort of bounds
>>>> checking?
>>>> From previous Paul's comments, I understood that he prefers to avoid
>>> extra checks. It will be up to LSM developers to ensure that the API is
>>> used correctly.
>>>
>>> Thanks
>>>
>>> Roberto
>>>
