Return-Path: <bpf+bounces-7417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4E776FD6
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 07:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47911C2147A
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFC0111C;
	Thu, 10 Aug 2023 05:52:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEA10E1
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 05:52:11 +0000 (UTC)
Received: from out-91.mta1.migadu.com (out-91.mta1.migadu.com [95.215.58.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D6F3
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 22:52:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691646725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C9O6JIx2JwFYOlrML74s8DcEj6L71Q2nq69Pn/oMqiw=;
	b=PMEs9FQTbc8nVPA6+YYIGJOST87459Xf+ko8j7li6/ZdWROAXFeIjDrGC/GLahsnJSm+ze
	u9tKWJwMCCKE200Qq55xw51CJCJqeqzjW5Be3vJYRt3JCtp5CfFKtao013zYRUldG70mLE
	LrQr9eAxVsa5ubzjCY2WFWh14IBB5+g=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2023-08-09
Date: Wed,  9 Aug 2023 22:51:23 -0700
Message-Id: <20230810055123.109578-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 19 non-merge commits during the last 6 day(s) which contain
a total of 25 files changed, 369 insertions(+), 141 deletions(-).

The main changes are:

1) Fix array-index-out-of-bounds access when detaching from an
   already empty mprog entry from Daniel Borkmann.

2) Adjust bpf selftest because of a recent llvm change
   related to the cpu-v4 ISA from Eduard Zingerman.

3) Add uprobe support for the bpf_get_func_ip helper from Jiri Olsa.

4) Fix a KASAN splat due to the kernel incorrectly accepted
   an invalid program using the recent cpu-v4 instruction from
   Yonghong Song.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Dan Carpenter, David Vernet, Eduard Zingerman, Simon Horman,
Viktor Malik, Yonghong Song

----------------------------------------------------------------

The following changes since commit 6f9bad6b2d7d6b4e11032b944e379974e31c5c8f:

  eth: dpaa: add missing net/xdp.h include (2023-08-03 16:17:34 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 2adbb7637fd1fcec93f4680ddb5ddbbd1a91aefb:

  bpf: btf: Remove two unused function declarations (2023-08-08 17:25:02 -0700)

----------------------------------------------------------------
bpf-next pull-request 2023-08-09

----------------------------------------------------------------
Daniel Borkmann (2):
      bpf: Fix mprog detachment for empty mprog entry
      selftests/bpf: Add test for detachment on empty mprog entry

Eduard Zingerman (1):
      selftests/bpf: relax expected log messages to allow emitting BPF_ST

Jiri Olsa (3):
      bpf: Add support for bpf_get_func_ip helper for uprobe program
      selftests/bpf: Add bpf_get_func_ip tests for uprobe on function entry
      selftests/bpf: Add bpf_get_func_ip test for uprobe inside function

Kui-Feng Lee (4):
      selftests/bpf: fix the incorrect verification of port numbers.
      bpf: fix inconsistent return types of bpf_xdp_copy_buf().
      bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.
      selftests/bpf: remove duplicated functions

Li kunyu (1):
      bpf: bpf_struct_ops: Remove unnecessary initial values of variables

Martin KaFai Lau (1):
      Merge branch 'bpf: Support bpf_get_func_ip helper in uprobes'

Sergey Kacheev (1):
      libbpf: Use local includes inside the library

Will Hawkins (2):
      bpf, docs: Formalize type notation and function semantics in ISA standard
      bpf, docs: Fix small typo and define semantics of sign extension

Yang Yingliang (1):
      bpf: change bpf_alu_sign_string and bpf_movsx_string to static

Yonghong Song (2):
      bpf: Fix an incorrect verification success with movsx insn
      selftests/bpf: Add a movsx selftest for sign-extension of R10

Yue Haibing (2):
      bpf: lru: Remove unused declaration bpf_lru_promote()
      bpf: btf: Remove two unused function declarations

 .../bpf/standardization/instruction-set.rst        | 121 ++++++++++++++++++---
 include/linux/bpf.h                                |   9 +-
 include/linux/btf.h                                |   2 -
 include/linux/filter.h                             |   5 +-
 include/uapi/linux/bpf.h                           |   7 +-
 kernel/bpf/bpf_lru_list.h                          |   1 -
 kernel/bpf/bpf_struct_ops.c                        |   6 +-
 kernel/bpf/disasm.c                                |   4 +-
 kernel/bpf/helpers.c                               |   2 +-
 kernel/bpf/mprog.c                                 |   2 +
 kernel/bpf/verifier.c                              |  31 ++++--
 kernel/trace/bpf_trace.c                           |  11 +-
 kernel/trace/trace_probe.h                         |   5 +
 kernel/trace/trace_uprobe.c                        |   7 +-
 tools/include/uapi/linux/bpf.h                     |   7 +-
 tools/lib/bpf/bpf_tracing.h                        |   2 +-
 tools/lib/bpf/usdt.bpf.h                           |   4 +-
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c      |  92 +++-------------
 .../selftests/bpf/prog_tests/get_func_ip_test.c    |  57 +++++++++-
 tools/testing/selftests/bpf/prog_tests/log_fixup.c |   2 +-
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |  37 ++++++-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |  31 ++++++
 .../testing/selftests/bpf/progs/get_func_ip_test.c |  25 ++++-
 .../selftests/bpf/progs/get_func_ip_uprobe_test.c  |  18 +++
 tools/testing/selftests/bpf/progs/verifier_movsx.c |  22 ++++
 25 files changed, 369 insertions(+), 141 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c

