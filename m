Return-Path: <bpf+bounces-6444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B13769773
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 15:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B6F1C20BEF
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0158182DF;
	Mon, 31 Jul 2023 13:24:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B64429;
	Mon, 31 Jul 2023 13:24:33 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C791706;
	Mon, 31 Jul 2023 06:24:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RDzV44Y58z4f3nxF;
	Mon, 31 Jul 2023 21:24:12 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgBnEqb+tcdk_ML5PA--.12666S2;
	Mon, 31 Jul 2023 21:24:15 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [PATCH bpf] bpf, sockmap: Fix NULL deref in sk_psock_backlog
Date: Mon, 31 Jul 2023 09:45:36 -0400
Message-Id: <20230731134536.4058181-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnEqb+tcdk_ML5PA--.12666S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1ftF1DXw1furWrAr13urg_yoWruFy3pF
	15Gw4UCF48JryUXa1fJF4DJr15C3WkAF1UArW7Aw1xZF15Cr15Gr98JF4j9r15trsru3W7
	Jr4DGF4UK3W7JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

sk_psock_backlog triggers a NULL dereference:

 BUG: kernel NULL pointer dereference, address: 000000000000000e
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 0 PID: 70 Comm: kworker/0:3 Not tainted 6.5.0-rc2-00585-gb11bbbe4c66e #26
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-p4
 Workqueue: events sk_psock_backlog
 RIP: 0010:0xffffffffc0205254
 Code: 00 00 48 89 94 24 a0 00 00 00 41 5f 41 5e 41 5d 41 5c 5d 5b 41 5b 41 5a 41 59 41 50
 RSP: 0018:ffffc90000acbcb8 EFLAGS: 00010246
 RAX: ffffffff81c5ee10 RBX: ffff888018260000 RCX: 0000000000000001
 RDX: 0000000000000003 RSI: ffffc90000acbd58 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000080100005
 R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000003
 R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000003
 FS:  0000000000000000(0000) GS:ffff88803ea00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000000e CR3: 000000000b0de002 CR4: 0000000000170ef0
 Call Trace:
  <TASK>
  ? __die+0x24/0x70
  ? page_fault_oops+0x15d/0x480
  ? fixup_exception+0x26/0x330
  ? exc_page_fault+0x72/0x1d0
  ? asm_exc_page_fault+0x26/0x30
  ? __pfx_inet_sendmsg+0x10/0x10
  ? 0xffffffffc0205254
  ? inet_sendmsg+0x20/0x80
  ? sock_sendmsg+0x8f/0xa0
  ? __skb_send_sock+0x315/0x360
  ? __pfx_sendmsg_unlocked+0x10/0x10
  ? sk_psock_backlog+0xb4/0x300
  ? process_one_work+0x292/0x560
  ? worker_thread+0x53/0x3e0
  ? __pfx_worker_thread+0x10/0x10
  ? kthread+0x102/0x130
  ? __pfx_kthread+0x10/0x10
  ? ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ? ret_from_fork_asm+0x1b/0x30
  </TASK>

The bug flow is as follows:

thread 1                                   thread 2

sk_psock_backlog                           sock_close
  sk_psock_handle_skb                        __sock_release
    __skb_send_sock                            inet_release
      sendmsg_unlocked                           tcp_close
        sock_sendmsg                               lock_sock
                                                     __tcp_close
                                                   release_sock
                                                 sock->sk = NULL // (1)
          inet_sendmsg
            sk = sock->sk // (2)
            inet_send_prepare
              inet_sk(sk)->inet_num // (3)

sock->sk is set to NULL by thread 2 at time (1), then fetched by
thread 1 at time (2), and used by thread 1 to access memory at
time (3), resulting in NULL pointer dereference.

To fix it, add lock_sock back on the egress path for sk_psock_handle_skb.

Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 net/core/skmsg.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 7c2764beeb04..8b758c51aa0d 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -609,15 +609,42 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	return err;
 }
 
+static int sk_psock_handle_ingress_skb(struct sk_psock *psock,
+				       struct sk_buff *skb,
+				       u32 off, u32 len)
+{
+	if (sock_flag(psock->sk, SOCK_DEAD))
+		return -EIO;
+	return sk_psock_skb_ingress(psock, skb, off, len);
+}
+
+static int sk_psock_handle_egress_skb(struct sk_psock *psock,
+				      struct sk_buff *skb,
+				      u32 off, u32 len)
+{
+	int ret;
+
+	lock_sock(psock->sk);
+
+	if (sock_flag(psock->sk, SOCK_DEAD))
+		ret = -EIO;
+	else if (!sock_writeable(psock->sk))
+		ret = -EAGAIN;
+	else
+		ret = skb_send_sock_locked(psock->sk, skb, off, len);
+
+	release_sock(psock->sk);
+
+	return ret;
+}
+
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
-	if (!ingress) {
-		if (!sock_writeable(psock->sk))
-			return -EAGAIN;
-		return skb_send_sock(psock->sk, skb, off, len);
-	}
-	return sk_psock_skb_ingress(psock, skb, off, len);
+	if (ingress)
+		return sk_psock_handle_ingress_skb(psock, skb, off, len);
+	else
+		return sk_psock_handle_egress_skb(psock, skb, off, len);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -660,10 +687,7 @@ static void sk_psock_backlog(struct work_struct *work)
 		ingress = skb_bpf_ingress(skb);
 		skb_bpf_redirect_clear(skb);
 		do {
-			ret = -EIO;
-			if (!sock_flag(psock->sk, SOCK_DEAD))
-				ret = sk_psock_handle_skb(psock, skb, off,
-							  len, ingress);
+			ret = sk_psock_handle_skb(psock, skb, off, len, ingress);
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
 					sk_psock_skb_state(psock, state, len, off);
-- 
2.30.2


