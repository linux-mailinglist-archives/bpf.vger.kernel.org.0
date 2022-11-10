Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40D4623B0E
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 05:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKJEyZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 23:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiKJEyY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 23:54:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A82B1B8
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 20:54:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l11so1347727edb.4
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 20:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wqSoewpCxJ4Y0ggQ4s9JwInWi59LSt8/aFh6EKqhC7I=;
        b=STZG+mAylSYQpVxyAlQiNwpasF23sqdyRkXKndQpRm7jV3Sl5n6FgHoCCV3mVjFBSn
         i6NyQGH4LSax4xhGgZifOdONY5mpq0bw/z/1rGyp7QoeQsiRNqO3KmlaY0e99yPxoiyM
         GHuqUBL9R2ORqF5IsCpikhwL/GvDx4yxzJ733ozMCNQF7HYWgi56JAr6hQSKsWhGbmzt
         he5wnTiTWTd+BR5zS/wVhZZNUz1E2KEceqd7/OGGvYMubq1OQF1y6ICzomgTAhlg5thI
         NRYxxVjS4KOm/DlM2n6jPk+hIEEGGyhDZMOQBRsX/Seq/NhXiBNJhulUi6SAGSq1JOsg
         h1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqSoewpCxJ4Y0ggQ4s9JwInWi59LSt8/aFh6EKqhC7I=;
        b=3l0HbwS7b9LCxnntLAJNIFevIerPOZ3j/RVR4hMWxe3Hqcltb/zo6eY0BSSwVcjSrJ
         4cKL/LUkSZ28sWLRO+7z5bNISC8v8it+bWbJjZqb1d8K+QrcoQHA4QSFBfk2FyuZA2JC
         UMeXvfW2tOyLAxlbZxx0HgqZftjZxk481kRUJJ3a86oEdIxQFTscDEYybdD4Q/Fwpk75
         0XG8OQl1h2UhgraDMMnmB1aOtlZrJ7lZX82X0Mlu0VHVmbIGIZaEYcjzEqq/5IwxwNGF
         wr7V+MpM/nRn7QY3IF0REFmCr1RMYSzaG5APgoGxaNG0QSwqzqPVU590od4L1cAVUX4Z
         yq+A==
X-Gm-Message-State: ACrzQf1+j5eo5d7/hULS9WdqHsXfuODuWXinkUYPPxoos1QEafdj29Pc
        g6I9UHsChjfaiJ3+0UTwkPEdavYfUpGP23LXTIg=
X-Google-Smtp-Source: AMsMyM4oHlhjRWhyaCOVjabsMguArvSMWOJLHfx4yG7BsdmC5q6SInYMNH3xsF5IiwwQT3Qwt3qRcmMKcTnXNHdcuUc=
X-Received: by 2002:aa7:c2ca:0:b0:461:89a6:2281 with SMTP id
 m10-20020aa7c2ca000000b0046189a62281mr64121781edp.260.1668056061204; Wed, 09
 Nov 2022 20:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20221109142611.879983-1-eddyz87@gmail.com> <20221109142611.879983-2-eddyz87@gmail.com>
In-Reply-To: <20221109142611.879983-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 20:54:08 -0800
Message-ID: <CAEf4BzZXrNPe+kk0yv117=5hMLXtV_odiY=f+tHDLn=sHh3RAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] libbpf: hashmap interface update to allow
 both long and void* keys/values
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 9, 2022 at 6:26 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> An update for libbpf's hashmap interface from void* -> void* to a
> polymorphic one, allowing both long and void* keys and values.
>
> This simplifies many use cases in libbpf as hashmaps there are mostly
> integer to integer.
>
> Perf copies hashmap implementation from libbpf and has to be
> updated as well.
>
> Changes to libbpf, selftests/bpf and perf are packed as a single
> commit to avoid compilation issues with any future bisect.
>
> Polymorphic interface is acheived by hiding hashmap interface
> functions behind auxiliary macros that take care of necessary
> type casts, for example:
>
>     #define hashmap_cast_ptr(p)                                         \
>         ({                                                              \
>                 _Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),\
>                                #p " pointee should be a long-sized integer or a pointer"); \
>                 (long *)(p);                                            \
>         })
>
>     bool hashmap_find(const struct hashmap *map, long key, long *value);
>
>     #define hashmap__find(map, key, value) \
>                 hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
>
> - hashmap__find macro casts key and value parameters to long
>   and long* respectively
> - hashmap_cast_ptr ensures that value pointer points to a memory
>   of appropriate size.
>
> This hack was suggested by Andrii Nakryiko in [1].
> This is a follow up for [2].
>
> [1] https://lore.kernel.org/bpf/CAEf4BzZ8KFneEJxFAaNCCFPGqp20hSpS2aCj76uRk3-qZUH5xg@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com/T/#m65b28f1d6d969fcd318b556db6a3ad499a42607d
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/bpf/bpftool/btf.c                       |  25 +--
>  tools/bpf/bpftool/common.c                    |  10 +-
>  tools/bpf/bpftool/gen.c                       |  19 +-
>  tools/bpf/bpftool/link.c                      |   8 +-
>  tools/bpf/bpftool/main.h                      |  14 +-
>  tools/bpf/bpftool/map.c                       |   8 +-
>  tools/bpf/bpftool/pids.c                      |  16 +-
>  tools/bpf/bpftool/prog.c                      |   8 +-
>  tools/lib/bpf/btf.c                           |  41 ++--
>  tools/lib/bpf/btf_dump.c                      |  17 +-
>  tools/lib/bpf/hashmap.c                       |  18 +-
>  tools/lib/bpf/hashmap.h                       |  91 +++++----
>  tools/lib/bpf/libbpf.c                        |  18 +-
>  tools/lib/bpf/strset.c                        |  18 +-
>  tools/lib/bpf/usdt.c                          |  29 ++-
>  tools/perf/tests/expr.c                       |  28 +--
>  tools/perf/tests/pmu-events.c                 |   6 +-
>  tools/perf/util/bpf-loader.c                  |  11 +-
>  tools/perf/util/evsel.c                       |   2 +-
>  tools/perf/util/expr.c                        |  36 ++--
>  tools/perf/util/hashmap.c                     |  18 +-
>  tools/perf/util/hashmap.h                     |  91 +++++----
>  tools/perf/util/metricgroup.c                 |  10 +-
>  tools/perf/util/stat-shadow.c                 |   2 +-
>  tools/perf/util/stat.c                        |   9 +-
>  .../selftests/bpf/prog_tests/hashmap.c        | 190 +++++++++++++-----

would be better if you added new tests in separate patch and didn't
use CHECK(), but oh well, we'll improve that some time in the future

But regardless this is a pretty clear win, thanks a lot for working on
this! I made a few pedantic changes mentioned below, and applied to
bpf-next.


>  .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
>  27 files changed, 411 insertions(+), 338 deletions(-)
>

[...]

> @@ -545,7 +545,7 @@ void delete_pinned_obj_table(struct hashmap *map)
>                 return;
>
>         hashmap__for_each_entry(map, entry, bkt)
> -               free(entry->value);
> +               free((void *)entry->value);

entry->pvalue

>
>         hashmap__free(map);
>  }

[...]

> @@ -309,8 +308,7 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>         if (!hashmap__empty(link_table)) {
>                 struct hashmap_entry *entry;
>
> -               hashmap__for_each_key_entry(link_table, entry,
> -                                           u32_as_hash_field(info->id))
> +               hashmap__for_each_key_entry(link_table, entry, info->id)
>                         printf("\n\tpinned %s", (char *)entry->value);

(char *)entry->pvalue for consistent use of pvalue

>         }
>         emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");

[...]

> @@ -595,8 +594,7 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
>         if (!hashmap__empty(map_table)) {
>                 struct hashmap_entry *entry;
>
> -               hashmap__for_each_key_entry(map_table, entry,
> -                                           u32_as_hash_field(info->id))
> +               hashmap__for_each_key_entry(map_table, entry, info->id)
>                         printf("\n\tpinned %s", (char *)entry->value);

same, pvalue for consistency

>         }
>

[...]

> @@ -561,8 +560,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
>         if (!hashmap__empty(prog_table)) {
>                 struct hashmap_entry *entry;
>
> -               hashmap__for_each_key_entry(prog_table, entry,
> -                                           u32_as_hash_field(info->id))
> +               hashmap__for_each_key_entry(prog_table, entry, info->id)
>                         printf("\n\tpinned %s", (char *)entry->value);

ditto

>         }
>

[...]

> @@ -1536,18 +1536,17 @@ static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
>                                  const char *orig_name)
>  {
>         char *old_name, *new_name;
> -       size_t dup_cnt = 0;
> +       long dup_cnt = 0;

size_t is fine as is, right?

>         int err;
>
>         new_name = strdup(orig_name);
>         if (!new_name)
>                 return 1;
>

[...]

> @@ -102,6 +122,13 @@ enum hashmap_insert_strategy {
>         HASHMAP_APPEND,
>  };
>
> +#define hashmap_cast_ptr(p)                                            \
> +       ({                                                              \
> +               _Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),\
> +                              #p " pointee should be a long-sized integer or a pointer"); \
> +               (long *)(p);                                            \
> +       })
> +

I've reformatted this slightly, making it less indented to the right

>  /*
>   * hashmap__insert() adds key/value entry w/ various semantics, depending on
>   * provided strategy value. If a given key/value pair replaced already

[...]
