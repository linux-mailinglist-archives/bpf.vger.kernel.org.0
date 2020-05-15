Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD291D5C42
	for <lists+bpf@lfdr.de>; Sat, 16 May 2020 00:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgEOWSY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 18:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgEOWRo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 18:17:44 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A86C05BD0F
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 15:17:44 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q11so4096049qvu.13
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=5X66uiOgYgneIaBJWnwDqqLNWHbvvwOIwUQE6JUFuvs=;
        b=qARBCYvghEem4ji8jJ2BuAfbQmPGkVwr7DrK0FrvuDW0/fcRXW1UaNp83QHo004iT1
         vuUgfu2YrFe+TvuMw8vjK3yr3XLqsiT1qSfht9xrfnq/N7Avk/OvbjrX4lH2kWEQcNdX
         xSpJJrMqNf/3nLZYYqYeGPJ4H69NKUHRhxzk4HY2l24l0omIGzz0oC8j2QSYKshNkaZ6
         c2ipmtfDZZFbNAuxFp9lVrVSs1zqEebu+FeVHSBRa3geGfjdwwGohjtOXDp9k8JGBZXl
         2ny84viFIL8I+nKzyqA2lwAB/zIpfr8UXmS6SH4uE0kpaoByFcH8AuizCchzIwGRYqc3
         MMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=5X66uiOgYgneIaBJWnwDqqLNWHbvvwOIwUQE6JUFuvs=;
        b=dxM/hoOlHaRIKm7vhcrQlZSgmukGaGMukohznv9nqn0QpUU5ze8yju71r58psPexIw
         GRS5xGNQuePBe9txCvivTyx7sZrnOYdgLiz6qonKDsSZuirkFOvpZHvUgdU+2bDReoNY
         cTi6i4tS+dsnEL5LYbWU4w3IrOeX1nFWI+WSDXpgtBl5hdDqaC3ynVsnkjPg+4CQj4f7
         A1moWa7Fe85rUhBhVW5mxoI//8Xascjsr8r+H3BOLtnUdoSbjpnuF/5xKs65TG+tHWNt
         JJxHmPH24V6qL6byEaJYosX43yJeuIwzPxdSZfZFeDCWQpjmUfzvwu9SNRK1LZ/z1tgh
         Enjg==
X-Gm-Message-State: AOAM531DKHAnl3sSKV04xnytUpEgYH3EwOLiAVeHHJpuNtQSSUCoh4tE
        rBu22MXh7H7S0CV1b7MJES5cRrAUPhAZ
X-Google-Smtp-Source: ABdhPJxKhy2kuV0TF8TWVXvm8V4MNQMdO/1/pXd8ZPwdQBwS4U2B0h4MOBFG4vjo44VnKkUnW1P/HKE9HyQv
X-Received: by 2002:a05:6214:1427:: with SMTP id o7mr5829901qvx.104.1589581063378;
 Fri, 15 May 2020 15:17:43 -0700 (PDT)
Date:   Fri, 15 May 2020 15:17:28 -0700
In-Reply-To: <20200515221732.44078-1-irogers@google.com>
Message-Id: <20200515221732.44078-4-irogers@google.com>
Mime-Version: 1.0
References: <20200515221732.44078-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v3 3/7] libbpf hashmap: Fix signedness warnings
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes the following warnings:

hashmap.c: In function =E2=80=98hashmap__clear=E2=80=99:
hashmap.h:150:20: error: comparison of integer expressions of different sig=
nedness: =E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99 {aka =E2=80=98l=
ong unsigned int=E2=80=99} [-Werror=3Dsign-compare]
  150 |  for (bkt =3D 0; bkt < map->cap; bkt++)        \

hashmap.c: In function =E2=80=98hashmap_grow=E2=80=99:
hashmap.h:150:20: error: comparison of integer expressions of different sig=
nedness: =E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99 {aka =E2=80=98l=
ong unsigned int=E2=80=99} [-Werror=3Dsign-compare]
  150 |  for (bkt =3D 0; bkt < map->cap; bkt++)        \

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index cffb96202e0d..a405dad068f5 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -60,7 +60,7 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
 void hashmap__clear(struct hashmap *map)
 {
 	struct hashmap_entry *cur, *tmp;
-	int bkt;
+	size_t bkt;
=20
 	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
 		free(cur);
@@ -100,8 +100,7 @@ static int hashmap_grow(struct hashmap *map)
 	struct hashmap_entry **new_buckets;
 	struct hashmap_entry *cur, *tmp;
 	size_t new_cap_bits, new_cap;
-	size_t h;
-	int bkt;
+	size_t h, bkt;
=20
 	new_cap_bits =3D map->cap_bits + 1;
 	if (new_cap_bits < HASHMAP_MIN_CAP_BITS)
--=20
2.26.2.761.g0e0b3e54be-goog

