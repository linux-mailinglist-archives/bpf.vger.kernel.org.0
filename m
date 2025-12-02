Return-Path: <bpf+bounces-75890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 120AFC9BF4F
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1B2F349547
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182E25F975;
	Tue,  2 Dec 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ww2l/SQx"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5527146B
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689483; cv=none; b=l4rkNieT9kB5AfA5IDSdSrCPdOlXBXhTpFqEbedNLayBIW4TVYjcvIk/U/UArGfA8rrOoAvvrN2SakRuZMTRrZEeWOKoNcpMHRHR83MmqlUS9J1oK58JBiEZiITLMYjubylOowr4ox6MVmy0AeOOkAGURF6uvn+EIN3a3eZvHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689483; c=relaxed/simple;
	bh=lqFSWWgbCYLsxE6Jcv0lfyihLv79CSGPMuWmwkl1yVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJFH6K3uKey/MkLezsro0nyPwsKoA3aYMzBKB6Q6GGkhmEBQKIdjEWoNtoHQ/Al55/TCmdi5FTjGJ0cXmD2cL3Tgniu14RkSWKimsE+FSJKXLixXMjGYSJrK7ZDY2wnM3pKoW5AWtiksubbzpLBBq5kywtbYdH/sk6pn6IipEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ww2l/SQx; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764689469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sT5IkezlGFPCTc3WA5XyqMyPfdf9RAfyoHrWAPvBjSA=;
	b=Ww2l/SQxHsc+IBm+FinRcSFtbb/fSvvwH8eiAjouKRn/0UikpapWi2Sleb82wdtXU6RhOT
	wADfxwpMcPDadILU71W2zcRJQs4H5UvLQ4XQ8Hf7Zkd/V7Vjc8RD7j7hpam/0OBcJ1ygsc
	jR2jAz6McCnGYbt1vffZPZuHLJaG3W4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
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
Subject: [PATCH bpf-next 0/3] bpf: Fix unintended eviction when updating lru hash maps
Date: Tue,  2 Dec 2025 23:30:29 +0800
Message-ID: <20251202153032.10118-1-leon.hwang@linux.dev>
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

In the selftest, this was to be worked around by reserving an extra entry to
avoid triggering eviction in __htab_lru_percpu_map_update_elem().
However, the underlying issue remains problematic because:

1. Users may unexpectedly lose entries when updating existing keys in a
   full map.
2. The eviction overhead is unnecessary for existing key updates.

This patchset fixes the issue by first checking if the key exists before
allocating a new node. If the key is found, update the value in-place,
refresh the LRU reference, and return immediately without triggering any
eviction. Only proceed with node allocation if the key does not exist.

Links:
[1] https://lore.kernel.org/bpf/20251117162033.6296-1-leon.hwang@linux.dev/

Leon Hwang (3):
  bpf: Avoid unintended eviction when updating lru_hash maps
  bpf: Avoid unintended eviction when updating lru_percpu_hash maps
  selftests/bpf: Add tests to verify no unintended eviction when
    updating lru hash maps

 kernel/bpf/hashtab.c                          | 43 +++++++++++
 .../selftests/bpf/prog_tests/htab_update.c    | 73 +++++++++++++++++++
 2 files changed, 116 insertions(+)

--
2.52.0


