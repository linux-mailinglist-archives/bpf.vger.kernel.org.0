Return-Path: <bpf+bounces-50263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3B0A246E3
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 04:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CD418895B1
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 03:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB30A35964;
	Sat,  1 Feb 2025 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s6E30kwP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD24690;
	Sat,  1 Feb 2025 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738378925; cv=none; b=kXw6P28mNL2Ummq+P2j75k2tESl7lHXDCgNVvaSogIHzZxzUlH+0oUpTPzfdHOcjWLpALH7ihFxasSkvHChGcWHPysek1Y104v2kS7pSW4zjiw0Pza5MoG2gDwKWFpr1anqFI7ow2XUxIRUYvspLXHrC3XG6iiQfFGaKItnXNv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738378925; c=relaxed/simple;
	bh=GcBvLu+Yh7nDxLMdbKvIl0x9CUhZVRNQwpGJruBZoq8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DyzG+MkjEM1Ct/VCvkdG8oq/spU6wXC/qIm90tW42uXCaJ9nTvO5Py3HnXGR8OMl7QALi2zJ3TMj/BfesNOoc1jvcC2pLidX8Lwos5Zbn+FUsb7BIUxwuRaIA4gtH0jdpP08TNY6+uZRGvVW94A6QMfB1aQxDGuOwVqytSHW1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s6E30kwP; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738378921; x=1769914921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=16rlmblW6sJxcHDoIVe5BPg6m7NVFFDy7fQu8znfxmA=;
  b=s6E30kwPXpnoxwbugND9LgKXbfZjfSjSPKsGjROBb4NmxNLdxPrwjjfG
   vp2/il+hWbA6D1y1QXoSwCiZcfPGA6isx4WW0WA45jLCjYLxn6pqVsnrJ
   9LNEOpXbJ+2GMvzVtORs+x8q4fBwF3E8iwNJUISqw2JrOvx2IjSKZawYe
   I=;
X-IronPort-AV: E=Sophos;i="6.13,250,1732579200"; 
   d="scan'208";a="458766247"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 03:01:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:21966]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id 082cdb39-5de9-41e3-b9f9-ee515c65321b; Sat, 1 Feb 2025 03:01:56 +0000 (UTC)
X-Farcaster-Flow-ID: 082cdb39-5de9-41e3-b9f9-ee515c65321b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 1 Feb 2025 03:01:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 1 Feb 2025 03:01:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>
CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Yan Zhai
	<yan@cloudflare.com>
Subject: [PATCH v2 bpf] net: Add rx_skb of kfree_skb to raw_tp_null_args[].
Date: Fri, 31 Jan 2025 19:01:42 -0800
Message-ID: <20250201030142.62703-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Yan Zhai reported a BPF prog could trigger a null-ptr-deref [0]
in trace_kfree_skb if the prog does not check if rx_sk is NULL.

Commit c53795d48ee8 ("net: add rx_sk to trace_kfree_skb") added
rx_sk to trace_kfree_skb, but rx_sk is optional and could be NULL.

Let's add kfree_skb to raw_tp_null_args[] to let the BPF verifier
validate such a prog and prevent the issue.

Now we fail to load such a prog:

  libbpf: prog 'drop': -- BEGIN PROG LOAD LOG --
  0: R1=ctx() R10=fp0
  ; int BPF_PROG(drop, struct sk_buff *skb, void *location, @ kfree_skb_sk_null.bpf.c:21
  0: (79) r3 = *(u64 *)(r1 +24)
  func 'kfree_skb' arg3 has btf_id 5253 type STRUCT 'sock'
  1: R1=ctx() R3_w=trusted_ptr_or_null_sock(id=1)
  ; bpf_printk("sk: %d, %d\n", sk, sk->__sk_common.skc_family); @ kfree_skb_sk_null.bpf.c:24
  1: (69) r4 = *(u16 *)(r3 +16)
  R3 invalid mem access 'trusted_ptr_or_null_'
  processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --

Note this fix requires commit 838a10bd2ebf ("bpf: Augment raw_tp
arguments with PTR_MAYBE_NULL").

[0]:
BUG: kernel NULL pointer dereference, address: 0000000000000010
 PF: supervisor read access in kernel mode
 PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
PREEMPT SMP
CPU: 6 UID: 0 PID: 348 Comm: sshd Not tainted 6.12.11 #206
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:bpf_prog_5e21a6db8fcff1aa_drop+0x10/0x2d
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 48 8b 57 18 <48> 0f b7 4a 10 48 bf 0c 4f e2 c1 ad 90 ff ff be 0c 00 00 00 e8 0f
RSP: 0018:ffffa86640b53da8 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffffa866402d1000 RCX: 0000000000000002
RDX: 0000000000000000 RSI: ffffa866402d1048 RDI: ffffa86640b53dc8
RBP: ffffa86640b53da8 R08: 0000000000000000 R09: 9c908cd09b9c8c91
R10: ffff90adc056b540 R11: 0000000000000002 R12: 0000000000000000
R13: ffffa86640b53e88 R14: 0000000000000800 R15: fffffffffffffffe
FS:  00007f2a27c2b480(0000) GS:ffff90b0efd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 0000000100e69004 CR4: 00000000001726f0
Call Trace:
 <TASK>
 ? __die+0x1f/0x60
 ? page_fault_oops+0x148/0x420
 ? search_bpf_extables+0x5b/0x70
 ? fixup_exception+0x27/0x2c0
 ? exc_page_fault+0x75/0x170
 ? asm_exc_page_fault+0x22/0x30
 ? bpf_prog_5e21a6db8fcff1aa_drop+0x10/0x2d
 bpf_trace_run4+0x68/0xd0
 ? unix_stream_connect+0x1f4/0x6f0
 sk_skb_reason_drop+0x90/0x120
 unix_stream_connect+0x1f4/0x6f0
 __sys_connect+0x7f/0xb0
 __x64_sys_connect+0x14/0x20
 do_syscall_64+0x47/0xc30
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f2a27f296a0
Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d 41 ff 0c 00 00 74 17 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 54
RSP: 002b:00007ffe29274f58 EFLAGS: 00000202 ORIG_RAX: 000000000000002a

Fixes: c53795d48ee8 ("net: add rx_sk to trace_kfree_skb")
Reported-by: Yan Zhai <yan@cloudflare.com>
Closes: https://lore.kernel.org/netdev/Z50zebTRzI962e6X@debian.debian/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Add kfree_skb to raw_tp_null_args[] instead of annotating
    rx_skb with __nullable

v1: https://lore.kernel.org/bpf/20250201001425.42377-1-kuniyu@amazon.com/
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9de6acddd479..c3223e0db2f5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6507,6 +6507,8 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	/* rxrpc */
 	{ "rxrpc_recvdata", 0x1 },
 	{ "rxrpc_resend", 0x10 },
+	/* skb */
+	{"kfree_skb", 0x1000},
 	/* sunrpc */
 	{ "xs_stream_read_data", 0x1 },
 	/* ... from xprt_cong_event event class */
-- 
2.39.5 (Apple Git-154)


