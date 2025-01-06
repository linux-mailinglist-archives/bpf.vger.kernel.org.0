Return-Path: <bpf+bounces-47925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C363A0204F
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DB73A4094
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB01DA634;
	Mon,  6 Jan 2025 08:07:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1861D90C5;
	Mon,  6 Jan 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150827; cv=none; b=fKmGaWINJeZJMnA7lvYg6gKjK7wgnOdix4cMBu3KnU7n+qsEENw84Pe7VAX/zc2O+0eAuPrSypUdQw+Q7RJUJOl06QSt0fk89OlWBQtin+qYnzXpdsbJqyCPcnUH+mLkylNqNjsoizs+Y1kztLkun+y5EpIZA5fBg3lEvi0XGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150827; c=relaxed/simple;
	bh=QzGyMUsCmMaGHNoW5OTSqgcCkHWN6HTrqiFfJA2nuxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nABHaQAdDmHp1hZ7IoMfdsCWldg9QIicWtKbPf+pK3ZcyHadsQFj1UWl5ngVKNv6uiJ53rXfdYxFCHew7IG4sS6J2Btw/c/GIMgYkFJYCrcffKmjc4Y7IAw+uS5IGXYRNgH2N43FX3SxGq27PdcCOrS9bzCytGr+SX0hnnSyO/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRRbT4372z4f3jqx;
	Mon,  6 Jan 2025 16:06:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7C9651A147C;
	Mon,  6 Jan 2025 16:07:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S14;
	Mon, 06 Jan 2025 16:07:00 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 10/19] bpf: Disable migration in array_map_free()
Date: Mon,  6 Jan 2025 16:18:51 +0800
Message-Id: <20250106081900.1665573-11-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250106081900.1665573-1-houtao@huaweicloud.com>
References: <20250106081900.1665573-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S14
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWDAw4UKF4xWr45Wr1fXrb_yoW8WF43pF
	Wkt34jkr48Xr4Ikrs8Jayjk34YyrW5G342kFZ5K34Fva13Zr9rZw1fG3W8ZF1YkF1kKr1S
	qw1qy39ayay8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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

When freeing the array map, the destroy procedure may invoke
bpf_obj_free_fields() to free the special fields in map value
(e.g., kptr). Since kptrs may be allocated from bpf memory allocator,
migrate_{disable|enable} pairs are necessary for the freeing of these
kptrs.

To simplify reasoning about when migrate_disable() is needed for the
freeing of these dynamically-allocated kptrs, let the caller to
guarantee migration is disabled before invoking bpf_obj_free_fields().

Therefore, the patch adds migrate_{disable|enable} pair in
array_map_free(). The migrate_{disable|enable} pairs in the underlying
implementation of bpf_obj_free_fields() will be removed by the following
patch.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/arraymap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index eb28c0f219ee..451737493b17 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -455,6 +455,7 @@ static void array_map_free(struct bpf_map *map)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
+	migrate_disable();
 	if (!IS_ERR_OR_NULL(map->record)) {
 		if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 			for (i = 0; i < array->map.max_entries; i++) {
@@ -471,6 +472,7 @@ static void array_map_free(struct bpf_map *map)
 				bpf_obj_free_fields(map->record, array_map_elem_ptr(array, i));
 		}
 	}
+	migrate_enable();
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
 		bpf_array_free_percpu(array);
-- 
2.29.2


