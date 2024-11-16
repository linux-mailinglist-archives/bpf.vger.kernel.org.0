Return-Path: <bpf+bounces-45029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE19D0108
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CF2286866
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067FE198841;
	Sat, 16 Nov 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNUuzzfX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99EA15E97;
	Sat, 16 Nov 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793308; cv=none; b=bYYXOLxhIhuwZbhV2XNRjxuaDftz8pWzm17t/Om0BpRc+GA0YOZzNinEYhXp+ox5gInMk0RAFHQs+TgCtMvzYpOramRvVyJYR8Q4hynx+KaHJX0mq9rOcHISx4SLJkLxTUwKXJPu1rpSda0JuH/Qv/gui3ih+OQtnOqGUyK0YQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793308; c=relaxed/simple;
	bh=rOlrV0T1yge/XKcECTuLt52SugDKbCyjmfsmlMuMuSQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxdXaGVGslqsCSpiecMTuNvlzAUH/D3rG+EaSrNBAf3mWULzstLhtm3CLDtdORyf8K7BdhqAIsFm6cq7jLWPSjcWkYrqriELmc7a69mZ8GhRn2fs62BbGSvvynPPVlq3fcoxZ4ulnmmFh7M1LqOWKiSskxB0zM4+pJpvdB3MZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNUuzzfX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so506666466b.1;
        Sat, 16 Nov 2024 13:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731793305; x=1732398105; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0vMX0IqGCKL/SMwGq+jgppYO3PlvC4SaHpBCmTku15Q=;
        b=DNUuzzfXPH7gMeA9BW/A31/lCwI/OlMoxY8oFeJBWQ840ZhM4r3hYB5UBP/k3vHgz8
         YB9AI5MT6r/lZogbXE6W+I0M9bp0p1B325IAqzY09ygpu7fUhLDWbjwIMPP9CfCvO52Q
         /i4fO4rGaKeTC6l4jx+uiJF8e9ewjOnLy8rguhv/CJx6B+Id39PVgZB9a1n+2AcdSha8
         4IY+bm3vQtBl37fG+FFsoH7yYkXEQnkRglq+nC6nhkNEkWa2dgad0dwzuxIYHgkfjBsr
         hgfI/slGMD/si/B5/7kwO8vKxfqzZs8FuyL00y4lV6oNNMOF6bilejnEMCK+leTbcR9a
         6DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793305; x=1732398105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vMX0IqGCKL/SMwGq+jgppYO3PlvC4SaHpBCmTku15Q=;
        b=AS564MOVY7E1AOmM7fUJ7hx0UErwZfNqbU5u55bA+7+IA0x0+VAJShKpnGZ930yowo
         TACCKFwr9X/uE9Xx7dqXWDgy6ve75mlqiGdwp++Hh1uzY7YgpJTWxrf36TShGoVlhl1K
         j+nm/naNPX7sml1iEc4NDx2BiqGlMcxfyfvalRMn9ueTXudFtrya9rLPBibyZFzIcx1C
         s1nKJuvS14nxu6eICJCVHhK4MprSUZHd8lCCyf8cfHLwRL0OJYydUUjd0lSnzqe7bZX/
         9ii0t5yw3E82MuSa9gPygqbwG0U4vQ8ZrkuXUIkQerZuxishizInomUAOJIqWOvcOHhg
         fPzw==
X-Forwarded-Encrypted: i=1; AJvYcCV0kY0RZAOZrcIxVgI2y84IgF4cl9PvYuDDT9T6q+cERdEeFe8sNh8T5qnOp20YfdqIniFGH1fP/NaZasr8@vger.kernel.org, AJvYcCVILCUr23vAHL3H0IIBaLM17GITqMT9LXFK9O7jh7gefFkVXZD/qzBZEd+pP7pYNzc51Io=@vger.kernel.org, AJvYcCVp4RFKqz9CXKA0YnlbCXwZ/GDCa6vdroboRojugLfk//+4aXbEcLM6IlbEAXJhvZJAmNY0DWGzFe+RVbKTPoAsj8XY@vger.kernel.org
X-Gm-Message-State: AOJu0YzziPQ/KLfwv+GQyyh5FHaqnHY9Q1BkeIZ3Gk3V9fsm6QcYFOS4
	vBDBDpmnnknXwagCqtczgj2lu3qmqN2z4SYWmxiAgK9OG+pbKpfM
X-Google-Smtp-Source: AGHT+IHqb/LaXEcKiRo4I6dbR49FkuB/lR/1goV5z5QOE/LNlVIua58FP4/nDjADDy7UncS4/aF8eg==
X-Received: by 2002:a17:906:519:b0:a9f:508:5f5a with SMTP id a640c23a62f3a-aa4a28a3cb5mr146492366b.40.1731793304893;
        Sat, 16 Nov 2024 13:41:44 -0800 (PST)
Received: from krava (85-193-35-167.rib.o2.cz. [85.193.35.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffc00sm351293866b.101.2024.11.16.13.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 13:41:44 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Nov 2024 22:41:38 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 02/11] uprobes: Make copy_from_page global
Message-ID: <ZzkRkmxWIIf1fWsC@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-3-jolsa@kernel.org>
 <CAEf4BzaqbBPmCvW5m8VCpxoKMu8B=1yYxAJ64m9gtS=Tg5Rz7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaqbBPmCvW5m8VCpxoKMu8B=1yYxAJ64m9gtS=Tg5Rz7g@mail.gmail.com>

On Thu, Nov 14, 2024 at 03:40:58PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 5, 2024 at 5:34 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Making copy_from_page global and adding uprobe prefix.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h |  1 +
> >  kernel/events/uprobes.c | 10 +++++-----
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 2f500bc97263..28068f9fcdc1 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -213,6 +213,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >  extern void uprobe_handle_trampoline(struct pt_regs *regs);
> >  extern void *arch_uretprobe_trampoline(unsigned long *psize);
> >  extern unsigned long uprobe_get_trampoline_vaddr(void);
> > +extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
> >  #else /* !CONFIG_UPROBES */
> >  struct uprobes_state {
> >  };
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 0b04c051d712..e9308649bba3 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -250,7 +250,7 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
> >         return is_swbp_insn(insn);
> >  }
> >
> > -static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
> > +void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
> >  {
> >         void *kaddr = kmap_atomic(page);
> >         memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
> > @@ -278,7 +278,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
> >          * is a trap variant; uprobes always wins over any other (gdb)
> >          * breakpoint.
> >          */
> > -       copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
> > +       uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
> >         is_swbp = is_swbp_insn(&old_opcode);
> >
> >         if (is_swbp_insn(new_opcode)) {
> > @@ -1027,7 +1027,7 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
> >         if (IS_ERR(page))
> >                 return PTR_ERR(page);
> >
> > -       copy_from_page(page, offset, insn, nbytes);
> > +       uprobe_copy_from_page(page, offset, insn, nbytes);
> >         put_page(page);
> >
> >         return 0;
> > @@ -1368,7 +1368,7 @@ struct uprobe *uprobe_register(struct inode *inode,
> >                 return ERR_PTR(-EINVAL);
> >
> >         /*
> > -        * This ensures that copy_from_page(), copy_to_page() and
> > +        * This ensures that uprobe_copy_from_page(), copy_to_page() and
> 
> rename copy_to_page() for symmetry?

ok

jirka

> 
> 
> >          * __update_ref_ctr() can't cross page boundary.
> >          */
> >         if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
> > @@ -2288,7 +2288,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
> >         if (result < 0)
> >                 return result;
> >
> > -       copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
> > +       uprobe_copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
> >         put_page(page);
> >   out:
> >         /* This needs to return true for any variant of the trap insn */
> > --
> > 2.47.0
> >

