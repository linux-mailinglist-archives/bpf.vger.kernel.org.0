Return-Path: <bpf+bounces-33791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEEB92680B
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124F8282FBC
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB6A186E33;
	Wed,  3 Jul 2024 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INg9IcEC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6E186E53;
	Wed,  3 Jul 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031046; cv=none; b=hSaksOVL1aHL/FYQcjxIhawGLObtUtytXyyPUroOIqH6FmJt6CEUzPzgqemA+E4bIyQOIimoZIzw6cMWTDNGPzziIYj2ce1Jc0z5qaI/+zgqpeJ5CJDlzJXaOmhYsO+sC67O9xs2ilHG+OF4NhDk3+GN5Ijrqtq2PyUuwpyalz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031046; c=relaxed/simple;
	bh=u/ugDJOkjejucPFIYaUEwjHaw2/c65rOdVkescpjCqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4eLltLrvcCstaSqulF8CTtotHwFQVQPiCT2Be2uY3jIl+DddiozikTLR3Pr4lEnD1D6xvs6u6OlqdSaIK+RAom5treM11estChnBZ3/p9Ug5HJDLUp6zIEkm3+//em34XIeTtNrK40DcZ+PGE/mJojh68huO0xoIsN+2cvlwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INg9IcEC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-706524adf91so4625058b3a.2;
        Wed, 03 Jul 2024 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720031044; x=1720635844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oQMkaAY1TlPRk/2htztcbgjkXW6Rg/eN6cRQoGk7o0=;
        b=INg9IcEClW1Af/eQ3IZApUQKM1/SqnF8sQ5vPMTeXyZE0UKrdYFAaKrVy4j49BOVAd
         L8qekJ+LVG0G2x6UfToJGAPPnYfmzmPin8OqDLGJcbrKuhDNPxTi6O8OtpdOCZbjf2r1
         P1/Jaw/VazFoRUKfToJOhrdc3Hy6I/lzWj6KX4qW0drtiRn/QXh5R4UU1QMR5VU9BPM4
         0JJSOR9xCuPkRGnImHl0SJr7T9jhrUs6SUtAKIYbq5ElliEysXY80Hw2mkR+wCM51qzG
         sPAR9CZTyvSXwQofiJcRt5OITr+oKJqGwE4NGxDKP/Wv6cDKHOfEcKtBMdm5O2WDlzhe
         bKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720031044; x=1720635844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oQMkaAY1TlPRk/2htztcbgjkXW6Rg/eN6cRQoGk7o0=;
        b=Ts4/0D/nOSH8D6oXHXd72tL2wjeRSa8oGj/BHKsZMzYjy7HMUaloL2xwy9S9pNlcWx
         /EPohE4SDOEE8iaaCSIMYMtae5VJmvV52BKkrmVHeUo7sLIW8e/LwUSO/nOwErb2l3YL
         3dfYwOMEFaRQspRJ8JAtkBwWzaLSgOx+D6WEHBYAuuspuMkWMAOCt4yb7b2ObJ3czbKr
         C9EJH/YBzbZ5SV10oqqTo00nKyyTKhmNtr6eidd7MZXmf6EY8fytVwAd2KtLQQ5IU1nf
         IowgLt1EbmJkm6tc83HF0/vtgcYaivMWTURTka1UCuQ+EqJBiidVh5ijm4ZySQzzpIX7
         fVlw==
X-Forwarded-Encrypted: i=1; AJvYcCVj97SA/k0/48YAgvTGHJxDrRJkm1nhUavHFTMzGtTk65Cj/M7WccgTToe++CgDsedRBLg6AedQotheeAHfSKDVmCi1w5rtp4wcfxNbRrEY5oqaVf+0mWinCpKje4WcJVK4aI+CMoQL
X-Gm-Message-State: AOJu0YzEg7dvWfvdefDU9Knyj+Qe6znxs4P7/sLowKZbK6ziDV/5I8s5
	RK3FDQ9ZK0YAx6r02tGaRFjCa9Gyiq4IjKzk0sNL9Vbc5/ITpFcheDys4MdhLMIXAMOBuEHHdju
	+9u3FPfME9S6ONVnQo7sMWHxwroY=
X-Google-Smtp-Source: AGHT+IHhoS8m+nx7VngLaWJ8frtiBXOY8AvVfp360SFHtnMNzhE4Q6rY0XLa29y39U79IwZ2hxaToav182N1MhA4B7M=
X-Received: by 2002:a05:6a00:4f8b:b0:705:a600:31da with SMTP id
 d2e1a72fcca58-70aaaed30a2mr15112245b3a.23.1720031044426; Wed, 03 Jul 2024
 11:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-6-andrii@kernel.org>
 <20240703081315.GN11386@noisy.programming.kicks-ass.net> <20240703191330.0f2c26f574eaef6d7831c18b@gmail.com>
In-Reply-To: <20240703191330.0f2c26f574eaef6d7831c18b@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 11:23:52 -0700
Message-ID: <CAEf4BzZnzAw8iFAO_ihz9GJwt+2Ymsy8_+73TpcXGkDta+K4fg@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] uprobes: move offset and ref_ctr_offset into uprobe_consumer
To: Masami Hiramatsu <masami.hiramatsu@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	oleg@redhat.com, mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 3:13=E2=80=AFAM Masami Hiramatsu
<masami.hiramatsu@gmail.com> wrote:
>
> On Wed, 3 Jul 2024 10:13:15 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Mon, Jul 01, 2024 at 03:39:28PM -0700, Andrii Nakryiko wrote:
> > > Simplify uprobe registration/unregistration interfaces by making offs=
et
> > > and ref_ctr_offset part of uprobe_consumer "interface". In practice, =
all
> > > existing users already store these fields somewhere in uprobe_consume=
r's
> > > containing structure, so this doesn't pose any problem. We just move
> > > some fields around.
> > >
> > > On the other hand, this simplifies uprobe_register() and
> > > uprobe_unregister() API by having only struct uprobe_consumer as one
> > > thing representing attachment/detachment entity. This makes batched
> > > versions of uprobe_register() and uprobe_unregister() simpler.
> > >
> > > This also makes uprobe_register_refctr() unnecessary, so remove it an=
d
> > > simplify consumers.
> > >
> > > No functional changes intended.
> > >
> > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/uprobes.h                       | 18 +++----
> > >  kernel/events/uprobes.c                       | 19 ++-----
> > >  kernel/trace/bpf_trace.c                      | 21 +++-----
> > >  kernel/trace/trace_uprobe.c                   | 53 ++++++++---------=
--
> > >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 22 ++++----
> > >  5 files changed, 55 insertions(+), 78 deletions(-)
> > >
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index b503fafb7fb3..a75ba37ce3c8 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -42,6 +42,11 @@ struct uprobe_consumer {
> > >                             enum uprobe_filter_ctx ctx,
> > >                             struct mm_struct *mm);
> > >
> > > +   /* associated file offset of this probe */
> > > +   loff_t offset;
> > > +   /* associated refctr file offset of this probe, or zero */
> > > +   loff_t ref_ctr_offset;
> > > +   /* for internal uprobe infra use, consumers shouldn't touch field=
s below */
> > >     struct uprobe_consumer *next;
> > >  };
> > >
> > > @@ -110,10 +115,9 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
> > >  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
> > >  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> > >  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct m=
m_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> > > -extern int uprobe_register(struct inode *inode, loff_t offset, struc=
t uprobe_consumer *uc);
> > > -extern int uprobe_register_refctr(struct inode *inode, loff_t offset=
, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> > > +extern int uprobe_register(struct inode *inode, struct uprobe_consum=
er *uc);
> > >  extern int uprobe_apply(struct inode *inode, loff_t offset, struct u=
probe_consumer *uc, bool);
> > > -extern void uprobe_unregister(struct inode *inode, loff_t offset, st=
ruct uprobe_consumer *uc);
> > > +extern void uprobe_unregister(struct inode *inode, struct uprobe_con=
sumer *uc);
> >
> > It seems very weird and unnatural to split inode and offset like this.
> > The whole offset thing only makes sense within the context of an inode.
>
> Hm, so would you mean we should have inode inside the uprobe_consumer?
> If so, I think it is reasonable.
>

I don't think so, for at least two reasons.

1) We will be wasting 8 bytes per consumer saving exactly the same
inode pointer for no good reason, while uprobe itself already stores
this inode. One can argue that having offset and ref_ctr_offset inside
uprobe_consumer is wasteful, in principle, and I agree. But all
existing users already store them in the same struct that contains
uprobe_consumer, so we are not regressing anything, while making the
interface simpler. We can always optimize that further, if necessary,
but right now that would give us nothing.

But moving inode into uprobe_consumer will regress memory usage.

2) In the context of batched APIs, offset and ref_ctr_offset varies
with each uprobe_consumer, while inode is explicitly the same for all
consumers in that batch. This API makes it very clear.

Technically, we can remove inode completely from *uprobe_unregister*,
because we now can access it from uprobe_consumer->uprobe->inode, but
it still feels right for symmetry and explicitly making a point that
callers should ensure that inode is kept alive.


> Thank you,
>
> >
> > So yeah, lets not do this.
>
>
> --
> Masami Hiramatsu

