Return-Path: <bpf+bounces-36412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C59482C7
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 22:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFD02837FB
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 20:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1D16BE06;
	Mon,  5 Aug 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI9UzQOG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE71DFF7;
	Mon,  5 Aug 2024 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888108; cv=none; b=doaRusjMmUJZ1P6oIXPNNpi+aS1SpzzkC/6WoGjUXpcvX3JSoj5lcKHvhjprj2Rj/7CbO2OacT0VFO0dOIzMTIhtMOc/ed4CEXpEylQzjh9eUhj7Z4eH+qlgKBgPqQ9y/ejeeRIHbix4Vx4eGhVfEiO1pOYy/2B2dAzrJDS0cDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888108; c=relaxed/simple;
	bh=otVCQOKvV/5nqUEhS8HgGXaV+fDxdHkNMHORoD4ZlJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1C4x+uLh1Ih3+V17lONhm9EX/J+noOdMLvIuwoKqLpIQOLjQx0T76OExHbZmOJLOJWlgA6WWDxW2DqI79CcBgTpdXx9fkW23FXBSv5qqOozQDlGWEXYYRbryozAvXsAWMSbff6+3Q0b5XmN2ZwWWLnmWArLGCsdn2/0bOU0Kns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI9UzQOG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cf78366187so7712603a91.3;
        Mon, 05 Aug 2024 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722888106; x=1723492906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mOHNfXvdN3GMWTEPdB5xSVFxudx+LI1nOP2dCz9qsM=;
        b=gI9UzQOGHfxaGi/Tc9dvtf9trdAZtk1KYpW7vgotvL/QiOe/omZHEvfyFuOHmNIWP+
         1bZLj8GlklI0+uEt1PhkxApUswp12aWZL58kERkPUmE9mKU7Ia3YcvKt4CO/1jrgth83
         05TmR7j+Fiz3mUBdAEuz93PNRT69Dk28QVF1a7YwycykVuotRLIzi0CHHRHlCOh+q8x6
         unVAnO3sGors9wS+ZQkBbYPsFfhh1C75Az5hHlb4yzL54crX9ZhtXZVG/UYEfw54wcrv
         d0SOKbhEGwZnMYUESOPtnhQ5QvJmcuD4Hmb5DeRrnE+YcmA7rnC7MiotoOhZpJ19vjvL
         FKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722888106; x=1723492906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mOHNfXvdN3GMWTEPdB5xSVFxudx+LI1nOP2dCz9qsM=;
        b=EJ/dreWQmmnCcqrhkfJGiRfsk/FdbTlhnTAZDCoufkoRjweTtsIE6BsNCDMWx1QmZx
         A0lFQFUjs701rdbWH/jkJF9st6CtOV1szKEje9dGqf0wadlUe5uEfSL59wXApFAkwZZB
         BEesfwqpg1o00IeGTjtnVICsPN4ZYd7cU4tKl+mBsnivpmyKSt/7XjJJR+dOWZe45UQY
         +7czKA41nx2+iYG2N5+9oAOqC+Wp0TY23pfesFtgbFnCu5Y01REyj3fnacCdJoFqyrZT
         A0w2VQp//ejFxvwMCjVIe15hc4QWY7gy+J7mHzBZNb3yybdM2lYRm9/ONWK2QsB0vxC3
         Cybg==
X-Forwarded-Encrypted: i=1; AJvYcCVRQ32/PLmRv+JXz9ZuSE1lnESDH24pFExt77TcR/kgPCPrPm78W4ArowMzZ/oOMgEzHFG10+kO5c9iAg1VHAFT2AM/RCW0FSPSdJV7DUm07XdSoqDAaruFc7lsmK12cNEWdiOMIF4CIL2YgMDok63g8TVlSjJ5E7282FHx7ISGb+VeW7xA
X-Gm-Message-State: AOJu0Yx9pyjjKbNbai4+lMtjn4hmBARGMvZIkEDBSMyXSC4sR0d+6LcB
	Kz1yYnYhOGev3UidfUZAEkPAahderyogbQ7iwQi5MzydEIbgwe0tWZvPHSGzkQ8k2CRKqyoB8Y+
	yi/S9neESCKmNpUZ7YQzEtGTiQ04=
X-Google-Smtp-Source: AGHT+IFP0uMu/YLTAtRb/rfz95PivfdwXs9VYSFQ3nN2dVooF3Hw+AB8vrnTT7JSHf7wyhRcVwb80Xu2+Wkf9vkIWTg=
X-Received: by 2002:a17:90a:8a93:b0:2cd:3445:f87e with SMTP id
 98e67ed59e1d1-2cff93c618bmr15080533a91.2.1722888105898; Mon, 05 Aug 2024
 13:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-7-andrii@kernel.org>
 <eb6d1474-a292-af20-b8b1-1c2de61405f4@huawei.com> <CAEf4BzZR6a4OSqsvyci0_-P+_o2PErM_PyC9y9eSc4J4A+Uabw@mail.gmail.com>
In-Reply-To: <CAEf4BzZR6a4OSqsvyci0_-P+_o2PErM_PyC9y9eSc4J4A+Uabw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Aug 2024 13:01:33 -0700
Message-ID: <CAEf4BzYuGo572m+zi3KD51zp82a63mL9f5F2kz1w8ZvEBQB_VA@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf/uprobe: split uprobe_unregister()
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 8:05=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 1, 2024 at 7:41=E2=80=AFPM Liao, Chang <liaochang1@huawei.com=
> wrote:
> >
> >
> >
> > =E5=9C=A8 2024/8/1 5:42, Andrii Nakryiko =E5=86=99=E9=81=93:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > With uprobe_unregister() having grown a synchronize_srcu(), it become=
s
> > > fairly slow to call. Esp. since both users of this API call it in a
> > > loop.
> > >
> > > Peel off the sync_srcu() and do it once, after the loop.
> > >
> > > With recent uprobe_register()'s error handling reusing full
> > > uprobe_unregister() call, we need to be careful about returning to th=
e
> > > caller before we have a guarantee that partially attached consumer wo=
n't
> > > be called anymore. So add uprobe_unregister_sync() in the error handl=
ing
> > > path. This is an unlikely slow path and this should be totally fine t=
o
> > > be slow in the case of an failed attach.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/uprobes.h                        |  8 ++++++--
> > >  kernel/events/uprobes.c                        | 18 ++++++++++++++--=
--
> > >  kernel/trace/bpf_trace.c                       |  5 ++++-
> > >  kernel/trace/trace_uprobe.c                    |  6 +++++-
> > >  .../selftests/bpf/bpf_testmod/bpf_testmod.c    |  3 ++-
> > >  5 files changed, 31 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index a1686c1ebcb6..8f1999eb9d9f 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -105,7 +105,8 @@ extern unsigned long uprobe_get_trap_addr(struct =
pt_regs *regs);
> > >  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct m=
m_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> > >  extern struct uprobe *uprobe_register(struct inode *inode, loff_t of=
fset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> > >  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consume=
r *uc, bool);
> > > -extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_c=
onsumer *uc);
> > > +extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct u=
probe_consumer *uc);
> > > +extern void uprobe_unregister_sync(void);
> >
> > [...]
> >
> > >  static inline void
> > > -uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > > +uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consum=
er *uc)
> > > +{
> > > +}
> > > +static inline void uprobes_unregister_sync(void)
> >
> > *uprobes*_unregister_sync, is it a typo?
> >
>
> I think the idea behind this is that you do a lot of individual uprobe
> unregistrations with multiple uprobe_unregister() calls, and then
> follow with a single *uprobes*_unregister_sync(), because in general
> it is meant to sync multiple uprobes unregistrations.

Ah, I think you were trying to say that only static inline
implementation here is called uprobes_unregister_sync, while all the
other ones are uprobe_unregister_sync(). I fixed it up, kept it as
singular uprobe_unregister_sync().

>
> > >  {
> > >  }
> > >  static inline int uprobe_mmap(struct vm_area_struct *vma)
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 3b42fd355256..b0488d356399 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c

[...]

