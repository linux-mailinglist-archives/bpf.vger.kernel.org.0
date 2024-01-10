Return-Path: <bpf+bounces-19331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3553829FF3
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 18:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65451C2179D
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E32E4D11C;
	Wed, 10 Jan 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c+KrLhbJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E004D581
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704909492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MLz/Gih8LvMZxPcgfcC+hU3IbPOVujYuPjGI0FcrFpQ=;
	b=c+KrLhbJXLn+bJESmhcWXUDnVkMtnsjFDJyELOr7L8VR44sS9ePtzGUhSqgZh5Z+eMNJii
	NekExpt70HqmVFsB52gChIReZv65TTi9Hn2tNM4qKYI0hUKPOa2YE1ywn2PUF6j/awTIhu
	CGoEAilhrgn78WCtwFLI8T5r144jqZI=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 0/3] bpf: Fix backward progress bug in bpf_iter_udp
Date: Wed, 10 Jan 2024 09:57:40 -0800
Message-Id: <20240110175743.2220907-1-martin.lau@linux.dev>
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
 .../bpf/prog_tests/sock_iter_batch.c          | 130 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   3 +
 .../selftests/bpf/progs/sock_iter_batch.c     | 121 ++++++++++++++++
 4 files changed, 264 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_iter_batch.c

-- 
2.34.1


