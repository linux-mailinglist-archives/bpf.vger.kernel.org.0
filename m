Return-Path: <bpf+bounces-45034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9184A9D0112
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DE1B23CE7
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15591AE018;
	Sat, 16 Nov 2024 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlW9GYca"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A31AC450;
	Sat, 16 Nov 2024 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793478; cv=none; b=dpm221+izVn9X76OP/VIIhqfvF0rBlbnvPGPJX4AsnVMyU4d4WRPEA+ThHMNt4DjafwiiW+g2m0xLaCASs5Fv5mYzMQ51F2xaSu/MnRXinIcWr9+Wy0WBiNiOjcF2r4gMIy+YkD3Oja12r2b1UYhFRt1TXnIjbPTAcNT6Q5hIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793478; c=relaxed/simple;
	bh=NIYT4QfvYd01n/hzRDene/g2+hz/kkSToCtHHHVrhr8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6lgmnJaG2CTw2c5GV5Ucp/hUrmAw81geDJrGHoJuEP0xg7DAvdzKyo6Oi4kOtkggNLars+XvDbNQAw8jWr4zm8Y4Upk47Ph0dFRuA1z+skHD/N2xzs6RbgZ7pjSrOLTcY4so8NebmlhvIR2ijiZO7/LI39x295xwB0BeSsZrQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlW9GYca; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfbaf3d88dso109164a12.3;
        Sat, 16 Nov 2024 13:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731793474; x=1732398274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PpU4WlGyZX8uepKApReCvzYDLungy4RMd2NWNGpb80k=;
        b=JlW9GYcaKT3GnqjsXyyy5QDvdAHITtBgZtW/ZQO/3S5Ke3a6fzJLwFUDyYOfGyWAhk
         ROOn4AcJKnK2ea8jdY2g2NdRf9OWHkmcDxj0zxjJs/7AhOCVh1Y6Xm1v4kqWn33D/Jfe
         EieNl0EZbT25c5lMKCO8/CqjCKesTMlNFyBVVEtDcetRMsvEpCC8Y2foPmtgkSTtRcwp
         hE5cf11b4mdUhxZoo2EXPm6k3FwEg1ByrMTRqKZBDr2Hed63rJ/QN/a4EqSIBfdlx7S8
         WAJ+BtC/wVvthHLADSnwe2TUT9g7U8MPLkC/eD1UDOEN+3UA2cxHOHBPFBm2Kvu8Iv+V
         AEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793474; x=1732398274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpU4WlGyZX8uepKApReCvzYDLungy4RMd2NWNGpb80k=;
        b=iYzeCiDzOtw7pkyaD0Q/9uFLxz8pLIy0O8DT3slR0UIVAjRm658Hz7T3ZAj3/dwMru
         BtWa8yVMS196wWGGMZUd8dOpS2I8z5VQnt1Y2PC+9xM3CUThbaPbncffl5y4vEVi5p3M
         PWXALSL0TdAoycFYID/XJ8fCmwtJohwDlSw8RGHXRot5FSQcJAByNbDioMiuUU4c7ZzJ
         3if8uLhRNNkL3Lg2UK4rXpmWigC9+e2yTOFPJHpNHLAUmqbQRjWd+z2DSqd6Hi/d62Q8
         eQvAdVQqel9/CErx6TzQYqCQVLmvLCkWuMRZ3ygM5w+EqbMMwd/fDn4LBAGty1Goa+Md
         pfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUURsOzRUGIRqCI+NCJA0Ngazfsowe08s6gDsp14RZdZFukep3B1QlYPje3V72E3A7J0zf7/o8u6KyFlly+@vger.kernel.org, AJvYcCVEQ7c5ckieFv0Tt4m844v++AOqFxBpSxEIQavgp4lTn1f9pLTM9bInBc8L72pQoGmpVDDDB4B7hmFEnEwUMSl8diQP@vger.kernel.org, AJvYcCW9KccuYgZQwhrq20eYL7GvFXZjqAHRIS1rGKmn0pdZZ8iUD4c+XShA7PS8+1o5gX2N8fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFJFiRyOYG1kVGoZCPqhpBWtyoSutafFTlpb3nF7PIKS+ByYd
	U517xhl3he9F3eZw13aSYdV0vJ8M943Io0/h7kvpRhy6WclQ4FB0
X-Google-Smtp-Source: AGHT+IHngvCITOp5ZNrF9NUE8eHaAR746esxOiBpGSR4S3Ollsu9dWGwnIDhjBYuVq2hNRAIOrYz5w==
X-Received: by 2002:a05:6402:1d56:b0:5cb:699c:30dd with SMTP id 4fb4d7f45d1cf-5cf8fd3ee94mr7674130a12.32.1731793473742;
        Sat, 16 Nov 2024 13:44:33 -0800 (PST)
Received: from krava (85-193-35-167.rib.o2.cz. [85.193.35.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfb99af32esm303612a12.75.2024.11.16.13.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 13:44:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Nov 2024 22:44:26 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <ZzkSOhQIMg_lzwiT@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-6-jolsa@kernel.org>
 <CAEf4BzYycU7_8uNgi9XrnnPSAvP7iyWwNA7cHu0aLTcAUxsBFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYycU7_8uNgi9XrnnPSAvP7iyWwNA7cHu0aLTcAUxsBFA@mail.gmail.com>

On Thu, Nov 14, 2024 at 03:44:14PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 5, 2024 at 5:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding interface to add special mapping for user space page that will be
> > used as place holder for uprobe trampoline in following changes.
> >
> > The get_tramp_area(vaddr) function either finds 'callable' page or create
> > new one.  The 'callable' means it's reachable by call instruction (from
> > vaddr argument) and is decided by each arch via new arch_uprobe_is_callable
> > function.
> >
> > The put_tramp_area function either drops refcount or destroys the special
> > mapping and all the maps are clean up when the process goes down.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h |  12 ++++
> >  kernel/events/uprobes.c | 141 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/fork.c           |   2 +
> >  3 files changed, 155 insertions(+)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index be306028ed59..222d8e82cee2 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -172,6 +172,15 @@ struct xol_area;
> >
> >  struct uprobes_state {
> >         struct xol_area         *xol_area;
> > +       struct hlist_head       tramp_head;
> > +       struct mutex            tramp_mutex;
> > +};
> > +
> > +struct tramp_area {
> > +       unsigned long           vaddr;
> > +       struct page             *page;
> > +       struct hlist_node       node;
> > +       refcount_t              ref;
> 
> nit: any reason we are unnecessarily trying to save 4 bytes on
> refcount (and we don't actually, due to padding)

hum, I'm not sure what you mean.. what's the alternative?

> 
> >  };
> >
> >  extern void __init uprobes_init(void);
> > @@ -219,6 +228,9 @@ extern int uprobe_verify_opcode(struct page *page, unsigned long vaddr, uprobe_o
> >  extern int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> >                                      uprobe_opcode_t *new_opcode, void *data);
> >  extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void *data);
> > +struct tramp_area *get_tramp_area(unsigned long vaddr);
> 
> uprobe_get_tramp_area() to make it clear this is uprobe specific,
> given this is exposed function?
> 
> and add that extern like we do for other functions?

ok

> 
> > +void put_tramp_area(struct tramp_area *area);
> 
> uprobe_put_tramp_area() ?

ok

> 
> > +bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
> >  #else /* !CONFIG_UPROBES */
> >  struct uprobes_state {
> >  };
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 944d9df1f081..a44305c559a4 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -616,6 +616,145 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
> >                         (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE, NULL);
> >  }
> >
> > +bool __weak arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
> > +{
> > +       return false;
> > +}
> > +
> > +static unsigned long find_nearest_page(unsigned long vaddr)
> > +{
> > +       struct mm_struct *mm = current->mm;
> > +       struct vm_area_struct *vma, *prev;
> > +       VMA_ITERATOR(vmi, mm, 0);
> > +
> > +       prev = vma_next(&vmi);
> > +       vma = vma_next(&vmi);
> > +       while (vma) {
> > +               if (vma->vm_start - prev->vm_end  >= PAGE_SIZE &&
> > +                   arch_uprobe_is_callable(prev->vm_end, vaddr))
> > +                       return prev->vm_end;
> 
> shouldn't we try both `prev->vm_end` and `vma->vm_start - PAGE_SIZE`
> as two possible places

right, we should do that

SNIP

> > +static struct tramp_area *create_tramp_area(unsigned long vaddr)
> > +{
> > +       struct mm_struct *mm = current->mm;
> > +       struct vm_area_struct *vma;
> > +       struct tramp_area *area;
> > +
> > +       vaddr = find_nearest_page(vaddr);
> > +       if (!vaddr)
> > +               return NULL;
> > +
> > +       area = kzalloc(sizeof(*area), GFP_KERNEL);
> > +       if (unlikely(!area))
> > +               return NULL;
> > +
> > +       area->page = alloc_page(GFP_HIGHUSER);
> > +       if (!area->page)
> > +               goto free_area;
> > +
> > +       refcount_set(&area->ref, 1);
> > +       area->vaddr = vaddr;
> > +
> > +       vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> > +                               &tramp_mapping);
> > +       if (!IS_ERR(vma))
> > +               return area;
> 
> please keep a pattern, it's less surprising that way
> 
>     if (IS_ERR(vma))
>         goto free_page;
> 
>     return area;
> 
> free_page:

ok


SNIP

> > +static void destroy_tramp_area(struct tramp_area *area)
> > +{
> > +       hlist_del(&area->node);
> > +       put_page(area->page);
> > +       kfree(area);
> > +}
> > +
> > +void put_tramp_area(struct tramp_area *area)
> > +{
> > +       struct mm_struct *mm = current->mm;
> > +       struct uprobes_state *state = &mm->uprobes_state;
> > +
> > +       if (area == NULL)
> 
> nit: !area

ok

thanks,
jirka

