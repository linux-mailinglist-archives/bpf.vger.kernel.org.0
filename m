Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1604D6A49
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 00:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiCKXKP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 18:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiCKXKL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 18:10:11 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FC4145E2A
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:09:06 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i1so7034047ila.7
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxAW3+aFIecaAP1+8BQqLdGKWilpdDZDP956b91iHAw=;
        b=Sp2NjiUW/GKfZ0jfI1u5K7/ATMf4HpIXFjo5P0GkkgM/9rsXXmMvfXLfCsvk8+QhfO
         lRm1uJokbRTrZvipLujHMLlRlahgP3q3d575mAu+CeQesnZLfcmgc9lOebMQ13Fviv2M
         co1htwtzvr4UDe4Z3auEMMcB67/h2It5PIqYGggix1feUSk2LsBMxOArSm8R1X5eAPkX
         jYuJuZAFxfbAG/ENObSNs/c6LkwJgb6ggAsZ1wRlgCN0YVJ7CYOCOV210nJMFnzMBzML
         QfPeLLC2fYSELROuDhARvt5P32Koke0V+bGPg9GolGtx4p0hAMbDyKLDB5TRaHYnSMHC
         GUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxAW3+aFIecaAP1+8BQqLdGKWilpdDZDP956b91iHAw=;
        b=avhj/15WHikqtMmH8rIwEGKglLwGplYN8dP8sUlMppQMmP/gdlcomRYhu6/Pi17jri
         WEF+6DpHtfe1PKCwfwPrAHVlAGy6hCHhgTWwI9GMqpOdMgujzBPbAp8Xr1mWaGkMN/EC
         pSx8aYuJtoT7bvv+5853uyxnHIBJ4Cl3IrKd9OIAyd0/0va9KChLKakg4MVRGH0nHRf7
         D0epFtHaBKOy3CrdCwKnbgsV3m/j0xU3nxFOxRlW5eLAjD+xYjrImn2cCQEwhBjGKlqY
         bat3fcCN24BMGNMC1fIxEGmaAr2jZU9jf698h0IeJtRe5Mi1P+4woQZOCxC3FCeDxtF4
         PhaQ==
X-Gm-Message-State: AOAM530n4O71V3Xm1ynIJp2CDJZbICyRq5e9VYknRU4wyOyO9SvcELsy
        KNxlMU51zSf9f5bCfmgBPwCg7fwparwfMaNoUWzCfnR4kgE=
X-Google-Smtp-Source: ABdhPJyQc0UTwh11KdgFV4xHRB26DoJ0lU4ko+HVDTtjFnR9rFEKrCp6SzBGwsamihjfiTv0IupI48ZyWubLK/h1p/g=
X-Received: by 2002:a05:6e02:1a8e:b0:2c6:3b01:1ffe with SMTP id
 k14-20020a056e021a8e00b002c63b011ffemr9781485ilv.239.1647040145903; Fri, 11
 Mar 2022 15:09:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646957399.git.delyank@fb.com> <b7ab6736af3976a8739f0ed75feb4ca58f5e926f.1646957399.git.delyank@fb.com>
 <CAEf4BzYsTBZwwVrLHkEGJyBsNRKyGCBNJSk3xDAS2z8OT8FL6w@mail.gmail.com>
In-Reply-To: <CAEf4BzYsTBZwwVrLHkEGJyBsNRKyGCBNJSk3xDAS2z8OT8FL6w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Mar 2022 15:08:54 -0800
Message-ID: <CAEf4BzYPRs6wyAsZqcE7ga15Y1jtbNcAV+a+89vXNbW3ZFyEjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: add subskeleton scaffolding
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 11, 2022 at 2:52 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 10, 2022 at 4:12 PM Delyan Kratunov <delyank@fb.com> wrote:
> >
> > In symmetry with bpf_object__open_skeleton(),
> > bpf_object__open_subskeleton() performs the actual walking and linking
> > of maps, progs, and globals described by bpf_*_skeleton objects.
> >
> > Signed-off-by: Delyan Kratunov <delyank@fb.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 136 +++++++++++++++++++++++++++++++++------
> >  tools/lib/bpf/libbpf.h   |  29 +++++++++
> >  tools/lib/bpf/libbpf.map |   2 +
> >  3 files changed, 146 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 3fb9c926fe6e..ba7b25b11486 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11810,6 +11810,49 @@ int libbpf_num_possible_cpus(void)
> >         return tmp_cpus;
> >  }
> >
> > +static int populate_skeleton_maps(const struct bpf_object* obj,
> > +                                 struct bpf_map_skeleton* maps,
> > +                                 size_t map_cnt)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < map_cnt; i++) {
> > +               struct bpf_map **map = maps[i].map;
> > +               const char *name = maps[i].name;
> > +               void **mmaped = maps[i].mmaped;
> > +
> > +               *map = bpf_object__find_map_by_name(obj, name);
> > +               if (!*map) {
> > +                       pr_warn("failed to find skeleton map '%s'\n", name);
> > +                       return libbpf_err(-ESRCH);
>
> this is internal helper function, so no need (and it's a bit
> misleading as well) to use libbpf_err() helper. Just return an error
> and let user-facing API functions deal with error handling
>
> > +               }
> > +
> > +               /* externs shouldn't be pre-setup from user code */
> > +               if (mmaped && (*map)->libbpf_type != LIBBPF_MAP_KCONFIG)
> > +                       *mmaped = (*map)->mmaped;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int populate_skeleton_progs(const struct bpf_object* obj,
> > +                                  struct bpf_prog_skeleton* progs,
> > +                                  size_t prog_cnt)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < prog_cnt; i++) {
> > +               struct bpf_program **prog = progs[i].prog;
> > +               const char *name = progs[i].name;
> > +
> > +               *prog = bpf_object__find_program_by_name(obj, name);
> > +               if (!*prog) {
> > +                       pr_warn("failed to find skeleton program '%s'\n", name);
> > +                       return libbpf_err(-ESRCH);
>
> same about libbpf_err() use
>
> > +               }
> > +       }
> > +       return 0;
> > +}
> > +
> >  int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
> >                               const struct bpf_object_open_opts *opts)
> >  {
> > @@ -11817,7 +11860,7 @@ int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
> >                 .object_name = s->name,
> >         );
> >         struct bpf_object *obj;
> > -       int i, err;
> > +       int err;
> >
> >         /* Attempt to preserve opts->object_name, unless overriden by user
> >          * explicitly. Overwriting object name for skeletons is discouraged,
> > @@ -11840,37 +11883,88 @@ int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
> >         }
> >
> >         *s->obj = obj;
> > +       err = populate_skeleton_maps(obj, s->maps, s->map_cnt);
> > +       if (err) {
> > +               pr_warn("failed to populate skeleton maps for '%s': %d\n",
> > +                       s->name, err);
>
> nit: probably fits under 100 characters on single line
>
> > +               return libbpf_err(err);
> > +       }
> >
> > -       for (i = 0; i < s->map_cnt; i++) {
> > -               struct bpf_map **map = s->maps[i].map;
> > -               const char *name = s->maps[i].name;
> > -               void **mmaped = s->maps[i].mmaped;
> > +       err = populate_skeleton_progs(obj, s->progs, s->prog_cnt);
> > +       if (err) {
> > +               pr_warn("failed to populate skeleton progs for '%s': %d\n",
> > +                       s->name, err);
>
> and here
>
> > +               return libbpf_err(err);
> > +       }
> >
> > -               *map = bpf_object__find_map_by_name(obj, name);
> > -               if (!*map) {
> > -                       pr_warn("failed to find skeleton map '%s'\n", name);
> > -                       return libbpf_err(-ESRCH);
> > -               }
> > +       return 0;
> > +}
> >
> > -               /* externs shouldn't be pre-setup from user code */
> > -               if (mmaped && (*map)->libbpf_type != LIBBPF_MAP_KCONFIG)
> > -                       *mmaped = (*map)->mmaped;
> > +int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
> > +{
> > +       int err, len, var_idx, i;
> > +       const char *var_name;
> > +       const struct bpf_map *map;
> > +       struct btf *btf;
> > +       __u32 map_type_id;
> > +       const struct btf_type *map_type, *var_type;
> > +       const struct bpf_var_skeleton *var_skel;
> > +       struct btf_var_secinfo *var;
> > +
> > +       if (!s->obj)
> > +               return libbpf_err(-EINVAL);
> > +
> > +       btf = bpf_object__btf(s->obj);
> > +       if (!btf)
> > +               return -errno;
>
> use libbpf_err(-errno) for consistency?
>
> > +
> > +       err = populate_skeleton_maps(s->obj, s->maps, s->map_cnt);
> > +       if (err) {
> > +               pr_warn("failed to populate subskeleton maps: %d\n", err);
> > +               return libbpf_err(err);
> >         }
> >
> > -       for (i = 0; i < s->prog_cnt; i++) {
> > -               struct bpf_program **prog = s->progs[i].prog;
> > -               const char *name = s->progs[i].name;
> > +       err = populate_skeleton_progs(s->obj, s->progs, s->prog_cnt);
> > +       if (err) {
> > +               pr_warn("failed to populate subskeleton maps: %d\n", err);
> > +               return libbpf_err(err);
> > +       }
> >
> > -               *prog = bpf_object__find_program_by_name(obj, name);
> > -               if (!*prog) {
> > -                       pr_warn("failed to find skeleton program '%s'\n", name);
> > -                       return libbpf_err(-ESRCH);
> > +       for (var_idx = 0; var_idx < s->var_cnt; var_idx++) {
> > +               var_skel = &s->vars[var_idx];
> > +               map = *var_skel->map;
> > +               map_type_id = bpf_map__btf_value_type_id(map);
> > +               map_type = btf__type_by_id(btf, map_type_id);
> > +
>
> should we double-check that map_type is DATASEC?
>
> > +               len = btf_vlen(map_type);
> > +               var = btf_var_secinfos(map_type);
> > +               for (i = 0; i < len; i++, var++) {
> > +                       var_type = btf__type_by_id(btf, var->type);
> > +                       if (!var_type) {
>
> unless BTF itself is corrupted, this shouldn't ever happen. So
> checking for DATASEC should be enough and this if (!var_type) is
> redundant
>
> > +                               pr_warn("Could not find var type for item %1$d in section %2$s",
> > +                                       i, bpf_map__name(map));
> > +                               return libbpf_err(-EINVAL);
> > +                       }
> > +                       var_name = btf__name_by_offset(btf, var_type->name_off);
> > +                       if (strcmp(var_name, var_skel->name) == 0) {
> > +                               *var_skel->addr = (char *) map->mmaped + var->offset;
>
> is (char *) cast necessary? C allows pointer adjustment on void *, so
> shouldn't be

oh, wait, it's so that C++ compiler doesn't complain, never mind

>
> > +                               break;
> > +                       }
> >                 }
> >         }
> > -
> >         return 0;
> >  }
> >
>
> [...]
>
> >  struct gen_loader_opts {
> >         size_t sz; /* size of this struct, for forward/backward compatiblity */
> >         const char *data;
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index df1b947792c8..d744fbb8612e 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -442,6 +442,8 @@ LIBBPF_0.7.0 {
> >
> >  LIBBPF_0.8.0 {
> >         global:
> > +               bpf_object__open_subskeleton;
> > +               bpf_object__destroy_subskeleton;
>
> nit: should be in alphabetic order
>
> >                 libbpf_register_prog_handler;
> >                 libbpf_unregister_prog_handler;
> >  } LIBBPF_0.7.0;
> > --
> > 2.34.1
