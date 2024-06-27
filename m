Return-Path: <bpf+bounces-33273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5091AD38
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10851F268E2
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B322199E9E;
	Thu, 27 Jun 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DldEElm4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32EA1990C4;
	Thu, 27 Jun 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507110; cv=none; b=URmj0U1szRbZD/hLzDlT+fDxWmEcD5U50mgsrDAGD4QPnNwMOC81lidbyl8y+3Na0Z+uYD97zgG9is6YbhI28uAlnG5o2GlhRoGsUlvCuywsg9M0jc0gUbcgY00mNiXfrbyAXUYHYHhIk0Jo1osDhBtxuhMwJt9MwtFUyFHVoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507110; c=relaxed/simple;
	bh=qIvu4g/bIBmBH2H9f4HwrUaLQ5grYwZpG98mYQbbVE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLrptxn2I5RXlBmnlfk1uqqBN1Ruz/t9sW+rzK5NPjTBO+V8yiMjYhxHYxi4daJhJ9zJdl8g+OT7Xya8hL0U4DfA186xIrDmei+7rtvgeg2zG4L5r4kdI7rqvRS9dnrkT/MZMO1wAPZ+y3hzwmZmP+zYTkNAQTBgqcKNaJ6P4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DldEElm4; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-70b2421471aso5840529a12.0;
        Thu, 27 Jun 2024 09:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719507108; x=1720111908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XSXQVstAeex/QLAPNBTMhwk+wqQDJE0LuUAT237zRI=;
        b=DldEElm4XDMXVQrwrMD6DjndIeVmra915tuWv6nFgQGtUqEUJbP9pvRpq2qYm66YiH
         kTo+ns7znlr9S3uMeAdJfrZngkanwUEN+aozmfgdQh2S+5vELa1SitQ1ef4JlnP4qNfz
         FBAvdhXzs3WByb7E2bS8gd1LT48zAFgUk04FkN3p+qrFi7jsurjRKgq5NeMG0RxLt592
         oRZip697cIbLG0H5OrLgVAtLUcWyRaHiV9vR8Ch5URFnba02KP49GgTkvlwVDtXItQsS
         ecwRJcFblNHwvRzM8mYTt6RsLcoxCezBYnbaG8bTrcNNYhR5ADakODY4GzMKpno0wh8Y
         4yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719507108; x=1720111908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XSXQVstAeex/QLAPNBTMhwk+wqQDJE0LuUAT237zRI=;
        b=a3itqysm13pDVdfXUxzoU/ylqwjonLAXkMmwd6B2x9fgstBMACX5VWnbK7EfpPBZNa
         rx9GY0gMv8ntPxbIresmwlWrgkIR66dub8D+cqegkTKEE7Fk6ZP0/fsPOg7iowI4Zj5I
         PpiMVkeL0y3UqdFp0qAFc3s3NpOlBERDbzXZUIxRWDqtGbKW6jgdiGWMlBarl+1Pav9o
         boAhkSoXrsowrOWqdtt9InV6Lr9jYXLB7l8bO8CXRBqR7CP4nr9uO1M2i2NGQczguIdp
         aTBDCI8UtJhZV4jn+/UUNFeKDHAaKauvPnjHiB628RRB/Ma26pD/Kx3+fSt8jeRzYZw3
         dugQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFfocTSCEp8sM+bESEN4XJdo+TTJWMWzYG9GLlgBSjbNy4pPGjDp537cVugYSprZwPJYcVAosuJuWMRvWw1A1uNF0LP/t3FvoMcdqCFQxE6G+au6RFv2UWnB4TtlzL9jYhb31sqiTOTpUu7op1WNVoblQkSkkNPeQ13WrYwK6OgxcwJepP
X-Gm-Message-State: AOJu0Yx5bj4jYc58/T7gc5E8QWJAxfIPKYHPOx0n8eRhm1R8RyibsfEt
	x9qv3xFjei9FbPnVtlIztwaaythCbWCTnHqAtb4siH5u5xMqY/qyF8KNTnKdwenXID0ykDv2HYu
	YmseP18OiLaPNNBM6HXIQDTp7E20=
X-Google-Smtp-Source: AGHT+IGXhQGVZd2LJiMpsrXL71XDxbNoacHQmSsuRaKegbY7AIu6gYcF5MN/YCRWVrZjSANHroTFUHFWhELa89DiLk4=
X-Received: by 2002:a05:6a20:8c24:b0:1bd:2acd:d175 with SMTP id
 adf61e73a8af0-1bd2acdd201mr5372076637.32.1719507107687; Thu, 27 Jun 2024
 09:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618194306.1577022-1-jolsa@kernel.org> <20240627160255.GA25374@redhat.com>
In-Reply-To: <20240627160255.GA25374@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Jun 2024 09:51:35 -0700
Message-ID: <CAEf4BzZVmKjfQD1zKMDOD-Zc4pVp+EGgb8h2veg=bXe1Pjn_Uw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: uprobes: make UPROBE_SWBP_INSN/UPROBE_XOLBP_INSN
 constant
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:04=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> LoongArch defines UPROBE_SWBP_INSN as a function call and this breaks
> arch_uprobe_trampoline() which uses it to initialize a static variable.
>
> Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return pr=
obe")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20240614174822.GA1185149@thelio-3990X=
/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/loongarch/include/asm/uprobes.h | 6 ++++--
>  arch/loongarch/kernel/uprobes.c      | 8 ++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/arch/loongarch/include/asm/uprobes.h b/arch/loongarch/includ=
e/asm/uprobes.h
> index c8f59983f702..18221eb9a8b0 100644
> --- a/arch/loongarch/include/asm/uprobes.h
> +++ b/arch/loongarch/include/asm/uprobes.h
> @@ -6,13 +6,15 @@
>
>  typedef u32 uprobe_opcode_t;
>
> +#define __emit_break(imm)      (uprobe_opcode_t)((imm) | (break_op << 15=
))
> +
>  #define MAX_UINSN_BYTES                8
>  #define UPROBE_XOL_SLOT_BYTES  MAX_UINSN_BYTES
>
> -#define UPROBE_SWBP_INSN       larch_insn_gen_break(BRK_UPROBE_BP)
> +#define UPROBE_SWBP_INSN       __emit_break(BRK_UPROBE_BP)
>  #define UPROBE_SWBP_INSN_SIZE  LOONGARCH_INSN_SIZE
>
> -#define UPROBE_XOLBP_INSN      larch_insn_gen_break(BRK_UPROBE_XOLBP)
> +#define UPROBE_XOLBP_INSN      __emit_break(BRK_UPROBE_XOLBP)
>

this looks correct (but based on pure code inspection)

>  struct arch_uprobe {
>         unsigned long   resume_era;
> diff --git a/arch/loongarch/kernel/uprobes.c b/arch/loongarch/kernel/upro=
bes.c
> index 87abc7137b73..90462d94c28f 100644
> --- a/arch/loongarch/kernel/uprobes.c
> +++ b/arch/loongarch/kernel/uprobes.c
> @@ -7,6 +7,14 @@
>
>  #define UPROBE_TRAP_NR UINT_MAX
>
> +static __init int check_emit_break(void)
> +{
> +       BUG_ON(UPROBE_SWBP_INSN  !=3D larch_insn_gen_break(BRK_UPROBE_BP)=
);
> +       BUG_ON(UPROBE_XOLBP_INSN !=3D larch_insn_gen_break(BRK_UPROBE_XOL=
BP));
> +       return 0;
> +}
> +arch_initcall(check_emit_break);
> +

I wouldn't even bother with this, but whatever.

>  int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>                              struct mm_struct *mm, unsigned long addr)
>  {
> --
> 2.25.1.362.g51ebf55
>
>

