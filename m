Return-Path: <bpf+bounces-49800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F03A1C2DF
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 12:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647D83A6385
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FCB2080D5;
	Sat, 25 Jan 2025 10:59:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259E2080E7
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802759; cv=none; b=XIRa0fsvZTDF0hLHtVLx3HJhJeHO1Vl3sAnu9+spWAB6q2cYQeORL9WAAquSEmVKtSHVb6rLJ15WclMTsF9Z8VP1JD5qccz5Mlhf5oMWlHUwxo+nmBTtHw1+3plT6QFSBuBn82zBlzB+dCMkiTPrnoXKF6LwQDQS+TAi2JPFcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802759; c=relaxed/simple;
	bh=Wti950fvufaGyOozmEdwfW+5+UQg8j7f0BnrvaE2cRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SooCRz9DCfMGJNgLjE2h0vP6rVJ14xcbXo55quMRuCibAzdzjA6VspWSj5+/+/Y/7tAnMHhsTC0XrbkBEkvggRwgkIlyKINJfZQebVrZcj2YI1eisCu/7h0WSTJsVmVNdyjcHRe16sHBOm4vC+VmDM7WsrI3MkVCiG2Nyo9NLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YgBWJ1T2sz4f3jXr
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E84B71A06E6
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S20;
	Sat, 25 Jan 2025 18:59:12 +0800 (CST)
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
Subject: [PATCH bpf-next v2 16/20] bpf: Disable unsupported operations for map with dynptr key
Date: Sat, 25 Jan 2025 19:11:05 +0800
Message-Id: <20250125111109.732718-17-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S20
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxWFWkJr4rCrW8uw18Grg_yoW8GFyrpF
	48Aa4Ikr48XF4fC347Wa1jv34UXw45G342kF4kK34rAF17XF9Fgr1DtF13Xr90kFWUJr4S
	qrW2grWFk34xCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Both batched map operation and dumping the map content through bpffs for
maps with dynptr keys are not supported, so disable these operations for
now.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h  | 3 ++-
 kernel/bpf/syscall.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a7dcdbd8c2824..194f3d4c1b0d0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -635,7 +635,8 @@ static inline bool bpf_map_offload_neutral(const struct bpf_map *map)
 static inline bool bpf_map_support_seq_show(const struct bpf_map *map)
 {
 	return (map->btf_value_type_id || map->btf_vmlinux_value_type_id) &&
-		map->ops->map_seq_show_elem;
+		map->ops->map_seq_show_elem &&
+		!bpf_map_has_dynptr_key(map);
 }
 
 int map_check_no_btf(const struct bpf_map *map,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dc29fa897855c..0f102142cc0db 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5542,6 +5542,10 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 		err = -EPERM;
 		goto err_put;
 	}
+	if (bpf_map_has_dynptr_key(map)) {
+		err = -EOPNOTSUPP;
+		goto err_put;
+	}
 
 	if (cmd == BPF_MAP_LOOKUP_BATCH)
 		BPF_DO_BATCH(map->ops->map_lookup_batch, map, attr, uattr);
-- 
2.29.2


