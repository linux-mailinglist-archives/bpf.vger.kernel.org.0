Return-Path: <bpf+bounces-48199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A91A04E78
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A533A247D
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F019ABD8;
	Wed,  8 Jan 2025 00:55:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9E1974FE;
	Wed,  8 Jan 2025 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297735; cv=none; b=aTwWthaqeaqsPrXyKNrlSAFrmsYDPxa9KgGk8n0PA1PMR6PHDz1Mc9PAxnmUe606q/gbMjqOzFZLm99hqK0j4cdAn7zAJ3Bcwjhn4zRp0b7HG/3Z/2fyMGFcCNIqJom76CiWIzV0BUXRb05YTDoPguQzwg13DZitmxSte+DWVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297735; c=relaxed/simple;
	bh=/FcnpfGrOmkvo7j6YxvRov66UbLKzRdKF+P1KDVuxSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIXIKDuyHA/KwVBbjpg7Q6nadvcxgix8gIz9jQiOgFSF3ac06f5exhfxToirBhdTyW+C6P5lPYJuFvp3OPhITP1GDWkjRThiZIE3jD3uK/HNKESeE54lizOfgeHUy4bb2KkLeFg72T4pEjymXH6ebXdbMIcEJL+zhXRiKUCLpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YSTwZ3T6Fz4f3kFh;
	Wed,  8 Jan 2025 08:55:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A1E691A1494;
	Wed,  8 Jan 2025 08:55:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_1zH1nBtZdAQ--.51859S20;
	Wed, 08 Jan 2025 08:55:30 +0800 (CST)
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
Subject: [PATCH bpf-next v2 16/16] bpf: Remove migrate_{disable|enable} from bpf_selem_free()
Date: Wed,  8 Jan 2025 09:07:28 +0800
Message-Id: <20250108010728.207536-17-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250108010728.207536-1-houtao@huaweicloud.com>
References: <20250108010728.207536-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq1_1zH1nBtZdAQ--.51859S20
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fCr48CF1ftr1rtr48tFb_yoW8CFW7pF
	Z3XryrAr42qa1F9rsrJF4fC34rXw4kWr17Kr4qyryrtwsxZF93Gr4IkF18ZasxJw1UXr1f
	ZF1Yga4j9w4UCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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

bpf_selem_free() has the following three callers:

(1) bpf_local_storage_update
It will be invoked through ->map_update_elem syscall or helpers for
storage map. Migration has already been disabled in these running
contexts.

(2) bpf_sk_storage_clone
It has already disabled migration before invoking bpf_selem_free().

(3) bpf_selem_free_list
bpf_selem_free_list() has three callers: bpf_selem_unlink_storage(),
bpf_local_storage_update() and bpf_local_storage_destroy().

The callers of bpf_selem_unlink_storage() includes: storage map
->map_delete_elem syscall, storage map delete helpers and
bpf_local_storage_map_free(). These contexts have already disabled
migration when invoking bpf_selem_unlink() which invokes
bpf_selem_unlink_storage() and bpf_selem_free_list() correspondingly.

bpf_local_storage_update() has been analyzed as the first caller above.
bpf_local_storage_destroy() is invoked when freeing the local storage
for the kernel object. Now cgroup, task, inode and sock storage have
already disabled migration before invoking bpf_local_storage_destroy().

After the analyses above, it is safe to remove migrate_{disable|enable}
from bpf_selem_free().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_local_storage.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 7c18298b139c3..fa56c30833ff1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -254,9 +254,7 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		 * bpf_mem_cache_free will be able to reuse selem
 		 * immediately.
 		 */
-		migrate_disable();
 		bpf_mem_cache_free(&smap->selem_ma, selem);
-		migrate_enable();
 		return;
 	}
 
-- 
2.29.2


