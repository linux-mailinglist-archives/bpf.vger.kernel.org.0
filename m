Return-Path: <bpf+bounces-46848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E59F0D86
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A07816A2BE
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D61E0E14;
	Fri, 13 Dec 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO6g0GZ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297FA1E0DAC;
	Fri, 13 Dec 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097328; cv=none; b=txuuoGMmn2ocZetq3KYZ/VzFuazAlMcUvO8SPYqTuc9nJee5uBTEvYMPGyMXaWYhASc74qZpq0JMF+VmmiXsPVA+FPNcLWIL4czeXE8ymnnptyJF3mP4B06EahaP5o7OEhgTPXLuuOn5PpymMzx6S8GgTqsK8mtz/3rO+g/b7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097328; c=relaxed/simple;
	bh=LYe6itm0GY/JvgJUgTjkRwEeepcVg7kMnBImBpu8D4s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWfafFGadmTZVWbgl2GnlfZcSzFAG+yjGppqNSB9CwEmeAIbnV0vyzXKR9kIYdy6LSykjf8URAJoL4BEc+IRkOH8jrTZV2YTr++Weg0wHkpTv7Pe3te/bK6bTCR/bTILSj85Smc2pcubB5j1GmwpNEICvT+zEYjP6t7yl1DiJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO6g0GZ7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a766b475so17880575e9.1;
        Fri, 13 Dec 2024 05:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734097324; x=1734702124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7IaFm2B54OMwnf0U0yLcHn8U0Ys6TETOx80M88eE6Nc=;
        b=SO6g0GZ7Vr8htdald1WnB+6gPXhjJzTegJPCtRLDgx9BqUYRrhDwZojHLaXW6dF3Dc
         VYaJkd5ibp3QkqNLnaRrZ5uK3qWejkgl7/0HzYHuTgeVIAHeDxF8nOtuZgfAUM89k0v5
         /DEEdljE5eYhT1QP7BYNOw7BW7UVZ5XiHUoKUCEr3EFhaUfkgXQWPArYwfM4p8UUAySK
         NKZLprIvSAXuEGHGic4EnELnw+S+OM4dpxMQDqqUBR9myoyQoRuRBOe3f4gLUwtEqVEW
         ew/11yubSmTwFcB2EwaHjz2p64p8wRoUDizUpB6sKOuIuVQyiDWgd73+w5Vk6cykHoo0
         /Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734097324; x=1734702124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IaFm2B54OMwnf0U0yLcHn8U0Ys6TETOx80M88eE6Nc=;
        b=KcDxg7KZx/zT1DVzn0MYv6WsTdOIjHrTW50kBPx2UuM5izZvoBAGp2re7nXLMnU9pR
         EpO9XWScSzdKu1zHZVFnP8b3X+2Uc5eeWiUvp2Dkqc7+lcIy/pkDgicwVZQWcQPtriQQ
         hCYI1KRH5+lzI7rvrkKDMe0yoULhoYkPoHGa8oVZuV6PBUg4JEi8zaoPyySB4iXPOkXM
         5M5RAzk1RCThgNKVyQLP0sTmPOCwRyIHC0NbETV3bYLYinpbi0A3Kv1TaKeLkeTz87kH
         GjXnkdu473iivinqptQiTX6JeJXwqCLjpcfzTWhmQptXdiIP7De2193CTc9PP0XEHKVB
         hZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUatu2K47CZhxBAwjgZoQ+rT/EDjcpg2FpNS4Q1vrtmXLB/lBdR1FvSHy4gHdmxS/VKlxJPmucsRZSQzRRmqI39y6wH@vger.kernel.org, AJvYcCWkb55pRACGI8lBflvaWI3Ay1yBvwkFEGxdiN24QRX0tTC/waavpkC05WOC/UXs0K3DcndHSZsDkaXRjSKr@vger.kernel.org, AJvYcCXAiX92ct7Je/PjmUhRD4RkeMSmM//qBHLHMDpHe+3hlJqK2F0eQETagz2ym8XRHojg8YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Slhymn37NEoIKmgmHXtu6WSj4qYMe1ofeD0Jnom4tc88V/pr
	UHfkDJeFvPvCASQRE/3YTjkt7pWBmcmVVsxho6Awt9YY0HBdjRQS
X-Gm-Gg: ASbGncthCiUpKUqZ1ieq1RYLM3E/783RZmeQjGywPs7FLTEWa4dkvVTNcMVXndTK1Uy
	qwY+6EhqnrLNgVtPIxqaB65uO4sQ+/Xmyn+lCFsINCQdZVG/UzqZ632m/JyeHZ5QCgxHuaWtR8V
	sPqMIHZYwqOuzgLe4cq2Fx33X59uU5AzogNIjn8colBVsNJYcQQ7w5OVZb4lCJTkfpZqBBgH5wa
	7XOz/l9jfl+HUuViji61+fdaGfc7MnHN1KOSLqp4y4IPUYgbDIfwMUM6oi+e6SYWhJHCYgkzGRH
	7Ymh6wAWHvWvZqheGWL+qt/44xcsoQ==
X-Google-Smtp-Source: AGHT+IHguh8I2zdiPWGZGBsSgGbCIs6O+N8fyvQTE3eDg+EvA0Bok6y0xCfhRwYkLDLK3z+Je2mhFA==
X-Received: by 2002:a05:600c:c11:b0:434:a684:9b1 with SMTP id 5b1f17b1804b1-4362aa1549bmr21467585e9.4.1734097324354;
        Fri, 13 Dec 2024 05:42:04 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878252d22csm7144039f8f.110.2024.12.13.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:42:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 14:42:01 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 05/13] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <Z1w5qXERTJV9hQ9p@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-6-jolsa@kernel.org>
 <CAEf4BzZEPdGxjHjPGr-4qKFju+roOiAVrMhTuviozmcP1-qojw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZEPdGxjHjPGr-4qKFju+roOiAVrMhTuviozmcP1-qojw@mail.gmail.com>

On Thu, Dec 12, 2024 at 05:01:52PM -0800, Andrii Nakryiko wrote:

SNIP

> > ---
> >  include/linux/uprobes.h |  12 +++++
> >  kernel/events/uprobes.c | 114 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/fork.c           |   1 +
> >  3 files changed, 127 insertions(+)
> >
> 
> Ran out of time for today, will continue tomorrow for the rest of
> patches. Some comments below.

thanks!

> 
> The numbers are really encouraging, though!
> 
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 8843b7f99ed0..c4ee755ca2a1 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -16,6 +16,7 @@
> >  #include <linux/types.h>
> >  #include <linux/wait.h>
> >  #include <linux/timer.h>
> > +#include <linux/mutex.h>
> >
> >  struct uprobe;
> >  struct vm_area_struct;
> > @@ -172,6 +173,13 @@ struct xol_area;
> >
> >  struct uprobes_state {
> >         struct xol_area         *xol_area;
> > +       struct hlist_head       tramp_head;
> > +};
> > +
> 
> should we make uprobe_state be linked by a pointer from mm_struct
> instead of increasing mm for each added field? right now it's
> embedded, I don't think it's problematic to allocate it on demand and
> keep it until mm_struct is freed

seems like good idea, I'll check on that

> 
> > +struct uprobe_trampoline {
> > +       struct hlist_node       node;
> > +       unsigned long           vaddr;
> > +       atomic64_t              ref;
> >  };
> >
> >  extern void __init uprobes_init(void);
> > @@ -220,6 +228,10 @@ extern int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *p
> >                                      unsigned long vaddr, uprobe_opcode_t *new_opcode,
> >                                      int nbytes);
> >  extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes);
> > +extern struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr);
> > +extern void uprobe_trampoline_put(struct uprobe_trampoline *area);
> > +extern bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
> > +extern const struct vm_special_mapping *arch_uprobe_trampoline_mapping(void);
> >  #else /* !CONFIG_UPROBES */
> >  struct uprobes_state {
> >  };
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 8068f91de9e3..f57918c624da 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -615,6 +615,118 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
> >                         (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE);
> >  }
> >
> > +bool __weak arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
> 
> bikeshedding some more, I still find "is_callable" confusing. How
> about "is_reachable_by_call"? slightly verbose, but probably more
> meaningful?

yep, more precise, will change

> 
> > +{
> > +       return false;
> > +}
> > +
> > +const struct vm_special_mapping * __weak arch_uprobe_trampoline_mapping(void)
> > +{
> > +       return NULL;
> > +}
> > +
> > +static unsigned long find_nearest_page(unsigned long vaddr)
> > +{
> > +       struct mm_struct *mm = current->mm;
> > +       struct vm_area_struct *vma, *prev;
> > +       VMA_ITERATOR(vmi, mm, 0);
> > +
> > +       prev = vma_next(&vmi);
> 
> minor: we are missing an opportunity to add something between
> [PAGE_SIZE, <first_vma_start>). Probably fine, but why not?

true, will add that check

> 
> > +       vma = vma_next(&vmi);
> > +       while (vma) {
> > +               if (vma->vm_start - prev->vm_end  >= PAGE_SIZE) {
> > +                       if (arch_uprobe_is_callable(prev->vm_end, vaddr))
> > +                               return prev->vm_end;
> > +                       if (arch_uprobe_is_callable(vma->vm_start - PAGE_SIZE, vaddr))
> > +                               return vma->vm_start - PAGE_SIZE;
> > +               }
> > +
> > +               prev = vma;
> > +               vma = vma_next(&vmi);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> 
> [...]
> 
> > +struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
> > +{
> > +       struct uprobes_state *state = &current->mm->uprobes_state;
> > +       struct uprobe_trampoline *tramp = NULL;
> > +
> > +       hlist_for_each_entry(tramp, &state->tramp_head, node) {
> > +               if (arch_uprobe_is_callable(tramp->vaddr, vaddr)) {
> > +                       atomic64_inc(&tramp->ref);
> > +                       return tramp;
> > +               }
> > +       }
> > +
> > +       tramp = create_uprobe_trampoline(vaddr);
> > +       if (!tramp)
> > +               return NULL;
> > +
> > +       hlist_add_head(&tramp->node, &state->tramp_head);
> > +       return tramp;
> > +}
> > +
> > +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> > +{
> > +       hlist_del(&tramp->node);
> > +       kfree(tramp);
> 
> hmm... shouldn't this be RCU-delayed (RCU Tasks Trace for uprobes),
> otherwise we might have some CPU executing code in that trampoline,
> no?

so we call destroy_uprobe_trampoline in 2 scenarios:

  - from uprobe_trampoline_put (in __arch_uprobe_optimize) when we failed
    to optimize the uprobe, so no task can execute it at that point

  - from clear_tramp_head as part of the uprobe trampolines cleanup
    (__mmput -> uprobe_clear_state) at which point the task should be dead

jirka

> 
> > +}
> > +
> 
> [...]

