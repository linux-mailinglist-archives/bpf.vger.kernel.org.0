Return-Path: <bpf+bounces-71424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B5BF27FF
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E9E424FA2
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1AD32ED47;
	Mon, 20 Oct 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WN8OgGbm"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BC192B84
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978796; cv=none; b=BS3/cOK2mTJ198/nU96RFlkNFtdykwrxEAAYFMOl1L+tSQbQIRt4fRyVDwhxKKn72HZMw3NZdrDlx4cI6cvVXY5vsU4KsyzDMBwlUemcRRUE9j8Y+4oaTK2iQZltXlKQxugg1QzPPAUsE4HyX+trp0YQfBCSyBa9YsxBKknUXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978796; c=relaxed/simple;
	bh=Odavzxy2BexwWoqgDcsWU58hygNdpI9KxmoPErhga9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdNIe5vcVicgvygcQTN7B03MN46SyqmGaP/M0ohVopRzDQKKK+ngBfCdVzQ4RRyAQb214WVzUBQ5jbsU97Ro6j2SOpoP/eao23S/oJkcfN2JdCzV+s9t4C5Df5LEuEJwkwUDTFz4mW+TmaQhSMn6qEyrNsfAsN0HxT+d4TBIOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WN8OgGbm; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760978788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vXz+Yf4/WKVtEjAJq5FbJ83Q1qsQ3bOt3NklG6ERV94=;
	b=WN8OgGbm5xQc6P42AtQSVcS8lRotIJfemBonNfUMd4iXm7TXqjP55tMnczXbu4EakwR4NB
	vHz/+woV5HVx4sKf1gPj7BBEtB3JObQUhfifJZu1Vqd/ecrTJT6UxOa9a0cE2JzdywdUMI
	EbJCKXBcOMiDp45XT6wW9j1fk3HPfbg=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf v2 0/4] bpf: Fix possible memleak when updating hash and local storage maps
Date: Tue, 21 Oct 2025 00:46:04 +0800
Message-ID: <20251020164608.20536-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the discussion thread
"[PATCH bpf-next v9 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps"[1],
it was pointed out that missing calls to bpf_obj_free_fields() could
lead to memory leaks.

A selftest was added to confirm that this is indeed a real issue - the
memory referenced by BPF_KPTR_{REF,PERCPU} fields is not freed when
bpf_obj_free_fields() is missing after copy_map_value[,_long]().

Further inspection of copy_map_value[,_long]() call sites revealed two
locations affected by this issue:

1. pcpu_copy_value()
2. htab_map_update_elem() when used with BPF_F_LOCK

This series fixes the leaks by properly calling bpf_obj_free_fields()
(or check_and_free_fields()) after copy_map_value[,_long]() and adds
selftests to verify the fix.

Changes:
v1 -> v2:
* Add test to verify no memleak when updating cgroup local storage maps.
* Address review from AI bot:
  * Fast path without bucket lock (around line 610) in
    'bpf_local_storage.c'.
v1: https://lore.kernel.org/bpf/20251016145801.47552-1-leon.hwang@linux.dev/

Links:
[1] https://lore.kernel.org/bpf/20250930153942.41781-1-leon.hwang@linux.dev/

Leon Hwang (4):
  bpf: Fix possible memleak in [lru_,]percpu_hash map update
  bpf: Fix possible memleak when updating hash maps with BPF_F_LOCK
  bpf: Fix possible memleak when updating local storage maps with
    BPF_F_LOCK
  selftests/bpf: Add tests to verify no memleak when updating hash and
    cgrp storage maps

 kernel/bpf/bpf_local_storage.c                |   1 +
 kernel/bpf/hashtab.c                          |   4 +
 .../bpf/prog_tests/refcounted_kptr.c          | 167 +++++++++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 160 +++++++++++++++++
 4 files changed, 331 insertions(+), 1 deletion(-)

--
2.51.0


