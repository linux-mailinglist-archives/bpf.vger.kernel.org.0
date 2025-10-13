Return-Path: <bpf+bounces-70831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDFDBD5981
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3544A3E1F82
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A92D248A;
	Mon, 13 Oct 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VxzJxKIC"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691A2D193C
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377689; cv=none; b=KyiYZNpRN/YjMI+jF/425c6hCwu+9FAUpuB7uC/d7nEG0U2yTEPiAJqhfBaz77YhhJGuQt/CwSmOFD6DI5cXnodaZQnbRqR2m6x7drvccbdzTwnrs0LkDhqdoc3CoULo4VLdPmLF2dDYexoIR3GO1jx/v+BJlwQk/3sX4iQjzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377689; c=relaxed/simple;
	bh=Fz2Z0NVg/DpxS1jweNIyZgePAu4cm4J9w/NK89KwvTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5aI4VqOjJNffryBbpmTXpgFxhbCj9DUNU68TGW+3nJmP5RY4QHTnWqHReEY1Ze0XhnsKewF3WDTi/2GABhbEBEArHd4cWJVBY6JE5h7ndEiqvD67R+xEPNZwtzCLp+9BLqeS7EX8EdOSm2bttu4aZ8N6PZOPBaWIeVyzu8Fv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VxzJxKIC; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760377675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dQog++Z4DABPXGobwnLJdN42FYEo1zhiAYhURAKlFOI=;
	b=VxzJxKICuu2V++rKVk+ZLlHlcziBjDWagVThwUkaCtfBN/Y7aJ0ivBFRXpZz05k6xpy8c5
	xR4H4gPdQuOcUUiTsAeWifhnn4AV1wthnL304+12V5T7qzviNz329dKXh4BjsI7Q4e5pZd
	keogQh+6AEcYloTIOsY1Y3ZrscMkOnk=
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
Subject: [PATCH bpf-next RFC 0/2] Pass external callchain entry to get_perf_callchain
Date: Tue, 14 Oct 2025 01:47:19 +0800
Message-ID: <20251013174721.2681091-1-chen.dylane@linux.dev>
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

Tao Chen (2):
  perf: Use extern perf_callchain_entry for get_perf_callchain
  bpf: Pass external callchain entry to get_perf_callchain

 include/linux/perf_event.h |  5 +++--
 kernel/bpf/stackmap.c      | 19 +++++++++++--------
 kernel/events/callchain.c  | 18 ++++++++++++------
 kernel/events/core.c       |  2 +-
 4 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.48.1


