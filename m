Return-Path: <bpf+bounces-9382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7825A796E25
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 02:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06B7281453
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE38807;
	Thu,  7 Sep 2023 00:43:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9463A
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 00:43:17 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DE173B;
	Wed,  6 Sep 2023 17:43:15 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VrV7FnU_1694047390;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VrV7FnU_1694047390)
          by smtp.aliyun-inc.com;
          Thu, 07 Sep 2023 08:43:12 +0800
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
Subject: [PATCH v5 0/2] perf/core: Bail out early if the request AUX area is out of bound
Date: Thu,  7 Sep 2023 08:43:06 +0800
Message-Id: <20230907004308.25874-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
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

changes since v4 (per Leo):
- refine comments as Leo asked
- correct aux limitation in doc by adding a formula

changes since v3 (per James):
- change to return with existing value -ENOMEM
- split doc part to a separate patch since they are going to be merged through
  separate trees.

changes since v2:
- remove unnecessary overflow check (per Peter)

changes since v1:
- drop out patch2 because it has been fixed on upstream (Thanks James for reminding)
- move sanity check into rb_alloc_aux (per Leo)
- add overflow check (per James)

Shuai Xue (2):
  perf/core: Bail out early if the request AUX area is out of bound
  perf record: Update docs regarding the maximum limitation of AUX area

 kernel/events/ring_buffer.c              |  6 ++++++
 tools/perf/Documentation/perf-record.txt | 11 +++++++++++
 2 files changed, 17 insertions(+)

-- 
2.39.3


