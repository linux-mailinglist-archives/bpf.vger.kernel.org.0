Return-Path: <bpf+bounces-46908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B939F1838
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B34167E72
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA681953A1;
	Fri, 13 Dec 2024 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSZv+Ccp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44937193086;
	Fri, 13 Dec 2024 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127116; cv=none; b=jK/gb932uxy/EFKKCIyun6oyE4WBmbSpMJYTqzZBRdtGlqRDE99aMi7RezAYUgo6VXQSVheqMJIyTsAXmZ3WVns7EXjdN63LF7jQXLeuQgcPageIQSIPZsEU+ZVMs4+wKUc/uK/rf5PJWuBIm7fRCqZLcztd9COvW0amvFfGrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127116; c=relaxed/simple;
	bh=ftjOLyece6c7d8H/bCxnY2QILxIoaDaXcQcJpLY/mkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FA+iOMFUkS+v5t6CXvXdGo6RspnDf3RG9QpCGRWM2u/4YI5r+XDyO/Jy6OVxKu6ENi5Jn54eJk4egQaay6fXSw5Qfs9Dhugnq/lYBY3ztfNoR3UAArrmEhx7Ms9gclNieTWSQXlAk5qwH5Nb6cqlLloCVsggI7/7L+hRnCfkEsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSZv+Ccp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728d1a2f180so1750539b3a.1;
        Fri, 13 Dec 2024 13:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734127114; x=1734731914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXzAt05WpHX8Qz6j5N/Uvrvi5wlKH5mpfIsiZnrQUdk=;
        b=dSZv+Ccp2SzLVuUDaPDU7ctTqXoZrLqWeche104nQAeZi6LwE41zvfcJje/OgsXP/Y
         GHATPWEI+OKvSmNGr0SLBOznai2gtu7QlGLXu3KCwKruFoVDkum7/KvUvDQ3VNpND8Ax
         FL4aWwrZGB6i8LL65JblyNWUY5Lktyr6YFxkg+8QRM8kvWSBBSBhR81afVP76nfagzmj
         Xg8AjP9gPqbDj+DelzrJfpMUevKVFkvSbEB2uvUHqG9ynUjaNXB0gh1boRJD9cnpfI9w
         DmBp3vgSeiwMZgfqYd8j1Aor/a45GvuHeIvFPJuMNBZqqH+eobKKmrIOSf9C4kr6YaKJ
         8e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734127114; x=1734731914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXzAt05WpHX8Qz6j5N/Uvrvi5wlKH5mpfIsiZnrQUdk=;
        b=Iwfse66eMT24O1z69Bk4zzH3gTMg7H9bt0sC09kZS0qSo7QGA7xUK9wRV4QsDf68T1
         2VyhXC+wATXIs6bjeBG5W1C7i7MCBl/Jd9a87hzugjAJeKqkd5S6UWiNjhLA72LzkhS/
         N/WUBejTGbSkNRUAY4DQLDpexTwSc1M4jJ2bCsMStw7alDG/1cGbP9jLzFx1IB6bgZko
         2hS/lsTJss4Ki05BMa8sd6hzCQQTawwq5YZU0lVz0pA8SXj0roRWkPOh6cbSyzr14lyV
         SMFzM4LHYyNofNSsYF30oZsQDsX9HWryW5NEgHreThXbCLgs1kERDC0E/yd8dORgN3dU
         ZXYw==
X-Forwarded-Encrypted: i=1; AJvYcCW/NlAWjlqDXvSYX3mpYIf8dKJcFtTVLzz6g54YbWMyOajyqbAUCNWjn1iDG2qf9kfhGtWeMdvlBMf248ym5SXWlL//@vger.kernel.org, AJvYcCXtyRHMgHK/n08i9v/gsCr6mYRVK4gxWLbeUSU3Rd/zZ19vpnrH1p3Oi6Ck5CIKVSZg0yokI10cL91aB1ce@vger.kernel.org, AJvYcCXwQ/LcdlHx4HpApuMXx5WZHv7dWJZZ0uIaRbVvFfqDd+t3Fhg7vc9kHSkM14fBPCVhJj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNggj0L6cv7IhG7uMdU8PGTzzIgHF3nOUaEnAVGVxGm48i796i
	A4T+04FfzK8GoyUS4JGqhb06yKd0ISJrx2HcGtlmHTYy47MFQdXVHGfvHLNVvzGCVLs64aFjOOO
	Lq7ZvKoVCzuCxaT9+9gLxhMYsdgfi1Q==
X-Gm-Gg: ASbGncv8Et2DjUAADT8Wq9tVsN6utGESuCykUvr+JpgHr0UsFYjk3SRAi6ybU+Xw9jM
	kcqJf40EnJogX0miRyUNVsttin8mTkyEpDnlfA6FDJzieIzXdLbR7iw==
X-Google-Smtp-Source: AGHT+IF8v0iJKJKtXCV3xpncg+Tce0/ExBJK4tnC86EomIWeZB0DcBoMHxAkJBs6VqGBmT35DMJ0rCFS0YBM+o/Ca3c=
X-Received: by 2002:a05:6a00:174b:b0:725:f3fa:8c6e with SMTP id
 d2e1a72fcca58-7290c56ce6bmr6138168b3a.7.1734127114462; Fri, 13 Dec 2024
 13:58:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-6-jolsa@kernel.org>
 <CAEf4BzZEPdGxjHjPGr-4qKFju+roOiAVrMhTuviozmcP1-qojw@mail.gmail.com> <Z1w5qXERTJV9hQ9p@krava>
In-Reply-To: <Z1w5qXERTJV9hQ9p@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 13:58:20 -0800
Message-ID: <CAEf4Bzb1AFR4PN-UG_64OXLL+AGiiVwoq6aO2UPAppgC9gCG-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/13] uprobes: Add mapping for optimized uprobe trampolines
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:42=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Dec 12, 2024 at 05:01:52PM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > > ---
> > >  include/linux/uprobes.h |  12 +++++
> > >  kernel/events/uprobes.c | 114 ++++++++++++++++++++++++++++++++++++++=
++
> > >  kernel/fork.c           |   1 +
> > >  3 files changed, 127 insertions(+)
> > >
> >
> > Ran out of time for today, will continue tomorrow for the rest of
> > patches. Some comments below.
>
> thanks!
>
> >
> > The numbers are really encouraging, though!
> >
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index 8843b7f99ed0..c4ee755ca2a1 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/types.h>
> > >  #include <linux/wait.h>
> > >  #include <linux/timer.h>
> > > +#include <linux/mutex.h>
> > >
> > >  struct uprobe;
> > >  struct vm_area_struct;
> > > @@ -172,6 +173,13 @@ struct xol_area;
> > >
> > >  struct uprobes_state {
> > >         struct xol_area         *xol_area;
> > > +       struct hlist_head       tramp_head;
> > > +};
> > > +
> >
> > should we make uprobe_state be linked by a pointer from mm_struct
> > instead of increasing mm for each added field? right now it's
> > embedded, I don't think it's problematic to allocate it on demand and
> > keep it until mm_struct is freed
>
> seems like good idea, I'll check on that
>
> >
> > > +struct uprobe_trampoline {
> > > +       struct hlist_node       node;
> > > +       unsigned long           vaddr;
> > > +       atomic64_t              ref;
> > >  };
> > >
> > >  extern void __init uprobes_init(void);
> > > @@ -220,6 +228,10 @@ extern int arch_uprobe_verify_opcode(struct arch=
_uprobe *auprobe, struct page *p
> > >                                      unsigned long vaddr, uprobe_opco=
de_t *new_opcode,
> > >                                      int nbytes);
> > >  extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbyte=
s);
> > > +extern struct uprobe_trampoline *uprobe_trampoline_get(unsigned long=
 vaddr);
> > > +extern void uprobe_trampoline_put(struct uprobe_trampoline *area);
> > > +extern bool arch_uprobe_is_callable(unsigned long vtramp, unsigned l=
ong vaddr);
> > > +extern const struct vm_special_mapping *arch_uprobe_trampoline_mappi=
ng(void);
> > >  #else /* !CONFIG_UPROBES */
> > >  struct uprobes_state {
> > >  };
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 8068f91de9e3..f57918c624da 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -615,6 +615,118 @@ set_orig_insn(struct arch_uprobe *auprobe, stru=
ct mm_struct *mm, unsigned long v
> > >                         (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWB=
P_INSN_SIZE);
> > >  }
> > >
> > > +bool __weak arch_uprobe_is_callable(unsigned long vtramp, unsigned l=
ong vaddr)
> >
> > bikeshedding some more, I still find "is_callable" confusing. How
> > about "is_reachable_by_call"? slightly verbose, but probably more
> > meaningful?
>
> yep, more precise, will change
>
> >
> > > +{
> > > +       return false;
> > > +}
> > > +
> > > +const struct vm_special_mapping * __weak arch_uprobe_trampoline_mapp=
ing(void)
> > > +{
> > > +       return NULL;
> > > +}
> > > +
> > > +static unsigned long find_nearest_page(unsigned long vaddr)
> > > +{
> > > +       struct mm_struct *mm =3D current->mm;
> > > +       struct vm_area_struct *vma, *prev;
> > > +       VMA_ITERATOR(vmi, mm, 0);
> > > +
> > > +       prev =3D vma_next(&vmi);
> >
> > minor: we are missing an opportunity to add something between
> > [PAGE_SIZE, <first_vma_start>). Probably fine, but why not?
>
> true, will add that check
>
> >
> > > +       vma =3D vma_next(&vmi);
> > > +       while (vma) {
> > > +               if (vma->vm_start - prev->vm_end  >=3D PAGE_SIZE) {
> > > +                       if (arch_uprobe_is_callable(prev->vm_end, vad=
dr))
> > > +                               return prev->vm_end;
> > > +                       if (arch_uprobe_is_callable(vma->vm_start - P=
AGE_SIZE, vaddr))
> > > +                               return vma->vm_start - PAGE_SIZE;
> > > +               }
> > > +
> > > +               prev =3D vma;
> > > +               vma =3D vma_next(&vmi);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> >
> > [...]
> >
> > > +struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
> > > +{
> > > +       struct uprobes_state *state =3D &current->mm->uprobes_state;
> > > +       struct uprobe_trampoline *tramp =3D NULL;
> > > +
> > > +       hlist_for_each_entry(tramp, &state->tramp_head, node) {
> > > +               if (arch_uprobe_is_callable(tramp->vaddr, vaddr)) {
> > > +                       atomic64_inc(&tramp->ref);
> > > +                       return tramp;
> > > +               }
> > > +       }
> > > +
> > > +       tramp =3D create_uprobe_trampoline(vaddr);
> > > +       if (!tramp)
> > > +               return NULL;
> > > +
> > > +       hlist_add_head(&tramp->node, &state->tramp_head);
> > > +       return tramp;
> > > +}
> > > +
> > > +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tram=
p)
> > > +{
> > > +       hlist_del(&tramp->node);
> > > +       kfree(tramp);
> >
> > hmm... shouldn't this be RCU-delayed (RCU Tasks Trace for uprobes),
> > otherwise we might have some CPU executing code in that trampoline,
> > no?
>
> so we call destroy_uprobe_trampoline in 2 scenarios:
>
>   - from uprobe_trampoline_put (in __arch_uprobe_optimize) when we failed
>     to optimize the uprobe, so no task can execute it at that point
>
>   - from clear_tramp_head as part of the uprobe trampolines cleanup
>     (__mmput -> uprobe_clear_state) at which point the task should be dea=
d

makes sense, I've been overcautious

>
> jirka
>
> >
> > > +}
> > > +
> >
> > [...]

