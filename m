Return-Path: <bpf+bounces-18847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF7822754
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 04:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB41F236F1
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 03:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7654A28;
	Wed,  3 Jan 2024 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHYirBzc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE261798A
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e70d8273fso1321e87.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 19:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704250865; x=1704855665; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEqAS6lUOK244Og0QhQ14SjtB7KhQXvIvbYkplos8Zw=;
        b=aHYirBzcvnLrtWBFeX4Fv7MTP+tuQvvzHudbBsZ3RyBhHSbQXY1v50t/5/gJ9aNapP
         AjCCQKkqAU/OnwKv5TGl/ansfR+n9eO753guKBiLDxDCwX8rZ7a0izIg+pW5B0SFbM9s
         /OSYRzmja+/EEOvi26KRJl6YKm8NNbWy4CsluAALsYniKKBwIWcAJODqPNpVWSQsYSbe
         Y/VTwZRtstGhMtcsGsmdfawMec5LSv8d4iaxyA73Nibl31C2R62HTBcCGvfw8Su7U9rY
         BxLtCDLJ4vy0sttJT4SWUamawrZ19e2lQyNHkH5uaeSXJ3dN+CdDBzS4qRLwctpU+w3x
         2wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704250865; x=1704855665;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEqAS6lUOK244Og0QhQ14SjtB7KhQXvIvbYkplos8Zw=;
        b=IHPJn5A171a80BzXiPkeytxF87hQRVcXr4l2VZA7zX+wtEDzvsKqbU+yiGJurXZlRG
         Bm5BOOoMENwOWzTiBLZos5ugBsdTyvhHcgdv9d1nwqWmU76RpRETaiwop+x75tJQf5Va
         Iekw7dK0lFJ/19k+PCOM51H/EZnbxFEHNYihPdz7yZbh6T9uuJCcXDNcfd+/dVPYmx7t
         Q06R3MgJvUoQ4IbMEUm89aKMR6dAVxo8p/lvSjNAt1M2zF/oiQmFkTJ1N6YNxMCa9g0A
         HliCOsP/B87WiXr8xu9i3oLEn4gkL+EC6++WSqjXunLIZURT6a+J/Zb+2KlRiX1ipZMy
         145Q==
X-Gm-Message-State: AOJu0YzJFDlKxACwN/h0EqFghUKZoqqxVGLUuU7CEbPGSagnQcZ5uNwQ
	iPEekGWMyHlQhFBMOiLG/jkqiLQFeShP28ruyTj2lKOQW9yh
X-Google-Smtp-Source: AGHT+IEJZ1VMcut2KcGDICtAiq2m/b5KuDKPjbOqlCDVqVrIpmNBGvInCj8UOT4HhcLmWIAV+X3NqHezcvrzzkNXcJo=
X-Received: by 2002:ac2:4e65:0:b0:50e:a747:917 with SMTP id
 y5-20020ac24e65000000b0050ea7470917mr13180lfs.5.1704250865081; Tue, 02 Jan
 2024 19:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207014655.1252484-1-irogers@google.com>
In-Reply-To: <20231207014655.1252484-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jan 2024 19:00:53 -0800
Message-ID: <CAP-5=fWdAouBb7us44HOdd+ZfBj5fLFTuLCokbG8w3jVuQgTxw@mail.gmail.com>
Subject: Re: [PATCH v1] perf env: Avoid recursively taking env->bpf_progs.lock
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Ming Wang <wangming01@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 5:46=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add variants of perf_env__insert_bpf_prog_info, perf_env__insert_btf
> and perf_env__find_btf prefixed with __ to indicate the
> env->bpf_progs.lock is assumed held. Call these variants when the lock
> is held to avoid recursively taking it and potentially having a thread
> deadlock with itself.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
> Previously this patch was part of a larger set:
> https://lore.kernel.org/lkml/20231127220902.1315692-51-irogers@google.com=
/
> ---
>  tools/perf/util/bpf-event.c |  8 +++---
>  tools/perf/util/bpf-event.h | 12 ++++-----
>  tools/perf/util/env.c       | 53 +++++++++++++++++++++++--------------
>  tools/perf/util/env.h       |  4 +++
>  tools/perf/util/header.c    |  8 +++---
>  5 files changed, 51 insertions(+), 34 deletions(-)
>
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 830711cae30d..3573e0b7ef3e 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -545,9 +545,9 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, s=
truct perf_env *env)
>         return evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env)=
;
>  }
>
> -void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> -                                   struct perf_env *env,
> -                                   FILE *fp)
> +void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> +                                     struct perf_env *env,
> +                                     FILE *fp)
>  {
>         __u32 *prog_lens =3D (__u32 *)(uintptr_t)(info->jited_func_lens);
>         __u64 *prog_addrs =3D (__u64 *)(uintptr_t)(info->jited_ksyms);
> @@ -563,7 +563,7 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_i=
nfo *info,
>         if (info->btf_id) {
>                 struct btf_node *node;
>
> -               node =3D perf_env__find_btf(env, info->btf_id);
> +               node =3D __perf_env__find_btf(env, info->btf_id);
>                 if (node)
>                         btf =3D btf__new((__u8 *)(node->data),
>                                        node->data_size);
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index 1bcbd4fb6c66..e2f0420905f5 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -33,9 +33,9 @@ struct btf_node {
>  int machine__process_bpf(struct machine *machine, union perf_event *even=
t,
>                          struct perf_sample *sample);
>  int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env=
);
> -void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> -                                   struct perf_env *env,
> -                                   FILE *fp);
> +void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> +                                     struct perf_env *env,
> +                                     FILE *fp);
>  #else
>  static inline int machine__process_bpf(struct machine *machine __maybe_u=
nused,
>                                        union perf_event *event __maybe_un=
used,
> @@ -50,9 +50,9 @@ static inline int evlist__add_bpf_sb_event(struct evlis=
t *evlist __maybe_unused,
>         return 0;
>  }
>
> -static inline void bpf_event__print_bpf_prog_info(struct bpf_prog_info *=
info __maybe_unused,
> -                                                 struct perf_env *env __=
maybe_unused,
> -                                                 FILE *fp __maybe_unused=
)
> +static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_info=
 *info __maybe_unused,
> +                                                   struct perf_env *env =
__maybe_unused,
> +                                                   FILE *fp __maybe_unus=
ed)
>  {
>
>  }
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index c68b7a004f29..cfdacbf29456 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -22,15 +22,20 @@ struct perf_env perf_env;
>  #include "bpf-utils.h"
>  #include <bpf/libbpf.h>
>
> -void perf_env__insert_bpf_prog_info(struct perf_env *env,
> -                                   struct bpf_prog_info_node *info_node)
> +void perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_pro=
g_info_node *info_node)
> +{
> +       down_write(&env->bpf_progs.lock);
> +       __perf_env__insert_bpf_prog_info(env, info_node);
> +       up_write(&env->bpf_progs.lock);
> +}
> +
> +void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_p=
rog_info_node *info_node)
>  {
>         __u32 prog_id =3D info_node->info_linear->info.id;
>         struct bpf_prog_info_node *node;
>         struct rb_node *parent =3D NULL;
>         struct rb_node **p;
>
> -       down_write(&env->bpf_progs.lock);
>         p =3D &env->bpf_progs.infos.rb_node;
>
>         while (*p !=3D NULL) {
> @@ -42,15 +47,13 @@ void perf_env__insert_bpf_prog_info(struct perf_env *=
env,
>                         p =3D &(*p)->rb_right;
>                 } else {
>                         pr_debug("duplicated bpf prog info %u\n", prog_id=
);
> -                       goto out;
> +                       return;
>                 }
>         }
>
>         rb_link_node(&info_node->rb_node, parent, p);
>         rb_insert_color(&info_node->rb_node, &env->bpf_progs.infos);
>         env->bpf_progs.infos_cnt++;
> -out:
> -       up_write(&env->bpf_progs.lock);
>  }
>
>  struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env =
*env,
> @@ -79,14 +82,22 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_in=
fo(struct perf_env *env,
>  }
>
>  bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_nod=
e)
> +{
> +       bool ret;
> +
> +       down_write(&env->bpf_progs.lock);
> +       ret =3D __perf_env__insert_btf(env, btf_node);
> +       up_write(&env->bpf_progs.lock);
> +       return ret;
> +}
> +
> +bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_n=
ode)
>  {
>         struct rb_node *parent =3D NULL;
>         __u32 btf_id =3D btf_node->id;
>         struct btf_node *node;
>         struct rb_node **p;
> -       bool ret =3D true;
>
> -       down_write(&env->bpf_progs.lock);
>         p =3D &env->bpf_progs.btfs.rb_node;
>
>         while (*p !=3D NULL) {
> @@ -98,25 +109,31 @@ bool perf_env__insert_btf(struct perf_env *env, stru=
ct btf_node *btf_node)
>                         p =3D &(*p)->rb_right;
>                 } else {
>                         pr_debug("duplicated btf %u\n", btf_id);
> -                       ret =3D false;
> -                       goto out;
> +                       return false;
>                 }
>         }
>
>         rb_link_node(&btf_node->rb_node, parent, p);
>         rb_insert_color(&btf_node->rb_node, &env->bpf_progs.btfs);
>         env->bpf_progs.btfs_cnt++;
> -out:
> -       up_write(&env->bpf_progs.lock);
> -       return ret;
> +       return true;
>  }
>
>  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
> +{
> +       struct btf_node *res;
> +
> +       down_read(&env->bpf_progs.lock);
> +       res =3D __perf_env__find_btf(env, btf_id);
> +       up_read(&env->bpf_progs.lock);
> +       return res;
> +}
> +
> +struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id=
)
>  {
>         struct btf_node *node =3D NULL;
>         struct rb_node *n;
>
> -       down_read(&env->bpf_progs.lock);
>         n =3D env->bpf_progs.btfs.rb_node;
>
>         while (n) {
> @@ -126,13 +143,9 @@ struct btf_node *perf_env__find_btf(struct perf_env =
*env, __u32 btf_id)
>                 else if (btf_id > node->id)
>                         n =3D n->rb_right;
>                 else
> -                       goto out;
> +                       return node;
>         }
> -       node =3D NULL;
> -
> -out:
> -       up_read(&env->bpf_progs.lock);
> -       return node;
> +       return NULL;
>  }
>
>  /* purge data in bpf_progs.infos tree */
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index bf7e3c4c211f..7c527e65c186 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -175,12 +175,16 @@ const char *perf_env__raw_arch(struct perf_env *env=
);
>  int perf_env__nr_cpus_avail(struct perf_env *env);
>
>  void perf_env__init(struct perf_env *env);
> +void __perf_env__insert_bpf_prog_info(struct perf_env *env,
> +                                     struct bpf_prog_info_node *info_nod=
e);
>  void perf_env__insert_bpf_prog_info(struct perf_env *env,
>                                     struct bpf_prog_info_node *info_node)=
;
>  struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env =
*env,
>                                                         __u32 prog_id);
>  bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_nod=
e);
> +bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_n=
ode);
>  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
> +struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id=
);
>
>  int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
>  char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 08cc2febabde..02bf9d8b5f74 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1849,8 +1849,8 @@ static void print_bpf_prog_info(struct feat_fd *ff,=
 FILE *fp)
>                 node =3D rb_entry(next, struct bpf_prog_info_node, rb_nod=
e);
>                 next =3D rb_next(&node->rb_node);
>
> -               bpf_event__print_bpf_prog_info(&node->info_linear->info,
> -                                              env, fp);
> +               __bpf_event__print_bpf_prog_info(&node->info_linear->info=
,
> +                                                env, fp);
>         }
>
>         up_read(&env->bpf_progs.lock);
> @@ -3188,7 +3188,7 @@ static int process_bpf_prog_info(struct feat_fd *ff=
, void *data __maybe_unused)
>                 /* after reading from file, translate offset to address *=
/
>                 bpil_offs_to_addr(info_linear);
>                 info_node->info_linear =3D info_linear;
> -               perf_env__insert_bpf_prog_info(env, info_node);
> +               __perf_env__insert_bpf_prog_info(env, info_node);
>         }
>
>         up_write(&env->bpf_progs.lock);
> @@ -3235,7 +3235,7 @@ static int process_bpf_btf(struct feat_fd *ff, void=
 *data __maybe_unused)
>                 if (__do_read(ff, node->data, data_size))
>                         goto out;
>
> -               perf_env__insert_btf(env, node);
> +               __perf_env__insert_btf(env, node);
>                 node =3D NULL;
>         }
>
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>

