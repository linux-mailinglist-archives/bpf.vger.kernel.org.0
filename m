Return-Path: <bpf+bounces-1461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0B5716E22
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 21:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5BB281317
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33FD31EE6;
	Tue, 30 May 2023 19:51:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A12D26D
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 19:51:57 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76CE194
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 12:51:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565de4b5be5so40191177b3.1
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 12:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685476311; x=1688068311;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RDD35lsg2/o+SoPydRLcBgQs2LsXTDuz7+rbUg418zY=;
        b=4t9NfHN6CUwtLjkSj0ZG7AOC+NHELVgYzKbmTElhGBANXgAnSAFENj4tlSH5VwtRp0
         ZjjxaWPW7tteXHFblu3U5YqVRj/9VrXLXy6Sd5sfNbfsYXcHm0+0s6eSgofF8juv9deV
         i18gSGwI9Vgt1h3lJGu8IPo10fNMbniAAtuYCnsIv68rFCIPYgCF6VZQaDdsWqJuEM+K
         GWeaqx4eYiSfL6b1ybcAKEj++MCnjj+tSpvmEVRffNMsIgmVWDVmF/CqbpxZSgWDNHip
         AX+fsGVj+0Dlww6s+q+o5mAS0nGCzDdCRdWQtyIbz0Dfx6Ibx9lWpQxKiiXCYHJq0MDB
         7M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685476311; x=1688068311;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDD35lsg2/o+SoPydRLcBgQs2LsXTDuz7+rbUg418zY=;
        b=JApQUhIRfGoaC5e0e0zud/6D/c6nFtbiBGjMrZxi2I4FfTtNklg0WyidvfE5kb5Nbi
         PA42QtAPUJlF1DyEJ5ZHkeXBrv52VYLvnyQIdXBPc9hLmRQQuRkDiAttcYVOwk7hTzOS
         BYTL4RwCJZrndZKif0fj8Vx14aqVi0xQY6JTei+j85tNlJ0Dg4NLgHobptciEeGnWS/p
         GG236Xraw0SBlH8HWEJhUPvoU7PYjqcOy040ShRo5MQFFP2eOQNipTyfF9WJ/TtYGnc7
         EB3rrOLdWe8145YFaUH8XWdHISRdB9vR5KPKGo0rQUUYHppRg8kDU0EQ4QFradcj2k0O
         dYAA==
X-Gm-Message-State: AC+VfDwSqHuOc6X7DLgNeP8Tbt/fkGvCCWTSYDFXK0mVPXf72ufA4e9r
	1tysklTcyQ7F9JLVr5cvKNbafI1YCYw4wA==
X-Google-Smtp-Source: ACHHUZ4Ge7bsXRqSs1UN6wPuO/6yjC8Pq7PxBSVigRSoHQuVaGIWCL4HArLGFe/sJfPMCzabLROX/c3ccyhxeQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b625:0:b0:54f:b56a:cd0f with SMTP id
 u37-20020a81b625000000b0054fb56acd0fmr2054031ywh.3.1685476311305; Tue, 30 May
 2023 12:51:51 -0700 (PDT)
Date: Tue, 30 May 2023 19:51:49 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530195149.68145-1-edumazet@google.com>
Subject: [PATCH net] bpf, sockmap: avoid potential NULL dereference in sk_psock_verdict_data_ready()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot found sk_psock(sk) could return NULL when called
from sk_psock_verdict_data_ready().

Just make sure to handle this case.

[1]
general protection fault, probably for non-canonical address 0xdffffc000000005c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000002e0-0x00000000000002e7]
CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.4.0-rc3-syzkaller-00588-g4781e965e655 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/16/2023
RIP: 0010:sk_psock_verdict_data_ready+0x19f/0x3c0 net/core/skmsg.c:1213
Code: 4c 89 e6 e8 63 70 5e f9 4d 85 e4 75 75 e8 19 74 5e f9 48 8d bb e0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 07 02 00 00 48 89 ef ff 93 e0 02 00 00 e8 29 fd
RSP: 0018:ffffc90000147688 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: 000000000000005c RSI: ffffffff8825ceb7 RDI: 00000000000002e0
RBP: ffff888076518c40 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000008000 R15: ffff888076518c40
FS: 0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f901375bab0 CR3: 000000004bf26000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
tcp_data_ready+0x10a/0x520 net/ipv4/tcp_input.c:5006
tcp_data_queue+0x25d3/0x4c50 net/ipv4/tcp_input.c:5080
tcp_rcv_established+0x829/0x1f90 net/ipv4/tcp_input.c:6019
tcp_v4_do_rcv+0x65a/0x9c0 net/ipv4/tcp_ipv4.c:1726
tcp_v4_rcv+0x2cbf/0x3340 net/ipv4/tcp_ipv4.c:2148
ip_protocol_deliver_rcu+0x9f/0x480 net/ipv4/ip_input.c:205
ip_local_deliver_finish+0x2ec/0x520 net/ipv4/ip_input.c:233
NF_HOOK include/linux/netfilter.h:303 [inline]
NF_HOOK include/linux/netfilter.h:297 [inline]
ip_local_deliver+0x1ae/0x200 net/ipv4/ip_input.c:254
dst_input include/net/dst.h:468 [inline]
ip_rcv_finish+0x1cf/0x2f0 net/ipv4/ip_input.c:449
NF_HOOK include/linux/netfilter.h:303 [inline]
NF_HOOK include/linux/netfilter.h:297 [inline]
ip_rcv+0xae/0xd0 net/ipv4/ip_input.c:569
__netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5491
__netif_receive_skb+0x1f/0x1c0 net/core/dev.c:5605
process_backlog+0x101/0x670 net/core/dev.c:5933
__napi_poll+0xb7/0x6f0 net/core/dev.c:6499
napi_poll net/core/dev.c:6566 [inline]
net_rx_action+0x8a9/0xcb0 net/core/dev.c:6699
__do_softirq+0x1d4/0x905 kernel/softirq.c:571
run_ksoftirqd kernel/softirq.c:939 [inline]
run_ksoftirqd+0x31/0x60 kernel/softirq.c:931
smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
kthread+0x344/0x440 kernel/kthread.c:379
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
</TASK>

Fixes: 6df7f764cd3c ("bpf, sockmap: Wake up polling after data copy")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a9060e1f0e4378fa47cfd375b4729b5b0a9f54ec..a29508e1ff3568583263b9307f7b1a0e814ba76d 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1210,7 +1210,8 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 		rcu_read_lock();
 		psock = sk_psock(sk);
-		psock->saved_data_ready(sk);
+		if (psock)
+			psock->saved_data_ready(sk);
 		rcu_read_unlock();
 	}
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog


