Return-Path: <bpf+bounces-62742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A71DAFDDDD
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 05:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE0C1C26EC3
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1458B1E7C10;
	Wed,  9 Jul 2025 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bm75rnhJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AB1E0E0B
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 03:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030522; cv=none; b=NK0XnV8z0P+/TCId6TWHMbpHxOVWFFoki62z27Y8hX6shm6T5+P6Uqdp4dyk42BEGG2KYLFO4NqHf6OOe0G2QlkRCDQdOKKfBlHZQ1bIuVsSOpXZiMBbuOM1fRYc4W6E1ghd6kUUVHOAKIyjYHPyUIJM+0usts6z3nChLuAAaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030522; c=relaxed/simple;
	bh=jTuYztbbMoYi0F79k6LUCNZpwzjRGgr3peSsD6k78Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgE0llH7r0d/d8+1bgBmiMROviovhi/32wvQO5HhfUn7cQsv9OBdi5IZN0L3thS4UvQnCUA1WK3rHlQ9YTACf15r+GqmWLndKuX7m17PvrWHhSUZ22b2M9VWf/tFWyFTsIEiKDqmi9cj0UrWHzI6DLpS8jb3KNjB6KCXb3hIIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bm75rnhJ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752030504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r/YRLtQXL3400MG0L8PDnU71+sc8ggILskVIUPnOQuQ=;
	b=Bm75rnhJrY96g9BbfOWhUHqSZGjPjPx0Oe1Y5tfYDExWkSPii/biY8HIV4AxhFSko1c3NM
	6PiZGj++VWS0/bcLP7ZlHkYlpQSxXVwFwoPeq4uQGjIpJnj6i+GtEfoHq+YnVoBck+fg/S
	LcrySkv1fEGK/VtIlL20o/sJu8jpMd0=
From: Tao Chen <chen.dylane@linux.dev>
To: daniel@iogearbox.net,
	razor@blackwall.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	horms@kernel.org,
	willemb@google.com,
	jakub@cloudflare.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	hawk@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v3 0/7] Add attach_type in bpf_link
Date: Wed,  9 Jul 2025 11:07:55 +0800
Message-ID: <20250709030802.850175-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Andrii suggested moving the attach_type into bpf_link, the previous discussion
is as follows:
https://lore.kernel.org/bpf/CAEf4BzY7TZRjxpCJM-+LYgEqe23YFj5Uv3isb7gat2-HU4OSng@mail.gmail.com

patch1 add attach_type in bpf_link, and pass it to bpf_link_init, which
will init the attach_type field.

patch2-7 remove the attach_type in struct bpf_xx_link, update the info
with bpf_link attach_type.

There are some functions finally call bpf_link_init but do not have bpf_attr
from user or do not need to init attach_type from user like bpf_raw_tracepoint_open,
now use prog->expected_attach_type to init attach_type.

bpf_struct_ops_map_update_elem
bpf_raw_tracepoint_open
bpf_struct_ops_test_run

Feedback of any kind is welcome, thanks.

Tao Chen (7):
  bpf: Add attach_type in bpf_link
  bpf: Remove attach_type in bpf_cgroup_link
  bpf: Remove attach_type in sockmap_link
  bpf: Remove location field in tcx_link
  bpf: Remove attach_type in bpf_netns_link
  bpf: Remove attach_type in bpf_tracing_link
  netkit: Remove location field in netkit_link

 drivers/net/netkit.c           | 10 ++++-----
 include/linux/bpf-cgroup.h     |  1 -
 include/linux/bpf.h            | 29 ++++++++++++++----------
 include/net/tcx.h              |  1 -
 kernel/bpf/bpf_iter.c          |  3 ++-
 kernel/bpf/bpf_struct_ops.c    |  5 +++--
 kernel/bpf/cgroup.c            | 17 +++++++--------
 kernel/bpf/net_namespace.c     |  8 +++----
 kernel/bpf/syscall.c           | 40 ++++++++++++++++++++--------------
 kernel/bpf/tcx.c               | 16 +++++++-------
 kernel/bpf/trampoline.c        | 10 +++++----
 kernel/trace/bpf_trace.c       |  4 ++--
 net/bpf/bpf_dummy_struct_ops.c |  3 ++-
 net/core/dev.c                 |  3 ++-
 net/core/sock_map.c            | 13 +++++------
 net/netfilter/nf_bpf_link.c    |  3 ++-
 16 files changed, 89 insertions(+), 77 deletions(-)

Change list:
 v2 -> v3:
  - move sleepable field to the end in bpf_link to fill the byte hole.(Jiri)
  - Acked from Jiri
 v2: https://lore.kernel.org/bpf/20250708082228.824766-1-chen.dylane@linux.dev

 v1 -> v2:
  - fix build error.(Jiri)
 v1: https://lore.kernel.org/bpf/20250707153916.802802-1-chen.dylane@linux.dev
-- 
2.48.1


