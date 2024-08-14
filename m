Return-Path: <bpf+bounces-37193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E10952073
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 18:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865CB1C2331C
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6981BA891;
	Wed, 14 Aug 2024 16:51:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF01B3F0E;
	Wed, 14 Aug 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654283; cv=none; b=aRRzq0/D7l13uJ3z6bw4HKlM77ZNUZgcNWAT7L94I0rzLKO9/uYwnKNfMKaKLQnrGhYmrS8KkYXqQ2CkRFGQSQmJbX2qsigzjbW66FhfkgicVT4MqFOXWIcz4Ixmj5m2sUYMm/jRSLHQ16MTlZyLPzeaxkdj9ffP17OZgZLiYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654283; c=relaxed/simple;
	bh=/+Jj6AwRi0cOqIQ+weRWqcy8rjcBHsJ2Bpv7eiiC4sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOpJChrzERM7BCeXMNF4O0MR5ISyT8hvaz3fzXOFQMvZIF12eI10MgyRCZkxnO9LZEtiaRttslfoWITa7GH2OlvGvCHiltPmp0N8ClY5WHm1Vv8d8j+aIk4WV7+J9WG88o1WxIdjvkuBhtD5wLcQbgBJJjd+cPxTOQozkYD+inE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cfdc4deeecso5093608a91.3;
        Wed, 14 Aug 2024 09:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654280; x=1724259080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGqUvaCbbE1LrXAAu5TDSSvO9gkkldxB1vMnvwmvTbQ=;
        b=Vdou5jnbUQA96kMGSbZ0TMRowOv5bqIRM+pglTRAunFYKRQUDJx335Y17YfPnCNefr
         dEXudipQqMPMDFFBWvqnJRVOvD1S5MtpZyTvJWDOoAkztqTKiC8X5DlNzA2nQMU7CbNc
         rgrdRyys+9BkugHd0iLq9UsdNKEbPsuEfJBVciKPn43BdR0i6wFzHsZq4M3W7b8eaZPT
         oiRfFGoujK3ReaxBchFZRD60ioV/e82je7CN/DTvhq3VHA9pqaLUQMvKR4xNzTnWiw6f
         jdSTWVW07HLI7ZMPtMdHxY5h0VJMlTVqdGcYI5MdkPxWcLubBiXdq6UjIoTXm6XGxhne
         kLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwiRRYVb9olbkM8jLF530N7rFMHYaZbXMt3yyBGng7UyGfRQm6Tz6YHd/Giq0TQPoIKX8PEZrddOHdlYrn3IEzIIbmxQlHRaR620MB80/+rFi01zGCdkN60AudYuo8pj/Ul6t5po3E7b53IaD7ZfDk7CU7zg8nd2cfi7NY9DZy5QQMEA==
X-Gm-Message-State: AOJu0YwCgk6nR5U7WQuTJKXyJb48xxHo35GfBRqqanzTqFoB0XsO65DM
	R+KdtJikCJpazlDnu+lSQ8jUn5xB9/xiDfipWgCzX50ZOdhyJRYEIKFc+/QIeGqzx2/dSKev7rv
	Mu2AbZfwtUcWpYzTquwLTo7KVsVQ=
X-Google-Smtp-Source: AGHT+IHN20OmmIA0mTVBsQaK5TcJP8oOUtxlc26OJoh6E0A2CDZr43Pi4iL7wMzkHsYC48712R9UkxiesUam2yMzndg=
X-Received: by 2002:a17:90a:9e5:b0:2cd:5d13:40ba with SMTP id
 98e67ed59e1d1-2d3aaa9934dmr3998410a91.14.1723654279677; Wed, 14 Aug 2024
 09:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813234117.2265235-1-namhyung@kernel.org> <ZrzcgE_GEzWbPOcQ@x1>
In-Reply-To: <ZrzcgE_GEzWbPOcQ@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 14 Aug 2024 09:51:07 -0700
Message-ID: <CAM9d7cipmhztFZkffd6dreO7CP7-NMYyo7Awr_11NZgENn9ECQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf bpf-filter: Support multiple events properly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 9:34=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Aug 13, 2024 at 04:41:16PM -0700, Namhyung Kim wrote:
> > So far it used tgid as a key to get the filter expressions in the
> > pinned filters map for regular users but it won't work well if the has
> > more than one filters at the same time.  Let's add the event id to the
> > key of the filter hash map so that it can identify the right filter
> > expression in the BPF program.
> >
> > As the event can be inherited to child tasks, it should use the primary
> > id which belongs to the parent (original) event.  Since evsel opens the
> > event for multiple CPUs and tasks, it needs to maintain a separate hash
> > map for the event id.
> >
> > In the user space, it keeps a list for the multiple evsel and release
> > the entries in the both hash map when it closes the event.
>
> Can you please provide an example of a command that uses this feature?
>
> Or if there is a 'perf test' shell for this already please point it out,

Sorry, please try:

  sudo ./perf record -e cycles --filter 'ip < 0xffffffff00000000' -e
instructions --filter 'period < 100000' -o- ./perf test -w noploop |
./perf script -i-

It's on the second patch.  I'll update the test as well.

Thanks,
Namhyung

>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/bpf-filter.c                 | 288 ++++++++++++++++---
> >  tools/perf/util/bpf_skel/sample-filter.h     |  11 +-
> >  tools/perf/util/bpf_skel/sample_filter.bpf.c |  42 ++-
> >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h   |   5 +
> >  4 files changed, 304 insertions(+), 42 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.=
c
> > index c5eb0b7eec19..0a1832564dd2 100644
> > --- a/tools/perf/util/bpf-filter.c
> > +++ b/tools/perf/util/bpf-filter.c
> > @@ -1,4 +1,45 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > +/**
> > + * Generic event filter for sampling events in BPF.
> > + *
> > + * The BPF program is fixed and just to read filter expressions in the=
 'filters'
> > + * map and compare the sample data in order to reject samples that don=
't match.
> > + * Each filter expression contains a sample flag (term) to compare, an=
 operation
> > + * (=3D=3D, >=3D, and so on) and a value.
> > + *
> > + * Note that each entry has an array of filter expressions and it only=
 succeeds
> > + * when all of the expressions are satisfied.  But it supports the log=
ical OR
> > + * using a GROUP operation which is satisfied when any of its member e=
xpression
> > + * is evaluated to true.  But it doesn't allow nested GROUP operations=
 for now.
> > + *
> > + * To support non-root users, the filters map can be loaded and pinned=
 in the BPF
> > + * filesystem by root (perf record --setup-filter pin).  Then each use=
r will get
> > + * a new entry in the shared filters map to fill the filter expression=
s.  And the
> > + * BPF program will find the filter using (task-id, event-id) as a key=
.
> > + *
> > + * The pinned BPF object (shared for regular users) has:
> > + *
> > + *                  event_hash                   |
> > + *                  |        |                   |
> > + *   event->id ---> |   id   | ---+   idx_hash   |     filters
> > + *                  |        |    |   |      |   |    |       |
> > + *                  |  ....  |    +-> |  idx | --+--> | exprs | --->  =
perf_bpf_filter_entry[]
> > + *                                |   |      |   |    |       |       =
        .op
> > + *   task id (tgid) --------------+   | .... |   |    |  ...  |       =
        .term (+ part)
> > + *                                               |                    =
        .value
> > + *                                               |
> > + *   =3D=3D=3D=3D=3D=3D=3D (root would skip this part) =3D=3D=3D=3D=3D=
=3D=3D=3D                     (compares it in a loop)
> > + *
> > + * This is used for per-task use cases while system-wide profiling (no=
rmally from
> > + * root user) uses a separate copy of the program and the maps for its=
 own so that
> > + * it can proceed even if a lot of non-root users are using the filter=
s at the
> > + * same time.  In this case the filters map has a single entry and no =
need to use
> > + * the hash maps to get the index (key) of the filters map (IOW it's a=
lways 0).
> > + *
> > + * The BPF program returns 1 to accept the sample or 0 to drop it.
> > + * The 'dropped' map is to keep how many samples it dropped by the fil=
ter and
> > + * it will be reported as lost samples.
> > + */
> >  #include <stdlib.h>
> >  #include <fcntl.h>
> >  #include <sys/ioctl.h>
> > @@ -6,6 +47,7 @@
> >
> >  #include <bpf/bpf.h>
> >  #include <linux/err.h>
> > +#include <linux/list.h>
> >  #include <api/fs/fs.h>
> >  #include <internal/xyarray.h>
> >  #include <perf/threadmap.h>
> > @@ -27,7 +69,14 @@
> >  #define PERF_SAMPLE_TYPE(_st, opt)   __PERF_SAMPLE_TYPE(PBF_TERM_##_st=
, PERF_SAMPLE_##_st, opt)
> >
> >  /* Index in the pinned 'filters' map.  Should be released after use. *=
/
> > -static int pinned_filter_idx =3D -1;
> > +struct pinned_filter_idx {
> > +     struct list_head list;
> > +     struct evsel *evsel;
> > +     u64 event_id;
> > +     int hash_idx;
> > +};
> > +
> > +static LIST_HEAD(pinned_filters);
> >
> >  static const struct perf_sample_info {
> >       enum perf_bpf_filter_term type;
> > @@ -175,24 +224,145 @@ static int convert_to_tgid(int tid)
> >       return tgid;
> >  }
> >
> > -static int update_pid_hash(struct evsel *evsel, struct perf_bpf_filter=
_entry *entry)
> > +/*
> > + * The event might be closed already so we cannot get the list of ids =
using FD
> > + * like in create_event_hash() below, let's iterate the event_hash map=
 and
> > + * delete all entries that have the event id as a key.
> > + */
> > +static void destroy_event_hash(u64 event_id)
> > +{
> > +     int fd;
> > +     u64 key, *prev_key =3D NULL;
> > +     int num =3D 0, alloced =3D 32;
> > +     u64 *ids =3D calloc(alloced, sizeof(*ids));
> > +
> > +     if (ids =3D=3D NULL)
> > +             return;
> > +
> > +     fd =3D get_pinned_fd("event_hash");
> > +     if (fd < 0) {
> > +             pr_debug("cannot get fd for 'event_hash' map\n");
> > +             free(ids);
> > +             return;
> > +     }
> > +
> > +     /* Iterate the whole map to collect keys for the event id. */
> > +     while (!bpf_map_get_next_key(fd, prev_key, &key)) {
> > +             u64 id;
> > +
> > +             if (bpf_map_lookup_elem(fd, &key, &id) =3D=3D 0 && id =3D=
=3D event_id) {
> > +                     if (num =3D=3D alloced) {
> > +                             void *tmp;
> > +
> > +                             alloced *=3D 2;
> > +                             tmp =3D realloc(ids, alloced * sizeof(*id=
s));
> > +                             if (tmp =3D=3D NULL)
> > +                                     break;
> > +
> > +                             ids =3D tmp;
> > +                     }
> > +                     ids[num++] =3D key;
> > +             }
> > +
> > +             prev_key =3D &key;
> > +     }
> > +
> > +     for (int i =3D 0; i < num; i++)
> > +             bpf_map_delete_elem(fd, &ids[i]);
> > +
> > +     free(ids);
> > +     close(fd);
> > +}
> > +
> > +/*
> > + * Return a representative id if ok, or 0 for failures.
> > + *
> > + * The perf_event->id is good for this, but an evsel would have multip=
le
> > + * instances for CPUs and tasks.  So pick up the first id and setup a =
hash
> > + * from id of each instance to the representative id (the first one).
> > + */
> > +static u64 create_event_hash(struct evsel *evsel)
> > +{
> > +     int x, y, fd;
> > +     u64 the_id =3D 0, id;
> > +
> > +     fd =3D get_pinned_fd("event_hash");
> > +     if (fd < 0) {
> > +             pr_err("cannot get fd for 'event_hash' map\n");
> > +             return 0;
> > +     }
> > +
> > +     for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
> > +             for (y =3D 0; y < xyarray__max_y(evsel->core.fd); y++) {
> > +                     int ret =3D ioctl(FD(evsel, x, y), PERF_EVENT_IOC=
_ID, &id);
> > +
> > +                     if (ret < 0) {
> > +                             pr_err("Failed to get the event id\n");
> > +                             if (the_id)
> > +                                     destroy_event_hash(the_id);
> > +                             return 0;
> > +                     }
> > +
> > +                     if (the_id =3D=3D 0)
> > +                             the_id =3D id;
> > +
> > +                     bpf_map_update_elem(fd, &id, &the_id, BPF_ANY);
> > +             }
> > +     }
> > +
> > +     close(fd);
> > +     return the_id;
> > +}
> > +
> > +static void destroy_idx_hash(struct pinned_filter_idx *pfi)
> > +{
> > +     int fd, nr;
> > +     struct perf_thread_map *threads;
> > +
> > +     fd =3D get_pinned_fd("filters");
> > +     bpf_map_delete_elem(fd, &pfi->hash_idx);
> > +     close(fd);
> > +
> > +     if (pfi->event_id)
> > +             destroy_event_hash(pfi->event_id);
> > +
> > +     threads =3D perf_evsel__threads(&pfi->evsel->core);
> > +     if (threads =3D=3D NULL)
> > +             return;
> > +
> > +     fd =3D get_pinned_fd("idx_hash");
> > +     nr =3D perf_thread_map__nr(threads);
> > +     for (int i =3D 0; i < nr; i++) {
> > +             /* The target task might be dead already, just try the pi=
d */
> > +             struct idx_hash_key key =3D {
> > +                     .evt_id =3D pfi->event_id,
> > +                     .tgid =3D perf_thread_map__pid(threads, i),
> > +             };
> > +
> > +             bpf_map_delete_elem(fd, &key);
> > +     }
> > +     close(fd);
> > +}
> > +
> > +/* Maintain a hashmap from (tgid, event-id) to filter index */
> > +static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter=
_entry *entry)
> >  {
> >       int filter_idx;
> >       int fd, nr, last;
> > +     u64 event_id =3D 0;
> > +     struct pinned_filter_idx *pfi =3D NULL;
> >       struct perf_thread_map *threads;
> >
> >       fd =3D get_pinned_fd("filters");
> >       if (fd < 0) {
> > -             pr_debug("cannot get fd for 'filters' map\n");
> > +             pr_err("cannot get fd for 'filters' map\n");
> >               return fd;
> >       }
> >
> >       /* Find the first available entry in the filters map */
> >       for (filter_idx =3D 0; filter_idx < MAX_FILTERS; filter_idx++) {
> > -             if (bpf_map_update_elem(fd, &filter_idx, entry, BPF_NOEXI=
ST) =3D=3D 0) {
> > -                     pinned_filter_idx =3D filter_idx;
> > +             if (bpf_map_update_elem(fd, &filter_idx, entry, BPF_NOEXI=
ST) =3D=3D 0)
> >                       break;
> > -             }
> >       }
> >       close(fd);
> >
> > @@ -201,22 +371,44 @@ static int update_pid_hash(struct evsel *evsel, s=
truct perf_bpf_filter_entry *en
> >               return -EBUSY;
> >       }
> >
> > +     pfi =3D zalloc(sizeof(*pfi));
> > +     if (pfi =3D=3D NULL) {
> > +             pr_err("Cannot save pinned filter index\n");
> > +             goto err;
> > +     }
> > +
> > +     pfi->evsel =3D evsel;
> > +     pfi->hash_idx =3D filter_idx;
> > +
> > +     event_id =3D create_event_hash(evsel);
> > +     if (event_id =3D=3D 0) {
> > +             pr_err("Cannot update the event hash\n");
> > +             goto err;
> > +     }
> > +
> > +     pfi->event_id =3D event_id;
> > +
> >       threads =3D perf_evsel__threads(&evsel->core);
> >       if (threads =3D=3D NULL) {
> >               pr_err("Cannot get the thread list of the event\n");
> > -             return -EINVAL;
> > +             goto err;
> >       }
> >
> >       /* save the index to a hash map */
> > -     fd =3D get_pinned_fd("pid_hash");
> > -     if (fd < 0)
> > -             return fd;
> > +     fd =3D get_pinned_fd("idx_hash");
> > +     if (fd < 0) {
> > +             pr_err("cannot get fd for 'idx_hash' map\n");
> > +             goto err;
> > +     }
> >
> >       last =3D -1;
> >       nr =3D perf_thread_map__nr(threads);
> >       for (int i =3D 0; i < nr; i++) {
> >               int pid =3D perf_thread_map__pid(threads, i);
> >               int tgid;
> > +             struct idx_hash_key key =3D {
> > +                     .evt_id =3D event_id,
> > +             };
> >
> >               /* it actually needs tgid, let's get tgid from /proc. */
> >               tgid =3D convert_to_tgid(pid);
> > @@ -228,16 +420,25 @@ static int update_pid_hash(struct evsel *evsel, s=
truct perf_bpf_filter_entry *en
> >               if (tgid =3D=3D last)
> >                       continue;
> >               last =3D tgid;
> > +             key.tgid =3D tgid;
> >
> > -             if (bpf_map_update_elem(fd, &tgid, &filter_idx, BPF_ANY) =
< 0) {
> > -                     pr_err("Failed to update the pid hash\n");
> > +             if (bpf_map_update_elem(fd, &key, &filter_idx, BPF_ANY) <=
 0) {
> > +                     pr_err("Failed to update the idx_hash\n");
> >                       close(fd);
> > -                     return -1;
> > +                     goto err;
> >               }
> > -             pr_debug("pid hash: %d -> %d\n", tgid, filter_idx);
> > +             pr_debug("bpf-filter: idx_hash (task=3D%d,%s) -> %d\n",
> > +                      tgid, evsel__name(evsel), filter_idx);
> >       }
> > +
> > +     list_add(&pfi->list, &pinned_filters);
> >       close(fd);
> > -     return 0;
> > +     return filter_idx;
> > +
> > +err:
> > +     destroy_idx_hash(pfi);
> > +     free(pfi);
> > +     return -1;
> >  }
> >
> >  int perf_bpf_filter__prepare(struct evsel *evsel, struct target *targe=
t)
> > @@ -247,7 +448,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, s=
truct target *target)
> >       struct bpf_program *prog;
> >       struct bpf_link *link;
> >       struct perf_bpf_filter_entry *entry;
> > -     bool needs_pid_hash =3D !target__has_cpu(target) && !target->uid_=
str;
> > +     bool needs_idx_hash =3D !target__has_cpu(target) && !target->uid_=
str;
> >
> >       entry =3D calloc(MAX_FILTERS, sizeof(*entry));
> >       if (entry =3D=3D NULL)
> > @@ -259,11 +460,11 @@ int perf_bpf_filter__prepare(struct evsel *evsel,=
 struct target *target)
> >               goto err;
> >       }
> >
> > -     if (needs_pid_hash && geteuid() !=3D 0) {
> > +     if (needs_idx_hash && geteuid() !=3D 0) {
> >               int zero =3D 0;
> >
> >               /* The filters map is shared among other processes */
> > -             ret =3D update_pid_hash(evsel, entry);
> > +             ret =3D create_idx_hash(evsel, entry);
> >               if (ret < 0)
> >                       goto err;
> >
> > @@ -274,7 +475,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, s=
truct target *target)
> >               }
> >
> >               /* Reset the lost count */
> > -             bpf_map_update_elem(fd, &pinned_filter_idx, &zero, BPF_AN=
Y);
> > +             bpf_map_update_elem(fd, &ret, &zero, BPF_ANY);
> >               close(fd);
> >
> >               fd =3D get_pinned_fd("perf_sample_filter");
> > @@ -288,6 +489,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, s=
truct target *target)
> >                               ret =3D ioctl(FD(evsel, x, y), PERF_EVENT=
_IOC_SET_BPF, fd);
> >                               if (ret < 0) {
> >                                       pr_err("Failed to attach perf sam=
ple-filter\n");
> > +                                     close(fd);
> >                                       goto err;
> >                               }
> >                       }
> > @@ -332,6 +534,15 @@ int perf_bpf_filter__prepare(struct evsel *evsel, =
struct target *target)
> >
> >  err:
> >       free(entry);
> > +     if (!list_empty(&pinned_filters)) {
> > +             struct pinned_filter_idx *pfi, *tmp;
> > +
> > +             list_for_each_entry_safe(pfi, tmp, &pinned_filters, list)=
 {
> > +                     destroy_idx_hash(pfi);
> > +                     list_del(&pfi->list);
> > +                     free(pfi);
> > +             }
> > +     }
> >       sample_filter_bpf__destroy(skel);
> >       return ret;
> >  }
> > @@ -339,6 +550,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, s=
truct target *target)
> >  int perf_bpf_filter__destroy(struct evsel *evsel)
> >  {
> >       struct perf_bpf_filter_expr *expr, *tmp;
> > +     struct pinned_filter_idx *pfi, *pos;
> >
> >       list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
> >               list_del(&expr->list);
> > @@ -346,14 +558,11 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
> >       }
> >       sample_filter_bpf__destroy(evsel->bpf_skel);
> >
> > -     if (pinned_filter_idx >=3D 0) {
> > -             int fd =3D get_pinned_fd("filters");
> > -
> > -             bpf_map_delete_elem(fd, &pinned_filter_idx);
> > -             pinned_filter_idx =3D -1;
> > -             close(fd);
> > +     list_for_each_entry_safe(pfi, pos, &pinned_filters, list) {
> > +             destroy_idx_hash(pfi);
> > +             list_del(&pfi->list);
> > +             free(pfi);
> >       }
> > -
> >       return 0;
> >  }
> >
> > @@ -364,10 +573,20 @@ u64 perf_bpf_filter__lost_count(struct evsel *evs=
el)
> >       if (list_empty(&evsel->bpf_filters))
> >               return 0;
> >
> > -     if (pinned_filter_idx >=3D 0) {
> > +     if (!list_empty(&pinned_filters)) {
> >               int fd =3D get_pinned_fd("dropped");
> > +             struct pinned_filter_idx *pfi;
> > +
> > +             if (fd < 0)
> > +                     return 0;
> >
> > -             bpf_map_lookup_elem(fd, &pinned_filter_idx, &count);
> > +             list_for_each_entry(pfi, &pinned_filters, list) {
> > +                     if (pfi->evsel !=3D evsel)
> > +                             continue;
> > +
> > +                     bpf_map_lookup_elem(fd, &pfi->hash_idx, &count);
> > +                     break;
> > +             }
> >               close(fd);
> >       } else if (evsel->bpf_skel) {
> >               struct sample_filter_bpf *skel =3D evsel->bpf_skel;
> > @@ -429,9 +648,10 @@ int perf_bpf_filter__pin(void)
> >
> >       /* pinned program will use pid-hash */
> >       bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
> > -     bpf_map__set_max_entries(skel->maps.pid_hash, MAX_PIDS);
> > +     bpf_map__set_max_entries(skel->maps.event_hash, MAX_EVT_HASH);
> > +     bpf_map__set_max_entries(skel->maps.idx_hash, MAX_IDX_HASH);
> >       bpf_map__set_max_entries(skel->maps.dropped, MAX_FILTERS);
> > -     skel->rodata->use_pid_hash =3D 1;
> > +     skel->rodata->use_idx_hash =3D 1;
> >
> >       if (sample_filter_bpf__load(skel) < 0) {
> >               ret =3D -errno;
> > @@ -484,8 +704,12 @@ int perf_bpf_filter__pin(void)
> >               pr_debug("chmod for filters failed\n");
> >               ret =3D -errno;
> >       }
> > -     if (fchmodat(dir_fd, "pid_hash", 0666, 0) < 0) {
> > -             pr_debug("chmod for pid_hash failed\n");
> > +     if (fchmodat(dir_fd, "event_hash", 0666, 0) < 0) {
> > +             pr_debug("chmod for event_hash failed\n");
> > +             ret =3D -errno;
> > +     }
> > +     if (fchmodat(dir_fd, "idx_hash", 0666, 0) < 0) {
> > +             pr_debug("chmod for idx_hash failed\n");
> >               ret =3D -errno;
> >       }
> >       if (fchmodat(dir_fd, "dropped", 0666, 0) < 0) {
> > diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util=
/bpf_skel/sample-filter.h
> > index e666bfd5fbdd..5f0c8e4e83d3 100644
> > --- a/tools/perf/util/bpf_skel/sample-filter.h
> > +++ b/tools/perf/util/bpf_skel/sample-filter.h
> > @@ -1,8 +1,9 @@
> >  #ifndef PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
> >  #define PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
> >
> > -#define MAX_FILTERS  64
> > -#define MAX_PIDS     (16 * 1024)
> > +#define MAX_FILTERS   64
> > +#define MAX_IDX_HASH  (16 * 1024)
> > +#define MAX_EVT_HASH  (1024 * 1024)
> >
> >  /* supported filter operations */
> >  enum perf_bpf_filter_op {
> > @@ -62,4 +63,10 @@ struct perf_bpf_filter_entry {
> >       __u64 value;
> >  };
> >
> > +struct idx_hash_key {
> > +     __u64 evt_id;
> > +     __u32 tgid;
> > +     __u32 reserved;
> > +};
> > +
> >  #endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
> > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/=
util/bpf_skel/sample_filter.bpf.c
> > index 4c75354b84fd..4872a16eedfd 100644
> > --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > @@ -15,13 +15,25 @@ struct filters {
> >       __uint(max_entries, 1);
> >  } filters SEC(".maps");
> >
> > -/* tgid to filter index */
> > -struct pid_hash {
> > +/*
> > + * An evsel has multiple instances for each CPU or task but we need a =
single
> > + * id to be used as a key for the idx_hash.  This hashmap would transl=
ate the
> > + * instance's ID to a representative ID.
> > + */
> > +struct event_hash {
> >       __uint(type, BPF_MAP_TYPE_HASH);
> > -     __type(key, int);
> > +     __type(key, __u64);
> > +     __type(value, __u64);
> > +     __uint(max_entries, 1);
> > +} event_hash SEC(".maps");
> > +
> > +/* tgid/evtid to filter index */
> > +struct idx_hash {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __type(key, struct idx_hash_key);
> >       __type(value, int);
> >       __uint(max_entries, 1);
> > -} pid_hash SEC(".maps");
> > +} idx_hash SEC(".maps");
> >
> >  /* tgid to filter index */
> >  struct lost_count {
> > @@ -31,7 +43,7 @@ struct lost_count {
> >       __uint(max_entries, 1);
> >  } dropped SEC(".maps");
> >
> > -volatile const int use_pid_hash;
> > +volatile const int use_idx_hash;
> >
> >  void *bpf_cast_to_kern_ctx(void *) __ksym;
> >
> > @@ -202,11 +214,25 @@ int perf_sample_filter(void *ctx)
> >
> >       k =3D 0;
> >
> > -     if (use_pid_hash) {
> > -             int tgid =3D bpf_get_current_pid_tgid() >> 32;
> > +     if (use_idx_hash) {
> > +             struct idx_hash_key key =3D {
> > +                     .tgid =3D bpf_get_current_pid_tgid() >> 32,
> > +             };
> > +             __u64 eid =3D kctx->event->id;
> > +             __u64 *key_id;
> >               int *idx;
> >
> > -             idx =3D bpf_map_lookup_elem(&pid_hash, &tgid);
> > +             /* get primary_event_id */
> > +             if (kctx->event->parent)
> > +                     eid =3D kctx->event->parent->id;
> > +
> > +             key_id =3D bpf_map_lookup_elem(&event_hash, &eid);
> > +             if (key_id =3D=3D NULL)
> > +                     goto drop;
> > +
> > +             key.evt_id =3D *key_id;
> > +
> > +             idx =3D bpf_map_lookup_elem(&idx_hash, &key);
> >               if (idx)
> >                       k =3D *idx;
> >               else
> > diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/ut=
il/bpf_skel/vmlinux/vmlinux.h
> > index d818e30c5457..4fa21468487e 100644
> > --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > @@ -175,6 +175,11 @@ struct perf_sample_data {
> >       u64                      code_page_size;
> >  } __attribute__((__aligned__(64))) __attribute__((preserve_access_inde=
x));
> >
> > +struct perf_event {
> > +     struct perf_event       *parent;
> > +     u64                     id;
> > +} __attribute__((preserve_access_index));
> > +
> >  struct bpf_perf_event_data_kern {
> >       struct perf_sample_data *data;
> >       struct perf_event       *event;
> > --
> > 2.46.0.76.ge559c4bf1a-goog

