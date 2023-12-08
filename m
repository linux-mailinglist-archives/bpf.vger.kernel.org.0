Return-Path: <bpf+bounces-17134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA7980A091
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E449B20BFF
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891981803B;
	Fri,  8 Dec 2023 10:23:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDA171F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 02:22:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SmnJr3WGSz4f3l2N
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CBFEB1A0B57
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxF57nJlY85LDA--.46390S11;
	Fri, 08 Dec 2023 18:22:54 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf-next 7/7] bpf: Wait for sleepable BPF program in maybe_wait_bpf_programs()
Date: Fri,  8 Dec 2023 18:23:55 +0800
Message-Id: <20231208102355.2628918-8-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231208102355.2628918-1-houtao@huaweicloud.com>
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxF57nJlY85LDA--.46390S11
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDCw4Dtw17Xw45Aw4fKrg_yoW5Kw47pF
	Z0ka4UKF45Xr47trsIqw4UZ34xtr9Yg347Grn5KryFvw13Xr9IgryFga98ZF1avrs7trWF
	qryjyrZ5Gw45ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Since commit 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in
sleepable programs"), sleepable BPF program can use map-in-map, but
maybe_wait_bpf_programs() doesn't consider it accordingly.

So checking the value of sleepable_refcnt in maybe_wait_bpf_programs(),
if the value is not zero, use synchronize_rcu_mult() to wait for both
sleepable and non-sleepable BPF programs. But bpf syscall from syscall
program is special, because the bpf syscall is called with
rcu_read_lock_trace() being held, and there will be dead-lock if
synchronize_rcu_mult() is used to wait for the exit of sleepable BPF
program, so just skip the waiting of sleepable BPF program for bpf
syscall which comes from syscall program.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d2641e51a1a7..6b9d7990d95f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/rcupdate_wait.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -140,15 +141,24 @@ static u32 bpf_map_value_size(const struct bpf_map *map)
 		return  map->value_size;
 }
 
-static void maybe_wait_bpf_programs(struct bpf_map *map)
+static void maybe_wait_bpf_programs(struct bpf_map *map, bool rcu_trace_lock_held)
 {
-	/* Wait for any running BPF programs to complete so that
-	 * userspace, when we return to it, knows that all programs
-	 * that could be running use the new map value.
+	/* Wait for any running non-sleepable and sleepable BPF programs to
+	 * complete, so that userspace, when we return to it, knows that all
+	 * programs that could be running use the new map value. However
+	 * syscall program can also use bpf syscall to update or delete inner
+	 * map in outer map, and it holds rcu_read_lock_trace() before doing
+	 * the bpf syscall. If use synchronize_rcu_mult(call_rcu_tasks_trace)
+	 * to wait for the exit of running sleepable BPF programs, there will
+	 * be dead-lock, so skip the waiting for syscall program.
 	 */
 	if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
-	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
-		synchronize_rcu();
+	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS) {
+		if (atomic64_read(&map->sleepable_refcnt) && !rcu_trace_lock_held)
+			synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
+		else
+			synchronize_rcu();
+	}
 }
 
 static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
@@ -1561,7 +1571,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 
 	err = bpf_map_update_value(map, f.file, key, value, attr->flags);
 	if (!err)
-		maybe_wait_bpf_programs(map);
+		maybe_wait_bpf_programs(map, bpfptr_is_kernel(uattr));
 
 	kvfree(value);
 free_key:
@@ -1618,7 +1628,7 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 	rcu_read_unlock();
 	bpf_enable_instrumentation();
 	if (!err)
-		maybe_wait_bpf_programs(map);
+		maybe_wait_bpf_programs(map, bpfptr_is_kernel(uattr));
 out:
 	kvfree(key);
 err_put:
@@ -4973,7 +4983,7 @@ static int bpf_map_do_batch(union bpf_attr *attr,
 err_put:
 	if (has_write) {
 		if (attr->batch.count)
-			maybe_wait_bpf_programs(map);
+			maybe_wait_bpf_programs(map, false);
 		bpf_map_write_active_dec(map);
 	}
 	fdput(f);
-- 
2.29.2


