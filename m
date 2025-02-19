Return-Path: <bpf+bounces-51904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB77A3B0CE
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 06:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D925E1749A0
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730D1ACEC2;
	Wed, 19 Feb 2025 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uNQkxR05"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E314A85
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 05:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739942467; cv=none; b=dx68VgLfSxedfe1f8Rgwqnmee12gU71+W40zXBKImP/Ip3TcLdi9IbFyp/inmN9/E3qAwiHF+6dQzSAioigwUcOQ5GkEDBvg2Cy2p9Z8QlQo2UEqAeF2TTD0KqMq2AqcU2Pk0j/pkaCAZYrmrHqFVST/iQ54zirdYIXhlaPKw7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739942467; c=relaxed/simple;
	bh=nUYwlzScIIbN2ZMhtJfMG/Bc+5js96aLGGdW5oKg72s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXgynCa7r+qREbdZ+53Hcil0AjKOFYSvvXMz84SgUKFT3lLvz8m/PRNDSWSylnDeEm2wdcZ+SfYoWnMOL5FVbJxeoiEXzEOPO1xOExUUETrwAgugiWHKfqHPksZN7Rqg/m6zgFH6Fw5goCiSoVh6NP8AUG3mpfC4jL3FZ3+6A5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uNQkxR05; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739942460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XEsN6voX4JYgMmdCGL9ffI2Bq36Dpz6UUUJG1SIrl7M=;
	b=uNQkxR05ewq2ft28WW+sv9hb9ng2EeqvNkYjzC5B56wk7fiI+2xSsdcOo5HnrCtcMid+Aa
	PQPtfds6VNcpRH0EMtkfiTARrpQOQOGmCQFAJtqXMojgUj0h7nRsYt12NrqI5x6IkljU5K
	HSHy8azdWjWE9Fx95xnUyo0TRbFa6Eo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v2 0/2] bpf: fix ktls panic with sockmap and add tests
Date: Wed, 19 Feb 2025 13:20:13 +0800
Message-ID: <20250219052015.274405-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We can reproduce the issue using the existing test program:
'./test_sockmap --ktls'
Or use the selftest I provided, which will cause a panic:

------------[ cut here ]------------
kernel BUG at lib/iov_iter.c:629!

PKRU: 55555554
Call Trace:
 <TASK>
 ? die+0x36/0x90
 ? do_trap+0xdd/0x100
 ? iov_iter_revert+0x178/0x180
 ? iov_iter_revert+0x178/0x180
 ? do_error_trap+0x7d/0x110
 ? iov_iter_revert+0x178/0x180
 ? exc_invalid_op+0x50/0x70
 ? iov_iter_revert+0x178/0x180
 ? asm_exc_invalid_op+0x1a/0x20
 ? iov_iter_revert+0x178/0x180
 ? iov_iter_revert+0x5c/0x180
 tls_sw_sendmsg_locked.isra.0+0x794/0x840
 tls_sw_sendmsg+0x52/0x80
 ? inet_sendmsg+0x1f/0x70
 __sys_sendto+0x1cd/0x200
 ? find_held_lock+0x2b/0x80
 ? syscall_trace_enter+0x140/0x270
 ? __lock_release.isra.0+0x5e/0x170
 ? find_held_lock+0x2b/0x80
 ? syscall_trace_enter+0x140/0x270
 ? lockdep_hardirqs_on_prepare+0xda/0x190
 ? ktime_get_coarse_real_ts64+0xc2/0xd0
 __x64_sys_sendto+0x24/0x30
 do_syscall_64+0x90/0x170

1. It looks like the issue started occurring after bpf being introduced to
ktls and later the addition of assertions to iov_iter has caused a panic.
If my fix tag is incorrect, please assist me in correcting the fix tag.

2. I make minimal changes for now, it's enough to make ktls work
correctly.

---
v1->v2: Added more content to the commit message
https://lore.kernel.org/all/20250123171552.57345-1-mrpre@163.com/#r
---

Jiayuan Chen (2):
  bpf: fix ktls panic with sockmap
  selftests/bpf: add ktls selftest

 net/tls/tls_sw.c                              |   8 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 174 +++++++++++++++++-
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  26 +++
 3 files changed, 205 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c

-- 
2.47.1


