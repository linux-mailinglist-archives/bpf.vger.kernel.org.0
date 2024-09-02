Return-Path: <bpf+bounces-38733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B649968EAB
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 22:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50631F23497
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A41D61B2;
	Mon,  2 Sep 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QELLTP63"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FB1C62D2;
	Mon,  2 Sep 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307516; cv=none; b=iD4RzRfXAdPNwansGOYe9wLfk81AmEs+zvL9ADxYmYwKMEUvbWxjKcJDiF5PrYPTmBLFCtg/H3Oa3VfDMdM5gRyNYwAcBoY+8MhELaG80I89hugMWo8bzd80rosnsOiWqWykterd1oT1Pgwt6cH8NSZ3idlebK486vOF+XBFYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307516; c=relaxed/simple;
	bh=rlcVAYAHHXvi4YAo/PA0SyrdQOJptJuD1RuUQmeZcFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gamnmFsBR6FNY8SjYW8c9I8UE8Tzl3EXL2PGiq7H0eZUwGtuefr68zq9fqiW4nbfaGAH3d3c5W/Ut1QzkuhQv+6Co1Ob8oizzBWz5oU1zXSrUSTWPsTrmEw6U5/5EL8gdpJTCDCe3MR2jGHdbqCL9+2peeLH84AZhZAIk1hBGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QELLTP63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70CDC4CEC6;
	Mon,  2 Sep 2024 20:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725307516;
	bh=rlcVAYAHHXvi4YAo/PA0SyrdQOJptJuD1RuUQmeZcFI=;
	h=From:To:Cc:Subject:Date:From;
	b=QELLTP63tQsZXzfkQzsDPlagiqFN/5MBFcw/t92Mqc7wodBRsaSvDdtdjNnmOSFDv
	 JkkS1WsSCGDzbHeERs58VVMHq6Kpd8x8VdEoSibh/no+2VeryXJTky5me2042EMqIx
	 EvOLcLlX3KTBL3rwb4c/WG2A/fDbOyFRx2GtQgNdeIgWHq6bKnQwGEUp1HfeKaX9+p
	 D8S+XrY6Xu3dYiBC0YKGR0eiLxA/7v4b7NlItZNkgrU3mYlXaLH9j3E6MXnnahXCtf
	 YNfq/v5HvZPGjmuzBzV6w0uymgAEy8VaSMp0OJB6zkaVbidYmTXFyFE5mmBaL8U1Ip
	 FzBw3BMTVDXxQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCHSET 0/5] perf tools: Constify BPF control data properly (v1)
Date: Mon,  2 Sep 2024 13:05:10 -0700
Message-ID: <20240902200515.2103769-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I've realized that some control data (usually for filter actions)
should be defined as 'const volatile' so that it can passed to the BPF
core and to be optimized properly (like with dead code elimination).

Convert the existing codes with the similar patterns.

Thanks,
Namhyung


Namhyung Kim (5):
  perf stat: Constify control data for BPF
  perf ftrace latency: Constify control data for BPF
  perf kwork: Constify control data for BPF
  perf lock contention: Constify control data for BPF
  perf record offcpu: Constify control data for BPF

 tools/perf/util/bpf_counter_cgroup.c          |  6 +--
 tools/perf/util/bpf_ftrace.c                  |  8 ++--
 tools/perf/util/bpf_kwork.c                   |  9 ++--
 tools/perf/util/bpf_kwork_top.c               |  7 +--
 tools/perf/util/bpf_lock_contention.c         | 45 ++++++++++---------
 tools/perf/util/bpf_off_cpu.c                 | 16 +++----
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c   |  2 +-
 tools/perf/util/bpf_skel/func_latency.bpf.c   |  7 +--
 tools/perf/util/bpf_skel/kwork_top.bpf.c      |  2 +-
 tools/perf/util/bpf_skel/kwork_trace.bpf.c    |  5 ++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 27 +++++------
 tools/perf/util/bpf_skel/off_cpu.bpf.c        |  9 ++--
 12 files changed, 76 insertions(+), 67 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


