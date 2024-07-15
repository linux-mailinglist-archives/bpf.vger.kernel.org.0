Return-Path: <bpf+bounces-34834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FA0931958
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 19:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFA728357E
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA356440;
	Mon, 15 Jul 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXYbxkif"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8E224EF;
	Mon, 15 Jul 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064662; cv=none; b=RVr8szsIcZMA3QQX+uE/R96vlbQgvTAPWA3PJqERPImT4xjIGZTnhfWc5qw7wxOpLTY4V21q9QKEfeMoCTapcG4AkHboRBBiRJi0Xl9tSw0R7Koh8CMrG02f77cqysTLVIn70hnUoup1KAn1GWMbeuZ2wOp3b+hr6V1yHbZTV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064662; c=relaxed/simple;
	bh=1o+44RtxCfSb7GucrEuzGXESuNxJ1wwd1GELlyBYmkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLwLJtiK3jMtrL28pEhsFlT6z53iUep4O63ZCC311xIBLEMW6bAyZD7ocilJwucoIwfDpcyCc+RzWc8JQRjmMHVQAs6KDrZSsv+/K3lmLtKygxSuR6p03cspqV675lM5rD4Ixa5CInGnN7bRzfMABOsyAssEOlZLpzmrcN84wYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXYbxkif; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c98b22638bso3190293a91.1;
        Mon, 15 Jul 2024 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721064660; x=1721669460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtP4aeSPEGk7iVglJ/94ERRThNBcFKWdiy/YtRf+yZM=;
        b=QXYbxkifJCr0TYEKeKEq69qd3C7cVxB/t2U0XuMArfydkjk9XgZoVoGfIvFGIqgh0M
         0FYP9QFP5Q5A+Lt8i/9nlBZK83Soht2oHELvzsFDrzcvsVQSlvbc/lVaXUCuI2M3EaGF
         Ijf640/m7YO6xrqNjV5hjdSOpS7TJCNXQvKFQ/GvRP3yT1t4MQjcfJOh4NJlUdUYy2pF
         DgX/l0rKe0X5NuSEK3qgXiwixx84AmgswA6Z+BXyoC14T3Pon8PkS6/zmWBGnfAlL8zj
         5l/yZ1G7WMJYih3H314Yv243qkxQ834IuRAga4nmiN3U4F8h0WAltT/AAvw/ZmDouofJ
         nTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721064660; x=1721669460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtP4aeSPEGk7iVglJ/94ERRThNBcFKWdiy/YtRf+yZM=;
        b=ik5CZArEyMggBXL5yEjSCAHHS2r975ef1+gNtFwUVsGKy7DjEB0BBWt1c006v3iDAg
         fwcBAOWwaLURrbZ3RXWhWyNjx9SICucG6wZPgwBKqDzoOyG3yZXfvEvV1dfDRFZcgfMX
         zijTCqoikmsUleDnCAuysMPt4e+vNeQjjf5qYtK+xxiZh6roX3U+cgn91XH4OEw/NBDy
         yJVlbpRnhrlcf8pGC7h/yjMp4bLp2gFrl68KSg7hxDdCTOvz357JDPuUBsdx3Do0ikBo
         Nxup5JJiB6Y3NgW+0VcHPixAQrfYKSmpboromhmPsDI5duUqiTbZhbLmI1CRaRpBOibW
         DtNA==
X-Forwarded-Encrypted: i=1; AJvYcCX1MJEUFsVH6ynJoYEd3KPol44uc3OdqHr+F3TFXmPm3assAUDXa53ql0GgjRSOApJfYkuvzDohQgBgng6QMUACZM0fqUvW6o7X04++fJv7pICUaoDVTUflB2CEuJgTxTJn2DLNKnaRpHZNj2KLbP+vV7moZlzq5gduZ9YMaD9e5zxr0I5y
X-Gm-Message-State: AOJu0YyQKIFW4L2IFSNYlf8BCTW77yXpzkbWuVEJzKB2iQcT6IzwEIoQ
	eXaC08GPpYaGNUZJo2VYCPHb+WGh/1DuiyDxbCbJnnot7dON4f3Q/xkTmHythhuA7rhZYyN2Ty+
	ajvujfaRFd1PPoVVQnEovjaIok+M=
X-Google-Smtp-Source: AGHT+IFIeeEF/sf4vDvJPuTRza3pKxrgkearLeh+rBXCaIF+tOEZNqXuxDQl3W6w/fPyfpxxFyDYTxYQylolnEycNv8=
X-Received: by 2002:a17:90b:906:b0:2c8:5055:e24f with SMTP id
 98e67ed59e1d1-2cb33726539mr819687a91.2.1721064659641; Mon, 15 Jul 2024
 10:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <20240711110400.880800153@infradead.org>
 <CAEf4BzZUVe-dQNcb1VQbEcN4kBFOYrFOB537q4Vhtpm_ebL9aQ@mail.gmail.com> <20240715112504.GD14400@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715112504.GD14400@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Jul 2024 10:30:47 -0700
Message-ID: <CAEf4BzZ9z+J2TMNRGyE9idw2T+zZRe7YU8JzgsoihCLogW4_UA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] perf/uprobe: SRCU-ify uprobe->consumer list
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 4:25=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jul 12, 2024 at 02:06:08PM -0700, Andrii Nakryiko wrote:
> > + bpf@vger, please cc bpf ML for the next revision, these changes are
> > very relevant there as well, thanks
> >
> > On Thu, Jul 11, 2024 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > With handle_swbp() hitting concurrently on (all) CPUs the
> > > uprobe->register_rwsem can get very contended. Add an SRCU instance t=
o
> > > cover the consumer list and consumer lifetime.
> > >
> > > Since the consumer are externally embedded structures, unregister wil=
l
> > > have to suffer a synchronize_srcu().
> > >
> > > A notably complication is the UPROBE_HANDLER_REMOVE logic which can
> > > race against uprobe_register() such that it might want to remove a
> > > freshly installer handler that didn't get called. In order to close
> > > this hole, a seqcount is added. With that, the removal path can tell
> > > if anything changed and bail out of the removal.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/events/uprobes.c |   60 +++++++++++++++++++++++++++++++++++++=
+++--------
> > >  1 file changed, 50 insertions(+), 10 deletions(-)
> > >
> >
> > [...]
> >
> > > @@ -800,7 +808,7 @@ static bool consumer_del(struct uprobe *
> > >         down_write(&uprobe->consumer_rwsem);
> > >         for (con =3D &uprobe->consumers; *con; con =3D &(*con)->next)=
 {
> > >                 if (*con =3D=3D uc) {
> > > -                       *con =3D uc->next;
> > > +                       WRITE_ONCE(*con, uc->next);
> >
> > I have a dumb and mechanical question.
> >
> > Above in consumer_add() you are doing WRITE_ONCE() for uc->next
> > assignment, but rcu_assign_pointer() for uprobe->consumers. Here, you
> > are doing WRITE_ONCE() for the same operation, if it so happens that
> > uc =3D=3D *con =3D=3D uprobe->consumers. So is rcu_assign_pointer() nec=
essary
> > in consumer_addr()? If yes, we should have it here as well, no? And if
> > not, why bother with it in consumer_add()?
>
> add is a publish and needs to ensure all stores to the object are
> ordered before the object is linked in. Note that rcu_assign_pointer()
> is basically a fancy way of writing smp_store_release().
>
> del otoh does not publish, it removes and doesn't need ordering.
>
> It does however need to ensure the pointer write itself isn't torn. That
> is, without the WRITE_ONCE() the compiler is free to do byte stores in
> order to update the 8 byte pointer value (assuming 64bit). This is
> pretty dumb, but very much permitted by C and also utterly fatal in the
> case where an RCU iteration comes by and reads a half-half pointer
> value.
>

Thanks for elaborating, very helpful! It's basically the same idea as
with rb_find_add_rcu(), got it.

> > >                         ret =3D true;
> > >                         break;
> > >                 }
> > > @@ -1139,9 +1147,13 @@ void uprobe_unregister(struct inode *ino
> > >                 return;
> > >
> > >         down_write(&uprobe->register_rwsem);
> > > +       raw_write_seqcount_begin(&uprobe->register_seq);
> > >         __uprobe_unregister(uprobe, uc);
> > > +       raw_write_seqcount_end(&uprobe->register_seq);
> > >         up_write(&uprobe->register_rwsem);
> > >         put_uprobe(uprobe);
> > > +
> > > +       synchronize_srcu(&uprobes_srcu);
> > >  }
> > >  EXPORT_SYMBOL_GPL(uprobe_unregister);
> >
> > [...]

