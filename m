Return-Path: <bpf+bounces-79353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB30AD38A2B
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 00:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A033030089B4
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E183128AA;
	Fri, 16 Jan 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca9X1np0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32B235063
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606361; cv=none; b=Z2WrijbuuhdMda4avqjzERWaw9R5nrI1G8/9v644UJoPslti9oekJVVLCc1nDRJJ17pSay55LHi2bC9si6NaBnBtwaBrGXd0ToIjPP8FXwgJjedLyUxEg5cXJE+gXefnZ22NO7YeKXAFFwl7ycVRb7OLUzZ6l1WRyvYL+FbTScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606361; c=relaxed/simple;
	bh=rbU0Ec3qolqeBsR3hF2aJMN1Q9BuTISIrNELLPer1N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqgVsG/cU3EXakTMhAtU2zL4a5o5fyZB6UXX3V+KJd4WrccfKZQ7mvxnVRjSX6kvwDZu4H7YIWNQWw9aGTvnBU0jf7gqL0WvPKNZgSKI0dpADWzvrg6ryhsR09it2+1DLheMxGoVG2tIZQ95YurV6C0O0uFEsN1ggOB5Ao/iTHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca9X1np0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso964029a12.3
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 15:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606359; x=1769211159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxwaLDTifIMkxC3a8V9Jl/ujC0CmnleZHGaCm/O5euY=;
        b=ca9X1np0bmOQ/ThpxnDlsVjLK2guo04mOP5nnizwwVAwlo94guktxXhj/gW+40rCo9
         3fAUdhjuwN7mmxP04FHHfuHDExSQqjJYUuHi1eCOkeTS0Nb8h/zWShzLGYNHJLczWjX2
         Kyi17b4eVMpoXClYt+u95TGLGzIVqDeDrNaqICZa0Q2XuDodgYWlAoPp5H78pByccX04
         /yds7pzLpT/a3rWK8GxMHqaO3OXF8MXmXnKlLVUEebz+ESw1UDlERshF5SUxls2ZPUin
         GEvZ6iI0d1qVSwOTHls79Bsqdye/lnSgUSka9a+sf84M8LnSpeUH1yGH3reDjAvfF118
         /W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606359; x=1769211159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxwaLDTifIMkxC3a8V9Jl/ujC0CmnleZHGaCm/O5euY=;
        b=KgA0mwPGGINGf4ZI4g6otlc3n9aGXiScLtIPceK75eFYiDYSunIjGf9AFHFOm/Y1nr
         ArJKvu2wpofohHbsMSg2JB+eS4PTUy8z4BsR3NxQdcqZrjbx9Msx6dI1SDKRVg3gMmcG
         9zHZS3SHXuYcy5ZUXB2iyKjqO5QUSXzcnGn5Nt+4pe/lb08QmeGcVgWmken4U0LKj28r
         WjHrIS1U1EozhKKtmuttb41eLK/HWqpLGfNQ14yDaF74QpzZWy63jaArnikz69LjiKOl
         zcIumEQj3uJwE4vmO5LXFvzhOVVUMgReo1r7vDopVTyIGhIInVJ1TNEnfgzy6vIj4W0L
         Q0rg==
X-Forwarded-Encrypted: i=1; AJvYcCXsIE/nMh/zYQ0AzsDKzetFxJrfwZD/Skd7JthbOj1h/9FTYvz0LSlf6Hdg+4+1/0Tp96E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl673w/8r5q94GoMPRNZgOMH3S/xEeCR4ctvxX5mS3r4J4PObd
	BU4MCPHnrHxV2QJqOyZW09l1/fFdJIY16Z5PJPzSDPPb5o7dZTquI+SxOderowIz/bMRPatkjfy
	9an+mxwWfWWy7s/jA0Vb6uQsrXP/PGKQ=
X-Gm-Gg: AY/fxX68oX6n6P1eoKuUQJxDrEberVaf2E1arCQV4RWc5qbOfMUtekmZgBCFvp6nh9Y
	DWNrtIgeQ8jsevjXYxghpLp9QmjN77qNiSlbr1lP3O1uSeNmP7UzHQViOcCJooHrQXmwkz4wuzi
	fX1Z9XY1E4dej5B8LeykNBATLZUf1QE9PqiYJubSY6cFA42dBJhzp5Y9W7D6bvGK5nohf4WeDdo
	ul+JplHM6RYAu49zZUMFUaSbYq/rQ6pK3YEvJYgIraf4DxTBb3AkoPQQ4Y+whC17zp/dG+F15It
	1AAben79naw=
X-Received: by 2002:a05:6a20:2450:b0:366:584c:62ef with SMTP id
 adf61e73a8af0-38dfe7d602cmr4683917637.65.1768606359122; Fri, 16 Jan 2026
 15:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116071739.121182-1-dongml2@chinatelecom.cn> <20260116071739.121182-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260116071739.121182-2-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 15:32:26 -0800
X-Gm-Features: AZwV_Qi5xMILd7AmhFW-B7lhQbG7DhtbslRYqmhbrnR6u-Ay4k1SgXWUfLoKSPE
Message-ID: <CAEf4BzazwvaLVy+4SByCt0cvkOm6eNSmDmGBfUM8u9scFseGCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:18=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported b=
y
> the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> tracepoint, especially for the case that the position of the arguments in
> a tracepoint can change.
>
> The target tracepoint BTF type id is specified during loading time,
> therefore we can get the function argument count from the function
> prototype instead of the stack.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - for nr_args, skip first 'void *__data' argument in btf_trace_##name
>   typedef
> ---
>  kernel/bpf/verifier.c    | 36 ++++++++++++++++++++++++++++++++----
>  kernel/trace/bpf_trace.c |  4 ++--
>  2 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index faa1ecc1fe9d..422d35c100ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23316,8 +23316,22 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                 /* Implement bpf_get_func_arg inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
> -                       /* Load nr_args from ctx - 8 */
> -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_1, -8);
> +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> +                               int nr_args;
> +
> +                               if (!prog->aux->attach_func_proto)
> +                                       return -EINVAL;

can this happen? can we have tp_btf program without attach_func_proto
properly set?

> +                               /*
> +                                * skip first 'void *__data' argument in =
btf_trace_##name
> +                                * typedef
> +                                */
> +                               nr_args =3D btf_type_vlen(prog->aux->atta=
ch_func_proto) - 1;
> +                               /* Save nr_args to reg0 */
> +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
nr_args);
> +                       } else {
> +                               /* Load nr_args from ctx - 8 */
> +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> +                       }
>                         insn_buf[1] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_2,=
 BPF_REG_0, 6);
>                         insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_2,=
 3);
>                         insn_buf[3] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_2,=
 BPF_REG_1);
> @@ -23369,8 +23383,22 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                 /* Implement get_func_arg_cnt inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg_cnt) {
> -                       /* Load nr_args from ctx - 8 */
> -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_1, -8);
> +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> +                               int nr_args;
> +
> +                               if (!prog->aux->attach_func_proto)
> +                                       return -EINVAL;
> +                               /*
> +                                * skip first 'void *__data' argument in =
btf_trace_##name
> +                                * typedef
> +                                */
> +                               nr_args =3D btf_type_vlen(prog->aux->atta=
ch_func_proto) - 1;
> +                               /* Save nr_args to reg0 */
> +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
nr_args);
> +                       } else {
> +                               /* Load nr_args from ctx - 8 */
> +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> +                       }
>
>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, 1);
>                         if (!new_prog)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6e076485bf70..9b1b56851d26 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>         case BPF_FUNC_d_path:
>                 return &bpf_d_path_proto;
>         case BPF_FUNC_get_func_arg:
> -               return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_=
proto : NULL;
> +               return &bpf_get_func_arg_proto;
>         case BPF_FUNC_get_func_ret:
>                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_=
proto : NULL;
>         case BPF_FUNC_get_func_arg_cnt:
> -               return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_=
cnt_proto : NULL;
> +               return &bpf_get_func_arg_cnt_proto;
>         case BPF_FUNC_get_attach_cookie:
>                 if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> --
> 2.52.0
>

