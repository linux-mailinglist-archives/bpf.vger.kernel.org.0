Return-Path: <bpf+bounces-74310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EED2C53819
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 17:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A868E357627
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF1341ADD;
	Wed, 12 Nov 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQb0quDZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6884340287
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965139; cv=none; b=sVVXkdAJWxtSxzTVuWd72fnaGu+ALFa2pKPYm7h2Lvo7lg9Zn6nBA+aT4CbhI9Vuf6p0sW3eSc81Bs0V8b3SpLyzT9bwYQoKP2zrJaMEjkbi6SKU5T+1n01+GpuTrU3rvP1z0j6Xp78GjH1hfT/GG3b3wSc3WLsUtiD8ISMscPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965139; c=relaxed/simple;
	bh=824HB0FwxXbrTkd2VprLbP8RIEvV0Ma1dBRa+Qdwaus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwFxZYWtG4UxFekqa5z3N2pz272yfwLR7zJ76eNRd76XVgnGF9kFtkBwip3G5LFOHblQwo69vYyymeF0F0RRbBw9RdT3LcQlKDxZamjXQQBynm1d8w9JFMG+WyXoICV0+PCpyaUL2G6dizMM3Y1wheZTATqMkdrY5GaoVaHKksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQb0quDZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762965125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2SvTyG20gTI6PLA4Qy0uxk1b8dqb6/aV5Fy9WbEByow=;
	b=TQb0quDZ8exl/W0BgAhk8oMQoZWO65M93a49bOynUQEKV9aze94ECS37o6ZFsdgQakB9ff
	iboEeIRhjv6iv374nRppYnGO71diDSL467/j7RKdUlleJpkdkHzjViqAoxZp2TeaFh90WI
	NDS7VZkcEWvRtG5Krgl7v+5jyaiYFBo=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v6 0/2] Pass external callchain entry to get_perf_callchain
Date: Thu, 13 Nov 2025 00:31:46 +0800
Message-ID: <20251112163148.100949-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Background
==========
Alexei noted we should use preempt_disable to protect get_perf_callchain
in bpf stackmap.
https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com

A previous patch was submitted to attempt fixing this issue. And Andrii
suggested teach get_perf_callchain to let us pass that buffer directly to
avoid that unnecessary copy.
https://lore.kernel.org/bpf/20250926153952.1661146-1-chen.dylane@linux.dev

Proposed Solution
=================
Add external perf_callchain_entry parameter for get_perf_callchain to
allow us to use external buffer from BPF side. The biggest advantage is
that it can reduce unnecessary copies.

Todo
====
But I'm not sure if this modification is appropriate. After all, the
implementation of get_callchain_entry in the perf subsystem seems much more
complex than directly using an external buffer.

Comments and suggestions are always welcome.

Change list:
 - v1 -> v2
   From Jiri
   - rebase code, fix conflict
 - v1: https://lore.kernel.org/bpf/20251013174721.2681091-1-chen.dylane@linux.dev
 
 - v2 -> v3:
   From Andrii
   - entries per CPU used in a stack-like fashion
 - v2: https://lore.kernel.org/bpf/20251014100128.2721104-1-chen.dylane@linux.dev

 - v3 -> v4:
   From Peter
   - refactor get_perf_callchain and add three new APIs to use perf
     callchain easily.
   From Andrii
   - reuse the perf callchain management.

   - rename patch1 and patch2.
 - v3: https://lore.kernel.org/bpf/20251019170118.2955346-1-chen.dylane@linux.dev
 
 - v4 -> v5:
   From Yonghong
   - keep add_mark false in stackmap when refactor get_perf_callchain in
     patch1.
   - add atomic operation in get_recursion_context in patch2.
   - rename bpf_put_callchain_entry with bpf_put_perf_callchain in
     patch3.
   - rebase bpf-next master.
 - v4: https://lore.kernel.org/bpf/20251028162502.3418817-1-chen.dylane@linux.dev

 - v5 -> v6:
   From Peter
   - disable preemption from BPF side in patch2.
   From AI
   - use ctx->entry->nr instead of ctx->nr in patch1.
 - v5: https://lore.kernel.org/bpf/20251109163559.4102849-1-chen.dylane@linux.dev

Tao Chen (2):
  perf: Refactor get_perf_callchain
  bpf: Hold the perf callchain entry until used completely

 include/linux/perf_event.h |  9 +++++
 kernel/bpf/stackmap.c      | 67 +++++++++++++++++++++++++++-------
 kernel/events/callchain.c  | 73 ++++++++++++++++++++++++--------------
 3 files changed, 111 insertions(+), 38 deletions(-)

-- 
2.48.1


