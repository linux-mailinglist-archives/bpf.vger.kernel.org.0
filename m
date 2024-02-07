Return-Path: <bpf+bounces-21443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0884D5D9
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534CC1F251E9
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF170200DB;
	Wed,  7 Feb 2024 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTppDiK9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53C1EB3B
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345433; cv=none; b=VytNxrOjfwwxg0WAsJ5TkwI6qgBcFZVtxsCLU1zwSJpITehXVbnNaWgci023Z0+UXK44BoRiqOxrARW2xNTgKxoT/uYbQw4g4fHDnll1D6bfWxdYTPgAOhXb0UZHQxBgsTWAaxq1i1ehm4gPXgG/IWQnUvxq5tKXGvssoanhtAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345433; c=relaxed/simple;
	bh=RZxmraRvUZVDCEnHDiKvvvCrdlGpPV4CU1ch1xpR8Ps=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sPQpjoP/7gwxPPeWJLH8gfM6t1iZA2B/u/GZy5IVyPdFPhvgPG8GwCY00urSYNWStcz5FDRlmzQLj5hdkKe/sjYFLQLZhKrl9OlIZo1pOwLKv+4rk6G7KODlb4Lpm3aboaNzVaoOtw2WhCvPNcBaQbB29fpZq8joH78Sqa9OQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTppDiK9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604a4923adaso2674757b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707345430; x=1707950230; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKYKLMrv5V+KXHpHJf+OrewS1WtN3SExz8bYkY92f/Q=;
        b=PTppDiK9MqwA29qsozPiSPPd/sEqX7IlOGnkXq1agwOQJLdBNDap/uUp/4gxPILEuA
         do7Sa7okhuVM52a/AYqjC2//z9kTK5RN0KxyQxxWOgrBmivwTOEAMR2XbkjEWoumia9n
         uaV7+jUWKa6wyeEY+zRy/xeykUv51+LcpnWMIu7VC8Iy5fQWJzetBUCIfnmRjoC4pXsK
         viq2eTD8CuQr2GrcHeKht44GzwnnYInwYZaiBYkx0NK4uFghYVsdLXfNahbHdFDuMq7u
         YrpgAvFRO18Mym1UKvKZGMQfRl0ocrY5VTibRC6vvXqSCnDDk0bCmKioLQ5XwVGni8Qh
         CmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707345430; x=1707950230;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKYKLMrv5V+KXHpHJf+OrewS1WtN3SExz8bYkY92f/Q=;
        b=h1XWLqfATGNg/qmAPjmVW36McPgaj7LwlAzQJkronXeRMblXCriY971mLP1/r5dYIX
         C+1jlAnq9Zps7NnI/GZqflrfGyrM1+Qx+phQJU6dc2qrvM2vKsOvEET2uY9Rh4rVNcRh
         afH5dnzkzjSH3DX5hy0ew6k9M1Gk4UFzrEDAk/b57Sq3CGtKT5aLwO9q+kKlLioKDafR
         khp+30I4kqmwpm1DS4qQ/EGGwUTzNHQ802ZBxRHEOxMsLZ24/z6FY2f4fx57xVQLzuCC
         X/pH9vfTpNvxAQMAnZgi+UmMqh9fcHoi8vCmJEJb+UK8oo7nlX0ztcujtHAVc3bmeVzd
         RwwA==
X-Gm-Message-State: AOJu0YzC3L93Z3KE4AeeDP0xqg0SZ7bFpoAO2Z1nsvfzKxdRrl949wJF
	a0g+mKbjLqXS6/JBRn4P2BjL/Lf3e1hLx1gIGkHM+4q57bf+pes7vgtaRoyab+QRk5QZdjYS1oC
	+vPKS6g==
X-Google-Smtp-Source: AGHT+IGyE0p17s5uo7V3RHmoONRX8hVPnohVhRU2VoBUS4dkcuDetwyIIVArQIbS0lUAzqUii6oV6GuEek1m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b420:757c:5706:d53b])
 (user=irogers job=sendgmr) by 2002:a81:574c:0:b0:5ff:5389:526c with SMTP id
 l73-20020a81574c000000b005ff5389526cmr927894ywb.2.1707345430452; Wed, 07 Feb
 2024 14:37:10 -0800 (PST)
Date: Wed,  7 Feb 2024 14:36:35 -0800
In-Reply-To: <20240207223639.3139601-1-irogers@google.com>
Message-Id: <20240207223639.3139601-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207223639.3139601-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 2/6] perf maps: Get map before returning in maps__find
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/tests/dwarf-unwind.c |  1 +
 tools/perf/tests/vmlinux-kallsyms.c      |  5 ++---
 tools/perf/util/bpf-event.c              |  1 +
 tools/perf/util/event.c                  |  4 ++--
 tools/perf/util/machine.c                | 22 ++++++++--------------
 tools/perf/util/maps.c                   | 17 ++++++++++-------
 tools/perf/util/symbol.c                 |  3 ++-
 7 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 5bfec3345d59..c05c0a85dad4 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -34,6 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
 	}
 
 	stack_size = map__end(map) - sp;
+	map__put(map);
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 822f893e67d5..e808e6fc8f76 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -151,10 +151,8 @@ static int test__vmlinux_matches_kallsyms_cb2(struct map *map, void *data)
 	u64 mem_end = map__unmap_ip(args->vmlinux_map, map__end(map));
 
 	pair = maps__find(args->kallsyms.kmaps, mem_start);
-	if (pair == NULL || map__priv(pair))
-		return 0;
 
-	if (map__start(pair) == mem_start) {
+	if (pair != NULL && !map__priv(pair) && map__start(pair) == mem_start) {
 		struct dso *dso = map__dso(map);
 
 		if (!args->header_printed) {
@@ -170,6 +168,7 @@ static int test__vmlinux_matches_kallsyms_cb2(struct map *map, void *data)
 		pr_info(" %s\n", dso->name);
 		map__set_priv(pair, 1);
 	}
+	map__put(pair);
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 3573e0b7ef3e..83709146a48a 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -63,6 +63,7 @@ static int machine__process_bpf_event_load(struct machine *machine,
 			dso->bpf_prog.id = id;
 			dso->bpf_prog.sub_id = i;
 			dso->bpf_prog.env = env;
+			map__put(map);
 		}
 	}
 	return 0;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 68f45e9e63b6..198903157f9e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -511,7 +511,7 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
 		struct addr_location al;
 
 		addr_location__init(&al);
-		al.map = map__get(maps__find(machine__kernel_maps(machine), tp->addr));
+		al.map = maps__find(machine__kernel_maps(machine), tp->addr);
 		if (al.map && map__load(al.map) >= 0) {
 			al.addr = map__map_ip(al.map, tp->addr);
 			al.sym = map__find_symbol(al.map, al.addr);
@@ -641,7 +641,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		return NULL;
 	}
 	al->maps = maps__get(maps);
-	al->map = map__get(maps__find(maps, al->addr));
+	al->map = maps__find(maps, al->addr);
 	if (al->map != NULL) {
 		/*
 		 * Kernel maps might be changed when loading symbols so loading
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b397a769006f..e8eb9f0b073f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -896,7 +896,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct symbol *sym;
 	struct dso *dso;
 	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
-	bool put_map = false;
 	int err = 0;
 
 	if (!map) {
@@ -913,12 +912,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			err = -ENOMEM;
 			goto out;
 		}
-		/*
-		 * The inserted map has a get on it, we need to put to release
-		 * the reference count here, but do it after all accesses are
-		 * done.
-		 */
-		put_map = true;
 		if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_OOL) {
 			dso->binary_type = DSO_BINARY_TYPE__OOL;
 			dso->data.file_size = event->ksymbol.len;
@@ -952,8 +945,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	}
 	dso__insert_symbol(dso, sym);
 out:
-	if (put_map)
-		map__put(map);
+	map__put(map);
 	return err;
 }
 
@@ -977,7 +969,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 		if (sym)
 			dso__delete_symbol(dso, sym);
 	}
-
+	map__put(map);
 	return 0;
 }
 
@@ -1005,11 +997,11 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 		perf_event__fprintf_text_poke(event, machine, stdout);
 
 	if (!event->text_poke.new_len)
-		return 0;
+		goto out;
 
 	if (cpumode != PERF_RECORD_MISC_KERNEL) {
 		pr_debug("%s: unsupported cpumode - ignoring\n", __func__);
-		return 0;
+		goto out;
 	}
 
 	if (dso) {
@@ -1032,7 +1024,8 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 		pr_debug("Failed to find kernel text poke address map for %#" PRI_lx64 "\n",
 			 event->text_poke.addr);
 	}
-
+out:
+	map__put(map);
 	return 0;
 }
 
@@ -1300,9 +1293,10 @@ static int machine__map_x86_64_entry_trampolines_cb(struct map *map, void *data)
 		return 0;
 
 	dest_map = maps__find(args->kmaps, map__pgoff(map));
-	if (dest_map != map)
+	if (RC_CHK_ACCESS(dest_map) != RC_CHK_ACCESS(map))
 		map__set_pgoff(map, map__map_ip(dest_map, map__pgoff(map)));
 
+	map__put(dest_map);
 	args->found = true;
 	return 0;
 }
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 45da1ec3630c..3336d540c577 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -500,15 +500,18 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 {
 	struct map *map = maps__find(maps, addr);
+	struct symbol *result = NULL;
 
 	/* Ensure map is loaded before using map->map_ip */
 	if (map != NULL && map__load(map) >= 0) {
-		if (mapp != NULL)
-			*mapp = map; // TODO: map_put on else path when find returns a get.
-		return map__find_symbol(map, map__map_ip(map, addr));
-	}
+		if (mapp)
+			*mapp = map;
 
-	return NULL;
+		result = map__find_symbol(map, map__map_ip(map, addr));
+		if (!mapp)
+			map__put(map);
+	}
+	return result;
 }
 
 struct maps__find_symbol_by_name_args {
@@ -552,7 +555,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
 		if (maps == NULL)
 			return -1;
-		ams->ms.map = maps__find(maps, ams->addr);  // TODO: map_get
+		ams->ms.map = maps__find(maps, ams->addr);
 		if (ams->ms.map == NULL)
 			return -1;
 	}
@@ -862,7 +865,7 @@ struct map *maps__find(struct maps *maps, u64 ip)
 					sizeof(*mapp), map__addr_cmp);
 
 			if (mapp)
-				result = *mapp; // map__get(*mapp);
+				result = map__get(*mapp);
 			done = true;
 		}
 		up_read(maps__lock(maps));
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index be212ba157dc..1710b89e207c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -757,7 +757,6 @@ static int dso__load_all_kallsyms(struct dso *dso, const char *filename)
 
 static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 {
-	struct map *curr_map;
 	struct symbol *pos;
 	int count = 0;
 	struct rb_root_cached old_root = dso->symbols;
@@ -770,6 +769,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	*root = RB_ROOT_CACHED;
 
 	while (next) {
+		struct map *curr_map;
 		struct dso *curr_map_dso;
 		char *module;
 
@@ -796,6 +796,7 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 			pos->end -= map__start(curr_map) - map__pgoff(curr_map);
 		symbols__insert(&curr_map_dso->symbols, pos);
 		++count;
+		map__put(curr_map);
 	}
 
 	/* Symbols have been adjusted */
-- 
2.43.0.594.gd9cf4e227d-goog


