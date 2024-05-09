Return-Path: <bpf+bounces-29208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345AF8C1452
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6570E1C21D18
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EB4770E0;
	Thu,  9 May 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JmIVdnG7"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8694C8B
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277038; cv=none; b=O0FavC4e0Gx/4rBEeUuk6Fy07SsGbsHFCysWD0CSWI97m6d8sFwK2NvOJrMKRhIETr72fWu3ztO//V27byiWP1yjF/ZlcwAN8iC54DdUxuhBEt9+IkhOBICz1305+PZRITNkbsEaseu/njH7pTodcVkM6Yf80imR/aCQJqwjv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277038; c=relaxed/simple;
	bh=ht4XerKhvBx91hWbUaMec94BbPDIcjTWczLZw/zzwoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDG115KFSv0o+f945vs92MSMEN12OgOyxDo/PYcpA6AtYSrvLVmgyTWlAUq+FPCbMJcNNIZk3uZS0UvzOhf4on/ly6y8mtH1fQC0MR+WWslRPsdL5mw0GW68u0M9hTJDjH21YD6O4+J7uBRLJMEUCb3RSqoYDYnEaQBCqQqeEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JmIVdnG7; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/GMqHnjnHxwq/7lwQXakwhcEJX49JOp6B6re8myyb40=;
	b=JmIVdnG7fC3qMyBzh3GZB+bKbsDFaWowzoHNu/lXceQ97dK00v+KgwSPIREdGBvnSPRNjz
	ZrbHkKtmuCPQjL8Xd4GqClaSfR9fx6SD8V/7nS1DxEFtfqNSwS8CvrdY8b3RcaxZjHTFlq
	f0mwsZr6O35JveNiYwaPQVQ+vMb2H8k=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 00/10] selftests/bpf: Retire bpf_tcp_helpers.h
Date: Thu,  9 May 2024 10:50:16 -0700
Message-ID: <20240509175026.3423614-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The earlier commit 8e6d9ae2e09f ("selftests/bpf: Use bpf_tracing.h instead of bpf_tcp_helpers.h")
removed the bpf_tcp_helpers.h usages from the non networking tests.

This patch set is a continuation of this effort to retire
the bpf_tcp_helpers.h from the networking tests (mostly tcp-cc related).

The main usage of the bpf_tcp_helpers.h is the partial kernel
socket definitions (e.g. sock, tcp_sock). New fields are kept adding
back to those partial socket definitions while everything is available
in the vmlinux.h. The recent bpf_cc_cubic.c test tried to extend
bpf_tcp_helpers.c but eventually used the vmlinux.h instead. To avoid
this unnecessary detour for new tests and have one consistent way
of using the kernel sockets, this patch set retires the bpf_tcp_helpers.h
usages and consolidates the tests to use vmlinux.h instead.

Martin KaFai Lau (10):
  selftests/bpf: Remove bpf_tracing_net.h usages from two networking
    tests
  selftests/bpf: Replace the bpf_tcp_helpers.h usage with
    bpf_tracing_net.h in some obvious tests
  selftests/bpf: Add a few tcp helper functions and macros to
    bpf_tracing_net.h
  selftests/bpf: Reuse the tcp_sk() from the bpf_tracing_net.h
  selftests/bpf: Sanitize the SEC and inline usages in the bpf-tcp-cc
    tests
  selftests/bpf: Rename tcp-cc private struct in bpf_cubic and bpf_dctcp
  selftests/bpf: Use bpf_tracing_net.h in bpf_cubic
  selftests/bpf: Use bpf_tracing_net.h in bpf_dctcp
  selftests/bpf: Remove bpf_tcp_helpers.h usage in other misc bpf tcp-cc
    tests
  selftests/bpf: Retire bpf_tcp_helpers.h

 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 241 ------------------
 .../selftests/bpf/progs/bpf_cc_cubic.c        |  39 ++-
 tools/testing/selftests/bpf/progs/bpf_cubic.c |  73 +++---
 tools/testing/selftests/bpf/progs/bpf_dctcp.c |  62 +++--
 .../selftests/bpf/progs/bpf_dctcp_release.c   |  10 +-
 .../selftests/bpf/progs/bpf_tcp_nogpl.c       |   8 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |  42 +++
 .../selftests/bpf/progs/connect4_prog.c       |  21 +-
 .../testing/selftests/bpf/progs/fib_lookup.c  |   2 +-
 .../testing/selftests/bpf/progs/mptcp_sock.c  |   4 +-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  16 +-
 .../bpf/progs/tcp_ca_incompl_cong_ops.c       |  12 +-
 .../selftests/bpf/progs/tcp_ca_kfunc.c        |  22 +-
 .../bpf/progs/tcp_ca_unsupp_cong_op.c         |   2 +-
 .../selftests/bpf/progs/tcp_ca_update.c       |  18 +-
 .../bpf/progs/tcp_ca_write_sk_pacing.c        |  20 +-
 .../bpf/progs/test_btf_skc_cls_ingress.c      |  16 +-
 .../selftests/bpf/progs/test_lwt_redirect.c   |   2 +-
 .../selftests/bpf/progs/test_sock_fields.c    |   6 +-
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |  13 +-
 20 files changed, 190 insertions(+), 439 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/bpf_tcp_helpers.h

-- 
2.43.0


