Return-Path: <bpf+bounces-49551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F8A19BD4
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 01:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123A6188D842
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 00:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F7D8F5A;
	Thu, 23 Jan 2025 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al9pnrM3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDAA1E4A6;
	Thu, 23 Jan 2025 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737592403; cv=none; b=TcR/C/bgUHcJBqHjBl0dV/BWNdfHrJWH3F3ggl/rM9nQuY05A971EwVHMeukvgukb2U9mDoi3B7Z/uJLFC7UIdAmbn9o6sfN/cL10txVXlMP2ybmxbOc+bhUcLPZot1ylJc/g9z0x9V8xmqfNwu33/Gj03jQvzRRWn+0ifWfMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737592403; c=relaxed/simple;
	bh=eeulK7nJPYKa5M4f+t/A8PJWGjiUXpE+ex8szSRUk+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RV91FTQq/wcmQWVjnBrhjoqKeP7JtKuGmNgRSySi37C9I0fcm0TOvW0ao/G7alXAlYmRKR+HNZvqNOwrHG0BHBDQgLi94bcY8roKo6xQ0XbqSt8oT0++A5d4/KsV/kdMpvc38zr+7e4IJPitCwmVCZZoms8mXY171OXsuJLN8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al9pnrM3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd730so2205075e9.2;
        Wed, 22 Jan 2025 16:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737592400; x=1738197200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvPWW5dzt4qw2cOEmIekTaN/SwHotlmB0JBO8EXO8+8=;
        b=al9pnrM3L7nWiun/vkqOIO9yfT5O86APRUPRRuQpBdmRJRnYI8bcihDkx7DJruloVs
         pov4YfQfaBF9SOZFCm/HyCfcHCx7sH6cGCbH9rWq8VNYsN87mY6lJ+T33QrYL2qdeigA
         e3VMzN6nfiHih4aOlQXqLrbn7J4OLy/CaZ/MyGVypY5PfnluUR4rcDzfq248cqRQUDwG
         0nchseI8d5bl1gL17D6I+jYnsaxhrjmOyyptatNBkC0BgGJz9njhR146RPO4+RnejOxt
         m6ALM32xZiDuh0SfEfvbyFfn/e9TrEN5bjO7I1duzPJdJEHPVNeAwxHbF7OijsIqHvm/
         MQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737592400; x=1738197200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvPWW5dzt4qw2cOEmIekTaN/SwHotlmB0JBO8EXO8+8=;
        b=BvwAA8rUhF3MH0a6UTrM7BKSC4Fiit+LPGqEqsaS6p51DXx6y7kbOb61zeu0nGGyR9
         Ahco6IZzmG1eXHiJ7s0O8fne2XwwSqbgo8kispqqfJMuZvwigjd1KiRf2dRCJUh0h6FU
         Y4FkQtFLs5lBPzPvdDI89rHLztrqEEeAho9Z7uD7Zi23aRl3sjtbZNTPykA4CaEDs3+W
         oRg77918eSXNhMTrfcsBLz81IUTwKhrH9/eFUFvVHGyeTw098xoqj6JWzJCPGqnzS1up
         J7QTjBH3iuyZKcusIaMBhIR11fGFR5VyUBn2kWoQSJQViM7BfIWzH5xIxkhlbU+EwHVa
         q3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUuuEQNVYsJHwMfO9GoUYKJopN10UPmZ+pDAT//cBOnVXoUY46lDQP4WkCbON/Cc0AVryQ=@vger.kernel.org, AJvYcCXyOb+E3kfN1QySaCU0UHznpyEXWREVaoQPA2nLdjHZLEsEVOs2L4tVUVZDE6deFwBe2LvMVNarmwzd+FNO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HrYCUToFgCYxTVWzyqTn8bI9joL08KMwOjAeWU0XEMkzL46y
	VRM1qgVXs7j95VZ4st0d0iuYcbpbNmYbjTJgDV8nIZY1g9DvQDlxfeBW1+hTZxGhj5+DNTubXN5
	jr7donyimJ2BnifYzdoE/LM2ilx8=
X-Gm-Gg: ASbGncs0ExA7xgJcxMeocGhDNJ5+oPBut9BgOfGQV4Rpi9cQyJmyfzXxoMSiXJhjL2O
	5n290jRu9IAc3iAbb12N7tdx5vTYMh4iKAZulG5gB/84QOQM7wov7NGLhbl5MbmVNrJfo8l5aTe
	CHujefhdU=
X-Google-Smtp-Source: AGHT+IHWa+fuHateOIvDDAf/qPbAfSQpc5S5mAfWGldb5EoAMrnMDGwnOmncdWgIl/AgdEFQu85E/Z0pr45L/OyaOE0=
X-Received: by 2002:a5d:47c9:0:b0:386:3e48:f732 with SMTP id
 ffacd0b85a97d-38bf5662a1amr22658870f8f.16.1737592399825; Wed, 22 Jan 2025
 16:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737433945.git.dxu@dxuuu.xyz> <7bfb3b6b1d3400d03fd9b7a7e15586c826449c71.1737433945.git.dxu@dxuuu.xyz>
In-Reply-To: <7bfb3b6b1d3400d03fd9b7a7e15586c826449c71.1737433945.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Jan 2025 16:33:08 -0800
X-Gm-Features: AWEUYZnEvEHvur52jNBEp2ItdcENkHlBZcpa96ZPQ6HQRTu0aFowUbEdINy48gI
Message-ID: <CAADnVQJYCE8ccy-rj6W98hiXutrZfsbWV9H7pKLUyFR-KSKPYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: arraymap: Skip boundscheck during
 inlining when possible
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:35=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> For regular arraymaps and percpu arraymaps, if the lookup is known to be
> inbounds, the inlined bounds check can be omitted. One fewer jump puts le=
ss
> pressure on the branch predictor. While it probably won't affect real
> workloads much, we can basically get this for free. So might as well -
> free wins are nice.
>
> JIT diff for regular arraymap (x86-64):
>
>      ; val =3D bpf_map_lookup_elem(&map_array, &key);
>     -  22:   movabsq $-131387164803072, %rdi
>     +  22:   movabsq $-131387246749696, %rdi
>        2c:   addq    $472, %rdi
>        33:   movl    (%rsi), %eax
>     -  36:   cmpq    $2, %rax
>     -  3a:   jae     0x45
>     -  3c:   imulq   $48, %rax, %rax
>     -  40:   addq    %rdi, %rax
>     -  43:   jmp     0x47
>     -  45:   xorl    %eax, %eax
>     -  47:   movl    $4, %edi
>     +  36:   imulq   $48, %rax, %rax
>     +  3a:   addq    %rdi, %rax
>     +  3d:   jmp     0x41
>     +  3f:   xorl    %eax, %eax
>     +  41:   movl    $4, %edi
>
> JIT diff for percpu arraymap (x86-64):
>
>      ; val =3D bpf_map_lookup_elem(&map_array_pcpu, &key);
>     -  22:   movabsq $-131387183532032, %rdi
>     +  22:   movabsq $-131387273779200, %rdi
>        2c:   addq    $472, %rdi
>        33:   movl    (%rsi), %eax
>     -  36:   cmpq    $2, %rax
>     -  3a:   jae     0x52
>     -  3c:   shlq    $3, %rax
>     -  40:   addq    %rdi, %rax
>     -  43:   movq    (%rax), %rax
>     -  47:   addq    %gs:170664, %rax
>     -  50:   jmp     0x54
>     -  52:   xorl    %eax, %eax
>     -  54:   movl    $4, %edi
>     +  36:   shlq    $3, %rax
>     +  3a:   addq    %rdi, %rax
>     +  3d:   movq    (%rax), %rax
>     +  41:   addq    %gs:170664, %rax
>     +  4a:   jmp     0x4e
>     +  4c:   xorl    %eax, %eax
>     +  4e:   movl    $4, %edi
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  kernel/bpf/arraymap.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 8dbdceeead95..7385104dc0d0 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -221,11 +221,13 @@ static int array_map_gen_lookup(struct bpf_map *map=
,
>
>         *insn++ =3D BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_a=
rray, value));
>         *insn++ =3D BPF_LDX_MEM(BPF_W, ret, index, 0);
> -       if (!map->bypass_spec_v1) {
> -               *insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4=
);
> -               *insn++ =3D BPF_ALU32_IMM(BPF_AND, ret, array->index_mask=
);
> -       } else {
> -               *insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 3=
);
> +       if (!inbounds) {
> +               if (!map->bypass_spec_v1) {
> +                       *insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_en=
tries, 4);
> +                       *insn++ =3D BPF_ALU32_IMM(BPF_AND, ret, array->in=
dex_mask);
> +               } else {
> +                       *insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_en=
tries, 3);
> +               }
>         }

As stands this is not correct for !spec_v1.
Though the verifier confirmed that key is constant, it still
goes via load and math,
so there is a risk of speculation out of bounds.

All that will be non-issue if the actual const_map_key is
passed in and computed into single ld_imm64
(as suggested in the other email).

pw-bot: cr

