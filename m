Return-Path: <bpf+bounces-78638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B600D165D0
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E713032FEF
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 02:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086912DECA3;
	Tue, 13 Jan 2026 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H2OmdoeL"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC7277C9D
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272711; cv=none; b=SUIWbjXHldVkTps8RvEeEXEeELliKBKuWAdBu/GfMot8NB4jBypCH+bDRNOh9zQtdppBAuS39S4sN52+SH4+on3kvnGXfk4dXShPJysLMEL3dZEInmbiG1U+p/RouaPJhYl4Jf8uB+acCW3sUsTDg6F75+niGJVr1VNPiKtKh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272711; c=relaxed/simple;
	bh=zdmc/4b/IdcJRYG41ZjUCKsHTmEBzw04JdTDUL4m8jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tz5NqoCfgisRMXh3MY8JkkY9YjZyiZpwzl4PWv+I+teV8U+xdS3DLWq+/w0KiOFGSoDo60yFQjW2+j1EUpDp7cdfz31p2g/+FB3M6fCDrUpS97+7NP0U3ihryqz4XqrDGku6bAlhjcQOyc4AvQt9u20vG4iNnyNPjPyshjhY4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H2OmdoeL; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768272706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IAvJQU4T0fm2xve7nVWfrsGO5CzxQEsmvhbPRJX4b7Y=;
	b=H2OmdoeLtGLspxKUjXr0KEYglU25fVHfQn81EkIsKm0eZ+v2xCwge18liNobo+vuOzFo+H
	XtIpnn07qcO9MPIT/Ka4U7pZrRr2P6ZMdBmsuuvzOqFJ2DmsayRKSBQ130T0FyPPOI679d
	3d5x+4e27yTiLDcOP4agQCbGyhCY1LY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v7 0/3] bpf: Fix FIONREAD and copied_seq issues
Date: Tue, 13 Jan 2026 10:50:48 +0800
Message-ID: <20260113025121.197535-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

syzkaller reported a bug [1] where a socket using sockmap, after being
unloaded, exposed incorrect copied_seq calculation. The selftest I
provided can be used to reproduce the issue reported by syzkaller.

TCP recvmsg seq # bug 2: copied E92C873, seq E68D125, rcvnxt E7CEB7C, fl 40
WARNING: CPU: 1 PID: 5997 at net/ipv4/tcp.c:2724 tcp_recvmsg_locked+0xb2f/0x2910 net/ipv4/tcp.c:2724
Call Trace:
 <TASK>
 receive_fallback_to_copy net/ipv4/tcp.c:1968 [inline]
 tcp_zerocopy_receive+0x131a/0x2120 net/ipv4/tcp.c:2200
 do_tcp_getsockopt+0xe28/0x26c0 net/ipv4/tcp.c:4713
 tcp_getsockopt+0xdf/0x100 net/ipv4/tcp.c:4812
 do_sock_getsockopt+0x34d/0x440 net/socket.c:2421
 __sys_getsockopt+0x12f/0x260 net/socket.c:2450
 __do_sys_getsockopt net/socket.c:2457 [inline]
 __se_sys_getsockopt net/socket.c:2454 [inline]
 __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2454
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

A sockmap socket maintains its own receive queue (ingress_msg) which may
contain data from either its own protocol stack or forwarded from other
sockets.

                                                     FD1:read()
                                                     --  FD1->copied_seq++
                                                         |  [read data]
                                                         |
                                [enqueue data]           v
                  [sockmap]     -> ingress to self ->  ingress_msg queue
FD1 native stack  ------>                                 ^
-- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
                                       |                  |
                                       |             ingress to FD1
                                       v                  ^
                                      ...                 |  [sockmap]
                                                     FD2 native stack

The issue occurs when reading from ingress_msg: we update tp->copied_seq
by default, but if the data comes from other sockets (not the socket's
own protocol stack), tcp->rcv_nxt remains unchanged. Later, when
converting back to a native socket, reads may fail as copied_seq could
be significantly larger than rcv_nxt.

Additionally, FIONREAD calculation based on copied_seq and rcv_nxt is
insufficient for sockmap sockets, requiring separate field tracking.

[1] https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983

---
v5 -> v7: Some modifications suggested by Jakub Sitnicki, and added Reviewed-by tag.
https://lore.kernel.org/bpf/20260106051458.279151-1-jiayuan.chen@linux.dev/

v1 -> v5: Use skmsg.sk instead of extending BPF_F_XXX macro and fix CI
          failure reported by CI
v1: https://lore.kernel.org/bpf/20251117110736.293040-1-jiayuan.chen@linux.dev/

Jiayuan Chen (3):
  bpf, sockmap: Fix incorrect copied_seq calculation
  bpf, sockmap: Fix FIONREAD for sockmap
  bpf, selftest: Add tests for FIONREAD and copied_seq

 include/linux/skmsg.h                         |  70 ++++-
 net/core/skmsg.c                              |  31 +-
 net/ipv4/tcp_bpf.c                            |  37 ++-
 net/ipv4/udp_bpf.c                            |  23 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 277 +++++++++++++++++-
 .../bpf/progs/test_sockmap_pass_prog.c        |  14 +
 6 files changed, 435 insertions(+), 17 deletions(-)

-- 
2.43.0


