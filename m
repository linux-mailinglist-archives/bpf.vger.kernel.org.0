Return-Path: <bpf+bounces-19477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2180F82C5BA
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C577E285CC3
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728A115ADF;
	Fri, 12 Jan 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UrFlJG4s"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CE15AC6;
	Fri, 12 Jan 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705086344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eeM+W0MqXOvEr81BMO58ddgEnx0OhGCR6cL344ka0ik=;
	b=UrFlJG4sw7ZDTWBEG7TpKJu6D+lKcunUgBQTcTeH2i1iu5+iUH6sMjTzB1DDkXqj6F1bNy
	7T32AYwcxTrqLvQVeAy4Utb3D8UCT49tSjgZXwJZMo+jVxtSXlGfZIUZE73tJV8CBKee/7
	bHQhKGPftHWHQwLs0Fko8M+TKlhaLdk=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 bpf 0/3] bpf: Fix backward progress bug in bpf_iter_udp
Date: Fri, 12 Jan 2024 11:05:27 -0800
Message-Id: <20240112190530.3751661-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch set fixes an issue in bpf_iter_udp that makes backward
progress and prevents the user space process from finishing. There is
a test at the end to reproduce the bug.

Please see individual patches for details.

v3:
- Fixed the iter_fd check and local_port check in the
  patch 3 selftest. (Yonghong)
- Moved jhash2 to test_jhash.h in the patch 3. (Yonghong)
- Added explanation in the bucket selection in the patch 3. (Yonghong)

v2:
- Added patch 1 to fix another bug that goes back to
  the previous bucket
- Simplify the fix in patch 2 to always reset iter->offset to 0
- Add a test case to close all udp_sk in a bucket while
  in the middle of the iteration.

Martin KaFai Lau (3):
  bpf: iter_udp: Retry with a larger batch size without going back to
    the previous bucket
  bpf: Avoid iter->offset making backward progress in bpf_iter_udp
  selftests/bpf: Test udp and tcp iter batching

 net/ipv4/udp.c                                |  22 ++-
 .../bpf/prog_tests/sock_iter_batch.c          | 135 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   3 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  91 ++++++++++++
 .../testing/selftests/bpf/progs/test_jhash.h  |  31 ++++
 5 files changed, 270 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_iter_batch.c

-- 
2.34.1


