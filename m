Return-Path: <bpf+bounces-16722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E02A8051D7
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 12:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138E71F2149A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C917456B68;
	Tue,  5 Dec 2023 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQrS/Mt0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4121A1;
	Tue,  5 Dec 2023 03:16:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1c890f9b55so54542266b.1;
        Tue, 05 Dec 2023 03:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701774990; x=1702379790; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ti0EygLrXL1ybJV+2IwmkNvjqyvD5l8XhA94fC+ez5I=;
        b=IQrS/Mt0jalyQNPuEp2OHaRHpB+o3D5drxbQ6PP53lztG2e5uxf8MsVeDS8D7+7PMn
         8RkYZuwcad3Zup11PLM40MxhZOu8TFn9ysQgTePyFlajE0GR7pwgLzzxcpNRGDkbitwR
         DFYLhBtBbb0Xm4L3rrZXgB9xwz0KkOXRwVdT+ijQvLHVh9zc7irbpVAPvitlUG5Qs7vW
         VIskrv2HQpxj8GqfyZqoagKiIqshdz5Zwq8o70x5X9633myNWRvmbCizrLyGWZRE/Zdo
         CBR2t4MrAizAT7E3ScKhKlpI1xK84/9hIFJiZFYmFA6J0bwG00adoTGKYus83Fa1mKkn
         72+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701774990; x=1702379790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ti0EygLrXL1ybJV+2IwmkNvjqyvD5l8XhA94fC+ez5I=;
        b=NRcqOpYH8QpYbB0OPfVvzMa81SoTTvUmvMsdYmVs9rk319j7YrIv+UGd3GdrS4oLls
         MvBuDZb9f87FB8CK6Dd4o0S23PyrJtmiaktOdDwOK9m3yapGdHFAX6V/5xhWfUnC4jjz
         dXF5cjDVbU8j6jWXRjaN6+cWKhzPFmyvWyHQaexeEUFg8BPb1B8hG4KEQqL9dwjNb9R9
         AmZ2FnTrrDXiPxPh13PagHXKFSMtRfeN2H83HOD0rvobpsFCZtpVsQXtvI5cZOYtXIw+
         6WJd7fNYxxY9ejhjLCQ38YE88EI2h1c6QkApkGeuKPK4DN1hCfqOpk/8jRMVnQA8QDmI
         vEWg==
X-Gm-Message-State: AOJu0Yxvqt9Ze4jWmzsIcgB+8l0h06gqjqkuEMQAgbPi3jwXoOchJS1Y
	nULef01jJGpzyO79r8eBD1Q=
X-Google-Smtp-Source: AGHT+IF3d9WCZ91k4YmR1hipO6U/99Y2ij76ZhU4TAQ7trpVtzdBDgNbaHMOf5TbJRmoNAyGVk54Zg==
X-Received: by 2002:a17:906:dc:b0:a01:9d8b:db17 with SMTP id 28-20020a17090600dc00b00a019d8bdb17mr4727373eji.15.1701774990161;
        Tue, 05 Dec 2023 03:16:30 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id b6-20020a170906194600b00a1712cbddebsm1761143eje.187.2023.12.05.03.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:16:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Dec 2023 12:16:27 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O
 signals.
Message-ID: <ZW8Gi2QI5ceAJfab@krava>
References: <20231204201406.341074-1-khuey@kylehuey.com>
 <20231204201406.341074-2-khuey@kylehuey.com>
 <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com>

On Mon, Dec 04, 2023 at 02:18:49PM -0800, Andrii Nakryiko wrote:
> On Mon, Dec 4, 2023 at 12:14 PM Kyle Huey <me@kylehuey.com> wrote:
> >
> > Returning zero from a bpf program attached to a perf event already
> > suppresses any data output. This allows it to suppress I/O availability
> > signals too.
> 
> make sense, just one question below
> 
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

> > ---
> >  kernel/events/core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b704d83a28b2..34d7b19d45eb 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct perf_event *event,
> >         rcu_read_unlock();
> >  out:
> >         __this_cpu_dec(bpf_prog_active);
> > -       if (!ret)
> > +       if (!ret) {
> > +               event->pending_kill = 0;
> >                 return;
> > +       }
> 
> What's the distinction between event->pending_kill and
> event->pending_wakeup? Should we do something about pending_wakeup?
> Asking out of complete ignorance of all these perf specifics.
> 

I think zeroing pending_kill is enough.. when it's set the perf code
sets pending_wakeup to call perf_event_wakeup in irq code that wakes
up event's ring buffer readers and sends sigio if pending_kill is set

jirka

> 
> >
> >         event->orig_overflow_handler(event, data, regs);
> >  }
> > --
> > 2.34.1
> >
> >

