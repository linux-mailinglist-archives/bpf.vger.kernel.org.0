Return-Path: <bpf+bounces-62085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C78AF0E7F
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 10:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36401793B0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 08:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4759223C8A1;
	Wed,  2 Jul 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceOuNTly"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F1E236454
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446461; cv=none; b=srgUm04x0aeIERpXDEwI9ilnXNeaXSr2gskC3lQHY8bHPr9vfEfZzIrcWw4CJsS0KMWwUsQEJ3T+JtLuQuctfrE8WDucfz62k2vgyHie118gjuznd00z0+ofOX6jfTy7YNtUrfL+Esm+o3B6+Dqv98xUCScuamOvDjEQLa9mem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446461; c=relaxed/simple;
	bh=kAxB29VFZvdaHJcaNtm+xRy3mTiUQuLaGAUck4z2L6Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsHTDd+Lq07DBg4Aj5gW1RbQ41gBXsFjU2YOqg/yemNZe8vasUN2rC84/KMk4uRkn+iQ5IShZCOPRsREkQLTYcLhTEYZk2hCB1HVKmZs3xBYOciwxGJyrF+m1gUE8wzWUI/IAL1mWpCLU7PqRDXietB6JwyrjGurlhSFDLOffmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceOuNTly; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae361e8ec32so924127866b.3
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751446458; x=1752051258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXD83iZCDcIPtJInbWN8r+M3NudWak+IJ2Gonpxii5M=;
        b=ceOuNTlyiAVwLBS31M02l17RwSbG1QV0+t+CnFlw2DgM2sM0HQDgJBYVnyzO1dZqPi
         MjBA01A6bo7c29AilOgWgoBnhCyTM+YQ5sU5YggxJKEUMVMwf8/r/xJV86IDhsXENy0x
         gnEQXJhvTCiOF8BN0KJjXidaQhjWCSCMrM8TICA+PW4KbZatkkVNrjrSzqKraARGTMZW
         ZheX7XzUijxeEH66lIJGu2wyQ1eORM7rKOXOEb9TcHHTc2JPvg9bdt77AFXdH+Q21PUQ
         2Z3OkBraJWx19LSkAEB72MCY4stSAmb4ARlDZ3xynUZUMI08StVFD8JXaj1oIy5vjmZ6
         Zr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446458; x=1752051258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXD83iZCDcIPtJInbWN8r+M3NudWak+IJ2Gonpxii5M=;
        b=DUYv+g0S+o3ujYPkjywOaI4XZh+suJGox67emsWvREqpkxo1ZrdfAHOpgihnqlA07h
         kCeP3jFvEj3RNDfc3nw+E7udAZ7lsQTcNxxRT1czo7NcxJ3P3leWjO1tsvvvAWtzmFnP
         r9sqg4lwp8nqOlSFgaxBzfN4wGmtA9mVjFblupaurYa1AjQwnnIL0NBun6JZh7ApMTb5
         LVX1tBCdMsJnqmH9QqRKzlkUcnxwn0HtSS4izjwiNl3GMdGPCW+4oIVz3ADtlyf9NMsq
         jsKcZAgG7CvdSGaAq09gbN/lQ9qpH8VxNS91OsvadXf05oMyl7cLQNJoiv6AGNQUsySO
         +AdA==
X-Gm-Message-State: AOJu0YxpVgQnA1JWoBzi4kZBp7WzapZX7/6SL+XNqmnyjocVr6t+R8r5
	/y+seTPiTriUvne4/Xl+06BCo4smtouu4Q7C8EWxpkQY6OyomI3SPVR/
X-Gm-Gg: ASbGncs6smte4o/bQ0YI3VAaFbWfYY2TtAUQXQKfeXL/warlfRyH31uNY62AN+wlguz
	ygYRXGL1ynXdAdMiOi5EQXmuX+Gm0SEUS2yXqg6oaDZkmzSp9sEuTPhW3vzyK6f+/7IxVCFqPFv
	7tI3GtwpgGTaeXHpUFyX7ci8tbo6F/hsN4gPBYoQGjkq+5CUl5zs0om1AKlMZuR1PzhP10uy53H
	R0fpuf07hBflbhmZN7GxzixkHzL9YtJIT0WXKDlF86QS1Z7ZUTHlLLv6ahaGg1CtVOSt/Ksq8qn
	VFswTp8Pf1WEZgCd7dT8ifGIDkugF/T9Rdmu9d9RMA1Rc4w7
X-Google-Smtp-Source: AGHT+IGI2TrDoAKd9WlldaeHhXyt0SDMf6URh+AtQrsToXxPq1FNHA+e7AdhguqiPky5WZmjKrWOvQ==
X-Received: by 2002:a17:907:6b07:b0:ae3:caba:2c07 with SMTP id a640c23a62f3a-ae3caba2c4amr49761066b.18.1751446457657;
        Wed, 02 Jul 2025 01:54:17 -0700 (PDT)
Received: from krava ([173.38.220.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363a9a8sm1038830566b.33.2025.07.02.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:54:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Jul 2025 10:54:15 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reduce stack frame size by using
 env->insn_buf for bpf insns
Message-ID: <aGTztxGRXTbD3lp9@krava>
References: <20250702053332.1991516-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702053332.1991516-1-yonghong.song@linux.dev>

On Tue, Jul 01, 2025 at 10:33:32PM -0700, Yonghong Song wrote:
> Arnd Bergmann reported an issue ([1]) where clang compiler (less than
> llvm18) may trigger an error where the stack frame size exceeds the limit.
> I can reproduce the error like below:
>   kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds limit (1280) in 'bpf_check'
>       [-Werror,-Wframe-larger-than]
>   kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds limit (1280) in 'do_check'
>       [-Werror,-Wframe-larger-than]
> 
> Use env->insn_buf for bpf insns instead of putting these insns on the
> stack. This can resolve the above 'bpf_check' error. The 'do_check' error
> will be resolved in the next patch.
> 
>   [1] https://lore.kernel.org/bpf/20250620113846.3950478-1-arnd@kernel.org/
> 
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  kernel/bpf/verifier.c | 194 ++++++++++++++++++++----------------------
>  1 file changed, 91 insertions(+), 103 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 90e688f81a48..29faef51065d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20939,26 +20939,27 @@ static bool insn_is_cond_jump(u8 code)
>  static void opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
>  {
>  	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
> -	struct bpf_insn ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
> +	struct bpf_insn *ja = env->insn_buf;
>  	struct bpf_insn *insn = env->prog->insnsi;
>  	const int insn_cnt = env->prog->len;
>  	int i;
>  
> +	*ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
>  	for (i = 0; i < insn_cnt; i++, insn++) {
>  		if (!insn_is_cond_jump(insn->code))
>  			continue;
>  
>  		if (!aux_data[i + 1].seen)
> -			ja.off = insn->off;
> +			ja->off = insn->off;
>  		else if (!aux_data[i + 1 + insn->off].seen)
> -			ja.off = 0;
> +			ja->off = 0;
>  		else
>  			continue;
>  
>  		if (bpf_prog_is_offloaded(env->prog->aux))
> -			bpf_prog_offload_replace_insn(env, i, &ja);
> +			bpf_prog_offload_replace_insn(env, i, ja);
>  
> -		memcpy(insn, &ja, sizeof(ja));
> +		memcpy(insn, ja, sizeof(*ja));
>  	}
>  }
>  
> @@ -21017,7 +21018,9 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
>  static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  					 const union bpf_attr *attr)
>  {
> -	struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
> +	struct bpf_insn *patch;
> +	struct bpf_insn *zext_patch = env->insn_buf;
> +	struct bpf_insn *rnd_hi32_patch = &env->insn_buf[2];
>  	struct bpf_insn_aux_data *aux = env->insn_aux_data;
>  	int i, patch_len, delta = 0, len = env->prog->len;
>  	struct bpf_insn *insns = env->prog->insnsi;
> @@ -21195,13 +21198,12 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  
>  		if (env->insn_aux_data[i + delta].nospec) {
>  			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
> -			struct bpf_insn patch[] = {
> -				BPF_ST_NOSPEC(),
> -				*insn,
> -			};
> +			struct bpf_insn *patch = &insn_buf[0];
>  
> -			cnt = ARRAY_SIZE(patch);
> -			new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
> +			*patch++ = BPF_ST_NOSPEC();
> +			*patch++ = *insn;
> +			cnt = patch - insn_buf;
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
>  
> @@ -21269,13 +21271,12 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  			/* nospec_result is only used to mitigate Spectre v4 and
>  			 * to limit verification-time for Spectre v1.
>  			 */
> -			struct bpf_insn patch[] = {
> -				*insn,
> -				BPF_ST_NOSPEC(),
> -			};
> +			struct bpf_insn *patch = &insn_buf[0];
>  
> -			cnt = ARRAY_SIZE(patch);
> -			new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
> +			*patch++ = *insn;
> +			*patch++ = BPF_ST_NOSPEC();
> +			cnt = patch - insn_buf;
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
>  
> @@ -21945,13 +21946,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  	u16 stack_depth_extra = 0;
>  
>  	if (env->seen_exception && !env->exception_callback_subprog) {
> -		struct bpf_insn patch[] = {
> -			env->prog->insnsi[insn_cnt - 1],
> -			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
> -			BPF_EXIT_INSN(),
> -		};
> +		struct bpf_insn *patch = &insn_buf[0];
>  
> -		ret = add_hidden_subprog(env, patch, ARRAY_SIZE(patch));
> +		*patch++ = env->prog->insnsi[insn_cnt - 1];
> +		*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> +		*patch++ = BPF_EXIT_INSN();
> +		ret = add_hidden_subprog(env, insn_buf, patch - insn_buf);
>  		if (ret < 0)
>  			return ret;
>  		prog = env->prog;
> @@ -21987,20 +21987,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		    insn->off == 1 && insn->imm == -1) {
>  			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
>  			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
> -			struct bpf_insn *patchlet;
> -			struct bpf_insn chk_and_sdiv[] = {
> -				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> -					     BPF_NEG | BPF_K, insn->dst_reg,
> -					     0, 0, 0),
> -			};
> -			struct bpf_insn chk_and_smod[] = {
> -				BPF_MOV32_IMM(insn->dst_reg, 0),
> -			};
> +			struct bpf_insn *patch = &insn_buf[0];
> +
> +			if (isdiv)
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> +							BPF_NEG | BPF_K, insn->dst_reg,
> +							0, 0, 0);
> +			else
> +				*patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
>  
> -			patchlet = isdiv ? chk_and_sdiv : chk_and_smod;
> -			cnt = isdiv ? ARRAY_SIZE(chk_and_sdiv) : ARRAY_SIZE(chk_and_smod);
> +			cnt = patch - insn_buf;
>  
> -			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
>  
> @@ -22019,83 +22017,73 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
>  			bool is_sdiv = isdiv && insn->off == 1;
>  			bool is_smod = !isdiv && insn->off == 1;
> -			struct bpf_insn *patchlet;
> -			struct bpf_insn chk_and_div[] = {
> -				/* [R,W]x div 0 -> 0 */
> -				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> -					     BPF_JNE | BPF_K, insn->src_reg,
> -					     0, 2, 0),
> -				BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
> -				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -				*insn,
> -			};
> -			struct bpf_insn chk_and_mod[] = {
> -				/* [R,W]x mod 0 -> [R,W]x */
> -				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> -					     BPF_JEQ | BPF_K, insn->src_reg,
> -					     0, 1 + (is64 ? 0 : 1), 0),
> -				*insn,
> -				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
> -			};
> -			struct bpf_insn chk_and_sdiv[] = {
> +			struct bpf_insn *patch = &insn_buf[0];
> +
> +			if (is_sdiv) {
>  				/* [R,W]x sdiv 0 -> 0
>  				 * LLONG_MIN sdiv -1 -> LLONG_MIN
>  				 * INT_MIN sdiv -1 -> INT_MIN
>  				 */
> -				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
> -				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> -					     BPF_ADD | BPF_K, BPF_REG_AX,
> -					     0, 0, 1),
> -				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> -					     BPF_JGT | BPF_K, BPF_REG_AX,
> -					     0, 4, 1),
> -				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> -					     BPF_JEQ | BPF_K, BPF_REG_AX,
> -					     0, 1, 0),
> -				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> -					     BPF_MOV | BPF_K, insn->dst_reg,
> -					     0, 0, 0),
> +				*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> +							BPF_ADD | BPF_K, BPF_REG_AX,
> +							0, 0, 1);
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> +							BPF_JGT | BPF_K, BPF_REG_AX,
> +							0, 4, 1);
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> +							BPF_JEQ | BPF_K, BPF_REG_AX,
> +							0, 1, 0);
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> +							BPF_MOV | BPF_K, insn->dst_reg,
> +							0, 0, 0);
>  				/* BPF_NEG(LLONG_MIN) == -LLONG_MIN == LLONG_MIN */
> -				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> -					     BPF_NEG | BPF_K, insn->dst_reg,
> -					     0, 0, 0),
> -				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -				*insn,
> -			};
> -			struct bpf_insn chk_and_smod[] = {
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> +							BPF_NEG | BPF_K, insn->dst_reg,
> +							0, 0, 0);
> +				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
> +				*patch++ = *insn;
> +				cnt = patch - insn_buf;
> +			} else if (is_smod) {
>  				/* [R,W]x mod 0 -> [R,W]x */
>  				/* [R,W]x mod -1 -> 0 */
> -				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
> -				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> -					     BPF_ADD | BPF_K, BPF_REG_AX,
> -					     0, 0, 1),
> -				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> -					     BPF_JGT | BPF_K, BPF_REG_AX,
> -					     0, 3, 1),
> -				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> -					     BPF_JEQ | BPF_K, BPF_REG_AX,
> -					     0, 3 + (is64 ? 0 : 1), 1),
> -				BPF_MOV32_IMM(insn->dst_reg, 0),
> -				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -				*insn,
> -				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> -				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
> -			};
> -
> -			if (is_sdiv) {
> -				patchlet = chk_and_sdiv;
> -				cnt = ARRAY_SIZE(chk_and_sdiv);
> -			} else if (is_smod) {
> -				patchlet = chk_and_smod;
> -				cnt = ARRAY_SIZE(chk_and_smod) - (is64 ? 2 : 0);
> +				*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
> +							BPF_ADD | BPF_K, BPF_REG_AX,
> +							0, 0, 1);
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> +							BPF_JGT | BPF_K, BPF_REG_AX,
> +							0, 3, 1);
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> +							BPF_JEQ | BPF_K, BPF_REG_AX,
> +							0, 3 + (is64 ? 0 : 1), 1);
> +				*patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
> +				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
> +				*patch++ = *insn;
> +				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
> +				*patch++ = BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
> +				cnt = (patch - insn_buf) - (is64 ? 2 : 0);
> +			} else if (isdiv) {
> +				/* [R,W]x div 0 -> 0 */
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> +							BPF_JNE | BPF_K, insn->src_reg,
> +							0, 2, 0);
> +				*patch++ = BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg);
> +				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
> +				*patch++ = *insn;
> +				cnt = patch - insn_buf;
>  			} else {
> -				patchlet = isdiv ? chk_and_div : chk_and_mod;
> -				cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
> -					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
> +				/* [R,W]x mod 0 -> [R,W]x */
> +				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
> +							BPF_JEQ | BPF_K, insn->src_reg,
> +							0, 1 + (is64 ? 0 : 1), 0);
> +				*patch++ = *insn;
> +				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
> +				*patch++ = BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
> +				cnt = (patch - insn_buf) - (is64 ? 2 : 0);
>  			}
>  
> -			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;
>  
> -- 
> 2.47.1
> 
> 

