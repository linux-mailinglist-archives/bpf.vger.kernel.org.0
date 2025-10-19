Return-Path: <bpf+bounces-71311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFDBBEEA66
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 19:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 197DD349094
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC101F03DE;
	Sun, 19 Oct 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ozh2bEuP"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393F5227
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760893335; cv=none; b=sHXaHfFIO+WdGC9+2zuMua2bAucdo+PVvUFjQwxj1svH4qpVNl/141rz872KMRo7Bm9NEsdPF2AF0GfIFM3NrLLDHKhR+tzVu/NKLcM2ugWmUIlubq7CE+nxEshRqU5WLmKVL4hB+NHgnZgJb0YUT4urRWEJx7wdngrvfLwysS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760893335; c=relaxed/simple;
	bh=I4IPIkVRwwPljb/L00Berkh9PET7fL8xPobDbg7CT40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpfBZQTxrGeQUK2s6X+x17LN2f1sv6SYM1nRFQLnEP/E1o5a40QIV5b/dklwYf4dX9kWSXXEyTUK5rhSPBY8dmfmt20Gp5TSECzUVae+/Cwfom0bBMMLED9/G6InPTWeRixhxf0VF9S50ltY348aMcP8ABKw9Bzb2yExbc7xV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ozh2bEuP; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760893330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iqzfPOzTOCeOc2Nx+fmkWoPF6VmUZJ9IKHq9VTjuh08=;
	b=Ozh2bEuPujZu9hDHbL6X/MbypkfQeQapazzO2cXcJfqwe15DMWBnm/sM01+fiOiceHuznw
	pfabOMRhZ4TwMfgZ8GfWdimMjQ6nIpE07vN+9xdBj8Y3HtCOckGAv3tm6whSFFGp0ZXVNu
	OHPOdqPrF3Hn4HCpYjivoI293s5vh6Y=
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
Subject: [RFC PATCH bpf-next v3 0/2] Pass external callchain entry to get_perf_callchain
Date: Mon, 20 Oct 2025 01:01:16 +0800
Message-ID: <20251019170118.2955346-1-chen.dylane@linux.dev>
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
If the above changes are reasonable, it seems that get_callchain_entry_for_task
could also use an external perf_callchain_entry.

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

Tao Chen (2):
  perf: Use extern perf_callchain_entry for get_perf_callchain
  bpf: Use per-cpu BPF callchain entry to save callchain

 include/linux/perf_event.h |   4 +-
 kernel/bpf/stackmap.c      | 100 ++++++++++++++++++++++++++++---------
 kernel/events/callchain.c  |  13 +++--
 kernel/events/core.c       |   2 +-
 4 files changed, 88 insertions(+), 31 deletions(-)

-- 
2.48.1


