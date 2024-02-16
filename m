Return-Path: <bpf+bounces-22125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7138573C3
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 03:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13BD1C2237D
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 02:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19ADFC02;
	Fri, 16 Feb 2024 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkGC/pgt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B1FBE9
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049896; cv=none; b=lHhUkDaNmyNjkzD+3djTNXpvL3aHLys7/0wS+oyF/Kdq4B31AGzUAzVJu3mTVnDlCGkVxM2P62x7kKwdfj6pLEz/iQWD0TIiTWtv1pVVtyU7TXt7Z+KhPPUGp6bOAEsQsPyR0wY9EYr/eIqevLyljgckjoWq2Pq5qtGjaVAs2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049896; c=relaxed/simple;
	bh=A0+cibfuNdOW9TUrUkdg/xe7mlqYOqyz7I1uRb+leXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkM4vBCGlleHsd5ZT7Ent7/jJt2gs+JUB4vQ0G6Saw8E/G//8UDsR0ui4vRJUnx8gnT7+yOxMFt7yK+75apw6TXdmQaJ870vfZArJ/82LkRPOFKrW7BqELrpQK3CtyRscokjcZSVMVyjvd1BT8LGCdMKSGV5Fgj6crUxElu0nWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkGC/pgt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso9007165e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 18:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708049893; x=1708654693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KFuzazkelQ2TtWPrzhQD5AFOSGYdLNU6Iir3sc8k4o=;
        b=PkGC/pgtAgq6Qv20nt2hYgX3lxbFA5fpoDscsOOYi1G8o6npoeRwSZ7pXgPbBn3E5y
         jm5WnJgTdyEQcn8W27HEtqyteUX2EkVb1V/Qsih8mBuYr29D4KfDtOJLFud6LtYp0nAL
         acDA/+ynpklwAJlQOKo3hxnBaJOg4QZAXYd0Nk5t9LWmf58pOw94nUJsU5G3Lm/7vNfI
         hrF9k912l+OgVn4ILPXG5q1lLgHfJELvw6Gkh7lyWo60eX7cqSPWHtyWUPjW2oxgTyAU
         w+04Q+4BhqA2w9LqdVxPiJYwKOhoWjFBikXuAkTjl7gJ/jXT6lSHd2DDskd5dZ+WbkUz
         tgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708049893; x=1708654693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KFuzazkelQ2TtWPrzhQD5AFOSGYdLNU6Iir3sc8k4o=;
        b=tSjwZnmZe8OT93U8m8dItn3FTTREDD9+czKG/dJyWXPE/m52IQY8lTUk8QdJzBzCko
         03HXvtDTJq5hQrCRC63VyxsBBhWYLqCnget+Gc4n2D3+gBJgpbNO5Rzjs9cDaRvBwHF8
         K+2vAB9j8oGBGg10HIZW7NKfhaGz0dqNh7Kds4ZTFx/93hSc0SYQgFBGWihObTz7/nvu
         1cDw/1gP8c/BKCTLGtZnZnk7TIO3I5nzy19thx3LCk6OyFP8u+sghUUH5dRt8ytckFTG
         XomxdKPjV6NaqkoIdu3wSroKLFNjteTeX75cAYA4+73Lnbr5c4Np7HqemS5D5E9BsWX2
         fVnQ==
X-Gm-Message-State: AOJu0YyYssVfrSqMS7aY7kYi3wAiHuhAe2aDKQKqccQ19Ae3tTnthErb
	QPiirw7Bl4V/L73lvI5h/m7LRGYNux9r/HCMhYlM134VqXX3+GEOdkLwhQp0RqhFm+5SmvbW20f
	0JLXAHsXiAO973j379rWAcDol7m8=
X-Google-Smtp-Source: AGHT+IG52Q1oJCf8+iCJ2hddL0MhmFUzyAOMnZT6nojKuZLpSkQqhfIBDmEp7q2q0ocTgjA2etIZ/5B/DeJnkvLicfI=
X-Received: by 2002:a05:600c:4f91:b0:412:17ac:3df1 with SMTP id
 n17-20020a05600c4f9100b0041217ac3df1mr3069048wmq.14.1708049892718; Thu, 15
 Feb 2024 18:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142226.87869-1-hffilwlqm@gmail.com> <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com> <CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com>
 <81607ab3-a7f5-4ad1-98c2-771c73bfb55c@gmail.com>
In-Reply-To: <81607ab3-a7f5-4ad1-98c2-771c73bfb55c@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Feb 2024 18:18:01 -0800
Message-ID: <CAADnVQJVC21dh9igQ7w=iMamx-M=U2H+Vt7fJE-9tB4qR4tHsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:16=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
> Here's the diff:

Please always send a diff against bpf-next.
No one remembers your prior patch from months ago.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 4065bdcc5b2a4..fc1df6a7d87c9 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -241,6 +241,8 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
>  }
>
>  struct jit_context {
> +       int prologue_tail_call_offset;
> +
>         int cleanup_addr; /* Epilogue code offset */
>
>         /*
> @@ -250,6 +252,8 @@ struct jit_context {
>          */
>         int tail_call_direct_label;
>         int tail_call_indirect_label;
> +
> +       bool tail_call_reachable;
>  };
>
>  /* Maximum number of bytes emitted while JITing one eBPF insn */
> @@ -259,7 +263,7 @@ struct jit_context {
>  /* Number of bytes emit_patch() needs to generate instructions */
>  #define X86_PATCH_SIZE         5
>  /* Number of bytes that will be skipped on tailcall */
> -#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
> +#define X86_TAIL_CALL_OFFSET   (14 + ENDBR_INSN_SIZE)
>
>  static void push_r12(u8 **pprog)
>  {
> @@ -389,6 +393,19 @@ static void emit_cfi(u8 **pprog, u32 hash)
>         *pprog =3D prog;
>  }
>
> +DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
> +
> +__attribute__((used))
> +static u32 *bpf_tail_call_cnt_prepare(void)
> +{
> +       u32 *tcc_ptr =3D this_cpu_ptr(&bpf_tail_call_cnt);
> +
> +       /* Initialise tail_call_cnt. */
> +       *tcc_ptr =3D 0;
> +
> +       return tcc_ptr;
> +}

This might need to be in asm to make sure no callee saved registers
are touched.

In general that's better, but it feels we can do better
and avoid passing rax around.
Just access bpf_tail_call_cnt directly from emit_bpf_tail_call.

