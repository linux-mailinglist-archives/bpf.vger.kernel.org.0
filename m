Return-Path: <bpf+bounces-35652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6583193C68A
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1B5284819
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7510E19D064;
	Thu, 25 Jul 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h/7N/i/Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBA1D545
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921709; cv=none; b=R3Z8+3zguiq2f61QbmgAAybQfcxCmgh7SUmR9Pw6IlSucAXPSFcsRg5Aq+kZRi4Y6iO6yY4vOzn73SZWE7C8YqlUIzHTfYn6ECQ9B1LnfrPXymsIN29JHyC+StnBiYiQsG515hFu33nBxjC2VEUxVbMgRkKE5uRzdaCQ3EXZBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921709; c=relaxed/simple;
	bh=kt3iTDmF3H+kLXA+2OD92SVdv2K4pgSMs7zaUnb5xTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJkPHPPj2JgCvV6vJQnwRFKRBw2f78buAiyf/sy1vNCc0+5hFu8LV/MrVPxUjr2mqFCgFtLa06JFV+3zoHkKRWpB+olN5YZ6htfsHM4XnT/u+lgMGlY2N99v1y5/2ez9r7+ig8kGMuCG6OWnM+ETillNpfSWsCuNvHVh0sWCC+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h/7N/i/Q; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36c0e452-a7fd-4abd-bc53-5c879492180f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721921703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZmf2DXKxNdIF5DA020QdOyZqdwtuFRd9O0TICbTlq0=;
	b=h/7N/i/QD3tQlGtWjIBlF2IvCpkBudgOH3WXGsNbBpIkyap6TdjlYEMeo1OnVLJw6oZUvO
	Z30g2CgH+XPCb8+dniaw69Fh2C81F2+OptHm6Y6aoHT/6lQ+t68UXGFLX8EiZCnpju2+Fz
	FRwmpPJxGi0sqYTsUCEoSUdtxFz60jw=
Date: Thu, 25 Jul 2024 08:34:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf: make function do_misc_fixups as
 noinline_for_stack
Content-Language: en-GB
To: Hao Peng <flyingpenghao@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 Peng Hao <flyingpeng@tencent.com>
References: <20240711054525.20748-1-flyingpeng@tencent.com>
 <CAADnVQJ+UxmOe_G+UL_wFEZOFTVL4XQ=D8X1N29CT=zHNmi6NQ@mail.gmail.com>
 <CAPm50aLhVegFY=H=PTGD3+Ny_KFszWn5bNiCzwyV39z_j2QnQA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAPm50aLhVegFY=H=PTGD3+Ny_KFszWn5bNiCzwyV39z_j2QnQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/24/24 11:18 PM, Hao Peng wrote:
> On Sat, Jul 13, 2024 at 12:43 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Wed, Jul 10, 2024 at 10:45 PM <flyingpenghao@gmail.com> wrote:
>>>
>>> By tracing the call chain, we found that do_misc_fixups consumed a lot
>>> of stack space. mark it as noinline_for_stack to prevent it from spreading
>>> to bpf_check's stack size.
>> ...
>>> -static int do_misc_fixups(struct bpf_verifier_env *env)
>>> +static noinline_for_stack int do_misc_fixups(struct bpf_verifier_env *env)
>> Now we're getting somewhere, but this is not a fix.
>> It may shut up the warn, but it will only increase the total stack usage.
>> Looking at C code do_misc_fixups() needs ~200 bytes worth of stack
>> space for insn_buf[16] and spill/fill.
>> That's far from the artificial 2k limit.
>>
>> Please figure out what exact variable is causing kasan to consume
>> so much stack. You may need to analyze compiler internals and
>> do more homework.
>> What is before/after stack usage ? with and without kasan?
>> With gcc try
>> +CFLAGS_verifier.o += -fstack-usage
>>
>> I see:
>> sort -k2 -n kernel/bpf/verifier.su |tail -10
>> ../kernel/bpf/verifier.c:13087:12:adjust_ptr_min_max_vals    240
>> dynamic,bounded
>> ../kernel/bpf/verifier.c:20804:12:do_check_common    248    dynamic,bounded
>> ../kernel/bpf/verifier.c:19151:12:convert_ctx_accesses    256    static
>> ../kernel/bpf/verifier.c:7450:12:check_mem_reg    256    static
>> ../kernel/bpf/verifier.c:7482:12:check_kfunc_mem_size_reg    256    static
>> ../kernel/bpf/verifier.c:10268:12:check_helper_call.isra    272
>> dynamic,bounded
>> ../kernel/bpf/verifier.c:21562:5:bpf_check    296    dynamic,bounded
>> ../kernel/bpf/verifier.c:19860:12:do_misc_fixups    320    static
>> ../kernel/bpf/verifier.c:13991:12:adjust_reg_min_max_vals    392    static
>> ../kernel/bpf/verifier.c:12280:12:check_kfunc_call.isra    408
>> dynamic,bounded
>>
>> do_misc_fixups() is not the smallest, but not that large either.
>>
> If I use gcc, I get the same result as you, but if I use llvm to build
> the kernel, the result is like this：
> # sort -k2 -n kernel/bpf/verifier.su | tail -10
> kernel/bpf/verifier.c:14026:adjust_reg_min_max_vals     440     static
> kernel/bpf/verifier.c:7432:check_mem_reg        440     static
> kernel/bpf/verifier.c:15955:check_cfg   472     static
> kernel/bpf/verifier.c:7464:check_kfunc_mem_size_reg     472     static
> kernel/bpf/verifier.c:15104:check_cond_jmp_op   504     static
> kernel/bpf/verifier.c:4166:__mark_chain_precision       504     static
> kernel/bpf/verifier.c:10239:check_helper_call   536     static
> kernel/bpf/verifier.c:17744:do_check    792     static
> kernel/bpf/verifier.c:12248:check_kfunc_call    984     static
> kernel/bpf/verifier.c:21486:bpf_check   2456    static
>
> Obviously, do_misc_fixups is automatically inlined into bpf_check.
> So adding noinline_for_stack to the do_misc_fixups function is a solution.

Looks like you are building your own kernel with KASAN.
You can change config CONFIG_FRAME_WARN value. In your config file you
have CONFIG_FRAME_WARN=2048. You can change it to
CONFIG_FRAME_WARN=4096 which should fix the issue.

>
> Thanks.
>
>> Do in-depth analysis instead of silencing the warn.
>>
>> pw-bot: cr

