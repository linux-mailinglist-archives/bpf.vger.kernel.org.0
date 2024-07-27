Return-Path: <bpf+bounces-35896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5793FBC0
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6ED1F23ADB
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14F1891A5;
	Mon, 29 Jul 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1oIw8pz4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CAE188CA7
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271576; cv=none; b=a1g4+EW8taCx6n0L1viOv8qYHS33H5KyEE+PKZVfidi8E1+iezX3C+WSUgkDHuluzZ0fCU8rL94//372or9o6URcvJLpX70GLBqXRXyBPXpFqnocDF+w6G0npzDTLZVVf3HdbCFQrlVI8ouSscDAWyTrymShCCXX/tqypm0cYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271576; c=relaxed/simple;
	bh=r/jk1bPDMru1N5AoMkuunoH2pb49M7nOjU+z9/MKibs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQOLEq/42AU/LnjjHEPIriCv6GGi590pHedxEHcjIwz+x/MhI6T0IgjhrOrCHYD8ZVRi03mJQZu1MDpvMZYNvfwxSvixXGrJMr6QR8B4SfGmeoLKjyyCb1rYnvknQGEmgJeLNs2qiIWzCV/qfmyW/tMmyl0HP1DZFIur4U70ISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1oIw8pz4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fee6435a34so19700585ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271574; x=1722876374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hggTn66JrbOD+sBIjW9DCUZjKZdbaIlQ6N1BF/br8RA=;
        b=1oIw8pz4xw91U1lrSFWpH2e8AatUcCm+BOQmYAcl77qG6e+K0VIGBaC817vD4ocYTu
         ADb4hUs9AcZ660dCqipoX7LTdcMnbFHqRqrg7LfdqzwYJvLCK00rqToDpUij9nVvWFzk
         WZ0j2lqkmpqih7CVB3ZIQ/HrqvOaNnEJm8+5LMouIKsiOglMvHYxqlSxCzf9EFfJYWFK
         hi797EZs/3Lu01f6jAQCuPnj4UmixOG2VGy0x+CPJ5lRd1T4XESJvIM2jqe0O66jP4zK
         w2dgn1dpxlntwsMad9puw4KIkqagKgdXnZjgfHq/o4HmYn/fF2gofZ24RK+5ES8VkgrE
         952g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271574; x=1722876374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hggTn66JrbOD+sBIjW9DCUZjKZdbaIlQ6N1BF/br8RA=;
        b=eyaOxMh/nlpmGioAgfaWENpw5kDwXILsTOi5GByuZx+ncW8am/w7KYUUYpyHDRtvPL
         X1X1aecy4dUi6H6oJwVJ3wKLmWCXvSk9k+iAOcIdSqHYzgXQGSWTEP+S9QsuwmB8Xv+C
         tHCoj/iZ46Am90Hz7MHlxJaxZXkQ3uSn++N2bp1Q23xvHiwG2xs2WEXsqLRTfvlNJP5y
         HhzNIn6VaXqRR9KW3kzloxJDPynhKkV/duZ+/Izo+uaRW697KdZuszWrWcTaysT+uIc2
         LtL2mzb9UYuTUqucRT5sa7u1OYzqo6Yc1//kTIV5u9+j/SWzdfUCT7Gvn2DTsy3sqwh/
         1rHA==
X-Forwarded-Encrypted: i=1; AJvYcCVNy2eG2hqGOipgNujFZi4ZEoGuJvPkecL+s9CO6GOPEPeQ6DCnG2cM4Bng+On5Y7jxNpIV8PrBg220FfW76H2KUjwq
X-Gm-Message-State: AOJu0Yx9WDjXU7vJ78p9H/soIfe5P6zgYJ8oJO0RRVwKH40sxAoiQinq
	ltz9SQzlxqri6dEJkaIu8uDKKeo61riVDxZqr+nW9szI1eEsPrGQ35wHF6n2GjQ=
X-Google-Smtp-Source: AGHT+IHwput5h4gdG/FQNNx/hl3tLZc38qQQiY4RziyanWxKoKdtV+dUnUDnm99B90DEvM0zWr8vPg==
X-Received: by 2002:a17:902:f68d:b0:1fd:9d0c:99a2 with SMTP id d9443c01a7336-1ff0492e124mr76115145ad.54.1722271574501;
        Mon, 29 Jul 2024 09:46:14 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:14 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:35 -0700
Subject: [PATCH v2 5/8] libperf: Add perf_evsel__has_fd() functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-5-7d154dcf6bea@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=2952;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=5bOJ2b703722JpraMU92aYFsGhC7VVqbjBOBXBX1n9w=;
 b=qvpfqD8c3mf+ibeI5OmudMFTmZt9WlbIgEglZdGnFxeEODawAp89wEr+czBg6PIJlpPnwuHka
 VyXXS8w7cRKCzleuS1aTn0nSnupQnm74zOk1NTd0Isx8R8RG65UAKN1
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Add the following functions:

  perf_evsel__has_fd

to check for perf events with the file descriptor specified in the
argument.
This function can be used in signal handlers to check overflow.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/Documentation/libperf.txt |  1 +
 tools/lib/perf/evsel.c                   | 18 ++++++++++++++++++
 tools/lib/perf/include/perf/evsel.h      |  1 +
 tools/lib/perf/libperf.map               |  1 +
 4 files changed, 21 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index bb99534d5855..f1bfe6b6e78a 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -161,6 +161,7 @@ SYNOPSIS
   int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__disable(struct perf_evsel *evsel);
   int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+  bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 17d3d9a88c23..6b98cba6eb4f 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -658,3 +658,21 @@ int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 	return err;
 }
+
+bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd)
+{
+	int cpu_map_idx;
+	int thread;
+	int *evsel_fd;
+
+	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->fd); ++cpu_map_idx) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
+			evsel_fd = FD(evsel, cpu_map_idx, thread);
+
+			if (fd == *evsel_fd)
+				return true;
+		}
+	}
+
+	return false;
+}
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 344808f23371..77816a35c383 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -73,5 +73,6 @@ LIBPERF_API int perf_evsel__open_opts(struct perf_evsel *evsel,
 				      struct perf_cpu_map *cpus,
 				      struct perf_thread_map *threads,
 				      struct perf_evsel_open_opts *opts);
+LIBPERF_API bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 84fed76621cb..f68519e17885 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -38,6 +38,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;
+		perf_evsel__has_fd;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__open;

-- 
2.44.0


