Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38693D656C
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 19:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbhGZQfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbhGZQdr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:47 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D3C0AEA30;
        Mon, 26 Jul 2021 09:53:34 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d10so9562114ils.7;
        Mon, 26 Jul 2021 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9ryiCkUgiSl2y82BR3LUjfc3g6RVnyFMM1g6GIuuJs=;
        b=VIH7KOhg0aHjqK24UyEgTM15YWWVIbFAWQD0WPlrFkC3Kwk7kcGaYDUK5W52SHsgkN
         l1OivmwajFDkmlu1o0NRbfNTPGwUK9qCEIbI514sY259lQ21AC3hoRZn1TNfjeL0TyQq
         6P3O8onIgTwaieUJlc7klH/6sscUyCyI0zixHxnQqEcDJmY4rOi7+kyfNJBsfyDHrTtb
         SF0hnfb40soC2Ho7Ts+Ju8pP+6J8AZwe0suzAuI8Tnof2IxqKqjY6BcpiXgwj+aormkY
         BsyrL9XY4YIHt6IZWmndvhJzx9aN5wq8tb6feCP2zCJ4T2SqJLMQzHbV+1fyeKb6wjjO
         r/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9ryiCkUgiSl2y82BR3LUjfc3g6RVnyFMM1g6GIuuJs=;
        b=G8imrdXnj9//ZuXXVYl2XBtPWJS2CZyQ93aSAtF/8HnJzDcRHaNYzXc7hkQwgKd0kd
         ycI5PBnSU9kXEOhLMpEjgUwE4RgjOCoJV4aKMDFJ2nH5+d7OHbgTmT7Vgkok/irZ2+PJ
         1ig3D+frkldCAVED/E1hEwlZeeQP93/8H3+rGH9vNbfymUgKZ6QZYP/qqBl12qbV28zK
         0q0ApIOtchdnSvr+8MMP+UDN6ndNrjNeMZGRuoXIGc1OmmEmiPSKg65FnYNBIHp8znqK
         83zJAlRXkzJVw5BJCYNJihb29P35cF46J6b60JuXSIwlC8/JkDTq9xvoYC/i5neOr7jG
         Eh+A==
X-Gm-Message-State: AOAM530Kg4XIJXxj/GKCfAK2VkGtN9GV3/FVYKEdFTJKmexg7Hm3sqRf
        pMOzCM+5fPU89GAkwTvnVyk=
X-Google-Smtp-Source: ABdhPJzN0DVyX7fz5EjiWcFj/wtY/6AAkUwUl/umhrvV5k1YbxiDBS8NgQjFtZrjIQtCuRisXPLXtQ==
X-Received: by 2002:a92:dcc2:: with SMTP id b2mr13794595ilr.84.1627318413944;
        Mon, 26 Jul 2021 09:53:33 -0700 (PDT)
Received: from john-XPS-13-9370.lan ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id r198sm254483ior.7.2021.07.26.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 09:53:33 -0700 (PDT)
From:   John Fastabend <john.fastabend@gmail.com>
To:     jakub@cloudflare.com, daniel@iogearbox.net,
        xiyou.wangcong@gmail.com, alexei.starovoitov@gmail.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        john.fastabend@gmail.com
Subject: [PATCH bpf v2 2/3] bpf, sockmap: on cleanup we additionally need to remove cached skb
Date:   Mon, 26 Jul 2021 09:53:03 -0700
Message-Id: <20210726165304.1443836-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726165304.1443836-1-john.fastabend@gmail.com>
References: <20210726165304.1443836-1-john.fastabend@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Its possible if a socket is closed and the receive thread is under memory
pressure it may have cached a skb. We need to ensure these skbs are
free'd along with the normal ingress_skb queue.

Before 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()") tear
down and backlog processing both had sock_lock for the common case of
socket close or unhash. So it was not possible to have both running in
parrallel so all we would need is the kfree in those kernels.

But, latest kernels include the commit 799aa7f98d5e and this requires a
bit more work. Without the ingress_lock guarding reading/writing the
state->skb case its possible the tear down could run before the state
update causing it to leak memory or worse when the backlog reads the state
it could potentially run interleaved with the tear down and we might end up
free'ing the state->skb from tear down side but already have the reference
from backlog side. To resolve such races we wrap accesses in ingress_lock
on both sides serializing tear down and backlog case. In both cases this
only happens after an EAGAIN error case so having an extra lock in place
is likely fine. The normal path will skip the locks.

Note, we check state->skb before grabbing lock. This works because
we can only enqueue with the mutex we hold already. Avoiding a race
on adding state->skb after the check. And if tear down path is running
that is also fine if the tear down path then removes state->skb we
will simply set skb=NULL and the subsequent goto is skipped. This
slight complication avoids locking in normal case.

With this fix we no longer see this warning splat from tcp side on
socket close when we hit the above case with redirect to ingress self.

[224913.935822] WARNING: CPU: 3 PID: 32100 at net/core/stream.c:208 sk_stream_kill_queues+0x212/0x220
[224913.935841] Modules linked in: fuse overlay bpf_preload x86_pkg_temp_thermal intel_uncore wmi_bmof squashfs sch_fq_codel efivarfs ip_tables x_tables uas xhci_pci ixgbe mdio xfrm_algo xhci_hcd wmi
[224913.935897] CPU: 3 PID: 32100 Comm: fgs-bench Tainted: G          I       5.14.0-rc1alu+ #181
[224913.935908] Hardware name: Dell Inc. Precision 5820 Tower/002KVM, BIOS 1.9.2 01/24/2019
[224913.935914] RIP: 0010:sk_stream_kill_queues+0x212/0x220
[224913.935923] Code: 8b 83 20 02 00 00 85 c0 75 20 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 89 df e8 2b 11 fe ff eb c3 0f 0b e9 7c ff ff ff 0f 0b eb ce <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 90 0f 1f 44 00 00 41 57 41
[224913.935932] RSP: 0018:ffff88816271fd38 EFLAGS: 00010206
[224913.935941] RAX: 0000000000000ae8 RBX: ffff88815acd5240 RCX: dffffc0000000000
[224913.935948] RDX: 0000000000000003 RSI: 0000000000000ae8 RDI: ffff88815acd5460
[224913.935954] RBP: ffff88815acd5460 R08: ffffffff955c0ae8 R09: fffffbfff2e6f543
[224913.935961] R10: ffffffff9737aa17 R11: fffffbfff2e6f542 R12: ffff88815acd5390
[224913.935967] R13: ffff88815acd5480 R14: ffffffff98d0c080 R15: ffffffff96267500
[224913.935974] FS:  00007f86e6bd1700(0000) GS:ffff888451cc0000(0000) knlGS:0000000000000000
[224913.935981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[224913.935988] CR2: 000000c0008eb000 CR3: 00000001020e0005 CR4: 00000000003706e0
[224913.935994] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[224913.936000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[224913.936007] Call Trace:
[224913.936016]  inet_csk_destroy_sock+0xba/0x1f0
[224913.936033]  __tcp_close+0x620/0x790
[224913.936047]  tcp_close+0x20/0x80
[224913.936056]  inet_release+0x8f/0xf0
[224913.936070]  __sock_release+0x72/0x120
[224913.936083]  sock_close+0x14/0x20

Fixes: a136678c0bdbb ("bpf: sk_msg, zap ingress queue on psock down")
Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/skmsg.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 28115ef742e8..036cdb33a94a 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -590,23 +590,42 @@ static void sock_drop(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static void sk_psock_skb_state(struct sk_psock *psock,
+			       struct sk_psock_work_state *state,
+			       struct sk_buff *skb,
+			       int len, int off)
+{
+	spin_lock_bh(&psock->ingress_lock);
+	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
+		state->skb = skb;
+		state->len = len;
+		state->off = off;
+	} else {
+		sock_drop(psock->sk, skb);
+	}
+	spin_unlock_bh(&psock->ingress_lock);
+}
+
 static void sk_psock_backlog(struct work_struct *work)
 {
 	struct sk_psock *psock = container_of(work, struct sk_psock, work);
 	struct sk_psock_work_state *state = &psock->work_state;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	bool ingress;
 	u32 len, off;
 	int ret;
 
 	mutex_lock(&psock->work_mutex);
-	if (state->skb) {
+	if (unlikely(state->skb)) {
+		spin_lock_bh(&psock->ingress_lock);
 		skb = state->skb;
 		len = state->len;
 		off = state->off;
 		state->skb = NULL;
-		goto start;
+		spin_unlock_bh(&psock->ingress_lock);
 	}
+	if (skb)
+		goto start;
 
 	while ((skb = skb_dequeue(&psock->ingress_skb))) {
 		len = skb->len;
@@ -621,9 +640,8 @@ static void sk_psock_backlog(struct work_struct *work)
 							  len, ingress);
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
-					state->skb = skb;
-					state->len = len;
-					state->off = off;
+					sk_psock_skb_state(psock, state, skb,
+							   len, off);
 					goto end;
 				}
 				/* Hard errors break pipe and stop xmit. */
@@ -722,6 +740,11 @@ static void __sk_psock_zap_ingress(struct sk_psock *psock)
 		skb_bpf_redirect_clear(skb);
 		sock_drop(psock->sk, skb);
 	}
+	kfree_skb(psock->work_state.skb);
+	/* We null the skb here to ensure that calls to sk_psock_backlog
+	 * do not pick up the free'd skb.
+	 */
+	psock->work_state.skb = NULL;
 	__sk_psock_purge_ingress_msg(psock);
 }
 
-- 
2.25.1

