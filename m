Return-Path: <bpf+bounces-37824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA2D95AD34
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19071C22A08
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 06:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2407136350;
	Thu, 22 Aug 2024 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nFIloQLH"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94D132464
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307009; cv=none; b=Q9t86gkKbp5syn7NLwgrY+IQNSDUJJzyaDN7/Rjx/xWlJO25ohyaswnHJXgM9njIhknQpP+qNH3qZRLGjVuJJGH5DPrk8BASP3sSCeDAmkEGlbPL31g8ni6ndcum6FCsLzdJFFHx54usqEU1XZ0D4VorO3hKy7nOX9h08qzBr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307009; c=relaxed/simple;
	bh=StCk7NBe0GoEPQiW2ZbotMZatd0139H9vjd1vIRB3o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3h5Bw0+Mx4SGKw+9r8oMqNAjczMOPAzSMHa34rVveYLCQ2DyEyf4L/m7smIe3iNfHY8nQaIATzp2Nbje/lPlydFpoPmtPpeXg6dW3FniVWfikDRwIaFGuoZ1/nSbyvyPOiD6qYFXEX6Zb479Iki4Ms6TU64aliaNUrrvyT7AM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nFIloQLH; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a4aa80b-b5fe-4f9a-95a3-743d2a218927@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724307002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=matlTEfoA+BasiBU/QvIlzxU6ucLk9kXpXEJHnid9bQ=;
	b=nFIloQLHfaQQpEAkhnliWCyCTNtCKRBehemOeAzDKfYQTxc7ViOAshAMY4WXIcff48GdeP
	02WbPVhrxWQDVy2sCp9K/D6q2V7mg8RtHkFen0VYOwkxHEhCQKhVABgh8oZOoeXXvkdnnI
	2QmSv/6S6Upfy7Fxla1mCkK+kxQHDaE=
Date: Wed, 21 Aug 2024 23:09:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: Allow pro/epilogue to call kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 Kernel Team <kernel-team@meta.com>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
 <20240821233440.1855263-8-martin.lau@linux.dev>
 <CAADnVQK4LUVsKQYHdaw0x9-CryA0wQX6stkvhFnNoDh1tt0jhg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQK4LUVsKQYHdaw0x9-CryA0wQX6stkvhFnNoDh1tt0jhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/21/24 6:32 PM, Alexei Starovoitov wrote:
> On Wed, Aug 21, 2024 at 4:35 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> The existing prologue has been able to call bpf helper but not a kfunc.
>> This patch allows the prologue/epilogue to call the kfunc.
>>
>> The subsystem that implements the .gen_prologue and .gen_epilogue
>> can add the BPF_PSEUDO_KFUNC_CALL instruction with insn->imm
>> set to the btf func_id of the kfunc call. This part is the same
>> as the bpf prog loaded from the sys_bpf.
> 
> I don't understand the value of this feature, since it seems
> pretty hard to use.
> The module (qdisc-bpf or else) would need to do something
> like patch 8/8:
> +BTF_ID_LIST(st_ops_epilogue_kfunc_list)
> +BTF_ID(func, bpf_kfunc_st_ops_inc10)
> +BTF_ID(func, bpf_kfunc_st_ops_inc100)
> 
> just to be able to:
>    BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
>                 st_ops_epilogue_kfunc_list[0]);
> 
> So a bunch of extra work on the module side and
> a bunch of work in this patch to enable such a pattern,
> but what is the value?
> 
> gen_epilogue() can call arbitrary kernel function.
> It doesn't have to be a helper.
> kfunc-s provide calling convention conversion from bpf to native,
> but the same thing is achieved by BPF_CALL_N macro.
> The module can use that macro without adding an actual bpf helper
> to uapi bpf.h.
> Then in gen_epilogue() the extra bpf insn can use:
> BPF_EMIT_CALL(module_provided_helper_that_is_not_helper)
> which will use
> BPF_CALL_IMM(x) ((void *)(x) - (void *)__bpf_call_base)

BPF_EMIT_CALL() was my earlier thought. I switched to the kfunc in this patch 
because of the bpf_jit_supports_far_kfunc_call() support for the kernel module. 
Using kfunc call will make supporting it the same.

I think the future bpf-qdisc can enforce built-in. bpf-tcp-cc has already been 
built-in only also. I think the hid_bpf is built-in only also.

Another consideration is also holding the module refcnt when having an 
attachable bpf prog calling a kernel func implemented in a kernel module. iiuc, 
this is the reason why aux->kfunc_btf_tab holds a reference to the kernel 
module. This should not be a problem to struct_ops though because the struct_ops 
map is the one that is attachable instead of the struct_ops prog. The struct_ops 
map has already held a refcnt of the module.

> to populate imm.
> And JITs will emit jump to that wrapper code provided by
> BPF_CALL_N.
> 
> And no need for this extra complexity in the verifier and
> its consumers that have to figure out (module_fd, btf_id) for
> kfunc just to fit into kfunc pattern with btf_distill_func_proto().
> 
> I guess one can argue that if such kfunc is already available
> to bpf prog then extra BPF_CALL_N wrapper for the same thing
> is a waste of kernel text, but this patch also adds quite a bit of
> kernel text. So the cost of BPF_CALL_N (which is a zero on x86)
> is acceptable.


