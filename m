Return-Path: <bpf+bounces-58692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3678BABFF80
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 00:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DCA18966EE
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0C423C8A1;
	Wed, 21 May 2025 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/rwSt7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2E823BCEF
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866458; cv=none; b=VEBxrDUMH2m5A1wLUo8q2dUA3MNgSWaK4wxezIbW0mmee0yYAOBq1uJWvj5YjLG1lNYPWqJZ/HWdddITRSZ5rjJkrYxpty1TSr49AwPbHRmBMjA7RjFUy1NbEY1mKHoBbGlXfzcFmM/2jBEvL2vY6fM7VXRN4Y3U9JrOBSmC3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866458; c=relaxed/simple;
	bh=YYB7ay2XZ2UC9vhXiivQ9Qog0KQ0BcG5GWpUEKVELGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MVPnQxIoUInIE59FTGHDudaREQ6JW2xb4gy12ANJ1ggv0nhZ4tPt2FgYjXJM5JqMmwORi5HjS3PhZnAYHpZzcFpIqcCCbkQigmWgCXr3y9z5TeO+j90NqlG8u6gxEBXqY0r1tjGaPkamEpeJmniSxTvt1Ta+MStrhCGO5aWdQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/rwSt7R; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73bfc657aefso5462166b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747866456; x=1748471256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcDBUrG9Rt/ZHj/u5g5h7BamQXJVoaPyall+VOpEmVg=;
        b=n/rwSt7RQ/Nj8KkXyYh7w/ky0clPrK0UnrZBvbqk/SPWVkjIv9K6tztNqMxRlWlLAe
         mZvu2vC26syTy19PIU4STRZV7F/SUURN2XB3VZ2CDtpc8lLfLXcjmSgECPMJs9SiRpF6
         N5lx/OtLz7Ii1dhd9xCPGAl6bJdcEjT1mcwmPm7oe4uqtkd3p6afV9NCYgrJc28vR4KT
         yFFhF53cXYjnybHeSTjCUTtvispqsfrzSythBTRECSYogFefUM9aTSbbUnjLFmVsmv79
         OVbcQcCdRZjvioQFQ4Mbf1HG/j8DzFCwUHqqT2ZchHSxym5VLn8+bQg9tWKy2WkdoLyL
         S1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747866456; x=1748471256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcDBUrG9Rt/ZHj/u5g5h7BamQXJVoaPyall+VOpEmVg=;
        b=cb3VhCpQ+Ryw5azqE9Pm4uba0/eM7gA73c/oU8TC6cP0DJe25qE0zJUsG7XikpbzaX
         FSY4Wx480dD8KtXnXIJAGM2OgEmKchY7n2xMd8wj20MUT5DuWb/9gSs57nqCa+WBgkqC
         itDB0hSAFQL76FbXDbTSGIgAn6i0FFi8P8O118+YsA/CEQb3RoqbqIVyO6FKhxmatB6s
         NMQmz02hog0qLG0MXR+QxT3myngvDF+U2w8TowibM30eMf1ABVcdY9N6R9nEtqxUug0/
         dBZuI7XfN8MQ54nudwCXKxQdrW1WEfqgn6z+TwJ666EN1oksilWXpt2ROuHxE60Vd8F5
         Wj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIqZgSjVHsBJlwWajO0jAvTn/vMhoILEmwb5/rSA+mQph7B+lQXlUXdmLW1JsHY18dlcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8fy6OuAf/Y8iYrikhZ1Nqb3h2Bq8w2iDsaothM6rqia/0iPQ
	resKJu5u3bWezJ/BCW5uOSl/R6XL4r+2Uwa0aqJ9JP6TrM01DyWhWXuQ7NsGWrQnINzU+4yGbFS
	xoDaQ0prRObJ3O5VkwbbMaQ==
X-Google-Smtp-Source: AGHT+IFf0gEcrt2DaqwzhkUNz7mVUXeJdUFtOelSLdDPz/TcjQIS84dfzKUQ6LOF4dcmBbsGH8K+O4CUlfY9WzAQ
X-Received: from pfwo11.prod.google.com ([2002:a05:6a00:1bcb:b0:736:3cd5:ba3f])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2304:b0:739:50c0:b3fe with SMTP id d2e1a72fcca58-742a97ab076mr35274944b3a.8.1747866456246;
 Wed, 21 May 2025 15:27:36 -0700 (PDT)
Date: Wed, 21 May 2025 15:27:24 -0700
In-Reply-To: <20250521222725.3895192-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Message-ID: <20250521222725.3895192-3-blakejones@google.com>
Subject: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
From: Blake Jones <blakejones@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

Look for .rodata maps, find ones with 'bpf_metadata_' variables, extract
their values as strings, and create a new PERF_RECORD_BPF_METADATA
synthetic event using that data. The code gets invoked from the existing
routine perf_event__synthesize_one_bpf_prog().

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/lib/perf/include/perf/event.h |  18 ++
 tools/perf/util/bpf-event.c         | 310 ++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h         |  13 ++
 3 files changed, 341 insertions(+)

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
index c81444059ad0..36d5676f025e 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -1,13 +1,20 @@
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
 #include <internal/lib.h>
+#include <perf/event.h>
 #include <symbol/kallsyms.h>
 #include "bpf-event.h"
 #include "bpf-utils.h"
@@ -151,6 +158,298 @@ static int synthesize_bpf_prog_name(char *buf, int size,
 	return name_len;
 }
 
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
+	/* If there aren't any variables with the "bpf_metadata_" prefix,
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
+	rodata = calloc(1, map_info.value_size);
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
+		.print_strings = 1,
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
+void bpf_metadata_free(struct bpf_metadata *metadata)
+{
+	if (metadata == NULL)
+		return;
+	for (__u32 index = 0; index < metadata->nr_prog_names; index++)
+		free(metadata->prog_names[index]);
+	if (metadata->prog_names != NULL)
+		free(metadata->prog_names);
+	if (metadata->event != NULL)
+		free(metadata->event);
+	free(metadata);
+}
+
+static struct bpf_metadata *bpf_metadata_alloc(__u32 nr_prog_tags,
+					       __u32 nr_variables)
+{
+	struct bpf_metadata *metadata;
+
+	metadata = calloc(1, sizeof(struct bpf_metadata));
+	if (!metadata)
+		return NULL;
+
+	metadata->prog_names = calloc(nr_prog_tags, sizeof(char *));
+	if (!metadata->prog_names) {
+		bpf_metadata_free(metadata);
+		return NULL;
+	}
+	for (__u32 prog_index = 0; prog_index < nr_prog_tags; prog_index++) {
+		metadata->prog_names[prog_index] = calloc(BPF_PROG_NAME_LEN,
+							  sizeof(char));
+		if (!metadata->prog_names[prog_index]) {
+			bpf_metadata_free(metadata);
+			return NULL;
+		}
+		metadata->nr_prog_names++;
+	}
+
+	metadata->event_size = sizeof(metadata->event->bpf_metadata) +
+	    nr_variables * sizeof(metadata->event->bpf_metadata.entries[0]);
+	metadata->event = calloc(1, metadata->event_size);
+	if (!metadata->event) {
+		bpf_metadata_free(metadata);
+		return NULL;
+	}
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
+		struct perf_record_bpf_metadata *bpf_metadata_event;
+		struct bpf_metadata_map map;
+
+		if (bpf_metadata_read_map_data(map_ids[map_index], &map) != 0)
+			continue;
+
+		metadata = bpf_metadata_alloc(info->nr_prog_tags, map.num_vars);
+		if (!metadata)
+			continue;
+
+		bpf_metadata_event = &metadata->event->bpf_metadata;
+		*bpf_metadata_event = (struct perf_record_bpf_metadata) {
+			.header = {
+				.type = PERF_RECORD_BPF_METADATA,
+				.size = metadata->event_size,
+			},
+			.nr_entries = 0,
+		};
+		bpf_metadata_fill_event(&map, bpf_metadata_event);
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
+	union perf_event *event;
+	int err = 0;
+
+	event = calloc(1, metadata->event_size + machine->id_hdr_size);
+	if (!event)
+		return -1;
+	memcpy(event, metadata->event, metadata->event_size);
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
 /*
  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
@@ -173,6 +472,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	const struct perf_tool *tool = session->tool;
 	struct bpf_prog_info_node *info_node;
 	struct perf_bpil *info_linear;
+	struct bpf_metadata *metadata;
 	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
 	struct perf_env *env;
@@ -193,6 +493,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	arrays |= 1UL << PERF_BPIL_JITED_INSNS;
 	arrays |= 1UL << PERF_BPIL_LINE_INFO;
 	arrays |= 1UL << PERF_BPIL_JITED_LINE_INFO;
+	arrays |= 1UL << PERF_BPIL_MAP_IDS;
 
 	info_linear = get_bpf_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
@@ -301,6 +602,15 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
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
index e2f0420905f5..007f0b4d21cb 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -17,6 +17,13 @@ struct record_opts;
 struct evlist;
 struct target;
 
+struct bpf_metadata {
+	union perf_event *event;
+	size_t		 event_size;
+	char		 **prog_names;
+	__u64		 nr_prog_names;
+};
+
 struct bpf_prog_info_node {
 	struct perf_bpil		*info_linear;
 	struct rb_node			rb_node;
@@ -36,6 +43,7 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
 void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 				      struct perf_env *env,
 				      FILE *fp);
+void bpf_metadata_free(struct bpf_metadata *metadata);
 #else
 static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 				       union perf_event *event __maybe_unused,
@@ -55,6 +63,11 @@ static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info _
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
2.49.0.1143.g0be31eac6b-goog


