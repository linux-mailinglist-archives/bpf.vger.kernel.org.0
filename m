Return-Path: <bpf+bounces-15127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D26A7ECF68
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083852815A8
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF33A8FF;
	Wed, 15 Nov 2023 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o/hvoqeL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55780381DF;
	Wed, 15 Nov 2023 19:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5637C433C7;
	Wed, 15 Nov 2023 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700077699;
	bh=sWalzTKT0Gz8E+OWv9ECaqJ3pQVZQSlVTd1mSBIK/1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/hvoqeLDTSYYw4lmKoPT157RSD3K3zhBvOYjKl8yKBMerSdrbJrbUWx5GxZv5epP
	 6fcUHffZxVZ8rSwcW+9JuCXjfS6dVkcGuaYLuK1EdeGDKZzRhFHPEMY87gRapbqVh8
	 B7+OnnDbUJJSNYVqxrSHnxFJGV5M/zkQdoq7Ihqw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	llvm@lists.linux.dev,
	Ming Wang <wangming01@loongson.cn>,
	Tom Rix <trix@redhat.com>,
	bpf@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 463/603] perf mem-events: Avoid uninitialized read
Date: Wed, 15 Nov 2023 14:16:48 -0500
Message-ID: <20231115191644.614925317@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 85f73c377b2ac9988a204b119aebb33ca5c60083 ]

pmu should be initialized to NULL before perf_pmus__scan loop. Fix and
shrink the scope of pmu at the same time. Issue detected by clang-tidy.

Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core ones")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: llvm@lists.linux.dev
Cc: Ming Wang <wangming01@loongson.cn>
Cc: Tom Rix <trix@redhat.com>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20231009183920.200859-10-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/mem-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 39ffe8ceb3809..954b235e12e51 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -185,7 +185,6 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 {
 	int i = *argv_nr, k = 0;
 	struct perf_mem_event *e;
-	struct perf_pmu *pmu;
 
 	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		e = perf_mem_events__ptr(j);
@@ -202,6 +201,8 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 			rec_argv[i++] = "-e";
 			rec_argv[i++] = perf_mem_events__name(j, NULL);
 		} else {
+			struct perf_pmu *pmu = NULL;
+
 			if (!e->supported) {
 				perf_mem_events__print_unsupport_hybrid(e, j);
 				return -1;
-- 
2.42.0




