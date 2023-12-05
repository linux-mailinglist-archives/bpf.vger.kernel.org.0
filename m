Return-Path: <bpf+bounces-16756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158F9805CE4
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C4A281B48
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7268B6B;
	Tue,  5 Dec 2023 18:07:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F1B2;
	Tue,  5 Dec 2023 10:07:54 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28659348677so42503a91.0;
        Tue, 05 Dec 2023 10:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799673; x=1702404473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNlzMFur71ZQLLM8yVbvG7H8ZNU7xWznyiwruW2zco0=;
        b=mmpoplhQu5uU/XSuuWP/AqZ8VpkAKj5UQwW7THhA8AUjNqnjE16Xc1Z13cI5HcQUlS
         JhAkQt7b4jSEUjH8ondLXyM64q6MnYaLfFhFn1f57pww8Guh7wjzt0I27dXkjldJSOIS
         ML53Ydc4wt09wtjhaEgjrTBFymmNmJ7ADTQHVWTTvfdgLqoxHdUlKTexwM9xfzUVY8Vl
         v4UV9moer2GAJzslTjtrB4hMMssifMK1F6Aub0UIh64xbePDukSavbJUXW+78T0eRoiI
         g4vMGjt3drqWBGFxqWRoc1FWLH8YPixAnViCX7vyyeZgf5RBTJYCHHtp10vh4Ys2Aw67
         cYKg==
X-Gm-Message-State: AOJu0YzT5jZn00jLY3thcs/QSy0hE2wCz7g4olUqF8HMWe3DvD5q8a+3
	ULKve4jgBhQv7SS9mrXhSNZEo0N6w6FX/JAOyrQ=
X-Google-Smtp-Source: AGHT+IHGLbi5nmB/0juEOSLMahSlJHYu1FGow8cvsSJNx3cCdYCI6tX17VGnnmPmUgMoA0doL5dZ4OEouXFjdhP676I=
X-Received: by 2002:a17:90b:1c0b:b0:286:bda8:9633 with SMTP id
 oc11-20020a17090b1c0b00b00286bda89633mr1926839pjb.25.1701799673408; Tue, 05
 Dec 2023 10:07:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-2-khuey@kylehuey.com>
 <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com> <ZW8Gi2QI5ceAJfab@krava>
In-Reply-To: <ZW8Gi2QI5ceAJfab@krava>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 5 Dec 2023 10:07:42 -0800
Message-ID: <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Kyle Huey <me@kylehuey.com>, 
	Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Add Marco Elver to CC.

On Tue, Dec 5, 2023 at 3:16=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Dec 04, 2023 at 02:18:49PM -0800, Andrii Nakryiko wrote:
> > On Mon, Dec 4, 2023 at 12:14=E2=80=AFPM Kyle Huey <me@kylehuey.com> wro=
te:
> > >
> > > Returning zero from a bpf program attached to a perf event already
> > > suppresses any data output. This allows it to suppress I/O availabili=
ty
> > > signals too.
> >
> > make sense, just one question below
> >
> > >
> > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> > > ---
> > >  kernel/events/core.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index b704d83a28b2..34d7b19d45eb 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct perf=
_event *event,
> > >         rcu_read_unlock();
> > >  out:
> > >         __this_cpu_dec(bpf_prog_active);
> > > -       if (!ret)
> > > +       if (!ret) {
> > > +               event->pending_kill =3D 0;
> > >                 return;
> > > +       }
> >
> > What's the distinction between event->pending_kill and
> > event->pending_wakeup? Should we do something about pending_wakeup?
> > Asking out of complete ignorance of all these perf specifics.
> >
>
> I think zeroing pending_kill is enough.. when it's set the perf code
> sets pending_wakeup to call perf_event_wakeup in irq code that wakes
> up event's ring buffer readers and sends sigio if pending_kill is set

Right, IIUC pending_wakeup is set by the ring buffer code when
a task is waiting for events and it gets enough events (watermark).
So I think it's good for ring buffer to manage the pending_wakeup.

And pending_kill is set when a task wants a signal delivery even
without getting enough events.  Clearing pending_kill looks ok
to suppress normal signals but I'm not sure if it's ok for SIGTRAP.

If we want to handle returning 0 from bpf as if the event didn't
happen, I think SIGTRAP and event_limit logic should be done
after the overflow handler depending on pending_kill or something.

Thanks,
Namhyung

