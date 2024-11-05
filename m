Return-Path: <bpf+bounces-43991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD329BC364
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0211C21F18
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CFF481A3;
	Tue,  5 Nov 2024 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/iE++js"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7E225A8
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775117; cv=none; b=T38rNwtrf2V5C6aWnJhECrbbO7ewyOlfX2rX60wmJiyU5Gwor60sMVZJWgaJmbYVDMHbSI9YzY2a3aEPvyw/wEJcU/ObhfqC3KiSRWiKZKHmBhlDlmRS9ZGMYTZ3s9cBzG2SbefFBDBTpL1QwZyIHoI7iMEESBDZa8Jm+Gn63Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775117; c=relaxed/simple;
	bh=KmUdL7pXTm0hyXnRnqdrFB2Udc44EseWY06Qrbqf7LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLAaS/RRpCUOMe9igBYlFLi+ZUv2gs20mEASBqJz/ZShxjkUznlsykv4ba4a6SQprTwHhx7/YZY3Lay35d8wxMpryWIbM23CPGa6+i890YG74Az6fa0nSoC+y4ip8dyc9BXe2biaKGAbqed6bao3QRk1I2KZw1bBVqfSXvjWBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/iE++js; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso40605395e9.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 18:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775114; x=1731379914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNb5YKElI14t/BfoPIqrlikj73YlLqQCsPwqXr8oTlI=;
        b=W/iE++jshuKfgKQ7j3Z0e7GmXxCnHTfJrMebzZLEHGQaKgS9pRqttHlrf6Su1mwKfg
         7kyiaKIZhmN6Z6021jvDbKZf7ig6NfcOGV3PKEdEdIeIIMG/6yvjWFe/7Xzod5CoTxpK
         o43YkOhqDx4vaqILZH73/oZZ3L1pMuRdfJ+McCJfxghU0JbDkv5c2KEru6FUPNSGEx3P
         WBSucaLVNaENT50RyZzIkERwR0HeZkJ6vo5c8Kzw9vCUAPfFfoNuRrtilnE2k8fQT6T3
         tBGkUEJC4NdonJN4E6nX1+0X18VkwsYSHUtHh4v7VlejLr0odET7sh+1Ta9aJd37mS1U
         1/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775114; x=1731379914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNb5YKElI14t/BfoPIqrlikj73YlLqQCsPwqXr8oTlI=;
        b=mmr8OGeD07r8QokttHRNi28l4HUuuB/h0xxGPMcBh/vbevX5igJOjL5YT+GT/3+1eb
         hBJACF2BKJt1E7meUszhdPMqq/lOz/L9tNjvpZPLOo05Ncc2cdFdKK7Lhl1DEI1AB0cn
         0nEtFNwhB0Xw8HHbHwiW5H1zR13ddWWKZL2jHg/h7wAxY9IhjR+ozhSwj0+uCF6SNY7I
         Fn7liYYcC9xJsJM2Fw6l2dKJ5vzQN0iDbtyCuQ9CGvCZh6yEylMET8I1GWVn3w07qDBj
         Z2uiSU0woP6Cts96S3daOS2TioZSSfY6hpj6+cEYmHiuN+sbbkvu1KkwQnMSVi88RZlM
         hY5A==
X-Gm-Message-State: AOJu0Yy1FVidBxfbGpcQ02Y8YfUtVO4rJifRiUsHw7d6E6D8KoUoTTrl
	z5xX7HzLd34w+VNVwtNCTAOj604wUQcGiRjKjeO0IYSyZ1+DwSqbHYlhu7AMSTSF3db0F9JtJYG
	IIPE08dNqteLwTLilJuvykVPuKD0=
X-Google-Smtp-Source: AGHT+IGr9rrdOH8Z8LIy9akP2BWgC6lPgCUBXY11SmtTwxCeiQcVRelduFpC3DWRqUBMS3ShR7r8Ujaxy9zZZoAMfj8=
X-Received: by 2002:adf:a353:0:b0:37d:5113:cdef with SMTP id
 ffacd0b85a97d-380611e4e39mr24101759f8f.43.1730775113876; Mon, 04 Nov 2024
 18:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev> <20241104193515.3243315-1-yonghong.song@linux.dev>
In-Reply-To: <20241104193515.3243315-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 18:51:42 -0800
Message-ID: <CAADnVQL3MkDgZykq1H3NhJio8gZDnf3+kXXw7AQ36uT8yw5UfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] bpf: Check potential private stack
 recursion for progs with async callback
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:38=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> In previous patch, tracing progs are enabled for private stack since
> recursion checking ensures there exists no nested same bpf prog run on
> the same cpu.
>
> But it is still possible for nested bpf subprog run on the same cpu
> if the same subprog is called in both main prog and async callback,
> or in different async callbacks. For example,
>   main_prog
>    bpf_timer_set_callback(timer, timer_cb);
>    call sub1
>   sub1
>    ...
>   time_cb
>    call sub1
>
> In the above case, nested subprog run for sub1 is possible with one in
> process context and the other in softirq context. If this is the case,
> the verifier will disable private stack for this bpf prog.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/verifier.c        | 42 +++++++++++++++++++++++++++++++-----
>  2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 0622c11a7e19..e921589abc72 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -669,6 +669,8 @@ struct bpf_subprog_info {
>         /* true if bpf_fastcall stack region is used by functions that ca=
n't be inlined */
>         bool keep_fastcall_stack: 1;
>         bool use_priv_stack: 1;
> +       bool visited_with_priv_stack_accum: 1;
> +       bool visited_with_priv_stack: 1;
>
>         u8 arg_cnt;
>         struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 406195c433ea..e01b3f0fd314 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6118,8 +6118,12 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>                                         idx, subprog_depth);
>                                 return -EACCES;
>                         }
> -                       if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
> +                       if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
>                                 subprog[idx].use_priv_stack =3D true;
> +                               subprog[idx].visited_with_priv_stack =3D =
true;
> +                       }
> +               } else {
> +                       subprog[idx].visited_with_priv_stack =3D true;

See suggestion for patch 3.
It's cleaner to rewrite with a single visited_with_priv_stack =3D true; sta=
tement.

>                 }
>         }
>  continue_func:
> @@ -6220,10 +6224,12 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>  static int check_max_stack_depth(struct bpf_verifier_env *env)
>  {
>         struct bpf_subprog_info *si =3D env->subprog_info;
> +       enum priv_stack_mode orig_priv_stack_supported;
>         enum priv_stack_mode priv_stack_supported;
>         int ret, subtree_depth =3D 0, depth_frame;
>
>         priv_stack_supported =3D bpf_enable_priv_stack(env->prog);
> +       orig_priv_stack_supported =3D priv_stack_supported;
>
>         if (priv_stack_supported !=3D NO_PRIV_STACK) {
>                 for (int i =3D 0; i < env->subprog_cnt; i++) {
> @@ -6240,13 +6246,39 @@ static int check_max_stack_depth(struct bpf_verif=
ier_env *env)
>                                                             priv_stack_su=
pported);
>                         if (ret < 0)
>                                 return ret;
> +
> +                       if (priv_stack_supported !=3D NO_PRIV_STACK) {
> +                               for (int j =3D 0; j < env->subprog_cnt; j=
++) {
> +                                       if (si[j].visited_with_priv_stack=
_accum &&
> +                                           si[j].visited_with_priv_stack=
) {
> +                                               /* si[j] is visited by bo=
th main/async subprog
> +                                                * and another async subp=
rog.
> +                                                */
> +                                               priv_stack_supported =3D =
NO_PRIV_STACK;
> +                                               break;
> +                                       }
> +                                       if (!si[j].visited_with_priv_stac=
k_accum)
> +                                               si[j].visited_with_priv_s=
tack_accum =3D
> +                                                       si[j].visited_wit=
h_priv_stack;
> +                               }
> +                       }
> +                       if (priv_stack_supported !=3D NO_PRIV_STACK) {
> +                               for (int j =3D 0; j < env->subprog_cnt; j=
++)
> +                                       si[j].visited_with_priv_stack =3D=
 false;
> +                       }

I cannot understand what this algorithm is doing.
What is the meaning of visited_with_priv_stack_accum ?

>                 }
>         }
>
> -       if (priv_stack_supported =3D=3D NO_PRIV_STACK && subtree_depth > =
MAX_BPF_STACK) {
> -               verbose(env, "combined stack size of %d calls is %d. Too =
large\n",
> -                       depth_frame, subtree_depth);
> -               return -EACCES;
> +       if (priv_stack_supported =3D=3D NO_PRIV_STACK) {
> +               if (subtree_depth > MAX_BPF_STACK) {
> +                       verbose(env, "combined stack size of %d calls is =
%d. Too large\n",
> +                               depth_frame, subtree_depth);
> +                       return -EACCES;
> +               }
> +               if (orig_priv_stack_supported =3D=3D PRIV_STACK_ADAPTIVE)=
 {
> +                       for (int i =3D 0; i < env->subprog_cnt; i++)
> +                               si[i].use_priv_stack =3D false;
> +               }

why? This patch suppose clear use_priv_stack from subprogs
that are dual called and only from those subprogs.
All other subprogs are fine.

But it seems the alog attempts to detect one such calling scenario
and disables priv_stack everywhere?

