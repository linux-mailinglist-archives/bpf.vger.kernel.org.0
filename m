Return-Path: <bpf+bounces-34659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339B392FDFE
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D33B21A5C
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA911741EA;
	Fri, 12 Jul 2024 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezDckx/Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05012B171
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799833; cv=none; b=RQKh4+MN838sUFqwP0tr8QSzgKQwMS8Mrut9NhRnG8yxDeHJi6PjD/h3ZUMWdTNXHIsDSmW+R8DJb7nGzEQuRqqAYVdzIWcasbBpC6Z1t4LiLF/uJJlWnhmcV/qYdNUBxUeWwCrxWGUErTxOuHjXfT18Kab7JFV0AAQv5wMFkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799833; c=relaxed/simple;
	bh=1JS1/PiUu997qwnJGuUecMqt5yRLJgkEzgTpuMp4cRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeII/YwE5NxWzwOWpkCmuf3TfVW+Wm9R6BPFaMw8v0QDuKm98sb0FqDiMNm9SlLB4Gdbi2bdmUpUawQIz14qtrLD5xC5JOSRBNCNCzUQ8nwWEB+2TpVAnnRtUxhaCREy5TOxJWX+gcuPvf5jDzd1v0R6kCr7cIAneNbPrhTN7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezDckx/Y; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so27377511fa.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720799830; x=1721404630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOafKOiCRUN8srawX+PXPFEB+ze/W8Kpa7KJ0yG6TKY=;
        b=ezDckx/YmK/glyQ5mgVA4gOPTAhmCD+ZeZBZuGW0DiCPDiyd1I5XjEecd0nlNo0YJ3
         7wzihlaz80Zv2+oHaJN7tNmtfEf/LwGxzRu+7o1yzqBl8kHV1s3QpCeIVsnZQ0AiGK6Y
         0l/xU4X7AJ1faKgIlVs6dyZ8M8vpeDLdzDu7PG7/9awfXwWBCk7A0fr/Xjjram2OlIUt
         MOl7ZCf8bnJaF/J7IVCX5WIk0dvbaPk57ysK+ZbvnwOsG+7ICOMC7A3NDO6SxdJzEnxs
         wyeQ4ee9gIRnWfX+MjSXm7Wn18JID05FJ01ss5KGMuLnndP/MZOma02gllY+cT9jLu1o
         l8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720799830; x=1721404630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOafKOiCRUN8srawX+PXPFEB+ze/W8Kpa7KJ0yG6TKY=;
        b=fQTKaJjtrdzefWM0VQRfyw4SAdjlYyBn7LgEDQ0KFlgg6Iaqvo7YpL+dypeN9dCw4L
         wZE6R7B9F/mcl/lp/rw+cWiX5+AWpt5IRsnnSTCe1gmTeAX4hzukRXQ7+kfaj7GLLBMy
         yU9QpGexzdn1Mf75ZjFGClnGUqFJRO6Njk/PtzFVoQQn2Q5A0yIPgYg+4FJ8xFnjnNU7
         4b0yVu0S0A8A3jokO7/FpCFziZkUFnHRW5VTOiBjmKMZX4/w3Y/hMGe4EkuV0tPVL4Kb
         4pnE3wuHHcXXyDimOp4LsjSNdH/I1eAzzXnJdxVjNQ2/dROEDeq4GEOg9qFfYRkZC4jl
         6fww==
X-Forwarded-Encrypted: i=1; AJvYcCXsSyoU/7XOUW7Zbq5V7UDXnR1g8yI02J5t55eoHQwWTk3aciQCBZH/WDbLSrvtrRoRYluyDllFISSBLMPlgKvjnGoI
X-Gm-Message-State: AOJu0Yy0tHc+aZxIKNnOV8wDFLmIg3q3Ik+6G6Ilv3M3WqtWuxxZQhie
	qZgyvSA0ymJE5iF9kLVdEHh6Qh238V5J3YVvtLmX+5OqUvPB5RQwmwi2Fv3/j92nj/GQzmFsDqL
	eXxLxfD5mJb1SfvInWepV7A7qj0o=
X-Google-Smtp-Source: AGHT+IHBFf/wKZhwNnz7GKcGGDoUqakKBe6hAUQXtw7g//F96WEE5vI7PQPfl6h9FhyYzY7wsvFRiHxJtDfuqehfmls=
X-Received: by 2002:a05:651c:214:b0:2ee:7590:7ce5 with SMTP id
 38308e7fff4ca-2eeb30ba06bmr72577121fa.3.1720799829701; Fri, 12 Jul 2024
 08:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720778831.git.tanggeliang@kylinos.cn> <9a002aaf658c4dfb3997cf9c5981b3b2350e5c30.1720778831.git.tanggeliang@kylinos.cn>
In-Reply-To: <9a002aaf658c4dfb3997cf9c5981b3b2350e5c30.1720778831.git.tanggeliang@kylinos.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jul 2024 08:56:58 -0700
Message-ID: <CAADnVQJor93EoYm7ioEgtfz=Or3TYu7dbj_Dk1f6HYJK2D3hEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: verifier: Fix return value of fixup_call_args
To: Geliang Tang <geliang@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 3:14=E2=80=AFAM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Run bloom_filter_map selftests (./test_progs -t bloom_filter_map) on a
> Loongarch platform, an error message "JIT doesn't support bpf-to-bpf call=
s"
> is got in user space, together with an unexpected errno EINVAL (22), not
> ENOTSUPP (524):
>
>  libbpf: prog 'inner_map': BPF program load failed: Invalid argument
>  libbpf: prog 'inner_map': -- BEGIN PROG LOAD LOG --
>  JIT doesn't support bpf-to-bpf calls
>  callbacks are not allowed in non-JITed programs
>  processed 37 insns (limit 1000000) max_states_per_insn 1 total_states
>  -- END PROG LOAD LOG --
>  libbpf: prog 'inner_map': failed to load: -22
>  libbpf: failed to load object 'bloom_filter_map'
>  libbpf: failed to load BPF skeleton 'bloom_filter_map': -22
>  setup_progs:FAIL:bloom_filter_map__open_and_load unexpected error: -22
>  #16      bloom_filter_map:FAIL
>
> Although in jit_subprogs(), the error number does be set as "ENOTSUPP":
>
>         verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
>         err =3D -ENOTSUPP;
>         goto out_free;
>
> But afterwards in fixup_call_args(), such error number is ignored, and
> overwritten as "-EINVAL":
>
>         verbose(env, "callbacks are not allowed in non-JITed programs\n")=
;
>         return -EINVAL;
>
> This patch fixes this by changing return values of fixup_call_args() from
> "-EINVAL" to "err ?: -EINVAL". With this change, errno 524 is got in user
> space now:
>
>  libbpf: prog 'inner_map': BPF program load failed: unknown error (-524)
>  libbpf: prog 'inner_map': -- BEGIN PROG LOAD LOG --
>  JIT doesn't support bpf-to-bpf calls
>  processed 37 insns (limit 1000000) max_states_per_insn 1 total_states
>  -- END PROG LOAD LOG --
>  libbpf: prog 'inner_map': failed to load: -524
>  libbpf: failed to load object 'bloom_filter_map'
>  libbpf: failed to load BPF skeleton 'bloom_filter_map': -524
>  setup_progs:FAIL:bloom_filter_map__open_and_load unexpected error: -524
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  kernel/bpf/verifier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c0263fb5ca4b..aa589fedd036 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19717,14 +19717,14 @@ static int fixup_call_args(struct bpf_verifier_=
env *env)
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>         if (has_kfunc_call) {
>                 verbose(env, "calling kernel functions are not allowed in=
 non-JITed programs\n");
> -               return -EINVAL;
> +               return err ?: -EINVAL;
>         }
>         if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) =
{
>                 /* When JIT fails the progs with bpf2bpf calls and tail_c=
alls
>                  * have to be rejected, since interpreter doesn't support=
 them yet.
>                  */
>                 verbose(env, "tail_calls are not allowed in non-JITed pro=
grams with bpf-to-bpf calls\n");
> -               return -EINVAL;
> +               return err ?: -EINVAL;
>         }
>         for (i =3D 0; i < prog->len; i++, insn++) {
>                 if (bpf_pseudo_func(insn)) {
> @@ -19732,7 +19732,7 @@ static int fixup_call_args(struct bpf_verifier_en=
v *env)
>                          * have to be rejected, since interpreter doesn't=
 support them yet.
>                          */
>                         verbose(env, "callbacks are not allowed in non-JI=
Ted programs\n");
> -                       return -EINVAL;
> +                       return err ?: -EINVAL;

Nack.
We're not changing this.
pw-bot: cr

