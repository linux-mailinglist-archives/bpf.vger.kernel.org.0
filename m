Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC862C7A4
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 19:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbiKPSaC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 13:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbiKPSaB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 13:30:01 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D814C275
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 10:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668623396; bh=NHUQvpQYr0Qj0gqXyR44REguG8S4rHXrKN2FlhJ3Ibw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=E9n5D5y3lQXK9qB96r7bg+rGteM4O62mxo7zV8BSjLuHFSlUl6zMWCqVpHBBt77K09cphVqJxfIh8dd6eZ+RougMIpSnxad6z095Vy0l4AXMnm6M9OLrEZXfRAsvDCUe/YoCH6s/Y1o14SebKwa6G/xSOh1c7VsvRZLIPgG/1apvs852dkds0ApuHiTdWiY0zgWVZ9kQ61nuAUCd6+lr/FZ4Y5G8puuf/zzbFSCmOb17EL7SmCj95NYbfzXx/y75x2FkPUhoP1WkwUYbi33N7HzK9TAjBvRvnadbLMJYr3uFMJ1Ee8lcFbg9vE7Dq5tzcKSTASmXUIAIM4k3SdI84A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668623396; bh=VR63XfpKqSpEsPvTZ24jmEnVQNKDJhk27deLKbv2c6a=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kOvD3JWgGztjdDIwK/3BjkPhya4lIHL35yL9f9P0aPOTzydLFYAaT5UnOmsoXvTkNh8NCymXBKSFkEoqzi/0QjD3ZeYadKrzjvY/CVuAy/sKfl8gcPm7PGzvLrk/ayNweh/BnGAaWHWhr9zEnrqK7o3QXgT7PIIc9HCydwBgAzIPpGrIlY+ZBMCmG43kw4p9BGMyQit5h5TSDQe1QmCbmWt4jgNRAPJ9XumYOXFqi3AJjRqgrjA7xlbN6SdzXz6GsizVRdmr6rQupzSwUHoWpY5vfrBluVVIyUEUl/gHvibR3wuK5VuyYnoXq930hxZPy3vnen3TEKN3M72o2qn4Fw==
X-YMail-OSG: FL1LeRUVM1mGJlmn.3Gqb.MqyKlt0DARDUb7sDut53byJr6O3GT6lvxAQKddjS0
 tG8iAc0jqqWsBGkzfHczm5OES0CSmrjiFjzXxXyhu7LiDUsMWvIS9ytoq9seb0ujiU6wjnH_kf4Z
 ReU1ScAJCOWFAwgpILVEWaRLFAozVC98Zk3vwIbUXcZLBvxYdDDLaEE0uzENnxWKRLEZHZid_XAJ
 2T4Sv9Wm8f.BXi2M4K.xGt5Z55xTrbEW0b3ONWNAMV.SeW5ppBMP9gS3gtjFLJbBBg20IO5wLfZE
 yUG8oiOKVzvLRYS4bgOb3TrGUKix9LAqGzceHor7WguGKxoN_bQtJtYKs0GGZ9t6uiSdrgXxAZ1v
 RTG8Lo.SZbztTkBNI7Sttoc.iXPLe7E2x5zUYrTrKW8bXM6_UjFKP_fwVL2.OgukognTsbj1cRwI
 uELnyRFDCC0qiEIWI.sy1tD1Ekq_OoMWDBRWL0hQqKSv95H.cwzWKH.WtM2qraHTaFDB9pvceaE.
 CcI5.R1JjjazuPp16FTYZiFVFdVHSQuwiDrLAHJhf7WbH11LoNV962oO2H9tPebodraNv__67qoj
 qHk5EHu9yhO33atU0RsW65GUj2jrgveQ5LnzGkTRh9YVCde4q9VXnDI2Cf_s7uh_SJniaRfQzctb
 bsCHB5HcL6NkHVb8B266udCgKag4_1zjR8h1aQsLLzT1VnhPINfFf6LHJOknNArwjA5T_kyHto3D
 78Tp2xs2uD_Jj2gkZHeX1hwKnj2uzr87b8OhqjRogJFrdJCewQXvdPtTZERFPgcuV5g920QOakJn
 sPeHqdE1VJotiF1fBCNM_6MQMWbmMXH67tsiL6H3S5Fbr49lMaLcG3PfibvF38fGUV.F3J2g9UHk
 f0Gr9bWXWh38D1q8TO9kHyMHEgLvqxrQVY6IFIDL3jbjqRRULskyRKVg0wItNU1oQmCQOqCG9hbH
 dnIduZZRbq3Fms3duSMKNmFX1ZWCV3ci1CO64_0fyx_zkkqbw4dCjr53Kfie2BuVcqf9kcJW27vl
 1.FUFmhFRPIYsgkEnRXlW6rds9chKOh92ii5jZvn.s9H0HMCCXxbPA1C0OL46WN_RaHCXc_LfQUp
 6ng9RntWtN2aPNt0v7J_cG888W1HuU1bDiPaqLmpl7ymKM54vKm3M2eB6HwLwN7efg_k4YutI7Wr
 E.fEGBe9aq93S9NRr8SZITRVrEO5Dhp2W0jJrx0Ah_KhZ5SjQOVLjcSutxLBgXYS8Flii_JGxq0_
 TTOQJLXqzUSBTmG_AEdGLdwGeXnSKX0vgG.vFx1d3YY3FguClAeiVF8Y8MKlbubPtIrZfY3tnTD8
 3wpuxn7k40cLZARZfsR.FfSXy.2nRg3JzW.0iYbuzoJ2qrSnDdNTjYQ_Qy7mA4wMC6yjMzzR8_xD
 9wlJRwkHyEqg1Lyo1orRiaJefE64KEkJBMdXRLyfWw4hROOLfSwydqnxhfWr07cS2OELvQh3QLdN
 hasS.DaXNRLWYS.xV_aSmTHprMmAvzYgQhAyxanIFpaWV4QVWij3uJTROAxHfuvEPLHVCudy.0tN
 JMIjHyEn5Fef7hs1lU9BaIg_4oFUC_N1rNA1ETlexuztJE6vxqnqC9mmwp00zLTR0Xvp0x95Yoga
 rZoh0fnqJwXX0GxU.s2VXoNhjWfB557aN1Uxdu56h5bpu2PHFUiAo_4eI_aCI2vpQRnvT2XT1RSN
 US7DHw7pj9TvN0.ei1GMtdLzkKR_XbWStOQzc956x.iv4p.iM0wY7FfhCQys9KEF6oQVHQGmiWfo
 xkWsRYtPTQy9lly3W.l7qIZUgS4iLdPArGmuFVCvJVgU5n4WJ53iljn9AMFBjT.vkiW6RsBhDDD_
 hjFz1jh6JyD7716Q2XM_JTtBaWWFSY5ug3e2H7CEiBGSnASw_O1tbiN3N3CqRy7iKJ9KXbgDlB5u
 qgv9bhZ0dkQrbRAj4Uy6V.fC8FVNzdgoVtTf64mMEfwiEryUjqNbtnJHrxLYkjzb.RmNQBDdKbQQ
 rs.n3EFOGqslWJwj8G4rvk8JICiPCA2HhTalrUqWYaugQNoYcL4cMs8ttZAQPMXbEoDpH2z_gKEN
 is2gHS9Qkzb_X0qBxn62jc2Yx1ZDMzjC8ANhYVb1buRv5FKD0S94Bbp..QZ9F5yflFnDw88t9E7R
 ZWUMD52PP8a.yVvVtd2aqxPePTVpJy5qcgNl7EMBqAzbOGgcsvcVuA7gQqsakLB9cab6x5_5wmPE
 jmF50GAWnm9ziboScX49gdQK9YWZ5fvqLn59UFRj3LFAZSwPLrqoi1ZAnN7518fNWUA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Nov 2022 18:29:56 +0000
Received: by hermes--production-bf1-5878955b5f-kkjj4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2101798ae56b406ede834f14ec72bf34;
          Wed, 16 Nov 2022 18:29:55 +0000 (UTC)
Message-ID: <2430b157-9ef9-2465-a9e4-d117d421566d@schaufler-ca.com>
Date:   Wed, 16 Nov 2022 10:29:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PoC][PATCH] bpf: Call return value check function in the JITed
 code
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
 <20221116154712.4115929-1-roberto.sassu@huaweicloud.com>
 <CAADnVQLQswvu3oGyeevLrKMT200yD4hzCbkBUAs=1bKSDVaOQg@mail.gmail.com>
 <05bf553f795ac93ea3032cfc1b56ca35fd6a920a.camel@huaweicloud.com>
 <CAADnVQJu7isDCi4+f8s4LfiwcYJbN4kXkvgJ8+ZnsS+QGDVnMw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAADnVQJu7isDCi4+f8s4LfiwcYJbN4kXkvgJ8+ZnsS+QGDVnMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/16/2022 9:55 AM, Alexei Starovoitov wrote:
> On Wed, Nov 16, 2022 at 8:41 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>> On Wed, 2022-11-16 at 08:16 -0800, Alexei Starovoitov wrote:
>>> On Wed, Nov 16, 2022 at 7:48 AM Roberto Sassu
>>> <roberto.sassu@huaweicloud.com> wrote:
>>>> +static bool is_ret_value_allowed(int ret, u32 ret_flags)
>>>> +{
>>>> +       if ((ret < 0 && !(ret_flags & LSM_RET_NEG)) ||
>>>> +           (ret == 0 && !(ret_flags & LSM_RET_ZERO)) ||
>>>> +           (ret == 1 && !(ret_flags & LSM_RET_ONE)) ||
>>>> +           (ret > 1 && !(ret_flags & LSM_RET_GT_ONE)))
>>>> +               return false;
>>>> +
>>>> +       return true;
>>>> +}
>>>> +
>>>>  /* For every LSM hook that allows attachment of BPF programs, declare a nop
>>>>   * function where a BPF program can be attached.
>>>>   */
>>>> @@ -30,6 +41,15 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)     \
>>>>  #include <linux/lsm_hook_defs.h>
>>>>  #undef LSM_HOOK
>>>>
>>>> +#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...)   \
>>>> +noinline RET bpf_lsm_##NAME##_ret(int ret)     \
>>>> +{                                              \
>>>> +       return is_ret_value_allowed(ret, RET_FLAGS) ? ret : DEFAULT; \
>>>> +}
>>>> +
>>>> +#include <linux/lsm_hook_defs.h>
>>>> +#undef LSM_HOOK
>>>> +
>>> because lsm hooks is mess of undocumented return values your
>>> "solution" is to add hundreds of noninline functions
>>> and hack the call into them in JITs ?!
>> I revisited the documentation and checked each LSM hook one by one.
>> Hopefully, I completed it correctly, but I would review again (others
>> are also welcome to do it).
>>
>> Not sure if there is a more efficient way. Do you have any idea?
>> Maybe we find a way to use only one check function (by reusing the
>> address of the attachment point?).
>>
>> Regarding the JIT approach, I didn't find a reliable solution for using
>> just the verifier. As I wrote to you, there could be the case where the
>> range can include positive values, despite the possible return values
>> are zero and -EACCES.
> Didn't you find that there are only 12 or so odd return cases.
> Maybe refactor some of them to something that the verifier can enforce
> and denylist the rest ?

Changing security_mumble() often requires changes in either VFS, audit or
networking code. Even simple changes can require extensive review and
difficult to obtain Acked-by's. It may be the correct approach, but it
won't be easy or quick.

> Also denylist those that Casey mentioned like security_secid_to_secctx ?

Identifying all the hooks that could be "dangerous" isn't an easy chore,
and some of the "dangerous" hooks are key to implementing classes of policy
and absolutely necessary for audit support.

