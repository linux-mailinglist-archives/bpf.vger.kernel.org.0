Return-Path: <bpf+bounces-15054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175B87EAF64
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 12:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328191C208A5
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638FE3D993;
	Tue, 14 Nov 2023 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F25224E1;
	Tue, 14 Nov 2023 11:42:24 +0000 (UTC)
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7965FAB;
	Tue, 14 Nov 2023 03:42:22 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltADX3QkZXVNlXr9cAA--.24900S5;
	Tue, 14 Nov 2023 19:42:19 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf-next 3/3] tcp_diag: Add the data length in skmsg to rx_queue
Date: Tue, 14 Nov 2023 19:42:00 +0800
Message-Id: <1699962120-3390-4-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1699962120-3390-1-git-send-email-yangpc@wangsu.com>
References: <1699962120-3390-1-git-send-email-yangpc@wangsu.com>
X-CM-TRANSID:SyJltADX3QkZXVNlXr9cAA--.24900S5
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4fAr13AF1fCr47Jr17Awb_yoW3Kwb_uw
	n7ZrW8W3srXr1xta1xZFZxJFyYk34IyFn5W3WS9a4qy34DJF9xuw4rXF98Ars7CanxCrZ5
	ur1DJryUG34rujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6x8ErcxFaVAv
	8VW8GwAv7VCY1x0262k0Y48FwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gw4l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
	Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	jesjbUUUUU=
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

In order to help us track the data length in ingress_msg
when using sk_msg redirect.

Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 net/ipv4/tcp_diag.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 01b50fa79189..b22382820a4b 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -11,6 +11,7 @@
 #include <linux/inet_diag.h>
 
 #include <linux/tcp.h>
+#include <linux/skmsg.h>
 
 #include <net/netlink.h>
 #include <net/tcp.h>
@@ -28,6 +29,7 @@ static void tcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 
 		r->idiag_rqueue = max_t(int, READ_ONCE(tp->rcv_nxt) -
 					     READ_ONCE(tp->copied_seq), 0);
+		r->idiag_rqueue += sk_msg_queue_len(sk);
 		r->idiag_wqueue = READ_ONCE(tp->write_seq) - tp->snd_una;
 	}
 	if (info)
-- 
2.38.1


