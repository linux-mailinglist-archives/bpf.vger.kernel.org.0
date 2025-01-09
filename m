Return-Path: <bpf+bounces-48319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC249A069DD
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 01:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615A018891BC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 00:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6B71FDA;
	Thu,  9 Jan 2025 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NVY7nGea"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3836D
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736382043; cv=none; b=Ah4A24qc3mNWcfer2Eb1RemyL9x+RGqP7xe0S+aVbtRd3fY4DomHWkv0pFdi8dcJTDZFTUJv04Kvm/neWw4CCLYYS3e3LRPgY5nv/DdHz0bEobAgR4iyL7S++h7K1MM3IQyncbSYRdH/Wm0lsPBndATcDXSPntmyPOuXx+eN2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736382043; c=relaxed/simple;
	bh=M6vl0RMK+ho5HYPkE0qG/6MXqpDkopAitRRlUbB2JHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXxCCloHhWMNu3LjsspFHcdxqW2u0LbvV0og8mguV/KBSahT2Vvl1s2vI9C1/GUo8yJ8Wz8MGmv3gTshbE2nroDri+XBTlM7J9CMVdm9SIIyWb6PABxXjioM16SeUBQ023fKXAaRa5WjDAYjOFFUaOtNThlkiOLNgSWsjCB3ucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NVY7nGea; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3961c9ce-21d3-4a35-956c-5e1a6eb6031b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736382029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COsGZGkKQF0TN0B0u/zldHpm4WzP2FBRThAycZ11GDk=;
	b=NVY7nGeaE8XaJMjQzLnJvtYht1ViHyPauG7fWnbmlONe2C44uJG/QZ9+TfOi09EbGAVLEx
	Y1pTloiq0MBc0OrF9LF6WRO878P8K2hfATklyoMu7OS7suKveFEdCKDTp7+ng3XW6Z6bjH
	RoIGZB02d5OWdb1vGGIg3Q80cgh72C0=
Date: Wed, 8 Jan 2025 16:20:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 08/14] bpf: net_sched: Add a qdisc watchdog
 timer
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 amery.hung@bytedance.com
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-9-amery.hung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241220195619.2022866-9-amery.hung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/24 11:55 AM, Amery Hung wrote:
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index 1c92bfcc3847..bbe7aded6f24 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -8,6 +8,10 @@
>   
>   static struct bpf_struct_ops bpf_Qdisc_ops;
>   
> +struct bpf_sched_data {
> +	struct qdisc_watchdog watchdog;
> +};
> +
>   struct bpf_sk_buff_ptr {
>   	struct sk_buff *skb;
>   };
> @@ -108,6 +112,46 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
>   	return 0;
>   }
>   
> +BTF_ID_LIST(bpf_qdisc_init_prologue_ids)
> +BTF_ID(func, bpf_qdisc_init_prologue)
> +
> +static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
> +				  const struct bpf_prog *prog)
> +{
> +	struct bpf_insn *insn = insn_buf;
> +
> +	if (strcmp(prog->aux->attach_func_name, "init"))
> +		return 0;
> +
> +	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
> +	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);

I was wondering if patch 7 is needed if BPF_EMIT_CALL() and BPF_CALL_1() were 
used, so it looks more like a bpf helper instead of kfunc. I tried but failed at 
the "fn = env->ops->get_func_proto(insn->imm, env->prog);" in do_misc_fixups(). 
I think the change in patch 7 is simple enough instead of getting 
get_func_proto() works for this case.

> +	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> +	*insn++ = prog->insnsi[0];
> +
> +	return insn - insn_buf;
> +}
> +
> +BTF_ID_LIST(bpf_qdisc_reset_destroy_epilogue_ids)
> +BTF_ID(func, bpf_qdisc_reset_destroy_epilogue)
> +
> +static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
> +				  s16 ctx_stack_off)
> +{
> +	struct bpf_insn *insn = insn_buf;
> +
> +	if (strcmp(prog->aux->attach_func_name, "reset") &&
> +	    strcmp(prog->aux->attach_func_name, "destroy"))
> +		return 0;
> +
> +	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
> +	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
> +	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_reset_destroy_epilogue_ids[0]);
> +	*insn++ = BPF_EXIT_INSN();
> +
> +	return insn - insn_buf;
> +}
> +

