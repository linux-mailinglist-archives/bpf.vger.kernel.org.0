Return-Path: <bpf+bounces-71611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAF6BF807F
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25772546330
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA53502BC;
	Tue, 21 Oct 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2+NDogU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89626B942
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070632; cv=none; b=sHmSbXeCQte9DrCWHNBAngHrsPNY5dzdD/QpG1ofLBMzAqXzPkjRJKVzfvaVxyBlTh3d68w/hTkOdK/mJmsZnTSyGl3wW4qdscHtCMCkYaliem+st+6l/axTx2XwSLMQsoFUFu+UYx5lA9g4YdXEk3H9/7nCkNkh8V9cZa9euwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070632; c=relaxed/simple;
	bh=uHaCegWf7G1lsvdrseJq4v473UN4vezxPgOeKsQYQfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfrIwhH+vYkHx2VCk+YUjb9d0U5GB/uKPiNd2t+pEOdbDdd4Ie5bWbxskKCIybZZ4FASDBJMfYNtk1rz2gKCYzKlce0sIsARTrscdtol+ksUlPFIHB2omC8HHuuuKxy8jlC6EsKJRVF/7C0+jgHRvgVeiVKBCb5+qJhDRzUnMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2+NDogU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4710683a644so1602215e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761070628; x=1761675428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGD+FcEsW2FFxX+kG8Fzb0HeFi6smqsLpBgWiT17QWM=;
        b=Y2+NDogUB0iETGhC4CXgQ31LdQqAqcvVAm4cv4Pw/8PDCNWVifZnlYrzqoKW4e4vTo
         Srctj0xnbCDCBHoUhNqg2P4kyKOKh2qVA9cJnhfprMQbMt+Zt9c7/3Qm3KOPPXtHaVZo
         khk/CooUbfKTw+aRkP2QK6w3GPWSBVAdLeOygn6dgnx6lc/VFOePQ1ZfDCJk54Jm5DY6
         N7ukILX6OSpXOtC6JI+eu5dSfMkut8CnDEHnQiwgnMKlJ0hJ/6YzcXOV9i97w84Za4YI
         WU/GyPc84CpJksd52Y9dZYI53JJVbe1AUczn1pE+vIOUcWcVJABPV6IIDSNuPlkjr0R7
         yF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070628; x=1761675428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGD+FcEsW2FFxX+kG8Fzb0HeFi6smqsLpBgWiT17QWM=;
        b=sT0z0uXLe1CgD2u2HzTvafyVfFaB/yhsz3TWDFJgsapADq3VkM+wGLFCvFrMS3RVRP
         J/+yCB7cJ8Y0Cmjhj6/26iioGyrxpuhvF3KRfX535QvWwIewjLpjC56P+VrYjKtMg9SR
         RxE/mNS/NurNOKw8XDTtjqtBtKX8cX+6PGLR05Xdj1rDPdT8a3AHvuVwsXTJ3W5Jzgss
         Wi6t/0ipHnZE2EJKZPvDt6DmJCoe6z6B+wgdSrww5aptnHprzUEZQ9tUjyTO/s+p4AEx
         8JHmgfxh1tHkoyiTXDmx8N7Tn9vhjQEpuqiEssYZb4tCxGiWUzx15a9NT7tdYLYEC4F0
         7tvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI8tRaSHV8D3SrL+MyNRFTiS2nqO6bkpTPVItdbAdRraebdG4HyC0CY1TCViXDP7Ax+lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsI7rY+7SYJWXEOK5ANH9n3Ro+6d9pha1Bkin85NesFaC97CRY
	I2HBmbDEr2RoLUxxF9MqeCRGsjDBblUK5ZoFlxoTEWA5eh+65XvDxd9w54/e6Xx3mXLlCc+CLw4
	XGYoQBtNZxfjRFcN0f4mFe7ZkPLG4Hiw=
X-Gm-Gg: ASbGncsfVUU7iyuFb6Tp6YmsSYTO4vMbQFOh9DB8PvArEeESVk7f8TRo/agVQ2QocC3
	JHjE5erOTLPPvVL2YH9Mbeocl3ncFsEVy0YVLt3veWyr28De+T71gzqGcbAMbUqmX77l9liDeJ9
	dUau7Tf8MD8MCZ40lAPNembrC5lXzA4kvL1/1mSEyhlWKaSP+e7Voz10bfWncohaqBPj4FoyXza
	I/QBDEvWoUwOg0nOq99EJUvp5W8ZdIY6zqU8h2VFTB4GLpQdU3dRkRLtTuQnYvRbFEOJXvQLYez
X-Google-Smtp-Source: AGHT+IHAL3TwL3lSrbbeuTOnvc5N+BYP3uS+YNImwOULyrDGTO3KCuxddBINXlS3GnAhet25AeUZNxliKcrwhe5LULc=
X-Received: by 2002:a05:600c:5251:b0:471:846:80ac with SMTP id
 5b1f17b1804b1-475c400151emr4658295e9.18.1761070627745; Tue, 21 Oct 2025
 11:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018142124.783206-1-dongml2@chinatelecom.cn> <20251018142124.783206-4-dongml2@chinatelecom.cn>
In-Reply-To: <20251018142124.783206-4-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 11:16:53 -0700
X-Gm-Features: AS18NWC-vk9wYK7_8tX_FVlBKQAbSU9jzlpKybVeQNDtOy8tuK9-TkGozXjUbPI
Message-ID: <CAADnVQLN96WZd0eWWb=__62g49y_wPfjTPKXaB_=o5jdVE7uKQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 7:21=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)    \
>         __LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> @@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
>                                          void *func_addr)
>  {
>         int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> -       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_=
off;
> +       int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
> +           arg_stack_off, rbx_off;
>         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> +       struct bpf_tramp_links *session =3D &tlinks[BPF_TRAMP_SESSION];
>         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
>         void *orig_call =3D func_addr;
> @@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>          *
>          * RBP - nregs_off [ regs count      ]  always
>          *
> +        * RBP - session_off [ session flags ] tracing session
> +        *
>          * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
>          *
>          * RBP - rbx_off   [ rbx value       ]  always
> @@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>         /* regs count  */
>         stack_size +=3D 8;
>         nregs_off =3D stack_size;
> +       stack_size +=3D 8;
> +       session_off =3D stack_size;

Unconditional stack increase? :(

