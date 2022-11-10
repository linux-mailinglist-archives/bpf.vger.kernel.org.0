Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E765862425D
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 13:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiKJM2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 07:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKJM2K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 07:28:10 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C4F7B
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 04:28:08 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m22so4491866eji.10
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 04:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nJRVimmRcUS8lstGa1rS3X+b69/P7Zxwb/tmGoNNSgE=;
        b=OsZq6QDLVAJDIJNlVooDSdk8RfGqcH6e+D9QvkazP/X35JTWn5Sp3lNnhTgramgtMJ
         pb0ELe/LIcp1aX12h/V0C4Lu5hFi0gLgpGyM7vVyx6sW1LO6ZAKb4aiAD+jxgkHmnd3G
         DGJ8cQou0rPfESS+FnjkWLCwTuwvShWDIOSmTZEpnX3X00ARs7EqZV4thdazSTj9Z9KT
         J3VW/m1QOCZwe2fp8amLMrZSRAwtP+/EGngQ+D2a+bV4BwvvsAm1MSmJ1Wj8J7x8lu3c
         5zOjgCC+WxWgcqi5zAwcGjDZ2y8oWYc9xI5dmniy9Xal7bmeKevLp3vupuBAwooIS0ru
         nA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJRVimmRcUS8lstGa1rS3X+b69/P7Zxwb/tmGoNNSgE=;
        b=7Y1DkU2JMyOf5nxAnsat551otJ1EBbLP6Lb4laqB1qYTxZhQHaoazioTCo9ky/HV90
         7ElupD0crXdUVCelfIMMsUOSOTqjaBxWFbLLU1i64v0BgCGVyUXo4if9/ACwh+XNXCju
         tVmraTlC560+6tIiEQnsJtLcHskU2nohGY57qq6UQrrbvIg52vE151h+es+5pBPKKlad
         ZCAWVO6IFGxP/5eD1zW0ALBmtZ5rj+kYQTkCZ3Iav8IdxllOZQqgYkMqYr48oYMVJLaB
         fJPeK/h+iOSYuqaXSgDCctlyLmTxTK2oS48xp+thVtFvrwm4Ap5ubKZmgRn8VZEAsH23
         EtoQ==
X-Gm-Message-State: ACrzQf1fTHubOyWNLsajbqr9fnZbIk2Ltn10EbP1I1+bo5qbCftakGma
        8suJ0Yq7zRTnk/zAxShpd+wsPPK7XNOioJNd
X-Google-Smtp-Source: AMsMyM6tLC3nEgLBq46otVB4yy2FkfyLXqG6PNEBubYxDJb4RlTXBZwhlLlhNZIajpWEmaMEI9xxEw==
X-Received: by 2002:a17:906:9bec:b0:7a9:cf4a:7028 with SMTP id de44-20020a1709069bec00b007a9cf4a7028mr2722172ejc.672.1668083286417;
        Thu, 10 Nov 2022 04:28:06 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id se19-20020a170906ce5300b0078194737761sm7069340ejb.124.2022.11.10.04.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 04:28:05 -0800 (PST)
Message-ID: <ef79194bb64cf4c56e03569f3e9385f7a5b5d519.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] libbpf: hashmap interface update to
 allow both long and void* keys/values
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com, acme@kernel.org
Date:   Thu, 10 Nov 2022 14:28:04 +0200
In-Reply-To: <CAEf4BzZXrNPe+kk0yv117=5hMLXtV_odiY=f+tHDLn=sHh3RAQ@mail.gmail.com>
References: <20221109142611.879983-1-eddyz87@gmail.com>
         <20221109142611.879983-2-eddyz87@gmail.com>
         <CAEf4BzZXrNPe+kk0yv117=5hMLXtV_odiY=f+tHDLn=sHh3RAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-11-09 at 20:54 -0800, Andrii Nakryiko wrote:
> On Wed, Nov 9, 2022 at 6:26 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > An update for libbpf's hashmap interface from void* -> void* to a
> > polymorphic one, allowing both long and void* keys and values.
> >=20
> > This simplifies many use cases in libbpf as hashmaps there are mostly
> > integer to integer.
> >=20
> > Perf copies hashmap implementation from libbpf and has to be
> > updated as well.
> >=20
> > Changes to libbpf, selftests/bpf and perf are packed as a single
> > commit to avoid compilation issues with any future bisect.
> >=20
> > Polymorphic interface is acheived by hiding hashmap interface
> > functions behind auxiliary macros that take care of necessary
> > type casts, for example:
> >=20
> >     #define hashmap_cast_ptr(p)                                        =
 \
> >         ({                                                             =
 \
> >                 _Static_assert((p) =3D=3D NULL || sizeof(*(p)) =3D=3D s=
izeof(long),\
> >                                #p " pointee should be a long-sized inte=
ger or a pointer"); \
> >                 (long *)(p);                                           =
 \
> >         })
> >=20
> >     bool hashmap_find(const struct hashmap *map, long key, long *value)=
;
> >=20
> >     #define hashmap__find(map, key, value) \
> >                 hashmap_find((map), (long)(key), hashmap_cast_ptr(value=
))
> >=20
> > - hashmap__find macro casts key and value parameters to long
> >   and long* respectively
> > - hashmap_cast_ptr ensures that value pointer points to a memory
> >   of appropriate size.
> >=20
> > This hack was suggested by Andrii Nakryiko in [1].
> > This is a follow up for [2].
> >=20
> > [1] https://lore.kernel.org/bpf/CAEf4BzZ8KFneEJxFAaNCCFPGqp20hSpS2aCj76=
uRk3-qZUH5xg@mail.gmail.com/
> > [2] https://lore.kernel.org/bpf/af1facf9-7bc8-8a3d-0db4-7b3f333589a2@me=
ta.com/T/#m65b28f1d6d969fcd318b556db6a3ad499a42607d
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/bpf/bpftool/btf.c                       |  25 +--
> >  tools/bpf/bpftool/common.c                    |  10 +-
> >  tools/bpf/bpftool/gen.c                       |  19 +-
> >  tools/bpf/bpftool/link.c                      |   8 +-
> >  tools/bpf/bpftool/main.h                      |  14 +-
> >  tools/bpf/bpftool/map.c                       |   8 +-
> >  tools/bpf/bpftool/pids.c                      |  16 +-
> >  tools/bpf/bpftool/prog.c                      |   8 +-
> >  tools/lib/bpf/btf.c                           |  41 ++--
> >  tools/lib/bpf/btf_dump.c                      |  17 +-
> >  tools/lib/bpf/hashmap.c                       |  18 +-
> >  tools/lib/bpf/hashmap.h                       |  91 +++++----
> >  tools/lib/bpf/libbpf.c                        |  18 +-
> >  tools/lib/bpf/strset.c                        |  18 +-
> >  tools/lib/bpf/usdt.c                          |  29 ++-
> >  tools/perf/tests/expr.c                       |  28 +--
> >  tools/perf/tests/pmu-events.c                 |   6 +-
> >  tools/perf/util/bpf-loader.c                  |  11 +-
> >  tools/perf/util/evsel.c                       |   2 +-
> >  tools/perf/util/expr.c                        |  36 ++--
> >  tools/perf/util/hashmap.c                     |  18 +-
> >  tools/perf/util/hashmap.h                     |  91 +++++----
> >  tools/perf/util/metricgroup.c                 |  10 +-
> >  tools/perf/util/stat-shadow.c                 |   2 +-
> >  tools/perf/util/stat.c                        |   9 +-
> >  .../selftests/bpf/prog_tests/hashmap.c        | 190 +++++++++++++-----
>=20
> would be better if you added new tests in separate patch and didn't
> use CHECK(), but oh well, we'll improve that some time in the future

For my reference, what's wrong with CHECK()?

> But regardless this is a pretty clear win, thanks a lot for working on
> this! I made a few pedantic changes mentioned below, and applied to
> bpf-next.

Sorry, missed a few casts :(

>=20
>=20
> >  .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
> >  27 files changed, 411 insertions(+), 338 deletions(-)
> >=20
>=20
> [...]
>=20
> > @@ -545,7 +545,7 @@ void delete_pinned_obj_table(struct hashmap *map)
> >                 return;
> >=20
> >         hashmap__for_each_entry(map, entry, bkt)
> > -               free(entry->value);
> > +               free((void *)entry->value);
>=20
> entry->pvalue
>=20
> >=20
> >         hashmap__free(map);
> >  }
>=20
> [...]
>=20
> > @@ -309,8 +308,7 @@ static int show_link_close_plain(int fd, struct bpf=
_link_info *info)
> >         if (!hashmap__empty(link_table)) {
> >                 struct hashmap_entry *entry;
> >=20
> > -               hashmap__for_each_key_entry(link_table, entry,
> > -                                           u32_as_hash_field(info->id)=
)
> > +               hashmap__for_each_key_entry(link_table, entry, info->id=
)
> >                         printf("\n\tpinned %s", (char *)entry->value);
>=20
> (char *)entry->pvalue for consistent use of pvalue
>=20
> >         }
> >         emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
>=20
> [...]
>=20
> > @@ -595,8 +594,7 @@ static int show_map_close_plain(int fd, struct bpf_=
map_info *info)
> >         if (!hashmap__empty(map_table)) {
> >                 struct hashmap_entry *entry;
> >=20
> > -               hashmap__for_each_key_entry(map_table, entry,
> > -                                           u32_as_hash_field(info->id)=
)
> > +               hashmap__for_each_key_entry(map_table, entry, info->id)
> >                         printf("\n\tpinned %s", (char *)entry->value);
>=20
> same, pvalue for consistency
>=20
> >         }
> >=20
>=20
> [...]
>=20
> > @@ -561,8 +560,7 @@ static void print_prog_plain(struct bpf_prog_info *=
info, int fd)
> >         if (!hashmap__empty(prog_table)) {
> >                 struct hashmap_entry *entry;
> >=20
> > -               hashmap__for_each_key_entry(prog_table, entry,
> > -                                           u32_as_hash_field(info->id)=
)
> > +               hashmap__for_each_key_entry(prog_table, entry, info->id=
)
> >                         printf("\n\tpinned %s", (char *)entry->value);
>=20
> ditto
>=20
> >         }
> >=20
>=20
> [...]
>=20
> > @@ -1536,18 +1536,17 @@ static size_t btf_dump_name_dups(struct btf_dum=
p *d, struct hashmap *name_map,
> >                                  const char *orig_name)
> >  {
> >         char *old_name, *new_name;
> > -       size_t dup_cnt =3D 0;
> > +       long dup_cnt =3D 0;
>=20
> size_t is fine as is, right?
>=20
> >         int err;
> >=20
> >         new_name =3D strdup(orig_name);
> >         if (!new_name)
> >                 return 1;
> >=20
>=20
> [...]
>=20
> > @@ -102,6 +122,13 @@ enum hashmap_insert_strategy {
> >         HASHMAP_APPEND,
> >  };
> >=20
> > +#define hashmap_cast_ptr(p)                                           =
 \
> > +       ({                                                             =
 \
> > +               _Static_assert((p) =3D=3D NULL || sizeof(*(p)) =3D=3D s=
izeof(long),\
> > +                              #p " pointee should be a long-sized inte=
ger or a pointer"); \
> > +               (long *)(p);                                           =
 \
> > +       })
> > +
>=20
> I've reformatted this slightly, making it less indented to the right
>=20
> >  /*
> >   * hashmap__insert() adds key/value entry w/ various semantics, depend=
ing on
> >   * provided strategy value. If a given key/value pair replaced already
>=20
> [...]

