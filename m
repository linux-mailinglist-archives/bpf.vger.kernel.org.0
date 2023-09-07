Return-Path: <bpf+bounces-9394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CE79706E
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 09:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FCA1C20A9C
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 07:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C61107;
	Thu,  7 Sep 2023 07:13:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E934EDA
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 07:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E99CC43395;
	Thu,  7 Sep 2023 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694070796;
	bh=rfbYK7o1rbMxnbowSSbASi9HStp57pP82j9rPHyuJWs=;
	h=From:To:Cc:Subject:Date:From;
	b=P/lT+ZeXI9IT+G7RtBHxCTIzM3VEftWiJZadP/gydDIKyVLzj91q5CLLTrEcydL9r
	 Av+IRuI401rOluWhqXBqM3ak14Hgq+Q7DNsvWxi18eRVczvw7dcoAbRbNev5+CbEJw
	 XveW9oMM0V+MlcP5Dsjumvd5yMrnyNbHnJs1Rbh/dFbJnwIVXmqXLNuuU5LpbN/h/L
	 0C4n13fP1AHAVRQ7Uku8Cb/0Eow3v2AlaFi3gaIH5JmcTlnke4w5TBQKpxmN70ciXJ
	 phX0kXKuXT04xnXIoMi6T/z9ubKViLTM7pXGrn7y5/zpe+IAEZMQopGO0K1VsErpT7
	 w4K5XWqsJmTbw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCHv2 bpf-next 0/9] bpf: Add missed stats for kprobes
Date: Thu,  7 Sep 2023 09:13:02 +0200
Message-ID: <20230907071311.254313-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
at the moment we can't retrieve the number of missed kprobe
executions and subsequent execution of BPF programs.

This patchset adds:
  - counting of missed execution on attach layer for:
    . kprobes attached through perf link (kprobe/ftrace)
    . kprobes attached through kprobe.multi link (fprobe)
  - counting of recursion_misses for BPF kprobe programs


It's still technically possible to create kprobe without perf link (using
SET_BPF perf ioctl) in which case we don't have a way to retrieve the kprobe's
'missed' count. However both libbpf and cilium/ebpf libraries use perf link
if it's available, and for old kernels without perf link support we can use
BPF program to retrieve the kprobe missed count.

v2 changes:
  - rename bpf_prog_missed_array to bpf_prog_inc_misses_counters [Alexei]
  - add missing space to 'missed' output [Quentin]
  - drop runtime stats changes [Hou Tao]
  - add common helper for kprobe missed stats [Hou Tao]
  - add test for tracepoint recursion missed counts [Hou Tao]

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/missed_stats

thanks,
jirka


---
Jiri Olsa (9):
      bpf: Count stats for kprobe_multi programs
      bpf: Add missed value to kprobe_multi link info
      bpf: Add missed value to kprobe perf link info
      bpf: Count missed stats in trace_call_bpf
      bpftool: Display missed count for kprobe_multi link
      bpftool: Display missed count for kprobe perf link
      selftests/bpf: Add test for missed counts of perf event link kprobe
      selftests/bpf: Add test for recursion counts of perf event link kprobe
      selftests/bpf: Add test for recursion counts of perf event link tracepoint

 include/linux/bpf.h                                         |  16 ++++++++++++++++
 include/linux/trace_events.h                                |   6 ++++--
 include/uapi/linux/bpf.h                                    |   2 ++
 kernel/bpf/syscall.c                                        |  14 ++++++++------
 kernel/trace/bpf_trace.c                                    |  10 ++++++++--
 kernel/trace/trace_kprobe.c                                 |  14 +++++++++++---
 tools/bpf/bpftool/link.c                                    |   6 ++++++
 tools/include/uapi/linux/bpf.h                              |   2 ++
 tools/testing/selftests/bpf/DENYLIST.aarch64                |   1 +
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       |   5 +++++
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h |   2 ++
 tools/testing/selftests/bpf/prog_tests/missed.c             | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/missed_kprobe.c           |  30 ++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c |  48 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/missed_tp_recursion.c     |  41 +++++++++++++++++++++++++++++++++++++++++
 15 files changed, 322 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/missed.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_tp_recursion.c

