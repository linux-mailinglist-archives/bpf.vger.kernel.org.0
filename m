Return-Path: <bpf+bounces-9493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44268798805
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286FE281AF1
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCDE63AB;
	Fri,  8 Sep 2023 13:39:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F65254
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:39:39 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A919BC
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 06:39:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rhxzk0VS2z4f3knY
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 21:39:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHVqkPJPtkRmSwCg--.44307S5;
	Fri, 08 Sep 2023 21:39:33 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf 1/4] bpf: Adjust size_index according to the value of KMALLOC_MIN_SIZE
Date: Fri,  8 Sep 2023 21:39:20 +0800
Message-Id: <20230908133923.2675053-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230908133923.2675053-1-houtao@huaweicloud.com>
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHVqkPJPtkRmSwCg--.44307S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr17Cr18Jr4DKFW8AF4rAFb_yoW7Xr1kpF
	y3Jr18Gr48ZF4xJr47CF4rJFWrGw1Fk3W7JrWfXw1UZF15Gr1DJr1ktryruFyqqrWrZ3W7
	JF4qqw48Kr1UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-TmDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

The following warning was reported when running "./test_progs -a
link_api -a linked_list" on a RISC-V QEMU VM:

  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342 bpf_mem_refill
  Modules linked in: bpf_testmod(OE)
  CPU: 3 PID: 261 Comm: test_progs- ... 6.5.0-rc5-01743-gdcb152bb8328 #2
  Hardware name: riscv-virtio,qemu (DT)
  epc : bpf_mem_refill+0x1fc/0x206
   ra : irq_work_single+0x68/0x70
  epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp : ff2000000001be20
   gp : ffffffff82d26138 tp : ff6000008477a800 t0 : 0000000000046600
   t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 : ff2000000001be70
   s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 : ff600003fef4b000
   a2 : 000000000000003f a3 : ffffffff80008250 a4 : 0000000000000060
   a5 : 0000000000000080 a6 : 0000000000000000 a7 : 0000000000735049
   s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 : 0000000000001000
   s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 : ffffffff82d6bd30
   s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10: 000000000000ffff
   s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 : 0000000000000000
   t5 : ff6000008fd28278 t6 : 0000000000040000
  [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
  [<ffffffff8015fe84>] irq_work_single+0x68/0x70
  [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
  [<ffffffff8015fefa>] irq_work_run+0x38/0x66
  [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
  [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
  [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
  [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
  [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
  [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
  [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
  [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
  [<ffffffff812b6904>] do_irq+0x66/0x98
  ---[ end trace 0000000000000000 ]---

The warning is due to WARN_ON_ONCE(tgt->unit_size != c->unit_size) in
free_bulk(). The direct reason is that a object is allocated and
freed by bpf_mem_caches with different unit_size.

The root cause is that KMALLOC_MIN_SIZE is 64 and there is no 96-bytes
slab cache in the specific VM. When linked_list test allocates a
72-bytes object through bpf_obj_new(), bpf_global_ma will allocate it
from a bpf_mem_cache with 96-bytes unit_size, but this bpf_mem_cache is
backed by 128-bytes slab cache. When the object is freed, bpf_mem_free()
uses ksize() to choose the corresponding bpf_mem_cache. Because the
object is allocated from 128-bytes slab cache, ksize() returns 128,
bpf_mem_free() chooses a 128-bytes bpf_mem_cache to free the object and
triggers the warning.

A similar warning will also be reported when using CONFIG_SLAB instead
of CONFIG_SLUB in a x86-64 kernel. Because CONFIG_SLUB defines
KMALLOC_MIN_SIZE as 8 but CONFIG_SLAB defines KMALLOC_MIN_SIZE as 32.

An alternative fix is to use kmalloc_size_round() in bpf_mem_alloc() to
choose a bpf_mem_cache which has the same unit_size with the backing
slab cache, but it may introduce performance degradation, so fix the
warning by adjusting the indexes in size_index according to the value of
KMALLOC_MIN_SIZE just like setup_kmalloc_cache_index_table() does.

Fixes: 822fb26bdb55 ("bpf: Add a hint to allocated objects.")
Reported-by: Björn Töpel <bjorn@kernel.org>
Closes: https://lore.kernel.org/bpf/87jztjmmy4.fsf@all.your.base.are.belong.to.us
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9c49ae53deaf..98d9e96fba3c 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -916,3 +916,41 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
+
+/* Most of the logic is taken from setup_kmalloc_cache_index_table() */
+static __init int bpf_mem_cache_adjust_size(void)
+{
+	unsigned int size, index;
+
+	/* Normally KMALLOC_MIN_SIZE is 8-bytes, but it can be
+	 * up-to 256-bytes.
+	 */
+	size = KMALLOC_MIN_SIZE;
+	if (size <= 192)
+		index = size_index[(size - 1) / 8];
+	else
+		index = fls(size - 1) - 1;
+	for (size = 8; size < KMALLOC_MIN_SIZE && size <= 192; size += 8)
+		size_index[(size - 1) / 8] = index;
+
+	/* The minimal alignment is 64-bytes, so disable 96-bytes cache and
+	 * use 128-bytes cache instead.
+	 */
+	if (KMALLOC_MIN_SIZE >= 64) {
+		index = size_index[(128 - 1) / 8];
+		for (size = 64 + 8; size <= 96; size += 8)
+			size_index[(size - 1) / 8] = index;
+	}
+
+	/* The minimal alignment is 128-bytes, so disable 192-bytes cache and
+	 * use 256-bytes cache instead.
+	 */
+	if (KMALLOC_MIN_SIZE >= 128) {
+		index = fls(256 - 1) - 1;
+		for (size = 128 + 8; size <= 192; size += 8)
+			size_index[(size - 1) / 8] = index;
+	}
+
+	return 0;
+}
+subsys_initcall(bpf_mem_cache_adjust_size);
-- 
2.29.2


