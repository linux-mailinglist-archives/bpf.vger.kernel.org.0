Return-Path: <bpf+bounces-55355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B4BA7C500
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 22:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E987189F738
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7DF221700;
	Fri,  4 Apr 2025 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVTfUuIZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088720A5E4;
	Fri,  4 Apr 2025 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798824; cv=none; b=acoCdTMD470vA0IBvWLngxSYFyt5xQIulqrrDuI4l9QioNSpNeTT64Ms2EawAgT25mnINh3kdKastr0r31ieOJY9fViADaNDO7AWMV1zaueCgR220Pop9Gs5qyywIh3b+2NsoQALttN/Azogvsb4fHyEjknhhntKUSkpjAkzDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798824; c=relaxed/simple;
	bh=XBHNcDH7QvoBcAFwlBXCPUrRuVBxiTOjCceXiAIaSds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIf4VShGwjUUb2Oa6GCGw04Wz09sQxnnL3VVMEsS1sed2NSsg0u7a6Vp3NDPn2dxNRxBGDILOEXg+TthtZrsBT0UgJL3SD1ByZghK/Mb5hmRT/M4c7JJeBVywXF0M6lMU0EAVxV2MpF54BLdbUENcrIIj0ALNHjgDyDulOVg3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVTfUuIZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso84203166b.0;
        Fri, 04 Apr 2025 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743798821; x=1744403621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k09yDSsU1So732P0LDeY+RNmj8T5f+ur+8RZjasoKk=;
        b=PVTfUuIZucg95lV1arZt2e4q2E3EJPadgf8mjkNvssBk4nYsx9Jph/iG66JspoT3rr
         Vf6bwPdse8PUonM63f8FX74WddCvEoK/QFiHIzrfBJfXXQETsV8KAeSUFkJpIRLjDvCS
         Hk6NbVA1XpnMAVR4Tk5o0jgbEC/Qwn0SaYtqCHJh3H/wToeaRdbvI5Uy7/9Fj3ERhQSk
         oJDmdnkt1JfLSALLcVqqHOiaKj2Bz9GTdJ3bSWa3XePzE7wIASFQA7WrZQ99iVz1hdud
         dW3sNxHEroeHdlFWUgW5bTERl0ZOBmVH2uJdI+ZYfYNBEkcY5lGm6tkNn/JYxYL9JU/n
         i1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743798821; x=1744403621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3k09yDSsU1So732P0LDeY+RNmj8T5f+ur+8RZjasoKk=;
        b=KOU7IilcRnxTdgVkQZLoYU5SoAaiPzsicG3zkSlPA2f1G6Ir8LmjPy5Sx1IKiuPttY
         Scm+ZvaPSACDcN7PPqMWUiHqTWmD/nFgo07g6d5OldJyCx4+xtUhomieZrLGOWU79mKY
         kDIUqCJ+WL0DDvfDTsDCCvqYARrVQQ88nN1/nz/2I/IKsYOFuqpHvlAwKcmtCZh+/cAI
         1wPrFx1ML6SBmg1ZlgDXPCSCe5EN01H++HaRuLmdnb0Vk8dJTojLVPYeW7YeZT5oIGz/
         XypudJlSYqBfPvTzziXOW+mMOmt3HEHrNQ3cxYZn78h1xk4C/bIaGqWnFAS7oWyAV9xl
         8Tfg==
X-Forwarded-Encrypted: i=1; AJvYcCV5peIc9b+ZEH8V408C5r5VpuUDaIYlpzIzvCUDrtRNXP5waIiUNICgNalb9TQodfTHLw1E1taQ4nPLmyFe3njMorLb@vger.kernel.org, AJvYcCWinOYXzD+d+m9wC1Efr1mjh2eftJIjpEj3LkJk2ZWSEmD15KWbh11o6kOmF0+VS6Ua0LQ=@vger.kernel.org, AJvYcCXwT2ODvizJ26KEabt19RWUyCotZYGi3hbleMbi3pNqlbLhG3orbjQLTrlSjYi4TMIDcOyzKwda91S7Pa+i@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpg+vANvGKYy6vJahU59JgKWEOl9RHLSG0AUoKj4M4VjrSWe/
	K+VxZILuM73Lugra5livN1AWwebVt9qKl4fGdOZbmsm8yynoU/7k77UskEYt5o7sMkvP2xOofcl
	PlgPtieXuqGHf7Nje31z4oHznJN8=
X-Gm-Gg: ASbGncv1JvMrZasQR6r2MJi1JVumu3OVRdsLgVex99bL2fO0W6hPNrcrfgFEvxuzzuq
	rASHJzxaSweGjxH+TWHg341RmmVD8o0QJJVDYcAv8l4HbViKsw3lTspsc8QIq27RBdCrmJ6uy7i
	IQ893TWkx8meLd3wZG8VYHVCh1/jniyFWnZ2t2tL2Tdw==
X-Google-Smtp-Source: AGHT+IFzE0zbVVknHfHBfBw7nufJESZ37Dhn4hkFkGzekz00JxhXvrjOXwAmGFDXYCNz7eghjWID09cY5QLnTSBfyTY=
X-Received: by 2002:a17:907:7e8a:b0:ac3:aae:40c6 with SMTP id
 a640c23a62f3a-ac7d1821b46mr351970966b.8.1743798820571; Fri, 04 Apr 2025
 13:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320114200.14377-1-jolsa@kernel.org> <20250320114200.14377-7-jolsa@kernel.org>
In-Reply-To: <20250320114200.14377-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 13:33:02 -0700
X-Gm-Features: ATxdqUEVT2MYEqjCbByq2BfzKEw9mvtcnk9fQIGwtDrVRl06R32IVa5tNUw6Kdk
Message-ID: <CAEf4Bzba80rRKmcUN-rEu5TtRF9F5ePOUJtNYM1nQDTrKOuaQg@mail.gmail.com>
Subject: Re: [PATCH RFCv3 06/23] uprobes: Add orig argument to uprobe_write
 and uprobe_write_opcode
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:43=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The uprobe_write has special path to restore the original page when
> we write original instruction back.
>
> This happens when uprobe_write detects that we want to write anything
> else but breakpoint instruction.
>
> In following changes we want to use uprobe_write function for multiple
> updates, so adding new function argument to denote that this is the
> original instruction update. This way uprobe_write can make appropriate
> checks and restore the original page when possible.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/arm/probes/uprobes/core.c |  2 +-
>  include/linux/uprobes.h        |  5 +++--
>  kernel/events/uprobes.c        | 22 ++++++++++------------
>  3 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/cor=
e.c
> index f5f790c6e5f8..54a90b565285 100644
> --- a/arch/arm/probes/uprobes/core.c
> +++ b/arch/arm/probes/uprobes/core.c
> @@ -30,7 +30,7 @@ int set_swbp(struct arch_uprobe *auprobe, struct mm_str=
uct *mm,
>              unsigned long vaddr)
>  {
>         return uprobe_write_opcode(auprobe, mm, vaddr,
> -                  __opcode_to_mem_arm(auprobe->bpinsn));
> +                  __opcode_to_mem_arm(auprobe->bpinsn), false);
>  }
>
>  bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *reg=
s)
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index c69a05775394..1b6a4e2b5464 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -196,9 +196,10 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
>  extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> -extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_st=
ruct *mm, unsigned long vaddr, uprobe_opcode_t);
> +extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_st=
ruct *mm, unsigned long vaddr,
> +                              uprobe_opcode_t, bool);

add arg names for humans?..

>  extern int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *m=
m, unsigned long vaddr,
> -                       uprobe_opcode_t *insn, int nbytes, uprobe_write_v=
erify_t verify);
> +                       uprobe_opcode_t *insn, int nbytes, uprobe_write_v=
erify_t verify, bool orig);
>  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset=
, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *u=
c, bool);
>  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprob=
e_consumer *uc);

[...]

