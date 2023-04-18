Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CFB6E5602
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDRAsK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 20:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRAsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:48:09 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A4F2D47
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681778886; bh=t5IImfKsNAgE1x/JhPy9n2LFqo3gfxyNFUnPHyKy/xE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=l65f+Xvfe4SLIfNHTG4RYy1uGYpc1z0JHSQf+3OxsRhVAyDJ3lCbt5rHEOsdBAJ7ciOk1EajMG2my/bZ1OnUZSL/tM5tlvxbdQNC1bPHLVBfOB1wQ0bANlJYjNeIp4sCP5uM12veXLJK7gydDpBgkklGZCOVSUt1mUqBCJ5GsvsoGGcmG2lNbeyZ438c21CU+7LpZ79y3JWZ1orkiuRiD/FswbLh8FNGEr5qFHrpDvtV+OGgM5OekUnrypI+SMrFFvymHnaWZAnvz7ewI0owF5xk1uUw7kRtW5bfdEEqmz34Z42D596r1OSMQdqtvUApD10M8uK/Dv9vRTv98gPfzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681778886; bh=S2ARxOZyuvtv3YtpjX9JOEdH0XjNrwMr/P4+53taLmu=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jHNcKp+HPg4d16N+ZBkF1i6WkADmo+CmkMRa2ew0Z7Owy/ateevaBwVAbiLkdH95N2dk9pUWM4Wctz22fLd3k1XNDVvRpFZt2xbui+TuWDfS1MQPBoml1gtIGEwwHQKr43OOJ6WI6jCiBMvSRY/CoriCNHe/QshZ3GhURyLL3pUjes18p5lHBd9NViw0bzS/6XBUppg6cbSX7WRtMwck1Wktjf6dfvSPzVeH6v+OVe/ZZs6fOE+jnsSKM2qabCBP7moUXxvtREXkwzU/QwZdjn/0yQi2JNyGUkaB1L7CpIoUH1LkZ2m3UJzhYVkY6Qf/bN3rc7Zwz0s+UIza3U7bUA==
X-YMail-OSG: .9ztuSIVM1lj66pvTf6vkNBJAGMt7yE.0IAJqIx7H9EYVtx3fJtSM0E10nl2C_s
 O4EE6vVKrB5r_aj6LZW0tdHPhbBHn4nup21HK4ciafB1.mpHlI6hbrS.ZFy.fkoWxuBn75n4Qv4q
 VfQ6M0qekXiknoRmJVoxwv9h28h9EbVGXZK8HH12PvuCmWczaxOexRgIfQZH2GYtZLC9HOb3c4vf
 i8ax5mDMeZ0gcO9SyUVd56i9m_xw_CwK6PxmG8oJ8UrFC6BDtSLZirPpupkqKqUn1LW34WOU11wq
 iOFSMKv76OHo_NPQBLPmRjTukiVkJ2yPIX4qTBCv0tl0D0WR0V.As19CIhjXWw6NRCvfNq4qrWpC
 dPx3hhiQxbBiVRoT2p7ghd6rndEwYUB2vRjDTvGAQGnpSp_HHnFAMbOyT51eijl2YtsRjvD5nvzj
 5vm4yo4D.rHjEb0Uf.ZjYjVXBBbxVb0T5.lCpIFkbs9mUCm8SCVkSpkwNi5lAHrgZC93Og4wSe5V
 k5SG6SQ9qNeJkP1lOcsDYOl_qZN8wzOCrKwvhPD463YROaf74K4w9rsaUIBMWMZ2Lrw.2MkfZnKn
 YbiDmFuSjn1M3u3vyvsDvIUQ.rio5oxU9_khHtmmGbNXjhTzptktl39M7_iJ0gmfT6Sdd.WpZTwc
 fxvx_DPC5Rv0LMkPGVRMGR.HwnSbtIMLyPV.damEz4SVxcsbY3qg6v73xS7qg3pSxu9ZSaRol4H9
 naYuPaGOvoCYkC2l7z_M_LD_tUenYf8ZzBOdelrMpS70rBgg0wFVG27HRHi7n6Txs754c2cMc6Jr
 mHOhgEUcNCVLCkhatrkugFGN1uTQ6SzpQI9EsAmYYFirEGTOfU8kPHD1dzigxTl31Q7RWAg6pDey
 so3HGKwmFziCfnKF8UJoqpUsnKuKfQP46.ZXgCh4d2DYcI3otXcCMp3msZPCrBq427FLnQsEC8wK
 xEhK1zup0YJjIFBaN_iQ_AvluO_q.Q0QszF.7wce79tlRW37TQn5oEnuj4z_sS_HzgdoEdqqMILo
 thIfHGGs3s3dpr7YybGvnU_cjv.fWscmYOLTjVVZYwsIPtBcPuzw4k9CmzUD2AkBwBL54k._.A64
 Q.6bfjf0MlybqP3skbqpzLY_AWuVFzS7rkn5VLU4JWIsT_csCv3PohUEPOU_nFKCOKGp0neS7owI
 nFzCiutfcNDjF31OWHAUIF..HfhNKOl_9utl2WaWixK8GB7AXgFuOJyk1jn1HbHBtA0IU80H3YHY
 JcRitkrMYMTiAaWPqEW8TmlbGvJpJ.GIU2wkwpsyQheiIqyuZgzrG2IkHAPYWmDKt6E.lIJ2BjbJ
 Dnb_T1tLL6YlsHCrVOPuVxjpVXOMHFv509j9G6jeR1fGHOCyICT3aGc2hAWe4Sh1Nqr.Ao2oj5bq
 bn5OmDjhkD0k9JlVe_bUT_fzHE7ws8YJv1wMognNBohnO0e4lE.7REVWGrAO1ZNMd9Uw0Xzq.YJQ
 SBgqK88XwpA3tKhAiKm56TPDTUb.3kkh19Y5JYIhKAIwIzHrOtBL.NMRT1vysnxz.o6Yd5m_pQ1g
 yqmyPoWYOGoxcogfsX.usfWDeD5xFrGY_nZ0CNeVYWwXAzLb4ghkQ9Gtm2x22Ht3gt740cfWcC8P
 PXvk8AspBxUeSBeJvdDn4Eof_hu1gmsrVFJKZilGT7hUMkpodn3vA2_OOfK5kGq6gGL_mhrp3F0k
 CdyyNCpFp7hwy2vp6mUpiLFpahxFTxdEuMqTRCZSw0kddRMxQ5qYnq50b5QEsVDhl7y5qR6q4IuG
 fIYX3.owM9fWf.lrIKCX2.xiB.hwYRM792I3obmrBjQdPnuoD5mM.edEUpWlGu_Z_8MybUFzyO0r
 bBRoAktRIomdkm8ghC9RZTQW3N6GzBJkfJZD5oO67BneeW7dRhPa_ddM4c_qKSszovf4Qv16hW6y
 DOaY3uuOa1agmtNlfV4_iuBg5M2s9v2YywWMNbmy4mvPFfKDfzRV64UwsKpi0OT8M1HD99DZO3rQ
 e4A6GWiyIaaTVFk9ceMFV_DoPXuTuizsqjv3Y8xZKJSakn6gObGXP08ffRJS7sSDmuOwHpNz_E0K
 HONCHQ0bqvMhyYQDOVHaJqNUKRQF09mA.Yb6bGCRH8dt.zNya23bd4PJs39ea1xltw6zj9GyWaH7
 q6mbO98BlX4.wFqU.dDEhhSy02R.CO4qPMnuLW1x9rP6bwQC6wp3c0m5NtiLZsOVScflCLFG_.A9
 Lup.eorw_akNSq0KhXzngo85rLFddgJxr4KJF9.e1LKRJJ3mUi.hqCQaYMXggh8gBiKYvNDrNhbj
 DbwvLBBC7QUGqrN8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3dc240a7-1758-498d-a5c9-ffa59599586e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Apr 2023 00:48:06 +0000
Received: by hermes--production-bf1-5f9df5c5c4-wvm2h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c4937ebdfde780413d33b9033972fa01;
          Tue, 18 Apr 2023 00:48:02 +0000 (UTC)
Message-ID: <ad70ee53-c774-6b50-33fc-d4568a3b5559@schaufler-ca.com>
Date:   Mon, 17 Apr 2023 17:47:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230412043300.360803-1-andrii@kernel.org>
 <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com>
 <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com>
 <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
 <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
 <CAHC9VhQFJafyW5r9YzG47NjrBcKURj3D0V-u7eN2eb5tBM2pkg@mail.gmail.com>
 <CAEf4BzZa26JHa=gBgMm-sqyNy_S71-2Rs_-F6mrRXQF9z9KcmA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEf4BzZa26JHa=gBgMm-sqyNy_S71-2Rs_-F6mrRXQF9z9KcmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/17/2023 4:29 PM, Andrii Nakryiko wrote:
> On Thu, Apr 13, 2023 at 8:11 AM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Apr 13, 2023 at 1:16 AM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>> On Wed, Apr 12, 2023 at 7:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Apr 12, 2023 at 9:43 PM Andrii Nakryiko
>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>> On Wed, Apr 12, 2023 at 12:07 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>> On Wed, Apr 12, 2023 at 2:28 PM Kees Cook <keescook@chromium.org> wrote:
>>>>>>> On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
>>>>>>>> On Wed, Apr 12, 2023 at 1:47 PM Kees Cook <keescook@chromium.org> wrote:
>>>>>>>>> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
>>>>>>>>>> On Wed, Apr 12, 2023 at 12:33 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>>>> ...
>>>>
>>>>>>>>> For example, in many places we have things like:
>>>>>>>>>
>>>>>>>>>         if (!some_check(...) && !capable(...))
>>>>>>>>>                 return -EPERM;
>>>>>>>>>
>>>>>>>>> I would expect this is a similar logic. An operation can succeed if the
>>>>>>>>> access control requirement is met. The mismatch we have through-out the
>>>>>>>>> kernel is that capability checks aren't strictly done by LSM hooks. And
>>>>>>>>> this series conceptually, I think, doesn't violate that -- it's changing
>>>>>>>>> the logic of the capability checks, not the LSM (i.e. there no LSM hooks
>>>>>>>>> yet here).
>>>>>>>> Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
>>>>>>>> when it returns a positive value "bypasses kernel checks".  The patch
>>>>>>>> isn't based on either Linus' tree or the LSM tree, I'm guessing it is
>>>>>>>> based on a eBPF tree, so I can't say with 100% certainty that it is
>>>>>>>> bypassing a capability check, but the description claims that to be
>>>>>>>> the case.
>>>>>>>>
>>>>>>>> Regardless of how you want to spin this, I'm not supportive of a LSM
>>>>>>>> hook which allows a LSM to bypass a capability check.  A LSM hook can
>>>>>>>> be used to provide additional access control restrictions beyond a
>>>>>>>> capability check, but a LSM hook should never be allowed to overrule
>>>>>>>> an access denial due to a capability check.
>>>>>>>>
>>>>>>>>> The reason CAP_BPF was created was because there was nothing else that
>>>>>>>>> would be fine-grained enough at the time.
>>>>>>>> The LSM layer predates CAP_BPF, and one could make a very solid
>>>>>>>> argument that one of the reasons LSMs exist is to provide
>>>>>>>> supplementary controls due to capability-based access controls being a
>>>>>>>> poor fit for many modern use cases.
>>>>>>> I generally agree with what you say, but we DO have this code pattern:
>>>>>>>
>>>>>>>          if (!some_check(...) && !capable(...))
>>>>>>>                  return -EPERM;
>>>>>> I think we need to make this more concrete; we don't have a pattern in
>>>>>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
>>>>>> Simply because there is another kernel access control mechanism which
>>>>>> allows a capability check to be skipped doesn't mean I want to allow a
>>>>>> LSM hook to be used to skip a capability check.
>>>>> This work is an attempt to tighten the security of production systems
>>>>> by allowing to drop too coarse-grained and permissive capabilities
>>>>> (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow more
>>>>> than production use cases are meant to be able to do) and then grant
>>>>> specific BPF operations on specific BPF programs/maps based on custom
>>>>> LSM security policy, which validates application trustworthiness using
>>>>> custom production-specific logic.
>>>> There are ways to leverage the LSMs to apply finer grained access
>>>> control on top of the relatively coarse capabilities that do not
>>>> require circumventing those capability controls.  One grants the
>>>> capabilities, just as one would do today, and then leverages the
>>>> security functionality of a LSM to further restrict specific users,
>>>> applications, etc. with a level of granularity beyond that offered by
>>>> the capability controls.
>>> Please help me understand something. What you and Casey are proposing,
>>> when taken to the logical extreme, is to grant to all processes root
>>> permissions and then use LSM to restrict specific actions, do I
>>> understand correctly? This strikes me as a less secure and more
>>> error-prone way of doing things.
>> When taken to the "logical extreme" most concepts end up sounding a
>> bit absurd, but that was the point, wasn't it?
> Wasn't my intent to make it sound absurd, sorry. The way I see it, for
> the sake of example, let's say CAP_BPF allows 20 different operations
> (each with its own security_xxx hook). And let's say in production I
> want to only allow 3 of them. Sure, technically it should be possible
> to deny access at 17 hooks and let it through in just those 3. But if
> someone adds 21st and I forget to add 21st restriction, that would be
> bad (but very probably with such approach).

That would be a flaw in the implementation of the 21st, not a problem
with the capabilities or LSM model. For the LSM model to be sufficiently
flexible it cannot be required to prevent or detect coding errors.

> So my point is that for situations like this, dropping CAP_BPF, but
> allowing only 3 hooks to proceed seems a safer approach, because if we
> add 21st hook, it will safely be denied without CAP_BPF *by default*.
> That's what I tried to point out.

When you're creating security relevant or enforcing mechanisms there has
too be a level of expectation regarding the care with which they're
developed. My expectation is that the 21st hook won't go in without
adequate review.

> But even if we ignore this "safe by default when a new hook is added"
> behavior, when taking user namespaces into account, the restrictive
> LSM approach just doesn't seem to work at all for something like
> CAP_BPF. CAP_BPF cannot be "namespaced", just like, say, CAP_SYS_TIME,
> because we cannot ensure that a given BPF program won't access kernel
> state "belonging" to another process (as one example).

Time namespaces have been proposed. I would be surprised if there aren't
people working on BPF namespaces somewhere. There's a difference between
"can't" and "haven't been".

> Now, thanks to Jonathan, I get that there was a heated discussion 20
> years ago about authoritative vs restrictive LSMs. But if I read a
> summary at that time ([0]), authoritative hooks were not out of the
> question *in principle*. Surely, "walk before we can run" makes sense,
> but it's been a while ago.

Certainly. The SGI comment was mine, by the way. I wanted authoritative
hooks for cases like POSIX ACLs and systems without root. While I would
have liked the decision to go the other way, there's no way I would endorse
a hybrid, where some hooks are restrictive and others authoritative.

>   [0] https://lwn.net/2001/1108/a/no-auth-hooks.php3
>
>
>> Here is a fun story which seems relevant ... in the early days of
>> SELinux, one of the community devs setup up a system with a SELinux
>> policy which restricted all privileged operations from the root user,
>> put the system on a publicly accessible network, posted the root
>> password for all to see, and invited the public to login to the system
>> and attempt to exercise root privilege (it's been well over 10 years
>> at this point so the details are a bit fuzzy).  Granted, there were
>> some hiccups in the beginning, mostly due to the crude state of policy
>> development/analysis at the time, but after a few policy revisions the
>> system held up quite well.
> Honest question out of curiosity: was the intent to demonstrate that
> with LSM one can completely restrict root? Or that root was actually
> allowed to do something useful? Because I can see how rejecting
> everything would be rather simple, but actually pretty useless in
> practice. Restricting only part of the power of the root, while still
> allowing it to do something useful in production seems like a much
> harder (but way more valuable) endeavor. Not saying it's impossible,
> but see my example about missing 21st new CAP_BPF functionality.

Capabilities are sufficient to implement a rootless system. It's been done.
Someone will point out that CAP_SYS_ADMIN is effectively root, and there's
some truth to that.

>> On the more practical side of things, there are several use cases
>> which require, by way of legal or contractual requirements, that full
>> root/admin privileges are decomposed into separate roles: security
>> admin, audit admin, backup admin, etc.  These users satisfy these
>> requirements by using LSMs, such as SELinux, to restrict the
>> administrative capabilities based on the SELinux user/role/domain.
>>
>>> By the way, even the above proposal of yours doesn't work for
>>> production use cases when user namespaces are involved, as far as I
>>> understand. We cannot grant CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN for
>>> containers running inside user namespaces, as CAP_BPF in non-init
>>> namespace is not enough for bpf() syscall to allow loading BPF maps or
>>> BPF program ...
>> Once again, the LSM has always intended to be a restrictive mechanism,
>> not a privilege granting mechanism.  If an operation is not possible
> Not according to [0] above:
>
>   > It is our belief that these changes do not belong in the initial version of
>   > LSM (especially given our limited charter and original goals), and should
>   > be proposed as incremental refinements after LSM has been initially
>   > accepted.
>   > ...
>   > It is our belief that the current LSM
>   > will provide a meaningful improvement in the security infrastructure of the
>   > Linux kernel, and that there is plenty of room for future expansion of LSM
>   > in subsequent phases.
>
> I don't see "always intended to be a restrictive mechanism" there.

Having been on the other side of the argument, the system that was accepted
was in fact "always intended to be a restrictive mechanism". The quote above
is a "never say never" statement.

>> without the LSM layer enabled, it should not be possible with the LSM
>> layer enabled.  The LSM is not a mechanism to circumvent other access
>> control mechanisms in the kernel.
> I understand, but it's not like we are proposing to go and bypass all
> kinds of random kernel security mechanisms. These are targeted hooks,
> developed by the BPF community for the BPF subsystem to allow trusted
> unprivileged production use cases. Yes, we currently rely on checking
> CAP_BPF to grant more dangerous/advanced features, but it's because we
> can't just allow any unprivileged process to do this. But what we
> really want is to answer the question "can we trust this process to
> use this advanced functionality", and if there is no specific LSM
> policy that cares one way (allow) or the other (disallow), fallback to
> CAP_BPF enforcement.
>
> So it's not bypassing kernel checks, but rather augmenting them with
> more flexible and customizable mechanisms, while still falling back to
> CAP_BPF if the user didn't install any custom LSM policy.

That would make CAP_BPF behave differently from all other capabilities.
Capabilities are hard enough to use correctly as it is. If each capability
defined its own semantics they would be completely unusable. 

>>> Also, in previous email you said:
>>>
>>>> Simply because there is another kernel access control mechanism which
>>>> allows a capability check to be skipped doesn't mean I want to allow a
>>>> LSM hook to be used to skip a capability check.
>>> I understand your stated position, but can you please help me
>>> understand the reasoning behind it?
>> Keeping the LSM as a restrictive access control mechanism helps ensure
>> some level of sanity and consistency across different Linux
>> installations.  If a certain operation requires CAP_SYS_ADMIN on one
>> Linux system, it should require CAP_SYS_ADMIN on another Linux system.
>> Granted, a LSM running on one system might impose additional
>> constraints on that operation, but the CAP_SYS_ADMIN requirement still
>> applies.
>>
>> There is also an issue of safety in knowing that enabling a LSM will
>> not degrade the access controls on a system by potentially granting
>> operations that were previously denied.
>>
>>> Does the above also mean that you'd be fine if we just don't plug into
>>> the LSM subsystem at all and instead come up with some ad-hoc solution
>>> to allow effectively the same policies? This sounds detrimental both
>>> to LSM and BPF subsystems, so I hope we can talk this through before
>>> finalizing decisions.
>> Based on your patches and our discussion, it seems to me that the
>> problem you are trying to resolve is related more to the
>> capability-based access controls in the eBPF, and possibly other
>> kernel subsystems, and not any LSM-based restrictions.  I'm happy to
>> work with you on a solution involving the LSM, but please understand
>> that I'm not going to support a solution which changes a core
>> philosophy of the LSM layer.
> Great, I'd really appreciate help and suggestions on how to solve the
> following problem.
>
> We have a BPF subsystem that allows loading BPF programs. Those BPF
> programs cannot be contained within a particular namespace just by its
> system-wide tracing nature (it can safely read kernel and user memory
> and we can't restrict whether that memory belongs to a particular
> namespace), so it's like CAP_SYS_TIME, just with much broader API
> surface.

This doesn't sound like a problem, it sounds like BPF is explicitly
designed to prevent interference by namespaces. But in some cases you
now want to limit it by namespaces.

It appears that the desired uses of BPF are no longer compatible with
its original security model. That's unfortunate, and likely to require
a significant change to the implementation of BPF.

>
> The other piece of a puzzle is user namespaces. We do want to run
> applications inside user namespaces, but allow them to use BPF
> programs. As far as I can tell, there is no way to grant real CAP_BPF
> that will be recognized by capable(CAP_BPF) (not ns_capable, see above
> about system-wide nature of BPF). If there is, please help me
> understand how. All my local experiments failed, and looking at
> cap_capable() implementation it is not intended to even check the
> initial namespace's capability if the process is running in the user
> namespace.
>
>
> So, given that a) we can't make CAP_BPF namespace-aware and b) we
> can't grant real CAP_BPF to processes in user namespace, how could we
> allow user namespaced applications to do useful work with BPF?
>
>>> Lastly, you mentioned before:
>>>
>>>>>> I think we need to make this more concrete; we don't have a pattern in
>>>>>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
>>> Unfortunately I don't have enough familiarity with all LSM hooks, so I
>>> can't confirm or disprove the above statement. But earlier someone
>>> brought to my attention the case of security_vm_enough_memory_mm(),
>>> which seems to be granting effectively CAP_SYS_ADMIN for the purposes
>>> of memory accounting. Am I missing something subtle there or does it
>>> grant effective caps indeed?
>> Some of the comments around that hook can be misleading, but if you
>> look at the actual code it starts to make more sense.
>>
> [...]
>
>> I do agree that the security_vm_enough_memory() hook is structured a
>> bit differently than most of the other LSM hooks, but it still
>> operates with the same philosophy: a LSM should only be allowed to
>> restrict access, a LSM should never be allowed to grant access that
>> would otherwise be denied by the traditional Linux access controls.
>>
>> Hopefully that explanation makes sense, but if things are still a bit
>> fuzzy I would encourage you to go look at the code, I'm sure it will
>> make sense once you spend a few minutes figuring out how it works.
>>
> Yep, thanks a lot, it's way more clear after grokking relevant pieces
> of LSM the code you pointed out and LSM infrastructure in general.
> "capabilities" LSM is non-negotiable, so it effectively always
> restricts a small subset of hooks, including vm_enough_memory and
> capable.
>
> Still, the problem still stands. How do we marry BPF and user
> namespaces? I'd really appreciate suggestions. Thank you!
>
>
>> [1] There is a long and sorta bizarre history with the capability LSM,
>> but just understand it is a bit "special" in many ways, and those
>> "special" behaviors are intentional.
>>
>> --
>> paul-moore.com
