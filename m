Return-Path: <bpf+bounces-78989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F036D22E31
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A18923036AC1
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 07:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0149288D0;
	Thu, 15 Jan 2026 07:37:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70781DF75D;
	Thu, 15 Jan 2026 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462678; cv=none; b=HoqBEbg/saaO+rKQ4Ts8wMzXvHvQHv2d8ezu659lWZG9eP/X2LqnXExyVSTlj2xTeLIhUP3yfzoiENcaV86XxpHslOfNB8cvpQqCSZ2XX8OTyyYLcm6EnBiWW3PNXG3tYnOIGjXpudwwjoFPilsZrfR9llmMy+BZNH0ofrs3fQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462678; c=relaxed/simple;
	bh=nNyJAR07RrdZRX5Vh5dAJjcRBgnNCwnJrXjwgx7MaSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xfodf7nMIVpqfLxjF2euwoGNlmgj8DBjFEjQ3DeBnuneu11G9L5lsXWl2jzzjF1nIFwof/WhFMcUgrBbg8kIkObqKlYYi0E7+jmesYrznIX/GPjezP9EmnAk7sh6DiQG+pGhT81BgutKO4x3fj9emlq5CJlKgfEMAybVTaiWN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dsFDW1vFCzKHMcR;
	Thu, 15 Jan 2026 15:36:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8507340579;
	Thu, 15 Jan 2026 15:37:52 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBHYoFQmWhpR0xLDw--.58709S2;
	Thu, 15 Jan 2026 15:37:52 +0800 (CST)
Message-ID: <8d219c57-28d7-42be-93ec-7252b32239fb@huaweicloud.com>
Date: Thu, 15 Jan 2026 15:37:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Add helper to detect indirect jump
 targets
Content-Language: en-US
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>
References: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
 <20260114093914.2403982-3-xukuohai@huaweicloud.com>
 <aWd3WBMVjpaFw39w@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <aWd3WBMVjpaFw39w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHYoFQmWhpR0xLDw--.58709S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW8Gry3Jw1kAF43Kw1rJFb_yoWxGF1rpF
	WkXa97AF45Xr4DtwnrZF1qyF1agw40g3srK3yUJay8Awn09rn5GF4jkFWSga4Ykryjkr1x
	ZFWjvrsrur4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 1/14/2026 7:00 PM, Anton Protopopov wrote:

[...]

>> +
>> +bool bpf_insn_is_indirect_target(const struct bpf_prog *prog, int idx)
>> +{
>> +	return prog->aux->insn_aux && prog->aux->insn_aux[idx].indirect_target;
> 
> Is there a case when insn_aux is NULL?
>

It is NULL when there is no indirect jump targets for the bpf prog, see the
has_indirect_target test in clone_insn_aux_data.

>> +}
>>   #endif /* CONFIG_BPF_JIT */
>>   
>>   /* Base function for offset calculation. Needs to go into .text section,
>> @@ -2540,24 +2579,24 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>>   	if (!bpf_prog_is_offloaded(fp->aux)) {
>>   		*err = bpf_prog_alloc_jited_linfo(fp);
>>   		if (*err)
>> -			return fp;
>> +			goto free_insn_aux;
>>   
>>   		fp = bpf_int_jit_compile(fp);
>>   		bpf_prog_jit_attempt_done(fp);
>>   		if (!fp->jited && jit_needed) {
>>   			*err = -ENOTSUPP;
>> -			return fp;
>> +			goto free_insn_aux;
>>   		}
>>   	} else {
>>   		*err = bpf_prog_offload_compile(fp);
>>   		if (*err)
>> -			return fp;
>> +			goto free_insn_aux;
>>   	}
>>   
>>   finalize:
>>   	*err = bpf_prog_lock_ro(fp);
>>   	if (*err)
>> -		return fp;
>> +		goto free_insn_aux;
>>   
>>   	/* The tail call compatibility check can only be done at
>>   	 * this late stage as we need to determine, if we deal
>> @@ -2566,6 +2605,10 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>>   	 */
>>   	*err = bpf_check_tail_call(fp);
>>   
>> +free_insn_aux:
>> +	vfree(fp->aux->insn_aux);
>> +	fp->aux->insn_aux = NULL;
>> +
>>   	return fp;
>>   }
>>   EXPORT_SYMBOL_GPL(bpf_prog_select_runtime);
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 22605d9e0ffa..f2fe6baeceb9 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3852,6 +3852,11 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
>>   	return env->insn_aux_data[insn_idx].jmp_point;
>>   }
>>   
>> +static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
>> +{
>> +	env->insn_aux_data[idx].indirect_target = true;
>> +}
>> +
>>   #define LR_FRAMENO_BITS	3
>>   #define LR_SPI_BITS	6
>>   #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
>> @@ -20337,6 +20342,7 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>>   	}
>>   
>>   	for (i = 0; i < n; i++) {
> 
> ^ n -> n-1
>

ACK

>> +		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>>   		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
>>   					  env->insn_idx, env->cur_state->speculative);
>>   		if (IS_ERR(other_branch))
>> @@ -21243,6 +21249,37 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
>>   	}
> 
> mark_indirect_target(n-1)
> 
>>   }
>>   
>> +static int clone_insn_aux_data(struct bpf_prog *prog, struct bpf_verifier_env *env, u32 off)
>> +{
>> +	u32 i;
>> +	size_t size;
>> +	bool has_indirect_target = false;
>> +	struct bpf_insn_aux_data *insn_aux;
>> +
>> +	for (i = 0; i < prog->len; i++) {
>> +		if (env->insn_aux_data[off + i].indirect_target) {
>> +			has_indirect_target = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	/* insn_aux is copied into bpf_prog so the JIT can check whether an instruction is an
>> +	 * indirect jump target. If no indirect jump targets exist, copying is unnecessary.
>> +	 */
>> +	if (!has_indirect_target)
>> +		return 0;
>> +
>> +	size = array_size(sizeof(struct bpf_insn_aux_data), prog->len);
>> +	insn_aux = vzalloc(size);
>> +	if (!insn_aux)
>> +		return -ENOMEM;
>> +
>> +	memcpy(insn_aux, env->insn_aux_data + off, size);
>> +	prog->aux->insn_aux = insn_aux;
>> +
>> +	return 0;
>> +}
>> +
>>   /* single env->prog->insni[off] instruction was replaced with the range
>>    * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
>>    * [0, off) and [off, end) to new locations, so the patched range stays zero
>> @@ -22239,6 +22276,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   		if (!i)
>>   			func[i]->aux->exception_boundary = env->seen_exception;
>>   
>> +		err = clone_insn_aux_data(func[i], env, subprog_start);
>> +		if (err < 0)
>> +			goto out_free;
>> +
>>   		/*
>>   		 * To properly pass the absolute subprog start to jit
>>   		 * all instruction adjustments should be accumulated
>> @@ -22306,6 +22347,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   	for (i = 0; i < env->subprog_cnt; i++) {
>>   		func[i]->aux->used_maps = NULL;
>>   		func[i]->aux->used_map_cnt = 0;
>> +		vfree(func[i]->aux->insn_aux);
>> +		func[i]->aux->insn_aux = NULL;
>>   	}
>>   
>>   	/* finally lock prog and jit images for all functions and
>> @@ -22367,6 +22410,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   	for (i = 0; i < env->subprog_cnt; i++) {
>>   		if (!func[i])
>>   			continue;
>> +		vfree(func[i]->aux->insn_aux);
>>   		func[i]->aux->poke_tab = NULL;
>>   		bpf_jit_free(func[i]);
>>   	}
>> @@ -25350,6 +25394,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>>   	env->verification_time = ktime_get_ns() - start_time;
>>   	print_verification_stats(env);
>>   	env->prog->aux->verified_insns = env->insn_processed;
>> +	env->prog->aux->insn_aux = env->insn_aux_data;
>>   
>>   	/* preserve original error even if log finalization is successful */
>>   	err = bpf_vlog_finalize(&env->log, &log_true_size);
>> @@ -25428,7 +25473,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>>   	if (!is_priv)
>>   		mutex_unlock(&bpf_verifier_lock);
>>   	clear_insn_aux_data(env, 0, env->prog->len);
>> -	vfree(env->insn_aux_data);
>> +	/* on success, insn_aux_data will be freed by bpf_prog_select_runtime */
>> +	if (ret) {
>> +		vfree(env->insn_aux_data);
>> +		env->prog->aux->insn_aux = NULL;
>> +	}
>>   err_free_env:
>>   	bpf_stack_liveness_free(env);
>>   	kvfree(env->cfg.insn_postorder);
>> -- 
>> 2.47.3
>>
> 
> LGTM, just in case, could you please tell how you have tested
> this patchset exactly?

I ran test_progs-cpuv4 on machines supporting x86 CET/IBT and arm64 BTI. I tested in three
environments: an arm64 physical machine with BTI support (CPU: Hisilicon KP920B), an arm64
QEMU VM using cpu=max for BTI support, and a Bochs VM with model=arrow_lake for x86 CET/IBT
support.


