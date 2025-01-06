Return-Path: <bpf+bounces-47933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C93A0205A
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF695163F7C
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9461D90C5;
	Mon,  6 Jan 2025 08:07:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FE1D79B6;
	Mon,  6 Jan 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150834; cv=none; b=Rl2YiXrLEMs2N7LbwkRpd52Nw+2UaBDoc9f7dmsS0fylEqRmS98omhZQd7OYj4aeHwV2BNj4JVwfa6DR1GkxsGEKE1+pk4vs4o1vDNv4Ugv2mdgezOE9R15ueSFCL0c8EwdE+P/usZGdy+7jJfdwZjfwtHf1CUBcmOZ9BItT9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150834; c=relaxed/simple;
	bh=ERV+dNS62FMiq+IIL3K7+YwHjYuSiJlg0VXFGZe3uzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocfOBIzTCLdNIEWiFR/tB5ckRU/Dml6HBHQsoQD8XZYmFaMxkFRe/5Cboc4HC/30EsFSCyd9QCelHV8AbMRT5+EHKSMblT2Px32Bc1E6ZyV/8qapLwefL44pGzLdrXpchG4S4M7F65PNwDh4GTHcLfwqrp7rLaWNNMLwYr1WEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRRbS2Vl0z4f3kvs;
	Mon,  6 Jan 2025 16:06:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9DF731A14E3;
	Mon,  6 Jan 2025 16:07:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S22;
	Mon, 06 Jan 2025 16:07:05 +0800 (CST)
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
Subject: [PATCH bpf-next 18/19] bpf: Remove migrate_{disable|enable} from bpf_local_storage_free()
Date: Mon,  6 Jan 2025 16:18:59 +0800
Message-Id: <20250106081900.1665573-19-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S22
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4DCrW3Ww13JFWktFykAFb_yoW8ZF43pF
	92gr93Cr4Ut3WF9FsrXF4fAr9xXw45Gr1jkws8ArySyrZxZrZ8Gr42kF47uFy3Gw1UXF4S
	vFn0gF1UCr1UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

bpf_local_storage_free() has three callers:

1) bpf_local_storage_alloc()
Its caller must have disabled migration.

2) bpf_local_storage_destroy()
Its four callers (bpf_{cgrp|inode|task|sk}_storage_free()) have already
invoked migrate_disable() before invoking bpf_local_storage_destroy().

3) bpf_selem_unlink()
Its callers include: cgrp/inode/task/sk storage ->map_delete_elem
callbacks, bpf_{cgrp|inode|task|sk}_storage_delete() helpers and
bpf_local_storage_map_free(). All of these callers have already disabled
migration before invoking bpf_selem_unlink().

Therefore, it is OK to remove migrate_{disable|enable} pair from
bpf_local_storage_free(). Also add a cant_migrate() check in
bpf_local_storage_free() to ensure the guarantee isn't broken.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_local_storage.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 0970766278f7..d67ba116aee8 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -163,6 +163,8 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 	if (!local_storage)
 		return;
 
+	cant_migrate();
+
 	if (!bpf_ma) {
 		__bpf_local_storage_free(local_storage, reuse_now);
 		return;
@@ -174,17 +176,14 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 		return;
 	}
 
-	if (smap) {
-		migrate_disable();
+	if (smap)
 		bpf_mem_cache_free(&smap->storage_ma, local_storage);
-		migrate_enable();
-	} else {
+	else
 		/* smap could be NULL if the selem that triggered
 		 * this 'local_storage' creation had been long gone.
 		 * In this case, directly do call_rcu().
 		 */
 		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
-	}
 }
 
 /* rcu tasks trace callback for bpf_ma == false */
-- 
2.29.2


