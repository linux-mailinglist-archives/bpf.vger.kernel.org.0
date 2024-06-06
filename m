Return-Path: <bpf+bounces-31495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428668FE4E3
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 13:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA69287238
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 11:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD041194C9F;
	Thu,  6 Jun 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwWFnTHY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABF153593
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672107; cv=none; b=Fj2Tksy30u2ufDcfGPBshfNThy0h/RE2wqkxy039GCPE/kp1LPhzK7MWq0vc2t6Zw+iMiZkbgSf/qk8u+VR1BYBtcIrHyjBzzEYLiaOMmZZt2foMnAZ9MMDBEmTvY9nw2UAQuWJrMPB+tbqTvMK9wIR0r2Vk4zlsU3ODrAXv0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672107; c=relaxed/simple;
	bh=/Bw7MD+abGJ1tA77PtFIYVBrqVZeW+1Q+rcyvZp/vLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHS20qTjsS/vE45Nj2m0a/Py1n0Q5f1i1MOhJ1Zj0uvZ+bTQzlpM4qX/N4a+hbGdvQnOXeErFIX6ORexLUzH6SscAYDO1hhCIoLuNDZSCuvwr/cgB6hFXUUCF6SVtxQTgV8TFD9yv4ef5uvdnQQt940CXRqMJnBdKIJI06QNM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwWFnTHY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7025b84c0daso676836b3a.2
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717672104; x=1718276904; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9rG9z6tXWMqVwQkBhSiG75AO2b0eXIEgheZqVQBsoRY=;
        b=LwWFnTHYoVDQMw1Zj9zlq+Kw0LusdjK23yAiUJM9a9A05xVRL9gCWxMxRKG0K6qs3D
         AbqirzU2dqW6MslunPYER1Qf6XPpYLCM0hKiYxxQHt+DgZuz8aLO4HVO7ih3pxynMIJO
         fVc754oPaq3L9+9Gg8pet0nvtCgJAfmX3AZjaoV0ILENQSctKxpD+PX8j+esqRQ5PhrD
         01/U+sYcNmK6JQrmiVS6qiryPVMyNmT4dba8KYukcdiNnqWpOjPySV4sCu7Nsk9J3vMH
         Op7iT1PxRr5JSRVcy+4jNCQ8P4GAbNWCi/0vcso121FXa+UWAX5Kzc19ejijWH6ouAHL
         hnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717672104; x=1718276904;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rG9z6tXWMqVwQkBhSiG75AO2b0eXIEgheZqVQBsoRY=;
        b=DvdYmIJWiKYiw57OFzsq+Sy0cyPPN3KlBCGZIuSp8OThYQn56XEyMgie9Z3Y5oSlB0
         aI+mJ5DKln255J/wJCw421aoqSpJxsoalqbEDgQK8If5eNwkD1R+6+5v1KvrlgfGDXop
         8vwaRFtSlzBpBnrEQA5LG4bN1lDoY8JX6MJiVC3aOhSYUfiN+GLUxXbcEqdoMpDR4S6e
         EbFBoFk/k6vIcMN3vUYs3JKwd/TthOTHYKPOdao2KL+ZRh0kpL7BdGDcju7l394LHFjk
         U9PKyWRvJb21+8c2iiIszWOB+Eb5kEaMYkEDLiVwE3HGZz3KDpvTHLg97avzaYk8rSpP
         9lBg==
X-Forwarded-Encrypted: i=1; AJvYcCVQRpoQ1MDSuI3Qfa+gQooSS2WpZlHmYuOTQJcTc2Hj2N5uqNYv5oiHQkUviQhI+Xq0sARVtubBnA5kd4uJfK2xioMY
X-Gm-Message-State: AOJu0Yxi7HzYXkiqGCzPW/EVBQRRWHy1u3sXwVRPDqd8C/Jwvaqm/ODT
	noGiTMP4ByIQqCpjsZ6VjttScXqH44xR8sodbLWKal0c4/WDlxRk
X-Google-Smtp-Source: AGHT+IEizfTJVljJHLEMyE6ZP4oE1XBajms89DxI9kW2qPQ1kUTH2QO7YIIInZhb5f879eKBMOePvQ==
X-Received: by 2002:a05:6a20:7348:b0:1b2:c84d:c7da with SMTP id adf61e73a8af0-1b2c84dcb52mr1699201637.28.1717672103886;
        Thu, 06 Jun 2024 04:08:23 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd80d789sm11933245ad.289.2024.06.06.04.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 04:08:23 -0700 (PDT)
Message-ID: <6dbfd5e14ffbf9d828d63c5855f9bb783ac2506a.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: Relax precision marking in open
 coded iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Thu, 06 Jun 2024 04:08:19 -0700
In-Reply-To: <20240606005425.38285-2-alexei.starovoitov@gmail.com>
References: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
	 <20240606005425.38285-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 17:54 -0700, Alexei Starovoitov wrote:

[...]

This looks interesting, need a bit more time to think about it.
A few minor notes below.

[...]

> @@ -14704,6 +14705,165 @@ static u8 rev_opcode(u8 opcode)
>  	}
>  }
> =20
> +/* Similar to mark_reg_unknown() and should only be called from cap_bpf =
path */
> +static void mark_unknown(struct bpf_reg_state *reg)
> +{
> +	u32 id =3D reg->id;
> +
> +	__mark_reg_unknown_imprecise(reg);
> +	reg->id =3D id;
> +}
> +/*
> + * Similar to regs_refine_cond_op(), but instead of tightening the range
> + * widen the upper bound of reg1 based on reg2 and
> + * lower bound of reg2 based on reg1.
> + */
> +static void widen_reg_bounds(struct bpf_reg_state *reg1,
> +			     struct bpf_reg_state *reg2,
> +			     u8 opcode, bool is_jmp32)
> +{
> +	switch (opcode) {
> +	case BPF_JGE:
> +	case BPF_JGT:
> +	case BPF_JSGE:
> +	case BPF_JSGT:
> +		opcode =3D flip_opcode(opcode);
> +		swap(reg1, reg2);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (opcode) {
> +	case BPF_JLE:
> +		if (is_jmp32) {
> +			reg1->u32_max_value =3D reg2->u32_max_value;
> +			reg1->s32_max_value =3D S32_MAX;
> +			reg1->umax_value =3D U64_MAX;
> +			reg1->smax_value =3D S64_MAX;
> +
> +			reg2->u32_min_value =3D reg1->u32_min_value;
> +			reg2->s32_min_value =3D S32_MIN;
> +			reg2->umin_value =3D 0;
> +			reg2->smin_value =3D S64_MIN;
> +		} else {
> +			reg1->umax_value =3D reg2->umax_value;
> +			reg1->smax_value =3D S64_MAX;
> +			reg1->u32_max_value =3D U32_MAX;
> +			reg1->s32_max_value =3D S32_MAX;
> +
> +			reg2->umin_value =3D reg1->umin_value;
> +			reg2->smin_value =3D S64_MIN;
> +			reg2->u32_min_value =3D U32_MIN;
> +			reg2->s32_min_value =3D S32_MIN;
> +		}
> +		reg1->var_off =3D tnum_unknown;
> +		reg2->var_off =3D tnum_unknown;
> +		break;

Just a random thought: suppose that one of the registers in question
is used as an index int the array of ints, and compiler increments it
using +=3D 4. Would it be interesting to preserve alignment info in the
var_off in such case? (in other words, preserve known trailing zeros).

[...]

> @@ -15177,8 +15339,78 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>  	}
> =20
>  	is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
> +	if (dst_reg->type !=3D SCALAR_VALUE || src_reg->type !=3D SCALAR_VALUE =
||
> +	    /* Widen scalars only if they're constants */
> +	    !is_reg_const(dst_reg, is_jmp32) || !is_reg_const(src_reg, is_jmp32=
))
> +		do_widen =3D false;
> +	else if (reg_const_value(dst_reg, is_jmp32) =3D=3D reg_const_value(src_=
reg, is_jmp32))
> +		/* And not equal */
> +		do_widen =3D false;
> +	else
> +		do_widen =3D (get_loop_entry(this_branch) ||
> +			    this_branch->may_goto_depth) &&
> +				/* Gate widen_reg() logic */
> +				env->bpf_capable;
> +
>  	pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> -	if (pred >=3D 0) {
> +
> +	if (do_widen && ((opcode =3D=3D BPF_JNE && pred =3D=3D 1) ||
> +			 (opcode =3D=3D BPF_JEQ && pred =3D=3D 0))) {
> +		/*
> +		 * !=3D is too vague. let's try < and > and widen. Example:
> +		 *
> +		 * R6=3D2
> +		 * 21: (15) if r6 =3D=3D 0x3e8 goto pc+14
> +		 * Predicted =3D=3D not-taken, but < is also true
> +		 * 21: R6=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D2,smax=3Dumax=3Dsma=
x32=3Dumax32=3D999,var_off=3D(0x0; 0x3ff))
> +		 */
> +		int refine_pred;
> +		u8 opcode2 =3D BPF_JLT;
> +
> +		refine_pred =3D is_branch_taken(dst_reg, src_reg, BPF_JLT, is_jmp32);
> +		if (refine_pred =3D=3D 1) {
> +			widen_reg(env, dst_reg, src_reg, BPF_JLT, is_jmp32, true);
> +
> +		} else {

nit: would it be possible to avoid second call to is_branch_taken()
     by checking that refine_pred =3D=3D 0 and assuming opcode2 =3D=3D BPF_=
JGE?

> +			opcode2 =3D BPF_JGT;
> +			refine_pred =3D is_branch_taken(dst_reg, src_reg, BPF_JGT, is_jmp32);
> +			if (refine_pred =3D=3D 1)
> +				widen_reg(env, dst_reg, src_reg, BPF_JGT, is_jmp32, true);
> +		}
> +
> +		if (refine_pred =3D=3D 1) {
> +			if (dst_reg->id)
> +				find_equal_scalars(this_branch, dst_reg);

I think it is necessary to do find_equal_scalars() for src_reg as well,
since widen_reg() could change both registers.

> +			if (env->log.level & BPF_LOG_LEVEL) {
> +				verbose(env, "Predicted %s, but %s is also true\n",
> +					opcode =3D=3D BPF_JNE ? "!=3D taken" : "=3D=3D not-taken",
> +					opcode2 =3D=3D BPF_JLT ? "<" : ">");
> +				print_insn_state(env, this_branch->frame[this_branch->curframe]);
> +			}
> +			err =3D mark_chain_precision(env, insn->dst_reg);
> +			if (err)
> +				return err;
> +			if (has_src_reg) {
> +				err =3D mark_chain_precision(env, insn->src_reg);
> +				if (err)
> +					return err;
> +			}
> +			if (pred =3D=3D 1)
> +				*insn_idx +=3D insn->off;
> +			return 0;
> +		}
> +		/*
> +		 * No luck. Predicted dst !=3D src taken or dst =3D=3D src not-taken,
> +		 * but !(dst < src) and !(dst > src).
> +		 * Constants must have been negative.
> +		 */
> +	}
> +
> +	if (do_widen && (opcode =3D=3D BPF_JNE || opcode =3D=3D BPF_JEQ || opco=
de =3D=3D BPF_JSET))
> +		/* widen_reg() algorithm works for <, <=3D, >, >=3D only */
> +		do_widen =3D false;
> +
> +	if (pred >=3D 0 && !do_widen) {
>  		/* If we get here with a dst_reg pointer type it is because
>  		 * above is_branch_taken() special cased the 0 comparison.
>  		 */

[...]

