Return-Path: <bpf+bounces-30253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DA08CB887
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873911C20D8B
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA54C7B;
	Wed, 22 May 2024 01:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCeo3ylA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F2DF5B;
	Wed, 22 May 2024 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341928; cv=none; b=DKOgBi1OFrhZGxMAJPUnoymnTXl1+pnF15GZHu93Ce3Gcf3myYQvGOca/z7NguQOMQPa3eJCLcRYfHwE5JVpeOOLzB2qM3sBR3cPwgnmeLqDXx820GQtpmIyq4odcKADiJTAvmKE99MqQi+VNlMXl3tQFT5RMUI/DBXccMRFL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341928; c=relaxed/simple;
	bh=D2SjqfOGPe5xouIRl6RPiNZsyBIkS56bzwVN0xMp4jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlbuMoLf1V3stpza+CvNPuY0jHo1XqUttDdXw9FU8JWTiBTSbpP1yJyk87KuajISrmSL6JcS59MSORC8f4pyTT/DYIpWSimkaR7qwYniY904kYdJ+wFORHDzcie53cYKrMocUrY9FY5EgOltniOFnZHM4b/w/spcQeVWLgNj9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCeo3ylA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0059FC2BD11;
	Wed, 22 May 2024 01:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716341928;
	bh=D2SjqfOGPe5xouIRl6RPiNZsyBIkS56bzwVN0xMp4jc=;
	h=From:To:Cc:Subject:Date:From;
	b=jCeo3ylAH4qbXibrOW/lqDe1CEdwx6TtGht1HYRm3pbCmObmFymIBP4bJm2+ai2k7
	 JbY4jAVS3WwQ30X507X8OPy+2cC5lf5NsOTUH14vHJEZKRtmC45tpsfHXdtxw+ANU8
	 7BKCzvlY56W7EI+XPXvg0Fx5qOm7kEfrIcU/0aIe8p12jxfJ191agkCln/8+WA3s+U
	 JU1cWLptuQAfNL1VhYWIGJjSrl3dDcoFKy+WK2vGIu/YR+hQQxiST+WZ0NBO4pdkov
	 WBGLiQ8pb6FWu68hu0Y+jJLqvuD6Dx50HjF2YMbbaV3FyzizUqG944/UdmSvouUZK0
	 PO7ZBfdUV0Opg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: x86@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bpf@vger.kernel.org,
	rihams@fb.com,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 0/4] Fix user stack traces captured from uprobes
Date: Tue, 21 May 2024 18:38:41 -0700
Message-ID: <20240522013845.1631305-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set reports two issues with captured stack traces.

First issue, fixed in patch #2, deals with fixing up uretprobe trampoline
addresses in captured stack trace. This issue happens when there are pending
return probes, for which kernel hijacks some of the return addresses on user
stacks. The code is matching those special uretprobe trampoline addresses with
the list of pending return probe instances and replaces them with actual
return addresses. This is the same fixup logic that fprobe/kretprobe has for
kernel stack traces.

Second issue, which patch #3 is fixing with the help of heuristic, is having
to do with capturing user stack traces in entry uprobes. At the very entrance
to user function, frame pointer in rbp register is not yet setup, so actual
caller return address is still pointed to by rsp. Patch is using a simple
heuristic, looking for `push %rbp` instruction, to fetch this extra direct
caller return address, before proceeding to unwind the stack using rbp.

Patch #4 adds tests into BPF selftests, that validate that captured stack
traces at various points is what we expect to get. This patch, while being BPF
selftests, is isolated from any other BPF selftests changes and can go in
through non-BPF tree without the risk of merge conflicts.

Patches are based on latest linux-trace/probes/for-next.

v1->v2:
  - fixed GCC aggressively inlining test_uretprobe_stack() function (BPF CI);
  - fixed comments (Peter).

Andrii Nakryiko (4):
  uprobes: rename get_trampoline_vaddr() and make it global
  perf,uprobes: fix user stack traces in the presence of pending
    uretprobes
  perf,x86: avoid missing caller address in stack traces captured in
    uprobe
  selftests/bpf: add test validating uprobe/uretprobe stack traces

 arch/x86/events/core.c                        |  20 ++
 include/linux/uprobes.h                       |   3 +
 kernel/events/callchain.c                     |  43 +++-
 kernel/events/uprobes.c                       |  17 +-
 .../bpf/prog_tests/uretprobe_stack.c          | 186 ++++++++++++++++++
 .../selftests/bpf/progs/uretprobe_stack.c     |  96 +++++++++
 6 files changed, 361 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uretprobe_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/uretprobe_stack.c

-- 
2.43.0


