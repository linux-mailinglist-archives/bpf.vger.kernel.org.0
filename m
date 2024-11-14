Return-Path: <bpf+bounces-44890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481219C963E
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0797D28322E
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 23:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251321B6D1D;
	Thu, 14 Nov 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjry5jrX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195DA1B3935;
	Thu, 14 Nov 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627685; cv=none; b=ByS+XZa9gniCSmWQL/DyOS5eLWsYcMstFq4QfKPuud3AW8OIUoWTiJaZGwXXorNrjOESmAhxAL85Xx03igxPA6df9ipHb0uYQT91aFXrzmAZSRfHQFL6yUgferkrq1AQABd+5sD7Tabp+n9yqwgaBK45V4xXnLDDxYOc9VZRouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627685; c=relaxed/simple;
	bh=BPo4Ql1iuyifEvEPuCSIs+ptp9YlEUOKHaAy1kVQdpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0AsQBvq8xJ1+yS03sI7oKHPp8uqvhl2PpPQpRrzEzZwx7W5AwSymPipoEASZJUsvDJE/APvsR+Gie/E0KrEXELPs/E7peKT4MDT9s2arAIFHoBF9FxTdSvd1vTWUPDpNXDhUCiUNZ+dfWLKYO5doGuxpJOMiai/9jmpEitYHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjry5jrX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e59746062fso140247a91.2;
        Thu, 14 Nov 2024 15:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731627683; x=1732232483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dpk89JtPBszNTY15D/qwUMevQ8PyuL8jZbzAM5ZU2cU=;
        b=Vjry5jrXK5G6tKmen01mYkNsl7jK/0cqlxYkeORHQfFxk/1MSlTe+9pKx5f/EsvZg6
         0d9S0BZWz0zb23gIruLn3NF8T/xe31OO1/k8+JxhSuB85Vx8LdE1pDGJ6MPizUineW2H
         vw4suEL2PcrLgLypSGNTHYtffNUCFLJJxFi+YFYeYONH2hKWgN/q1eKn7J9TiB7gDoqe
         kbtRZUPCFmQrlhfAt0dWOAjv045KuNMN4dOksVUcvXy0qGskAsO36g6ZTCdQWVZZUtjX
         HC0IrWVjguheRCqHP11hvoONvISbbNJZItVLhJIuwNKLl/z/23QEn/c8JG3l0lnlBHMV
         Ierg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627683; x=1732232483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dpk89JtPBszNTY15D/qwUMevQ8PyuL8jZbzAM5ZU2cU=;
        b=jNdEBeVpho6Xee3WXhGhlHykeWoEYAjS9OcNNwSZjOmZsRyLpuRkRqz8Y43dnRKOuM
         W6uIO4ZX6htaK/lCfkr+8c0ScG9bgH70DjNvyk/whsNLu3NSz6fj9mKCuYB/neMftGyH
         jbMvLC1+WihvPPLlxbedfYwELV2g+dN5f5okTUgV1zT/F89WWQfawayqA59IRPLYXxYr
         ufIkGCw4SdBIkdjZFhs9tLcqOi0h0Iy+qadn2/JV/+iUNYBjoG4DC2MHszETnZ9vaNmp
         ATKX9N1DS9822l9nyanZvBPv1MZa2FJ4PzFJdooCwGyBm51kK9CpkgUoI5bE9th0PJn6
         vR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV97cwjS2S6tP1V3807liIQ9nq0aUeU0brGCImC1Bt79eLL/HfDQl+EMxNAbS4Yb8fUyRnRw4T3+8Fdy52P@vger.kernel.org, AJvYcCWJ8QC6wYP7d/8mZS9ZQtuLarzBzJj24Epy3ZZe2DOhSi1A623CSssHK23fLjp2BEIld0mhjl5aDvEVNGyZWTqloJ71@vger.kernel.org, AJvYcCXeGD6YdB+nASdI3J2FWAuCch9No5Lmuh0Txm/VnlZnPRItN5gAenU3bFtCHI2wsd5RedU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWi8Eo3ylcgYKFEs/1dtbHh7XE0sZ48nG+YeRN2pndj3rW/Nwy
	m6amqnxeiOMQJXKQ+YS6Rf9nmCJu3eF//XaeHIPTQ4ZPGxbfA4ivPTAt/56rAzkc9mKf/3RL0VH
	fUMeq2rLTDJKVVrKkv6toodPhHD0=
X-Google-Smtp-Source: AGHT+IG1L8HnS9t8sf+G3681Lpr1KxtsAJg/iK5alf9Dc4FLqgEdWd+9Ai+u9JJtRMSDjsjJni2ua71g7kgcOJFuW6A=
X-Received: by 2002:a17:90a:fc4e:b0:2da:d766:1925 with SMTP id
 98e67ed59e1d1-2ea1559c7e1mr976495a91.37.1731627683314; Thu, 14 Nov 2024
 15:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-5-jolsa@kernel.org>
In-Reply-To: <20241105133405.2703607-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 15:41:08 -0800
Message-ID: <CAEf4Bzbufp=pSqNHZu6+FPAqGSOqoE56R4KnewECFbdtAe-eeg@mail.gmail.com>
Subject: Re: [RFC perf/core 04/11] uprobes: Add data argument to
 uprobe_write_opcode function
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding data argument to uprobe_write_opcode function and passing
> it to newly added arch overloaded functions:
>
>   arch_uprobe_verify_opcode
>   arch_uprobe_is_register
>
> This way each architecture can provide custmized verification.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  6 +++++-
>  kernel/events/uprobes.c | 25 +++++++++++++++++++------
>  2 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 7d23a4fee6f4..be306028ed59 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -182,7 +182,7 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_st=
ruct *mm,
> -                              unsigned long vaddr, uprobe_opcode_t *insn=
, int len);
> +                              unsigned long vaddr, uprobe_opcode_t *insn=
, int len, void *data);
>  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset=
, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *u=
c, bool);
>  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprob=
e_consumer *uc);
> @@ -215,6 +215,10 @@ extern void uprobe_handle_trampoline(struct pt_regs =
*regs);
>  extern void *arch_uretprobe_trampoline(unsigned long *psize);
>  extern unsigned long uprobe_get_trampoline_vaddr(void);
>  extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr=
, void *dst, int len);
> +extern int uprobe_verify_opcode(struct page *page, unsigned long vaddr, =
uprobe_opcode_t *new_opcode);
> +extern int arch_uprobe_verify_opcode(struct page *page, unsigned long va=
ddr,
> +                                    uprobe_opcode_t *new_opcode, void *d=
ata);
> +extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void=
 *data);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 3e275717789b..944d9df1f081 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -264,7 +264,13 @@ static void copy_to_page(struct page *page, unsigned=
 long vaddr, const void *src
>         kunmap_atomic(kaddr);
>  }
>
> -static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_=
opcode_t *new_opcode)
> +__weak bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void=
 *data)
> +{
> +       return is_swbp_insn(insn);
> +}
> +
> +int uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> +                        uprobe_opcode_t *new_opcode)
>  {
>         uprobe_opcode_t old_opcode;
>         bool is_swbp;
> @@ -292,6 +298,12 @@ static int verify_opcode(struct page *page, unsigned=
 long vaddr, uprobe_opcode_t
>         return 1;
>  }
>
> +__weak int arch_uprobe_verify_opcode(struct page *page, unsigned long va=
ddr,
> +                                    uprobe_opcode_t *new_opcode, void *d=
ata)

why wrapping lines? even original longer code was single line


> +{
> +       return uprobe_verify_opcode(page, vaddr, new_opcode);
> +}
> +
>  static struct delayed_uprobe *
>  delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
>  {
> @@ -471,7 +483,8 @@ static int update_ref_ctr(struct uprobe *uprobe, stru=
ct mm_struct *mm,
>   * Return 0 (success) or a negative errno.
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *m=
m,
> -                       unsigned long vaddr, uprobe_opcode_t *insn, int l=
en)
> +                       unsigned long vaddr, uprobe_opcode_t *insn, int l=
en,
> +                       void *data)
>  {
>         struct uprobe *uprobe;
>         struct page *old_page, *new_page;
> @@ -480,7 +493,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
>         bool orig_page_huge =3D false;
>         unsigned int gup_flags =3D FOLL_FORCE;
>
> -       is_register =3D is_swbp_insn(insn);
> +       is_register =3D arch_uprobe_is_register(insn, len, data);
>         uprobe =3D container_of(auprobe, struct uprobe, arch);
>
>  retry:
> @@ -491,7 +504,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
>         if (IS_ERR(old_page))
>                 return PTR_ERR(old_page);
>
> -       ret =3D verify_opcode(old_page, vaddr, insn);
> +       ret =3D arch_uprobe_verify_opcode(old_page, vaddr, insn, data);
>         if (ret <=3D 0)
>                 goto put_old;
>
> @@ -584,7 +597,7 @@ int __weak set_swbp(struct arch_uprobe *auprobe, stru=
ct mm_struct *mm, unsigned
>  {
>         uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
>
> -       return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP=
_INSN_SIZE);
> +       return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP=
_INSN_SIZE, NULL);
>  }
>
>  /**
> @@ -600,7 +613,7 @@ int __weak
>  set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigne=
d long vaddr)
>  {
>         return uprobe_write_opcode(auprobe, mm, vaddr,
> -                       (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_IN=
SN_SIZE);
> +                       (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_IN=
SN_SIZE, NULL);
>  }
>
>  /* uprobe should have guaranteed positive refcount */
> --
> 2.47.0
>

