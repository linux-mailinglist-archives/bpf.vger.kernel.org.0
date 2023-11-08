Return-Path: <bpf+bounces-14479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC5F7E57EB
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8981C20BA7
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 13:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EB019455;
	Wed,  8 Nov 2023 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aiJ1n6/o"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AA19441;
	Wed,  8 Nov 2023 13:24:56 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C541BEB;
	Wed,  8 Nov 2023 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=M1NmQPy85Z8pzih/5Twc2EPfw96cy1vSfLp8k9FcaXY=; b=aiJ1n6/ondu62ZifADQ8wQajMS
	OgbX6rFsaND08d4ySBxtlVtVrTf0NlIvXsdJ3H8djAv0rcxhQrFY1KTr3haKg2fvEu4fTbf0t9K5v
	kEOm1ioVYA5FQhgRcoAG8rsy+eyneWqsOWDJ357/USVBf1LdwYpPuxOygjmvm7tcfBz9JgPA1wvZD
	HHv3PSjrzJ1UJSLoySjzdoyaC5ooXie9eyvlGAioSeP2uhDnO07DvoBJCQbsdq6ZlZc5Xtk6Rniwc
	fqywzHqwEjDCtTYbWG2MMIZtZY/qr0YyMOiC+objws1UAUDZaDnwZTZKzwG5UQ3jSQj9AxkzKDdto
	GON8ch6A==;
Received: from mob-194-230-147-75.cgn.sunrise.net ([194.230.147.75] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r0iY7-0006Pv-RI; Wed, 08 Nov 2023 14:24:52 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2023-11-08
Date: Wed,  8 Nov 2023 14:24:48 +0100
Message-Id: <20231108132448.1970-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27087/Wed Nov  8 09:40:00 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 16 non-merge commits during the last 6 day(s) which contain
a total of 30 files changed, 341 insertions(+), 130 deletions(-).

The main changes are:

1) Fix a BPF verifier issue in precision tracking for BPF_ALU | BPF_TO_BE |
   BPF_END where the source register was incorrectly marked as precise,
   from Shung-Hsi Yu.

2) Fix a concurrency issue in bpf_timer where the former could still have
   been alive after an application releases or unpins the map, from Hou Tao.

3) Fix a BPF verifier issue where immediates are incorrectly cast to u32
   before being spilled and therefore losing sign information, from Hao Sun.

4) Fix a misplaced BPF_TRACE_ITER in check_css_task_iter_allowlist which
   incorrectly compared bpf_prog_type with bpf_attach_type, from Chuyi Zhou.

5) Add __bpf_hook_{start,end} as well as __bpf_kfunc_{start,end}_defs macros,
   migrate all BPF-related __diag callsites over to it, and add a new
   __diag_ignore_all for -Wmissing-declarations to the macros to address
   recent build warnings, from Dave Marchevsky.

6) Fix broken BPF selftest build of xdp_hw_metadata test on architectures
   where char is not signed, from Björn Töpel.

7) Fix test_maps selftest to properly use LIBBPF_OPTS() macro to initialize
   the bpf_map_create_opts, from Andrii Nakryiko.

8) Fix bpffs selftest to avoid unmounting /sys/kernel/debug as it may have
   been mounted and used by other applications already, from Manu Bretelle.

9) Fix a build issue without CONFIG_CGROUPS wrt css_task open-coded
   iterators, from Matthieu Baerts.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Anders Roxell, Andrii Nakryiko, David Vernet, Eduard Zingerman, Hsin-Wei 
Hung, Jiri Olsa, kernel test robot, Larysa Zaremba, Mohamed Mahmoud, 
Shung-Hsi Yu, Tao Lyu, Toke Høiland-Jørgensen, Yafang Shao, Yonghong Song

----------------------------------------------------------------

The following changes since commit 2b7ac0c87d985c92e519995853c52b9649ea4b07:

  tools: ynl-gen: don't touch the output file if content is the same (2023-11-01 22:14:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 8e1b802503bb630eafc3e97b2daf755368ec96e1:

  Merge branch 'Let BPF verifier consider {task,cgroup} is trusted in bpf_iter_reg' (2023-11-07 15:28:06 -0800)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'bpf-fix-incorrect-immediate-spill'
      Merge branch 'relax-allowlist-for-open-coded-css_task-iter'
      Merge branch 'bpf-fix-precision-tracking-for-bpf_alu-bpf_to_be-bpf_end'

Andrii Nakryiko (1):
      selftests/bpf: fix test_maps' use of bpf_map_create_opts

Björn Töpel (1):
      selftests/bpf: Fix broken build where char is unsigned

Chuyi Zhou (5):
      bpf: Relax allowlist for css_task iter
      selftests/bpf: Add tests for css_task iter combining with cgroup iter
      selftests/bpf: Add test for using css_task iter in sleepable progs
      bpf: Let verifier consider {task,cgroup} is trusted in bpf_iter_reg
      selftests/bpf: get trusted cgrp from bpf_iter__cgroup directly

Dave Marchevsky (2):
      bpf: Add __bpf_kfunc_{start,end}_defs macros
      bpf: Add __bpf_hook_{start,end} macros

Hao Sun (2):
      bpf: Fix check_stack_write_fixed_off() to correctly spill imm
      selftests/bpf: Add test for immediate spilled to stack

Hou Tao (1):
      bpf: Check map->usercnt after timer->timer is assigned

Manu Bretelle (1):
      selftests/bpf: fix test_bpffs

Martin KaFai Lau (1):
      Merge branch 'Let BPF verifier consider {task,cgroup} is trusted in bpf_iter_reg'

Matthieu Baerts (1):
      bpf: fix compilation error without CGROUPS

Shung-Hsi Yu (2):
      bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
      selftests/bpf: precision tracking test for BPF_NEG and BPF_END

 Documentation/bpf/kfuncs.rst                       |  6 +-
 include/linux/btf.h                                | 11 +++
 kernel/bpf/bpf_iter.c                              |  6 +-
 kernel/bpf/cgroup_iter.c                           |  8 +-
 kernel/bpf/cpumask.c                               |  6 +-
 kernel/bpf/helpers.c                               | 39 +++++----
 kernel/bpf/map_iter.c                              |  6 +-
 kernel/bpf/task_iter.c                             | 24 +++---
 kernel/bpf/verifier.c                              | 33 ++++++--
 kernel/cgroup/rstat.c                              |  9 +--
 kernel/trace/bpf_trace.c                           |  6 +-
 net/bpf/test_run.c                                 |  7 +-
 net/core/filter.c                                  | 13 +--
 net/core/xdp.c                                     |  6 +-
 net/ipv4/fou_bpf.c                                 |  6 +-
 net/netfilter/nf_conntrack_bpf.c                   |  6 +-
 net/netfilter/nf_nat_bpf.c                         |  6 +-
 net/socket.c                                       |  8 +-
 net/xfrm/xfrm_interface_bpf.c                      |  6 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  6 +-
 .../selftests/bpf/map_tests/map_percpu_stats.c     | 20 ++---
 .../testing/selftests/bpf/prog_tests/cgroup_iter.c | 33 ++++++++
 tools/testing/selftests/bpf/prog_tests/iters.c     |  1 +
 .../testing/selftests/bpf/prog_tests/test_bpffs.c  | 11 ++-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  2 +
 tools/testing/selftests/bpf/progs/iters_css_task.c | 55 +++++++++++++
 .../selftests/bpf/progs/iters_task_failure.c       |  4 +-
 .../selftests/bpf/progs/verifier_precision.c       | 93 ++++++++++++++++++++++
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c  | 32 ++++++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  2 +-
 30 files changed, 341 insertions(+), 130 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_precision.c

