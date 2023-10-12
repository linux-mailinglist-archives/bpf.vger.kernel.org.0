Return-Path: <bpf+bounces-12007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC32A7C657F
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62549282955
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D520BD525;
	Thu, 12 Oct 2023 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEsMd4mP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35428D50E
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:46 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1991D45
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a39444700so1521065276.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091875; x=1697696675; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ROvqMh8j+zKvWbIwAMh3UVBHyePHtFkWdSWTbYfkrk=;
        b=qEsMd4mP5hXoihm5RuLvG3X4V8L8ImJ4jmvEBU/Q6Q/kwQptfvKbz3xp+sL9IDDaPF
         /18gUKoKZdbPON7uuYB4VY5mMRHmRONyl9wJ8QHT9mlQh/0DUYuYKiw1uGhtsBcZjYXV
         5DGuNPbT8fA++tS+XbFWvhMULlpfS8jJLdn63L0gupfKTlaU7AOx/CERFD/DkvqBKup/
         TzcIhWzmxg6B2hYOBT1JsGjbg1O04i5XQ0p8PUV9/iQxjqewgd6USXxohPZVyV7wYvjo
         6BhjUUsj6uvsaB1EiCjxkUD5Sk340LLePRbFzHHl6Je3qFJRHOIWjrgJaeayjltmWQAE
         NL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091875; x=1697696675;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ROvqMh8j+zKvWbIwAMh3UVBHyePHtFkWdSWTbYfkrk=;
        b=oPkMshEZjth6IhfLR/unyNkI1XhNnMtQM4UioH7a3BebO7MaXI4jzEz58Y5lmmmqjW
         EdofgXqb/JdSyRUom9DR/K08rAI5zRgWASeaYlesjT0xeW7mDCfaZA6zkoeq4tiBEXbA
         YtrWqoMo6Osa5vyZ3lU9AIdpJd+4D/Ji9t1W2yMPjCpjZiZ4HB+z90GAvrDU4c+UUpWv
         CCQ4MqB182+l3ILbybRsogmMIBkq9kcDskxy+UlRWhXAILt7j18+SHT8J0wiz3LZmQIF
         5ZHIFrzhieL84iFNDDbVZpoOnitKfxpXlrvnEiwP2HDdjA4UOETpRZaKSr9Q11wfeQDX
         PRKQ==
X-Gm-Message-State: AOJu0YwvsaALJIPm7QoDNZtqpEqa64apbnijgYjWM9QmUEQnRuEC5eT1
	bqwtic85ZFPRZVGyGfI3oRW6CTpEf9IB
X-Google-Smtp-Source: AGHT+IElPpe9ROkbPj/gSrX4PpIF3QfcJEzXpV4BI/ZOllHK2Yme467dIHTq3079kx4WiY289sHIucoJATLT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:1f45:0:b0:d8a:fcdb:d670 with SMTP id
 f66-20020a251f45000000b00d8afcdbd670mr489117ybf.1.1697091875173; Wed, 11 Oct
 2023 23:24:35 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:58 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 12/13] perf mmap: Lazily initialize zstd streams
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Zstd streams create dictionaries that can require significant RAM,
especially when there is one per-CPU. Tools like perf record won't use
the streams without the -z option, and so the creation of the streams
is pure overhead. Switch to creating the streams on first use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/compress.h |  1 +
 tools/perf/util/mmap.c     |  5 ++--
 tools/perf/util/mmap.h     |  1 -
 tools/perf/util/zstd.c     | 61 ++++++++++++++++++++------------------
 4 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 0cd3369af2a4..9391850f1a7e 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -21,6 +21,7 @@ struct zstd_data {
 #ifdef HAVE_ZSTD_SUPPORT
 	ZSTD_CStream	*cstream;
 	ZSTD_DStream	*dstream;
+	int comp_level;
 #endif
 };
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 49093b21ee2d..122ee198a86e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -295,15 +295,14 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
 
 	map->core.flush = mp->flush;
 
-	map->comp_level = mp->comp_level;
 #ifndef PYTHON_PERF
-	if (zstd_init(&map->zstd_data, map->comp_level)) {
+	if (zstd_init(&map->zstd_data, mp->comp_level)) {
 		pr_debug2("failed to init mmap compressor, error %d\n", errno);
 		return -1;
 	}
 #endif
 
-	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
+	if (mp->comp_level && !perf_mmap__aio_enabled(map)) {
 		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
 				 MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 		if (map->data == MAP_FAILED) {
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index f944c3cd5efa..0df6e1621c7e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -39,7 +39,6 @@ struct mmap {
 #endif
 	struct mmap_cpu_mask	affinity_mask;
 	void		*data;
-	int		comp_level;
 	struct perf_data_file *file;
 	struct zstd_data      zstd_data;
 };
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 48dd2b018c47..60f2d749b1c0 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -7,35 +7,9 @@
 
 int zstd_init(struct zstd_data *data, int level)
 {
-	size_t ret;
-
-	data->dstream = ZSTD_createDStream();
-	if (data->dstream == NULL) {
-		pr_err("Couldn't create decompression stream.\n");
-		return -1;
-	}
-
-	ret = ZSTD_initDStream(data->dstream);
-	if (ZSTD_isError(ret)) {
-		pr_err("Failed to initialize decompression stream: %s\n", ZSTD_getErrorName(ret));
-		return -1;
-	}
-
-	if (!level)
-		return 0;
-
-	data->cstream = ZSTD_createCStream();
-	if (data->cstream == NULL) {
-		pr_err("Couldn't create compression stream.\n");
-		return -1;
-	}
-
-	ret = ZSTD_initCStream(data->cstream, level);
-	if (ZSTD_isError(ret)) {
-		pr_err("Failed to initialize compression stream: %s\n", ZSTD_getErrorName(ret));
-		return -1;
-	}
-
+	data->comp_level = level;
+	data->dstream = NULL;
+	data->cstream = NULL;
 	return 0;
 }
 
@@ -63,6 +37,21 @@ size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t
 	ZSTD_outBuffer output;
 	void *record;
 
+	if (!data->cstream) {
+		data->cstream = ZSTD_createCStream();
+		if (data->cstream == NULL) {
+			pr_err("Couldn't create compression stream.\n");
+			return -1;
+		}
+
+		ret = ZSTD_initCStream(data->cstream, data->comp_level);
+		if (ZSTD_isError(ret)) {
+			pr_err("Failed to initialize compression stream: %s\n",
+				ZSTD_getErrorName(ret));
+			return -1;
+		}
+	}
+
 	while (input.pos < input.size) {
 		record = dst;
 		size = process_header(record, 0);
@@ -96,6 +85,20 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 	ZSTD_inBuffer input = { src, src_size, 0 };
 	ZSTD_outBuffer output = { dst, dst_size, 0 };
 
+	if (!data->dstream) {
+		data->dstream = ZSTD_createDStream();
+		if (data->dstream == NULL) {
+			pr_err("Couldn't create decompression stream.\n");
+			return -1;
+		}
+
+		ret = ZSTD_initDStream(data->dstream);
+		if (ZSTD_isError(ret)) {
+			pr_err("Failed to initialize decompression stream: %s\n",
+				ZSTD_getErrorName(ret));
+			return -1;
+		}
+	}
 	while (input.pos < input.size) {
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
-- 
2.42.0.609.gbb76f46606-goog


