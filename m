Return-Path: <bpf+bounces-77097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDCECCE330
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9BA53058627
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EC22737F9;
	Fri, 19 Dec 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KWH08YEc"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB1272816
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109486; cv=none; b=XohNchD/5KClx6vJo1p0HL4ZcZzmYn9/wQpLjZjlQofWsAWtCu9U22lPRNOaTUU3Y6u+ooBjD2XfFx3GTe3AaGe0DRdNVQkL+EgiurS20h7w42IgS7SYy7TFLDW/QShEvrHEasuY/OL2jbONYZPdANDI8HOazby4ipW/lbSfm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109486; c=relaxed/simple;
	bh=6X7DwnpBSNdwV9o3sjHEbF3A3DnQ8ehTodGph/Csq6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eACYm1h4BE1k49WLdpuHSqlFCMYpdWeCJwlgqApUgtwsahW/qE2nXCWL2SDwX7W+Xvz9s5jYHbM0IRn77wuUK/G6ysuGIr5Hbn+eJ+mrnoI5tHwP1m61iSV2zryfifWotWmBkxOyNCZViI9QdOzpKEtd13Wxc4dmkxNkvFWll74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KWH08YEc; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766109482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L2xoCujIaM8urCKbtnvhzmEUA6Re927k76kBPypVsAM=;
	b=KWH08YEcj7C6mMQvC0lfQRUPN/zJanVLFFqax3ysRJi1W8cnghsrSM5QUDS1uBEUATGQ+R
	8EK9RZlyY1ZuRe8c+hsSZUFQ0IqM23cQOZEUNbdebKw0yQl+ZGFEjzCVOIvqczdIXjsPix
	8GsMwEGyXGDA30sjJgBKhJNuprh6g44=
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
Subject: [PATCH bpf-next v1 0/6] mm: bpf kfuncs to access memcg data
Date: Thu, 18 Dec 2025 17:57:44 -0800
Message-ID: <20251219015750.23732-1-roman.gushchin@linux.dev>
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


JP Kobryn (2):
  mm: introduce BPF kfunc to access memory events
  bpf: selftests: selftests for memcg stat kfuncs

Roman Gushchin (4):
  mm: declare memcg_page_state_output() in memcontrol.h
  mm: introduce BPF kfuncs to deal with memcg pointers
  mm: introduce bpf_get_root_mem_cgroup() BPF kfunc
  mm: introduce BPF kfuncs to access memcg statistics and events

 include/linux/memcontrol.h                    |   3 +
 mm/Makefile                                   |   3 +
 mm/bpf_memcontrol.c                           | 175 ++++++++++++++
 mm/memcontrol-v1.h                            |   1 -
 .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 223 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_memcg.c   |  42 ++++
 7 files changed, 464 insertions(+), 1 deletion(-)
 create mode 100644 mm/bpf_memcontrol.c
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c

-- 
2.52.0


