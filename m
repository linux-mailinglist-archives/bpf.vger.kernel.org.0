Return-Path: <bpf+bounces-75649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA883C8F6F8
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 17:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D8184E9D3F
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BCE22759C;
	Thu, 27 Nov 2025 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsPwh5VI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70331A065
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259519; cv=none; b=OR9PzOP+lGND6CNwHjMU211oKDQET8csh29hEnnH7/H3Coh5f3dcLMM+d2wNZ8sh1ECFo8OzLKBfLkRnMv0xLU76VVtRNm6w3wuvX3jEAJxuf2wLvzZL1VizCzzMWQ1CNTRhTf7TpiIQZGhRBW3QabDHVyRF449/KYU3YCdFdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259519; c=relaxed/simple;
	bh=uY/xXOA8P5Foqbjmz6cuCvk5SpgEUlGwQ8BV2UqUE+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc/+TIJPAYLP3qWbkM1neqHYWBj/pqBH6MqdJ/weMFqbZVb2PDebFieVojnVnkFHjk3ioLtS5JJi8owLEcmcb9tSgn9R5wE7Bwtw6TT50OKwaJtTi7KUFOmhY79nZNHhfE9iftt8KZqEGvGQyQnNWEVsmRIHFWvAFFGZOezR/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsPwh5VI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b47f662a0so1104463f8f.0
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764259516; x=1764864316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOK+1h6/kZRYtmUHlxzu95Y/jqjks1Di+JaS1ToZHWw=;
        b=IsPwh5VIrtXR58LReNh39s6tLkfYWz/gQwAsdx2YYCADtrPTMnAO0wVgzyBY5Et+r+
         zstEUoAAI5u9YvyZMcPalq6pJO/rzPZ5+o6eb6LZSW55l9vQ6XltijSNIrk2enjAivz1
         BE2yW61tjsk1VyLGGedJcncuFhSKaFle+m6/xutSF4tRKCnv7nQ6F4H7Mmq7bE1yDs77
         LpZtndg+Qlxq4/4PqL7t+jizk4Ov6tjhajamBP7VRM0Efa86tvdrbR9Exk5kAPqw1Ymn
         sG9DMgPM2nB2icNnpRCKXaVXBTNBYK0sgrycnWvG/BRjK4I4iV3JAnZvu1i+nH2SPiLy
         OPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259516; x=1764864316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOK+1h6/kZRYtmUHlxzu95Y/jqjks1Di+JaS1ToZHWw=;
        b=F5gUKAxO2qzXgp4glhctM0aAq7ElN4wbpDvpFAcDtizLeSwZfLnmV03SulJ8KPkOi5
         9K7wHa0joOgxLyF89xPwMqXIP+y7nA3IWqnAZqhINTNKbuQqvYPvbJyP04R+2Mh3tJNs
         8qKTj9vC51CCdo1xGSPtwphmupl3rnipTEOX9Ewl6AzUX339ITCn4gxBmUEniYtXMeQT
         C/s6UZooBydMYzyX3g9u3O3dSpxrkZi/AbWqi3AHnzGpz0t2WZh0yxAIKekcWhPjn+pF
         1rTp7vGDFK5D2IMgKxbUEveXiWDIa5vInj3A33ColEdyAerl2pDcusVOhMpHI/H5a+y4
         UwkQ==
X-Gm-Message-State: AOJu0Yw6v3Yuc6aSUZP7kbAensz2VW7eXq+O0bMcL+gY7fWtN23chDIO
	ZhVlScJlJxZnJ3ecxCMPWPljEYxlDqW4upOGPwCi8eaEfSfQVJlyVtJn
X-Gm-Gg: ASbGncvzKMVYusv17ci5chidwqt2BeNh9AyTB+83gpUwjxpgAXgE/+i360j/WgjA1Oz
	AGCD5mDgKLnBtRFhvO1rmimC6cgLsiE/mWPe8TrKe8VH7F80nMcDpbxU3yZ8oTyvmD0IuH0lkqi
	ObsAG3dZy/fXlFtQx1IcV8zSstRkVonixTadwFtZMDQFOMNIhTDwjcx3GGHGBHF8eWE2qkX3gW3
	wlTKFv8+aL3JJdDYLdQWjRts7FTTx4DLb5RLMwrsUYmcXrnLtLwp3vx96W9lRV/+ESLptCdxuNY
	2fBSMmXOV9H1+NIm8cVAY26YqtrdA0grwvg0X/qyLF/Tj5xk7woNMDFaF3fCOcXdnp+ooHEKE0Z
	Phrs1SIqIKbVAMLn4hKlDcnmM9YewCopoGamm4EJfM9TvpBP6nBFEO6W9peCTvN/gF/0AdmSzIo
	sRfR52xUELvQDGHg+vCbUg
X-Google-Smtp-Source: AGHT+IEV5bCrmdEECfiP3HhxH/6MOzpxurpVKE2FJKSU1F0avYt0ds3ZA+JgTCooQKFsSGxEH2DA4Q==
X-Received: by 2002:a05:6000:2910:b0:42b:3ed2:c086 with SMTP id ffacd0b85a97d-42cc12f1f36mr26997853f8f.4.1764259515752;
        Thu, 27 Nov 2025 08:05:15 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caa5d02sm4163588f8f.36.2025.11.27.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:05:15 -0800 (PST)
Date: Thu, 27 Nov 2025 16:11:44 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Message-ID: <aSh4QCd27MUHMVdp@mail.gmail.com>
References: <20251127140318.3944249-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127140318.3944249-1-xukuohai@huaweicloud.com>

On 25/11/27 10:03PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>

This patch doesn't apply to bpf-next due to
https://lore.kernel.org/bpf/20251125145857.98134-2-leon.hwang@linux.dev/T/#u

> When BTI is enabled, the indirect jump selftest triggers BTI exception:
> 
> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> ...
> Call trace:
>  bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>  bpf_prog_run_pin_on_cpu+0x140/0x468
>  bpf_prog_test_run_syscall+0x280/0x3b8
>  bpf_prog_test_run+0x22c/0x2c0
>  __sys_bpf+0x4d8/0x5c8
>  __arm64_sys_bpf+0x88/0xa8
>  invoke_syscall+0x80/0x220
>  el0_svc_common+0x160/0x1d0
>  do_el0_svc+0x54/0x70
>  el0_svc+0x54/0x188
>  el0t_64_sync_handler+0x84/0x130
>  el0t_64_sync+0x198/0x1a0
> 
> This happens because no BTI instruction is generated by the JIT for
> indirect jump targets.
> 
> Fix it by emitting BTI instruction for every possible indirect jump
> targets when BTI is enabled. The targets are identified by traversing
> all instruction arrays used by the BPF program, since indirect jump
> targets can only be read from instruction arrays.
> 
> Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 20 ++++++++++++++++
>  include/linux/bpf.h           | 12 ++++++++++
>  kernel/bpf/bpf_insn_array.c   | 43 +++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 929123a5431a..f546df886049 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -78,6 +78,7 @@ static const int bpf2a64[] = {
>  
>  struct jit_ctx {
>  	const struct bpf_prog *prog;
> +	unsigned long *indirect_targets;
>  	int idx;
>  	int epilogue_offset;
>  	int *offset;
> @@ -1199,6 +1200,11 @@ static int add_exception_handler(const struct bpf_insn *insn,
>  	return 0;
>  }
>  
> +static bool maybe_indirect_target(int insn_off, unsigned long *targets_bitmap)

Why "maybe"? (But also see below.)

> +{
> +	return targets_bitmap && test_bit(insn_off, targets_bitmap);
> +}
> +
>  /* JITs an eBPF instruction.
>   * Returns:
>   * 0  - successfully JITed an 8-byte eBPF instruction.
> @@ -1231,6 +1237,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>  	int ret;
>  	bool sign_extend;
>  
> +	if (maybe_indirect_target(i, ctx->indirect_targets))
> +		emit_bti(A64_BTI_J, ctx);
> +
>  	switch (code) {
>  	/* dst = src */
>  	case BPF_ALU | BPF_MOV | BPF_X:
> @@ -2085,6 +2094,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	memset(&ctx, 0, sizeof(ctx));
>  	ctx.prog = prog;
>  
> +	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && bpf_prog_has_insn_array(prog)) {
> +		ctx.indirect_targets = kvcalloc(BITS_TO_LONGS(prog->len), sizeof(unsigned long),
> +						GFP_KERNEL);

It's allocated here on every run, but freed below only when 
!prog->is_func || extra_pass.

> +		if (ctx.indirect_targets == NULL) {
> +			prog = orig_prog;
> +			goto out_off;
> +		}
> +		bpf_prog_collect_indirect_targets(prog, ctx.indirect_targets);
> +	}
> +
>  	ctx.offset = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
>  	if (ctx.offset == NULL) {
>  		prog = orig_prog;
> @@ -2248,6 +2267,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  			prog->aux->priv_stack_ptr = NULL;
>  		}
>  		kvfree(ctx.offset);
> +		kvfree(ctx.indirect_targets);
>  out_priv_stack:
>  		kfree(jit_data);
>  		prog->aux->jit_data = NULL;
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a9b788c7b4aa..c81eb54f7b26 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3822,11 +3822,23 @@ void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
>  
>  #ifdef CONFIG_BPF_SYSCALL
>  void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
> +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap);
> +bool bpf_prog_has_insn_array(const struct bpf_prog *prog);
>  #else
>  static inline void
>  bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
>  {
>  }
> +
> +static inline bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
> +{
> +	return false;
> +}
> +
> +static inline void
> +bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
> +{
> +}
>  #endif
>  
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index 61ce52882632..ed20b186a1f5 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -299,3 +299,46 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
>  		}
>  	}
>  }
> +
> +bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
> +{
> +	int i;
> +
> +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> +		if (is_insn_array(prog->aux->used_maps[i]))
> +			return true;
> +	}
> +	return false;
> +}

I think a different check is needed here (and a different function
name, smth like "bpf_prog_has_indirect_jumps"), and a different
algorithm to collect jump targets in the chunk below. A program can
have instruction arrays not related to indirect jumps (see, e.g.,
bpf_insn_array selftests + in future insns arrays will be used to
also support other functionality). As an extreme case, an insn array
can point to every instruction in a prog, thus a BTI will be
generated for every instruction.

In verifier it is used a bit differently, namely, all insn arrays for
a given subprog are collected when an indirect jump is encountered
(and non-deterministic only in check_cfg). Later in verification, an
exact map is used, so this is not a problem.

Initially I wanted to have a map flag (in map_extra) to distingiush between
different types of instruction arrays ("plane ones", "jump targets",
"call targets", "static keys"), but Andrii wasn't happy with it,
so eventually I've dropped it. Maybe it is worth adding it until
the code is merged to upstream? Eduard, Alexei, wdyt?

> +
> +/*
> + * This function collects possible indirect jump targets in a BPF program. Since indirect jump
> + * targets can only be read from instruction arrays, it traverses all instruction arrays used
> + * by @prog. For each instruction in the arrays, it sets the corresponding bit in @bitmap.
> + */
> +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
> +{
> +	struct bpf_insn_array *insn_array;
> +	struct bpf_map *map;
> +	u32 xlated_off;
> +	int i, j;
> +
> +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> +		map = prog->aux->used_maps[i];
> +		if (!is_insn_array(map))
> +			continue;
> +
> +		insn_array = cast_insn_array(map);
> +		for (j = 0; j < map->max_entries; j++) {
> +			xlated_off = insn_array->values[j].xlated_off;
> +			if (xlated_off == INSN_DELETED)
> +				continue;
> +			if (xlated_off < prog->aux->subprog_start)
> +				continue;
> +			xlated_off -= prog->aux->subprog_start;
> +			if (xlated_off >= prog->len)
> +				continue;
> +			__set_bit(xlated_off, bitmap);
> +		}
> +	}
> +}
> -- 
> 2.47.3
> 

