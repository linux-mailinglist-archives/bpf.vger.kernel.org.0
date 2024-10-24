Return-Path: <bpf+bounces-43105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969C39AF4DC
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2389D281A9C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 21:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F512178F1;
	Thu, 24 Oct 2024 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GQU/f1hd"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD79156C74;
	Thu, 24 Oct 2024 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807054; cv=none; b=lWSjEXBsoGwISrMpozZl/PxhUbapfqHkdRvKf/SxouwQ6ocOBbNDMBEZME/RXfWbn/QoE35PSUudaZmrw5glafvl2wJ7cMIezZd/hcaDkR+fWOYon6nBivHg2EpHgs0K7879agxp1c6Szfr1B+iDJfjhmHo5BPZwQC0OuKo+wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807054; c=relaxed/simple;
	bh=k2Cu7LS2AcDU1X9fd4y0JNdfOT8WJdBfnzX3gY+gSis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ty6dPjGC5lxFrm/Bhtx4MLIb13nYIfKb/M7WIw6/l8h0M9oZLad+pS9YmuR7EFBsq9QjQEDlQGOSV+xCCcl5M1Rw2ZYRai+dEcvfhATDWAVtrTeL2/USJH0qBKRbhBawPiL/cfFXSCj+ucLZFHzyWrXbo3HanICe9Tj0WASMSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GQU/f1hd; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=2gmx1gSLQpQKkoaF379JOep+mYJrpU3SlXt9w9fvpy4=; b=GQU/f1hdvzdt2k+F3qSU1ibYdL
	XAiH1SSEaHfpx1yIHvldIYp8fkbL4J1U9ZlSFWZOLlKXStlhz7In3pmrxiXLBcXpy+NNAVPJuCA5x
	fzIVyRTHKX8mqCpPhJzsPbBiMi1dJWHAnheDB84il+dRj8AKsSbL2AoEHwzmDXGaNk9+aMz8hOavs
	Mh1+k6thLpuOfZCVroZiC+L2/3M8bYuj4BYRIQ58GtyGL4wFFEYXWjyp9D7ufGxyp2xzHTj0SmILj
	Us+RtwySkzpRb48vwc/RDXfn84d3fJ3a5+iXzxJ2hSUsYGXHynUUmwnd78dM0oTRSOwd2WRjiG798
	TkDT/fTw==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t45pd-000LU5-B3; Thu, 24 Oct 2024 23:57:25 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.12-rc5
Date: Thu, 24 Oct 2024 23:57:24 +0200
Message-Id: <20241024215724.60017-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27437/Thu Oct 24 10:33:37 2024)

Hi Linus,

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to d5fb316e2af1d947f0f6c3666e373a54d9f27c6f:

  Merge branch 'add-the-missing-bpf_link_type-invocation-for-sockmap' (2024-10-24 10:17:13 -0700)

----------------------------------------------------------------
BPF fixes:

- Fix an out-of-bounds read in bpf_link_show_fdinfo for BPF
  sockmap link file descriptors (Hou Tao)

- Fix BPF arm64 JIT's address emission with tag-based KASAN
  enabled reserving not enough size (Peter Collingbourne)

- Fix BPF verifier do_misc_fixups patching for inlining of the
  bpf_get_branch_snapshot BPF helper (Andrii Nakryiko)

- Fix a BPF verifier bug and reject BPF program write attempts
  into read-only marked BPF maps (Daniel Borkmann)

- Fix perf_event_detach_bpf_prog error handling by removing an
  invalid check which would skip BPF program release (Jiri Olsa)

- Fix memory leak when parsing mount options for the BPF
  filesystem (Hou Tao)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Andrii Nakryiko (2):
      bpf: fix do_misc_fixups() for bpf_get_branch_snapshot()
      Merge branch 'add-the-missing-bpf_link_type-invocation-for-sockmap'

Daniel Borkmann (5):
      bpf: Add MEM_WRITE attribute
      bpf: Fix overloading of MEM_UNINIT's meaning
      bpf: Remove MEM_UNINIT from skb/xdp MTU helpers
      selftests/bpf: Add test for writes to .rodata
      selftests/bpf: Add test for passing in uninit mtu_len

Hou Tao (3):
      bpf: Preserve param->string when parsing mount options
      bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
      bpf: Check validity of link->type in bpf_link_show_fdinfo()

Jiri Olsa (1):
      bpf,perf: Fix perf_event_detach_bpf_prog error handling

Peter Collingbourne (1):
      bpf, arm64: Fix address emission with tag-based KASAN enabled

 arch/arm64/net/bpf_jit_comp.c                      | 12 +++-
 include/linux/bpf.h                                | 14 +++-
 include/linux/bpf_types.h                          |  1 +
 include/uapi/linux/bpf.h                           |  3 +
 kernel/bpf/helpers.c                               | 10 +--
 kernel/bpf/inode.c                                 |  5 +-
 kernel/bpf/ringbuf.c                               |  2 +-
 kernel/bpf/syscall.c                               | 16 +++--
 kernel/bpf/verifier.c                              | 75 +++++++++++-----------
 kernel/trace/bpf_trace.c                           |  6 +-
 net/core/filter.c                                  | 42 +++++-------
 tools/include/uapi/linux/bpf.h                     |  3 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  | 19 ++++++
 tools/testing/selftests/bpf/progs/verifier_const.c | 31 ++++++++-
 tools/testing/selftests/bpf/progs/verifier_mtu.c   | 18 ++++++
 15 files changed, 167 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mtu.c

