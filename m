Return-Path: <bpf+bounces-75141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E247DC7292A
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 08:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C95D03497F0
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF973043AF;
	Thu, 20 Nov 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knUuKfk3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C4302CC9
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623310; cv=none; b=hXpdCCggCgZzt1LKYsovheuzBcDq/GbReXC799aXcgdG5t5P6q+O3H+c5/VzzF8PSpEKKtQ+HJv6NfX7Dff6d88KzwIuJIdHCujYZ5u4hNNb+JjPAhDtWaA5taexzW0nevGTCdODlwj2oSUYYNv9vRBJ1IDdnGHmvoqCG6KTwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623310; c=relaxed/simple;
	bh=PoZzKooldyS09F0DrQHNQlOyt/QzIA7zHB/LjzFuNHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwV6PS3x6W8xHxTcrXUWl8yUWj45StI3gkJrdreo/9Od628emhkvSCFbtnrwgtN9Nxxq4v6uI0caLZV8Q/UqXbJJcqYsVyEFxEWJv51lkifFz+hTe6rspvvjEv23WeE9Ue+O/H5+ENMI5jUbXS8gFDnjVDzW2BhU6vJYr9YrWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knUuKfk3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295c64cb951so157415ad.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 23:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763623307; x=1764228107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHaicfDQ+Iz0AxGWxfn1Oe/AWnMqn2B/ceLG3l5DP4g=;
        b=knUuKfk3B4zUoyDB7P59AxJ4GjTKDh6nYPwfi96fNtrqzBYMH9XkorqIsZO8W6maOL
         enxpHWf7P7UBi0JlrNPKt3ySVn/HYTUKHJ+L7O44lrrI8H8IdNdhLJyIXhuL6vv5V1+Q
         11NNC0SQaevc3jwxjabwu9TxEW8jVGYrlK/50aPem9GAy6hDw+Wa1BILIJJiu7+6utgm
         Dqc7ujEjfPNuNfPqCxGLrDByHweu42jUURtfZVil9NHXNlJkXN6QMbv0xwVFi2aU8q78
         4kzzExZ32O5y9OH4NjauDkIXZIJVP4xUXvq0u3kzCP2JIXtBxENEhOKnKUAeIy5GfcSV
         iGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763623307; x=1764228107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHaicfDQ+Iz0AxGWxfn1Oe/AWnMqn2B/ceLG3l5DP4g=;
        b=WhXr187SWgoFi5DwZPASePjOEB5XC2nRGezf5XSS0WCql4Zx3fidljfIeL+PIuBRe7
         JozoJCL3KsNZG4UMY4U9SMw0DvvzJqHeEe8d32MBdvHmbrlFYJtcGbhhwAdncPPVOhYo
         gtkeAeaYxhwKWfj7wKM1xMb9cUidGrF7lyKAMoHd2GvSjtzoFpvqo3aIY3Yn68MVHMn8
         bz43UlpaVWsfJHkzInqE5U1gQ+mO86pvUBdD4C99fTBHnu0gl620TRL4wRJ8eds1yeNo
         D8lImcfRO+pI/maoqgu/DIxJKStTx9BeuGgNGn/wod56HyZzvbBFgqCA7hBJ2xBNQ0Y/
         kv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxQUC52o5J+QR0202mO3LcWdCtkWlgK9M0zwi+YFz0tJe4GIgCCV1zaBiDBeBxP+DQFvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/h2M2e6Usz9VF8ZrguT9sxBWJyOe2cbYu38wrbL28fnan0AYi
	sREFoD0/VEuAumtXfrVMBUfggwQ8vTDAzZxtVNoEicCi+cJbw+1HtwUc/mpuPCC3/HF++PVSyxC
	SiMxjAgnkBWcRHCLrhqcusO4nRvvmuikfLzEE0M+L
X-Gm-Gg: ASbGncuDCTGNqRtlKYF1o6D+UOGKaqw8T0IZAdIQSXFCVtCKRalvuHtL9epAYmkBB/+
	k5q7wWn5nwOLrC8ooqB9fcNpQ7enxnvgvJLa32Pn0oYgXHDCtlKtYzeFMd2aBqKUlTEU3BXiVLY
	BmtPQVlYPvvtOSmD7nvqD6TeBdQW2x0+Gw67OMgBZr/xc0IPG9XcrL4CT1+80BzTGhIZZ2v563l
	G8F3GHt5nbdxHFcIO4Hd/mHY0HTQsqJlhdR8CKK0ir2OWbUk52mnaVG3GZkiJg9qr0swKjv
X-Google-Smtp-Source: AGHT+IHZH4dzJYbP+6JEJU146TqIYwgbwYu6L37DmUR2kDQlrP4kcGeYX6edRL7L67kQOFBusvYY8AdC2i6auLcPlzk=
X-Received: by 2002:a17:902:d48a:b0:295:30bc:458e with SMTP id
 d9443c01a7336-29b5da68247mr1398075ad.3.1763623306956; Wed, 19 Nov 2025
 23:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120021046.94490-1-namhyung@kernel.org> <20251120021046.94490-7-namhyung@kernel.org>
 <CAP-5=fVZcmYgyRJVNbet9ZLjihAiXNy7D8cX+QqHe8EKqJ1qOQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVZcmYgyRJVNbet9ZLjihAiXNy7D8cX+QqHe8EKqJ1qOQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 23:21:35 -0800
X-Gm-Features: AWmQ_bmGj70-yG8VRXForCVD3RpZbxAbDk1gJJ-fwwQ4WqyQsrq4dL6vbbcFGRk
Message-ID: <CAP-5=fUmoxMw9UkptfoMZUaSbLSnZ2hxJvYejMabyugLk_qYKQ@mail.gmail.com>
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

On Wed, Nov 19, 2025 at 9:29=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Nov 19, 2025 at 6:11=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > It's possible that some kernel samples don't have matching deferred
> > callchain records when the profiling session was ended before the
> > threads came back to userspace.  Let's flush the samples before
> > finish the session.
> >
> > Also 32-bit systems can see partial mmap for the data.  In that case,
> > deferred samples won't point to the correct data once the mapping moves
> > to the next portion of the file.  Copy the original sample before it
> > unmaps the current data.
>
> I think it is simpler to always copy. We may have events from
> synthesis, inject, .. and not the reader. Relying on callers to know
> that someone made a copy of the event and to make a defensive copy on
> their behalf just feels error prone.
>
> In the python session API I need to deal with the lifetime of events.
> Currently the events are copied:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n507
> and I'm doing this for session tool callbacks:
> https://lore.kernel.org/lkml/20251029053413.355154-12-irogers@google.com/
> I think it can be made lazier by knowing the tool callback can assume
> the event and sample are valid. We can delay the copying of the
> event/sample for if the pyevent has a reference count >1 and we're
> returning out of the tool callback. Doing some kind of global
> knowledge in the reader for maintaining the correctness of memory, I'm
> just not clear on how to make it always work.

I believe we always reuse the memory for the event, per event, in pipe mode=
:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/session.c?h=3Dperf-tools-next#n1868
so a lazy copy will be broken for the pipe mode case.

Thanks,
Ian

> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/session.c | 98 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 2e777fd1bcf6707b..b781e01ddcb4876b 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1288,8 +1288,13 @@ static int evlist__deliver_sample(struct evlist =
*evlist, const struct perf_tool
> >  struct deferred_event {
> >         struct list_head list;
> >         union perf_event *event;
> > +       bool allocated;
> >  };
> >
> > +/*
> > + * This is called when a deferred callchain record comes up.  Find all=
 matching
> > + * samples, merge the callchains and process them.
> > + */
> >  static int evlist__deliver_deferred_samples(struct evlist *evlist,
> >                                             const struct perf_tool *too=
l,
> >                                             union  perf_event *event,
> > @@ -1331,6 +1336,86 @@ static int evlist__deliver_deferred_samples(stru=
ct evlist *evlist,
> >                         free(orig_sample.callchain);
> >
> >                 list_del(&de->list);
> > +               if (de->allocated)
> > +                       free(de->event);
> > +               free(de);
> > +
> > +               if (ret)
> > +                       break;
> > +       }
> > +       return ret;
> > +}
> > +
> > +/*
> > + * This is called when the backing mmap is about to go away.  It needs=
 to save
> > + * the original sample data until it finds the matching deferred callc=
hains.
> > + */
> > +static void evlist__copy_deferred_samples(struct evlist *evlist,
> > +                                         const struct perf_tool *tool,
> > +                                         struct machine *machine)
> > +{
> > +       struct deferred_event *de, *tmp;
> > +       struct evsel *evsel;
> > +       int ret =3D 0;
> > +
> > +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, li=
st) {
> > +               struct perf_sample sample;
> > +               size_t sz =3D de->event->header.size;
> > +               void *buf;
> > +
> > +               if (de->allocated)
> > +                       continue;
> > +
> > +               buf =3D malloc(sz);
> > +               if (buf) {
> > +                       memcpy(buf, de->event, sz);
> > +                       de->event =3D buf;
> > +                       de->allocated =3D true;
> > +                       continue;
> > +               }
> > +
> > +               /* The allocation failed, flush the sample now */
> > +               ret =3D evlist__parse_sample(evlist, de->event, &sample=
);
> > +               if (ret =3D=3D 0) {
> > +                       evsel =3D evlist__id2evsel(evlist, sample.id);
> > +                       evlist__deliver_sample(evlist, tool, de->event,
> > +                                              &sample, evsel, machine)=
;
> > +               }
> > +
> > +               list_del(&de->list);
> > +               BUG_ON(de->allocated);
> > +               free(de);
> > +       }
> > +}
> > +
> > +/*
> > + * This is called at the end of the data processing for the session.  =
Flush the
> > + * remaining samples as there's no hope for matching deferred callchai=
ns.
> > + */
> > +static int evlist__flush_deferred_samples(struct evlist *evlist,
> > +                                         const struct perf_tool *tool,
> > +                                         struct machine *machine)
> > +{
> > +       struct deferred_event *de, *tmp;
> > +       struct evsel *evsel;
> > +       int ret =3D 0;
> > +
> > +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, li=
st) {
> > +               struct perf_sample sample;
> > +
> > +               ret =3D evlist__parse_sample(evlist, de->event, &sample=
);
> > +               if (ret < 0) {
> > +                       pr_err("failed to parse original sample\n");
> > +                       break;
> > +               }
> > +
> > +               evsel =3D evlist__id2evsel(evlist, sample.id);
> > +               ret =3D evlist__deliver_sample(evlist, tool, de->event,
> > +                                            &sample, evsel, machine);
> > +
> > +               list_del(&de->list);
> > +               if (de->allocated)
> > +                       free(de->event);
> >                 free(de);
> >
> >                 if (ret)
> > @@ -1374,6 +1459,7 @@ static int machines__deliver_event(struct machine=
s *machines,
> >                                 return -ENOMEM;
> >
> >                         de->event =3D event;
> > +                       de->allocated =3D false;
> >                         list_add_tail(&de->list, &evlist->deferred_samp=
les);
> >                         return 0;
> >                 }
> > @@ -2218,6 +2304,8 @@ reader__mmap(struct reader *rd, struct perf_sessi=
on *session)
> >         }
> >
> >         if (mmaps[rd->mmap_idx]) {
> > +               evlist__copy_deferred_samples(session->evlist, session-=
>tool,
> > +                                             &session->machines.host);
> >                 munmap(mmaps[rd->mmap_idx], rd->mmap_size);
> >                 mmaps[rd->mmap_idx] =3D NULL;
> >         }
> > @@ -2372,6 +2460,11 @@ static int __perf_session__process_events(struct=
 perf_session *session)
> >         if (err)
> >                 goto out_err;
> >         err =3D auxtrace__flush_events(session, tool);
> > +       if (err)
> > +               goto out_err;
> > +       err =3D evlist__flush_deferred_samples(session->evlist,
> > +                                            session->tool,
> > +                                            &session->machines.host);
> >         if (err)
> >                 goto out_err;
> >         err =3D perf_session__flush_thread_stacks(session);
> > @@ -2494,6 +2587,11 @@ static int __perf_session__process_dir_events(st=
ruct perf_session *session)
> >         if (ret)
> >                 goto out_err;
> >
> > +       ret =3D evlist__flush_deferred_samples(session->evlist, tool,
> > +                                            &session->machines.host);
> > +       if (ret)
> > +               goto out_err;
> > +
> >         ret =3D perf_session__flush_thread_stacks(session);
> >  out_err:
> >         ui_progress__finish();
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >

