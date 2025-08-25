Return-Path: <bpf+bounces-66430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3A5B349DC
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843011A84A9A
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D23093BD;
	Mon, 25 Aug 2025 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doI1Ef4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D392C325C
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145526; cv=none; b=YIzej+jhtBfW8Ulilgjs030Eca7CzsFNd70TssKM9DGq7SckxbATblntLpFVQtdiJrazCo644VvA0StSfasdMaRxuTxj5V7SD/yjHlFA7VLhfj3WKN8NSo3neN5V8aQRAVRXtGBDWslaMGi0QDdUBzvRKUcBvBK+bMjRA10QHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145526; c=relaxed/simple;
	bh=bH28iSM6BjBrUM+5t0hHAEGKHJjLUO1HTx10LeNxLHA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+ptjJICn2+ZR+Qwi0X2u5u6gvUjRewGCQBWus2IIRJlL4Tj3zs5Sjcy2s+KzVW+c1xUU8/KjdEq/UBjnAjHOcJUduUywmLpmHAaV7+KbalQ0k/v2fcVZN+PUNPuMcR+VEevPufmGIXRDDJbtEr1GwbrABZs9g4MwXwcIvHBwYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doI1Ef4d; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2449978aceaso33060535ad.2
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756145524; x=1756750324; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OMK8Jbsln3Hdrkz6elt7KszlHgfzWIwn2ExN1UExZI=;
        b=doI1Ef4d2NGjPI++b1dETE5meTVTwdmwh4H2DN+IMb4qfdps8OZsor9TQbUkG0yxvU
         JGiS0FcCQxrF3epHZqILGFiSDSDW7xxYbNrbYSUEqutREJdnNhS1hENsPJLp9hg5ChGm
         fZd5mwJDTfKWfyDQsXAJASfgJ67CBEYqeMRXcgpo8nbQFJBKL4ksKN8PIcQj9aDQPB9F
         1AGHYu2WWHuk4DRmjOIsCKnZDxNsCLk1VmBNa/LWt+vP6EAd6RFlVo9QtFkZhi+U0fVW
         atx4IGx2Un/qyZZYVRHFg5rEAcjsMaQFgMTLDMqavAGyCXr/LwaAgVMT0LwTS9w2sVPy
         YEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145524; x=1756750324;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0OMK8Jbsln3Hdrkz6elt7KszlHgfzWIwn2ExN1UExZI=;
        b=OxDk+kfIZkwCsjGof1gPCnYj9C3XvQP9jKIM2d+a3XKCBJ9G37MYZPGkh+dLjrKg/P
         Zv4IvwA01CkFKY+4tw6NsMyjy0+vem2yq0QfvFxvIX17wCOC4oLq2GJFEQNiRLI+jnp5
         BKWUcFf7+lw8LytxeWnQ3ZUeYWkWK/LWVVzSqiMjLRF9KOZB3+lUZirsro7isEgR+1m/
         TQtQKq/bR/W361xKKFAw/9pkyK0EqaXoP+1UeGYgStMJDUljG/XS1utmAOB20vw4IgD1
         7Wcl/+ZYDdcxL7uVhIQ3Tpj6i9ot0gTxytsUIokY2Fsjvy8M1oHZ13MAP6p/v76ZDc8T
         vxDg==
X-Forwarded-Encrypted: i=1; AJvYcCWx18K+iC/c31aNLZUT9iIdDWkPJMH9B8ErbDVg8szATIv+Q88sOkEBc0uP6ZIZBmtUv4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9kF3h3w7I2eDJZ4+pWCVl5C20MjbD64Vfd/XEVY77/xcEMWh
	o3gpjIR5sgQC0RvtcW4i9Sl8kQ4EhKzfQy48xms5AMsTkrABvGWtCghS
X-Gm-Gg: ASbGncu74tro3q4VQqJ53QFTa9MRaFAeakmeLasH+11AbxXREOOJ2SbZWp46uPGHgGj
	4+NCRtottDcuvg5v1VSFTU9wVZn7VJaDhLpArQnSEViAa9mvnlFDSMem7ij6bI9Go2gN5Z49Ws0
	1tqUPilvxUBScBOEA1DZluWYcA7BrCVCdaKyyXC/0+JtA1qNHpSa6ZrC4l4xOp+WAxqBOj9RXF0
	pBYCZxn8V5XHMNfhoxA2D4MD/Tb8rKMT1VRXgHFDyhXtFYMwBMIk0NQDDqDkToxJ6nESCymrYu3
	a2JgkbqpheOadNFXKJZO/1qpGqZlmIytoePWZ5EQQ0nmYcpjeKXj4XNk5oLPMp9IXuGgJAT5F3b
	tTcuRaGL7C+U8g2nwZMf09xYbIucp
X-Google-Smtp-Source: AGHT+IGdu1vcmdFrdVDJGEB53EDkP82AShwAgthxxb9o3nsVOpMG3hpDvtq2ws9xCUuav3q+bn5YfQ==
X-Received: by 2002:a17:903:380b:b0:240:6ae4:3695 with SMTP id d9443c01a7336-2462ee0cf11mr155613545ad.4.1756145524395;
        Mon, 25 Aug 2025 11:12:04 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:48d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246cc1334f0sm36095725ad.157.2025.08.25.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:12:03 -0700 (PDT)
Message-ID: <e485c7411db1661d181c238cfb5380b65a3c3ad7.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 01/11] bpf: fix the return value of
 push_stack
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 25 Aug 2025 11:12:01 -0700
In-Reply-To: <20250816180631.952085-2-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-2-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:

The change makes sense to me, please see a few comments below.

[...]

> @@ -2111,12 +2111,12 @@ static struct bpf_verifier_state *push_stack(stru=
ct bpf_verifier_env *env,
>  	env->stack_size++;
>  	err =3D copy_verifier_state(&elem->st, cur);
>  	if (err)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	elem->st.speculative |=3D speculative;
>  	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
>  		verbose(env, "The sequence of %d jumps is too complex.\n",
>  			env->stack_size);
> -		return NULL;
> +		return ERR_PTR(-EFAULT);

Nit: this should be -E2BIG, I think.

>  	}
>  	if (elem->st.parent) {
>  		++elem->st.parent->branches;
> @@ -2912,7 +2912,7 @@ static struct bpf_verifier_state *push_async_cb(str=
uct bpf_verifier_env *env,
> =20
>  	elem =3D kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACC=
OUNT);
>  	if (!elem)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	elem->insn_idx =3D insn_idx;
>  	elem->prev_insn_idx =3D prev_insn_idx;
> @@ -2924,7 +2924,7 @@ static struct bpf_verifier_state *push_async_cb(str=
uct bpf_verifier_env *env,
>  		verbose(env,
>  			"The sequence of %d jumps is too complex for async cb.\n",
>  			env->stack_size);
> -		return NULL;
> +		return ERR_PTR(-EFAULT);

(and here too)

>  	}
>  	/* Unlike push_stack() do not copy_verifier_state().
>  	 * The caller state doesn't matter.

[...]

> @@ -14217,7 +14217,7 @@ sanitize_speculative_path(struct bpf_verifier_env=
 *env,
>  	struct bpf_reg_state *regs;
> =20
>  	branch =3D push_stack(env, next_idx, curr_idx, true);
> -	if (branch && insn) {
> +	if (!IS_ERR(branch) && insn) {

Note: branch returned by `sanitize_speculative_path` is never used.
      Maybe change the function to return `int` and do the regular

        err =3D sanitize_speculative_path()
        if (err)
      	   return err;

      thing here?

>  		regs =3D branch->frame[branch->curframe]->regs;
>  		if (BPF_SRC(insn->code) =3D=3D BPF_K) {
>  			mark_reg_unknown(env, regs, insn->dst_reg);

[...]

> @@ -16721,8 +16720,7 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
>  		 * execution.
>  		 */
>  		if (!env->bypass_spec_v1 &&
> -		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
> -					       *insn_idx))
> +		    IS_ERR(sanitize_speculative_path(env, insn, *insn_idx + 1, *insn_i=
dx)))
>  			return -EFAULT;

I think the error code should be taken from the return value of the
sanitize_speculative_path().

>  		if (env->log.level & BPF_LOG_LEVEL)
>  			print_insn_state(env, this_branch, this_branch->curframe);
> @@ -16734,9 +16732,9 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
>  		 * simulation under speculative execution.
>  		 */
>  		if (!env->bypass_spec_v1 &&
> -		    !sanitize_speculative_path(env, insn,
> -					       *insn_idx + insn->off + 1,
> -					       *insn_idx))
> +		    IS_ERR(sanitize_speculative_path(env, insn,
> +						     *insn_idx + insn->off + 1,
> +						     *insn_idx)))

Same here.

>  			return -EFAULT;
>  		if (env->log.level & BPF_LOG_LEVEL)
>  			print_insn_state(env, this_branch, this_branch->curframe);

[...]

