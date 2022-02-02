Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1172B4A76C7
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiBBRYw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 12:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242514AbiBBRYw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 12:24:52 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087B1C061714;
        Wed,  2 Feb 2022 09:24:52 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so5151854oos.6;
        Wed, 02 Feb 2022 09:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9t7QkVp8oA8kn5whg9VqGlLwOpcqu0Z5d/Vyw0ND1g0=;
        b=VvIy5NiU1x6Xkaugb5NbaFWdmm0zdzXNbGx+nzxhqDcxuRNDKn7mrewVejYAHtA9KY
         +VkFRiWNvI3/IQaNqv66OGHaEBNACQa6h053aWCZ5CslJHJBornSEIttwKvTJS4kgHrV
         /jS4R//GNKnjuOaLhsxXtYZkHVGqq5noePCd12MZTK7wHCC9/l63aKC3f18HXEA9Ait6
         rvVCINURlRj+xHCYvd9MaBvGxgWScZ6SCq3Zy+5cXupTLt5CqkeEU/bfWSAkio3YvVIl
         85yi4iHjLoTqJBFR9dqea9tWvD/mX+twJt/zSq419XjOkfunaqu7ZrWF7OWwZpzmRf7G
         n7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9t7QkVp8oA8kn5whg9VqGlLwOpcqu0Z5d/Vyw0ND1g0=;
        b=xm/ViqqMDZg55Vb37i300dQ47bt4EILTHDSks5w74wYShv0UFNn5lS7MkFPivq4IWq
         72DymA6hz+O5kZydwTWqpEyT8+CfKEfoOUrLpNphbkDWRm1HsjdGOJKUepMe3snzAOg1
         B7lwQLF5nhxP/6MsMBl84vfARXgXjuFZjWbKDwpOcCYLKBkRU5kmCErjs+L9JmmsEgfB
         Zh89Eteyv3WF0ZXqN8hR4JrwXDp5DG3O/k0ULwW5WDgkJSvEIIWFqCAJrDwWVDt+3+wQ
         dCcFCNk3/twBLkMzhqG/gu+2ClCZ0lnItmCI8mUbZ3GV97Gp0QhPhKTJ6cv69FW0bJ65
         gSJQ==
X-Gm-Message-State: AOAM532Gj6OCUMKQderB0QJh1/M1srgTPdf4puGgAJuT4nL4ojHT/pWP
        HYz8hRIG84NlRk6lT4VinwZgIuqNJTFiXIz0mc4=
X-Google-Smtp-Source: ABdhPJzbB1/eC2bfhY7H5bxkcBN5WDlcChT+/InvaZZXvZED1VE1gpnyxrFHmJ2j9CxiveFXTCSej5+wBk1bW+F6XCI=
X-Received: by 2002:a4a:c98a:: with SMTP id u10mr15314894ooq.51.1643822691298;
 Wed, 02 Feb 2022 09:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20220119230636.1752684-1-christylee@fb.com> <20220119230636.1752684-3-christylee@fb.com>
 <Ye2LAEiXaBoj2n8Z@krava> <Yfq4o0Op4eYvFKIp@krava>
In-Reply-To: <Yfq4o0Op4eYvFKIp@krava>
From:   Christy Lee <christyc.y.lee@gmail.com>
Date:   Wed, 2 Feb 2022 09:24:40 -0800
Message-ID: <CAPqJDZpR0n2_VAPQNnpLoyAt_zO5b6XvSs0cO8X=kb3azOqg5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] perf: stop using deprecated
 bpf_object__next() API
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry, some other priorities came up. If it's urgent, please feel free
to commandeer this commit. Otherwise, I can get to it this weekend.

Christy

On Wed, Feb 2, 2022 at 9:00 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> hi,
> just checking, do you plan to send new version for this?
>
> thanks,
> jirka
>
> On Sun, Jan 23, 2022 at 06:06:08PM +0100, Jiri Olsa wrote:
> > On Wed, Jan 19, 2022 at 03:06:36PM -0800, Christy Lee wrote:
> >
> > SNIP
> >
> > > ---
> > >  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
> > >  tools/perf/util/bpf-loader.h |  1 +
> > >  2 files changed, 55 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > > index 4631cac3957f..b1822f8af2bb 100644
> > > --- a/tools/perf/util/bpf-loader.c
> > > +++ b/tools/perf/util/bpf-loader.c
> > > @@ -29,9 +29,6 @@
> > >
> > >  #include <internal/xyarray.h>
> > >
> > > -/* temporarily disable libbpf deprecation warnings */
> > > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > -
> > >  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
> > >                           const char *fmt, va_list args)
> > >  {
> > > @@ -49,6 +46,36 @@ struct bpf_prog_priv {
> > >     int *type_mapping;
> > >  };
> > >
> > > +struct bpf_perf_object {
> > > +   struct bpf_object *obj;
> > > +   struct list_head list;
> > > +};
> > > +
> > > +static LIST_HEAD(bpf_objects_list);
> >
> > hum.. I still can't see any code adding/removing bpf_perf_object
> > objects to this list, and that's why the code is failing to remove
> > probes
> >
> > because there are no objects to iterate on, so added probes stay
> > configured and screw following tests
> >
> > you need something like below to add and del objects from
> > bpf_objects_list list
> >
> > it also simplifies for_each macros to work just over perf_obj,
> > because I wasn't patient enough to make it work with the extra
> > bpf_object ;-) I don't mind if you fix that, but this way looks
> > simpler to me
> >
> > tests are working for me with this fix, please feel free to
> > squash it into your change
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> > index 57b9591f7cbb..d09d25707f1e 100644
> > --- a/tools/perf/tests/bpf.c
> > +++ b/tools/perf/tests/bpf.c
> > @@ -210,6 +210,11 @@ prepare_bpf(void *obj_buf, size_t obj_buf_sz, const char *name)
> >               pr_debug("Compile BPF program failed.\n");
> >               return NULL;
> >       }
> > +
> > +     if (bpf_perf_object__add(obj)) {
> > +             bpf_object__close(obj);
> > +             return NULL;
> > +     }
> >       return obj;
> >  }
> >
> > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > index 89e584ac267c..a7a8ad32c847 100644
> > --- a/tools/perf/util/bpf-loader.c
> > +++ b/tools/perf/util/bpf-loader.c
> > @@ -70,11 +70,11 @@ struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *prev)
> >       return next;
> >  }
> >
> > -#define bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
> > -     for ((perf_obj) = bpf_perf_object__next(NULL),                         \
> > -         (tmp) = bpf_perf_object__next(perf_obj), (obj) = NULL;             \
> > -          (perf_obj) != NULL; (perf_obj) = (tmp),                           \
> > -         (tmp) = bpf_perf_object__next(tmp), (obj) = (perf_obj)->obj)
> > +#define bpf_perf_object__for_each(perf_obj, tmp)         \
> > +     for ((perf_obj) = bpf_perf_object__next(NULL),   \
> > +          (tmp) = bpf_perf_object__next(perf_obj);    \
> > +          (perf_obj) != NULL; (perf_obj) = (tmp),     \
> > +         (tmp) = bpf_perf_object__next(tmp) )
> >
> >  static bool libbpf_initialized;
> >
> > @@ -97,6 +97,24 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
> >       return obj;
> >  }
> >
> > +int bpf_perf_object__add(struct bpf_object *obj)
> > +{
> > +     struct bpf_perf_object *perf_obj = zalloc(sizeof(*perf_obj));
> > +
> > +     if (perf_obj) {
> > +             perf_obj->obj = obj;
> > +             list_add_tail(&perf_obj->list, &bpf_objects_list);
> > +     }
> > +     return perf_obj ? 0 : -ENOMEM;
> > +}
> > +
> > +static void bpf_perf_object__close(struct bpf_perf_object *perf_obj)
> > +{
> > +     list_del(&perf_obj->list);
> > +     bpf_object__close(perf_obj->obj);
> > +     free(perf_obj);
> > +}
> > +
> >  struct bpf_object *bpf__prepare_load(const char *filename, bool source)
> >  {
> >       struct bpf_object *obj;
> > @@ -135,17 +153,20 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
> >               return obj;
> >       }
> >
> > +     if (bpf_perf_object__add(obj)) {
> > +             bpf_object__close(obj);
> > +             return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
> > +     }
> >       return obj;
> >  }
> >
> >  void bpf__clear(void)
> >  {
> >       struct bpf_perf_object *perf_obj, *tmp;
> > -     struct bpf_object *obj;
> >
> > -     bpf_perf_object__for_each(perf_obj, tmp, obj) {
> > -             bpf__unprobe(obj);
> > -             bpf_object__close(obj);
> > +     bpf_perf_object__for_each(perf_obj, tmp) {
> > +             bpf__unprobe(perf_obj->obj);
> > +             bpf_perf_object__close(perf_obj);
> >       }
> >  }
> >
> > @@ -1538,11 +1559,10 @@ apply_obj_config_object(struct bpf_object *obj)
> >  int bpf__apply_obj_config(void)
> >  {
> >       struct bpf_perf_object *perf_obj, *tmp;
> > -     struct bpf_object *obj;
> >       int err;
> >
> > -     bpf_perf_object__for_each(perf_obj, tmp, obj) {
> > -             err = apply_obj_config_object(obj);
> > +     bpf_perf_object__for_each(perf_obj, tmp) {
> > +             err = apply_obj_config_object(perf_obj->obj);
> >               if (err)
> >                       return err;
> >       }
> > @@ -1550,25 +1570,24 @@ int bpf__apply_obj_config(void)
> >       return 0;
> >  }
> >
> > -#define bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
> > -     bpf_perf_object__for_each(perf_obj, tmp, obj)                          \
> > -             bpf_object__for_each_map(map, obj)
> > +#define bpf__perf_for_each_map(perf_obj, tmp, map)                   \
> > +     bpf_perf_object__for_each(perf_obj, tmp)                     \
> > +             bpf_object__for_each_map(map, perf_obj->obj)
> >
> > -#define bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name)            \
> > -     bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        \
> > +#define bpf__perf_for_each_map_named(perf_obj, tmp, map, name)            \
> > +     bpf__perf_for_each_map(perf_obj, tmp, map)                        \
> >               if (bpf_map__name(map) && (strcmp(name, bpf_map__name(map)) == 0))
> >
> >  struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
> >  {
> >       struct bpf_map_priv *tmpl_priv = NULL;
> >       struct bpf_perf_object *perf_obj, *tmp;
> > -     struct bpf_object *obj;
> >       struct evsel *evsel = NULL;
> >       struct bpf_map *map;
> >       int err;
> >       bool need_init = false;
> >
> > -     bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
> > +     bpf__perf_for_each_map_named(perf_obj, tmp, map, name) {
> >               struct bpf_map_priv *priv = bpf_map__priv(map);
> >
> >               if (IS_ERR(priv))
> > @@ -1604,7 +1623,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
> >               evsel = evlist__last(evlist);
> >       }
> >
> > -     bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
> > +     bpf__perf_for_each_map_named(perf_obj, tmp, map, name) {
> >               struct bpf_map_priv *priv = bpf_map__priv(map);
> >
> >               if (IS_ERR(priv))
> > diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
> > index 95262b7e936f..78c7d3662910 100644
> > --- a/tools/perf/util/bpf-loader.h
> > +++ b/tools/perf/util/bpf-loader.h
> > @@ -83,6 +83,8 @@ int bpf__strerror_config_obj(struct bpf_object *obj,
> >  int bpf__apply_obj_config(void);
> >  int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
> >
> > +int bpf_perf_object__add(struct bpf_object *obj);
> > +
> >  int bpf__setup_stdout(struct evlist *evlist);
> >  struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name);
> >  int bpf__strerror_setup_output_event(struct evlist *evlist, int err, char *buf, size_t size);
>
