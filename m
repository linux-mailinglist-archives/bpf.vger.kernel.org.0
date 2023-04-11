Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3716DE129
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDKQnL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDKQnK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:10 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E6199C
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681231386; bh=kbuXP04/d4J/zBFq0sBCEVloCxLuyRQ6S4W2lvhk08Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XUC+Tw12UuxdrOm5IZzAsF0iK4GJtUGCj39gBNERGOG85X5/mA2XtSaazKxlD1NPtfXzsj8ATMQhryEPH5hvRzptf92BUWoPbwFx1W3ujZ98Q/lQ1EhtlB9glOWUD7sY18YkncFCG9KpUz88bRb8u+LKS4EohL29coKA1rCXmLU+WHrKB/JFKWxChxlyScweQkmwV1LLEkcfWRARTMyC/3iTfxjukaYP4dBuvhhDVFxwb7VOcxKnwwKIaB7eT5BcCH+05aXJXejJJ0SJo5gy03q151BN4sot415xO6BCb4uCHPIJDiiLIeMpUpcGqHfhprWQ6WjUGI/xFcVOZ2vyVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681231386; bh=pxmLraZoweNJqwnhja7+1CJL1iL0dqvd27PaPEyV2FE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=O1xgW+kymxFGs1Jdol2N1TSy8bOYsU71i3HX5OEHEM0CqwFka5tRff8pYgJOLH/aMt7sb8h7KMGY+KlYRjQ8k6FVmaVPthJXI6oyODtOCzvALxXhfEQ+xofqhlDnPHlqIz0U6VffMEFm8yHvutwP24Hvi/06cKdLkulwpp79eOZUoAFh417CxFWHbjqq8cWNsOMN1C5kJ2OoyNIKHbbJT6XIvuThc0PbaAaulLGGXI4dL1ZCgPEupFU/fqE3H60c8oU4x0H1+zpsJRkpdQucOPPYDiwujs3sZGmH++pYVJheMvdR/JJfzyGHrplWhpKowdlPzL31OeS36zpgO0f9Lg==
X-YMail-OSG: MQ885NoVM1mxebdkX9ARxQfN_PRBiYbQY7GKOz8bdf9fejqh.xBhuX6JVzs7Amf
 ZTZ8lwcxqSPIX2Nagi6Kq630_TAImvS2h9LZsONcg8ZlqSrjIg9RLvz_C533rpNUL5IQqc1ygVU8
 unUXWdsRpfcKxlSGQFBfaRXR1u5XXVcY9DTyC1cDVsP1fPChp7XKlZotVym0ehkNWVW1lqjA.8yS
 FbFBv9LSG9igJn29Y3p8OMjNZOv97cZxDWJymWhiJEoJL5YE3pPwPM84TRfgF3GqWzmpLNEEBQh9
 _l4RtqhOSYqWhD5_QjSYsMhxoAPf9HnLJTYU6_H4sjS861JCmKYz1BVe5Ia4lzRSiStzymJ5on4K
 sVOhEEPlKzOh_kIVuA8rEX.UiOnF2vdO1QdmJOamIUmESWhGuBEbwCOrR.CMPZDA301Ss.Xx9FOx
 _rmYXwcdPnxCveTwUeBw78dMu7HABfBvIJzJICDh4GD7PhDauc4IcX5cVQmofj9EUYr4MgzQNFK7
 Q1TxYDWbuf_ygNxg9oAZj3_yE9rFCBdAHfJ7gQP7WyBwNNF.VAffFa76P0.RYsW8HXqRsGcxdLxz
 3M_EQAiU.nL2RSwP7Z8bbU8JDUecQPQNxYYi6jBpNEeY1QwYsdBtSDxPHAmZl5H1ByNVN7gj0kQL
 f4nrIOfKEyG1raDfOb2Kd021Gmi_H3hVQWrgxNmzNTO90DlrME.ou0.8CJLJPav_GtxXkIV4BRYD
 gDipSU6OK5th9nFx_TyzosXhMBrtYNTJS4B1NXkqpknwhobhLl_Hvy8GRhOqjU_Udw2.5.s.uXDc
 SmTr8aokXIbp1LZVVA4EcmeeQIYXjI5VW2QyMGNoGMRhL0ADu.Q2Y5O9SD6DWC7uW_tecIKRFEvk
 YBKaMpr4QPrZFQcyzxrPhZfHBdn.TYCSnxoNcOqI5Zl6zrnCM4lG9dRl7V.KeBVbWUDDCUrj84mj
 x8hrCCiMOUjxU9FVEc8yrHPTrS1uQo1pryyDm4HF3eHwG_TwAV20zENMGrins6rl2LDKHyAghZtL
 3sEL7rzc9FCmpzsU9xt8dwoNPCLoc5EC_.F6wV_VCctnDfmNih67ci4F3f65xivR_LWmO24Neu31
 og.6u7iVevtjviuvnDfXXlEyLRiTKPmfv5SDH5.ZKXRd2EEbk8350Xf2lMGrdUw3Ql4hk2rs4vyb
 aSph67ESHrxRROWtNd85c7ql7JvQ4Zn8_jssD4HqE_E0LDYBgVNonLa.EQui3t6cJm9eJK2pyeGj
 f3rSC8BqBicUVjvOqUSmTt2U0XlNJ.jqhKhFDmoYsXGixKJoxTXjX_rh4X3cjeW1bHVLQQjGadGS
 Hmo2bEs4.F0XEFr7JaYktx0wznIB6RVzmygvzxqGtea94SHpKzslbDmHn.4esrThUHhN6oe2aTT8
 tBgSm0ZmU5pjF7PMH2knR5AYpHTYXC_QXPHiGn2mnGBrRehQ.KDYHfH0tWYhxIw95PlLSUMc6sFV
 HHq2OXni8OBUFeywlZvb8evZ60Zj0wgVoMKIRrpx_MPD7z2A70nR4L20lh_mbqQRakH0.vM6KFQL
 15TrxlZ17bNfJbpic4ESEug74WD9vrfsXn9AEEo7ZnxZMRcjbvPTpyJ435ZccaW.7vSyBbFDmijj
 EX6NiSmaLmdmpbDwO7Qonqf_6W5OlL3L6QQ49EGlCvWvxGfCyai5BbuUy_c.RBzG2hAzH.7Z_4tb
 ZVhica_wKjpVLopMAIzaNShrbBhEo6FH410u5h9movye0IE6kDHUZpSRMH4alCTCZjNR4hA1YaAr
 xqLdiwBaxM3NTFiYVaCMHEw5DvOVAUAA3rq17Dwqhvj2H6p3.tzCa7YBXvCMgsF0gP84QVk0cPib
 La4WPOV4Skpzrs6Ex5KcU2.7xPPJ2YihgDzpNVJQZOjMBSl9clzy6pxMr_dXRBFzA.q7r0_oswcY
 E8H60FtP5CU61lrLSMaGQ1nQmzPOIq8JreBCRgIhcTrISYwOqCyjaZzPtZUL1Pz1AsNS49BeLSRZ
 g1tT9Fgp4SqLjADtqwqg9EvFab3DyPuVoP0zk1F49Op.dRoVXSmIERkRHC.Itn9ColKerh86ddfG
 kgvTirRpSktuhsjURt0G72jvWi2S9jUQofM3dPNNMO72XCdbjUiywZtCUjv5sRHyHwY9k94JdrIB
 DE3RMDLdVORBVi1V6MlgxHyZXgSUi8YIvGt4L5JA.R6nQ7XI29gbeYhc2BRdrofdMVK8m35mCyF2
 8Y49ne7MtRMZxbvPc1qtFxC7WyNuRQsOwZ7CLLZ1dL9dwfMxFEQUJLhB3QdOtqXkvcgfA8c28XLn
 SgkJkUAgz8a34deYqXSySRwKoxm11623A
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3f153f18-f280-4344-9673-aa6e14977376
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 16:43:06 +0000
Received: by hermes--production-ne1-7dbd98dd99-7dkf6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID caefbefbe2cac6bdb238356981a38ca4;
          Tue, 11 Apr 2023 16:43:02 +0000 (UTC)
Message-ID: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
Date:   Tue, 11 Apr 2023 09:42:59 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <64d8dcae509beca4cd763acb148d2665b805ee6e.camel@huaweicloud.com>
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

On 4/11/2023 12:53 AM, Roberto Sassu wrote:
> On Tue, 2023-04-11 at 03:22 -0400, Mimi Zohar wrote:
>> Hi Roberto,
>>
>> Sorry for the delay in responding...
> Hi Mimi
>
> no worries!
>
>> The patch description reads as though support for per LSM multiple
>> xattrs is being added in this patch, though lsm_get_xattr_slot() only
>> ever is incremented once for each LSM.  To simplify review, it would be
>> nice to mention that lsm_get_xattr_slot() would be called multiple
>> times per LSM xattr.
> Ok, I will mention it.
>
>> On Fri, 2023-03-31 at 14:32 +0200, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> Currently, security_inode_init_security() supports only one LSM providing
>>> an xattr and EVM calculating the HMAC on that xattr, plus other inode
>>> metadata.
>>>
>>> Allow all LSMs to provide one or multiple xattrs, by extending the security
>>> blob reservation mechanism. Introduce the new lbs_xattr_count field of the
>>> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
>>> needs, and the LSM infrastructure knows how many xattr slots it should
>>> allocate.
>>>
>>> Dynamically allocate the new_xattrs array to be populated by LSMs with the
>>> inode_init_security hook, and pass it to the latter instead of the
>>> name/value/len triple. Unify the !initxattrs and initxattrs case, simply
>>> don't allocate the new_xattrs array in the former.
>>>
>>> Also, pass to the hook the number of xattrs filled by each LSM, so that
>>> there are no gaps when the next LSM fills the array. Gaps might occur
>>> because an LSM can legitimately request xattrs to the LSM infrastructure,
>>> but not fill the reserved slots, if it was not initialized.
>> The number of security xattrs permitted per LSM was discussed in the
>> second paragraph.  The first line of this paragraph needs to be updated
>> to reflect the current number of security xattrs used, though that is
>> more related to the new lsm_get_xattr_slot().  Or perhaps the entire
>> paragraph is unnecessary, a remnant from
>> security_check_compact_filled_xattrs(), and should be removed.  
> I would probably say in that paragraph that the number specified for
> the lbs_xattr_count field determines how many times an LSM can call
> lsm_get_xattr_slot().
>
>>> Update the documentation of security_inode_init_security() to reflect the
>>> changes, and fix the description of the xattr name, as it is not allocated
>>> anymore.
>>>
>>> Finally, adapt both SELinux and Smack to use the new definition of the
>>> inode_init_security hook, and to fill the reserved slots in the xattr
>>> array. Introduce the lsm_get_xattr_slot() helper to retrieve an available
>>> slot to fill, and to increment the number of filled slots.
>>>
>>> Move the xattr->name assignment after the xattr->value one, so that it is
>>> done only in case of successful memory allocation. For Smack, also reserve
>>> space for the other defined xattrs although they are not set yet in
>>> smack_inode_init_security().
>> This Smack comment should be moved to the previous paragraph and even
>> expanded explaining that lsm_get_xattr_slot() will be called for each
>> additional security xattr.
> >From previous Paul's and Casey's comments, Smack will have just two
> xattrs, assuming that security.SMACK_TRASMUTE64 can be set in
> smack_inode_init_security(). I will change this part accordingly once
> Casey can have a look at the function.

To be clear, Smack may use two xattrs from smack_inode_init_security(),
SMACK64 and SMACK64_TRANSMUTE. SMACK64_TRANSMUTE is only set on directories.
SMACK64_MMAP and SMACK64_EXEC can be set on files, but they have to be
set explicitly. A file may have three xattrs, but only one from
smack_inode_init_security().

I'm looking at the existing Smack function, and it includes checking for
the transmute attribute. Your patch seems to have dropped this important
behavior. That needs to be restored in any case. You can tell that you need
to include the SMACK64_TRANSMUTE xattr if setting it is detected.

>
>>> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
>>> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> ---
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index c2be66c669a..9eb9b686493 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -28,6 +28,7 @@
>>>  #include <linux/security.h>
>>>  #include <linux/init.h>
>>>  #include <linux/rculist.h>
>>> +#include <linux/xattr.h>
>>>  
>>>  union security_list_options {
>>>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
>>> @@ -63,8 +64,27 @@ struct lsm_blob_sizes {
>>>  	int	lbs_ipc;
>>>  	int	lbs_msg_msg;
>>>  	int	lbs_task;
>>> +	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
>>>  };
>>>  
>>> +/**
>>> + * lsm_get_xattr_slot - Return the next available slot and increment the index
>>> + * @xattrs: array storing LSM-provided xattrs
>>> + * @xattr_count: number of already stored xattrs (updated)
>>> + *
>>> + * Retrieve the first available slot in the @xattrs array to fill with an xattr,
>>> + * and increment @xattr_count.
>>> + *
>>> + * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
>>> + */
>>> +static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>>> +					       int *xattr_count)
>>> +{
>>> +	if (unlikely(!xattrs))
>>> +		return NULL;
>>> +	return xattrs + (*xattr_count)++;
>> At some point, since lsm_get_xattr_slot() could be called multiple
>> times from the same LSM, shouldn't there be some sort of bounds
>> checking?
> >From previous Paul's comments, I understood that he prefers to avoid
> extra checks. It will be up to LSM developers to ensure that the API is
> used correctly.
>
> Thanks
>
> Roberto
>
