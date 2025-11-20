Return-Path: <bpf+bounces-75140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E452C7240F
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 06:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E99DE2AE67
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 05:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE5F2FDC53;
	Thu, 20 Nov 2025 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQMmYsJS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78235283FC9
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763616588; cv=none; b=bN7FZGxRNZqhgyAtEdN28qjUj61oGnd7I83xvuzkVFxAof1HeMi/kiuOSkrusnxqxtOdz4Z8WZfu8+sg700knh4rhMPHzOrm0E3FeI4Y0MqGvoGRX9s3dsvVw77KamvQX0exDpRy5V/v0BZ9bQQcbl2KVK7lZJh1eYlUoTl3VWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763616588; c=relaxed/simple;
	bh=YHDLsIpTmt7VE1wNd2xoG3QIZdjR0RBXPFb12Wq7qss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp53IYyH+1LUzjBVnf8UVa2we4CsQT3wZlpWPaMECGX570I7Tzwj37BiI4GNqwKst6eJ7BMeWvixUkkyYGvVZYiGuKgUfzNqhR9nrPOxzC+U8WkQ5yYrxPvgcBt+9+zQA62plmKDV285DtsYHZ9guUxkcAXw9REjIkEV0GtBmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQMmYsJS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297e13bf404so113935ad.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 21:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763616586; x=1764221386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW5aVHVpnngD0pwo3SfGO76Ix5ez8063opvM3M5CLFE=;
        b=wQMmYsJSfsDefVzEp0B7FMyh1VNplJV+Ml+7glKWi4dY54fIFPBXSXEIDu+ZDsuHjI
         G4R3kC2PsCKUuJWn0Amgo6ubt9GHnup2FF1EtztYF3T8HNSgwLoCOq21XmT7CjjH7+aX
         DpK0zHzME/mdqfkr8XOMFEMKRpoF6e/Ql62jAMzhoP3apociHlFhdct7ozmr1P0gQEUH
         QnvC2sDQW5NjKrCnVh96eVYuFJ8sBfwOvZEFxM8bqf9WPI9BbYrw3lxyIH4U2m6QuTrT
         mrsCm6pzmb1ARmigNGx5z5hfycWjx0dvqZXIIESiyFIylbmVn8tr5+rfZLJz0r7EnpjR
         gJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763616586; x=1764221386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TW5aVHVpnngD0pwo3SfGO76Ix5ez8063opvM3M5CLFE=;
        b=YdTunM1sYnkOm4QOGDa201QeBnUCoraZxoden71kXxLIswbE0sMX4XYWbqAT0Z82RZ
         Yy8H1HQvQS5K74oYfkRig+jAirPeXFg4cfuWQ1Uoedd2DulSpyI8vP4f+THM3PDQL03b
         EMX2mgQV2qYebp92dgVXe9alEykK7KtGXId9oTWxF0zL2wUnilcFX1/T6zxDlSs4sAvH
         9Xf0QcECx4CF7/3i6F5d1D54tQA5ZDAca5SFWTlYf7/44vigbDiPO9pZkLZ7sHOT4vLf
         3289XzGq9b1tD4aoKGOoKL2dbH5iKsXEAXq1mXBsEQZXX1V9hf463oozBO6zCycqN0Mu
         0BpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXijIKxF69IxSF6mAC50VgSldF2rlJ8W6lTBlDCtdq2e+vkdnomEptdgLvXLzb5H9m1/Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgqGzw2wQarjbMkiHC3bkWtnV9/Lryq+8kco7PGkjdon9tdk9D
	jb5UdcD1l8FxlsalqajMiMkhszYCDCneH3MU07NjPN5smii9+MpndxJiPrIeXXXzcBsTXNjgylo
	rkQTJmOb70zIdix+Jq+R2zCqQgup72eKxC/kT6tVO
X-Gm-Gg: ASbGncthkTDgJ2xMabaMLAFLdVFV/qkwIY82I0Cn/sM/BGbdaTyHkhru6SgeiNTwh4t
	wHd2X52Zv+rV/nEkaNCkYPbPinq1wG+WuvhcnTuGdOHlnEEhApVZsgvlDsgqFlPhTGTpjOrB9vU
	8Z8ghGn2Eel6NnQoalZ407CztZdc8FJdVFYTvaiJNCZbMwthvs6rSM3v+Hu7YukmwNzEm7rsCVc
	hU7nrn/7PjefftekjNfNHemtVjG+lwrQU8223s+rcjdkDLGEqTK3Tl/SqI0t75JT+OpPNZY
X-Google-Smtp-Source: AGHT+IFz21m1gvtJ+c4Oz5Xw91aFL1sfJL0YxVGA63lOLUkBDQShrn7qcWGtR3K/OnaWZwh4nUG1vbmcxYGLjIUUpt0=
X-Received: by 2002:a17:902:da83:b0:298:144f:b759 with SMTP id
 d9443c01a7336-29b5dc138e1mr1457515ad.9.1763616585298; Wed, 19 Nov 2025
 21:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120021046.94490-1-namhyung@kernel.org> <20251120021046.94490-7-namhyung@kernel.org>
In-Reply-To: <20251120021046.94490-7-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 21:29:34 -0800
X-Gm-Features: AWmQ_bniEbT9bZAsiC3VOQbMkfFcl3CbQa7pPIN-PoUwLJdoM4P-V4uu45KLj0Q
Message-ID: <CAP-5=fVZcmYgyRJVNbet9ZLjihAiXNy7D8cX+QqHe8EKqJ1qOQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] perf tools: Flush remaining samples w/o deferred callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 6:11=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It's possible that some kernel samples don't have matching deferred
> callchain records when the profiling session was ended before the
> threads came back to userspace.  Let's flush the samples before
> finish the session.
>
> Also 32-bit systems can see partial mmap for the data.  In that case,
> deferred samples won't point to the correct data once the mapping moves
> to the next portion of the file.  Copy the original sample before it
> unmaps the current data.

I think it is simpler to always copy. We may have events from
synthesis, inject, .. and not the reader. Relying on callers to know
that someone made a copy of the event and to make a defensive copy on
their behalf just feels error prone.

In the python session API I need to deal with the lifetime of events.
Currently the events are copied:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n507
and I'm doing this for session tool callbacks:
https://lore.kernel.org/lkml/20251029053413.355154-12-irogers@google.com/
I think it can be made lazier by knowing the tool callback can assume
the event and sample are valid. We can delay the copying of the
event/sample for if the pyevent has a reference count >1 and we're
returning out of the tool callback. Doing some kind of global
knowledge in the reader for maintaining the correctness of memory, I'm
just not clear on how to make it always work.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/session.c | 98 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 2e777fd1bcf6707b..b781e01ddcb4876b 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1288,8 +1288,13 @@ static int evlist__deliver_sample(struct evlist *e=
vlist, const struct perf_tool
>  struct deferred_event {
>         struct list_head list;
>         union perf_event *event;
> +       bool allocated;
>  };
>
> +/*
> + * This is called when a deferred callchain record comes up.  Find all m=
atching
> + * samples, merge the callchains and process them.
> + */
>  static int evlist__deliver_deferred_samples(struct evlist *evlist,
>                                             const struct perf_tool *tool,
>                                             union  perf_event *event,
> @@ -1331,6 +1336,86 @@ static int evlist__deliver_deferred_samples(struct=
 evlist *evlist,
>                         free(orig_sample.callchain);
>
>                 list_del(&de->list);
> +               if (de->allocated)
> +                       free(de->event);
> +               free(de);
> +
> +               if (ret)
> +                       break;
> +       }
> +       return ret;
> +}
> +
> +/*
> + * This is called when the backing mmap is about to go away.  It needs t=
o save
> + * the original sample data until it finds the matching deferred callcha=
ins.
> + */
> +static void evlist__copy_deferred_samples(struct evlist *evlist,
> +                                         const struct perf_tool *tool,
> +                                         struct machine *machine)
> +{
> +       struct deferred_event *de, *tmp;
> +       struct evsel *evsel;
> +       int ret =3D 0;
> +
> +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> +               struct perf_sample sample;
> +               size_t sz =3D de->event->header.size;
> +               void *buf;
> +
> +               if (de->allocated)
> +                       continue;
> +
> +               buf =3D malloc(sz);
> +               if (buf) {
> +                       memcpy(buf, de->event, sz);
> +                       de->event =3D buf;
> +                       de->allocated =3D true;
> +                       continue;
> +               }
> +
> +               /* The allocation failed, flush the sample now */
> +               ret =3D evlist__parse_sample(evlist, de->event, &sample);
> +               if (ret =3D=3D 0) {
> +                       evsel =3D evlist__id2evsel(evlist, sample.id);
> +                       evlist__deliver_sample(evlist, tool, de->event,
> +                                              &sample, evsel, machine);
> +               }
> +
> +               list_del(&de->list);
> +               BUG_ON(de->allocated);
> +               free(de);
> +       }
> +}
> +
> +/*
> + * This is called at the end of the data processing for the session.  Fl=
ush the
> + * remaining samples as there's no hope for matching deferred callchains=
.
> + */
> +static int evlist__flush_deferred_samples(struct evlist *evlist,
> +                                         const struct perf_tool *tool,
> +                                         struct machine *machine)
> +{
> +       struct deferred_event *de, *tmp;
> +       struct evsel *evsel;
> +       int ret =3D 0;
> +
> +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> +               struct perf_sample sample;
> +
> +               ret =3D evlist__parse_sample(evlist, de->event, &sample);
> +               if (ret < 0) {
> +                       pr_err("failed to parse original sample\n");
> +                       break;
> +               }
> +
> +               evsel =3D evlist__id2evsel(evlist, sample.id);
> +               ret =3D evlist__deliver_sample(evlist, tool, de->event,
> +                                            &sample, evsel, machine);
> +
> +               list_del(&de->list);
> +               if (de->allocated)
> +                       free(de->event);
>                 free(de);
>
>                 if (ret)
> @@ -1374,6 +1459,7 @@ static int machines__deliver_event(struct machines =
*machines,
>                                 return -ENOMEM;
>
>                         de->event =3D event;
> +                       de->allocated =3D false;
>                         list_add_tail(&de->list, &evlist->deferred_sample=
s);
>                         return 0;
>                 }
> @@ -2218,6 +2304,8 @@ reader__mmap(struct reader *rd, struct perf_session=
 *session)
>         }
>
>         if (mmaps[rd->mmap_idx]) {
> +               evlist__copy_deferred_samples(session->evlist, session->t=
ool,
> +                                             &session->machines.host);
>                 munmap(mmaps[rd->mmap_idx], rd->mmap_size);
>                 mmaps[rd->mmap_idx] =3D NULL;
>         }
> @@ -2372,6 +2460,11 @@ static int __perf_session__process_events(struct p=
erf_session *session)
>         if (err)
>                 goto out_err;
>         err =3D auxtrace__flush_events(session, tool);
> +       if (err)
> +               goto out_err;
> +       err =3D evlist__flush_deferred_samples(session->evlist,
> +                                            session->tool,
> +                                            &session->machines.host);
>         if (err)
>                 goto out_err;
>         err =3D perf_session__flush_thread_stacks(session);
> @@ -2494,6 +2587,11 @@ static int __perf_session__process_dir_events(stru=
ct perf_session *session)
>         if (ret)
>                 goto out_err;
>
> +       ret =3D evlist__flush_deferred_samples(session->evlist, tool,
> +                                            &session->machines.host);
> +       if (ret)
> +               goto out_err;
> +
>         ret =3D perf_session__flush_thread_stacks(session);
>  out_err:
>         ui_progress__finish();
> --
> 2.52.0.rc1.455.g30608eb744-goog
>

