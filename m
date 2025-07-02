Return-Path: <bpf+bounces-62117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BCBAF5ACC
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D5A48648A
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CD22BE7D0;
	Wed,  2 Jul 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AggipgHW"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556422BD5B5
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465668; cv=none; b=SkscNf7GHzrkKIetEvNH+EzgYnJTiwo3YuPPIBCXDMm1crqQ+b+a39FGGYfS3l8oO7+ZrMOd7S963T8y/XaNYJI+O+VGc0yg+uKviYDzmAqNYsH+B1w8y5xxEa0JVXKVdM0FM96Ct8TM+kiIK5N9BOqCZ31rndLMa7b+kzfhpUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465668; c=relaxed/simple;
	bh=zqKGhMgZTNKn8t9nNqOSQ0vaSPiBBITK2Mwmm0guxPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSWxQW6lg5n8dqel0GnlBq4CzzNn8txo5gcAW4LarAP42JQ/AYFc5nr76eFWWZvVQofesiFHz8M9xD1MOnPt6DRBHCpvQYpPuWZGJSQV/WRQAgXTwUSegn0zrcz8Jl46zAQ4Ksa7qEZoN0xFOtsbUgu0tTFt1wYMjttaPTJkHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AggipgHW; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a8ea0565-e20d-4019-a64b-fa8020866411@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751465653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uQFp4cJ8AYYwMC7A3lrbx+MnxlYvEYEmihK/yWxec8=;
	b=AggipgHWO0jdRYz0u1A4o9IuVGIUox6XdD/xi0R/d6J6bhOmrOrOr1EYpHWE0DyawWIISL
	aq8S/Nw40+gThtNLeZTlRVfpSm7YmtQ0b1ttiCHmMapXtsmm3EOWRYT1vDv0QJKHYW5xD7
	+6k76+6P75Nfr0qiXUPN0e9Vo8PgH54=
Date: Wed, 2 Jul 2025 07:14:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: turn off sanitizer in do_misc_fixups for old clang
Content-Language: en-GB
To: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
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
 <646c1c27-b940-4ece-aa0f-dbeea8aa7de3@linux.dev>
 <eb4b4473-c75e-4bfa-9a16-19a5256a558d@app.fastmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <eb4b4473-c75e-4bfa-9a16-19a5256a558d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/2/25 12:48 AM, Arnd Bergmann wrote:
> On Tue, Jul 1, 2025, at 23:28, Yonghong Song wrote:
>> On 7/1/25 1:45 PM, Andrii Nakryiko wrote:
>>> On Tue, Jul 1, 2025 at 1:03 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> On 6/23/25 2:32 PM, Alexei Starovoitov wrote:
>>>>> On Fri, Jun 20, 2025 at 4:38 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>> I checked IR and found the following memory allocations which may contribute
>>>> excessive stack usage:
>>>>
>>>> attr.coerce1, i32 noundef %uattr_size) local_unnamed_addr #0 align 16 !dbg !19800 {
>>>> entry:
>>>>      %zext_patch.i = alloca [2 x %struct.bpf_insn], align 16, !DIAssignID !19854
>>>>      %rnd_hi32_patch.i = alloca [4 x %struct.bpf_insn], align 16, !DIAssignID !19855
>>>>      %cnt.i = alloca i32, align 4, !DIAssignID !19856
>>>>      %patch.i766 = alloca [3 x %struct.bpf_insn], align 16, !DIAssignID !19857
>>>>      %chk_and_sdiv.i = alloca [1 x %struct.bpf_insn], align 4, !DIAssignID !19858
>>>>      %chk_and_smod.i = alloca [1 x %struct.bpf_insn], align 4, !DIAssignID !19859
>>>>      %chk_and_div.i = alloca [4 x %struct.bpf_insn], align 16, !DIAssignID !19860
>>>>      %chk_and_mod.i = alloca [4 x %struct.bpf_insn], align 16, !DIAssignID !19861
>>>>      %chk_and_sdiv343.i = alloca [8 x %struct.bpf_insn], align 16, !DIAssignID !19862
>>>>      %chk_and_smod472.i = alloca [9 x %struct.bpf_insn], align 16, !DIAssignID !19863
>>>>      %desc.i = alloca %struct.bpf_jit_poke_descriptor, align 8, !DIAssignID !19864
>>>>      %target_size.i = alloca i32, align 4, !DIAssignID !19865
>>>>      %patch.i = alloca [2 x %struct.bpf_insn], align 16, !DIAssignID !19866
>>>>      %patch355.i = alloca [2 x %struct.bpf_insn], align 16, !DIAssignID !19867
>>>>      %ja.i = alloca %struct.bpf_insn, align 8, !DIAssignID !19868
>>>>      %ret_insn.i.i = alloca [8 x i32], align 16, !DIAssignID !19869
>>>>      %ret_prog.i.i = alloca [8 x i32], align 16, !DIAssignID !19870
>>>>      %fd.i = alloca i32, align 4, !DIAssignID !19871
>>>>      %log_true_size = alloca i32, align 4, !DIAssignID !19872
>>>> ...
>>>>
>>>> So yes, chk_and_{div,mod,sdiv,smod} consumes quite some stack and
>>>> can be coverted to runtime allocation but that is not enough for 1280
>>>> stack limit, we need to do more conversion from stack to memory
>>>> allocation. Will try to have uniform way to convert
>>>> 'alloca [<num> x %struct.bpf_insn]' to runtime allocation.
>>>>
>>> Do we need to go all the way to dynamic allocation? See env->insns_buf
>>> (which some parts of this function are already using for constructing
>>> instruction patch), let's just converge on that? It pre-allocates
>>> space for 32 instructions, should be sufficient for all the use cases,
>>> no?
>> Make sense. This is much better. Thanks!
> I'm not sure if that actually helps on the old clang version, as far
> as I understood it in my initial analysis, the problem in the
>
> struct bpf_insn chk_and_sdiv[] = {
>                                  /* [R,W]x sdiv 0 -> 0
>                                   * LLONG_MIN sdiv -1 -> LLONG_MIN
>                                   * INT_MIN sdiv -1 -> INT_MIN
>                                   */
>                                  BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
> ...
> }
>
> construct is not the chk_and_sdiv[] array itself but the
> struct initializer in the BPF_MOV64_REG() macro that leads to
> having two copies of the struct on the stack and then copying
> between them. In gcc or clang-18+, these all get folded
> into a single object on the stack.

See https://lore.kernel.org/bpf/20250702053332.1991516-1-yonghong.song@linux.dev/.
The above 'struct bpf_insn chk_and_sdiv[] = { ... }' will be removed so
there will not be stack consumption any more for it. Instead, we use
the scratch space in bpf_verifier_env.

>
> (Disclaimer: I don't understand anything about how clang
> actually works internally, the above is only speculation on
> my side, based on the assembler output)
>
>        Arnd


