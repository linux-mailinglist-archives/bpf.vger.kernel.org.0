Return-Path: <bpf+bounces-47935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EEFA0205D
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F0918858BC
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64BC1DC988;
	Mon,  6 Jan 2025 08:07:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F21DA0E1;
	Mon,  6 Jan 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150836; cv=none; b=KVTyCsoBiP017BC5o6N0QGHEWI6dyckuBhqw1CrefYje2qjb4t7VY2uMMG/aiw/4ZQ2hEaShG9dgnakOE39t0Nz1mgi++tIPSZT5w0XQ3cbscE567WrR0Tu5pPF++g0i7HGoQEOASvSLGIW2o1uQqiLuDdL2+zVHvG79ar1SYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150836; c=relaxed/simple;
	bh=XPAyxuEqoQ9kPmaRjBByoeA0kuBk23qq7DNXlnka/4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBsBqWg2MVVytdN+WWH9zwy6nOdbQbLg8F1WmTlzZDD6StLICc5ocWomxaRwP4W+/qvmnNRX/EVPcoXzJYuAtRP88zQA5jULrpUJ5Nm6XjyeFUrwlN6oa9PMAaTJAAA38OePcENY0Gs9Ox/quzd+kBJLx1foomdhEvQZeveNLLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YRRbV1C8lz4f3jd9;
	Mon,  6 Jan 2025 16:06:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 44BB91A10C2;
	Mon,  6 Jan 2025 16:07:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S23;
	Mon, 06 Jan 2025 16:07:06 +0800 (CST)
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
Subject: [PATCH bpf-next 19/19] bpf: Remove migrate_{disable|enable} from bpf_selem_free()
Date: Mon,  6 Jan 2025 16:19:00 +0800
Message-Id: <20250106081900.1665573-20-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S23
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fCr48CF1ftr1rtr48tFb_yoW8tFWfpF
	Z7Xr95Cr4Uta1F9FsrJF4fCryrXw48Wr17Kr4DA34rtrsxZF93Gr4IkF18Za43Gw1UXryf
	ZF1Yga4Uuw4UCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
from bpf_selem_free(). Also add a cant_migrate() check in
bpf_selem_free().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_local_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index d67ba116aee8..f196093db0a0 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -235,6 +235,8 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    struct bpf_local_storage_map *smap,
 		    bool reuse_now)
 {
+	cant_migrate();
+
 	if (!smap->bpf_ma) {
 		/* Only task storage has uptrs and task storage
 		 * has moved to bpf_mem_alloc. Meaning smap->bpf_ma == true
@@ -258,9 +260,7 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
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


