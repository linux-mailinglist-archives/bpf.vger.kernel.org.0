Return-Path: <bpf+bounces-37214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD84952455
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 22:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0364728BEBC
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 20:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D501BE877;
	Wed, 14 Aug 2024 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoSHtDdR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB945139CE3
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668983; cv=none; b=X2C+Rd33aCiqgxg8IyeIUt83RzK0Al9nSq4jJQ3zLQ+KYKPxtaqi0i2wntO+bB1oQD1VsukOKgLuKmNncuGA/rklAMVVw/Ez5iDUO2jzv0N69W6luGfegIdOn0qY+k5zFmwVWB2AP11u0vGCvtaDZ5nn0crnbWt2fp1ik5FhrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668983; c=relaxed/simple;
	bh=ZatuZRnLrPyyTKGOnetd0Ks/shVrijKe0beNj5Or2EM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOwn38jhw2zWSv5PE9A/z7LhEuDx/+ck1z9K9QKDNYJp4Ku6/808fOOYepl5dojP/HT2wcQHL7YDq0Ji8/zquXWSp/Hv1eMLQWMdI6u5teb2GpdsnACLUz9STkFORUP9Zli+f8J9XLRneertUwIEOMt04S59aDzmHANqzajHxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoSHtDdR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd640a6454so3348295ad.3
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723668981; x=1724273781; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c8eTkoX3AKCtrpdBvBbwTv3azc3T5/FwiuoxXLUx660=;
        b=HoSHtDdRrfABfasPxwzQ5rtefZZkitomSbrM2q5UySSjZ0xJ/g5heDk2QHAhG+6Fmt
         +cyZqJ3MDE1Gl2oydoiYoK9KVAIx1LzBpzn6tX0QTwnqPnxtU76RkhYm5P3vAyK+QyXr
         S90rBQlWJQEHlXoZAyn+s3x9aipnO7ZQjF0U3zohuROLejgSeh11EeuCVRwrNoYouTMf
         Q66BmTTAoQHGI6fnvQKU2NUDuggtHsiE5kIp8GfFYVP2BFwrF1ZjqPnmpYh05KYNKX01
         q8/QIvbIP2TCG3xiLxw3GlSjetyGP4LmfFn5JrdAE4DFdtwDcmlFTaLUKq7m3YPjcnjZ
         qNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723668981; x=1724273781;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8eTkoX3AKCtrpdBvBbwTv3azc3T5/FwiuoxXLUx660=;
        b=lQedz37pB8JTBAdgfQNOn+rhwEUdZ1sqwyMsjfS75rYxty5zKDRrDgMmniWDfeyuKT
         nbIDlVkISCy+o0CI+XqAw+CRLMKlMCBYejNJNVxJHd5mxfa44ZBO4eJAvxiPSn3qepvj
         QlvlqixWflTbm3ydWa5djEEafGrqKTL99eZCGr9LLs5/kaUp4kL9A3YpofRNydqhEmr2
         c9nZZU628Y6MAL9b4BrFyRyCkUTMSoSs/bfLmww3hviC8/4P2OH6n7RAh0HySjfLGsWE
         OpK+QIwO7U6GQP77dPhyFUpUBkXprMMbXsddnx3Az1B7ywx1jrl6Gem5jMfPi0HyGulx
         t0+A==
X-Forwarded-Encrypted: i=1; AJvYcCWolP0k/fnKsontuZfcx+Ycywgc0qbqCJ7fvb4ivgVDoOiDiPRVIh2W70N1jW5zgtnZRJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcOMdKrUTIto6OKkpIHuJaEs6KFjRuvXQmTE/deygwtPTrW+J
	DcjU6cEOoLKqKhXM3BQQZub8tv5rEwDG8HjZtV4UFNbtVc8EV36P
X-Google-Smtp-Source: AGHT+IGeV7tDnR+OBPPJX7XHh+A+yf5N20bShnlkkd8njEMAoLzESFul656ugnFzCgkLgJ+vSNyKKg==
X-Received: by 2002:a17:902:f68a:b0:201:d65d:7361 with SMTP id d9443c01a7336-201d65d7417mr47568205ad.58.1723668980827;
        Wed, 14 Aug 2024 13:56:20 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031cb2csm542805ad.106.2024.08.14.13.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 13:56:20 -0700 (PDT)
Message-ID: <19903da56fbfb99e4ad6fdea646aaff885e9fd4d.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/6] bpf: Add gen_epilogue to
 bpf_verifier_ops
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 14 Aug 2024 13:56:15 -0700
In-Reply-To: <20240813184943.3759630-2-martin.lau@linux.dev>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
	 <20240813184943.3759630-2-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-13 at 11:49 -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> This patch adds a .gen_epilogue to the bpf_verifier_ops. It is similar
> to the existing .gen_prologue. Instead of allowing a subsystem
> to run code at the beginning of a bpf prog, it allows the subsystem
> to run code just before the bpf prog exit.
>=20
> One of the use case is to allow the upcoming bpf qdisc to ensure that
> the skb->dev is the same as the qdisc->dev_queue->dev. The bpf qdisc
> struct_ops implementation could either fix it up or drop the skb.
> Another use case could be in bpf_tcp_ca.c to enforce snd_cwnd
> has sane value (e.g. non zero).
>=20
> The epilogue can do the useful thing (like checking skb->dev) if it
> can access the bpf prog's ctx. Unlike prologue, r1 may not hold the
> ctx pointer. This patch saves the r1 in the stack if the .gen_epilogue
> has returned some instructions in the "epilogue_buf".
>=20
> The existing .gen_prologue is done in convert_ctx_accesses().
> The new .gen_epilogue is done in the convert_ctx_accesses() also.
> When it sees the (BPF_JMP | BPF_EXIT) instruction, it will be patched
> with the earlier generated "epilogue_buf". The epilogue patching is
> only done for the main prog.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Apart from the note below I don't see any obvious problems with this code.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19610,15 +19610,37 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct=
 bpf_verifier_env *env,
>   */
>  static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  {
> +	struct bpf_subprog_info *subprogs =3D env->subprog_info;
>  	const struct bpf_verifier_ops *ops =3D env->ops;
> -	int i, cnt, size, ctx_field_size, delta =3D 0;
> +	int i, cnt, size, ctx_field_size, delta =3D 0, epilogue_cnt =3D 0;
>  	const int insn_cnt =3D env->prog->len;
> -	struct bpf_insn insn_buf[16], *insn;
> +	struct bpf_insn insn_buf[16], epilogue_buf[16], *insn;
>  	u32 target_size, size_default, off;
>  	struct bpf_prog *new_prog;
>  	enum bpf_access_type type;
>  	bool is_narrower_load;
> =20
> +	if (ops->gen_epilogue) {
> +		epilogue_cnt =3D ops->gen_epilogue(epilogue_buf, env->prog,
> +						 -(subprogs[0].stack_depth + 8));
> +		if (epilogue_cnt >=3D ARRAY_SIZE(epilogue_buf)) {
> +			verbose(env, "bpf verifier is misconfigured\n");
> +			return -EINVAL;
> +		} else if (epilogue_cnt) {
> +			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
> +			cnt =3D 0;
> +			subprogs[0].stack_depth +=3D 8;

Note: two other places that allocate additional stack
      (optimize_bpf_loop(), do_misc_fixups())
      also bump 'env->prog->aux->stack_depth'.

> +			insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
> +						      -subprogs[0].stack_depth);
> +			insn_buf[cnt++] =3D env->prog->insnsi[0];
> +			new_prog =3D bpf_patch_insn_data(env, 0, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +			env->prog =3D new_prog;
> +			delta +=3D cnt - 1;
> +		}
> +	}
> +

[...]


