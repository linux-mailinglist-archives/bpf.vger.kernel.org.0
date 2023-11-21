Return-Path: <bpf+bounces-15515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BD47F2BA1
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 12:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B74B21B4C
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6D548CC1;
	Tue, 21 Nov 2023 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99A0298;
	Tue, 21 Nov 2023 03:22:33 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltAAXHQnxklxl4VxoAA--.27190S4;
	Tue, 21 Nov 2023 19:22:30 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH bpf-next v2 2/3] tcp: Add the data length in skmsg to SIOCINQ ioctl
Date: Tue, 21 Nov 2023 19:22:04 +0800
Message-Id: <1700565725-2706-3-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
References: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
X-CM-TRANSID:SyJltAAXHQnxklxl4VxoAA--.27190S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XF18KrW3Xr4xGFW5ZF48Crg_yoWfKFgE93
	9rGF48G3yxWr1IvanFyFZ5t3WS9w18ur1fWF43Ca47ta4UJry5Crs3J3s8Crsrua9FkrZ5
	WF93G3y3urya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

SIOCINQ ioctl returns the number unread bytes of the receive
queue but does not include the ingress_msg queue. With the
sk_msg redirect, an application may get a value 0 if it calls
SIOCINQ ioctl before recv() to determine the readable size.

Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 net/ipv4/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3d3a24f79573..04da0684c397 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -267,6 +267,7 @@
 #include <linux/errqueue.h>
 #include <linux/static_key.h>
 #include <linux/btf.h>
+#include <linux/skmsg.h>
 
 #include <net/icmp.h>
 #include <net/inet_common.h>
@@ -613,7 +614,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		slow = lock_sock_fast(sk);
-		answ = tcp_inq(sk);
+		answ = tcp_inq(sk) + sk_msg_queue_len(sk);
 		unlock_sock_fast(sk, slow);
 		break;
 	case SIOCATMARK:
-- 
2.38.1


