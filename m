Return-Path: <bpf+bounces-67953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02156B5093A
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 01:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F74F1C64101
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 23:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91C287503;
	Tue,  9 Sep 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5SupcS2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5DB287262
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460387; cv=none; b=eXljuZWChnnf9yK5i66yjZaCnB9l/lZgzhmGFeUnXURUfC36j0BRDeU0n7Ye9wJaRfC3cNtPKAAMQy18lob5auX65D+IUMB+Gh/sR9stE6Z+ExnYsFTLJtbzOtvA+xIFBTiFfX8xLCN1M+oft6yHQI1eYI62OIwpJgmWHZI98s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460387; c=relaxed/simple;
	bh=NHJ8RRwetdKTcL55P+rUw3OmPXKeTdDGjZwj7586590=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qbn5vsNoEEnGOFkGuzY5CsOLHHsumH9OQ+PyL9h38iLHVYUqLAcrqtWv1/86c2VBvIcfYxBfu+9RgYjv1s2DxiAPf1KHNl5SeOTVH9QKbTvB4tzLKQBybe137piqQDKt+Cw6uaXJEziTffcJj/9DZEbePujpo97DYIIi1wlp4vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5SupcS2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329ee69e7deso5959335a91.3
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 16:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757460385; x=1758065185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gqM9tS7SH/HFXAH0Y7hf/mL7j8GtwTRhXAe2rnNCA/0=;
        b=s5SupcS27A20VddlpK6yO8uotaqBuIVezP0TGhpKBFjWov9LPDLa212VLe4R5xFOu8
         a23WBbFvmSLNwCSHt/aI9Ev0Ui6l/UJ9i+7HNVNgAPpkb/LMWPaE8lJ41MJ0uI9pIV3O
         jqFJ7miqGPJQphZ5HnsGfcnwd/6+8+Cki+7RCol6onwq1+u+ifaTcTTVLpXgsEvuAkc3
         cgtt6i6N0OWt1e2QAj3QVAIO02bTUpIDUDgjgst92PSvtYSqOt/HfssvGRcoEQBwYwmx
         HOf9jE1EdUsL1C+KVQJ0oD52KXHwJUvJVk62z17EqgsI1xVCEX/cpSOPoz8sjXA6XYD4
         rlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460385; x=1758065185;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gqM9tS7SH/HFXAH0Y7hf/mL7j8GtwTRhXAe2rnNCA/0=;
        b=Qtgvw97LrY/Up4weyTz5697oTqSCJWaqYD55CpdfJNngjmG7A8WVgndBwIQWbyO+g7
         orILAc1yOqXMcmbSKt7qD48cBq+2kS4mNq+xdqB89Ynmmdfj6539UJ3RtEl4fC775p4r
         nk5dhMuE8NhuSdn/kVo65uBQPQgePLNNMTKAGQIT3laAAOqq8vGGLNj+WGonHLQNNJAM
         30PL2ti5Acds+xkhTz8isIznl5ZnHe2gW0a80EBNWhDNlJWYzWa/vOPV1EPByLZAoHcQ
         im91AaubAPoXt6vZF9kVekbQl83Q74xAn2BO9qDUbbqH9fKGdXnPuOnCvFD73+mggzoK
         kU4g==
X-Forwarded-Encrypted: i=1; AJvYcCUtJoxmzD3yLqcv3iMSMfo85/mF/y2dmvyG8nDx0gsS/QNZVLN2z8uYwJzDG6kxeJj427Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgRr5VEKSDvecrPzOF8Njuv8U97ZkOn4qBs7iNp3w56PHKS2J5
	JGPWe5IkOc1YB9FywkwfACj+zDZaJuVheAH6jFa04uxaAvrG+tS4BTT4Dv2moVgDbltL+HkSkEO
	XpBMsqg==
X-Google-Smtp-Source: AGHT+IEaoTEOgTd4mwg31AzmSxuw9oMDl1ayzr2vwiIYeT8L5aqfPymFo/NQoXocCkSzC8TL/8KuG4G6t04=
X-Received: from pjbsh18.prod.google.com ([2002:a17:90b:5252:b0:327:50fa:eff9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f41:b0:32b:51ab:5d3e
 with SMTP id 98e67ed59e1d1-32d43f0460dmr16771546a91.6.1757460385553; Tue, 09
 Sep 2025 16:26:25 -0700 (PDT)
Date: Tue,  9 Sep 2025 23:26:12 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909232623.4151337-1-kuniyu@google.com>
Subject: [PATCH v1 bpf] tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict()
 fails to allocate psock->cork.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported the splat below. [0]

The repro does the following:

  1. Load a sk_msg prog that calls bpf_msg_cork_bytes(msg, cork_bytes)
  2. Attach the prog to a SOCKMAP
  3. Add a socket to the SOCKMAP
  4. Activate fault injection
  5. Send data less than cork_bytes

At 5., the data is carried over to the next sendmsg() as it is
smaller than the cork_bytes specified by bpf_msg_cork_bytes().

Then, tcp_bpf_send_verdict() tries to allocate psock->cork to hold
the data, but this fails silently due to fault injection + __GFP_NOWARN.

If the allocation fails, we need to revert the sk->sk_forward_alloc
change done by sk_msg_alloc().

Let's call sk_msg_free() when tcp_bpf_send_verdict fails to allocate
psock->cork.

[0]:
WARNING: net/ipv4/af_inet.c:156 at inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156, CPU#1: syz-executor/5983
Modules linked in:
CPU: 1 UID: 0 PID: 5983 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156
Code: 0f 0b 90 e9 62 fe ff ff e8 7a db b5 f7 90 0f 0b 90 e9 95 fe ff ff e8 6c db b5 f7 90 0f 0b 90 e9 bb fe ff ff e8 5e db b5 f7 90 <0f> 0b 90 e9 e1 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 9f fc
RSP: 0018:ffffc90000a08b48 EFLAGS: 00010246
RAX: ffffffff8a09d0b2 RBX: dffffc0000000000 RCX: ffff888024a23c80
RDX: 0000000000000100 RSI: 0000000000000fff RDI: 0000000000000000
RBP: 0000000000000fff R08: ffff88807e07c627 R09: 1ffff1100fc0f8c4
R10: dffffc0000000000 R11: ffffed100fc0f8c5 R12: ffff88807e07c380
R13: dffffc0000000000 R14: ffff88807e07c60c R15: 1ffff1100fc0f872
FS:  00005555604c4500(0000) GS:ffff888125af1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555604df5c8 CR3: 0000000032b06000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __sk_destruct+0x86/0x660 net/core/sock.c:2339
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Reported-by: syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68c0b6b5.050a0220.3c6139.0013.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_bpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ba581785adb4..ee6a371e65a4 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -408,8 +408,10 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		if (!psock->cork) {
 			psock->cork = kzalloc(sizeof(*psock->cork),
 					      GFP_ATOMIC | __GFP_NOWARN);
-			if (!psock->cork)
+			if (!psock->cork) {
+				sk_msg_free(sk, msg);
 				return -ENOMEM;
+			}
 		}
 		memcpy(psock->cork, msg, sizeof(*msg));
 		return 0;
-- 
2.51.0.384.g4c02a37b29-goog


