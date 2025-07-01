Return-Path: <bpf+bounces-62016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8CBAF059D
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 23:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB89189AA59
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC752EBDC7;
	Tue,  1 Jul 2025 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EnRfXEjV"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDB1C84C5;
	Tue,  1 Jul 2025 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405339; cv=none; b=DLfROeYkZ6kHGXTQUHb9mvZZ0gz/OQO8mkjPCDAk5JRSuxwV8ptnEta4sOVptzTyKM52ZC3TBnvZBUFVLSazL27Vanx26e1KPiXPQVHPEBkpGGz9SbyVrbhpEOP2EPKnYSdklf2GH6FwOzkcTLaHxS/LrK0rwNHzhL5PnpVd8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405339; c=relaxed/simple;
	bh=/jVcLgbFbY496RecZHjcYFJ5MP92f9ISj2CZ1yQpfCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXhbVds9abz95gUsd9SAOiMSKiV4JyqwL1Qh4LKuKAAHEhxcY/NDxorjb2PKyK/P9Jin9a/uzEFRfxiNXwPcRQh1GD3eqa1GzBpAsR5HIA+AkCS2OJaTBKupgjEzwVUo33RM657MS8yVtV+wC8StrYPZAt10I0kaZh34MPzpxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EnRfXEjV; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <646c1c27-b940-4ece-aa0f-dbeea8aa7de3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751405324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sngN7YcO9+y3E2gnnJ9PKRXKEzOYBz6zNjasxjsvxhs=;
	b=EnRfXEjVSZSFqcEn8DhHCyH84Dc3RopQfQ7PTpE57WL3UpYf+VFli49oUOTqsqiETUvs98
	UFdgMKr6Gftx/Zm2eMsPjkzAVUGDf5T94ECSQgfokDgutuqkk7JaseJ1V3Ru924Jzl24Tm
	zbpK5LD7QuKUkJbXn0B+4VOwUxNaZtE=
Date: Tue, 1 Jul 2025 14:28:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: turn off sanitizer in do_misc_fixups for old clang
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Luis Gerhorst <luis.gerhorst@fau.de>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
References: <20250620113846.3950478-1-arnd@kernel.org>
 <CAADnVQKAT3UPzcpzkJ6_-powz4YTiDAku4-a+++hrhYdJUnLiw@mail.gmail.com>
 <361eb614-e145-49dc-aa32-12f313f61b96@linux.dev>
 <CAEf4BzahSLGiW_F4LtG1tMAb0O1b6D-kO0AcrU2O+nLKVbkvZA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzahSLGiW_F4LtG1tMAb0O1b6D-kO0AcrU2O+nLKVbkvZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/1/25 1:45 PM, Andrii Nakryiko wrote:
> On Tue, Jul 1, 2025 at 1:03 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 6/23/25 2:32 PM, Alexei Starovoitov wrote:
>>> On Fri, Jun 20, 2025 at 4:38 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> clang versions before version 18 manage to badly optimize the bpf
>>>> verifier, with lots of variable spills leading to excessive stack
>>>> usage in addition to likely rather slow code:
>>>>
>>>> kernel/bpf/verifier.c:23936:5: error: stack frame size (2096) exceeds limit (1280) in 'bpf_check' [-Werror,-Wframe-larger-than]
>>>> kernel/bpf/verifier.c:21563:12: error: stack frame size (1984) exceeds limit (1280) in 'do_misc_fixups' [-Werror,-Wframe-larger-than]
>>>>
>>>> Turn off the sanitizer in the two functions that suffer the most from
>>>> this when using one of the affected clang version.
>>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> ---
>>>>    kernel/bpf/verifier.c | 11 +++++++++--
>>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 2fa797a6d6a2..7724c7a56d79 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -19810,7 +19810,14 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>>>           return 0;
>>>>    }
>>>>
>>>> -static int do_check(struct bpf_verifier_env *env)
>>>> +#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 180100
>>>> +/* old clang versions cause excessive stack usage here */
>>>> +#define __workaround_kasan  __disable_sanitizer_instrumentation
>>>> +#else
>>>> +#define __workaround_kasan
>>>> +#endif
>>>> +
>>>> +static __workaround_kasan int do_check(struct bpf_verifier_env *env)
>>> This looks too hacky for a workaround.
>>> Let's figure out what's causing such excessive stack usage and fix it.
>>> We did some of this work in
>>> commit 6f606ffd6dd7 ("bpf: Move insn_buf[16] to bpf_verifier_env")
>>> and similar.
>>> Looks like it wasn't enough or more stack usage crept in since then.
>>>
>>> Also make sure you're using the latest bpf-next.
>>> A bunch of code was moved out of do_check().
>>> So I bet the current bpf-next/master doesn't have a problem
>>> with this particular function.
>>> In my kasan build do_check() is now fully inlined.
>>> do_check_common() is not and it's using 512 bytes of stack.
>>>
>>>>    {
>>>>           bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
>>>>           struct bpf_verifier_state *state = env->cur_state;
>>>> @@ -21817,7 +21824,7 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
>>>>    /* Do various post-verification rewrites in a single program pass.
>>>>     * These rewrites simplify JIT and interpreter implementations.
>>>>     */
>>>> -static int do_misc_fixups(struct bpf_verifier_env *env)
>>>> +static __workaround_kasan int do_misc_fixups(struct bpf_verifier_env *env)
>>> This one is using 832 byte of stack with kasan.
>>> Which is indeed high.
>>> Big chunk seems to be coming from chk_and_sdiv[] and chk_and_smod[].
>>>
>>> Yonghong,
>>> looks like you contributed that piece of code.
>>> Pls see how to reduce stack size here.
>>> Daniel used this pattern in earlier commits. Looks like
>>> we took it too far.
>> With llvm17, I got the following error:
>>
>> /home/yhs/work/bpf-next/kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds limit (1280) in 'bpf_check' [-
>> Werror,-Wframe-larger-than]
>>    24491 | int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
>>          |     ^
>> /home/yhs/work/bpf-next/kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds limit (1280) in 'do_check' [-
>> Werror,-Wframe-larger-than]
>>    19921 | static int do_check(struct bpf_verifier_env *env)
>>          |            ^
>> 2 errors generated.
>>
>> I checked IR and found the following memory allocations which may contribute
>> excessive stack usage:
>>
>> attr.coerce1, i32 noundef %uattr_size) local_unnamed_addr #0 align 16 !dbg !19800 {
>> entry:
>>     %zext_patch.i = alloca [2 x %struct.bpf_insn], align 16, !DIAssignID !19854
>>     %rnd_hi32_patch.i = alloca [4 x %struct.bpf_insn], align 16, !DIAssignID !19855
>>     %cnt.i = alloca i32, align 4, !DIAssignID !19856
>>     %patch.i766 = alloca [3 x %struct.bpf_insn], align 16, !DIAssignID !19857
>>     %chk_and_sdiv.i = alloca [1 x %struct.bpf_insn], align 4, !DIAssignID !19858
>>     %chk_and_smod.i = alloca [1 x %struct.bpf_insn], align 4, !DIAssignID !19859
>>     %chk_and_div.i = alloca [4 x %struct.bpf_insn], align 16, !DIAssignID !19860
>>     %chk_and_mod.i = alloca [4 x %struct.bpf_insn], align 16, !DIAssignID !19861
>>     %chk_and_sdiv343.i = alloca [8 x %struct.bpf_insn], align 16, !DIAssignID !19862
>>     %chk_and_smod472.i = alloca [9 x %struct.bpf_insn], align 16, !DIAssignID !19863
>>     %desc.i = alloca %struct.bpf_jit_poke_descriptor, align 8, !DIAssignID !19864
>>     %target_size.i = alloca i32, align 4, !DIAssignID !19865
>>     %patch.i = alloca [2 x %struct.bpf_insn], align 16, !DIAssignID !19866
>>     %patch355.i = alloca [2 x %struct.bpf_insn], align 16, !DIAssignID !19867
>>     %ja.i = alloca %struct.bpf_insn, align 8, !DIAssignID !19868
>>     %ret_insn.i.i = alloca [8 x i32], align 16, !DIAssignID !19869
>>     %ret_prog.i.i = alloca [8 x i32], align 16, !DIAssignID !19870
>>     %fd.i = alloca i32, align 4, !DIAssignID !19871
>>     %log_true_size = alloca i32, align 4, !DIAssignID !19872
>> ...
>>
>> So yes, chk_and_{div,mod,sdiv,smod} consumes quite some stack and
>> can be coverted to runtime allocation but that is not enough for 1280
>> stack limit, we need to do more conversion from stack to memory
>> allocation. Will try to have uniform way to convert
>> 'alloca [<num> x %struct.bpf_insn]' to runtime allocation.
>>
> Do we need to go all the way to dynamic allocation? See env->insns_buf
> (which some parts of this function are already using for constructing
> instruction patch), let's just converge on that? It pre-allocates
> space for 32 instructions, should be sufficient for all the use cases,
> no?

Make sense. This is much better. Thanks!


