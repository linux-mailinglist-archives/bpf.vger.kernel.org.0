Return-Path: <bpf+bounces-36293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B941D945FD7
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 17:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19391C2259C
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD8E2101B9;
	Fri,  2 Aug 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYQxjmB1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE01DAC4F;
	Fri,  2 Aug 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611138; cv=none; b=uO1MzdM02Cjyfmd3h8xVlp+k8CEWvi0/vdIPJaAOLRUoF2RfYt7ShYqBKuhUovkGfavTPpCf+QZPdCxGDVUHs0Fe3/TdpJCO0gpqOa1X4E3ZJ11gbN4n3cfHPWnxTnY+U/Su+LtvPj8kZXe6VrxDjpjcijtjVOkAZvYfQUUSZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611138; c=relaxed/simple;
	bh=RBRAeZBBYoe2LXhw8LghRfF6wQcafFS9pPEQGc32G0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyppxTAilTNh2gk6dok+XYFaZVTLpJ8lqLMahw2LtyP/VFl1Wuk3ZVFzg/T0tRtWDdVKSVeYFGsjyQAQD5jX6PRuTx7XH25BD4ayNVJqR71FR4Y8gCHCTmeR37/tKxIZeyP3T3TGrm4wkZ98z29YNvS5mgKNsfiHeIeQzHjt7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYQxjmB1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a9e25008aso1102428566b.0;
        Fri, 02 Aug 2024 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722611135; x=1723215935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UyWAM+msyPF6QGXrwvMTh/SmGbZRENZMvN4/PcJhyU=;
        b=ZYQxjmB1AQWyOmgjnh7QzsWDoGRHYhRwlPnV+TahrW7R/bH2e0lwv9D9yUZggpdkMd
         o2EN40+CopYdjcVgzNldlvRkSuaA3ymFgGzmAbkPTxOut4ytJmfD4dpFaktLpZfQrGED
         DtRrSs9N4E4YHZV1XRvjJYJ6ApNiVqX+mB+Jy/q3zYEJwh1360rY3PdUX30h0YfVSPrT
         p1PtES3vCv0ifuFUVM5pOWmFkDdDicI4t/uMUao4xkl+lJtNUiwbHxO5l3kswEbKQ0Z0
         M6TnnGpKxwblJPeAWajR943niQwHMDg53ymPKJ3Kjo0WN+ZCHWn84zuS+NHMFwS3PcGl
         dDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611135; x=1723215935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UyWAM+msyPF6QGXrwvMTh/SmGbZRENZMvN4/PcJhyU=;
        b=FgHz2rkdC3m1DYO988N/SDR6OTeuyfV2vol3Idmd+8x+4AR61WzzDqSGZEYZqLKVcv
         cAc46zrw+agPsAcNhn75+WHqv2okB2Ts3IPN+tuey78N2tLU6d7YacbnXwGMcLHl6tYD
         LMX7ZAkCG5OfCwHOngMmtIpd+V5YN9WlfqRGSISMpeN2aNY9gHDTYNdYjdskbO4H+LtI
         6bkWpArXGIzQIrn68LQcAM0zD8KPagqVK36QUFgZdhSzv9zug7ODvDzOXBpre3Hv/2C4
         zGE76DaFeAfaibKIzUgnvuqCqu9Jpz4lNuLJ/n2nmT9PEQ+smTinNb0a+VJ81shBqU8j
         0cRw==
X-Forwarded-Encrypted: i=1; AJvYcCVvXu0p5xDs/IY0G5irDo4nD8q2bjdraaRHG4XlPrti5S/D3HXmelZfAow5rTAnc8/NsP1NgS9TVfR7pIZCDsrPaZLg1/oGABFs2dmobkT+31xjgCTuAn0Wa2+3A8/L6vqwiLYaHb3cGrv86J0N4csWC6g2rpRXZeRcC63F4WhE2W7Q4J3m
X-Gm-Message-State: AOJu0YwCIBJrfREFKo6pl5/kuELQn1kcpJPI2xE+EQu2fz4OGzJFFH3b
	n7JxPIAfGx51ZmkYiqd5zb221FL5EyjDTIiAvTSGrJnYMRMWaPumN6rw7OfFv2eWYKSMwEIwIn3
	eKzFQ3ObFiLOxA2ww+VNAg/2+8zU=
X-Google-Smtp-Source: AGHT+IElMIr/ebjjVoiS+upJcSsQBtMTff/+jRibSomwARdE7S8RvH9GjM+u5Fc8asTVB7YKAdQ5e2uYe0cQpkk+4V4=
X-Received: by 2002:a17:906:c10a:b0:a72:8296:ca1f with SMTP id
 a640c23a62f3a-a7dc506dc64mr257607166b.50.1722611134200; Fri, 02 Aug 2024
 08:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-7-andrii@kernel.org>
 <eb6d1474-a292-af20-b8b1-1c2de61405f4@huawei.com>
In-Reply-To: <eb6d1474-a292-af20-b8b1-1c2de61405f4@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Aug 2024 08:05:18 -0700
Message-ID: <CAEf4BzZR6a4OSqsvyci0_-P+_o2PErM_PyC9y9eSc4J4A+Uabw@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf/uprobe: split uprobe_unregister()
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 7:41=E2=80=AFPM Liao, Chang <liaochang1@huawei.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/8/1 5:42, Andrii Nakryiko =E5=86=99=E9=81=93:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > With uprobe_unregister() having grown a synchronize_srcu(), it becomes
> > fairly slow to call. Esp. since both users of this API call it in a
> > loop.
> >
> > Peel off the sync_srcu() and do it once, after the loop.
> >
> > With recent uprobe_register()'s error handling reusing full
> > uprobe_unregister() call, we need to be careful about returning to the
> > caller before we have a guarantee that partially attached consumer won'=
t
> > be called anymore. So add uprobe_unregister_sync() in the error handlin=
g
> > path. This is an unlikely slow path and this should be totally fine to
> > be slow in the case of an failed attach.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/uprobes.h                        |  8 ++++++--
> >  kernel/events/uprobes.c                        | 18 ++++++++++++++----
> >  kernel/trace/bpf_trace.c                       |  5 ++++-
> >  kernel/trace/trace_uprobe.c                    |  6 +++++-
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c    |  3 ++-
> >  5 files changed, 31 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index a1686c1ebcb6..8f1999eb9d9f 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -105,7 +105,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt=
_regs *regs);
> >  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_=
struct *mm, unsigned long vaddr, uprobe_opcode_t);
> >  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offs=
et, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> >  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer =
*uc, bool);
> > -extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_con=
sumer *uc);
> > +extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct upr=
obe_consumer *uc);
> > +extern void uprobe_unregister_sync(void);
>
> [...]
>
> >  static inline void
> > -uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > +uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer=
 *uc)
> > +{
> > +}
> > +static inline void uprobes_unregister_sync(void)
>
> *uprobes*_unregister_sync, is it a typo?
>

I think the idea behind this is that you do a lot of individual uprobe
unregistrations with multiple uprobe_unregister() calls, and then
follow with a single *uprobes*_unregister_sync(), because in general
it is meant to sync multiple uprobes unregistrations.

> >  {
> >  }
> >  static inline int uprobe_mmap(struct vm_area_struct *vma)
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 3b42fd355256..b0488d356399 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1089,11 +1089,11 @@ register_for_each_vma(struct uprobe *uprobe, st=
ruct uprobe_consumer *new)
> >  }
> >
> >  /**
> > - * uprobe_unregister - unregister an already registered probe.
> > + * uprobe_unregister_nosync - unregister an already registered probe.
> >   * @uprobe: uprobe to remove
> >   * @uc: identify which probe if multiple probes are colocated.
> >   */
> > -void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *=
uc)
> > +void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_con=
sumer *uc)
> >  {
> >       int err;
> >
> > @@ -1109,10 +1109,14 @@ void uprobe_unregister(struct uprobe *uprobe, s=
truct uprobe_consumer *uc)
> >               return;
> >
> >       put_uprobe(uprobe);
> > +}
> > +EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
> >
> > +void uprobe_unregister_sync(void)
> > +{
> >       synchronize_srcu(&uprobes_srcu);
> >  }
> > -EXPORT_SYMBOL_GPL(uprobe_unregister);
> > +EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
> >
> >  /**
> >   * uprobe_register - register a probe
> > @@ -1170,7 +1174,13 @@ struct uprobe *uprobe_register(struct inode *ino=
de,
> >       up_write(&uprobe->register_rwsem);
> >
> >       if (ret) {
> > -             uprobe_unregister(uprobe, uc);
> > +             uprobe_unregister_nosync(uprobe, uc);
> > +             /*
> > +              * Registration might have partially succeeded, so we can=
 have
> > +              * this consumer being called right at this time. We need=
 to
> > +              * sync here. It's ok, it's unlikely slow path.
> > +              */
> > +             uprobe_unregister_sync();
> >               return ERR_PTR(ret);
> >       }
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 73c570b5988b..6b632710c98e 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3184,7 +3184,10 @@ static void bpf_uprobe_unregister(struct bpf_upr=
obe *uprobes, u32 cnt)
> >       u32 i;
> >
> >       for (i =3D 0; i < cnt; i++)
> > -             uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer=
);
> > +             uprobe_unregister_nosync(uprobes[i].uprobe, &uprobes[i].c=
onsumer);
> > +
> > +     if (cnt)
> > +             uprobe_unregister_sync();
> >  }
> >
> >  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 7eb79e0a5352..f7443e996b1b 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -1097,6 +1097,7 @@ static int trace_uprobe_enable(struct trace_uprob=
e *tu, filter_func_t filter)
> >  static void __probe_event_disable(struct trace_probe *tp)
> >  {
> >       struct trace_uprobe *tu;
> > +     bool sync =3D false;
> >
> >       tu =3D container_of(tp, struct trace_uprobe, tp);
> >       WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
> > @@ -1105,9 +1106,12 @@ static void __probe_event_disable(struct trace_p=
robe *tp)
> >               if (!tu->uprobe)
> >                       continue;
> >
> > -             uprobe_unregister(tu->uprobe, &tu->consumer);
> > +             uprobe_unregister_nosync(tu->uprobe, &tu->consumer);
> > +             sync =3D true;
> >               tu->uprobe =3D NULL;
> >       }
> > +     if (sync)
> > +             uprobe_unregister_sync();
> >  }
> >
> >  static int probe_event_enable(struct trace_event_call *call,
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/to=
ols/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 73a6b041bcce..928c73cde32e 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -478,7 +478,8 @@ static void testmod_unregister_uprobe(void)
> >       mutex_lock(&testmod_uprobe_mutex);
> >
> >       if (uprobe.uprobe) {
> > -             uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
> > +             uprobe_unregister_nosync(uprobe.uprobe, &uprobe.consumer)=
;
> > +             uprobe_unregister_sync();
> >               uprobe.offset =3D 0;
> >               uprobe.uprobe =3D NULL;
> >       }
>
> --
> BR
> Liao, Chang

