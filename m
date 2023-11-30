Return-Path: <bpf+bounces-16263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E01C7FF10D
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D0FB210C0
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF11487A2;
	Thu, 30 Nov 2023 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1835B9
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:00:19 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SgyWL5GXkz4f3lx1
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 22:00:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B66381A04BD
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 22:00:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhBslWhlJ5NxCQ--.49902S5;
	Thu, 30 Nov 2023 22:00:16 +0800 (CST)
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
	"Paul E . McKenney" <paulmck@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf v4 1/7] bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
Date: Thu, 30 Nov 2023 22:01:14 +0800
Message-Id: <20231130140120.1736235-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231130140120.1736235-1-houtao@huaweicloud.com>
References: <20231130140120.1736235-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhBslWhlJ5NxCQ--.49902S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWUXFWUXr45tFy3Kw1fCrg_yoW5ZF4xpF
	y09a4Fkr1jqFsrZ3yYva92yry5Ka90ganrJws7Ww4YvF4UWFn7XryxJFnIvF98KrWUAr48
	Z3W2qwnrA348Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

These three bpf_map_{lookup,update,delete}_elem() helpers are also
available for sleepable bpf program, so add the corresponding lock
assertion for sleepable bpf program, otherwise the following warning
will be reported when a sleepable bpf program manipulates bpf map under
interpreter mode (aka bpf_jit_enable=0):

  WARNING: CPU: 3 PID: 4985 at kernel/bpf/helpers.c:40 ......
  CPU: 3 PID: 4985 Comm: test_progs Not tainted 6.6.0+ #2
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
  RIP: 0010:bpf_map_lookup_elem+0x54/0x60
  ......
  Call Trace:
   <TASK>
   ? __warn+0xa5/0x240
   ? bpf_map_lookup_elem+0x54/0x60
   ? report_bug+0x1ba/0x1f0
   ? handle_bug+0x40/0x80
   ? exc_invalid_op+0x18/0x50
   ? asm_exc_invalid_op+0x1b/0x20
   ? __pfx_bpf_map_lookup_elem+0x10/0x10
   ? rcu_lockdep_current_cpu_online+0x65/0xb0
   ? rcu_is_watching+0x23/0x50
   ? bpf_map_lookup_elem+0x54/0x60
   ? __pfx_bpf_map_lookup_elem+0x10/0x10
   ___bpf_prog_run+0x513/0x3b70
   __bpf_prog_run32+0x9d/0xd0
   ? __bpf_prog_enter_sleepable_recur+0xad/0x120
   ? __bpf_prog_enter_sleepable_recur+0x3e/0x120
   bpf_trampoline_6442580665+0x4d/0x1000
   __x64_sys_getpgid+0x5/0x30
   ? do_syscall_64+0x36/0xb0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
   </TASK>

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 56b0c1f678ee..f43038931935 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -32,12 +32,13 @@
  *
  * Different map implementations will rely on rcu in map methods
  * lookup/update/delete, therefore eBPF programs must run under rcu lock
- * if program is allowed to access maps, so check rcu_read_lock_held in
- * all three functions.
+ * if program is allowed to access maps, so check rcu_read_lock_held() or
+ * rcu_read_lock_trace_held() in all three functions.
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -53,7 +54,8 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -70,7 +72,8 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
-- 
2.29.2


