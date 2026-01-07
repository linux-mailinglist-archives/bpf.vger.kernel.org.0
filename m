Return-Path: <bpf+bounces-78116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B00CFE860
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 16:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6E843002871
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC8346E7B;
	Wed,  7 Jan 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4oN+Ib1"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132653469E6
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798940; cv=none; b=rVrRNDa6bsvlHUqdZY9CRE7yTcwJtlr6EIpEB8lwYWozdmyFb7TARjg2nvjhH16+aUj+6TgKQsQfU8eb5pi5B2XkA2OjA70QBFLyr7xZNpT7+vkYCli5oVkspWmu4AD2O8o3YS5TyiQLbycIFYP7Dg5381swiE106FJUDFNeQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798940; c=relaxed/simple;
	bh=azzVitQYZ2XO94489ycHRUOZrYOoIYB1gSvvqNt7NXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYh59sR0kbVMKW7HILJylTAXeVbBjVmRF4AghuUTx4iTxIDPfA/IS72KOw2cShRd1VTUAq7seWA11VGzPZRLYGL8kQsn1GO9YnyhlQ0LZBUnRXYfJnPGG8MOTMN5rC5jDqky6gZpWh+yDScApPUiqtYr3VQ05g5zHT6/wC30V3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4oN+Ib1; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767798935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2OzjI7j24nuDa7whWsVSC5vNwsQcqgS5TafzX2QInP4=;
	b=o4oN+Ib1SLvmJB3wzyQ9kNBRYR/TEtL4hdC7pmIqq90yDDc9osnN23oownidTWFL95/DD9
	0aTuVbmxJaUgCsqveHlSE4eLYvX89b7YhudFCPHNzFnnKea28Zr12ToZ4rNo36bN8iz54l
	13PtHAwWrrGt+084vVlyrnkmrOAzQ/4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 0/5] bpf: lru: Fix unintended eviction when updating lru hash maps
Date: Wed,  7 Jan 2026 23:14:51 +0800
Message-ID: <20260107151456.72539-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This unintended LRU eviction issue was observed while developing the
selftest for
"[PATCH bpf-next v10 0/8] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps" [1].

When updating an existing element in lru_hash or lru_percpu_hash maps,
the current implementation calls prealloc_lru_pop() to get a new node
before checking if the key already exists. If the map is full, this
triggers LRU eviction and removes an existing element, even though the
update operation only needs to modify the value in-place.

In the selftest of the aforementioned patch, this was to be worked around by
reserving an extra entry to
void triggering eviction in __htab_lru_percpu_map_update_elem(). However, the
underlying issue remains problematic because:

1. Users may unexpectedly lose entries when updating existing keys in a
   full map.
2. The eviction overhead is unnecessary for existing key updates.

This patchset fixes the issue by first checking if the key exists before
allocating a new node. If the key is found, update the value using the extra
LRU node without triggering any eviction. Only proceed with node allocation
if the key does not exist.

Links:
[1] https://lore.kernel.org/bpf/20251117162033.6296-1-leon.hwang@linux.dev/

Changes:
v2 -> v3:
 * Rebase onto the latest tree to fix CI build failures.
 * Free special fields of 'l_old' on the non-error path (per bot).

v1 -> v2:
 * Tidy hash handling in LRU code.
 * Factor out bpf_lru_node_reset_state helper.
 * Factor out bpf_lru_move_next_inactive_rotation helper.
 * Update element using preallocated extra elements in order to avoid
   breaking the update atomicity (per Alexei).
 * Check values on other CPUs in tests (per bot).
 * v1: https://lore.kernel.org/bpf/20251202153032.10118-1-leon.hwang@linux.dev/

Leon Hwang (5):
  bpf: lru: Tidy hash handling in LRU code
  bpf: lru: Factor out bpf_lru_node_reset_state helper
  bpf: lru: Factor out bpf_lru_move_next_inactive_rotation helper
  bpf: lru: Fix unintended eviction when updating lru hash maps
  selftests/bpf: Add tests to verify no unintended eviction when
    updating lru_[percpu_,]hash maps

 kernel/bpf/bpf_lru_list.c                     | 228 ++++++++++++++----
 kernel/bpf/bpf_lru_list.h                     |  10 +-
 kernel/bpf/hashtab.c                          |  96 +++++++-
 .../selftests/bpf/prog_tests/htab_update.c    | 129 ++++++++++
 4 files changed, 408 insertions(+), 55 deletions(-)

--
2.52.0


