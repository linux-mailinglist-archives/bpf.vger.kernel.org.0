Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0F6D88EA
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjDEUoU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 16:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjDEUoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 16:44:04 -0400
Received: from sonic304-16.consmr.mail.bf2.yahoo.com (sonic304-16.consmr.mail.bf2.yahoo.com [74.6.128.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2540B7EEC
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680727429; bh=o79+MK6dpUzZUQXvocZyHLwH3RptZrKXroxGX/4QlUk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ieE0DjEhftH/TEwvf/6S90sdZLDG7xCc4FtHlvMCrpgR6w0j7eEH4LMzborZxM+mBFWR5oRDukzLrojlh5dyWFKeS2MNW1UTxDM45tgNlCtKL/+lKvbgktp1QLFjIrwWgrMQD7NAeO/bYkto0FKEg2NCwJ5Nm5nTZErLXUl8o/XwfnCtx+xT3ZOE9+gV+SHQPRX+9xKCtLdGNA/CQqs0HCL03ojXwcjbaigHq3+9BKuTULiVhw2rT/4bYSO6e0aOsM/12jHhU6EquTNqVRB0pmHegZEMqCEJZW2/f3srgtSvrKhalh5OtspFcNJmftTyKZ5MQWHAh95XwlD4fu2QGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680727429; bh=k5D18lCf6ys6zehgqpmGHlf6J/sxe8IO1texY18gVOH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JJeZQJtNv+xp01noIOqtNc+ybpPIOtQByEi84rMElvG4I23OS6ziiy7jwg54BDdy1lolVlhNAaKLWjvyo2o7fPR0Tt/StVcC7GFKu9hA/0j5IeORKoVkqBIwfA4pTOSQuSHbf1VjodA1Fx6F9E7EOTHYZfY3SC3A4dZ7x3OHj1qSLlxLdwlBKkUzdP9WtagXrJo4j3P4d0skLBzb1QEHb6SO2jlKcJJSk0px2yqUvdYxvf23uQkYpMnu/0CHukZtTS44IDwxMbvbeFN/zWfyt/KDJ5v1nZkcJVvUgqbp3sdm8uY3fMMI9Amm3YfF/4BEAix9QmmC7NuYt0tvlhrO8g==
X-YMail-OSG: pGkYCcMVM1nXs1G3qp3EEk4uRDZUEogs8IkOwmZb7_E_GvwyQ0Mb7UP4ruFY7CJ
 SsexIpSaG0rHXiUxzB9Y8eAtsrwEnO6Go7TjAMX8cBwtlbInty.18CSPtyu.QZK3g.Vv8OIQNf8k
 viXyX.dmX8JxXGxMExcc6Z67JqdeSGdrxdwQnZHwyZbQMur0n_t3CbPR5HyYIYQh_GLHKM2daHlt
 TtJ1uQMs0ki1UtR0jTUYX4aLbfO0OGoOHY3bPjeauMyFWStQyryjD4PxL0wh7AmxY.S1KUQGk16l
 aWu4hcqdPc_oR5l41Z43v6LcAhcIwbIYlYN_0xUiXzMNWwrAjpEHO4XGruNbVRj3KGHhAMb956dB
 i6pIsbX_w64mDLxz9.otx279RxjnK7wGabSew5n4NzgNXgKxcrGm.OBhHNGhKAXvf_FzyxZP6XhN
 0.W3JtKOORDvR9xISzpLCfAvE4mgYowk1l_9m25LUXC77uWCFeYna9vmQLdsSbUJqpKoUFKMKeYC
 3MOd1podyV1EGZw0vGoI5jZcmxIRAyWU6OOVLfwxSYHc2DYuNbfmoe_AGczw8uJ7g72jW8qSQ_AZ
 8ZQpyzYSbf4JQw.JlZo_rs.Dtx5NUcGGu3t7aRhBuMCOfkWsPT9KXpl.Apbk4b9RXYJwIPGmClfN
 UCICJKPVGu1xj7ZtFDlZZnIOHWIWDvlkX2wGBOAtT.CvYsVNDThYu_0XxcbLIylNGsSxaFv6r95_
 NIvcOHfmdPMYGrXO_ha59nbUYkqSGKTZz_yEpgeXL6Pbm349.ZM78G1Nfwq4dsvleHgUbMHeusBH
 jjrJsBCaVUmT2EV03JdVRXLsnlMBrIiMGhYhnWB_IzI0Khj3kaSyHgWOIJrbOiFwOyMwI.3ZDD91
 ouQrErNw7zFua3HRwFXrXssOD36HQ0nHns_LDR.bvO3RjX53BsJvlMjYQvjuElDGDHIESlNQA1Bw
 SmSaaHw5CCVAcRfStZ9ue9PoApAREMP3PPn1WPVNO6bYF1MZ_JGZ0VdLXJkr2r5p08bg_ZK38YCE
 jBA4RPg3mQxG4I9OpPBvHBQvROsu4VtDUh7._o0otpQc_xzfOtT6SKtzxQfSw0ASMZqKMXZaIj6a
 yxWUmlG5cutIDixf.BSfLYPRbtJsjHm0FLRKzEaDpS0L5OFFqLX4evooHBayEB6OBtpuBhokYiQV
 CnF5E6I_lG_Zozjgm6GLWx5fyiFErB1F4WOObsaz.36PxAXR5S9zfijxoKCul_4NLpqLBMZ2Ze2D
 XBzBloXGykzjWPfWiyFS6sY.1kdUsp0zhMyQxi3TwUP3wN1UifZlJcGT3ZyLoZexOrdPfvu9Crwh
 rn_xXeFCh6kC5_Z3Wlh..Y7w.HDr_KhsPg_NoqMMOEeF8Ne5BYjzyfLKFaIvmTABmthZl741gWHA
 u9wS641YpGg49vDgPv0fE6cy6GqQVRu0jE3kV.CUbHl.1yip0CmP2D_mC56wIzUJ2MpOI98uQOfd
 HuS2P.pReMlq_a8LLhVmqVi5_6R_ohnQid5cM85iodrl3ry_B4FiRY2wS3OMQKAgCrwqksaSiEtz
 1Vjt4rfexQPocrz0kfs9_4mZxFdgRJl6GFqOjec3pSy6jyjVQScTG9TMnp_iTNsVc3GAuCu0aogB
 WK310mQzz7aESOLfhFDBY4beFzpeBjwxl_1ZJiUsJfWtLHUYREGcPU1Ags0jBqoxqJas4fVECoRS
 gOuqqdYZoGEWvQiWVNtYXLYUDTizHPRX4NDhL.CTl6DqqSu_gdvj2EngZ05QDARibIMpFt9opCv6
 lUObqtZ4gXn.bLyKZqmBmvP7zFVLlcjAFqzNYDBDD6fl03rpFYmmtT0ZsWp_amuJUTMicHrLodYt
 .nI0Th_XGrF8WLBEmidme5NbJwDPE1if3XjrhCfULE3ifaWYpjq2FJIZxmhPR0dWRtpCL9I6bVdL
 fyn0Mb_qG_QH3JKhKNqkX1z__KFFyE_xmRpoubIk_hMkKjKv13k_IS60zIuHaGyxlG43iqXtgFQO
 NltK.hVWiRG47fQ5_WHaz0DNq05Q.PjYYJ5y93MkFjqixC0VHTeNMyBIeNmAnzbyyaRtf3oyjelv
 YT7c54V7BiDcQrfDQYn70DQlKLXwItRReLbZ1N1VZTRA4FqLM12EMlCNn2s161BaeqZciUV84tA.
 A8bGh1qNAGeOMUUNdr_YHRxB3lreoUytRUpjbFH9HYWyRIHvWfUuXgQ5MyApiXSH2oahmQ5q05ir
 FGGm8kWKKOgTPO0l1Xl94GVfm5SGQN6WkxPqBe5RuDb1OsEScD5stzPfodTQs.AhzGhMPqtDctlf
 EWc787yi550Hd
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2e24c7fd-7294-401d-8e1a-0b8c9b02a20a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Wed, 5 Apr 2023 20:43:49 +0000
Received: by hermes--production-ne1-7dbd98dd99-t5dz4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f9cdb95437a94bd13984470700a1b503;
          Wed, 05 Apr 2023 20:43:45 +0000 (UTC)
Message-ID: <83ddfcb9-b4a6-71b4-a20c-62f484c8e040@schaufler-ca.com>
Date:   Wed, 5 Apr 2023 13:43:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
 <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
 <CAHC9VhSbGdij6xz9D49my37kD9qYrBmh2x7=cNFFDL2dZ=EZTw@mail.gmail.com>
 <5dbb9430-1e26-ec12-26a2-3718c84e33c2@schaufler-ca.com>
 <7549b624-421e-30b9-ca99-de42929354c7@huaweicloud.com>
 <CAHC9VhTsSUM6_g5+ZOqZ=P6307hCAJW+-xEc4fKQcymPs5pYjQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTsSUM6_g5+ZOqZ=P6307hCAJW+-xEc4fKQcymPs5pYjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/5/2023 12:59 PM, Paul Moore wrote:
> On Wed, Apr 5, 2023 at 5:44 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>> On 4/5/2023 4:08 AM, Casey Schaufler wrote:
>>> On 4/4/2023 11:54 AM, Paul Moore wrote:
>>>> On Fri, Mar 31, 2023 at 8:33 AM Roberto Sassu
>>>> <roberto.sassu@huaweicloud.com> wrote:
> ..
>
>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>>> index cfcbb748da2..8392983334b 100644
>>>>> --- a/security/smack/smack_lsm.c
>>>>> +++ b/security/smack/smack_lsm.c
>>>>> @@ -52,6 +52,15 @@
>>>>>   #define SMK_RECEIVING  1
>>>>>   #define SMK_SENDING    2
>>>>>
>>>>> +/*
>>>>> + * Smack uses multiple xattrs.
>>>>> + * SMACK64 - for access control, SMACK64EXEC - label for the program,
>>>> I think it would be good to move SMACK64EXEC to its own line; it took
>>>> me a minute to figure out why SMACK_INODE_INIT_XATTRS was set to '4'
>>>> when I only say three comment lines ... ;)
>>>>
>>>>> + * SMACK64MMAP - controls library loading,
>>>>> + * SMACK64TRANSMUTE - label initialization,
>>>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
>>>>> + */
>>>>> +#define SMACK_INODE_INIT_XATTRS 4
>>>> If smack_inode_init_security() only ever populates a single xattr, and
>>>> that is the only current user of SMACK_INODE_INIT_XATTRS, can we make
>>>> this '1' and shrink the xattr allocation a bit?
>>> If the parent directory is marked with SMACK64_TRANSMUTE, the access
>>> rule allowing the access has the "t" mode, and the object being initialized
>>> is a directory, the new inode should get the SMACK64_TRANSMUTE attribute.
>>> The callers of security_inode_init_security() don't seem to care.
>>> I can't say if the evm code is getting SMACK64_TRANSMUTE or, for that
>>> matter, SMACK64_EXEC and SMACK64_MMAP, some other way. The older system
>>> allowed for multiple Smack xattrs, but I'm not clear on exactly how.
>> If you like to set an additional xattr, that would be possible now.
>> Since we reserve multiple xattrs, we can call lsm_get_xattr_slot()
>> another time and set SMACK64_TRANSMUTE.
>>
>> I think, if the kernel config has CONFIG_EVM_EXTRA_SMACK_XATTRS set,
>> EVM would protect SMACK64_TRANSMUTE too.
> Ooookay, but can someone explain to me how either the current, or
> patched, smack_inode_init_security() function can return multiple
> xattrs via the security_inode_init_security() LSM hook?

It can't.

>   I'm hoping
> I'm missing something really obvious, but I can only see a single
> Smack xattr being returned ...

Smack is setting the transmute attribute in smack_d_instantiate().
The exec and mmap attributes are always set explicitly.

I don't know how the "extra" Smack attributes were obtained by evm
before, and I haven't been looking at how they're doing it now.
I have assumed that CONFIG_EVM_EXTRA_SMACK_XATTRS does something
meaningful.

