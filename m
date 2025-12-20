Return-Path: <bpf+bounces-77221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557BCD26C8
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B6630380D5
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB42EC0B3;
	Sat, 20 Dec 2025 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cwAU33OF"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4F276050
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204000; cv=none; b=RhL+yhYbM2Fr0tempQGYf8hIOfdiLety8883ahtDFgKSsq4ETNVUvYdYX9QnCp6CmY8lCX3fVstZ+A/SZ3TZwZJCEP+vPlbnKntf2KSgWC/CXAAD8ABPvYr/Rw6TTB9V95Ypqyt8UuXIV1/SDZZQyJAQd2yrJYaHu3UFUncVW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204000; c=relaxed/simple;
	bh=SHv2Iq955cChy4Uoy4h2p6Pssci1g9l9LMiOPWGVdAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1AO5oUzT/XpUd1bNg86vTHWMrAc24UsqKvRO5hC9bXEW3TTHcGaoJ54NFWp3zXKVdoBap1mKSNlAGztKh61UKy1pJ4ehf1USL6i/TfvolLJGKW5QtjLyINQYbj5Uob34w6qkA577+swWfTZM1PPjdsXhrvhPgszUDGD+CAYD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cwAU33OF; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766203983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wj67LJX/XEXlSZrfpiOUjDxm3w3z3jaCg452pE5m7xA=;
	b=cwAU33OF8lzqQdJ5ZZcFI2VxRJuRM5zjc43cBN/2hm2mUDbQJFu/4Z7MbYdkX0vrxeFZUj
	PelNzJYTzUeNfH4tByrRIV4mtSREmvkEfZhgtCRtaY19D4liYxRdFchAekbiOe6K1IaOhb
	SMqtUc6uPVeRTvok7YuS7qLe6wTcfIk=
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
Subject: [PATCH bpf-next v2 0/7] mm: bpf kfuncs to access memcg data
Date: Fri, 19 Dec 2025 20:12:43 -0800
Message-ID: <20251220041250.372179-1-roman.gushchin@linux.dev>
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

v2:
  - added mem_cgroup_disabled() checks (by Shakeel B.)
  - added special handling of the root memcg in bpf_mem_cgroup_usage()
  (by Shakeel B.)
  - minor fixes in the kselftest (by Shakeel B.)
  - added a MAINTAINERS entry (by Shakeel B.)

v1:
  https://lore.kernel.org/bpf/87ike29s5r.fsf@linux.dev/T/#t


JP Kobryn (2):
  mm: introduce BPF kfunc to access memory events
  bpf: selftests: selftests for memcg stat kfuncs

Roman Gushchin (5):
  mm: declare memcg_page_state_output() in memcontrol.h
  mm: introduce BPF kfuncs to deal with memcg pointers
  mm: introduce bpf_get_root_mem_cgroup() BPF kfunc
  mm: introduce BPF kfuncs to access memcg statistics and events
  MAINTAINERS: add an entry for MM BPF extensions

 MAINTAINERS                                   |   7 +
 include/linux/memcontrol.h                    |   3 +
 mm/Makefile                                   |   3 +
 mm/bpf_memcontrol.c                           | 179 ++++++++++++++
 mm/memcontrol-v1.h                            |   1 -
 .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 223 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_memcg.c   |  39 +++
 8 files changed, 472 insertions(+), 1 deletion(-)
 create mode 100644 mm/bpf_memcontrol.c
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c

-- 
2.52.0


