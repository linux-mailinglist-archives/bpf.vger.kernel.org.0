Return-Path: <bpf+bounces-56621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFBCA9B360
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF11A7A6AFA
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05D27FD51;
	Thu, 24 Apr 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDZwJHF/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC427A926;
	Thu, 24 Apr 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510789; cv=none; b=R+7vNNtdIiaRVIVdWGmfn4oYfenHzO4hPgZT5NENgUNb6as3FxrWNHnjer5afHLtXFQqHfmxt+YbURB0ZEWNS9RgG0jV/bQ0mnklNdBDO9LEV6TPGuuYWNlfqOW3vHdtnBaionIcLmljYHPKJ5ber6m5pQUQSPqxx/L1uWn77J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510789; c=relaxed/simple;
	bh=axC1Drsdf6J/ulltERHu0PyDLxHJYOxdK7BsvDX195A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2YYXUgFEScxgUENCIhBGvhxZP6iTKUjopsyX+db8QOs1jWMfgXb7Ccm+zVJerYaNNHySvRTkXFMqiaANt2Gzw88Go9ClvQ/YwPovHQ4TSkClY2AXprYcfmPN0Hzo9b2SzhX8upYS0GrGqruq/IHhb5aU8+qHS+ib+HT4JnhV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDZwJHF/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7398d65476eso1021657b3a.1;
        Thu, 24 Apr 2025 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745510787; x=1746115587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOia9kBWQgn3uL8bpE/5viJ+HAfruuVuzNZxkiZ9nvY=;
        b=HDZwJHF/mtetSsxChQ3i5lUaC5XfXatVx7vUpTjELwvM+wn6B5aqx06WSQNlp8bt4t
         +ysxftBkJIlzHUWWyf0F703PJ6M++L5gNCHCQAWUYsPpmmGsDeV0JnIEBKBSDbs7mfGs
         a6xh65rSF2UlthecoFHrK1McwxO5Pz5dHyO5Zw5hnrPFZ8RY2jFoGsgJxJJ+a5gSH/4C
         tyYGUMYiAVdYcTeWy1NFallcG1j6kPJkGaQtY+RAJsVoWFxS3QClsrb69yS01rtfOEId
         2Cz4aoyYKPin+uqNFxTitEZEop5TMRlux7PNflcBd65hccXjsnp7sJZyJLYWtQSsXSEX
         1GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745510787; x=1746115587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOia9kBWQgn3uL8bpE/5viJ+HAfruuVuzNZxkiZ9nvY=;
        b=lRko7eEXJNWpXzgVmhQERyMoEdsSfKAI9MUjWn95B/JtjeSTMLAagrO+a8HrFDBD8O
         4GhnkNa2JhbJC4rkZcZgw9Kqaun9EoGr1dMI6UYE9BF5T4YOEMl/V3B3fBcA7Z9Ix0Qa
         IBR4JdDzzv02ww6Ag8EF/EqwTUWc4kaWJt81JuAdlXScIXTacI9hu0AdpTrZuOwqdnMT
         MHniKxXjJbUCA2OpAwzmhlvij3ESJiH/jMY+imIXRSIGoqjx6Tdbp/8OgvUrxsKQ9IeO
         YrN5HxkDFE991fsb337XRspOAEPrY7kRS0wd1m2RUi1trNmlgr5Ym/mK102bMEBpJqGz
         zo2g==
X-Forwarded-Encrypted: i=1; AJvYcCX8YP9EigIpMR41jpa5F1pjta/8s6oVOZeHbsrngo/fgAdMbxETizScNpZnU5ZiZrDOwTwK/0mjlgqlV+NI@vger.kernel.org, AJvYcCXgZHpfcNwD3oL9xJS2AQn+l+Zl075AOlw7+O0FqFgv/gtoCrfom85kKsUt4UGWIx+J7ukWc4ymBE62ZZFp/F15xR+t@vger.kernel.org, AJvYcCXyg10x4kTOtcCvafrkboOkd9aNQcshsCaBmqN43uKBGCMLYRt/QsxGaI/R9hrJ5W8HyvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28AOalVUPCPFHOd/gUuW+LY/URmSQVgGD5zpnL/oUwkbesvwS
	L3X6GoTNbO9por20Lis5hX/SJTlhbA5XNzDRmKgp2DuPHFHClSYLZs3nyyuqU/h3DKUxF2O8nho
	UszJBL84czAfUltwD7JUZ+vmTVIM=
X-Gm-Gg: ASbGnctv6fvXAhOUSPqa5DpZUNnNPgA/lIf4J9NR1J3OTcmhZ6D0Q9FADYT4FtzPWdy
	0vBYHT7f0BC3DDzhVoT6AitFfzO+V+9/eGP1PIE87RF377RFeaoOc4I43p+FI0aEzn+ZUYQxBQI
	o27H8OLYYRr+ipDb+ovn8zK98JikAYyD9jyH4bNw==
X-Google-Smtp-Source: AGHT+IHGR37EkkIQxFfsBPhwH7utQC1kdcjQdTTcQP1nKCAJZROgLM1/WKVjGNjYPqtRd2aD6oXvNQQkZPEV3ifFvy8=
X-Received: by 2002:a05:6a00:6f26:b0:736:bced:f4cf with SMTP id
 d2e1a72fcca58-73e2661a103mr4376993b3a.0.1745510786669; Thu, 24 Apr 2025
 09:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-11-jolsa@kernel.org>
 <CAEf4BzbJJuKY+eTaDvwhgmp9jBqYXoLWinBY8vK0oYh0irC07Q@mail.gmail.com> <aAozSky7pIIGIB4s@krava>
In-Reply-To: <aAozSky7pIIGIB4s@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Apr 2025 09:06:14 -0700
X-Gm-Features: ATxdqUF_G37AKhAjZlbvpmyy_G5E0q7k3jFMDWPUt73VVWEZQQyUXYRq3uUihX0
Message-ID: <CAEf4Bzak2rmSXQyTynRu3XPBemqbEmaxdUAFOQ-F5XRfZ7yOLg@mail.gmail.com>
Subject: Re: [PATCH perf/core 10/22] uprobes/x86: Add support to optimize uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 5:49=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Apr 22, 2025 at 05:04:03PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > >  arch/x86/include/asm/uprobes.h |   7 +
> > >  arch/x86/kernel/uprobes.c      | 281 +++++++++++++++++++++++++++++++=
+-
> > >  include/linux/uprobes.h        |   6 +-
> > >  kernel/events/uprobes.c        |  15 +-
> > >  4 files changed, 301 insertions(+), 8 deletions(-)
> > >
> >
> > just minor nits, LGTM
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > +int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma=
,
> > > +            unsigned long vaddr)
> > > +{
> > > +       if (should_optimize(auprobe)) {
> > > +               bool optimized =3D false;
> > > +               int err;
> > > +
> > > +               /*
> > > +                * We could race with another thread that already opt=
imized the probe,
> > > +                * so let's not overwrite it with int3 again in this =
case.
> > > +                */
> > > +               err =3D is_optimized(vma->vm_mm, vaddr, &optimized);
> > > +               if (err || optimized)
> > > +                       return err;
> >
> > IMO, this is a bit too clever, I'd go with plain
> >
> > if (err)
> >     return err;
> > if (optimized)
> >     return 0; /* we are done */
> >
>
> ok
>
> > (and mirror set_orig_insn() structure, consistently)
>
> set_orig_insn does that already, right?
>

right, and that was my point

> >
> >
> > > +       }
> > > +       return uprobe_write_opcode(vma, vaddr, UPROBE_SWBP_INSN, true=
);
> > > +}
> > > +
> > > +int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct=
 *vma,
> > > +                 unsigned long vaddr)
> > > +{
> > > +       if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))=
 {
> > > +               struct mm_struct *mm =3D vma->vm_mm;
> > > +               bool optimized =3D false;
> > > +               int err;
> > > +
> > > +               err =3D is_optimized(mm, vaddr, &optimized);
> > > +               if (err)
> > > +                       return err;
> > > +               if (optimized)
> > > +                       WARN_ON_ONCE(swbp_unoptimize(auprobe, vma, va=
ddr));
> > > +       }
> > > +       return uprobe_write_opcode(vma, vaddr, *(uprobe_opcode_t *)&a=
uprobe->insn, false);
> > > +}
> > > +
> > > +static int __arch_uprobe_optimize(struct mm_struct *mm, unsigned lon=
g vaddr)
> > > +{
> > > +       struct uprobe_trampoline *tramp;
> > > +       struct vm_area_struct *vma;
> > > +       int err =3D 0;
> > > +
> > > +       vma =3D find_vma(mm, vaddr);
> > > +       if (!vma)
> > > +               return -1;
> >
> > this is EPERM, will be confusing to debug... why not -EINVAL?
> >
> > > +       tramp =3D uprobe_trampoline_get(vaddr);
> > > +       if (!tramp)
> > > +               return -1;
> >
> > ditto
>
> so the error value is not exposed to user space in this case,
> we try to optimize in the first hit with:
>
>         handle_swbp()
>         {
>                 arch_uprobe_optimize()
>                 {
>
>                         if (__arch_uprobe_optimize(mm, vaddr))
>                                 set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &=
auprobe->flags);
>
>                 }
>         }
>
> and set ARCH_UPROBE_FLAG_OPTIMIZE_FAIL flags bit in case of error,
> plus there's WARN for swbp_optimize which should pass in case we
> get that far

yeah, I know, but I don't think we should deviate from kernel-wide
-Exxx convention for returning errors from functions just because this
error doesn't make it all the way to user space

>
> thanks,
> jirka
>
> >
> > > +       err =3D swbp_optimize(vma, vaddr, tramp->vaddr);
> > > +       if (WARN_ON_ONCE(err))
> > > +               uprobe_trampoline_put(tramp);
> > > +       return err;
> > > +}
> > > +
> >
> > [...]

