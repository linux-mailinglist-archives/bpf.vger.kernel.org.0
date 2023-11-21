Return-Path: <bpf+bounces-15516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684AE7F2BA3
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 12:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232172827C3
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8686048CE4;
	Tue, 21 Nov 2023 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6114CB;
	Tue, 21 Nov 2023 03:22:34 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltAAXHQnxklxl4VxoAA--.27190S5;
	Tue, 21 Nov 2023 19:22:31 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf-next v2 3/3] tcp_diag: Add the data length in skmsg to rx_queue
Date: Tue, 21 Nov 2023 19:22:05 +0800
Message-Id: <1700565725-2706-4-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
References: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
X-CM-TRANSID:SyJltAAXHQnxklxl4VxoAA--.27190S5
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4fAr13AF1fCr47Jr17Awb_yoW3Kwb_uw
	n7ZrW8W3srXr1xta1xZFZxJFyYk34IyFn5W3WS9a4qy34DJF9xuw4rXF98Ars7CanxCrZ5
	ur1DJryUG34rujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6x8ErcxFaVAv
	8VW8GwAv7VCY1x0262k0Y48FwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4kMxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUwL0eDUUUU
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


