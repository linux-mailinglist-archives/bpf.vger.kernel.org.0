Return-Path: <bpf+bounces-9384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D25C796E28
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F061C20A97
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 00:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31198A47;
	Thu,  7 Sep 2023 00:43:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D6A28
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 00:43:20 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEAB172E;
	Wed,  6 Sep 2023 17:43:17 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VrV7FoD_1694047394;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VrV7FoD_1694047394)
          by smtp.aliyun-inc.com;
          Thu, 07 Sep 2023 08:43:15 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	james.clark@arm.com,
	leo.yan@linaro.org
Cc: mingo@redhat.com,
	baolin.wang@linux.alibaba.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 2/2] perf record: Update docs regarding the maximum limitation of AUX area
Date: Thu,  7 Sep 2023 08:43:08 +0800
Message-Id: <20230907004308.25874-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907004308.25874-1-xueshuai@linux.alibaba.com>
References: <20230907004308.25874-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The maximum AUX area is limited by the page size of the system. Update
the documentation to reflect this.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 tools/perf/Documentation/perf-record.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 680396c56bd1..dfc322d6f1f1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -292,6 +292,17 @@ OPTIONS
 	Also, by adding a comma, the number of mmap pages for AUX
 	area tracing can be specified.
 
+	The maximum AUX area is limited by the maximum physically contiguous
+	memory allocated from slab/slub. It can be calculated with following
+	formula:
+
+	  PAGE_SIZE << MAX_ORDER
+	( ---------------------- ) * PAGE_SIZE
+	   sizeof(page_pointer)
+
+	For example with 4K pages and MAX_ORDER=10 configured, the maximum AUX
+	area is 2GiB.
+
 -g::
 	Enables call-graph (stack chain/backtrace) recording for both
 	kernel space and user space.
-- 
2.39.3


