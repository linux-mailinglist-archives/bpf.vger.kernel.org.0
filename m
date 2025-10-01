Return-Path: <bpf+bounces-70166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF83BB201F
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 00:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6F064E18A0
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD0E3115BD;
	Wed,  1 Oct 2025 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtnYMBDA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C8C30F53C
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358375; cv=none; b=Q6KFFtaUGFDKKdihlaNswVJ6SSstauBbBSalErlYZF7vG9Ok1iV0PzGxrH8cI8KmpMEfIa428RmdW+yjV9CWQk2kNpq7XLR+DvXqpXkTGfNWlCvRmhBSwOovWGBYBVqyQH3k918JZ0mJxEi6nccXRLVRrkSab4dNQ8GILUUmWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358375; c=relaxed/simple;
	bh=CFTq1xK0fy32SOmnpAHshDwkMJUmE0CGdpBGt9b/dts=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FtT4YahjxsTtj6DlJ5YqCyoO0Gxnw2iUPJVWu5X98Oiwm5gq3TIh+JRgqzcbnIQBVG1zLkMM9cBL4yV0PgaQ3T2gfqpf8WYhZgC5KCEdswY1R/IYKhPd82TA0axIhp8mcWBeFPTwBKTt3H8fvbqQleF8YCFCGN22SrYXwfVzR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtnYMBDA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782e93932ffso451148b3a.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 15:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759358374; x=1759963174; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on9JoZ0Y3ZmA+gcBBl1arm3v5/hj9CVye+1sxMNsMms=;
        b=mtnYMBDAKOCdoyvSmUKovkLoW/tbBlGjQFdQUEAX6oe6Y8Td9tXY0QRex98gby6TuP
         /CwzJVZBX9ZINByhUdNe6tRr8XU4/IlSQPkOO0I0gyNb72MaWJ8oMswNphn0aE7tCmqR
         OBsTtLpaBN/atuKSi2VLDWGJoS1qmAKs4o5BycOifUTt4L89yXjNyny1QulSI4U4/ile
         CvLyLiQ9FZscu1vm0RDhc+DJHWaRqdX9K7cGkhIFSkOwJOa973P6Fzdx7zDfeyxZ7l1y
         A3xLkRyn1JUCo1jMS/upZFm+jIHvi0lScEYbDdzbG4hCUHqn/qpAdKfSPERAb6ZLnhhK
         tivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759358374; x=1759963174;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=on9JoZ0Y3ZmA+gcBBl1arm3v5/hj9CVye+1sxMNsMms=;
        b=jFQ0DvXlNSpS4ZHN16Y+JDcIkZuHMkZNxrtwAcRDDilXARKPdM96HGLoNYhOvO2DPA
         9w8+CWUt9HtY4ajUrANCe+PIoFyFTxmcftXIm8q2J+cZyGzd7u35zgijXjcb7TgNNg7W
         ZWgr7qBHmjyGDLPEZLJakbrUmt6JmhN/9qmbJx88Kh0tJo9YS4ByMOzXgQFZTiAxH9Iw
         UAqbKGV3g4o5IFH8Vtvzm9yFmlf8wcxjqdMSiwBLRZBQwtCdurMwJJm0cA8loH8jcBvE
         I5MIu+VG0JZ5Fr7e2xYZkK/DaH3ipbTGpdiSvZTypKWvDJS5pYQfiIAPkbhakvKNnLb3
         2hVA==
X-Forwarded-Encrypted: i=1; AJvYcCUXeNsAz8/oHFRJWr8G65PXLaCEFrGUbt8qfkskefFKak5FJT/3Zsop5rOtw7NB1tOEeAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48GSXQmjAQqVEIf8HR4lAcHd3rJqK8yuyAKV58Jh4WpTzJBub
	tLIfVyQVLM1n/0+KP9RVUKgQYnQZrhpRL/VjoLpgX8Ej/dU7HtN2UBbw
X-Gm-Gg: ASbGncsHGLfE6OIGymx9btKt+sAyAkZVdI26vDFFlE8z7inDd2IVZC6N+8N7VkRYcwy
	XMkIwpGnOgCXm7L24j7WjxUY0ZCUVkdwRgS9l9rdWnm8eTJsyWnvsjt0y4Mqn02d96k+LU5niT6
	iTA6OSKOsj9DGHL4VXLEgD1eM9/gxQxT1zfM81V8HYuEZiCUqJRQEp1YELZLffTkfTzW7oBSf9g
	bbrSDFL+rGxv5sDc+dRARAgM1JULhSPoKGyRUtTOD8Z+txplv3WHW2BTk5HeFwTgSIdUNxCIHIv
	Ie0BjepkmmBs39eUtU0W6J0vMuPFbWCihIIoikXNulz2iEKUkrABI0FnK807hPCUBFPF1jHra29
	pyca0i9vUyfF/EPrH6a6kAACHi2YMBFV/LLEaM4bhvDgXc6sqF/TTkIyVlONanCpGFa2jRKnYkY
	mEQLUjyw==
X-Google-Smtp-Source: AGHT+IF8SpFoUT20SuerO+SfQ9vf+g+2TkiwSrO9zeCtLeXiuaTUzNDsS6KUY6o/NqRpJGfkrW06/w==
X-Received: by 2002:a17:90b:4ac8:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-339a6f38007mr5586991a91.24.1759358373657;
        Wed, 01 Oct 2025 15:39:33 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3d0fsm763149a91.6.2025.10.01.15.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:39:33 -0700 (PDT)
Message-ID: <eddce884140f3df9e6c3c7e1b873a570b163ce1d.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 09/15] bpf: make bpf_insn_successors to
 return a pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 01 Oct 2025 15:39:32 -0700
In-Reply-To: <20250930125111.1269861-10-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-10-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> The bpf_insn_successors() function is used to return successors
> to a BPF instruction. So far, an instruction could have 0, 1 or 2
> successors. Prepare the verifier code to introduction of instructions
> with more than 2 successors (namely, indirect jumps).
>=20
> To do this, introduce a new struct, struct bpf_iarray, containing
> an array of bpf instruction indexes and make bpf_insn_successors
> to return a pointer of that type. The storage for all instructions
> is allocated in the env->succ, which holds an array of size 2,
> to be used for all instructions.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(but please fix the IS_ERR things, see below).

[...]

> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -509,6 +509,15 @@ struct bpf_map_ptr_state {
>  #define BPF_ALU_SANITIZE		(BPF_ALU_SANITIZE_SRC | \
>  					 BPF_ALU_SANITIZE_DST)
> =20
> +/*
> + * An array of BPF instructions.
> + * Primary usage: return value of bpf_insn_successors.
> + */
> +struct bpf_iarray {
> +	int off_cnt;
> +	u32 off[];
> +};
> +

Tbh, the names `off` and `off_cnt` are a bit strange in context of
instruction successors.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 705535711d10..6c742d2f4c04 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17770,6 +17770,22 @@ static int mark_fastcall_patterns(struct bpf_ver=
ifier_env *env)
>  	return 0;
>  }
> =20
> +static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t =
n_elem)
> +{
> +	size_t new_size =3D sizeof(struct bpf_iarray) + n_elem * 4;

Nit: n_elem * 4 -> n_elem * sizeof(*old->off) ?

> +	struct bpf_iarray *new;
> +
> +	new =3D kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
> +	if (!new) {
> +		/* this is what callers always want, so simplify the call site */
> +		kvfree(old);
> +		return NULL;
> +	}
> +
> +	new->off_cnt =3D n_elem;
> +	return new;
> +}

[...]

> @@ -24325,14 +24342,18 @@ static int compute_live_registers(struct bpf_ve=
rifier_env *env)
>  		for (i =3D 0; i < env->cfg.cur_postorder; ++i) {
>  			int insn_idx =3D env->cfg.insn_postorder[i];
>  			struct insn_live_regs *live =3D &state[insn_idx];
> -			int succ_num;
> -			u32 succ[2];
> +			struct bpf_iarray *succ;
>  			u16 new_out =3D 0;
>  			u16 new_in =3D 0;
> =20
> -			succ_num =3D bpf_insn_successors(env->prog, insn_idx, succ);
> -			for (int s =3D 0; s < succ_num; ++s)
> -				new_out |=3D state[succ[s]].in;
> +			succ =3D bpf_insn_successors(env, insn_idx);
> +			if (IS_ERR(succ)) {

This error check is no longer necessary.

> +				err =3D PTR_ERR(succ);
> +				goto out;
> +
> +			}
> +			for (int s =3D 0; s < succ->off_cnt; ++s)
> +				new_out |=3D state[succ->off[s]].in;
>  			new_in =3D (new_out & ~live->def) | live->use;
>  			if (new_out !=3D live->out || new_in !=3D live->in) {
>  				live->in =3D new_in;

[...]

> @@ -24496,12 +24517,17 @@ static int compute_scc(struct bpf_verifier_env =
*env)
>  				stack[stack_sz++] =3D w;
>  			}
>  			/* Visit 'w' successors */
> -			succ_cnt =3D bpf_insn_successors(env->prog, w, succ);
> -			for (j =3D 0; j < succ_cnt; ++j) {
> -				if (pre[succ[j]]) {
> -					low[w] =3D min(low[w], low[succ[j]]);
> +			succ =3D bpf_insn_successors(env, w);
> +			if (IS_ERR(succ)) {

Same here.

> +				err =3D PTR_ERR(succ);
> +				goto exit;
> +
> +			}
> +			for (j =3D 0; j < succ->off_cnt; ++j) {
> +				if (pre[succ->off[j]]) {
> +					low[w] =3D min(low[w], low[succ->off[j]]);
>  				} else {
> -					dfs[dfs_sz++] =3D succ[j];
> +					dfs[dfs_sz++] =3D succ->off[j];
>  					goto dfs_continue;
>  				}
>  			}

[...]

