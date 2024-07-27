Return-Path: <bpf+bounces-35894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B193FBBC
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E851F23BAA
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D71918786B;
	Mon, 29 Jul 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aHDxMYgR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150C18734F
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271573; cv=none; b=e/JlD+tJ04Fxgy000DrRsNLYJB+pTITPhil1HIulqd1bUMvPDssJeLwwaTO61xLydM5atdN1bHgJQOkS4d522b6gWJXZ9n7Ca4RyRkomyWza7Hc4Q5CjUFvfcn4jXO5t53LBGpCM7rm0YMXCqdqAOusiYvlXt/TlRRYDZMOF7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271573; c=relaxed/simple;
	bh=Ngg3rd0M9C6xmXKqdyh5Swv8+ulPNZzaCEcRVN+uVoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmaELzZPBAMwqjidvg72ynKycRVL2pC8kbndoDxbzBzj6RpJpecDrsBgeUDySmlnbbTSZ25aCohM5RH95IpOM4TIVWA8B1G5jaMY8ZAMVvvEryA9YO08Wp6529FS05/rg6/B9KHFz4+XFYOUb0N1t7J5321JX9BVrzM9R4xlNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aHDxMYgR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd78c165eeso28319115ad.2
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271571; x=1722876371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uo0PY2WTM6EhFKrs58+9HaWpsdI63v4tb+UT2YjwAqc=;
        b=aHDxMYgRJqmIcNcMqfj0aJ7fwsosMWNjNnKDzmuPaUd3w+hefwyllWdBb2tkWcttxG
         HOEMouQRhU+KLLkuuxO7ydQgFenCovmgGEOcXu79kkArkoqvpndyvxTFFAuyVO3aEJ7Q
         i0CpMsTq7PfeTQFgXtZI4oyjEQgctzUeCwvLdfPPKy7yFMPUzLevDdvbomes6zCTfbOd
         QHv2W/lUGK1lf6WKDJ5G16/IAesl0ZUOQKE1lQZtkLJ8ua8G1fYOdHfq/DHnMobYL0Np
         7ty1SWyhH0ptCyueNahUYk15Kw35RXGZEU4X/7lsQEc0Bpvwocrw5FaGruX4ssLaUEE3
         2tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271571; x=1722876371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uo0PY2WTM6EhFKrs58+9HaWpsdI63v4tb+UT2YjwAqc=;
        b=Ae9RQ4IU7r7mjFlItzHCjdMb88yddJ8dEGsRGR6ngmIVrEdnEr7foAgNhLCH0bWZSV
         BJeOegBKRj032q9Eo9CN8Zxj1sykklbtiMTtRd/ITKVp37ElGgWfIsffJP0znB0Dm+Ej
         anIeATug+5Pp/JI50UG9tzbVbhbH46culLy2+gv44fNgxRk2EvpdjA+ykGckRaxMdLVd
         LB6+9KmfUjFwWvaJjm6Pdr6qRHfv+8UkXBYSkeZsDIzbl+KuhIVXQeLfKie3atyduul4
         ZF8bfQhWGHj/e8pu2/6wOgyCflJ6awWQWdA7DjMOHUg0OimqDanzieDXxDeT1OSskkgh
         p8vg==
X-Forwarded-Encrypted: i=1; AJvYcCULSNE1W5q9T3oBR0AO56YEeuH2DW3qqKdfHoKxR8semPb8sRVKxDACLbNUYl42FQjOpQb5w3x0xivYXhFJGUm/bfVZ
X-Gm-Message-State: AOJu0Yw6OJGEjadCA/q+755cAS5wzjl7qZ+9cJEjY/KW0eJUw0SP9RBd
	llE95DGeYaeiUXwkiWdeu82Ykp+CsJlCxpFR6QsETLvyNx6xHFw2j4+40RpDrDg=
X-Google-Smtp-Source: AGHT+IHLgMPdjmt0sDFCR6yF11VZsrAEjljxhSUWErrndmlusWxFwhB4XqPZLawRIvpO/YA7zmUOuQ==
X-Received: by 2002:a17:902:f542:b0:1fb:779e:4fd0 with SMTP id d9443c01a7336-1ff04824612mr103219635ad.24.1722271571147;
        Mon, 29 Jul 2024 09:46:11 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:10 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:33 -0700
Subject: [PATCH v2 3/8] libperf: Introduce perf_{evsel, evlist}__open_opt
 with extensible struct opts
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-3-7d154dcf6bea@rivosinc.com>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=7074;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=+5d9mj+wHf0VzhQfYQKCxev5dn5+38ZS8YUUwro/Nzs=;
 b=4PBFwV6Nyh9X5DwMJ8/GEDy/ecDevgP9/dGJd4n4JTycAjE7K//b7Dbg213JCH5ss5kjqMWkL
 MfL/jvDn1RkDy5EvdHb4DEd1g9XHj0Z4wrpg4+lHQWiHaPCPH6VQsSK
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Introduce perf_{evsel, evlist}__open_opt with extensible structure opts.
The mechanism of the extensible structure opts imitates
tools/lib/bpf/libbpf.h. Currently, only open_flags is supported for the
opts structure.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/Documentation/libperf.txt | 10 ++++++++++
 tools/lib/perf/evlist.c                  | 20 ++++++++++++++++++++
 tools/lib/perf/evsel.c                   | 26 +++++++++++++++++++++++++-
 tools/lib/perf/include/perf/evlist.h     |  3 +++
 tools/lib/perf/include/perf/evsel.h      | 23 +++++++++++++++++++++++
 tools/lib/perf/libperf.map               |  2 ++
 6 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index fcfb9499ef9c..83827b94617a 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -132,6 +132,16 @@ SYNOPSIS
           };
   };
 
+  struct perf_evsel_open_opts {
+          /* size of this struct, for forward/backward compatibility */
+          size_t sz;
+
+          unsigned long open_flags;       /* perf_event_open flags */
+  };
+  #define perf_evsel_open_opts__last_field open_flags
+
+  #define LIBPERF_OPTS(TYPE, NAME, ...)
+
   struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
   void perf_evsel__delete(struct perf_evsel *evsel);
   int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c6d67fc9e57e..7aa62f90f13b 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -753,3 +753,23 @@ void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *
 			__perf_evlist__propagate_maps(evlist, evsel);
 	}
 }
+
+int perf_evlist__open_opts(struct perf_evlist *evlist,
+			   struct perf_evsel_open_opts *opts)
+{
+	struct perf_evsel *evsel;
+	int err;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		err = perf_evsel__open_opts(evsel, evsel->cpus,
+					    evsel->threads, opts);
+		if (err < 0)
+			goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	perf_evlist__close(evlist);
+	return err;
+}
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c07160953224..96ecf3e5c8b4 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -16,8 +16,13 @@
 #include <internal/lib.h>
 #include <linux/string.h>
 #include <sys/ioctl.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <sys/types.h>
 #include <sys/mman.h>
 #include <asm/bug.h>
+#include <tools/opts.h>
+#include "internal.h"
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
@@ -26,6 +31,7 @@ void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 	evsel->attr = *attr;
 	evsel->idx  = idx;
 	evsel->leader = evsel;
+	evsel->open_flags = 0;
 }
 
 struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
@@ -160,7 +166,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
-						 cpu, group_fd, 0);
+						 cpu, group_fd, evsel->open_flags);
 
 			if (fd < 0) {
 				err = -errno;
@@ -555,3 +561,21 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 	if (pscaled)
 		*pscaled = scaled;
 }
+
+int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+			  struct perf_thread_map *threads,
+			  struct perf_evsel_open_opts *opts)
+{
+	int err = 0;
+
+	if (!OPTS_VALID(opts, perf_evsel_open_opts)) {
+		err = -EINVAL;
+		return err;
+	}
+
+	evsel->open_flags = OPTS_GET(opts, open_flags, 0);
+
+	err = perf_evsel__open(evsel, cpus, threads);
+
+	return err;
+}
diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
index e894b770779e..37ac44364d22 100644
--- a/tools/lib/perf/include/perf/evlist.h
+++ b/tools/lib/perf/include/perf/evlist.h
@@ -9,6 +9,7 @@ struct perf_evlist;
 struct perf_evsel;
 struct perf_cpu_map;
 struct perf_thread_map;
+struct perf_evsel_open_opts;
 
 LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
@@ -48,4 +49,6 @@ LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
 
 LIBPERF_API void perf_evlist__set_leader(struct perf_evlist *evlist);
 LIBPERF_API int perf_evlist__nr_groups(struct perf_evlist *evlist);
+LIBPERF_API int perf_evlist__open_opts(struct perf_evlist *evlist,
+				       struct perf_evsel_open_opts *opts);
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 6f92204075c2..8eb3927f3cd0 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -5,6 +5,7 @@
 #include <stdint.h>
 #include <perf/core.h>
 #include <stdbool.h>
+#include <signal.h>
 #include <linux/types.h>
 
 struct perf_evsel;
@@ -25,6 +26,24 @@ struct perf_counts_values {
 	};
 };
 
+struct perf_evsel_open_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+
+	unsigned long open_flags;	/* perf_event_open flags */
+};
+
+#define perf_evsel_open_opts__last_field open_flags
+
+#define LIBPERF_OPTS(TYPE, NAME, ...)			\
+	struct TYPE NAME = ({				\
+		memset(&NAME, 0, sizeof(struct TYPE));	\
+		(struct TYPE) {				\
+			.sz = sizeof(struct TYPE),	\
+			__VA_ARGS__			\
+		};					\
+	})
+
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
@@ -46,5 +65,9 @@ LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
 LIBPERF_API void perf_counts_values__scale(struct perf_counts_values *count,
 					   bool scale, __s8 *pscaled);
+LIBPERF_API int perf_evsel__open_opts(struct perf_evsel *evsel,
+				      struct perf_cpu_map *cpus,
+				      struct perf_thread_map *threads,
+				      struct perf_evsel_open_opts *opts);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 2aa79b696032..84fed76621cb 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -29,6 +29,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__enable;
 		perf_evsel__disable;
 		perf_evsel__open;
+		perf_evsel__open_opts;
 		perf_evsel__close;
 		perf_evsel__mmap;
 		perf_evsel__munmap;
@@ -40,6 +41,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__open;
+		perf_evlist__open_opts;
 		perf_evlist__close;
 		perf_evlist__enable;
 		perf_evlist__disable;

-- 
2.44.0


