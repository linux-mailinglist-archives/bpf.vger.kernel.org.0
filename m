Return-Path: <bpf+bounces-71218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E16BEA29F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C845E583CBC
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FC82F692B;
	Fri, 17 Oct 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xQPa0+TW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C31946C8;
	Fri, 17 Oct 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715016; cv=none; b=FClpBazV8+egeVw+kE7o2rnPZETIk7gWcZw5jjUMoB0RqRezotbhhEHpErr/gTni4oLutUcEvdjqQE7jjyQtFDRMHp7hfrh01IyUujin4DnoAHWBwV7q3XUs/2o1pByO5AKZXL+no8za5EjrbIYOJ8/D4vhRrlIxj4zT0Yv1ndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715016; c=relaxed/simple;
	bh=uowemTQlJiYgMGrbUDmHstGZHrwBihs94XchgZk6xHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGiQDWvPWOauVYNCaCnbqEMRCu8xwlsDGQrJ37wxpqek/j8VVDM8ywOesuWR78y+D+43FFyJc892OooJs1SNILl6J+pmMb7QLhqScC58EMtmPwyxLMmrr5gvohjBwfmjTld2x1Hs0J6ib5YVsFNktdGLVhRmY4WG4G2hBmmdoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xQPa0+TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4EBC4CEE7;
	Fri, 17 Oct 2025 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715016;
	bh=uowemTQlJiYgMGrbUDmHstGZHrwBihs94XchgZk6xHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xQPa0+TW0xXQ7b6GUESetvOUAXBdmfDlwHkCX4B8KSvlc4vaZv8SOd+4vkeL0rqSO
	 JMwaMY9nTBvHWEVBwBS2jBVBeBW1SQhF9sbdPEj8fvpSdtbIRaH0V9xmufQru2msAB
	 3MIgE4aA++zQdtVlPEeaCuexf7kHJLjEdsnTuSkE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 069/371] perf bpf-filter: Fix opts declaration on older libbpfs
Date: Fri, 17 Oct 2025 16:50:44 +0200
Message-ID: <20251017145204.432766505@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 3a0f56d72a7575f03187a85b7869c76a862b40ab ]

Building perf with LIBBPF_DYNAMIC (ie not the default static linking of
libbpf with perf) is breaking as the libbpf isn't version 1.7 or newer,
where dont_enable is added to bpf_perf_event_opts.

To avoid this breakage add a compile time version check and don't
declare the variable when not present.

Fixes: 5e2ac8e8571df54d ("perf bpf-filter: Enable events manually")
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Hao Ge <gehao@kylinos.cn>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf-filter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index a0b11f35395f8..92308c38fbb56 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -443,6 +443,10 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 	return -1;
 }
 
+#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)			\
+	(LIBBPF_MAJOR_VERSION > (major) ||				\
+	 (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
+
 int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
 	int i, x, y, fd, ret;
@@ -451,8 +455,12 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
 			    .dont_enable = true);
+#else
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+#endif
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
-- 
2.51.0




