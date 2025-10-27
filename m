Return-Path: <bpf+bounces-72357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AABC0FC82
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 18:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E042519A8869
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08131A818;
	Mon, 27 Oct 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQoFlIwU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DE315D2A;
	Mon, 27 Oct 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587442; cv=none; b=PKThu1UYqKoliNpGDL6pmfJ+UfK0JqYJM6/bo9aqsk94MuQf19yPDjn8TbDTp2uE/I2oJBFTBgOeemanA4Ds5XDcGP7BpfGSSEYQTgLsVZNt7s5OTJGiPeyT/o0cq5z23Y6OG4R1NY0ywKx2O0CAZvxzpUMMobyvLlW1B62veJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587442; c=relaxed/simple;
	bh=P3oO4yY5mpwazix2hUgQq51rIJb3kogk/q4QdDTwFZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSAgONXlMYFUQYaAtZatyPFpcAEpKitCr/er/9ml/jsDR5nfaympgprN1o4pAJ5l7XnthT4APyopWRQvMWOg/Mrg+951ESqP3MOgB5BSzwIXzDthZb9Z/0Chy+x20I0yEwGTLtgczSrqPJfxKn7Z+jFW0+ifaC7+Yw6sHajYDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQoFlIwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEB2C4CEFD;
	Mon, 27 Oct 2025 17:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761587441;
	bh=P3oO4yY5mpwazix2hUgQq51rIJb3kogk/q4QdDTwFZI=;
	h=From:To:Cc:Subject:Date:From;
	b=gQoFlIwUjeKHJ00cAgHk3L2Q8wsncwZqsq3cSdFHwkLPh8GBh1IQjjPFvMV6OgrwC
	 mE1KlyiorOL8FRwlOM6K6Cw87JUpFnERkUmoTb8brAwwWR2ISzJ3+/JOSMZqDAnwTr
	 cjKastoh0MAdibu8e299eSrVlZRZqkPwOj12Kmg5XqdLrPkAWwWzJVjhg4ik2TtT7c
	 W8baR12Cim7fEkSCXnPcFrP2mfAdZhVMNW6LMw0BDpixgTQGESDUMCl72Yp0D+qWJ6
	 4deH8eNuGDSoUMQCGzsiI0oq3VKw6KVSHiklUQnncQW40PsKuN+gAsYHCUco40KikK
	 eCQHTl/AxnR2g==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	rostedt@goodmis.org,
	andrey.grodzovsky@crowdstrike.com,
	mhiramat@kernel.org,
	kernel-team@meta.com,
	olsajiri@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf 0/3] Fix ftrace for livepatch + BPF fexit programs
Date: Mon, 27 Oct 2025 10:50:20 -0700
Message-ID: <20251027175023.1521602-1-song@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

livepatch and BPF trampoline are two special users of ftrace. livepatch
uses ftrace with IPMODIFY flag and BPF trampoline uses ftrace direct
functions. When livepatch and BPF trampoline with fexit programs attach to
the same kernel function, BPF trampoline needs to call into the patched
version of the kernel function.

1/3 and 2/3 of this patchset fix two issues with livepatch + fexit cases,
one in the register_ftrace_direct path, the other in the
modify_ftrace_direct path.

3/3 adds selftests for both cases.

---

Changes v3 => v4:
1. Add helper reset_direct. (Steven)
2. Add Reviewed-by from Jiri.
3. Fix minor typo in comments.

v3: https://lore.kernel.org/bpf/20251026205445.1639632-1-song@kernel.org/

Changes v2 => v3:
1. Incorporate feedback by AI, which also fixes build error reported by
   Steven and kernel test robot.

v2: https://lore.kernel.org/bpf/20251024182901.3247573-1-song@kernel.org/

Changes v1 => v2:
1. Target bpf tree. (Alexei)
2. Bring back the FTRACE_WARN_ON in __ftrace_hash_update_ipmodify
   for valid code paths. (Steven)
3. Update selftests with cleaner way to find livepatch-sample.ko.
   (offlline discussion with Ihor)

v1: https://lore.kernel.org/bpf/20251024071257.3956031-1-song@kernel.org/

Song Liu (3):
  ftrace: Fix BPF fexit with livepatch
  ftrace: bpf: Fix IPMODIFY + DIRECT in modify_ftrace_direct()
  selftests/bpf: Add tests for livepatch + bpf trampoline

 kernel/bpf/trampoline.c                       |   5 -
 kernel/trace/ftrace.c                         |  60 +++++++---
 tools/testing/selftests/bpf/config            |   3 +
 .../bpf/prog_tests/livepatch_trampoline.c     | 107 ++++++++++++++++++
 .../bpf/progs/livepatch_trampoline.c          |  30 +++++
 5 files changed, 185 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
 create mode 100644 tools/testing/selftests/bpf/progs/livepatch_trampoline.c

--
2.47.3

