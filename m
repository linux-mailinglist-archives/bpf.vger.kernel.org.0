Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E424C7E7
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 00:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgHTWq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 18:46:28 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:46735
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728516AbgHTWq2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Aug 2020 18:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597963585; bh=kZsZWZ5f/c1xywxsQw+Kjqet1zVQhnt0aJlgALoxq3g=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=iirSxnjh/I6G91A35gcrR0AugQnvk4jHdZWWrr23lPA3aL7pT/cpIVzJED0tJHeUJEOv49+Eqygf93dhb7BnPqlAFsOAD/KvF2QheuQUdpTEKUglq1twf1C9niqnKM73vjQTeVSsDEe8X8Rd04oeDlHHAWgw1Lj+xcWWWzK5giw+oHwekArv5mEZ8vhJAsaZ79UL78ImQ9hNCyFjl/F45zR0OZrUm2kmdDkL8mJTaQtL5KtDeBZbqz2wsqAsZmX80g3twmm9MCavKwGQsUBiNdF/wQOjWiN259zWmzRkTrIqHiNrQiJk0G3Sw7W6bi1588a2MwcjWkbRvOMbnbAOQg==
X-YMail-OSG: 8ptYxy8VM1nUb9hUvEQHu6DYQoxpYRCBqXNglFeOS1ttJS3Cxu7ZsXGlkYzbhw0
 yqSzq5bc18oABxANlI9LdhcDN5DMWoDF7ijJYkWPgjoUrduvLQ9kvw8I9y1f8LetWzuinPDGLvZj
 prtcbaW.UM7BhRcYb4eS37cNDkHRWFqLpIpIpeIVvYiAObZfG9jTQoUvHT9iDxGvCqrKRKqhYLUf
 qMwzi1_YsNLCYQ3lp3I4Kz6O5Fv8AJGjBe5JR.NRIuTpSFj6oD2WPhl1hHBRs9GFIYDJ5ZJJ1Lk3
 QQycNaIvQ4jEXl27bKfoiMVGttsEflmcG612Qb7f4XNSTf7ASOL.VhYZTlj.y.TmD7WQVe3MzFy7
 8HcvJzLV9elPKHcSS5wL7uz1PzEkWiUCc5nqaU3mleUBMlhSutSqVgylKlc6AHLNYd7iOJz_b1IX
 q2b076bGP0yp6tbct6KbJ4g0rVpIpfWaNqPcHoy.PmMUlrobBFhJk5YTO2HG_4LYlBZLjWTO9lxt
 qD3n8kXfyPpxrXWSvTVOxyCi21IVfwZY7RpKltFPHysK2pn0pOa56MJ8qqfw2RyVembvDr0yv5f_
 BMGL6_iUrQJpPscphrPkDG9RjZrvAU9VaoJbMs.UQW1AShaOb.FxGdQVXZ.rXKVRHTeUqF6VnTt8
 7UJ7NFXrKkIh4r6sgeL_2fBRKFQ.XS7zbk203mWBI.O4ChTltyO3fIj2BwZskDXKUxut5ixjpMqi
 U0hRQZAPtM9ViLJAZF6dKwr0ndEjxKvpo6_XCXXlysXHbDWT15pt9KUQbOWleb9ISNocUPpwg0Hh
 lISVCOjkZE3ZZPSreeq2J4ZD.KIDKLDsW7YNO80dgUY_B.n2VQBrI9wWao1ZSAILtUdL8xuLgCiJ
 mUUATgfJDU4JnwB_Y6E7QDOW8zGpZEfSZR2_ZnChTFGHpcji12qh1jTVx9T18.ql0VXBwItU0ARu
 0JHqqvMfzGaoXlw6HjkG2T99lhHqcni3KykfCuEfZKUBcKSXBOtmiX7ukLOFSA42RfxmnVoxY8gX
 lOHuFpKZGqtKLDSUezDkvor_bjVulQ2pBw70i6NDiGRCJa1uQvzkpA.jD2Pdg3otJlztMjUB7SI2
 CZBQeeu3yhFBn9fkt9nGRhCd3sD35loKRb3tK6YAfBi0hLw0PhjV8cRsZaF89.seqW6fkOOiVPNc
 .NqEazlEG._TkIiUlW8wR966dvniO7AkaH04.DPf7tAYova21h6KzSIPso3xiB15f3Yyw4pgL_in
 VLUDKSOfpYM86B9T6ShKHswL.YJ.L5LXYylCFmR5vUlPAUaULPWuHnxvMZH5_Zkclg3O8fOFib8A
 LxP1qH3vF.8DtPLctMheTrGeQZ_esM8qyxRLvfmqsNZBdLLBZLuTbJWim9aggJqKYo_OpsSa6_Pw
 sybZTdDI4PBgELcL1tnOu59P0cxdFKhYtrgCGlUh7VJYWVVZDmK2bBPPZRarZgMXSayyCUHF8FoW
 K3967SdzRWNsFoi7a_mXtcsi8EvkgR.Vtz5rW4wcpNgJ69zHXydN4sP.Cwh_SfCSLRZR29o7ad0J
 tz9OMuLrZXH4GEOog.YoHwnV8ICPp0dU.ldSkghCZK0owLmR5zTYjR8DMU15R3dCjilIFD6y59Am
 x
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Aug 2020 22:46:25 +0000
Received: by smtp401.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c9d24128d16933f219473daa73690d8b;
          Thu, 20 Aug 2020 22:46:20 +0000 (UTC)
Subject: Re: [RFC] security: replace indirect calls with static calls
To:     Brendan Jackman <jackmanb@chromium.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, pjt@google.com,
        jannh@google.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        keescook@chromium.org, thgarnie@chromium.org, kpsingh@google.com,
        paul.renauld.epfl@gmail.com, Brendan Jackman <jackmanb@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200820164753.3256899-1-jackmanb@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <42fb4180-772c-5579-ef3e-b4003e2b784b@schaufler-ca.com>
Date:   Thu, 20 Aug 2020 15:46:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820164753.3256899-1-jackmanb@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/20/2020 9:47 AM, Brendan Jackman wrote:
> From: Paul Renauld <renauld@google.com>
>
> LSMs have high overhead due to indirect function calls through
> retpolines. This RPC proposes to replace these with static calls [1]
> instead.
>
> This overhead is especially significant for the "bpf" LSM which supports
> the implementation of LSM hooks with eBPF programs (security/bpf)[2]. In
> order to facilitate this, the "bpf" LSM provides a default nop callback for
> all LSM hooks. When enabled, the "bpf", LSM incurs an unnecessary /
> avoidable indirect call to this nop callback.
>
> The performance impact on a simple syscall eventfd_write (which triggers
> the file_permission hook) was measured with and without "bpf" LSM
> enabled. Activating the LSM resulted in an overhead of 4% [3].
>
> This overhead prevents the adoption of bpf LSM on performance critical
> systems, and also, in general, slows down all LSMs.
>
> Currently, the LSM hook callbacks are stored in a linked list and
> dispatched as indirect calls. Using static calls can remove this overhead
> by replacing all indirect calls with direct calls.
>
> During the discussion of the "bpf" LSM patch-set it was proposed to special
> case BPF LSM to avoid the overhead by using static keys. This was however
> not accepted and it was decided to [4]:
>
> - Not special-case the "bpf" LSM.
> - Implement a general solution benefitting the whole LSM framework.
>
> This is based on the static call branch [5].
>
> For each LSM hook, a table of static calls is defined (referred to as
> "static slots", or "slots"). When all the LSMs are initialized and linked
> lists are filled, the hook callbacks are copied to the appropriate static
> slot. The callbacks are continuously added at the end of the table, and the
> index of the first slot that is non empty is stored.  Then, when a LSM hook
> is called (macro call_[int/void]_hook), the execution jumps to this first
> non-empty slot and all of the subsequent static slots are executed.
>
> The static calls are re-initialized every time the linked list is modified,
> i.e. after the early LSM init, and the LSM init.
>
> Let's say, there are 5 static slots per LSM hook, and 3 LSMs implement some
> hook with the callbacks A, B, C.
>
> Previously, the code for this hook would have looked like this:
>
> 	ret = DEFAULT_RET;
>
>         for each cb in [A, B, C]:
>                 ret = cb(args); <--- costly indirect call here
>                 if ret != 0:
>                         break;
>
>         return ret;
>
> Static calls are defined at build time and are initially empty (NOP
> instructions). When the LSMs are initialized, the slots are filled as
> follows:
>
>  slot idx     content
>            |-----------|
>     0      |           |
>            |-----------|
>     1      |           |
>            |-----------|
>     2      |   call A  | <-- base_slot_idx = 2
>            |-----------|
>     3      |   call B  |
>            |-----------|
>     4      |   call C  |
>            |-----------|
>
> The generated code will unroll the foreach loop to have a static call for
> each possible LSM:
>
>         ret = DEFAULT_RET;
>         switch(base_slot_idx):
>
>                 case 0:
>                         NOP

What does NOP really look like?

>                         if ret != 0:

I assume you'd want "ret != DEFAULT_RET" instead of "ret != 0".

>                                 break;
>                         // fallthrough
>                 case 1:
>                         NOP
>                         if ret != 0:
>                                 break;
>                         // fallthrough
>                 case 2:
>                         ret = A(args); <--- direct call, no retpoline
>                         if ret != 0:
>                                 break;
>                         // fallthrough
>                 case 3:
>                         ret = B(args); <--- direct call, no retpoline
>                         if ret != 0:
>                                 break;
>                         // fallthrough
>
>                 [...]
>
>                 default:
>                         break;
>
>         return ret;
>
> A similar logic is applied for void hooks.
>
> Why this trick with a switch statement? The table of static call is defined
> at compile time. The number of hook callbacks that will be defined is
> unknown at that time, and the table cannot be resized at runtime.  Static
> calls do not define a conditional execution for a non-void function, so the
> executed slots must be non-empty.

So what goes in for empty slots? What about gaps in the table?

>   With this use of the table and the
> switch, it is possible to jump directly to the first used slot and execute
> all of the slots after. This essentially makes the entry point of the table
> dynamic. Instead, it would also be possible to start from 0 and break after
> the final populated slot, but that would require an additional conditional
> after each slot.
>
> This macro is used to generate the code for each static slot, (e.g. each
> case statement in the previous example). This will expand into a call to
> MACRO for each static slot defined. For example, if with again 5 slots:
>
> SECURITY_FOREACH_STATIC_SLOT(MACRO, x, y) ->
>
> 	MACRO(0, x, y)
> 	MACRO(1, x, y)
> 	MACRO(2, x, y)
> 	MACRO(3, x, y)
> 	MACRO(4, x, y)
>
> This is used in conjunction with LSM_HOOK definitions in
> linux/lsm_hook_defs.h to execute a macro for each static slot of each LSM
> hook.
>
> The patches for static calls [6] are not upstreamed yet.
>
> The number of available slots for each LSM hook is currently fixed at
> 11 (the number of LSMs in the kernel). Ideally, it should automatically
> adapt to the number of LSMs compiled into the kernel.

#define SECURITY_STATIC_SLOT_COUNT ( \
	1 + /* Capability module is always there */ \
	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
	... \
	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))

> If there’s no practical way to implement such automatic adaptation, an
> option instead would be to remove the panic call by falling-back to the old
> linked-list mechanism, which is still present anyway (see below).
>
> A few special cases of LSM don't use the macro call_[int/void]_hook but
> have their own calling logic. The linked-lists are kept as a possible slow
> path fallback for them.

Unfortunately, the stacking effort is increasing the number of hooks
that will require special handling. security_secid_to_secctx() is one
example. 

>
> Before:
>
> https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/62437b1416829ca0e8a0ed9101530bc90fd42d69/lsm-performance.png
>
> After:
>
> https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/00e414b73e0c38c2eae8f05d5363a745179ba285/faster-lsm-results.png
>
> With this implementation, any overhead of the indirect call in the LSM
> framework is completely mitigated (performance results: [7]). This
> facilitates the adoption of "bpf" LSM on production machines and also
> benefits all other LSMs.

Your numbers for a system with BPF are encouraging. What do the numbers
look like for a system with SELinux, Smack or AppArmor?

>
> [1]: https://lwn.net/ml/linux-kernel/20200710133831.943894387@infradead.org/
> [2]: https://lwn.net/Articles/798157/
> [3] measurements: https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/62437b1416829ca0e8a0ed9101530bc90fd42d69/lsm-performance.png
> protocol: https://gist.github.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5#file-measurement-protocol-md
> [4]: https://lwn.net/Articles/813261/
> [5]: git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call
> [6]: https://lwn.net/ml/linux-kernel/20200710133831.943894387@infradead.org/#t
> [7]: https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/00e414b73e0c38c2eae8f05d5363a745179ba285/faster-lsm-results.png
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: James Morris <jmorris@namei.org>
> Cc: pjt@google.com
> Cc: jannh@google.com
> Cc: peterz@infradead.org
> Cc: rafael.j.wysocki@intel.com
> Cc: keescook@chromium.org
> Cc: thgarnie@chromium.org
> Cc: kpsingh@google.com
> Cc: paul.renauld.epfl@gmail.com
>
> Signed-off-by: Paul Renauld <renauld@google.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  include/linux/lsm_hooks.h       |   1 +
>  include/linux/lsm_static_call.h | 134 ++++++++++++++++++++
>  security/security.c             | 217 ++++++++++++++++++++++++++++----
>  3 files changed, 331 insertions(+), 21 deletions(-)
>  create mode 100644 include/linux/lsm_static_call.h
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 95b7c1d32062..d11e116b588e 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1524,6 +1524,7 @@ union security_list_options {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
>  	#include "lsm_hook_defs.h"
>  	#undef LSM_HOOK
> +	void *generic_func;
>  };
>  
>  struct security_hook_heads {
> diff --git a/include/linux/lsm_static_call.h b/include/linux/lsm_static_call.h
> new file mode 100644
> index 000000000000..f5f5698292e0
> --- /dev/null
> +++ b/include/linux/lsm_static_call.h
> @@ -0,0 +1,134 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#ifndef __LINUX_LSM_STATIC_CALL_H
> +#define __LINUX_LSM_STATIC_CALL_H
> +
> +/*
> + * Static slots are used in security/security.c to avoid costly
> + * indirect calls by replacing them with static calls.
> + * The number of static calls for each LSM hook is fixed.
> + */
> +#define SECURITY_STATIC_SLOT_COUNT 11

See suggested code above.

> +
> +/*
> + * Identifier for the LSM static slots.
> + * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
> + * IDX is the index of the slot. 0 <= NUM < SECURITY_STATIC_SLOT_COUNT
> + */
> +#define STATIC_SLOT(HOOK, IDX) security_static_slot_##HOOK##_##IDX
> +
> +/*
> + * Call the macro M for each LSM hook slot.
> + * M should take as first argument the index and then
> + * the same __VA_ARGS__
> + * Essentially, this will expand to:
> + *	M(0, ...)
> + *	M(1, ...)
> + *	M(2, ...)
> + *	...
> + * Note that no trailing semicolon is placed so M should be defined
> + * accordingly.
> + * This adapts to a change to SECURITY_STATIC_SLOT_COUNT.
> + */
> +#define SECURITY_FOREACH_STATIC_SLOT(M, ...)		\
> +	UNROLL_MACRO_LOOP(SECURITY_STATIC_SLOT_COUNT, M, __VA_ARGS__)
> +
> +/*
> + * Intermediate macros to expand SECURITY_STATIC_SLOT_COUNT
> + */
> +#define UNROLL_MACRO_LOOP(N, MACRO, ...)		\
> +	_UNROLL_MACRO_LOOP(N, MACRO, __VA_ARGS__)
> +
> +#define _UNROLL_MACRO_LOOP(N, MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP(N, MACRO, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP(N, MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_##N(MACRO, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_0(MACRO, ...)
> +
> +#define __UNROLL_MACRO_LOOP_1(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_0(MACRO, __VA_ARGS__)	\
> +	MACRO(0, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_2(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_1(MACRO, __VA_ARGS__)	\
> +	MACRO(1, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_3(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_2(MACRO, __VA_ARGS__)	\
> +	MACRO(2, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_4(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_3(MACRO, __VA_ARGS__)	\
> +	MACRO(3, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_5(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_4(MACRO, __VA_ARGS__)	\
> +	MACRO(4, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_6(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_5(MACRO, __VA_ARGS__)	\
> +	MACRO(5, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_7(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_6(MACRO, __VA_ARGS__)	\
> +	MACRO(6, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_8(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_7(MACRO, __VA_ARGS__)	\
> +	MACRO(7, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_9(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_8(MACRO, __VA_ARGS__)	\
> +	MACRO(8, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_10(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_9(MACRO, __VA_ARGS__)	\
> +	MACRO(9, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_11(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_10(MACRO, __VA_ARGS__)	\
> +	MACRO(10, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_12(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_11(MACRO, __VA_ARGS__)	\
> +	MACRO(11, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_13(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_12(MACRO, __VA_ARGS__)	\
> +	MACRO(12, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_14(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_13(MACRO, __VA_ARGS__)	\
> +	MACRO(13, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_15(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_14(MACRO, __VA_ARGS__)	\
> +	MACRO(14, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_16(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_15(MACRO, __VA_ARGS__)	\
> +	MACRO(15, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_17(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_16(MACRO, __VA_ARGS__)	\
> +	MACRO(16, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_18(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_17(MACRO, __VA_ARGS__)	\
> +	MACRO(17, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_19(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_18(MACRO, __VA_ARGS__)	\
> +	MACRO(18, __VA_ARGS__)
> +
> +#define __UNROLL_MACRO_LOOP_20(MACRO, ...)		\
> +	__UNROLL_MACRO_LOOP_19(MACRO, __VA_ARGS__)	\
> +	MACRO(19, __VA_ARGS__)
> +

Where does "20" come from? Why are you unrolling beyond 11?

> +#endif /* __LINUX_LSM_STATIC_CALL_H */
> diff --git a/security/security.c b/security/security.c
> index 70a7ad357bc6..15026bc716f2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,8 @@
>  #include <linux/string.h>
>  #include <linux/msg.h>
>  #include <net/flow.h>
> +#include <linux/static_call.h>
> +#include <linux/lsm_static_call.h>
>  
>  #define MAX_LSM_EVM_XATTR	2
>  
> @@ -86,6 +88,128 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
>  static __initdata struct lsm_info **ordered_lsms;
>  static __initdata struct lsm_info *exclusive;
>  
> +/*
> + * Necessary information about a static
> + * slot to call __static_call_update
> + */
> +struct static_slot {
> +	/* static call key as defined by STATIC_CALL_KEY */
> +	struct static_call_key *key;
> +	/* static call trampoline as defined by STATIC_CALL_TRAMP */
> +	void *trampoline;
> +};
> +
> +/*
> + * Table of the static calls for each LSM hook.
> + * Once the LSMs are initialized, their callbacks will be copied to these
> + * tables such that the slots are filled backwards (from last to first).
> + * This way, we can jump directly to the first used slot, and execute
> + * all of them after. This essentially makes the entry point point
> + * dynamic to adapt the number of slot to the number of callbacks.
> + */
> +struct static_slot_list {
> +	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +		struct static_slot NAME[SECURITY_STATIC_SLOT_COUNT];
> +	#include <linux/lsm_hook_defs.h>
> +	#undef LSM_HOOK
> +} __randomize_layout;
> +
> +/*
> + * Index of the first used static call for each LSM hook
> + * in the corresponding static_slot_list table.
> + * All slots with greater indices are used.

Again, what about gaps?

> + * If no slot is used, the default value is INT_MAX.
> + */
> +struct base_slot_idx {
> +	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +		int NAME;
> +	#include <linux/lsm_hook_defs.h>
> +	#undef LSM_HOOK
> +} __randomize_layout;
> +
> +/*
> + * Create the static slots for each LSM hook, initially empty.
> + * This will expand to:
> + *
> + * [...]
> + *
> + * DEFINE_STATIC_CALL_NULL(security_static_slot_file_permission_0,
> + *			   *((int(*)(struct file *file, int mask)))NULL);
> + * DEFINE_STATIC_CALL_NULL(security_static_slot_file_permission_1, ...);
> + *
> + * [...]
> + */
> +#define CREATE_STATIC_SLOT(NUM, NAME, RET, ...)				\
> +	DEFINE_STATIC_CALL_NULL(STATIC_SLOT(NAME, NUM),			\
> +				*((RET(*)(__VA_ARGS__))NULL));
> +
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
> +	SECURITY_FOREACH_STATIC_SLOT(CREATE_STATIC_SLOT, NAME, RET, __VA_ARGS__)
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +#undef CREATE_STATIC_SLOT
> +
> +/*
> + * Initialise a table of static slots for each LSM hook.
> + * When defined with DEFINE_STATIC_CALL_NULL as above, a static call is
> + * a key and a trampoline. Both are needed to use __static_call_update.
> + * This will expand to:
> + * struct static_slot_list static_slots = {
> + *	[...]
> + *	.file_permission = {
> + *		(struct static_slot) {
> + *			.key = &STATIC_CALL_KEY(
> + *				security_static_slot_file_permission_0),
> + *			.trampoline = &STATIC_CALL_TRAMP(
> + *				security_static_slot_file_permission_0)
> + *		},
> + *		(struct static_slot) {
> + *			.key = &STATIC_CALL_KEY(
> + *				security_static_slot_file_permission_1),
> + *			.trampoline = &STATIC_CALL_TRAMP(
> + *				security_static_slot_file_permission_1)
> + *		},
> + *		[...]
> + *	},
> + *	.file_alloc_security = {
> + *		[...]
> + *	},
> + *	[...]
> + * }
> + */
> +static struct static_slot_list static_slots __initdata = {
> +#define DEFINE_SLOT(NUM, NAME)						\
> +	(struct static_slot) {					\
> +		.key = &STATIC_CALL_KEY(STATIC_SLOT(NAME, NUM)),	\
> +		.trampoline = &STATIC_CALL_TRAMP(STATIC_SLOT(NAME, NUM))\
> +	},
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
> +	.NAME = {							\
> +		SECURITY_FOREACH_STATIC_SLOT(DEFINE_SLOT, NAME)		\
> +	},
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +#undef DEFINE_SLOT
> +};
> +
> +/*
> + * The base slot index for each is initially INT_MAX, which means
> + * that no slot is used yet.
> + * When expanded, this results in:
> + * struct base_slot_idx base_slot_idx = {
> + *	[...]
> + *	.file_permission = INT_MAX,
> + *	.file_alloc_security = INT_MAX,
> + *	[...]
> + * }
> + */
> +static struct base_slot_idx base_slot_idx __lsm_ro_after_init = {
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
> +	.NAME = INT_MAX,
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +};
> +
>  static __initdata bool debug;
>  #define init_debug(...)						\
>  	do {							\
> @@ -307,6 +431,46 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> +static void __init lsm_init_hook_static_slot(struct static_slot *slots,
> +					     struct hlist_head *head,
> +					     int *first_slot_idx)
> +{
> +	struct security_hook_list *pos;
> +	struct static_slot *slot;
> +	int slot_cnt;
> +
> +	slot_cnt = 0;
> +	hlist_for_each_entry_rcu(pos, head, list)
> +		slot_cnt++;
> +
> +	if (slot_cnt > SECURITY_STATIC_SLOT_COUNT)
> +		panic("%s - No static hook slot remaining to add LSM hook.\n",
> +		      __func__);
> +
> +	if (slot_cnt == 0) {
> +		*first_slot_idx = INT_MAX;
> +		return;
> +	}
> +
> +	*first_slot_idx = SECURITY_STATIC_SLOT_COUNT - slot_cnt;
> +	slot = slots + *first_slot_idx;
> +	hlist_for_each_entry_rcu(pos, head, list) {
> +		__static_call_update(slot->key, slot->trampoline,
> +				     pos->hook.generic_func);
> +		slot++;
> +	}
> +}
> +
> +static void __init lsm_init_static_slots(void)
> +{
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
> +	lsm_init_hook_static_slot(static_slots.NAME,			\
> +				  &security_hook_heads.NAME,		\
> +				  &base_slot_idx.NAME);
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +}
> +
>  static void __init lsm_early_cred(struct cred *cred);
>  static void __init lsm_early_task(struct task_struct *task);
>  
> @@ -354,6 +518,7 @@ static void __init ordered_lsm_init(void)
>  	lsm_early_task(current);
>  	for (lsm = ordered_lsms; *lsm; lsm++)
>  		initialize_lsm(*lsm);
> +	lsm_init_static_slots();
>  
>  	kfree(ordered_lsms);
>  }
> @@ -374,6 +539,7 @@ int __init early_security_init(void)
>  		prepare_lsm(lsm);
>  		initialize_lsm(lsm);
>  	}
> +	lsm_init_static_slots();
>  
>  	return 0;
>  }
> @@ -696,27 +862,36 @@ static void __init lsm_early_task(struct task_struct *task)
>   * call_int_hook:
>   *	This is a hook that returns a value.
>   */
> -
> -#define call_void_hook(FUNC, ...)				\
> -	do {							\
> -		struct security_hook_list *P;			\
> -								\
> -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> -			P->hook.FUNC(__VA_ARGS__);		\
> -	} while (0)
> -
> -#define call_int_hook(FUNC, IRC, ...) ({			\
> -	int RC = IRC;						\
> -	do {							\
> -		struct security_hook_list *P;			\
> -								\
> -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> -			RC = P->hook.FUNC(__VA_ARGS__);		\
> -			if (RC != 0)				\
> -				break;				\
> -		}						\
> -	} while (0);						\
> -	RC;							\
> +#define __CASE_CALL_STATIC_VOID(NUM, HOOK, ...)				\
> +	case NUM:							\
> +		static_call(STATIC_SLOT(HOOK, NUM))(__VA_ARGS__);	\
> +		fallthrough;
> +
> +#define call_void_hook(FUNC, ...) do {					\
> +	switch (base_slot_idx.FUNC) {					\
> +	SECURITY_FOREACH_STATIC_SLOT(__CASE_CALL_STATIC_VOID,		\
> +				     FUNC, __VA_ARGS__)			\
> +	default :							\
> +		break;							\
> +	}								\
> +} while (0)
> +
> +#define __CASE_CALL_STATIC_INT(NUM, R, HOOK, ...)			\
> +	case NUM:							\
> +		R = static_call(STATIC_SLOT(HOOK, NUM))(__VA_ARGS__);	\
> +		if (R != 0)						\
> +			break;						\
> +		fallthrough;
> +
> +#define call_int_hook(FUNC, IRC, ...) ({				\
> +	int RC = IRC;							\
> +	switch (base_slot_idx.FUNC) {					\
> +	SECURITY_FOREACH_STATIC_SLOT(__CASE_CALL_STATIC_INT,		\
> +				     RC, FUNC, __VA_ARGS__)		\
> +	default :							\
> +		break;							\
> +	}								\
> +	RC;								\
>  })
>  
>  /* Security operations */
