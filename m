Return-Path: <bpf+bounces-54795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCBEA72B5A
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D21176963
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F28205AAC;
	Thu, 27 Mar 2025 08:23:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC12054FF
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063783; cv=none; b=coNcAnlKhkJbCKFGyYLKSD0p6JtCe5fnPdD71i5uJEcyOMM/eRtDxy1xRLEldMOvgE3oCpGb07ShMO4t+nBj5SM82+E1WEf+5cTJVXa3+31UDpH5Cms6c3mbPY+iTT8Tt25N1GO6TYYXQbAuBQRYYnjD8zpxpb3O+JKEbqLGBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063783; c=relaxed/simple;
	bh=KgvpsCbDfFWKd0vl1YCZmd4rNxB7vuBm2d9HEBt0gpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WfIkOI8WFEf5q4KT4KSVWb3gWCSYy/5tuVeJQ6W99NeRYWgBPMmxBvz8moaNFAhmPmIiPSfmp0xFhKvDDuzMaOOEZQ+uMVdENSv/R8mqZR3Zo02zAwKTcu9suQlvczp3DPq3APKjkbmIswzPttVm4MPJF/Kbp0UwZFuzDO/1j2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8p72vHz4f3jXb
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EC3E01A0EC9
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S16;
	Thu, 27 Mar 2025 16:22:57 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 12/16] bpf: Disable unsupported operations for map with dynptr key
Date: Thu, 27 Mar 2025 16:34:51 +0800
Message-Id: <20250327083455.848708-13-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S16
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4xCw17Zr1rur4rCr4xCrg_yoW5Gry8pF
	48JF97ur40vF47X342qa1kZ34UXw1UK347Ca1vy34rtFnrXr9Igr18J3W3Xr9I9FWUJ3yI
	yw429rWFv3yUurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Batched map operations, dumping the map content through bpffs, and
iterating over each element using the bpf_for_each_map_elem() helper or
the bpf map element iterator are not supported for maps with dynptr
keys. Therefore, disable these operations for now.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h   | 3 ++-
 kernel/bpf/map_iter.c | 3 +++
 kernel/bpf/syscall.c  | 4 ++++
 kernel/bpf/verifier.c | 4 ++++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f4b43b68f8d1..59295dd8d6fd3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -629,7 +629,8 @@ static inline bool bpf_map_offload_neutral(const struct bpf_map *map)
 static inline bool bpf_map_support_seq_show(const struct bpf_map *map)
 {
 	return (map->btf_value_type_id || map->btf_vmlinux_value_type_id) &&
-		map->ops->map_seq_show_elem;
+		map->ops->map_seq_show_elem &&
+		!bpf_map_has_dynptr_key(map);
 }
 
 int map_check_no_btf(const struct bpf_map *map,
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 9575314f40a69..775d8bc63ed5d 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -113,6 +113,9 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
+	if (bpf_map_has_dynptr_key(map))
+		goto put_map;
+
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 40c3d85b06bae..24599749dc6f9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5508,6 +5508,10 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 		err = -EPERM;
 		goto err_put;
 	}
+	if (bpf_map_has_dynptr_key(map)) {
+		err = -EOPNOTSUPP;
+		goto err_put;
+	}
 
 	if (cmd == BPF_MAP_LOOKUP_BATCH)
 		BPF_DO_BATCH(map->ops->map_lookup_batch, map, attr, uattr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 05a5636ae4984..fea94fcd8bf25 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10246,6 +10246,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_CGRP_STORAGE)
 			goto error;
 		break;
+	case BPF_FUNC_for_each_map_elem:
+		if (bpf_map_has_dynptr_key(map))
+			goto error;
+		break;
 	default:
 		break;
 	}
-- 
2.29.2


