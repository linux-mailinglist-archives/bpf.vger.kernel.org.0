Return-Path: <bpf+bounces-11765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200AE7BE9E3
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA98C281BAC
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729813B290;
	Mon,  9 Oct 2023 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvSI3xcv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A733B288
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:40:24 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B11610C1
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:40:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f53027158so73031557b3.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876808; x=1697481608; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2w50121eaJxmD5xi4lyi9EP2qbUj9KHP7ryysYJjsrs=;
        b=LvSI3xcv1Pv0J5NIglp/ZC6IwgLyvnx/moBjo7CLmpirHKURidYO8kyPX5ATJN+/9X
         FIvOxsRuvv331fUYCkfSf+k+oJcwCp/Y92K03TvqsygFXs7jI2ydoWAdxNYCP94Ebs6b
         jFscQG+mTRb3r+0fKFzrQ7x9jTCfWJy67/vbyM7E/QXB+mQSWdElZeZ/N5s8417l03+I
         Xt9s4i6tC/21Q/EGV5aTbgVJQyIEJ0a5H5L2MehRSrkg3BkqVTaNCrymHd58jMnHRbEp
         J64iJyeYt6xjztb2imDCE5Ywax97cgxpyai4P3zAKIbLOmwBr0IHVQRJ7OJwqWdRAU+P
         ui+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876808; x=1697481608;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2w50121eaJxmD5xi4lyi9EP2qbUj9KHP7ryysYJjsrs=;
        b=f3GHUlrMsHbsWVX+1fQVuzeJb13/0/Y5DUkakiF2ZRm1EszMSrF1j0catX+mH8CJLk
         ZHraeZiUyxmrhn8ay4yA2df4D5YpuPadOKHYWEDDrE4896MOr0MdD0x7Kf6lhzLckoKx
         RqvkaphQBHX0INYu1a55LQjLxzAK7/3Y/L95tBq/sc3/H0f0Hp1Tk7F6jU7DnkY6WKzt
         y3NEH1gxXsc0otxvRCWW0vHX8YkXHsKupLLbRg4ySTmJKxI7UQIOu1u1WH2poLHIuLWm
         xFn+0Y6L5HGADMnf9Jz8TQMFYIGra5FTL5z+xCcW0HVGQMaGJm0r6npPOOXt7J3b6yCO
         bF/A==
X-Gm-Message-State: AOJu0YygXYn/MWvwSZVQ4wJmvJ0TucgfB8MCAT6aQ3FxEqtqK9LdQu78
	Fmr7kCC2tnJHuTrFjJy0kUTbrp/g/SGD
X-Google-Smtp-Source: AGHT+IGiCnrYwl2bz9V5BPunBrn18TVaUdmOO32yw1ylQCOt1vaQvnidceAE50bXIJfV7pObT3lh6Dqz9yAl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:bc0d:0:b0:58c:b45f:3e94 with SMTP id
 a13-20020a81bc0d000000b0058cb45f3e94mr290065ywi.8.1696876808338; Mon, 09 Oct
 2023 11:40:08 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:19 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 17/18] perf header: Fix various error path memory leaks
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Memory leaks were detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 60 +++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d812e1e371a7..e86b9439ffee 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2573,7 +2573,7 @@ static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 {
 	u32 nr, i;
-	char *str;
+	char *str = NULL;
 	struct strbuf sb;
 	int cpu_nr = ff->ph->env.nr_cpus_avail;
 	u64 size = 0;
@@ -2601,7 +2601,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
 			goto error;
 		size += string_size(str);
-		free(str);
+		zfree(&str);
 	}
 	ph->env.sibling_cores = strbuf_detach(&sb, NULL);
 
@@ -2620,7 +2620,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
 			goto error;
 		size += string_size(str);
-		free(str);
+		zfree(&str);
 	}
 	ph->env.sibling_threads = strbuf_detach(&sb, NULL);
 
@@ -2684,7 +2684,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
 			goto error;
 		size += string_size(str);
-		free(str);
+		zfree(&str);
 	}
 	ph->env.sibling_dies = strbuf_detach(&sb, NULL);
 
@@ -2699,6 +2699,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 
 error:
 	strbuf_release(&sb);
+	zfree(&str);
 free_cpu:
 	zfree(&ph->env.cpu);
 	return -1;
@@ -2736,10 +2737,9 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		n->map = perf_cpu_map__new(str);
+		free(str);
 		if (!n->map)
 			goto error;
-
-		free(str);
 	}
 	ff->ph->env.nr_numa_nodes = nr;
 	ff->ph->env.numa_nodes = nodes;
@@ -2913,10 +2913,10 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 		return -1;
 
 	for (i = 0; i < cnt; i++) {
-		struct cpu_cache_level c;
+		struct cpu_cache_level *c = &caches[i];
 
 		#define _R(v)						\
-			if (do_read_u32(ff, &c.v))\
+			if (do_read_u32(ff, &c->v))			\
 				goto out_free_caches;			\
 
 		_R(level)
@@ -2926,22 +2926,25 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 		#undef _R
 
 		#define _R(v)					\
-			c.v = do_read_string(ff);		\
-			if (!c.v)				\
-				goto out_free_caches;
+			c->v = do_read_string(ff);		\
+			if (!c->v)				\
+				goto out_free_caches;		\
 
 		_R(type)
 		_R(size)
 		_R(map)
 		#undef _R
-
-		caches[i] = c;
 	}
 
 	ff->ph->env.caches = caches;
 	ff->ph->env.caches_cnt = cnt;
 	return 0;
 out_free_caches:
+	for (i = 0; i < cnt; i++) {
+		free(caches[i].type);
+		free(caches[i].size);
+		free(caches[i].map);
+	}
 	free(caches);
 	return -1;
 }
@@ -3585,18 +3588,16 @@ static int perf_header__adds_write(struct perf_header *header,
 				   struct feat_copier *fc)
 {
 	int nr_sections;
-	struct feat_fd ff;
+	struct feat_fd ff = {
+		.fd  = fd,
+		.ph = header,
+	};
 	struct perf_file_section *feat_sec, *p;
 	int sec_size;
 	u64 sec_start;
 	int feat;
 	int err;
 
-	ff = (struct feat_fd){
-		.fd  = fd,
-		.ph = header,
-	};
-
 	nr_sections = bitmap_weight(header->adds_features, HEADER_FEAT_BITS);
 	if (!nr_sections)
 		return 0;
@@ -3623,6 +3624,7 @@ static int perf_header__adds_write(struct perf_header *header,
 	err = do_write(&ff, feat_sec, sec_size);
 	if (err < 0)
 		pr_debug("failed to write feature section\n");
+	free(ff.buf); /* TODO: added to silence clang-tidy. */
 	free(feat_sec);
 	return err;
 }
@@ -3630,11 +3632,11 @@ static int perf_header__adds_write(struct perf_header *header,
 int perf_header__write_pipe(int fd)
 {
 	struct perf_pipe_file_header f_header;
-	struct feat_fd ff;
+	struct feat_fd ff = {
+		.fd = fd,
+	};
 	int err;
 
-	ff = (struct feat_fd){ .fd = fd };
-
 	f_header = (struct perf_pipe_file_header){
 		.magic	   = PERF_MAGIC,
 		.size	   = sizeof(f_header),
@@ -3645,7 +3647,7 @@ int perf_header__write_pipe(int fd)
 		pr_debug("failed to write perf pipe header\n");
 		return err;
 	}
-
+	free(ff.buf);
 	return 0;
 }
 
@@ -3658,11 +3660,12 @@ static int perf_session__do_write_header(struct perf_session *session,
 	struct perf_file_attr   f_attr;
 	struct perf_header *header = &session->header;
 	struct evsel *evsel;
-	struct feat_fd ff;
+	struct feat_fd ff = {
+		.fd = fd,
+	};
 	u64 attr_offset;
 	int err;
 
-	ff = (struct feat_fd){ .fd = fd};
 	lseek(fd, sizeof(f_header), SEEK_SET);
 
 	evlist__for_each_entry(session->evlist, evsel) {
@@ -3670,6 +3673,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 		err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
 		if (err < 0) {
 			pr_debug("failed to write perf header\n");
+			free(ff.buf);
 			return err;
 		}
 	}
@@ -3695,6 +3699,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 		err = do_write(&ff, &f_attr, sizeof(f_attr));
 		if (err < 0) {
 			pr_debug("failed to write perf header attribute\n");
+			free(ff.buf);
 			return err;
 		}
 	}
@@ -3705,8 +3710,10 @@ static int perf_session__do_write_header(struct perf_session *session,
 
 	if (at_exit) {
 		err = perf_header__adds_write(header, evlist, fd, fc);
-		if (err < 0)
+		if (err < 0) {
+			free(ff.buf);
 			return err;
+		}
 	}
 
 	f_header = (struct perf_file_header){
@@ -3728,6 +3735,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 
 	lseek(fd, 0, SEEK_SET);
 	err = do_write(&ff, &f_header, sizeof(f_header));
+	free(ff.buf);
 	if (err < 0) {
 		pr_debug("failed to write perf header\n");
 		return err;
-- 
2.42.0.609.gbb76f46606-goog


