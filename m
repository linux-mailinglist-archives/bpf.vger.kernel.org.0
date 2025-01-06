Return-Path: <bpf+bounces-47927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60940A02054
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EF5161E1C
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336C21DAC9F;
	Mon,  6 Jan 2025 08:07:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433881C4A1C;
	Mon,  6 Jan 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150827; cv=none; b=TBDRQi2s3rXySVvspsshXKwuUI3B3AWiSBjgmgB/4nP8+OkifuGA7C/3+alrEc4Hj/XKitHQKYlu88YzSWqY8UdKSbQLyzX3n1h0sRIX+wgzAeoU9jj7vuPvH61OI696t/0aaJGIk16TbG2dqOdc1KZXi+lyjwDJzilrAZwGs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150827; c=relaxed/simple;
	bh=OLnJ60MXVHbnChRm7xvDOUWS7wmMXSVUiNYpaMdRd8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6AQRm+LuoSmOZ4u7GMpPDVFvmLsf8CasAx7GStDYgFZ4KfA+Fa43hvoekTp6JIH4NTxPn2z1ZOlTTnJA+OSNpCyhwdh7AjFiF77Dk5uiixdMqg/SAGuIFD26u7MPMSOVSY9mzCdaQGZinbkIoFa4SoncENGlHhb8UUjFZKBA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YRRbK6KGQz4f3jR1;
	Mon,  6 Jan 2025 16:06:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E934A1A1A96;
	Mon,  6 Jan 2025 16:06:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S10;
	Mon, 06 Jan 2025 16:06:57 +0800 (CST)
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
Subject: [PATCH bpf-next 06/19] bpf: Disable migration when destroying inode storage
Date: Mon,  6 Jan 2025 16:18:47 +0800
Message-Id: <20250106081900.1665573-7-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S10
X-Coremail-Antispam: 1UD129KBjvJXoW7AF15Gw1kZw4kGF13WFWDXFb_yoW8AFWfpF
	Z7try5tw4qq3yF9rs7Xw4xCryxAayfWay7Gr4qkw1ftrsxXF98Kw1IyF1Fva43Jryvgr4I
	vFn0gFn8Zr1UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When destroying inode storage, it invokes bpf_local_storage_destroy() to
remove all storage elements saved in the inode storage. The destroy
procedure will call bpf_selem_free() to free the element, and
bpf_selem_free() calls bpf_obj_free_fields() to free the special fields
in map value (e.g., kptr). Since kptrs may be allocated from bpf memory
allocator, migrate_{disable|enable} pairs are necessary for the freeing
of these kptrs.

To simplify reasoning about when migrate_disable() is needed for the
freeing of these dynamically-allocated kptrs, let the caller to
guarantee migration is disabled before invoking bpf_obj_free_fields().
Therefore, the patch adds migrate_{disable|enable} pair in
bpf_inode_storage_free(). The migrate_{disable|enable} pairs in the
underlying implementation of bpf_obj_free_fields() will be removed by
the following patch.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_inode_storage.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index a51c82dee1bd..15a3eb9b02d9 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -62,16 +62,17 @@ void bpf_inode_storage_free(struct inode *inode)
 	if (!bsb)
 		return;
 
+	migrate_disable();
 	rcu_read_lock();
 
 	local_storage = rcu_dereference(bsb->storage);
-	if (!local_storage) {
-		rcu_read_unlock();
-		return;
-	}
+	if (!local_storage)
+		goto out;
 
 	bpf_local_storage_destroy(local_storage);
+out:
 	rcu_read_unlock();
+	migrate_enable();
 }
 
 static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
-- 
2.29.2


