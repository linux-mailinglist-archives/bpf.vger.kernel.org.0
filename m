Return-Path: <bpf+bounces-37324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB17953D38
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3B01C24827
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6C1547EB;
	Thu, 15 Aug 2024 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+jeAP0R"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D8154456
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760063; cv=none; b=Y+KNvQygUbY6phVe1cvcl+NnYeZAi7WbtZztMO05xehkbOrtuheh7EaN/wAyTPE8zKvxgeduAtP4nE/BUytGWFQA3VWSiq8ha6dx3Hekjj7sPZxpgJUlyh87byyB58fjrL6THcaMB2ZejdiwU7zN/LMoPVhHPfID8KO6t9SMiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760063; c=relaxed/simple;
	bh=62RcMdgSn3oo3tSBy6DL778qabCdkvItbw5J2IqLDV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qorPUFM3r9ZIdMUvk086K8PhfAcRDezuGL9OmHmlxu/cNqtt/r46+ygZFbVvmqIiy7vxBkJIQmvoy9BFonS7XRo+0uVUl6miGTvghJZnnKoZWIe5h0P35vvnoSs8b9vEkBfeuJfQXQ6Gv7ihC32VLK56QOub8qJ8yWx3epxCMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+jeAP0R; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a912370d-0812-48ee-aaf5-8dbeddc8fefa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723760058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEGo0P6wJ3ynBWQNFoBSMJkQbbLm9oZkOQkRexkLPGE=;
	b=A+jeAP0R79ZtEAoMtchEr1pgPCAg5uyaURIJWXKTRzOezGs4y8zuWqzd6MVwLv9llwllU/
	7ymj/c5bMJUaqNyEk9MyJrtgxq0XkIY9Mh+Nz1Lk1tg7QRolFW5GKL/pWtyndj3oKkTG3T
	fst5eRyHnpzF4iqOGiwseVcbkb8O95k=
Date: Thu, 15 Aug 2024 15:14:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/6] bpf: Add gen_epilogue to
 bpf_verifier_ops
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 kernel-team@meta.com
References: <20240813184943.3759630-1-martin.lau@linux.dev>
 <20240813184943.3759630-2-martin.lau@linux.dev>
 <19903da56fbfb99e4ad6fdea646aaff885e9fd4d.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <19903da56fbfb99e4ad6fdea646aaff885e9fd4d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/14/24 1:56 PM, Eduard Zingerman wrote:
> On Tue, 2024-08-13 at 11:49 -0700, Martin KaFai Lau wrote:
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> This patch adds a .gen_epilogue to the bpf_verifier_ops. It is similar
>> to the existing .gen_prologue. Instead of allowing a subsystem
>> to run code at the beginning of a bpf prog, it allows the subsystem
>> to run code just before the bpf prog exit.
>>
>> One of the use case is to allow the upcoming bpf qdisc to ensure that
>> the skb->dev is the same as the qdisc->dev_queue->dev. The bpf qdisc
>> struct_ops implementation could either fix it up or drop the skb.
>> Another use case could be in bpf_tcp_ca.c to enforce snd_cwnd
>> has sane value (e.g. non zero).
>>
>> The epilogue can do the useful thing (like checking skb->dev) if it
>> can access the bpf prog's ctx. Unlike prologue, r1 may not hold the
>> ctx pointer. This patch saves the r1 in the stack if the .gen_epilogue
>> has returned some instructions in the "epilogue_buf".
>>
>> The existing .gen_prologue is done in convert_ctx_accesses().
>> The new .gen_epilogue is done in the convert_ctx_accesses() also.
>> When it sees the (BPF_JMP | BPF_EXIT) instruction, it will be patched
>> with the earlier generated "epilogue_buf". The epilogue patching is
>> only done for the main prog.
>>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
> 
> Apart from the note below I don't see any obvious problems with this code.
> 
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19610,15 +19610,37 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>>    */
>>   static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>   {
>> +	struct bpf_subprog_info *subprogs = env->subprog_info;
>>   	const struct bpf_verifier_ops *ops = env->ops;
>> -	int i, cnt, size, ctx_field_size, delta = 0;
>> +	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
>>   	const int insn_cnt = env->prog->len;
>> -	struct bpf_insn insn_buf[16], *insn;
>> +	struct bpf_insn insn_buf[16], epilogue_buf[16], *insn;
>>   	u32 target_size, size_default, off;
>>   	struct bpf_prog *new_prog;
>>   	enum bpf_access_type type;
>>   	bool is_narrower_load;
>>   
>> +	if (ops->gen_epilogue) {
>> +		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
>> +						 -(subprogs[0].stack_depth + 8));
>> +		if (epilogue_cnt >= ARRAY_SIZE(epilogue_buf)) {
>> +			verbose(env, "bpf verifier is misconfigured\n");
>> +			return -EINVAL;
>> +		} else if (epilogue_cnt) {
>> +			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
>> +			cnt = 0;
>> +			subprogs[0].stack_depth += 8;
> 
> Note: two other places that allocate additional stack
>        (optimize_bpf_loop(), do_misc_fixups())
>        also bump 'env->prog->aux->stack_depth'.

Thanks for pointing it out.

In this case, I will stay with calling .gen_epilogue in convert_ctx_accesses().

> 
>> +			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
>> +						      -subprogs[0].stack_depth);
>> +			insn_buf[cnt++] = env->prog->insnsi[0];
>> +			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
>> +			if (!new_prog)
>> +				return -ENOMEM;
>> +			env->prog = new_prog;
>> +			delta += cnt - 1;
>> +		}
>> +	}
>> +
> 
> [...]
> 


