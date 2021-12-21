Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4B47C8EF
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 22:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbhLUV60 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 16:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUV60 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 16:58:26 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC3CC061574;
        Tue, 21 Dec 2021 13:58:25 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id c3so368943iob.6;
        Tue, 21 Dec 2021 13:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZASVIBK/qYtP7TbvZbJC9S353QGDcMH4KZPgcDV5DQ=;
        b=FSSbZ2KKk1m0wX1wT7Y8lZAYhK/05ULNtHUhl0VsvCZ54SdsJFbBpoOUq/KSMwptoe
         Bwz8FG/SGjOKCkgmzZ7jghCHXfYsV539PHZa/alqqiueEXRrjsusDORSuve6RZC1Sz2f
         W8rxhL1BBFsi7VJgigAXYF870D2qbkM2bcB3OhNVTDpbfXihHBaP/jcJAOMYGdKXvi42
         ZvFw4Ru+RQhfRTTSe8UQT180NrSg9BUIfd056gXJBwyh5PL3Rdjs93fkn3mjhjvNObAn
         23XCGSq2cY8V4alxWklDlKgUBa1GDnH68OFDAvDjLsCErF0P9T1l3nsOPxGE1BWkmX57
         KbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZASVIBK/qYtP7TbvZbJC9S353QGDcMH4KZPgcDV5DQ=;
        b=VDixjImXFpV7wE0n1yITT1l0bZQQ5kQ0/F6GdCEVflXZOsN5MWSrB3QUwKLCOPwEoE
         tWGXwxO/9HEzXglmpjlnWGbI3tU/zCl/cOMDoNj9nsLXb6CJ8q8YOVelhIsEQe0Y8P3E
         xF6eP4RAsuv1iMKOGPiMLmpEtH4W+2uXoYpe0/3oPM+GPhG0BuBs5fFsbGyG6pnszKH3
         zTIPX0J2zG2Vuejv0km7ANp16LNcLwZbXO8vC8Ss0iv11R3A6Yh3T7sdT380IcBKJw5y
         uqCIG1CHCB85alhor554d3TvO/bVVIAh0/8ReQ+gjERw5yoKCofsSvFRXmepjK8/nlF6
         Psxw==
X-Gm-Message-State: AOAM532NVyfIb2NzdT9SJ33dqUE36eIhXbif+GJ9Pc6HI9omaCnnCszU
        wVGYzlv7OtXb8mCl4e31XwjqcgjYDDzhf03T1Pna0Onz
X-Google-Smtp-Source: ABdhPJyAqUYP5iC3o5Hs/GtgwA4naq3LrTSiwGejgkZnH+UX1qzngDgHujdrlluHO/CI351FTAog/HOKiV7nIYLJaOg=
X-Received: by 2002:a5d:9f01:: with SMTP id q1mr71995iot.144.1640123905245;
 Tue, 21 Dec 2021 13:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20211216222108.110518-1-christylee@fb.com> <20211216222108.110518-3-christylee@fb.com>
 <YcGO271nDvfMeSlK@krava>
In-Reply-To: <YcGO271nDvfMeSlK@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Dec 2021 13:58:14 -0800
Message-ID: <CAEf4BzZpNvEtfsVHUJGfwi_1xM+7-ohBPKPrRo--X=fYkYLrsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] perf: stop using deprecated
 bpf__object_next() API
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 21, 2021 at 12:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Dec 16, 2021 at 02:21:08PM -0800, Christy Lee wrote:
> > bpf__object_next is deprecated, track bpf_objects directly in
> > perf instead.
> >
> > Signed-off-by: Christy Lee <christylee@fb.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
> >  tools/perf/util/bpf-loader.h |  1 +
> >  2 files changed, 55 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > index 528aeb0ab79d..9e3988fd719a 100644
> > --- a/tools/perf/util/bpf-loader.c
> > +++ b/tools/perf/util/bpf-loader.c
> > @@ -29,9 +29,6 @@
> >
> >  #include <internal/xyarray.h>
> >
> > -/* temporarily disable libbpf deprecation warnings */
> > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > -
> >  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
> >                             const char *fmt, va_list args)
> >  {
> > @@ -49,6 +46,36 @@ struct bpf_prog_priv {
> >       int *type_mapping;
> >  };
> >
> > +struct bpf_perf_object {
> > +     struct bpf_object *obj;
> > +     struct list_head list;
> > +};
> > +
> > +static LIST_HEAD(bpf_objects_list);
>
> hum, so this duplicates libbpf's bpf_objects_list,
> how do objects get on this list?

yep, this list needs to be updated on perf side each time
bpf_object__open() (and any variant of open) is called.

>
> could you please put more comments in changelog
> and share how you tested this?

I actually have no idea how to test this as well, can you please share
some ideas?


BTW, while we are at it, Jiri, do you have any good ideas on how to
remove perf's usage of bpf_program__set_priv() and
bpf_program__set_prep() APIs in perf code base? These APIs are
deprecated as well, but seems like perf relies on them pretty heavily.
What would be the best way to stop using them?

For set_priv(), I think it should be totally fine to maintain a
separate lookup hash table by `struct bpf_program *` or its name, that
shouldn't be hard.

But for set_prep(), what does perf use it for? I assume for cloning
BPF programs, right? Anything else besides that? If it's just for
cloning, libbpf provides bpf_program__insns() API to get access to
underlying bpf_insn array, do you think it's possible to switch perf
to that instead?



>
> thanks,
> jirka
>
> > +
> > +struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *prev)
> > +{
> > +     struct bpf_perf_object *next;
> > +
> > +     if (!prev)
> > +             next = list_first_entry(&bpf_objects_list,
> > +                                     struct bpf_perf_object, list);
> > +     else
> > +             next = list_next_entry(prev, list);
> > +
> > +     /* Empty list is noticed here so don't need checking on entry. */
> > +     if (&next->list == &bpf_objects_list)
> > +             return NULL;
> > +
> > +     return next;
> > +}
> > +
> > +#define bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
> > +     for ((perf_obj) = bpf_perf_object__next(NULL),                         \
> > +         (tmp) = bpf_perf_object__next(perf_obj), (obj) = NULL;             \
> > +          (perf_obj) != NULL; (perf_obj) = (tmp),                           \
> > +         (tmp) = bpf_perf_object__next(tmp), (obj) = (perf_obj)->obj)
> > +
> >  static bool libbpf_initialized;
> >
> >  struct bpf_object *
> > @@ -113,9 +140,10 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
> >
> >  void bpf__clear(void)
> >  {
> > -     struct bpf_object *obj, *tmp;
> > +     struct bpf_perf_object *perf_obj, *tmp;
> > +     struct bpf_object *obj;
> >
> > -     bpf_object__for_each_safe(obj, tmp) {
> > +     bpf_perf_object__for_each(perf_obj, tmp, obj) {
> >               bpf__unprobe(obj);
> >               bpf_object__close(obj);
> >       }
> > @@ -621,8 +649,12 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> >       if (err)
> >               return err;
> >
> > +/* temporarily disable libbpf deprecation warnings */
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> >       err = bpf_program__set_prep(prog, priv->nr_types,
> >                                   preproc_gen_prologue);
> > +#pragma GCC diagnostic pop
> >       return err;
> >  }
> >
> > @@ -776,7 +808,11 @@ int bpf__foreach_event(struct bpf_object *obj,
> >                       if (priv->need_prologue) {
> >                               int type = priv->type_mapping[i];
> >
> > +/* temporarily disable libbpf deprecation warnings */
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> >                               fd = bpf_program__nth_fd(prog, type);
> > +#pragma GCC diagnostic pop
> >                       } else {
> >                               fd = bpf_program__fd(prog);
> >                       }
> > @@ -1498,10 +1534,11 @@ apply_obj_config_object(struct bpf_object *obj)
> >
> >  int bpf__apply_obj_config(void)
> >  {
> > -     struct bpf_object *obj, *tmp;
> > +     struct bpf_perf_object *perf_obj, *tmp;
> > +     struct bpf_object *obj;
> >       int err;
> >
> > -     bpf_object__for_each_safe(obj, tmp) {
> > +     bpf_perf_object__for_each(perf_obj, tmp, obj) {
> >               err = apply_obj_config_object(obj);
> >               if (err)
> >                       return err;
> > @@ -1510,26 +1547,25 @@ int bpf__apply_obj_config(void)
> >       return 0;
> >  }
> >
> > -#define bpf__for_each_map(pos, obj, objtmp)  \
> > -     bpf_object__for_each_safe(obj, objtmp)  \
> > -             bpf_object__for_each_map(pos, obj)
> > +#define bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
> > +     bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
> > +             bpf_object__for_each_map(map, obj)
> >
> > -#define bpf__for_each_map_named(pos, obj, objtmp, name)      \
> > -     bpf__for_each_map(pos, obj, objtmp)             \
> > -             if (bpf_map__name(pos) &&               \
> > -                     (strcmp(name,                   \
> > -                             bpf_map__name(pos)) == 0))
> > +#define bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name)            \
> > +     bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
> > +             if (bpf_map__name(map) && (strcmp(name, bpf_map__name(map)) == 0))
> >
> >  struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
> >  {
> >       struct bpf_map_priv *tmpl_priv = NULL;
> > -     struct bpf_object *obj, *tmp;
> > +     struct bpf_perf_object *perf_obj, *tmp;
> > +     struct bpf_object *obj;
> >       struct evsel *evsel = NULL;
> >       struct bpf_map *map;
> >       int err;
> >       bool need_init = false;
> >
> > -     bpf__for_each_map_named(map, obj, tmp, name) {
> > +     bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
> >               struct bpf_map_priv *priv = bpf_map__priv(map);
> >
> >               if (IS_ERR(priv))
> > @@ -1565,7 +1601,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
> >               evsel = evlist__last(evlist);
> >       }
> >
> > -     bpf__for_each_map_named(map, obj, tmp, name) {
> > +     bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
> >               struct bpf_map_priv *priv = bpf_map__priv(map);
> >
> >               if (IS_ERR(priv))
> > diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
> > index 5d1c725cea29..95262b7e936f 100644
> > --- a/tools/perf/util/bpf-loader.h
> > +++ b/tools/perf/util/bpf-loader.h
> > @@ -53,6 +53,7 @@ typedef int (*bpf_prog_iter_callback_t)(const char *group, const char *event,
> >
> >  #ifdef HAVE_LIBBPF_SUPPORT
> >  struct bpf_object *bpf__prepare_load(const char *filename, bool source);
> > +struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *prev);
> >  int bpf__strerror_prepare_load(const char *filename, bool source,
> >                              int err, char *buf, size_t size);
> >
> > --
> > 2.30.2
> >
>
