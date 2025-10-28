Return-Path: <bpf+bounces-72582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178FC15CFB
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6097506DF8
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE70286405;
	Tue, 28 Oct 2025 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HXHVqMcd"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F42750E6
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668769; cv=none; b=eIpuceazhbxxOX1on+xZNlCcLLEBfxELcOJpBVO6wjdLA9ZU1CU1U73VyOUfM1ylb5+s17/95rJGMqqSR87WVawV1Oykk2rG+OIPNbOWH5BlV6IIFsjHDMWbcWMgqN7h+DOzyFETHily1ogGoq42Bx/Ts4dtj5p+eS2Zfo8YNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668769; c=relaxed/simple;
	bh=Gut23H+vLbBU8WnL9h+ExoPk62kwRW1OvEs3CVzZH9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9zDPnH3oW+n8+x8fYb56DGfkKWS+Nh/sIR1Q9v4TZUqeX7/FxViqcRwAptSwbTZsjFJWnUZwkDi7aZK6jCaFLZ1dLjfN1aE+oQHK0l0BvcNSvzfxp8mZgSqCyBI8we9VYtSpg11rH7yr2r+9CbcwDRDtQ6D07LH01ZV8gPj/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HXHVqMcd; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761668763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zSkSma7mbiNDwjyN0Eo4/+PbZjdcy6kJHldE9TQrU04=;
	b=HXHVqMcdEQX3V2MroWxF3mq5nsKHDcnpdurKn7BKW/vm6UuKFJuF6l/50TO7YkfUiwXDGt
	GXfvTgsKZ2EcyXeihP2wVMPsyLPTRP6g961i/ZgEUD4fz7bKOpObzEsY22VjFkqJEWSCkk
	9YS8XKW33DIiPPi89oDKFHju/KAKRVs=
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
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v4 0/2] Pass external callchain entry to get_perf_callchain
Date: Wed, 29 Oct 2025 00:25:00 +0800
Message-ID: <20251028162502.3418817-1-chen.dylane@linux.dev>
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

Tao Chen (2):
  perf: Refactor get_perf_callchain
  bpf: Hold the perf callchain entry until used completely

 include/linux/perf_event.h | 11 +++++-
 kernel/bpf/stackmap.c      | 61 ++++++++++++++++++++++++-------
 kernel/events/callchain.c  | 75 ++++++++++++++++++++++++--------------
 kernel/events/core.c       |  2 +-
 4 files changed, 107 insertions(+), 42 deletions(-)

-- 
2.48.1


