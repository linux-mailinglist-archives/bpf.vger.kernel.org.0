Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCD76221CB
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 03:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKICOa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 21:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKICO3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 21:14:29 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8D01A81E
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 18:14:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v7so9929902wmn.0
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 18:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ALJI/ErsIGg7Ptuk8BRq2e9/Vxju4VXzlbrjBUvfUmw=;
        b=aWK23PRvqudgHy7BEveLWOuw8QsdgJKOxJi7WuUTKY4SKvp/xn+rblw8RSHd7JCm3e
         6q93PhmIC993iNMj5/vDTBcggP0UYVnQSvbaBLtJE+Vq45iAXjgFf4BOPbLutWGWJgE0
         rvf4Jaq96eLv362k06aZIdQScRFI8vE0Wz3uEdg0XyW5i4CQTbBOOXquoC5FJeknLx9N
         V3KFSqHQEo0HzjNj1MpmorOWF7cSOvNePbrAc+4OzZee+lEa31jUnbBVA+sLbzS0O4kp
         hiLTaVP/7bA5xe4edjERbsTEXsz4JiDVLMFtlCV27juYgsU0Pcva1XYELF4an0S5+aqP
         ZjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALJI/ErsIGg7Ptuk8BRq2e9/Vxju4VXzlbrjBUvfUmw=;
        b=MCAY/IuLyRK58o+imRzHYcwcIw+lvnIvGNQ2To5dzG8H0UJGN1RPXTlv+fGsGT96R5
         XWhyKmIAhOj9VXTfzzyzRoHAj46AcnAUy4d+ssXzPdJXoWgaaeYuZ2lYJ37r97a358Bc
         kchEsK8zdeHcyEjQsj+5/mNIqpmLBk2x0CrPNQusLGgire1ucp/t3FVJQdFV5jrIV8vz
         6DZvfgLLbqy0NyHUs63tdo7MSsh8Iz9szwSnjvSrFJoe0RmtfeqGg5kWKxYVd5fBl5ch
         DwJiVlo1S9tr9MG8ad1aLESJrOVhLZygHUYTsnX0XWCeGI3jW7dAXdTe1uUmwhJny5nn
         G7Ug==
X-Gm-Message-State: ANoB5pmGOTqz2QsqS/rerf31qaAcGykubeOmnXhTPgyIebnYPH/7Svlp
        cUcGDt1Cj6iPhGKtnr6m0e4=
X-Google-Smtp-Source: AA0mqf4ykD8Xq8vm9KwLPEKm9mierOo0X+WJvORuqMpMzDseHTR+hCENhlVJOG5HBJ15DHWy/UjMRw==
X-Received: by 2002:a1c:2c6:0:b0:3cf:ab4b:5ea9 with SMTP id 189-20020a1c02c6000000b003cfab4b5ea9mr9047618wmc.171.1667960065276;
        Tue, 08 Nov 2022 18:14:25 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0023682011c1dsm11661244wrq.104.2022.11.08.18.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 18:14:24 -0800 (PST)
Message-ID: <82d36b7ae03e956f29c01b567aa8ba290b423364.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: hashmap interface update to
 long -> long
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Wed, 09 Nov 2022 04:14:23 +0200
In-Reply-To: <CAEf4BzZ8KFneEJxFAaNCCFPGqp20hSpS2aCj76uRk3-qZUH5xg@mail.gmail.com>
References: <20221106202910.4193104-1-eddyz87@gmail.com>
         <20221106202910.4193104-2-eddyz87@gmail.com>
         <CAADnVQJNFqGE+5b9kicHnfxd37bpeCJV1Cz+5rXi-vt8imTMaQ@mail.gmail.com>
         <CAEf4BzZ8KFneEJxFAaNCCFPGqp20hSpS2aCj76uRk3-qZUH5xg@mail.gmail.com>
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

On Mon, 2022-11-07 at 16:46 -0800, Andrii Nakryiko wrote:
> On Sun, Nov 6, 2022 at 12:43 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Sun, Nov 6, 2022 at 12:29 PM Eduard Zingerman <eddyz87@gmail.com> wr=
ote:
> > >=20
> > > An update for libbpf's hashmap interface from void* -> void* to
> > > long -> long. Removes / simplifies some type casts when hashmap
> > > keys or values are 32-bit integers.
> > >=20
> > > In libbpf hashmap is more often used with integral keys / values
> > > rather than with pointer keys / values.
> > >=20
> > > Perf copies hashmap implementation from libbpf and has to be
> > > updated as well.
> > >=20
> > > Changes to libbpf, selftests/bpf and perf are packed as a single
> > > commit to avoid compilation issues with any future bisect.
> > >=20
> > > The net number of casts is decreased after this refactoring. Although
> > > perf mostly uses ptr to ptr maps, thus a lot of casts have to be
> > > added there:
> > >=20
> > >              Casts    Casts
> > >              removed  added
> > > libbpf       ~50      ~20
> > > libbpf tests ~55      ~0
> > > perf         ~0       ~33
> > > perf tests   ~0       ~13
> > >=20
> > > This is a follow up for [1].
> > >=20
> > > [1] https://lore.kernel.org/bpf/af1facf9-7bc8-8a3d-0db4-7b3f333589a2@=
meta.com/T/#m65b28f1d6d969fcd318b556db6a3ad499a42607d
> > >=20
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  tools/bpf/bpftool/btf.c                       |  25 ++---
> > >  tools/bpf/bpftool/common.c                    |  10 +-
> > >  tools/bpf/bpftool/gen.c                       |  19 ++--
> > >  tools/bpf/bpftool/link.c                      |   8 +-
> > >  tools/bpf/bpftool/main.h                      |  14 +--
> > >  tools/bpf/bpftool/map.c                       |   8 +-
> > >  tools/bpf/bpftool/pids.c                      |  16 +--
> > >  tools/bpf/bpftool/prog.c                      |   8 +-
> > >  tools/lib/bpf/btf.c                           |  41 ++++---
> > >  tools/lib/bpf/btf_dump.c                      |  16 +--
> > >  tools/lib/bpf/hashmap.c                       |  16 +--
> > >  tools/lib/bpf/hashmap.h                       |  34 +++---
> > >  tools/lib/bpf/libbpf.c                        |  18 ++--
> > >  tools/lib/bpf/strset.c                        |  18 ++--
> > >  tools/lib/bpf/usdt.c                          |  31 +++---
> > >  tools/perf/tests/expr.c                       |  40 +++----
> > >  tools/perf/tests/pmu-events.c                 |   6 +-
> > >  tools/perf/util/bpf-loader.c                  |  23 ++--
> > >  tools/perf/util/expr.c                        |  32 +++---
> > >  tools/perf/util/hashmap.c                     |  16 +--
> > >  tools/perf/util/hashmap.h                     |  34 +++---
> > >  tools/perf/util/metricgroup.c                 |  12 +--
> > >  tools/perf/util/stat.c                        |   9 +-
> > >  .../selftests/bpf/prog_tests/hashmap.c        | 102 +++++++++-------=
--
> > >  .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
> > >  25 files changed, 257 insertions(+), 305 deletions(-)
> >=20
> > Looks like the churn is not worth it.
> > I'd keep it as-is.
>=20
> No-no, this is already a big win for libbpf/bpftool as is, but we can
> do even better for perf and some uses in selftest and libbpf itself.
> Given a hashmap can be used with a pointer or an integer as the
> key/value, we can use a bit of smartness (while keeping the safety)
> through simple macro wrapper for operations like hashmap__find and
> hashmap__insert (and co). That will avoid most of if not all casts for
> hashmap lookups/updates. And then for hashmap__for_each_entry and
> such, we can define hashmap_entry to have a union of long-based and
> void*-based key:
>=20
> struct hashmap_entry {
>   union {
>     long key;
>     const void *pkey;
>   };
>   union {
>     long value;
>     void *pvalue;
>   };
>   ...
> }
>=20
> I have it a try in few perf places, and it allows to avoid all the
> casts while thanks to that _Statis_assert we should be even safer than
> it was before. Eduard, please check the diff below and see if you can
> incorporate similar changes for other operations, if necessary.
>=20

That's a nice hack, thank you. Everything works after interface
function / macro update. I need a bit more time to wrap up the
patch-set, will post it tomorrow.

> $ git diff
> diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
> index dfe99e766f30..0c1c1289a694 100644
> --- a/tools/lib/bpf/hashmap.c
> +++ b/tools/lib/bpf/hashmap.c
> @@ -203,7 +203,7 @@ int hashmap__insert(struct hashmap *map, long key,
> long value,
>         return 0;
>  }
>=20
> -bool hashmap__find(const struct hashmap *map, long key, long *value)
> +bool hashmap_find(const struct hashmap *map, long key, long *value)
>  {
>         struct hashmap_entry *entry;
>         size_t h;
> diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> index 7393ef616920..daec29012808 100644
> --- a/tools/lib/bpf/hashmap.h
> +++ b/tools/lib/bpf/hashmap.h
> @@ -47,8 +47,14 @@ typedef size_t (*hashmap_hash_fn)(long key, void *ctx)=
;
>  typedef bool (*hashmap_equal_fn)(long key1, long key2, void *ctx);
>=20
>  struct hashmap_entry {
> -       long key;
> -       long value;
> +       union {
> +               long key;
> +               const void *pkey;
> +       };
> +       union {
> +               long value;
> +               void *pvalue;
> +       };
>         struct hashmap_entry *next;
>  };
>=20
> @@ -144,7 +150,13 @@ static inline int hashmap__append(struct hashmap
> *map, long key, long value)
>=20
>  bool hashmap__delete(struct hashmap *map, long key, long *old_key,
> long *old_value);
>=20
> -bool hashmap__find(const struct hashmap *map, long key, long *value);
> +bool hashmap_find(const struct hashmap *map, long key, long *value);
> +
> +#define hashmap__find(map, key, value) ({
>                          \
> +               _Static_assert(value =3D=3D NULL || sizeof(*value) =3D=3D
> sizeof(long),                 \
> +                              "Value pointee should be a long-sized
> integer or a pointer");    \
> +               hashmap_find(map, (long)key, (long *)value);
>                          \
> +})
>=20
>  /*
>   * hashmap__for_each_entry - iterate over all entries in hashmap
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 96092c9cb34b..1a1a76357f72 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5669,7 +5669,7 @@ static int bpf_core_resolve_relo(struct bpf_program=
 *prog,
>                 return -EINVAL;
>=20
>         if (relo->kind !=3D BPF_CORE_TYPE_ID_LOCAL &&
> -           !hashmap__find(cand_cache, local_id, (long *)&cands)) {
> +           !hashmap__find(cand_cache, local_id, &cands)) {
>                 cands =3D bpf_core_find_cands(prog->obj, local_btf, local=
_id);
>                 if (IS_ERR(cands)) {
>                         pr_warn("prog '%s': relo #%d: target candidate
> search failed for [%d] %s %s: %ld\n",
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index 8107ed0428c2..cb206003c1f0 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -130,12 +130,9 @@ static int test__expr(struct test_suite *t
> __maybe_unused, int subtest __maybe_u
>                         expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
>                                         ctx) =3D=3D 0);
>         TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 3);
> -       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"BAR",
> -                                                 (long *)&val_ptr));
> -       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"BAZ",
> -                                                 (long *)&val_ptr));
> -       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"BOZO",
> -                                                 (long *)&val_ptr));
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
> (long)"BAR", &val_ptr));
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
> (long)"BAZ", &val_ptr));
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
> (long)"BOZO", &val_ptr));
>=20
>         expr__ctx_clear(ctx);
>         ctx->sctx.runtime =3D 3;
> @@ -143,20 +140,16 @@ static int test__expr(struct test_suite *t
> __maybe_unused, int subtest __maybe_u
>                         expr__find_ids("EVENT1\\,param\\=3D?@ +
> EVENT2\\,param\\=3D?@",
>                                         NULL, ctx) =3D=3D 0);
>         TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 2);
> -       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
> (long)"EVENT1,param=3D3@",
> -                                                 (long *)&val_ptr));
> -       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
> (long)"EVENT2,param=3D3@",
> -                                                 (long *)&val_ptr));
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
> (long)"EVENT1,param=3D3@", &val_ptr));
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
> (long)"EVENT2,param=3D3@", &val_ptr));
>=20
>         expr__ctx_clear(ctx);
>         TEST_ASSERT_VAL("find ids",
>                         expr__find_ids("dash\\-event1 - dash\\-event2",
>                                        NULL, ctx) =3D=3D 0);
>         TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 2);
> -       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"dash-e=
vent1",
> -                                                 (long *)&val_ptr));
> -       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"dash-e=
vent2",
> -                                                 (long *)&val_ptr));
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
> (long)"dash-event1", &val_ptr));
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
> (long)"dash-event2", &val_ptr));
>=20
>         /* Only EVENT1 or EVENT2 need be measured depending on the
> value of smt_on. */
>         {
> @@ -174,7 +167,7 @@ static int test__expr(struct test_suite *t
> __maybe_unused, int subtest __maybe_u
>                 TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=
=3D 1);
>                 TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
>                                                           (long)(smton
> ? "EVENT1" : "EVENT2"),
> -                                                         (long *)&val_pt=
r));
> +                                                         &val_ptr));
>=20
>                 expr__ctx_clear(ctx);
>                 TEST_ASSERT_VAL("find ids",
> @@ -183,7 +176,7 @@ static int test__expr(struct test_suite *t
> __maybe_unused, int subtest __maybe_u
>                 TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=
=3D 1);
>                 TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
>=20
> (long)(corewide ? "EVENT1" : "EVENT2"),
> -                                                         (long *)&val_pt=
r));
> +                                                         &val_ptr));
>=20
>         }
>         /* The expression is a constant 1.0 without needing to
> evaluate EVENT1. */
> @@ -220,8 +213,7 @@ static int test__expr(struct test_suite *t
> __maybe_unused, int subtest __maybe_u
>                         expr__find_ids("source_count(EVENT1)",
>                         NULL, ctx) =3D=3D 0);
>         TEST_ASSERT_VAL("source count", hashmap__size(ctx->ids) =3D=3D 1)=
;
> -       TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids, (long)"EV=
ENT1",
> -                                                     (long *)&val_ptr));
> +       TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids,
> (long)"EVENT1", &val_ptr));
>=20
>         expr__ctx_free(ctx);
>=20
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 55f114450316..2430b8965268 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -131,7 +131,7 @@ static void *program_priv(const struct bpf_program *p=
rog)
>=20
>         if (IS_ERR_OR_NULL(bpf_program_hash))
>                 return NULL;
> -       if (!hashmap__find(bpf_program_hash, (long)prog, (long *)&priv))
> +       if (!hashmap__find(bpf_program_hash, prog, &priv))
>                 return NULL;
>         return priv;
>  }
> @@ -1170,7 +1170,7 @@ static void *map_priv(const struct bpf_map *map)
>=20
>         if (IS_ERR_OR_NULL(bpf_map_hash))
>                 return NULL;
> -       if (!hashmap__find(bpf_map_hash, (long)map, (long *)&priv))
> +       if (!hashmap__find(bpf_map_hash, map, &priv))
>                 return NULL;
>         return priv;
>  }
> @@ -1184,7 +1184,7 @@ static void bpf_map_hash_free(void)
>                 return;
>=20
>         hashmap__for_each_entry(bpf_map_hash, cur, bkt)
> -               bpf_map_priv__clear((struct bpf_map *)cur->key, (void
> *)cur->value);
> +               bpf_map_priv__clear(cur->pkey, cur->pvalue);
>=20
>         hashmap__free(bpf_map_hash);
>         bpf_map_hash =3D NULL;
> diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
> index dfe99e766f30..0c1c1289a694 100644
> --- a/tools/perf/util/hashmap.c
> +++ b/tools/perf/util/hashmap.c
> @@ -203,7 +203,7 @@ int hashmap__insert(struct hashmap *map, long key,
> long value,
>         return 0;
>  }
>=20
> -bool hashmap__find(const struct hashmap *map, long key, long *value)
> +bool hashmap_find(const struct hashmap *map, long key, long *value)
>  {
>         struct hashmap_entry *entry;
>         size_t h;
> diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
> index 7393ef616920..edbadb712725 100644
> --- a/tools/perf/util/hashmap.h
> +++ b/tools/perf/util/hashmap.h
> @@ -47,8 +47,14 @@ typedef size_t (*hashmap_hash_fn)(long key, void *ctx)=
;
>  typedef bool (*hashmap_equal_fn)(long key1, long key2, void *ctx);
>=20
>  struct hashmap_entry {
> -       long key;
> -       long value;
> +       union {
> +               long key;
> +               const void *pkey;
> +       };
> +       union {
> +               long value;
> +               void *pvalue;
> +       };
>         struct hashmap_entry *next;
>  };
>=20
> @@ -144,7 +150,13 @@ static inline int hashmap__append(struct hashmap
> *map, long key, long value)
>=20
>  bool hashmap__delete(struct hashmap *map, long key, long *old_key,
> long *old_value);
>=20
> -bool hashmap__find(const struct hashmap *map, long key, long *value);
> +bool hashmap_find(const struct hashmap *map, long key, long *value);
> +
> +#define hashmap__find(map, key, value) ({
>                          \
> +               _Static_assert(sizeof(*value) =3D=3D sizeof(long),
>                          \
> +                              "Value pointee should be a long-sized
> integer or a pointer");    \
> +               hashmap_find(map, (long)key, (long *)value);
>                          \
> +})
>=20
>  /*
>   * hashmap__for_each_entry - iterate over all entries in hashmap
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index e9bd881c6912..2059ed3164ae 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -288,7 +288,7 @@ static int setup_metric_events(struct hashmap *ids,
>                  * combined or shared groups, this metric may not care
>                  * about this event.
>                  */
> -               if (hashmap__find(ids, (long)metric_id, (long *)&val_ptr)=
) {
> +               if (hashmap__find(ids, metric_id, &val_ptr)) {
>                         metric_events[matched_events++] =3D ev;
>=20
>                         if (matched_events >=3D ids_size)
> 11/07 16:45:42.699 andriin@devbig019:~/linux/tools/lib/bpf (master)
> $

