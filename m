Return-Path: <bpf+bounces-59958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28712AD09BE
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D35A3B3FE9
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E1623ED6A;
	Fri,  6 Jun 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFqnDDXj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82B23D29B
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246777; cv=none; b=cZtk3ndxrlp9DZN0ge093WGBSf6HU3updzYxlE//tLqLvP222g5h/ABlpdT5e2oGJVz7rqjGVByftj6TBC4nJjGAiBIjxXHeeGJRoKAmdzPI8id3bGGnUQQF1p25PIo0Tt4vI9HauunJUVhsyabKd5DUjOAjPoTddsMvzdvVoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246777; c=relaxed/simple;
	bh=lv+bM4moTnKOGlGoG2cAgW1utmnJXzA7idT/X6DTndA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S1DZhI+mqdnEqzXomtIZOILGaOpgsP59RKvyF5Th86nebDwFziviiLzaceU8CwKHLColNOzkFdqqoHYMSgwZjHOD/g3DHHnM4sYuNO2M4eBua1fqVbIN1hBPbRmotKBi/JQNbiM63hT0d4CsbBcZcfLug6jSCxaLSPpaQVQcKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFqnDDXj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so3212465a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749246774; x=1749851574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=slKzUD48tkq9i10Iz9b2HZco4LcIFVLTatkKbkE7Sdg=;
        b=kFqnDDXjxgrkpGIJE4QVRIuH3T9oUGNwkLFeO8SKY1UMB850XHTqntDA09hu3XvnS2
         nrgCwLytlQ3c5XvL2hvomgB43YMgwICPPDYnuWQE5wACVKqKDPf9kkX1FQ6RoUrvosPY
         RsPpDp/9BU30T7ugSHxb5uG7JwThprZhzRKJSIBP0hgtkbqpax12NBz3SgLMZQ1WP/k1
         E35nb6E1AG067qxF6er+gCivzIS16nkkcvybAf8YetUr3PLOjAT/bzDsBe1TQ7dUfLA/
         BOofQHUkurTw3PF63fbyud6VSRzaqC5HADvsrgx0PKiOtm9keXQw+l61ri2WcK4qxV55
         h6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246774; x=1749851574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slKzUD48tkq9i10Iz9b2HZco4LcIFVLTatkKbkE7Sdg=;
        b=CodRx2pw8bSf4xxkhZK4131nwOQM/km9whZR2ECLcLBOg31uRSq7myhCr+/i5uHp7C
         elDiUcsCEpB1aiFnMhQ3n8Lr4A+8Xp+0Y+BaBdFdfGfPDsEWxUtzGY1xwogVoegg37sd
         qv5dTfobT/mdKdNY2D2BDSGh3jQvgp9QAgzkD9boPLHW3G7oVFkT5X0PXLy0x2kI8e4o
         DMXErHnsY2sPNM8RmSZpfBW7QcIjRFMg9sgd7ka7AlS3SL1dJcqym5J5qhHwiqqza2jH
         V2x/lM9eIo4Xz3uxR/Tzo1XjFd5w2+T7NkSPR3FqqxLSMAefWx0lfeG4Ze4EIVi0qDXa
         oLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjz0ZEVY2faE/9acEzpSfT51kwgbptPrGHThWUOhWQpTvNPrA/yQraGPe/0jiIs6SFIDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNSUT8wk+geLZlImnE1z0gyLdMrg1dJMif3rHvw4riHq9qgyP+
	eDiJwGOmqUZEe13WqKmM703GxSBVKU+73YKFWEls2/G93xZQAi3OFlpNio92no0XRmxn4z0hyov
	ehjjzfp3Kj7IHSLf4+hcK3g==
X-Google-Smtp-Source: AGHT+IH9OKDmiuyxsq7eGthfr+1SBBAtvBz2KikWHiT6h2hbtjF4zNjHaav0zRN18sqs2hVDsbWG2mWLzbOwmKOs
X-Received: from pjbsi11.prod.google.com ([2002:a17:90b:528b:b0:312:1c59:43a6])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:dfc6:b0:311:b6d2:4c36 with SMTP id 98e67ed59e1d1-3134768b6c7mr5977145a91.26.1749246774667;
 Fri, 06 Jun 2025 14:52:54 -0700 (PDT)
Date: Fri,  6 Jun 2025 14:52:43 -0700
In-Reply-To: <20250606215246.2419387-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250606215246.2419387-3-blakejones@google.com>
Subject: [PATCH v3 2/5] perf: collect BPF metadata from existing BPF programs
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

Look for .rodata maps, find ones with 'bpf_metadata_' variables, extract
their values as strings, and create a new PERF_RECORD_BPF_METADATA
synthetic event using that data. The code gets invoked from the existing
routine perf_event__synthesize_one_bpf_prog().

For example, a BPF program with the following variables:

    const char bpf_metadata_version[] SEC(".rodata") = "3.14159";
    int bpf_metadata_value[] SEC(".rodata") = 42;

would generate a PERF_RECORD_BPF_METADATA record with:

    .prog_name        = <BPF program name, e.g. "bpf_prog_a1b2c3_foo">
    .nr_entries       = 2
    .entries[0].key   = "version"
    .entries[0].value = "3.14159"
    .entries[1].key   = "value"
    .entries[1].value = "42"

Each of the BPF programs and subprograms that share those variables would
get a distinct PERF_RECORD_BPF_METADATA record, with the ".prog_name"
showing the name of each program or subprogram. The prog_name is
deliberately the same as the ".name" field in the corresponding
PERF_RECORD_KSYMBOL record.

This code only gets invoked if support for displaying BTF char arrays
as strings is detected.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/lib/perf/include/perf/event.h |  18 ++
 tools/perf/util/bpf-event.c         | 332 ++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h         |  12 +
 3 files changed, 362 insertions(+)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 09b7c643ddac..6608f1e3701b 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -467,6 +467,22 @@ struct perf_record_compressed2 {
 	char			 data[];
 };
 
+#define BPF_METADATA_KEY_LEN   64
+#define BPF_METADATA_VALUE_LEN 256
+#define BPF_PROG_NAME_LEN      KSYM_NAME_LEN
+
+struct perf_record_bpf_metadata_entry {
+	char key[BPF_METADATA_KEY_LEN];
+	char value[BPF_METADATA_VALUE_LEN];
+};
+
+struct perf_record_bpf_metadata {
+	struct perf_event_header	      header;
+	char				      prog_name[BPF_PROG_NAME_LEN];
+	__u64				      nr_entries;
+	struct perf_record_bpf_metadata_entry entries[];
+};
+
 enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_USER_TYPE_START		= 64,
 	PERF_RECORD_HEADER_ATTR			= 64,
@@ -489,6 +505,7 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_COMPRESSED			= 81,
 	PERF_RECORD_FINISHED_INIT		= 82,
 	PERF_RECORD_COMPRESSED2			= 83,
+	PERF_RECORD_BPF_METADATA		= 84,
 	PERF_RECORD_HEADER_MAX
 };
 
@@ -530,6 +547,7 @@ union perf_event {
 	struct perf_record_header_feature	feat;
 	struct perf_record_compressed		pack;
 	struct perf_record_compressed2		pack2;
+	struct perf_record_bpf_metadata		bpf_metadata;
 };
 
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index c81444059ad0..1f6e76ee6024 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -1,13 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/err.h>
+#include <linux/perf_event.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <internal/lib.h>
+#include <perf/event.h>
 #include <symbol/kallsyms.h>
 #include "bpf-event.h"
 #include "bpf-utils.h"
@@ -151,6 +159,319 @@ static int synthesize_bpf_prog_name(char *buf, int size,
 	return name_len;
 }
 
+#ifdef HAVE_LIBBPF_STRINGS_SUPPORT
+
+#define BPF_METADATA_PREFIX "bpf_metadata_"
+#define BPF_METADATA_PREFIX_LEN (sizeof(BPF_METADATA_PREFIX) - 1)
+
+static bool name_has_bpf_metadata_prefix(const char **s)
+{
+	if (strncmp(*s, BPF_METADATA_PREFIX, BPF_METADATA_PREFIX_LEN) != 0)
+		return false;
+	*s += BPF_METADATA_PREFIX_LEN;
+	return true;
+}
+
+struct bpf_metadata_map {
+	struct btf *btf;
+	const struct btf_type *datasec;
+	void *rodata;
+	size_t rodata_size;
+	unsigned int num_vars;
+};
+
+static int bpf_metadata_read_map_data(__u32 map_id, struct bpf_metadata_map *map)
+{
+	int map_fd;
+	struct bpf_map_info map_info;
+	__u32 map_info_len;
+	int key;
+	struct btf *btf;
+	const struct btf_type *datasec;
+	struct btf_var_secinfo *vsi;
+	unsigned int vlen, vars;
+	void *rodata;
+
+	map_fd = bpf_map_get_fd_by_id(map_id);
+	if (map_fd < 0)
+		return -1;
+
+	memset(&map_info, 0, sizeof(map_info));
+	map_info_len = sizeof(map_info);
+	if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len) < 0)
+		goto out_close;
+
+	/* If it's not an .rodata map, don't bother. */
+	if (map_info.type != BPF_MAP_TYPE_ARRAY ||
+	    map_info.key_size != sizeof(int) ||
+	    map_info.max_entries != 1 ||
+	    !map_info.btf_value_type_id ||
+	    !strstr(map_info.name, ".rodata")) {
+		goto out_close;
+	}
+
+	btf = btf__load_from_kernel_by_id(map_info.btf_id);
+	if (!btf)
+		goto out_close;
+	datasec = btf__type_by_id(btf, map_info.btf_value_type_id);
+	if (!btf_is_datasec(datasec))
+		goto out_free_btf;
+
+	/*
+	 * If there aren't any variables with the "bpf_metadata_" prefix,
+	 * don't bother.
+	 */
+	vlen = btf_vlen(datasec);
+	vsi = btf_var_secinfos(datasec);
+	vars = 0;
+	for (unsigned int i = 0; i < vlen; i++, vsi++) {
+		const struct btf_type *t_var = btf__type_by_id(btf, vsi->type);
+		const char *name = btf__name_by_offset(btf, t_var->name_off);
+
+		if (name_has_bpf_metadata_prefix(&name))
+			vars++;
+	}
+	if (vars == 0)
+		goto out_free_btf;
+
+	rodata = zalloc(map_info.value_size);
+	if (!rodata)
+		goto out_free_btf;
+	key = 0;
+	if (bpf_map_lookup_elem(map_fd, &key, rodata)) {
+		free(rodata);
+		goto out_free_btf;
+	}
+	close(map_fd);
+
+	map->btf = btf;
+	map->datasec = datasec;
+	map->rodata = rodata;
+	map->rodata_size = map_info.value_size;
+	map->num_vars = vars;
+	return 0;
+
+out_free_btf:
+	btf__free(btf);
+out_close:
+	close(map_fd);
+	return -1;
+}
+
+struct format_btf_ctx {
+	char *buf;
+	size_t buf_size;
+	size_t buf_idx;
+};
+
+static void format_btf_cb(void *arg, const char *fmt, va_list ap)
+{
+	int n;
+	struct format_btf_ctx *ctx = (struct format_btf_ctx *)arg;
+
+	n = vsnprintf(ctx->buf + ctx->buf_idx, ctx->buf_size - ctx->buf_idx,
+		      fmt, ap);
+	ctx->buf_idx += n;
+	if (ctx->buf_idx >= ctx->buf_size)
+		ctx->buf_idx = ctx->buf_size;
+}
+
+static void format_btf_variable(struct btf *btf, char *buf, size_t buf_size,
+				const struct btf_type *t, const void *btf_data)
+{
+	struct format_btf_ctx ctx = {
+		.buf = buf,
+		.buf_idx = 0,
+		.buf_size = buf_size,
+	};
+	const struct btf_dump_type_data_opts opts = {
+		.sz = sizeof(struct btf_dump_type_data_opts),
+		.skip_names = 1,
+		.compact = 1,
+		.emit_strings = 1,
+	};
+	struct btf_dump *d;
+	size_t btf_size;
+
+	d = btf_dump__new(btf, format_btf_cb, &ctx, NULL);
+	btf_size = btf__resolve_size(btf, t->type);
+	btf_dump__dump_type_data(d, t->type, btf_data, btf_size, &opts);
+	btf_dump__free(d);
+}
+
+static void bpf_metadata_fill_event(struct bpf_metadata_map *map,
+				    struct perf_record_bpf_metadata *bpf_metadata_event)
+{
+	struct btf_var_secinfo *vsi;
+	unsigned int i, vlen;
+
+	memset(bpf_metadata_event->prog_name, 0, BPF_PROG_NAME_LEN);
+	vlen = btf_vlen(map->datasec);
+	vsi = btf_var_secinfos(map->datasec);
+
+	for (i = 0; i < vlen; i++, vsi++) {
+		const struct btf_type *t_var = btf__type_by_id(map->btf,
+							       vsi->type);
+		const char *name = btf__name_by_offset(map->btf,
+						       t_var->name_off);
+		const __u64 nr_entries = bpf_metadata_event->nr_entries;
+		struct perf_record_bpf_metadata_entry *entry;
+
+		if (!name_has_bpf_metadata_prefix(&name))
+			continue;
+
+		if (nr_entries >= (__u64)map->num_vars)
+			break;
+
+		entry = &bpf_metadata_event->entries[nr_entries];
+		memset(entry, 0, sizeof(*entry));
+		snprintf(entry->key, BPF_METADATA_KEY_LEN, "%s", name);
+		format_btf_variable(map->btf, entry->value,
+				    BPF_METADATA_VALUE_LEN, t_var,
+				    map->rodata + vsi->offset);
+		bpf_metadata_event->nr_entries++;
+	}
+}
+
+static void bpf_metadata_free_map_data(struct bpf_metadata_map *map)
+{
+	btf__free(map->btf);
+	free(map->rodata);
+}
+
+static struct bpf_metadata *bpf_metadata_alloc(__u32 nr_prog_tags,
+					       __u32 nr_variables)
+{
+	struct bpf_metadata *metadata;
+	size_t event_size;
+
+	metadata = zalloc(sizeof(struct bpf_metadata));
+	if (!metadata)
+		return NULL;
+
+	metadata->prog_names = zalloc(nr_prog_tags * sizeof(char *));
+	if (!metadata->prog_names) {
+		bpf_metadata_free(metadata);
+		return NULL;
+	}
+	for (__u32 prog_index = 0; prog_index < nr_prog_tags; prog_index++) {
+		metadata->prog_names[prog_index] = zalloc(BPF_PROG_NAME_LEN);
+		if (!metadata->prog_names[prog_index]) {
+			bpf_metadata_free(metadata);
+			return NULL;
+		}
+		metadata->nr_prog_names++;
+	}
+
+	event_size = sizeof(metadata->event->bpf_metadata) +
+	    nr_variables * sizeof(metadata->event->bpf_metadata.entries[0]);
+	metadata->event = zalloc(event_size);
+	if (!metadata->event) {
+		bpf_metadata_free(metadata);
+		return NULL;
+	}
+	metadata->event->bpf_metadata = (struct perf_record_bpf_metadata) {
+		.header = {
+			.type = PERF_RECORD_BPF_METADATA,
+			.size = event_size,
+		},
+		.nr_entries = 0,
+	};
+
+	return metadata;
+}
+
+static struct bpf_metadata *bpf_metadata_create(struct bpf_prog_info *info)
+{
+	struct bpf_metadata *metadata;
+	const __u32 *map_ids = (__u32 *)(uintptr_t)info->map_ids;
+
+	for (__u32 map_index = 0; map_index < info->nr_map_ids; map_index++) {
+		struct bpf_metadata_map map;
+
+		if (bpf_metadata_read_map_data(map_ids[map_index], &map) != 0)
+			continue;
+
+		metadata = bpf_metadata_alloc(info->nr_prog_tags, map.num_vars);
+		if (!metadata)
+			continue;
+
+		bpf_metadata_fill_event(&map, &metadata->event->bpf_metadata);
+
+		for (__u32 index = 0; index < info->nr_prog_tags; index++) {
+			synthesize_bpf_prog_name(metadata->prog_names[index],
+						 BPF_PROG_NAME_LEN, info,
+						 map.btf, index);
+		}
+
+		bpf_metadata_free_map_data(&map);
+
+		return metadata;
+	}
+
+	return NULL;
+}
+
+static int synthesize_perf_record_bpf_metadata(const struct bpf_metadata *metadata,
+					       const struct perf_tool *tool,
+					       perf_event__handler_t process,
+					       struct machine *machine)
+{
+	const size_t event_size = metadata->event->header.size;
+	union perf_event *event;
+	int err = 0;
+
+	event = zalloc(event_size + machine->id_hdr_size);
+	if (!event)
+		return -1;
+	memcpy(event, metadata->event, event_size);
+	memset((void *)event + event->header.size, 0, machine->id_hdr_size);
+	event->header.size += machine->id_hdr_size;
+	for (__u32 index = 0; index < metadata->nr_prog_names; index++) {
+		memcpy(event->bpf_metadata.prog_name,
+		       metadata->prog_names[index], BPF_PROG_NAME_LEN);
+		err = perf_tool__process_synth_event(tool, event, machine,
+						     process);
+		if (err != 0)
+			break;
+	}
+
+	free(event);
+	return err;
+}
+
+void bpf_metadata_free(struct bpf_metadata *metadata)
+{
+	if (metadata == NULL)
+		return;
+	for (__u32 index = 0; index < metadata->nr_prog_names; index++)
+		free(metadata->prog_names[index]);
+	free(metadata->prog_names);
+	free(metadata->event);
+	free(metadata);
+}
+
+#else /* HAVE_LIBBPF_STRINGS_SUPPORT */
+
+static struct bpf_metadata *bpf_metadata_create(struct bpf_prog_info *info __maybe_unused)
+{
+	return NULL;
+}
+
+static int synthesize_perf_record_bpf_metadata(const struct bpf_metadata *metadata __maybe_unused,
+					       const struct perf_tool *tool __maybe_unused,
+					       perf_event__handler_t process __maybe_unused,
+					       struct machine *machine __maybe_unused)
+{
+	return 0;
+}
+
+void bpf_metadata_free(struct bpf_metadata *metadata __maybe_unused)
+{
+}
+
+#endif /* HAVE_LIBBPF_STRINGS_SUPPORT */
+
 /*
  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
@@ -173,6 +494,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	const struct perf_tool *tool = session->tool;
 	struct bpf_prog_info_node *info_node;
 	struct perf_bpil *info_linear;
+	struct bpf_metadata *metadata;
 	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
 	struct perf_env *env;
@@ -193,6 +515,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	arrays |= 1UL << PERF_BPIL_JITED_INSNS;
 	arrays |= 1UL << PERF_BPIL_LINE_INFO;
 	arrays |= 1UL << PERF_BPIL_JITED_LINE_INFO;
+	arrays |= 1UL << PERF_BPIL_MAP_IDS;
 
 	info_linear = get_bpf_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
@@ -301,6 +624,15 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 		 */
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
+
+		/* Synthesize PERF_RECORD_BPF_METADATA */
+		metadata = bpf_metadata_create(info);
+		if (metadata != NULL) {
+			err = synthesize_perf_record_bpf_metadata(metadata,
+								  tool, process,
+								  machine);
+			bpf_metadata_free(metadata);
+		}
 	}
 
 out:
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index e2f0420905f5..16644b3aaba1 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -17,6 +17,12 @@ struct record_opts;
 struct evlist;
 struct target;
 
+struct bpf_metadata {
+	union perf_event *event;
+	char		 **prog_names;
+	__u64		 nr_prog_names;
+};
+
 struct bpf_prog_info_node {
 	struct perf_bpil		*info_linear;
 	struct rb_node			rb_node;
@@ -36,6 +42,7 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
 void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 				      struct perf_env *env,
 				      FILE *fp);
+void bpf_metadata_free(struct bpf_metadata *metadata);
 #else
 static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 				       union perf_event *event __maybe_unused,
@@ -55,6 +62,11 @@ static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info _
 						    FILE *fp __maybe_unused)
 {
 
+}
+
+static inline void bpf_metadata_free(struct bpf_metadata *metadata)
+{
+
 }
 #endif // HAVE_LIBBPF_SUPPORT
 #endif
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


