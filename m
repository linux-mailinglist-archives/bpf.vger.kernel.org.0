Return-Path: <bpf+bounces-49792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24EA1C2D5
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6073A9E0B
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9591E7C08;
	Sat, 25 Jan 2025 10:59:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F51207A34
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802756; cv=none; b=taLc+Qvy+7ckgH11iIYH2of9NOCD30/qKvNsP0/pxphByzisTAuc041w6YWhtPeGYe8Lb99yZrCWMo5Lm1wz01xjKg0bjEjg3yyFvXrMo2MC6WqWIqurAC/Bvx8m7vBy9eT+fus8xMXXu63cmhScpJhBJS71SwCycpxzShgSf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802756; c=relaxed/simple;
	bh=DAfX+84m/90gIMDF55raQlRDznZNW892A7gnnjlbR5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXN959xOWpWEt615eWe35dZVJv3Z3lL44N5IMhufBvO+3mqV9szvpz6iyAiy05eNpfn0W5xewh5b0XtjstMAYPz9N7R6TP1b7gZ6N9JZ68O1oP+te7N+J9M9aYln1YnwJMjuinqUbWricdsICYgzkyV3CWKaoEb95GD2Wi3xIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBW774Srz4f3kvR
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 050CE1A0FC8
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S9;
	Sat, 25 Jan 2025 18:59:05 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 05/20] bpf: Introduce an internal map flag BPF_INT_F_DYNPTR_IN_KEY
Date: Sat, 25 Jan 2025 19:10:54 +0800
Message-Id: <20250125111109.732718-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250125111109.732718-1-houtao@huaweicloud.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGry3Zry7WrWxKrWUXrW7twb_yoW5Zw4DpF
	4rCFy3Wr48Xr47u3y7Xa1rurWYqw1Uury7CF9IgryrAFyjgry3Zr10gFy5CF9IvFW5A3y3
	Ar4jk34rCa47AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Introduce an internal map flag BPF_F_DYNPTR_IN_KEY to support dynptr in
map key. Add the corresponding helper bpf_map_has_dynptr_key() to check
whether the support of dynptr-key is enabled.

The reason for an internal map flag is twofolds:
1) user doesn't need to set the map flag explicitly
map_create() will use the presence of bpf_dynptr in map key as an
indicator of enabling dynptr key.
2) avoid adding new arguments for ->map_alloc_check() and ->map_alloc()
map_create() needs to pass the supported status of dynptr key to
->map_alloc_check (e.g., check the maximum length of dynptr data size)
and ->map_alloc (e.g., check whether dynptr key fits current map type).
Adding new arguments for these callbacks to achieve that will introduce
too much churns.

Therefore, the patch uses the topmost bit of map_flags as the internal
map flag. map_create() checks whether the internal flag is set in the
beginning and bpf_map_get_info_by_fd() clears the internal flag before
returns the map flags to userspace.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h  | 17 +++++++++++++++++
 kernel/bpf/syscall.c |  4 +++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ed58d5dd6b34b..ee02a5d313c56 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -258,6 +258,14 @@ struct bpf_list_node_kern {
 	void *owner;
 } __attribute__((aligned(8)));
 
+/* Internal map flags */
+enum {
+	/* map key supports bpf_dynptr */
+	BPF_INT_F_DYNPTR_IN_KEY = (1U << 31),
+};
+
+#define BPF_INT_F_MASK (1U << 31)
+
 struct bpf_map {
 	const struct bpf_map_ops *ops;
 	struct bpf_map *inner_map_meta;
@@ -269,6 +277,10 @@ struct bpf_map {
 	u32 value_size;
 	u32 max_entries;
 	u64 map_extra; /* any per-map-type extra fields */
+	/* The topmost bit of map_flags is used as an internal map flag
+	 * (aka BPF_INT_F_DYNPTR_IN_KEY) and it can't be set through bpf
+	 * syscall.
+	 */
 	u32 map_flags;
 	u32 id;
 	/* BTF record for special fields in map value. bpf_dynptr is disallowed
@@ -317,6 +329,11 @@ struct bpf_map {
 	s64 __percpu *elem_count;
 };
 
+static inline bool bpf_map_has_dynptr_key(const struct bpf_map *map)
+{
+	return map->map_flags & BPF_INT_F_DYNPTR_IN_KEY;
+}
+
 static inline const char *btf_field_type_name(enum btf_field_type type)
 {
 	switch (type) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d57bfb30463fa..07c67ad1a6a07 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1378,6 +1378,8 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		return -EINVAL;
 
+	if (attr->map_flags & BPF_INT_F_MASK)
+		return -EINVAL;
 	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
 	 * to avoid per-map type checks tripping on unknown flag
 	 */
@@ -5057,7 +5059,7 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	info.key_size = map->key_size;
 	info.value_size = map->value_size;
 	info.max_entries = map->max_entries;
-	info.map_flags = map->map_flags;
+	info.map_flags = map->map_flags & ~BPF_INT_F_MASK;
 	info.map_extra = map->map_extra;
 	memcpy(info.name, map->name, sizeof(map->name));
 
-- 
2.29.2


