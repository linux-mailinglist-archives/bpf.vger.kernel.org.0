Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531F125034F
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgHXQnO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 12:43:14 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:35096
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728737AbgHXQnB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Aug 2020 12:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598287379; bh=B7Ew0G0TXa2KKNlI0pJDDyrSW+TqKo0gQIsvxCgL1U0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LjjMN8oatFn1E4o2uThfFQUkDWeiJcLShVEEL2+YfUmrRpp8VyurV0ASkXKniqHZufwl1eub2Uf1kSBnVzkynlf2N6ZVvJh/txObrndvQpd53UGlb4DF98mHVzCRsA1XNb7SBjQZHdNosKvqeHFAKTScvLMwfgjl63ApW5t+iZaXvTTx5DPNQILG7jyhXxnmmUG/oYx99o0qCCPQwUFMxHHmm3zhGgFyiGxoo4QG1H0DZuszkyZguxE8DpsEPya8fsraxwpygSi9r+2qZEYIfzeF4WHebssPkHyYJNJaHhyj/jk6a00c1lpshuKbp6A2PwdZG6EAilBMxfpVR6pn/A==
X-YMail-OSG: Q0MWEB8VM1mPbN44l7Ltn.YJrFw0Pw1ViTR6Y_3Y352.gfnJnhYp29R.FfBB93D
 JHi1ZyiDhKmggGDxnOdYMszA1Dw4qQUyB4KGj3rvD3lruGn2g0uMsPyiam5FxDQsmA4.xmTTQA.G
 k1OwgGp17Hqn4zFUU6C0eSeEA75HwV7BnsmIk0I26EYOXCwk8Uv0q_XEMaBn_Gx6hYWt7uLQbpW_
 9KBU7I_NSw7AgJHKcXi9Mqj5xD9j9itnSoBDSZpdpFt1hfU8W7eDXVNXQXU2rKd.PstvUR3qqNB1
 2KKI.cz2eqmqb980IfeG4KqFWUjUFHSb4hx0ERYsUmedfLM2YiBSU_iWlivhV4g1HduC6gXL748w
 aKdhNprdrj.VhVYC7Lx.SPPhBlMm6iIApVdBOQgacpaQK3EIBnhNe8UKjINOXjJod3UHzglSLR.s
 M3Ub55fVXPBW1Fk7x3vAkYuD7hw.JD4OyMb4VEcJtG4xbc7vqdORMPZHTEWT7DwdCdlsUM7c.gi1
 EJ1I_U3wSrZ.BMFo6vd1wnOf.MuCLbbQemXMTQmZnkMpwitxOYp86oRk.4BUnsl0sGa5KBex68lV
 g_FONJmqv4eT7SuL1WxdQk6V4S0qtkbGUcoRa33SmxgH6Whb3LK7d11RkOK1xX7Be_kdZD7EK1uf
 r.JgM.2TKGLe2JbQHX_Q1Em77GweA6l12eO65sHyFmP.qCa2TBRd.aNmucLZyUAlGEoJmrH1Rhdt
 oZGqptVWMdB2j8LgSoPLKuyNsj7D7AbnkAN4MdAKvWnuIONvezS9GzV8meTZC5p6FYwfhv0_f8m.
 F_A9yiG.q0fsehftKQk7HLpqoT6VvHbU.llBqJCxdBPyeJbuGb0Powo1fK1vNXsu9OV.WbyogokE
 DbU8Cd9FfLXP408vJl3uQW4J_NYMvHuYyRbC2XUQbF670_5Hl19kBug0lg9BTcyesj971ab9.SXm
 0tNQ5WjyeAikaIeccOEKlgq2FnSqYw5cFDVOCriEQWQ9sWMHNdrHwFJftGGlWkoc___uIE7jJLzb
 kZxAVpy.ofAryCY988BmFBJUkBkg.sB3aEv41eGP.deirxKATsD6TVfBOLyjimcGO07lPMPO9_zj
 lF7ZkHiy.8K3PXOQFVrwZIhBmYYnTJuXKPrkmza5zjPQqmXJOdqWYpg_Mf23.ES84LUIxKKGFMbw
 qlKmtsWOPmTq8c8mUc3UFWeOVRS74nbKl4ZPZCQJUnQ4hba2r8vwtEb.UAns4tFXjWkn5g_lF9BK
 7jXTaXjgCLcI6ZzXT.6SVm.wJTQkA383m60Kss_yJhz3fU4OqAaHGpy7vJynLuSsHglBfkxPRLe3
 3qiylcGl0e0k5EQ_o6TkTZrb4O_Z3WOZ7w3wq_B31P.l80Nl26WR6ZxNCasn11q4gDSA_53j1Syk
 vwHLtaVBDhK_tATG6umaMFeWmETMxolmgb5ScCXME.SR1w1s0yYi1TOBvWDCk09E7VoJfuj0MouM
 BLWhAEUaKe1gn7sAWcVjN4e0PDyhW7tc8WI5roJ0UAPxQJVDaBCS1gVcft3VNxo2.fxIBKxnhU2I
 9BBOctfPrGcCWTiuDJQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Aug 2020 16:42:59 +0000
Received: by smtp417.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0d00dcda49cce8273293f2c695656539;
          Mon, 24 Aug 2020 16:42:57 +0000 (UTC)
Subject: Re: [RFC] security: replace indirect calls with static calls
To:     Brendan Jackman <jackmanb@google.com>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rafael.j.wysocki@intel.com, Kees Cook <keescook@chromium.org>,
        thgarnie@chromium.org, KP Singh <kpsingh@google.com>,
        paul.renauld.epfl@gmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200820164753.3256899-1-jackmanb@chromium.org>
 <42fb4180-772c-5579-ef3e-b4003e2b784b@schaufler-ca.com>
 <CA+i-1C09YZ8aCr6p5NOA2e3Ji5TKwdET=qAy=M328NK--L=0RA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <66a35f25-53be-17c3-8ab3-7cb32b0bc77a@schaufler-ca.com>
Date:   Mon, 24 Aug 2020 09:42:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+i-1C09YZ8aCr6p5NOA2e3Ji5TKwdET=qAy=M328NK--L=0RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/24/2020 8:20 AM, Brendan Jackman wrote:
> On Fri, 21 Aug 2020 at 00:46, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 8/20/2020 9:47 AM, Brendan Jackman wrote:
> [...]
>> What does NOP really look like?
> The NOP is the same as a regular function call but the CALL
> instruction is replaced with a NOP instruction. The code that sets up
> the call parameters is unchanged, and so is the code that expects to
> get the return value in eax or whatever.

Right. Are you saying that NOP is in-line assembler in your switch?

> That means we cannot actually
> call the static_calls for NULL slots, we'd get undefined behaviour
> (except for void hooks) - this is what Peter is talking about in the
> sibling thread.

Referring to the "sibling thread" is kinda confusing, and
assumes everyone is one all the right mailing lists, and knows
which other thread you're talking about.

>
> For this reason, there are _no gaps_ in the callback table. For a
> given LSM hook, all the slots after base_slot_idx are filled,

Why go to all the trouble of maintaining the base_slot_idx
if NOP is so cheap? Why not fill all unused slots with NOP?
Worst case would be a hook with no users, in which case you
have 11 NOPS in the void hook case and 11 "if (ret != DEFAULT_RET)"
and 11 NOPS in the int case. No switch magic required. Even
better, in the int case you have two calls/slot, the first is the
module supplied function (or NOP) and the second is
	int isit(int ret) { return (ret != DEFAULT_RET) ? ret : 0; }
(or NOP).

The no security module case degenerates to 22 NOP instructions
and no if checks of any sort. I'm not the performance guy, but
that seems better than maintaining and checking base_slot_idx
to me.
 

>  and all
> before are empty, so jumping to base_slot_idx ensures that we don't
> reach an empty slot. That's what the switch trick is all about.

I hates tricks. They're so susceptible to clever attacks.


>>>                         if ret != 0:
>> I assume you'd want "ret != DEFAULT_RET" instead of "ret != 0".
> Yeah that's a good question - but the existing behaviour is to always
> check against 0 (DEFAULT_RET is called IRC in the real code),
> which does seem strange.

If you don't do this correctly you'll make a real mess of the security.

>> So what goes in for empty slots? What about gaps in the table?
> It's a NOP, but we never execute it (explained above). There are no gaps.

Right. Unused slots have NOP. NOP is (assumed to be) cheap.


>>> +#define __UNROLL_MACRO_LOOP_20(MACRO, ...) \
>>> + __UNROLL_MACRO_LOOP_19(MACRO, __VA_ARGS__) \
>>> + MACRO(19, __VA_ARGS__)
>>> +
>> Where does "20" come from? Why are you unrolling beyond 11?
> It's just an arbitrary limit on the unrolling macro implementation, we
> aren't actually unrolling beyond 11 where the macro is used (N is set
> to 11).

I'm not a fan of including macros you can't use, especially
when they're just obvious variants of other macros.


>>>   With this use of the table and the
>>> switch, it is possible to jump directly to the first used slot and execute
>>> all of the slots after. This essentially makes the entry point of the table
>>> dynamic. Instead, it would also be possible to start from 0 and break after
>>> the final populated slot, but that would require an additional conditional
>>> after each slot.
>>>
>>> This macro is used to generate the code for each static slot, (e.g. each
>>> case statement in the previous example). This will expand into a call to
>>> MACRO for each static slot defined. For example, if with again 5 slots:
>>>
>>> SECURITY_FOREACH_STATIC_SLOT(MACRO, x, y) ->
>>>
>>>       MACRO(0, x, y)
>>>       MACRO(1, x, y)
>>>       MACRO(2, x, y)
>>>       MACRO(3, x, y)
>>>       MACRO(4, x, y)
>>>
>>> This is used in conjunction with LSM_HOOK definitions in
>>> linux/lsm_hook_defs.h to execute a macro for each static slot of each LSM
>>> hook.
>>>
>>> The patches for static calls [6] are not upstreamed yet.
>>>
>>> The number of available slots for each LSM hook is currently fixed at
>>> 11 (the number of LSMs in the kernel). Ideally, it should automatically
>>> adapt to the number of LSMs compiled into the kernel.
>> #define SECURITY_STATIC_SLOT_COUNT ( \
>>         1 + /* Capability module is always there */ \
>>         (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>>         (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>>         ... \
>>         (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
>>
> Yeah, that's exactly what we need but it needs to be expanded to an
> integer literal at preprocessor time, those +s won't work :(

???? Gosh. It works in my module stacking code.


>>> If there’s no practical way to implement such automatic adaptation, an
>>> option instead would be to remove the panic call by falling-back to the old
>>> linked-list mechanism, which is still present anyway (see below).
>>>
>>> A few special cases of LSM don't use the macro call_[int/void]_hook but
>>> have their own calling logic. The linked-lists are kept as a possible slow
>>> path fallback for them.
>> Unfortunately, the stacking effort is increasing the number of hooks
>> that will require special handling. security_secid_to_secctx() is one
>> example.
>>
>>> Before:
>>>
>>> https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/62437b1416829ca0e8a0ed9101530bc90fd42d69/lsm-performance.png
>>>
>>> After:
>>>
>>> https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/00e414b73e0c38c2eae8f05d5363a745179ba285/faster-lsm-results.png
>>>
>>> With this implementation, any overhead of the indirect call in the LSM
>>> framework is completely mitigated (performance results: [7]). This
>>> facilitates the adoption of "bpf" LSM on production machines and also
>>> benefits all other LSMs.
>> Your numbers for a system with BPF are encouraging. What do the numbers
>> look like for a system with SELinux, Smack or AppArmor?
> Yeah that's a good question. As I said in the sibling thread the
> motivating example is very lightweight LSM callbacks in very hot
> codepaths, but I'll get some broader data too and report back.

Even IoT systems are using security modules these days. You'll be
hard pressed to identify a class of systems that don't use an
LSM or two. My bet is that your fiendishly clever scheme is going
to make everyone's life better, but as with all things, it does
need to have hard evidence.

