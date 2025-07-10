Return-Path: <bpf+bounces-62871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F7AFF762
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 05:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5429E189B183
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 03:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30528136B;
	Thu, 10 Jul 2025 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xalXz70u"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F0280325;
	Thu, 10 Jul 2025 03:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117693; cv=none; b=X3Ze3JajF7Q7Nt4d1NSoJgys4Ekqcq72dfLZw1Voeq/k4euTCSeTIgEZizHe0FePVN8dhpHR/KdSanGQl67viW+4OO5+J0Z/7hpUCjPrxz6a/dWamx9rgBEEayC8nEnU86yEgYmUbxIGfHSZsnNPjpdWWG9uPwWTmoH5rmKXgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117693; c=relaxed/simple;
	bh=NWCmJ+zEfwfgbRXquUFr7EcLgUu+2CJdCCQRAI+xnEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H57jzkcuCJVZIyCYTm9nOJTOxj35oxqzTn3jgwacopFYEjhjVe0l0Sm1E6ts/o7a9c5/3P/LDFqCwhYrykHRAiXGkrGPGETRFks4MDWfQO6w2hUe216bw50MibWcSHdd/aECG05byNzPt8Vv3h30wUoY7RYgOJC7b+HRMAn2gN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xalXz70u; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752117677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CSR2uISZBceEd6Z8VzgB8CnshhCFLyi1u5l5/uiK2t0=;
	b=xalXz70uPE7TM/EnJhABWTskkpSkP/48ZNhb0HZ/XIR08pxqgK5jPRAFHH66m5BdbOkSJJ
	MouBHfI9xuQKxCmWPea/9/pw3RTZQVpqEybcPS4Xy41Bh9IXIa/Gi3KnC9mHSOy0XKahy9
	htyXdtKeOkzAsx1lqs5NzRHSfqDbt+M=
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
Subject: [PATCH bpf-next v4 0/7] Move attach_type into bpf_link
Date: Thu, 10 Jul 2025 11:20:31 +0800
Message-ID: <20250710032038.888700-1-chen.dylane@linux.dev>
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
 kernel/bpf/net_namespace.c     | 10 ++++-----
 kernel/bpf/syscall.c           | 40 ++++++++++++++++++++--------------
 kernel/bpf/tcx.c               | 16 +++++++-------
 kernel/bpf/trampoline.c        | 10 +++++----
 kernel/trace/bpf_trace.c       |  4 ++--
 net/bpf/bpf_dummy_struct_ops.c |  3 ++-
 net/core/dev.c                 |  3 ++-
 net/core/sock_map.c            | 13 +++++------
 net/netfilter/nf_bpf_link.c    |  3 ++-
 16 files changed, 90 insertions(+), 78 deletions(-)

Change list:
 v3 -> v4:
  - move netns_type field to the end in bpf_netns_link to fill the byte
    hole.(Jakub)
  - the series reviewed-by Jakub
  - patch1,2,3,4,7 acked-by Daniel
  - patch7 acked-by Nikolay
  - change the patch0 name to be consistent with the v1 version, sorry for that
    the name is the same as patch1 in v2 and v3.
 v3: https://lore.kernel.org/bpf/20250709030802.850175-1-chen.dylane@linux.dev

 v2 -> v3:
  - move sleepable field to the end in bpf_link to fill the byte hole.(Jiri)
  - Acked from Jiri
 v2: https://lore.kernel.org/bpf/20250708082228.824766-1-chen.dylane@linux.dev

 v1 -> v2:
  - fix build error.(Jiri)
 v1: https://lore.kernel.org/bpf/20250707153916.802802-1-chen.dylane@linux.dev
-- 
2.48.1


