Return-Path: <bpf+bounces-44335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716FF9C179A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 09:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EC91F23F6B
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8CC1DC195;
	Fri,  8 Nov 2024 08:15:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B951634;
	Fri,  8 Nov 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053738; cv=none; b=LLlcW6Z9il6IrO1rp5h32kM5bFmQmXy1KsMFFjIVPjXc77NyVessZm7d7rrV8qKNIUpiBvsfef1lMINhPnCGagmHRhG8ZdZJ0l+CTOK9xQIKu+FdeAKAjEr65uw3pBBmPwd2UeDJWKk0HINuQNpYto3DOOQKi8zv2vbl3CUUZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053738; c=relaxed/simple;
	bh=ynKLFiLi5aENLAbB8QE2NE+5vMQnsrp8Jxeoydti8YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ACgfnR0c+chr4ux+3UIlrhGUAZnYKqXXcs4RUbpcFhPkCvyYBSG475wiWh+r/N4XgQorqBTi2gf7PkKoMOIcgn28bh24m+RmvV/NpQ4p9jfJObH21DCUKF5oIz6MM6g+q66hmEepgPOmUQdtLgifUdKrgkeXfdWVr3A9BXOuOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XlBZV42QZz4f3l8K;
	Fri,  8 Nov 2024 16:15:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 821781A07BB;
	Fri,  8 Nov 2024 16:15:27 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgAXDK6eyC1nOEOhBA--.5950S3;
	Fri, 08 Nov 2024 16:15:27 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix release of struct_ops map
Date: Fri,  8 Nov 2024 16:26:32 +0800
Message-Id: <20241108082633.2338543-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108082633.2338543-1-xukuohai@huaweicloud.com>
References: <20241108082633.2338543-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXDK6eyC1nOEOhBA--.5950S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry8CF4rJr15Gw1DKrWrGrg_yoW7uF48pF
	WUKr1UCr48Xr47Wr18JF47Ar4akr4F9a4UXrn7JryrtF15Ww15JF1UtF4UZr9Iqr4DAr1a
	qr9Fqw10yrWUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxU4cTmUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The test in the follow-up patch triggers the following kernel panic:

 Oops: int3: 0000 [#1] PREEMPT SMP PTI
 CPU: 0 UID: 0 PID: 465 Comm: test_progs Tainted: G           OE      6.12.0-rc4-gd1d187515
 Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-pr4
 RIP: 0010:0xffffffffc0015041
 Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc ccc
 RSP: 0018:ffffc9000187fd20 EFLAGS: 00000246
 RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffffff82c54639 RDI: 0000000000000000
 RBP: ffffc9000187fd48 R08: 0000000000000001 R09: 0000000000000000
 R10: 0000000000000001 R11: 000000004cba6383 R12: 0000000000000000
 R13: 0000000000000002 R14: ffff88810438b7a0 R15: ffffffff8369d7a0
 FS:  00007f05178006c0(0000) GS:ffff888236e00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f0508c94000 CR3: 0000000100d16003 CR4: 0000000000170ef0
 Call Trace:
  <TASK>
  ? show_regs+0x68/0x80
  ? die+0x3b/0x90
  ? exc_int3+0xca/0xe0
  ? asm_exc_int3+0x3e/0x50
  run_struct_ops+0x58/0xb0 [bpf_testmod]
  param_attr_store+0xa2/0x100
  module_attr_store+0x25/0x40
  sysfs_kf_write+0x50/0x70
  kernfs_fop_write_iter+0x146/0x1f0
  vfs_write+0x27e/0x530
  ksys_write+0x75/0x100
  __x64_sys_write+0x1d/0x30
  x64_sys_call+0x1d30/0x1f30
  do_syscall_64+0x68/0x140
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f051831727f
 Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 d5 f8 ff 48 8b 54 24 18 48 8b 74 24 108
 RSP: 002b:00007f05177ffdf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 00007f05178006c0 RCX: 00007f051831727f
 RDX: 0000000000000002 RSI: 00007f05177ffe30 RDI: 0000000000000004
 RBP: 00007f05177ffe90 R08: 0000000000000000 R09: 000000000000000b
 R10: 0000000000000000 R11: 0000000000000293 R12: ffffffffffffff30
 R13: 0000000000000002 R14: 00007ffd926bfd50 R15: 00007f0517000000
  </TASK>

It's because the sleepable prog is still running when the struct_ops
map is released.

To fix it, follow the approach used in bpf_tramp_image_put. First,
before release struct_ops map, wait a rcu_tasks_trace gp for sleepable
progs to finish. Then, wait a rcu_tasks gp for normal progs and the
rest trampoline insns to finish.

Additionally, switch to call_rcu to remove the synchronous waiting,
as suggested by Alexei and Martin.

Fixes: b671c2067a04 ("bpf: Retire the struct_ops map kvalue->refcnt.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/bpf_struct_ops.c | 37 +++++++++++++++++++------------------
 kernel/bpf/syscall.c        |  7 ++++++-
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index fda3dd2ee984..dd5f9bf12791 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -865,24 +865,6 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	 */
 	if (btf_is_module(st_map->btf))
 		module_put(st_map->st_ops_desc->st_ops->owner);
-
-	/* The struct_ops's function may switch to another struct_ops.
-	 *
-	 * For example, bpf_tcp_cc_x->init() may switch to
-	 * another tcp_cc_y by calling
-	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
-	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
-	 * and its refcount may reach 0 which then free its
-	 * trampoline image while tcp_cc_x is still running.
-	 *
-	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
-	 * to finish. bpf-tcp-cc prog is non sleepable.
-	 * A rcu_tasks gp is to wait for the last few insn
-	 * in the tramopline image to finish before releasing
-	 * the trampoline image.
-	 */
-	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
-
 	__bpf_struct_ops_map_free(map);
 }
 
@@ -974,6 +956,25 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	mutex_init(&st_map->lock);
 	bpf_map_init_from_attr(map, attr);
 
+	/* The struct_ops's function may switch to another struct_ops.
+	 *
+	 * For example, bpf_tcp_cc_x->init() may switch to
+	 * another tcp_cc_y by calling
+	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
+	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
+	 * and its refcount may reach 0 which then free its
+	 * trampoline image while tcp_cc_x is still running.
+	 *
+	 * Since struct_ops prog can be sleepable, a rcu_tasks_trace gp
+	 * is to wait for sleepable progs in the map to finish. Then a
+	 * rcu_tasks gp is to wait for the normal progs and the last few
+	 * insns in the tramopline image to finish before releasing the
+	 * trampoline image.
+	 *
+	 * Also see the comment in function bpf_tramp_image_put.
+	 */
+	WRITE_ONCE(map->free_after_mult_rcu_gp, true);
+
 	return map;
 
 errout_free:
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8254b2973157..ae927f087f04 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -886,7 +886,12 @@ static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
 
 static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
 {
-	if (rcu_trace_implies_rcu_gp())
+	struct bpf_map *map = container_of(rcu, struct bpf_map, rcu);
+
+	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS)
+		/* See comment in the end of bpf_struct_ops_map_alloc */
+		call_rcu_tasks(rcu, bpf_map_free_rcu_gp);
+	else if (rcu_trace_implies_rcu_gp())
 		bpf_map_free_rcu_gp(rcu);
 	else
 		call_rcu(rcu, bpf_map_free_rcu_gp);
-- 
2.39.5


