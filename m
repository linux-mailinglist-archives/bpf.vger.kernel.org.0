Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24F06204E2
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 01:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiKHArH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 19:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiKHArG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 19:47:06 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A7920BC6
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 16:47:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id sc25so34525817ejc.12
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 16:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gLoiTEIqT0L7IglWBe/aHweeZf5c4tGDupcFHFa/LyM=;
        b=pEz+EXZ03uvvAaAXv1VUWA8xw/jrT2FcdmIqBaLcuclHL7e0p2731DwN9h5oUKfj++
         S7gn8Bs8PrbwOl/3nevO953Z0ym1FVB0eU1bxwPSNztqWk01ONzvsOdvRkzlylg9JoVw
         Gx0EkV3hYXD0xrr+ocbyDLFrHuA8NrCcrysVw+D835o4WAGGSDK43oJb/lilG+LARqKV
         uymCtCWkujnOm3u/eIRNW1HalPkAmkE1JxXIrwUZbFJNYVh51eLqoR3HNiU9hR2ouuUK
         Z08LH7PUV1E+m9zVSrTaHFwSalqMIDeHkwu7aq2Wyr3VyFU+7XbaBIXPbgw9iMxVF4gY
         bV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLoiTEIqT0L7IglWBe/aHweeZf5c4tGDupcFHFa/LyM=;
        b=wxbkEHuqFeUWn0GUw/9SPgRgCIAU8HKWKY11XMjtQAddVGkEohmZmWqkeXd/qFYMIc
         RXy92NQA5bQbGyHZO36FJEfvCEGCPMgFTb8xFNRr42tmglJh8KRFZviLeILEPS0UCf+W
         bmqZ/+XhDfnDMUiIksImcOs9E68rOVW5Nr3T5OhJDtx6v6SY9rDSXqzoXsM0XO2AlozE
         mo+1TEYrHjhbVaagejN/UBveMvhQS8Km1yO13PdHenXoL3FvQsUzAs839U9oSb6jbSLH
         oq98tlXvkyY6PvcGKxy9egaObE9m92DQz71iVil6i6lBdVvQo9+PNFD3f+Ms6eCCIDd/
         WSmg==
X-Gm-Message-State: ACrzQf2uc1eLEJMf1LVAMvNr3FE0j11rt+AnEZ2w68Y0/kNeZ+En+agL
        bjkHMZJwhP7ezu2oAK7jQWFXRva9MPtbPCVEzRQ=
X-Google-Smtp-Source: AMsMyM6DqmV0nsgoERJl8gtidZwn8yrt3uHw9bS1pvZGzkWE6pJvLA+si05Dn2skwSMnjxg/8DklA36FiunfuysRCLQ=
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id
 sc36-20020a1709078a2400b00795bb7d643bmr51367356ejc.115.1667868423170; Mon, 07
 Nov 2022 16:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20221106202910.4193104-1-eddyz87@gmail.com> <20221106202910.4193104-2-eddyz87@gmail.com>
 <CAADnVQJNFqGE+5b9kicHnfxd37bpeCJV1Cz+5rXi-vt8imTMaQ@mail.gmail.com>
In-Reply-To: <CAADnVQJNFqGE+5b9kicHnfxd37bpeCJV1Cz+5rXi-vt8imTMaQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Nov 2022 16:46:51 -0800
Message-ID: <CAEf4BzZ8KFneEJxFAaNCCFPGqp20hSpS2aCj76uRk3-qZUH5xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: hashmap interface update to long
 -> long
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Sun, Nov 6, 2022 at 12:43 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Nov 6, 2022 at 12:29 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > An update for libbpf's hashmap interface from void* -> void* to
> > long -> long. Removes / simplifies some type casts when hashmap
> > keys or values are 32-bit integers.
> >
> > In libbpf hashmap is more often used with integral keys / values
> > rather than with pointer keys / values.
> >
> > Perf copies hashmap implementation from libbpf and has to be
> > updated as well.
> >
> > Changes to libbpf, selftests/bpf and perf are packed as a single
> > commit to avoid compilation issues with any future bisect.
> >
> > The net number of casts is decreased after this refactoring. Although
> > perf mostly uses ptr to ptr maps, thus a lot of casts have to be
> > added there:
> >
> >              Casts    Casts
> >              removed  added
> > libbpf       ~50      ~20
> > libbpf tests ~55      ~0
> > perf         ~0       ~33
> > perf tests   ~0       ~13
> >
> > This is a follow up for [1].
> >
> > [1] https://lore.kernel.org/bpf/af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com/T/#m65b28f1d6d969fcd318b556db6a3ad499a42607d
> >
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  tools/bpf/bpftool/btf.c                       |  25 ++---
> >  tools/bpf/bpftool/common.c                    |  10 +-
> >  tools/bpf/bpftool/gen.c                       |  19 ++--
> >  tools/bpf/bpftool/link.c                      |   8 +-
> >  tools/bpf/bpftool/main.h                      |  14 +--
> >  tools/bpf/bpftool/map.c                       |   8 +-
> >  tools/bpf/bpftool/pids.c                      |  16 +--
> >  tools/bpf/bpftool/prog.c                      |   8 +-
> >  tools/lib/bpf/btf.c                           |  41 ++++---
> >  tools/lib/bpf/btf_dump.c                      |  16 +--
> >  tools/lib/bpf/hashmap.c                       |  16 +--
> >  tools/lib/bpf/hashmap.h                       |  34 +++---
> >  tools/lib/bpf/libbpf.c                        |  18 ++--
> >  tools/lib/bpf/strset.c                        |  18 ++--
> >  tools/lib/bpf/usdt.c                          |  31 +++---
> >  tools/perf/tests/expr.c                       |  40 +++----
> >  tools/perf/tests/pmu-events.c                 |   6 +-
> >  tools/perf/util/bpf-loader.c                  |  23 ++--
> >  tools/perf/util/expr.c                        |  32 +++---
> >  tools/perf/util/hashmap.c                     |  16 +--
> >  tools/perf/util/hashmap.h                     |  34 +++---
> >  tools/perf/util/metricgroup.c                 |  12 +--
> >  tools/perf/util/stat.c                        |   9 +-
> >  .../selftests/bpf/prog_tests/hashmap.c        | 102 +++++++++---------
> >  .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
> >  25 files changed, 257 insertions(+), 305 deletions(-)
>
> Looks like the churn is not worth it.
> I'd keep it as-is.

No-no, this is already a big win for libbpf/bpftool as is, but we can
do even better for perf and some uses in selftest and libbpf itself.
Given a hashmap can be used with a pointer or an integer as the
key/value, we can use a bit of smartness (while keeping the safety)
through simple macro wrapper for operations like hashmap__find and
hashmap__insert (and co). That will avoid most of if not all casts for
hashmap lookups/updates. And then for hashmap__for_each_entry and
such, we can define hashmap_entry to have a union of long-based and
void*-based key:

struct hashmap_entry {
  union {
    long key;
    const void *pkey;
  };
  union {
    long value;
    void *pvalue;
  };
  ...
}

I have it a try in few perf places, and it allows to avoid all the
casts while thanks to that _Statis_assert we should be even safer than
it was before. Eduard, please check the diff below and see if you can
incorporate similar changes for other operations, if necessary.

$ git diff
diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index dfe99e766f30..0c1c1289a694 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -203,7 +203,7 @@ int hashmap__insert(struct hashmap *map, long key,
long value,
        return 0;
 }

-bool hashmap__find(const struct hashmap *map, long key, long *value)
+bool hashmap_find(const struct hashmap *map, long key, long *value)
 {
        struct hashmap_entry *entry;
        size_t h;
diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 7393ef616920..daec29012808 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -47,8 +47,14 @@ typedef size_t (*hashmap_hash_fn)(long key, void *ctx);
 typedef bool (*hashmap_equal_fn)(long key1, long key2, void *ctx);

 struct hashmap_entry {
-       long key;
-       long value;
+       union {
+               long key;
+               const void *pkey;
+       };
+       union {
+               long value;
+               void *pvalue;
+       };
        struct hashmap_entry *next;
 };

@@ -144,7 +150,13 @@ static inline int hashmap__append(struct hashmap
*map, long key, long value)

 bool hashmap__delete(struct hashmap *map, long key, long *old_key,
long *old_value);

-bool hashmap__find(const struct hashmap *map, long key, long *value);
+bool hashmap_find(const struct hashmap *map, long key, long *value);
+
+#define hashmap__find(map, key, value) ({
                         \
+               _Static_assert(value == NULL || sizeof(*value) ==
sizeof(long),                 \
+                              "Value pointee should be a long-sized
integer or a pointer");    \
+               hashmap_find(map, (long)key, (long *)value);
                         \
+})

 /*
  * hashmap__for_each_entry - iterate over all entries in hashmap
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 96092c9cb34b..1a1a76357f72 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5669,7 +5669,7 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
                return -EINVAL;

        if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
-           !hashmap__find(cand_cache, local_id, (long *)&cands)) {
+           !hashmap__find(cand_cache, local_id, &cands)) {
                cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
                if (IS_ERR(cands)) {
                        pr_warn("prog '%s': relo #%d: target candidate
search failed for [%d] %s %s: %ld\n",
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 8107ed0428c2..cb206003c1f0 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -130,12 +130,9 @@ static int test__expr(struct test_suite *t
__maybe_unused, int subtest __maybe_u
                        expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
                                        ctx) == 0);
        TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 3);
-       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"BAR",
-                                                 (long *)&val_ptr));
-       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"BAZ",
-                                                 (long *)&val_ptr));
-       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"BOZO",
-                                                 (long *)&val_ptr));
+       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
(long)"BAR", &val_ptr));
+       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
(long)"BAZ", &val_ptr));
+       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
(long)"BOZO", &val_ptr));

        expr__ctx_clear(ctx);
        ctx->sctx.runtime = 3;
@@ -143,20 +140,16 @@ static int test__expr(struct test_suite *t
__maybe_unused, int subtest __maybe_u
                        expr__find_ids("EVENT1\\,param\\=?@ +
EVENT2\\,param\\=?@",
                                        NULL, ctx) == 0);
        TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
-       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
(long)"EVENT1,param=3@",
-                                                 (long *)&val_ptr));
-       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
(long)"EVENT2,param=3@",
-                                                 (long *)&val_ptr));
+       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
(long)"EVENT1,param=3@", &val_ptr));
+       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
(long)"EVENT2,param=3@", &val_ptr));

        expr__ctx_clear(ctx);
        TEST_ASSERT_VAL("find ids",
                        expr__find_ids("dash\\-event1 - dash\\-event2",
                                       NULL, ctx) == 0);
        TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
-       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"dash-event1",
-                                                 (long *)&val_ptr));
-       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"dash-event2",
-                                                 (long *)&val_ptr));
+       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
(long)"dash-event1", &val_ptr));
+       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
(long)"dash-event2", &val_ptr));

        /* Only EVENT1 or EVENT2 need be measured depending on the
value of smt_on. */
        {
@@ -174,7 +167,7 @@ static int test__expr(struct test_suite *t
__maybe_unused, int subtest __maybe_u
                TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
                TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
                                                          (long)(smton
? "EVENT1" : "EVENT2"),
-                                                         (long *)&val_ptr));
+                                                         &val_ptr));

                expr__ctx_clear(ctx);
                TEST_ASSERT_VAL("find ids",
@@ -183,7 +176,7 @@ static int test__expr(struct test_suite *t
__maybe_unused, int subtest __maybe_u
                TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
                TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,

(long)(corewide ? "EVENT1" : "EVENT2"),
-                                                         (long *)&val_ptr));
+                                                         &val_ptr));

        }
        /* The expression is a constant 1.0 without needing to
evaluate EVENT1. */
@@ -220,8 +213,7 @@ static int test__expr(struct test_suite *t
__maybe_unused, int subtest __maybe_u
                        expr__find_ids("source_count(EVENT1)",
                        NULL, ctx) == 0);
        TEST_ASSERT_VAL("source count", hashmap__size(ctx->ids) == 1);
-       TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids, (long)"EVENT1",
-                                                     (long *)&val_ptr));
+       TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids,
(long)"EVENT1", &val_ptr));

        expr__ctx_free(ctx);

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 55f114450316..2430b8965268 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -131,7 +131,7 @@ static void *program_priv(const struct bpf_program *prog)

        if (IS_ERR_OR_NULL(bpf_program_hash))
                return NULL;
-       if (!hashmap__find(bpf_program_hash, (long)prog, (long *)&priv))
+       if (!hashmap__find(bpf_program_hash, prog, &priv))
                return NULL;
        return priv;
 }
@@ -1170,7 +1170,7 @@ static void *map_priv(const struct bpf_map *map)

        if (IS_ERR_OR_NULL(bpf_map_hash))
                return NULL;
-       if (!hashmap__find(bpf_map_hash, (long)map, (long *)&priv))
+       if (!hashmap__find(bpf_map_hash, map, &priv))
                return NULL;
        return priv;
 }
@@ -1184,7 +1184,7 @@ static void bpf_map_hash_free(void)
                return;

        hashmap__for_each_entry(bpf_map_hash, cur, bkt)
-               bpf_map_priv__clear((struct bpf_map *)cur->key, (void
*)cur->value);
+               bpf_map_priv__clear(cur->pkey, cur->pvalue);

        hashmap__free(bpf_map_hash);
        bpf_map_hash = NULL;
diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index dfe99e766f30..0c1c1289a694 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -203,7 +203,7 @@ int hashmap__insert(struct hashmap *map, long key,
long value,
        return 0;
 }

-bool hashmap__find(const struct hashmap *map, long key, long *value)
+bool hashmap_find(const struct hashmap *map, long key, long *value)
 {
        struct hashmap_entry *entry;
        size_t h;
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index 7393ef616920..edbadb712725 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
@@ -47,8 +47,14 @@ typedef size_t (*hashmap_hash_fn)(long key, void *ctx);
 typedef bool (*hashmap_equal_fn)(long key1, long key2, void *ctx);

 struct hashmap_entry {
-       long key;
-       long value;
+       union {
+               long key;
+               const void *pkey;
+       };
+       union {
+               long value;
+               void *pvalue;
+       };
        struct hashmap_entry *next;
 };

@@ -144,7 +150,13 @@ static inline int hashmap__append(struct hashmap
*map, long key, long value)

 bool hashmap__delete(struct hashmap *map, long key, long *old_key,
long *old_value);

-bool hashmap__find(const struct hashmap *map, long key, long *value);
+bool hashmap_find(const struct hashmap *map, long key, long *value);
+
+#define hashmap__find(map, key, value) ({
                         \
+               _Static_assert(sizeof(*value) == sizeof(long),
                         \
+                              "Value pointee should be a long-sized
integer or a pointer");    \
+               hashmap_find(map, (long)key, (long *)value);
                         \
+})

 /*
  * hashmap__for_each_entry - iterate over all entries in hashmap
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e9bd881c6912..2059ed3164ae 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -288,7 +288,7 @@ static int setup_metric_events(struct hashmap *ids,
                 * combined or shared groups, this metric may not care
                 * about this event.
                 */
-               if (hashmap__find(ids, (long)metric_id, (long *)&val_ptr)) {
+               if (hashmap__find(ids, metric_id, &val_ptr)) {
                        metric_events[matched_events++] = ev;

                        if (matched_events >= ids_size)
11/07 16:45:42.699 andriin@devbig019:~/linux/tools/lib/bpf (master)
$
