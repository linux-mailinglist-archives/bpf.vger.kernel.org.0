Return-Path: <bpf+bounces-45032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D219D010D
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B882867A8
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED81ADFFE;
	Sat, 16 Nov 2024 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTgxEZmB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE015E97;
	Sat, 16 Nov 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793422; cv=none; b=CPJsz6cpxGw+vw5BW/K2bHReT8pENpj8udQ5ATGQfwNVqHyu+RCyan5954YTgPB8gpHVNAXp+CiEFISh1btoCapOUNTqx+k0j7PItpfFoqau7xLO1uLkSSFRiiK3bNLFC/Gm4ULchWl9kOMStooc1B6lwkN6QeXXgjUziVJoiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793422; c=relaxed/simple;
	bh=lia+aQr0DaNhu5eUoSTUU4zRmYfQNqmuc+9kQjPcQCA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqwzBbPGpMGXwZj7OQd0DkYTs6PG9aWy4/WsWx3v/f7RmRaHorM+h/D8qoZ3e1oXCPDUWtgezqfAOLRD5p2lKuOE4JF0yCxmwcmrBQYJHlOZCmlpUY2llf7mMzq3dxHl4Z7O77/fhjmLt7Qbr5M2iVIopiSMQITcKBuDJqk1lSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTgxEZmB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfbc911b6cso103215a12.1;
        Sat, 16 Nov 2024 13:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731793419; x=1732398219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fdyd1z/CkHZCEoZ4pqP+IpNCg5zW4io92DgVJIh5HMY=;
        b=hTgxEZmBYalEqI/LS//tJzP69hP4nGd19JNVRVstj+dWU1gOlKjW6Ij7Q94GA7rJMM
         7kIDKw0tvDZF4RSOhWurTOjFXjwwognJBLvH9ynNYWHKDp6Atq70buNGZ/5POv0BbOpv
         0/RDrgGMvcDO8UYeIj4wvidkgd7X4XY80QxWJtimHsAsWv36G2751kYiFN5YE41RmeHF
         1g7Pbq0K9EfUINpTai0sbRwTXI5yx67QM45RyS9SDe5AjkQWoSRWdWxPB9srWyGwt/Bq
         ksPggXEiO5TXMuApZzALLidwLHQPLqUZ1VbzvePrnq2J6ZymgxZe/npSsEvs1Miy3Jdl
         n1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793419; x=1732398219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdyd1z/CkHZCEoZ4pqP+IpNCg5zW4io92DgVJIh5HMY=;
        b=LJl8eOBVGvPIFt82Hgp4ubc6sI3rhgQid4wL22WUDHm2kW05huvhgH0tdXMGl6yIor
         R6May2YX5DqRVmPTo4UxNq+ApS61cbKW53frXoE29e0/3d5Lwoc1CGya/myYsOzHQ7wf
         er5rw446CHtwRYLunZvCven0sys27k7XCxnU+RtjEOAnNrtoZ37v1Dl6DTmCHUpK4qW/
         bPCFF9hVLKo7L8N+nQgd5ELH8JQaAcD/filh5AXC9iWgoiy4bIGnSlUMNYrnQ3a88zPG
         i4QcTtd1Em9WEGMZgxO1RblVM05iq1+5wUPB2QnuXri0spwpAUhMQX6kib3URGuLB3GT
         Y5qw==
X-Forwarded-Encrypted: i=1; AJvYcCVF/5c30F/5XhiYq4kfIS4U9nwk6XaFfYJ0LoBvrC4nSU2RHiTA3Vp3gbOc97IZ+HagzIw=@vger.kernel.org, AJvYcCVUxywUx/OmuHJnMvGFKHxM8ih9ORJb7BujKMaZDZk+oksLx24464fhkJJU8pqb8WZclwXxW3Rj4Qru7rlw@vger.kernel.org, AJvYcCW6wZgwTfQzGtTajmslYy6cGV5i3Dzmp+fm0AA5yNbdUtJgIRCuCM+y5UOEpIK/hY0ABRklFm50b622bQ3ELp3ff3L0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gpnBm7uL1Xygath2T7+IAECNen9ecwuzDfZ7KHWP2Mup/UBp
	3DpnDEkxRLQXcKNmpOpJzK2AkudiREpauQfV2/PA/4Cvdkc/wocV
X-Google-Smtp-Source: AGHT+IFsJIpzh9Dc9z70GhcPd1em1mRziZZE0coYdp5C2v8kF9E7SWpmGMXT7Qr1Q5UPunLrlGtEzg==
X-Received: by 2002:a17:907:2ce6:b0:a99:c075:6592 with SMTP id a640c23a62f3a-aa48354d554mr747480466b.56.1731793418986;
        Sat, 16 Nov 2024 13:43:38 -0800 (PST)
Received: from krava (85-193-35-167.rib.o2.cz. [85.193.35.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df515e0sm346066766b.53.2024.11.16.13.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 13:43:38 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Nov 2024 22:43:35 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 04/11] uprobes: Add data argument to
 uprobe_write_opcode function
Message-ID: <ZzkSB7QETdOd1S2X@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-5-jolsa@kernel.org>
 <CAEf4Bzbufp=pSqNHZu6+FPAqGSOqoE56R4KnewECFbdtAe-eeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbufp=pSqNHZu6+FPAqGSOqoE56R4KnewECFbdtAe-eeg@mail.gmail.com>

On Thu, Nov 14, 2024 at 03:41:08PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 5, 2024 at 5:34 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding data argument to uprobe_write_opcode function and passing
> > it to newly added arch overloaded functions:
> >
> >   arch_uprobe_verify_opcode
> >   arch_uprobe_is_register
> >
> > This way each architecture can provide custmized verification.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h |  6 +++++-
> >  kernel/events/uprobes.c | 25 +++++++++++++++++++------
> >  2 files changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 7d23a4fee6f4..be306028ed59 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -182,7 +182,7 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
> >  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
> >  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> >  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > -                              unsigned long vaddr, uprobe_opcode_t *insn, int len);
> > +                              unsigned long vaddr, uprobe_opcode_t *insn, int len, void *data);
> >  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> >  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
> >  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> > @@ -215,6 +215,10 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
> >  extern void *arch_uretprobe_trampoline(unsigned long *psize);
> >  extern unsigned long uprobe_get_trampoline_vaddr(void);
> >  extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
> > +extern int uprobe_verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode);
> > +extern int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> > +                                    uprobe_opcode_t *new_opcode, void *data);
> > +extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void *data);
> >  #else /* !CONFIG_UPROBES */
> >  struct uprobes_state {
> >  };
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 3e275717789b..944d9df1f081 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -264,7 +264,13 @@ static void copy_to_page(struct page *page, unsigned long vaddr, const void *src
> >         kunmap_atomic(kaddr);
> >  }
> >
> > -static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
> > +__weak bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void *data)
> > +{
> > +       return is_swbp_insn(insn);
> > +}
> > +
> > +int uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> > +                        uprobe_opcode_t *new_opcode)
> >  {
> >         uprobe_opcode_t old_opcode;
> >         bool is_swbp;
> > @@ -292,6 +298,12 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
> >         return 1;
> >  }
> >
> > +__weak int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> > +                                    uprobe_opcode_t *new_opcode, void *data)
> 
> why wrapping lines? even original longer code was single line

hm, adding 'uprobe_opcode_t *new_opcode' would make the line over 100 chars,
but right, surrouding code is not strict ;-) ok

jirka

> 
> 
> > +{
> > +       return uprobe_verify_opcode(page, vaddr, new_opcode);
> > +}
> > +
> >  static struct delayed_uprobe *
> >  delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
> >  {
> > @@ -471,7 +483,8 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
> >   * Return 0 (success) or a negative errno.
> >   */
> >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > -                       unsigned long vaddr, uprobe_opcode_t *insn, int len)
> > +                       unsigned long vaddr, uprobe_opcode_t *insn, int len,
> > +                       void *data)
> >  {
> >         struct uprobe *uprobe;
> >         struct page *old_page, *new_page;
> > @@ -480,7 +493,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >         bool orig_page_huge = false;
> >         unsigned int gup_flags = FOLL_FORCE;
> >
> > -       is_register = is_swbp_insn(insn);
> > +       is_register = arch_uprobe_is_register(insn, len, data);
> >         uprobe = container_of(auprobe, struct uprobe, arch);
> >
> >  retry:
> > @@ -491,7 +504,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >         if (IS_ERR(old_page))
> >                 return PTR_ERR(old_page);
> >
> > -       ret = verify_opcode(old_page, vaddr, insn);
> > +       ret = arch_uprobe_verify_opcode(old_page, vaddr, insn, data);
> >         if (ret <= 0)
> >                 goto put_old;
> >
> > @@ -584,7 +597,7 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned
> >  {
> >         uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> >
> > -       return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP_INSN_SIZE);
> > +       return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP_INSN_SIZE, NULL);
> >  }
> >
> >  /**
> > @@ -600,7 +613,7 @@ int __weak
> >  set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
> >  {
> >         return uprobe_write_opcode(auprobe, mm, vaddr,
> > -                       (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE);
> > +                       (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE, NULL);
> >  }
> >
> >  /* uprobe should have guaranteed positive refcount */
> > --
> > 2.47.0
> >

