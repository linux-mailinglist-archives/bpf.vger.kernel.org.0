Return-Path: <bpf+bounces-16758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869AA805D0F
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1EC1C21160
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0D068B70;
	Tue,  5 Dec 2023 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5zedPar"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8F0122
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:17:17 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b83fc26e4cso3358699b6e.2
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701800237; x=1702405037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDi8w67oLrCVnWUnDYFdDwzLTH62p8zVTFKrJGR7vTA=;
        b=T5zedPartWcsSubHoFT0v9EkdqfSoBTx4JJjvCaW6LJyr1VJGToiDW5yiki1CiuIqk
         rp+3A3RN+mULd1/avj0jZ/h9a31Ekl2Jnd1SRladgxSe6eMJHqc757INfvoj4WcYK47H
         fIcoSBSrNlTpVInIYRwpQ+NJQwTXyHltRdJ60EScLgGPYQ+gL8DKAYZUl9qanLJ1gR86
         eHywPwoOCGh3ncpyH7/SBS7xSkVSqRjfrWQoyxnKGq8OJhZr6K/W4uWysims260yfa+h
         tocvC57EMWZoIYxaPqGXq5eQQkKU3HvaDcZ9+S6BLjiwBHj1NzFHXAmKOILZ4jwz9kmk
         CvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800237; x=1702405037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDi8w67oLrCVnWUnDYFdDwzLTH62p8zVTFKrJGR7vTA=;
        b=P+u5vKRUcPrFi5fM1UYhxRjh7+77sZdjmVpVdmv91g9IDQtgo0qcuGZJ3V8Jfn/RZN
         Ch7GnjSGi81DmUxXV5R1wrb5OZCdJ0zGWL89gcPWaaOIwZGcGKC69vRZg1T2AThAek6K
         WzaCL/DEthTinuakhqsSKD77+giSHsIjjv71JC6Z4B6WvsXXaDwblmjnWeIbGBUZF5Ya
         Gjiwrlcmoy+sTozEABbm+KsDChyjzSgQWoBJTfYeGIwPaXiOmB5gHP2eH7FVSJ0TnnTy
         YWVcqg06/apnvgcplZP9lH6F+Ajo3Yy0PrANlXSjfmpRRokElmDk5MOKeVXk7IFZF8/v
         9HcQ==
X-Gm-Message-State: AOJu0YzZ+ZqZe+u6cFyiSozKGVBnVNgSflK+09GkBRn5qWXEM7ezcSJA
	mD9Tzf1ndZvTFFwLRj8PnT9bZ36Gsew2GDxVEy+Gqw==
X-Google-Smtp-Source: AGHT+IFVPtycg0dL10C+0thiptzxicQhELMBG95r/Ap4aYVMCRYNBG6hTGKCzlb6QEEknzdZvnI7OFwLD7ptlaTRwLc=
X-Received: by 2002:a05:6870:9d9b:b0:1fa:1355:da45 with SMTP id
 pv27-20020a0568709d9b00b001fa1355da45mr7508586oab.11.1701800236823; Tue, 05
 Dec 2023 10:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-2-khuey@kylehuey.com>
 <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com>
 <ZW8Gi2QI5ceAJfab@krava> <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
In-Reply-To: <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 5 Dec 2023 19:16:38 +0100
Message-ID: <CANpmjNPfoLX=HPy0MhbGqMmGT4jE0Ky29cx5QP_8tJ2u=1ju_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Dec 2023 at 19:07, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> Add Marco Elver to CC.
>
> On Tue, Dec 5, 2023 at 3:16=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Mon, Dec 04, 2023 at 02:18:49PM -0800, Andrii Nakryiko wrote:
> > > On Mon, Dec 4, 2023 at 12:14=E2=80=AFPM Kyle Huey <me@kylehuey.com> w=
rote:
> > > >
> > > > Returning zero from a bpf program attached to a perf event already
> > > > suppresses any data output. This allows it to suppress I/O availabi=
lity
> > > > signals too.
> > >
> > > make sense, just one question below
> > >
> > > >
> > > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > > > ---
> > > >  kernel/events/core.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index b704d83a28b2..34d7b19d45eb 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct pe=
rf_event *event,
> > > >         rcu_read_unlock();
> > > >  out:
> > > >         __this_cpu_dec(bpf_prog_active);
> > > > -       if (!ret)
> > > > +       if (!ret) {
> > > > +               event->pending_kill =3D 0;
> > > >                 return;
> > > > +       }
> > >
> > > What's the distinction between event->pending_kill and
> > > event->pending_wakeup? Should we do something about pending_wakeup?
> > > Asking out of complete ignorance of all these perf specifics.
> > >
> >
> > I think zeroing pending_kill is enough.. when it's set the perf code
> > sets pending_wakeup to call perf_event_wakeup in irq code that wakes
> > up event's ring buffer readers and sends sigio if pending_kill is set
>
> Right, IIUC pending_wakeup is set by the ring buffer code when
> a task is waiting for events and it gets enough events (watermark).
> So I think it's good for ring buffer to manage the pending_wakeup.
>
> And pending_kill is set when a task wants a signal delivery even
> without getting enough events.  Clearing pending_kill looks ok
> to suppress normal signals but I'm not sure if it's ok for SIGTRAP.
>
> If we want to handle returning 0 from bpf as if the event didn't
> happen, I think SIGTRAP and event_limit logic should be done
> after the overflow handler depending on pending_kill or something.

I'm not sure which kernel version this is for, but in recent kernels,
the SIGTRAP logic was changed to no longer "abuse" event_limit, and
uses its own "pending_sigtrap" + "pending_work" (on reschedule
transitions).

Thanks,
-- Marco

