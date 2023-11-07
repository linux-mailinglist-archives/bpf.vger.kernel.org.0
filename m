Return-Path: <bpf+bounces-14422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3B7E4177
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F0FB20F86
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F5B3159C;
	Tue,  7 Nov 2023 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995B30FA1
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 14:06:01 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1675C102
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:06:00 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SPqkT3dLlz4f3m7G
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 443751A0199
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhA_REpl+VkmAQ--.3051S12;
	Tue, 07 Nov 2023 22:05:57 +0800 (CST)
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
Subject: [PATCH bpf 08/11] bpf: Defer bpf_map_put() for inner map in map htab
Date: Tue,  7 Nov 2023 22:06:59 +0800
Message-Id: <20231107140702.1891778-9-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231107140702.1891778-1-houtao@huaweicloud.com>
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhA_REpl+VkmAQ--.3051S12
X-Coremail-Antispam: 1UD129KBjvJXoWxGryfAw1DZryDurWxJFyUAwb_yoWrAF13pF
	yrKF4xCrW8Xr4DJ3yrXan2vFyjgwn5Xw1UAF98Ga4FkF1kWr9rX3WrXFW7KFyY9F4DArs5
	tw12q340v34kCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When updating or deleting a map in map htab, the map may still be
accessed by non-sleepable program or sleepable program. However
bpf_fd_htab_map_update_elem() decreases the ref-count of the inner map
directly through bpf_map_put(), if the ref-count is the last ref-count
which is true for most cases, the inner map will be free by
ops->map_free() in a kworker. But for now, most .map_free() callbacks
don't use synchronize_rcu() or its variants to wait for the elapse of a
RCU grace period, so bpf program which is accessing the inner map may
incur use-after-free problem.

Fix it by deferring the invocation of bpf_map_put() after the elapse of
both one RCU grace period and one tasks trace RCU grace period.

Fixes: bba1dc0b55ac ("bpf: Remove redundant synchronize_rcu.")
Fixes: 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in sleepable programs")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c    | 25 +++++++++++++++----------
 kernel/bpf/map_in_map.h |  4 ++--
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 81b9f237c942b..0013329af6d36 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1813,10 +1813,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		} else {
 			value = l->key + roundup_key_size;
 			if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
-				struct bpf_map **inner_map = value;
+				void *inner = READ_ONCE(*(void **)value);
 
-				 /* Actual value is the id of the inner map */
-				map_id = map->ops->map_fd_sys_lookup_elem(*inner_map);
+				/* Actual value is the id of the inner map */
+				map_id = map->ops->map_fd_sys_lookup_elem(inner);
 				value = &map_id;
 			}
 
@@ -2553,12 +2553,16 @@ static struct bpf_map *htab_of_map_alloc(union bpf_attr *attr)
 
 static void *htab_of_map_lookup_elem(struct bpf_map *map, void *key)
 {
-	struct bpf_map **inner_map  = htab_map_lookup_elem(map, key);
+	struct bpf_inner_map_element *element;
+	void **ptr;
 
-	if (!inner_map)
+	ptr = htab_map_lookup_elem(map, key);
+	if (!ptr)
 		return NULL;
 
-	return READ_ONCE(*inner_map);
+	/* element must be no-NULL */
+	element = READ_ONCE(*ptr);
+	return element->map;
 }
 
 static int htab_of_map_gen_lookup(struct bpf_map *map,
@@ -2570,11 +2574,12 @@ static int htab_of_map_gen_lookup(struct bpf_map *map,
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
-	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 2);
+	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 3);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
 				offsetof(struct htab_elem, key) +
 				round_up(map->key_size, 8));
 	*insn++ = BPF_LDX_MEM(BPF_DW, ret, ret, 0);
+	*insn++ = BPF_LDX_MEM(BPF_DW, ret, ret, 0);
 
 	return insn - insn_buf;
 }
@@ -2592,9 +2597,9 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_of_map_lookup_elem,
 	.map_delete_elem = htab_map_delete_elem,
-	.map_fd_get_ptr = bpf_map_fd_get_ptr,
-	.map_fd_put_ptr = bpf_map_fd_put_ptr,
-	.map_fd_sys_lookup_elem = bpf_map_fd_sys_lookup_elem,
+	.map_fd_get_ptr = bpf_map_of_map_fd_get_ptr,
+	.map_fd_put_ptr = bpf_map_of_map_fd_put_ptr,
+	.map_fd_sys_lookup_elem = bpf_map_of_map_fd_sys_lookup_elem,
 	.map_gen_lookup = htab_of_map_gen_lookup,
 	.map_check_btf = map_check_no_btf,
 	.map_mem_usage = htab_map_mem_usage,
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index 1fa688b8882ae..f8719bcd7c254 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -10,8 +10,8 @@ struct file;
 struct bpf_map;
 
 struct bpf_inner_map_element {
-	/* map must be the first member, array_of_map_gen_lookup() depends on it
-	 * to dereference map correctly.
+	/* map must be the first member, array_of_map_gen_lookup() and
+	 * htab_of_map_lookup_elem() depend on it to dereference map correctly.
 	 */
 	struct bpf_map *map;
 	struct rcu_head rcu;
-- 
2.29.2


