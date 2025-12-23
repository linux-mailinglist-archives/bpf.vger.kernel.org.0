Return-Path: <bpf+bounces-77340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D231BCD8105
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 05:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1776C305B5B3
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 04:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34112E7F3E;
	Tue, 23 Dec 2025 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eSPxj8VF"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739652E093A
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766464937; cv=none; b=kpG4Of1mkSwMzOiY/8dezdGW1FqqMk0dSTxjmWdYVmvnN6J2CJWUlECvh3rQosS9mwGPgZWcguNSBa0ARNVp3wEJAVDXxdM8GZaXUdKOL+xpuyLA7xoEUGxKJeLEFBxnI6wMIntOkOi4eGVu1zbi3xHkUzDKRtU2p0IgRdVOXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766464937; c=relaxed/simple;
	bh=0e3AkPcuDYwtqnHidiqbH4j+hrjei3Cg/LQz1y/LLVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2AIghezKimnXXaGjfIZOKcYT7aHz3tPkQkKbfdInERBqFS18OwuS3TO3Y4PPVQ42JkGf1w8pvWkX829T1V20MQZBnMcsr2/V3qf/T9ymHt9JpkNH9guLIUCxCqlJ5D4rswLX/aAc9WMM7rI8oPc/2YYWEwm3QEgkA5tt83McpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eSPxj8VF; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766464923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SjJvNSdwQ4A6e4PX6vyjBTwXtvr1QpS9I/j4kVhHdy4=;
	b=eSPxj8VFCZxBnerYcHV2YPXOcaJnq6PpJ7dqoZ7G3iHU6YXzZaNuCQuOjnKUSS7PnG8YnF
	SjTRSkx4Q6UjGIvW2uDwerwWfW8wUXnbjlcA2zJV2lIIR9F2j/fi4MFhgzwjTA/ntOiRu5
	Q3PhgpM6m3jpzs7AmfTPagoR9T7HhMk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: JP Kobryn <inwardvessel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v4 0/6] mm: bpf kfuncs to access memcg data
Date: Mon, 22 Dec 2025 20:41:50 -0800
Message-ID: <20251223044156.208250-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce kfuncs to simplify the access to the memcg data.
These kfuncs can be used to accelerate monitoring use cases and
for implementing custom OOM policies once BPF OOM is landed.

This patchset was separated out from the BPF OOM patchset to simplify
the logistics and accelerate the landing of the part which is useful
by itself. No functional changes since BPF OOM v2.

v4:
  - refactored memcg vm event and stat item idx checks (by Alexei)

v3:
  - dropped redundant kfuncs flags (by Alexei)
  - fixed kdocs warnings (by Alexei)
  - merged memcg stats access patches into one (by Alexei)
  - restored root memcg usage reporting, added a comment
  - added checks for enum boundaries
  - added Shakeel and JP as co-maintainers (by Shakeel)

v2:
  - added mem_cgroup_disabled() checks (by Shakeel B.)
  - added special handling of the root memcg in bpf_mem_cgroup_usage()
  (by Shakeel B.)
  - minor fixes in the kselftest (by Shakeel B.)
  - added a MAINTAINERS entry (by Shakeel B.)

v1:
  https://lore.kernel.org/bpf/87ike29s5r.fsf@linux.dev/T/#t


JP Kobryn (1):
  bpf: selftests: selftests for memcg stat kfuncs

Roman Gushchin (5):
  mm: declare memcg_page_state_output() in memcontrol.h
  mm: introduce BPF kfuncs to deal with memcg pointers
  mm: introduce bpf_get_root_mem_cgroup() BPF kfunc
  mm: introduce BPF kfuncs to access memcg statistics and events
  MAINTAINERS: add an entry for MM BPF extensions

 MAINTAINERS                                   |   9 +
 include/linux/memcontrol.h                    |  20 ++
 mm/Makefile                                   |   3 +
 mm/bpf_memcontrol.c                           | 193 +++++++++++++++
 mm/memcontrol-v1.h                            |   1 -
 mm/memcontrol.c                               |  16 ++
 .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 223 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_memcg.c   |  39 +++
 9 files changed, 521 insertions(+), 1 deletion(-)
 create mode 100644 mm/bpf_memcontrol.c
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c

-- 
2.52.0


