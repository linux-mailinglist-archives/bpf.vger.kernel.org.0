Return-Path: <bpf+bounces-6313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8906767D9D
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 11:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F33E2811C0
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E202125B8;
	Sat, 29 Jul 2023 09:19:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E45C2E3;
	Sat, 29 Jul 2023 09:19:07 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2721D271D;
	Sat, 29 Jul 2023 02:19:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RCf8656D4z4f3prT;
	Sat, 29 Jul 2023 17:19:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCHLaGE2cRkf9BOPA--.1627S6;
	Sat, 29 Jul 2023 17:19:03 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	houtao1@huawei.com
Subject: [PATCH bpf 2/2] bpf, cpumap: Handle skb as well when clean up ptr_ring
Date: Sat, 29 Jul 2023 17:51:07 +0800
Message-Id: <20230729095107.1722450-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230729095107.1722450-1-houtao@huaweicloud.com>
References: <20230729095107.1722450-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHLaGE2cRkf9BOPA--.1627S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xWr4UKw4DXry7uFy5twb_yoW8KrW7pr
	4fKryUJr48X3ZFvay8Kan3try3Jan2g3WfJ3yFk34rZF15X39rWaykKayktFy5GrZ5Cr15
	Jrs0qF95KayDJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1o5l5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

The following warning was reported when running xdp_redirect_cpu with
both skb-mode and stress-mode enabled:

  ------------[ cut here ]------------
  Incorrect XDP memory type (-2128176192) usage
  WARNING: CPU: 7 PID: 1442 at net/core/xdp.c:405
  Modules linked in:
  CPU: 7 PID: 1442 Comm: kworker/7:0 Tainted: G  6.5.0-rc2+ #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  Workqueue: events __cpu_map_entry_free
  RIP: 0010:__xdp_return+0x1e4/0x4a0
  ......
  Call Trace:
   <TASK>
   ? show_regs+0x65/0x70
   ? __warn+0xa5/0x240
   ? __xdp_return+0x1e4/0x4a0
   ......
   xdp_return_frame+0x4d/0x150
   __cpu_map_entry_free+0xf9/0x230
   process_one_work+0x6b0/0xb80
   worker_thread+0x96/0x720
   kthread+0x1a5/0x1f0
   ret_from_fork+0x3a/0x70
   ret_from_fork_asm+0x1b/0x30
   </TASK>

The reason for the warning is twofold. One is due to the kthread
cpu_map_kthread_run() is stopped prematurely. Another one is
__cpu_map_ring_cleanup() doesn't handle skb mode and treats skbs in
ptr_ring as XDP frames.

Prematurely-stopped kthread will be fixed by the preceding patch and
ptr_ring will be empty when __cpu_map_ring_cleanup() is called. But
as the comments in __cpu_map_ring_cleanup() said, handling and freeing
skbs in ptr_ring as well to "catch any broken behaviour gracefully".

Fixes: 11941f8a8536 ("bpf: cpumap: Implement generic cpumap")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/cpumap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 08351e0863e5..ef28c64f1eb1 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -129,11 +129,17 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 	 * invoked cpu_map_kthread_stop(). Catch any broken behaviour
 	 * gracefully and warn once.
 	 */
-	struct xdp_frame *xdpf;
+	void *ptr;
 
-	while ((xdpf = ptr_ring_consume(ring)))
-		if (WARN_ON_ONCE(xdpf))
-			xdp_return_frame(xdpf);
+	while ((ptr = ptr_ring_consume(ring))) {
+		WARN_ON_ONCE(1);
+		if (unlikely(__ptr_test_bit(0, &ptr))) {
+			__ptr_clear_bit(0, &ptr);
+			kfree_skb(ptr);
+			continue;
+		}
+		xdp_return_frame(ptr);
+	}
 }
 
 static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
-- 
2.29.2


