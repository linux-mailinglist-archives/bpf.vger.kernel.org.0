Return-Path: <bpf+bounces-65898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E33B2AEC5
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDB3681E95
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5691D343D88;
	Mon, 18 Aug 2025 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OFXcVi3P"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E01343D76
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536511; cv=none; b=ONOV8xcOA+XV5Mn5+OMMrf/pc4pR/H6zItAn0+KgOj9JYz7czSveHela7Ce17dIFqpOyp+2gDT3cEWyL5xtqnhLKN/ED0VQa+mbpoJbMUwu2ziL+OJ0ogpmjZ+ZAc/mEe/EBzmIC2cbYzLeXntuJ0txgJdVhvD+hAn57yxy5o60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536511; c=relaxed/simple;
	bh=lwNLAN/DotVsyA3UfSNAQkHIgywR9xfwVNScnHiTT+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lh3Dkt6hbv0hSXn+6tNyl4QJQ4qM1RpHgzh9237uJC1gxg6zqgGGGy4e4XkoOopMW4C54ILh+WEwFaVl8ylLVwh9WFv7Nt8VOoxpKyp4+lOJbwHKwjJnumwGa77CfaPgmVxXLhdWD23yw4ZVhrLjQiPboN9BxWFArGdUmjMPEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OFXcVi3P; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9GgSRJiKCu3BOGI+c6Rkf7dEZO8accJ0kdmdmhdiQ9o=;
	b=OFXcVi3PUjmW38+SokI8waULo25wFMZMn4kwm4Cx6LY8Pe9wvfHWPTz0sDnlzsleOficHh
	F6LoRf3O0xQ1Munzo0yjiS2Qn+Q2gwY6LHsrDy75Ofvz9U6yiK/T19wxi1SL5u32/hPdeD
	lMrzNzcO/0iws375mn0AGpWK+i8v/qk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 00/14] mm: BPF OOM
Date: Mon, 18 Aug 2025 10:01:22 -0700
Message-ID: <20250818170136.209169-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patchset adds an ability to customize the out of memory
handling using bpf.

It focuses on two parts:
1) OOM handling policy,
2) PSI-based OOM invocation.

The idea to use bpf for customizing the OOM handling is not new, but
unlike the previous proposal [1], which augmented the existing task
ranking policy, this one tries to be as generic as possible and
leverage the full power of the modern bpf.

It provides a generic interface which is called before the existing OOM
killer code and allows implementing any policy, e.g. picking a victim
task or memory cgroup or potentially even releasing memory in other
ways, e.g. deleting tmpfs files (the last one might require some
additional but relatively simple changes).

The past attempt to implement memory-cgroup aware policy [2] showed
that there are multiple opinions on what the best policy is.  As it's
highly workload-dependent and specific to a concrete way of organizing
workloads, the structure of the cgroup tree etc, a customizable
bpf-based implementation is preferable over a in-kernel implementation
with a dozen on sysctls.

The second part is related to the fundamental question on when to
declare the OOM event. It's a trade-off between the risk of
unnecessary OOM kills and associated work losses and the risk of
infinite trashing and effective soft lockups.  In the last few years
several PSI-based userspace solutions were developed (e.g. OOMd [3] or
systemd-OOMd [4]). The common idea was to use userspace daemons to
implement custom OOM logic as well as rely on PSI monitoring to avoid
stalls. In this scenario the userspace daemon was supposed to handle
the majority of OOMs, while the in-kernel OOM killer worked as the
last resort measure to guarantee that the system would never deadlock
on the memory. But this approach creates additional infrastructure
churn: userspace OOM daemon is a separate entity which needs to be
deployed, updated, monitored. A completely different pipeline needs to
be built to monitor both types of OOM events and collect associated
logs. A userspace daemon is more restricted in terms on what data is
available to it. Implementing a daemon which can work reliably under a
heavy memory pressure in the system is also tricky.

[1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
[2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
[3]: https://github.com/facebookincubator/oomd
[4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html

----

v1:
  1) Both OOM and PSI parts are now implemented using bpf struct ops,
     providing a path the future extensions (suggested by Kumar Kartikeya Dwivedi,
     Song Liu and Matt Bobrowski)
  2) It's possible to create PSI triggers from BPF, no need for an additional
     userspace agent. (suggested by Suren Baghdasaryan)
     Also there is now a callback for the cgroup release event.
  3) Added an ability to block on oom_lock instead of bailing out (suggested by Michal Hocko)
  4) Added bpf_task_is_oom_victim (suggested by Michal Hocko)
  5) PSI callbacks are scheduled using a separate workqueue (suggested by Suren Baghdasaryan)

RFC:
  https://lwn.net/ml/all/20250428033617.3797686-1-roman.gushchin@linux.dev/


Roman Gushchin (14):
  mm: introduce bpf struct ops for OOM handling
  bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
  mm: introduce bpf_oom_kill_process() bpf kfunc
  mm: introduce bpf kfuncs to deal with memcg pointers
  mm: introduce bpf_get_root_mem_cgroup() bpf kfunc
  mm: introduce bpf_out_of_memory() bpf kfunc
  mm: allow specifying custom oom constraint for bpf triggers
  mm: introduce bpf_task_is_oom_victim() kfunc
  bpf: selftests: introduce read_cgroup_file() helper
  bpf: selftests: bpf OOM handler test
  sched: psi: refactor psi_trigger_create()
  sched: psi: implement psi trigger handling using bpf
  sched: psi: implement bpf_psi_create_trigger() kfunc
  bpf: selftests: psi struct ops test

 include/linux/bpf_oom.h                       |  49 +++
 include/linux/bpf_psi.h                       |  71 ++++
 include/linux/memcontrol.h                    |   2 +
 include/linux/oom.h                           |  12 +
 include/linux/psi.h                           |  15 +-
 include/linux/psi_types.h                     |  72 +++-
 kernel/bpf/verifier.c                         |   5 +
 kernel/cgroup/cgroup.c                        |  14 +-
 kernel/sched/bpf_psi.c                        | 337 ++++++++++++++++++
 kernel/sched/build_utility.c                  |   4 +
 kernel/sched/psi.c                            | 130 +++++--
 mm/Makefile                                   |   4 +
 mm/bpf_memcontrol.c                           | 166 +++++++++
 mm/bpf_oom.c                                  | 157 ++++++++
 mm/oom_kill.c                                 | 182 +++++++++-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  39 ++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   2 +
 .../selftests/bpf/prog_tests/test_oom.c       | 229 ++++++++++++
 .../selftests/bpf/prog_tests/test_psi.c       | 224 ++++++++++++
 tools/testing/selftests/bpf/progs/test_oom.c  | 108 ++++++
 tools/testing/selftests/bpf/progs/test_psi.c  |  76 ++++
 21 files changed, 1845 insertions(+), 53 deletions(-)
 create mode 100644 include/linux/bpf_oom.h
 create mode 100644 include/linux/bpf_psi.h
 create mode 100644 kernel/sched/bpf_psi.c
 create mode 100644 mm/bpf_memcontrol.c
 create mode 100644 mm/bpf_oom.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_psi.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c

-- 
2.50.1


