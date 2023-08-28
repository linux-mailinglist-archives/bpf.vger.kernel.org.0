Return-Path: <bpf+bounces-8820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D5578A6DB
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 09:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496F81C203B1
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4ED10FE;
	Mon, 28 Aug 2023 07:55:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BEEC2
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940C4C433C7;
	Mon, 28 Aug 2023 07:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209342;
	bh=+KomhCliNwatsQyfrHWximXXsPIfKu8TgSw0Q3b/dOE=;
	h=From:To:Cc:Subject:Date:From;
	b=qC4guuZIgT97GAiMVBgvu5Tj8x9/8GGYIoclDoqXjGUF/UCsR2AsdgxTj3UWfK1Wf
	 PhT2VfbuLrZ15qj49DGldS3UM2VMBbjWYhV6AfV0WZaO8NlsXxn4/olWTHCV0QUhVK
	 Dply7jW4oP9puiQZiGVugl5Qnky9/GYG12okrMJOUQFhN0ZFJEDH0kCTA7wPcgaAoT
	 zCzv6ZxZbMKtpgnnp1EZ0sCPOatxv6fnMOaxBj06nLm/C9qY4Nq+Sp2qmjuDWrWfoK
	 O/jDtvzaQE3gXWuiD+A5A3FiOK63z951wSyLDw0sKyHOJJVWVQx9HqPR/a/hqjeIzZ
	 ZOosfE9jqPf8g==
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
Subject: [PATCH bpf-next 00/12] bpf: Add missed stats for kprobes
Date: Mon, 28 Aug 2023 09:55:25 +0200
Message-ID: <20230828075537.194192-1-jolsa@kernel.org>
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
  - counting runtime stats (kernel.bpf_stats_enabled=1) for BPF programs
    executed through bpf_prog_run_array - kprobes, perf events, trace
    syscall probes


It's still technically possible to create kprobe without perf link (using
SET_BPF perf ioctl) in which case we don't have a way to retrieve the kprobe's
'missed' count. However both libbpf and cilium/ebpf libraries use perf link
if it's available, and for old kernels without perf link support we can use
BPF program to retrieve the kprobe missed count.

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/missed_stats

thanks,
jirka


---
Jiri Olsa (12):
      bpf: Move update_prog_stats to syscall object
      bpf: Move bpf_prog_start_time to linux/filter.h
      bpf: Count stats for kprobe_multi programs
      bpf: Add missed value to kprobe_multi link info
      bpf: Add missed value to kprobe perf link info
      bpf: Count missed stats in trace_call_bpf
      bpf: Move bpf_prog_run_array down in the header file
      bpf: Count run stats in bpf_prog_run_array
      bpftool: Display missed count for kprobe_multi link
      bpftool: Display missed count for kprobe perf link
      selftests/bpf: Add test missed counts of perf event link kprobe
      elftests/bpf: Add test recursion stats of perf event link kprobe

 include/linux/bpf.h                                         | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 include/linux/trace_events.h                                |   6 ++++--
 include/uapi/linux/bpf.h                                    |   2 ++
 kernel/bpf/syscall.c                                        |  36 +++++++++++++++++++++++++------
 kernel/bpf/trampoline.c                                     |  45 +++++----------------------------------
 kernel/trace/bpf_trace.c                                    |  17 ++++++++++++---
 kernel/trace/trace_kprobe.c                                 |   5 ++++-
 tools/bpf/bpftool/link.c                                    |   8 ++++++-
 tools/include/uapi/linux/bpf.h                              |   2 ++
 tools/testing/selftests/bpf/DENYLIST.aarch64                |   1 +
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       |   5 +++++
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h |   2 ++
 tools/testing/selftests/bpf/prog_tests/missed.c             |  97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/missed_kprobe.c           |  30 ++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c |  48 +++++++++++++++++++++++++++++++++++++++++
 15 files changed, 327 insertions(+), 83 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/missed.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c

