Return-Path: <bpf+bounces-10682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E756B7ABDF7
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E04151C20928
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C29820EC;
	Sat, 23 Sep 2023 05:36:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA37F9
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:36:50 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195AF19B9
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdac026f7so52949147b3.0
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447376; x=1696052176; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQyzyxD68ePpbOWMRqgJmncvVxKbUt7ya9UE8v2z5vg=;
        b=zPqo8PoD8evK8TqV6j1+iwS4jSrRU5frkSpmA58JOKbjKM6pnXKwUSIP+57xeXfUEl
         F2FzbU6M20H0i0yjry6PASkGUY/KLUHXUD+Z6h+dsg2PeIaI9/aSebTl/SSnSiyAxUbj
         Xwwc9mgm2Sv8KDz6YSbeYGcT4fnmdhm2jKJsUPOMqg95l/s28hix48nNcm/lwUTuzgM8
         +Aoinc49neQTI6U4A8j6Al79sPiZpj5Lk+BkMlsqVpwIAXmAQcUMuOx8jlMVOizMhMiK
         GpS0fLjEGyRr7OoW2zgExZW+NbKrVDGVI/QpY9uehH4a6wZJ6Wt0meRRmYdHJgasmCNT
         LomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447376; x=1696052176;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQyzyxD68ePpbOWMRqgJmncvVxKbUt7ya9UE8v2z5vg=;
        b=ku3c1u25/JK/fH7U1dKHtmw8aNPB7XeInI9EKmzkrmXN96xgFTxZJAty0deiSow5NT
         +U4YKsme/Oe/d2NjuUqTWzIt22Dcz3tFTE/hPEfSvS0Pwf1eExnqnrxvfhCqLuxOtRiy
         EVKe42+spOPYVdLg8jWTcKQNZRJPSGe/YXNNbGsamd+DtQgdvyaj+1stiwyeI1+ssuOQ
         tyttB66wxfOmAQLGIicvJX8a+5RDJXdqMjyb+wrD5UHeprF7mSH8iyOz3kf1PTI07cPo
         h8hwIophsqcdIgLDgqILeVmX84SiCjRJ+KUPCcy5zswwXdo1l6ZzNkqdofAmpyQ+81Yd
         nlrw==
X-Gm-Message-State: AOJu0Yx8RS3+e+nzQ7MN92PTNrnaR/DJPM805x4Qf5UShjNz4v2fRIjJ
	sJQikBc+h16ubB5TIfFEslZRImUSTn5D
X-Google-Smtp-Source: AGHT+IH1/8N6KXKbsq0cgMy7XxhDM7wiUKaAcfle1eqtAKeK0B+VxM29iufwiC2RBjgnCg6nNUi1fgZXeX2a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a81:e344:0:b0:59b:e684:3c7a with SMTP id
 w4-20020a81e344000000b0059be6843c7amr20581ywl.4.1695447375211; Fri, 22 Sep
 2023 22:36:15 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:14 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 17/18] perf header: Fix various error path memory leaks
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Memory leaks were detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 63 ++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d812e1e371a7..41b78e40b22b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2598,8 +2598,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		/* include a NULL character at the end */
-		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
+		if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
+			free(str);
 			goto error;
+		}
 		size += string_size(str);
 		free(str);
 	}
@@ -2617,8 +2619,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		/* include a NULL character at the end */
-		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
+		if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
+			free(str);
 			goto error;
+		}
 		size += string_size(str);
 		free(str);
 	}
@@ -2681,8 +2685,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		/* include a NULL character at the end */
-		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
+		if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
+			free(str);
 			goto error;
+		}
 		size += string_size(str);
 		free(str);
 	}
@@ -2736,10 +2742,9 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2913,10 +2918,10 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 		return -1;
 
 	for (i = 0; i < cnt; i++) {
-		struct cpu_cache_level c;
+		struct cpu_cache_level *c = &caches[i];
 
 		#define _R(v)						\
-			if (do_read_u32(ff, &c.v))\
+			if (do_read_u32(ff, &c->v))			\
 				goto out_free_caches;			\
 
 		_R(level)
@@ -2926,22 +2931,25 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -3585,18 +3593,16 @@ static int perf_header__adds_write(struct perf_header *header,
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
@@ -3623,6 +3629,7 @@ static int perf_header__adds_write(struct perf_header *header,
 	err = do_write(&ff, feat_sec, sec_size);
 	if (err < 0)
 		pr_debug("failed to write feature section\n");
+	free(ff.buf);
 	free(feat_sec);
 	return err;
 }
@@ -3630,11 +3637,11 @@ static int perf_header__adds_write(struct perf_header *header,
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
@@ -3645,7 +3652,7 @@ int perf_header__write_pipe(int fd)
 		pr_debug("failed to write perf pipe header\n");
 		return err;
 	}
-
+	free(ff.buf);
 	return 0;
 }
 
@@ -3658,11 +3665,12 @@ static int perf_session__do_write_header(struct perf_session *session,
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
@@ -3670,6 +3678,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 		err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
 		if (err < 0) {
 			pr_debug("failed to write perf header\n");
+			free(ff.buf);
 			return err;
 		}
 	}
@@ -3695,6 +3704,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 		err = do_write(&ff, &f_attr, sizeof(f_attr));
 		if (err < 0) {
 			pr_debug("failed to write perf header attribute\n");
+			free(ff.buf);
 			return err;
 		}
 	}
@@ -3705,8 +3715,10 @@ static int perf_session__do_write_header(struct perf_session *session,
 
 	if (at_exit) {
 		err = perf_header__adds_write(header, evlist, fd, fc);
-		if (err < 0)
+		if (err < 0) {
+			free(ff.buf);
 			return err;
+		}
 	}
 
 	f_header = (struct perf_file_header){
@@ -3728,6 +3740,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 
 	lseek(fd, 0, SEEK_SET);
 	err = do_write(&ff, &f_header, sizeof(f_header));
+	free(ff.buf);
 	if (err < 0) {
 		pr_debug("failed to write perf header\n");
 		return err;
-- 
2.42.0.515.g380fc7ccd1-goog


