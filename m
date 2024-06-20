Return-Path: <bpf+bounces-32628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D089111B3
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D8B1F219D6
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DE1381B8;
	Thu, 20 Jun 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTq21/IV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CDB657;
	Thu, 20 Jun 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910069; cv=none; b=G5TpHCT1e7QYzR0hfCYoSGAfl0Jh54rWOFmsuLG+kTHSIBeP1s4wRfPl8olAexk29v2wvrQCT1QfzEUogw1bipcRoIudpRkyCzu9uUktWM6mMmT7mzjcbkyy5q7U3kJE2TGCIEY6yKLL7ZAiU1QhCJ0huh4g3ZaYPwpu7Gxv27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910069; c=relaxed/simple;
	bh=DhHUliTDv9obS+xUqwdC0en0lhuGpMpydP7QX14WBNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEia1LDketutSalTZLY49eWFjEUA3AvaBE608m/ynC2tLRQDqZN6oQAlNRtrpb0EJWq8Y3+dkDv5gmScU8wPg75gVVwzTeSTCpbMue7r/dCjaueBF2reH0LVC5hhPhYy3ldsBsSdFF9F1BRaQ3QqMMyO6ukBdX0bU8fhJCKNz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTq21/IV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e9f52e99c2so912145a12.1;
        Thu, 20 Jun 2024 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718910068; x=1719514868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edgL49LMRv7Ws8FTfMR2qUOp30oBPUnUg1BlrmXNj0k=;
        b=MTq21/IVEatBY1E1Yx2PfGGPbVGt8wQTrKBFx2BFHEUN065p36JnRzwvQfjwB4bfpv
         f2OoW04xRwH+udRcBqOw9rz0qPru+vVq3p0lzt95E2ocHIubhJdh+A1XEKrm1ciWfoEo
         4ODl4kosg6jMlpYT2VMI/NxtTN778Ha5bT7t8wn0jl9HOlJr4q/2VIk8uWVXBDsDipca
         tQN6QXPOYeqFrZMw94RHq0zM+sERLO7whEPX5ieqOexdYyDFAT4TFJi28ZolTlxKY6HJ
         LhUyL0kO+sP6bu7Ti/F6Ew11Zbfb36oSD3BIhJD+1fowK8JpJGz6Dvdycq6RrgLZET/u
         rUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718910068; x=1719514868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edgL49LMRv7Ws8FTfMR2qUOp30oBPUnUg1BlrmXNj0k=;
        b=OazL4yOYd/avTnXGWy3hmxsd/bHQrkmsn6+5N+JjSJKH4ss0pZD7TR73CzKIIVwizB
         qzipL16ReGzOkCNAfuk8W6jD4de9kJdMHB9Uj3kR+0qeHtTX5qqTYjewyuKp6/vIlCom
         go456XR9yXlzWlidO+1nOUEYavXnWUCdZbTaC9NGNFU1ldo3dfbr4uZqaskteB5AkiQv
         SYxVDfXfp7SGbtL6+PdAy5dwk6EMP0epasQuQIctiB2OR5mH7qI27c2FZr0jKUBSUrUc
         LeEALxnORsozuWC0+IF5v4gwRz5oxIRqt/0Pi7PMBsKzAUUkCMvwAJiH46MvgkqH1UpN
         QQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzWJw2F/nfkDBEUtNA1iqKUvhEr+n7+BComBoCh3u/A2vlF4IIXM3G+s1rUOcvuvuxGglv+OHGUEBeDYapZvZaFL+TVmzt67XV+0VZTTYfl8Ows6UrXat1jfFFoYaIdFlR/bQP5EPfcCx1yrqu08isxa0+1TDTeTPRujdY1XZtgpo7IRIC
X-Gm-Message-State: AOJu0YwBDKN8Q6pAUmt5HssuIIYmxuYaZxx50rjROXgMNXGYgvvHjse5
	k8TjNTJjPWj2XKjrdoDO0XQdRFS57Wzi/meIBgol7Uw1jz6GyBrOwkmxQq0dCIiDHfgoP2uB95O
	ad+AdfvNHKSPKwLuXsERr/VjjqdFOHg==
X-Google-Smtp-Source: AGHT+IFwISJyQPW1kEQVodY5n7ZimQCwzXCRznBCj3vo6t+DlpcwO+ayOJjl5QFOV+y2yc6+XFD75IBGnnNRgJR3+q0=
X-Received: by 2002:a17:90a:8a02:b0:2c2:f704:5278 with SMTP id
 98e67ed59e1d1-2c7b5dc7f9emr6158069a91.42.1718910067663; Thu, 20 Jun 2024
 12:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618194306.1577022-1-jolsa@kernel.org>
In-Reply-To: <20240618194306.1577022-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Jun 2024 12:00:55 -0700
Message-ID: <CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
Subject: Re: [PATCH] uprobe: Do not use UPROBE_SWBP_INSN as static initializer
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:43=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Nathan reported compilation fail for loongarch arch:
>
>   kernel/events/uprobes.c: In function 'arch_uprobe_trampoline':
>   arch/loongarch/include/asm/uprobes.h:12:33: error: initializer element =
is not constant
>      12 | #define UPROBE_SWBP_INSN        larch_insn_gen_break(BRK_UPROBE=
_BP)
>         |                                 ^~~~~~~~~~~~~~~~~~~~
>   kernel/events/uprobes.c:1479:39: note: in expansion of macro 'UPROBE_SW=
BP_INSN'
>    1479 |         static uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
>
> Loongarch defines UPROBE_SWBP_INSN as function call, so we can't
> use it to initialize static variable.
>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return pr=
obe")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Can we instead ask loongarch folks to rewrite it to be a constant?
Having this as a function call is both an inconvenience and potential
performance problem (a minor one, but still). I would imagine it's not
hard to hard-code an instruction as a constant here.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2816e65729ac..6986bd993702 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1476,8 +1476,9 @@ static int xol_add_vma(struct mm_struct *mm, struct=
 xol_area *area)
>
>  void * __weak arch_uprobe_trampoline(unsigned long *psize)
>  {
> -       static uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
> +       static uprobe_opcode_t insn;
>
> +       insn =3D insn ?: UPROBE_SWBP_INSN;
>         *psize =3D UPROBE_SWBP_INSN_SIZE;
>         return &insn;
>  }
> --
> 2.45.1
>

