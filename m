Return-Path: <bpf+bounces-45142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0FF9D1FEE
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 07:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974751F223C9
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E1715574E;
	Tue, 19 Nov 2024 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tyv8w3fE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1BE571;
	Tue, 19 Nov 2024 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996355; cv=none; b=DUfpKoYp+BgPhEuTQZMz1574YysChBYWRbtHCUm82JOzUhCnfIpYRJtLyqS+aWd0hHlrZr8Y/ZRX/6TI2gzfOkSEJUJbcFAut0kQ7T8bGRGHvlzypmhMpLbhZ8fKw6Ea77J5VOfoo9ts9Ut3IISsbZ9h1lQxjT5Jyhnj1ke3MSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996355; c=relaxed/simple;
	bh=4FKFiPTBCrJoKZb2/ShpU5ZAzBcxWkpC0UREB1ERFaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFS5xWIXObmW3ZZZE9w4ZKGXDz38GuqWJkzDN2KeG4zZXQ7XUgIk26M/rV5cpMwgAvmNAKFQjxbUhXdjZRo6zxcUO/Q5pU3fAaXeC/bq7lXOMMPUZiuKTq5IQma0NEm+oEXHaHCuEn6EFAsEZQ/eQHkDY9pyGftHEIq3OyMQiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tyv8w3fE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so2081147a12.1;
        Mon, 18 Nov 2024 22:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731996353; x=1732601153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H66xNhUBESH7QUiyBeW758pf4oz9rDIsRA8VPU6oj6U=;
        b=Tyv8w3fEahlAsXCqiDuwRffd6TCpFb4/LgwamfrHN6H96k9IcJbF+9giICiF02ue9u
         kRhFIEwr5PMUimGtEQqF6O2bQrzkJVmisiJZAryTVdG5A+bQ1J6rDkfgTzDpAARc0CmN
         FzfB02ggaj/3p13arkLFgP1hC3LcMdS77EcBLKqOY2DbgBZCsIKeWDdkM/JBYffbIR4R
         NAKc4GmtdvVUxEQY1rB4Dx4k8RIPrYqALpC8ToHXPq4xck/wb5p7uFBlGYK+IbK3F2w2
         6Fj4HVlsEqj0FF1vn8zJtZG+O7m6yCEAjiQw13IaZIg3Bn4+x3ajVY4/Tp09Jq5Nju0r
         tGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731996353; x=1732601153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H66xNhUBESH7QUiyBeW758pf4oz9rDIsRA8VPU6oj6U=;
        b=gsMRRGIsrhBPV4plqQDDf6Q/YmsQdMmQ7dviXPL7Fh7T7Dbw/gIUh6cUOF5KtZ3KrT
         yWVqwG6ZMWmW13I39SGWQckJNd8FgEcGpId+AW5q8MgQSHo5RDqhjFPYVa9TNVLbLr3A
         asrCrEb3GpvylzpVjkJ1VrbKJ6827i6CkcYnLPxWgYFnpsx0eN/PHo0G53o9xKMIgk78
         O3jr820sQmApHW4n8Ucep92Se/Fk8g+TUPd/oTsA6ZiTsF8pq1dBdaeV5IlRsnvZJPYc
         F+pTvZXMM64yV7gagRPZzhtQKa3TuLmYSoX235xVG24hWC2LIYU9etIAEoJwpfGSeUjc
         sm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGr9l8oxUky+ay8OvgJF5b2D66cYaq2nP8ajatQLgJePoMU94G0Nenp45cvCfoad/tHY+mQqu0HO1/br9P3UEIZJx8@vger.kernel.org, AJvYcCUlVnmqDwif/7V8qYNHzuAQrvzKOxI65WqNeraQNTc3OtVl7WZUa7N8emvLFD8PqqOdKxjvPPvDbkNX3vm2@vger.kernel.org, AJvYcCV3mpuL7LAJ7GJ4k+zsHFKeShtoc16smj51UO3aMJrvIOFaWlUK+IYReR0oU4lTK71LqcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgPySlycrHKPXKkohEuhzCndhKzr9TRpsCydwTY1AD9kjUOoa
	7E/F+ttI5Swnw7BrGVFbYw1ru6yCjFmmplY9IpZcQtA1csvm6PWIhN9Eka7fZqasU9LYfewl30A
	NV7d+/7cWPNkSFLW7yJU1GoOlojU=
X-Google-Smtp-Source: AGHT+IG+y6qrc+A5F8Jbk9hJ/JpZbQga9Kt4uZZLttBL3Zgx1l85/36tUNk1U4bauOZRMc+Tdl5rfA2D2TgLsnCy1tA=
X-Received: by 2002:a05:6a20:431b:b0:1db:e177:7737 with SMTP id
 adf61e73a8af0-1dc90afca42mr22805202637.8.1731996353175; Mon, 18 Nov 2024
 22:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-6-jolsa@kernel.org>
 <CAEf4BzYycU7_8uNgi9XrnnPSAvP7iyWwNA7cHu0aLTcAUxsBFA@mail.gmail.com> <ZzkSOhQIMg_lzwiT@krava>
In-Reply-To: <ZzkSOhQIMg_lzwiT@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Nov 2024 22:05:41 -0800
Message-ID: <CAEf4BzYBRtK-U_SLY-qYDGf2pc4YzBOeKgyjFbzv-EHXrdNANg@mail.gmail.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe trampolines
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 1:44=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Nov 14, 2024 at 03:44:14PM -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 5, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > Adding interface to add special mapping for user space page that will=
 be
> > > used as place holder for uprobe trampoline in following changes.
> > >
> > > The get_tramp_area(vaddr) function either finds 'callable' page or cr=
eate
> > > new one.  The 'callable' means it's reachable by call instruction (fr=
om
> > > vaddr argument) and is decided by each arch via new arch_uprobe_is_ca=
llable
> > > function.
> > >
> > > The put_tramp_area function either drops refcount or destroys the spe=
cial
> > > mapping and all the maps are clean up when the process goes down.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/uprobes.h |  12 ++++
> > >  kernel/events/uprobes.c | 141 ++++++++++++++++++++++++++++++++++++++=
++
> > >  kernel/fork.c           |   2 +
> > >  3 files changed, 155 insertions(+)
> > >
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index be306028ed59..222d8e82cee2 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -172,6 +172,15 @@ struct xol_area;
> > >
> > >  struct uprobes_state {
> > >         struct xol_area         *xol_area;
> > > +       struct hlist_head       tramp_head;
> > > +       struct mutex            tramp_mutex;
> > > +};
> > > +
> > > +struct tramp_area {
> > > +       unsigned long           vaddr;
> > > +       struct page             *page;
> > > +       struct hlist_node       node;
> > > +       refcount_t              ref;
> >
> > nit: any reason we are unnecessarily trying to save 4 bytes on
> > refcount (and we don't actually, due to padding)
>
> hum, I'm not sure what you mean.. what's the alternative?

atomic64_t ?

>
> >
> > >  };
> > >
> > >  extern void __init uprobes_init(void);
> > > @@ -219,6 +228,9 @@ extern int uprobe_verify_opcode(struct page *page=
, unsigned long vaddr, uprobe_o
> > >  extern int arch_uprobe_verify_opcode(struct page *page, unsigned lon=
g vaddr,
> > >                                      uprobe_opcode_t *new_opcode, voi=
d *data);
> > >  extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, =
void *data);
> > > +struct tramp_area *get_tramp_area(unsigned long vaddr);
> >
> > uprobe_get_tramp_area() to make it clear this is uprobe specific,
> > given this is exposed function?
> >
> > and add that extern like we do for other functions?
>
> ok
>
> >
> > > +void put_tramp_area(struct tramp_area *area);
> >
> > uprobe_put_tramp_area() ?
>
> ok
>
> >
> > > +bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vad=
dr);
> > >  #else /* !CONFIG_UPROBES */
> > >  struct uprobes_state {
> > >  };
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 944d9df1f081..a44305c559a4 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -616,6 +616,145 @@ set_orig_insn(struct arch_uprobe *auprobe, stru=
ct mm_struct *mm, unsigned long v
> > >                         (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWB=
P_INSN_SIZE, NULL);
> > >  }
> > >
> > > +bool __weak arch_uprobe_is_callable(unsigned long vtramp, unsigned l=
ong vaddr)
> > > +{
> > > +       return false;
> > > +}
> > > +
> > > +static unsigned long find_nearest_page(unsigned long vaddr)
> > > +{
> > > +       struct mm_struct *mm =3D current->mm;
> > > +       struct vm_area_struct *vma, *prev;
> > > +       VMA_ITERATOR(vmi, mm, 0);
> > > +
> > > +       prev =3D vma_next(&vmi);
> > > +       vma =3D vma_next(&vmi);
> > > +       while (vma) {
> > > +               if (vma->vm_start - prev->vm_end  >=3D PAGE_SIZE &&
> > > +                   arch_uprobe_is_callable(prev->vm_end, vaddr))
> > > +                       return prev->vm_end;
> >
> > shouldn't we try both `prev->vm_end` and `vma->vm_start - PAGE_SIZE`
> > as two possible places
>
> right, we should do that
>
> SNIP
>
> > > +static struct tramp_area *create_tramp_area(unsigned long vaddr)
> > > +{
> > > +       struct mm_struct *mm =3D current->mm;
> > > +       struct vm_area_struct *vma;
> > > +       struct tramp_area *area;
> > > +
> > > +       vaddr =3D find_nearest_page(vaddr);
> > > +       if (!vaddr)
> > > +               return NULL;
> > > +
> > > +       area =3D kzalloc(sizeof(*area), GFP_KERNEL);
> > > +       if (unlikely(!area))
> > > +               return NULL;
> > > +
> > > +       area->page =3D alloc_page(GFP_HIGHUSER);
> > > +       if (!area->page)
> > > +               goto free_area;
> > > +
> > > +       refcount_set(&area->ref, 1);
> > > +       area->vaddr =3D vaddr;
> > > +
> > > +       vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > > +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD=
|VM_DONTCOPY|VM_IO,
> > > +                               &tramp_mapping);
> > > +       if (!IS_ERR(vma))
> > > +               return area;
> >
> > please keep a pattern, it's less surprising that way
> >
> >     if (IS_ERR(vma))
> >         goto free_page;
> >
> >     return area;
> >
> > free_page:
>
> ok
>
>
> SNIP
>
> > > +static void destroy_tramp_area(struct tramp_area *area)
> > > +{
> > > +       hlist_del(&area->node);
> > > +       put_page(area->page);
> > > +       kfree(area);
> > > +}
> > > +
> > > +void put_tramp_area(struct tramp_area *area)
> > > +{
> > > +       struct mm_struct *mm =3D current->mm;
> > > +       struct uprobes_state *state =3D &mm->uprobes_state;
> > > +
> > > +       if (area =3D=3D NULL)
> >
> > nit: !area
>
> ok
>
> thanks,
> jirka

