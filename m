Return-Path: <bpf+bounces-50254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE6A245E3
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 01:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC873A86A1
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 00:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F852C9A;
	Sat,  1 Feb 2025 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kQ75sP5e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38BA934;
	Sat,  1 Feb 2025 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738368884; cv=none; b=Oxe2YF6BLIBAn/1i5poqJfkZ8cqXpRfuxQr/wkn1ixGPZAmdrRHTtMi8+RvIfZ007ZCI3TYoOimUsb3wUnh525PwAGqotSL6hxMbEIb1h4jMgy/HB465L2uPOVKg9l+eR0cidUVhZ8pwLX9puxGHOaQAd44lDBwaz1rtX5hUidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738368884; c=relaxed/simple;
	bh=fwnPzvWrESrUPkCcA2My4tpFwSxEPdl2EJtuTfU8I5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G9fIO4MBfwV8PZuzcfUxUWIkODPnt+SD5ubJXIMsyrSd5zYbj6g7gCesNAdz1vcFLOONg29rzT79LDhREafxynsl+EefDe1Y4IltIHXEHu++CwBx3o4XsdCNxYeunucadoF2beH2k32mlf1/U+DZbggPPaUP3GDZg5iei1zswSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kQ75sP5e; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738368883; x=1769904883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e5rvXHN34xl/8zzTp4uIrYXRbwAvVp16cloemZaHGrk=;
  b=kQ75sP5ekgE0soKNBSMRfteiYw3LHsSBkT3yxh0p9xERuq5XpAU8UXFa
   vSFH9IC/zLjUy+modM2iX90yZ42z9itRDjz/IuNirt2UrbDfWutYeAh+D
   jY3OuT2jTebu4+AVLaJZ4h064AC5qCDSO2H0qQy8DuW18iKt17odxWhmj
   c=;
X-IronPort-AV: E=Sophos;i="6.13,250,1732579200"; 
   d="scan'208";a="18826589"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 00:14:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:49824]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.120:2525] with esmtp (Farcaster)
 id 4d3b26dc-c124-4b2f-874e-b369b79ea4c8; Sat, 1 Feb 2025 00:14:40 +0000 (UTC)
X-Farcaster-Flow-ID: 4d3b26dc-c124-4b2f-874e-b369b79ea4c8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 1 Feb 2025 00:14:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 1 Feb 2025 00:14:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, "Yan
 Zhai" <yan@cloudflare.com>
Subject: [PATCH v1 bpf] net: Annotate rx_sk with __nullable for trace_kfree_skb.
Date: Fri, 31 Jan 2025 16:14:25 -0800
Message-ID: <20250201001425.42377-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Yan Zhai reported a BPF prog could trigger a null-ptr-deref [0]
in trace_kfree_skb if the prog does not check if rx_sk is NULL.

Commit c53795d48ee8 ("net: add rx_sk to trace_kfree_skb") added
rx_sk to trace_kfree_skb, but rx_sk is optional and could be NULL.

Let's add __nullable suffix to rx_sk to let the BPF verifier
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

Note this fix requires commit 8aeaed21befc ("bpf: Support
__nullable argument suffix for tp_btf").

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
 include/trace/events/skb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index b877133cd93a..8bf0e61b8549 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -24,9 +24,9 @@ DEFINE_DROP_REASON(FN, FN)
 TRACE_EVENT(kfree_skb,
 
 	TP_PROTO(struct sk_buff *skb, void *location,
-		 enum skb_drop_reason reason, struct sock *rx_sk),
+		 enum skb_drop_reason reason, struct sock *rx_sk__nullable),
 
-	TP_ARGS(skb, location, reason, rx_sk),
+	TP_ARGS(skb, location, reason, rx_sk__nullable),
 
 	TP_STRUCT__entry(
 		__field(void *,		skbaddr)
@@ -39,7 +39,7 @@ TRACE_EVENT(kfree_skb,
 	TP_fast_assign(
 		__entry->skbaddr = skb;
 		__entry->location = location;
-		__entry->rx_sk = rx_sk;
+		__entry->rx_sk = rx_sk__nullable;
 		__entry->protocol = ntohs(skb->protocol);
 		__entry->reason = reason;
 	),
-- 
2.39.5 (Apple Git-154)


