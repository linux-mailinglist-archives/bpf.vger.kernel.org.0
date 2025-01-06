Return-Path: <bpf+bounces-47918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C30A0203E
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB89B161AD3
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DB31D8A08;
	Mon,  6 Jan 2025 08:07:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416E1D79A0;
	Mon,  6 Jan 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150821; cv=none; b=aC2UcZSpPqr/ih6gsg7N/3pr91cuy7s+zoxH56spwPUf4s7QnMjKy/1lW3gBPoHKUKLPTzoukE19jVcfv6SoBhMDKNJyKkaUFMUCvSJi+eaQeGUoDX8MXJziZjmA4ZdqFFqRqxWVJY7DhOty7U8A2LkrWtZr02djnfHMSyWNXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150821; c=relaxed/simple;
	bh=gQCsMYtYPTED4DiSFcOSS1IMZ1kiqonY63DJMaxnPBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9UyxBGYDeOr3S3/5JJNhNza83e7Ep6+hjppENwbmjko5eeUKkT4DyDOIJrRStL0gWOPIJqd5N5UW8jUs1JyZP3IFPdBb2ePdXN/DVCak35VeGnmvjAg6g4E2Wras7BdgCSIzTZkwgU7iKIJkuPejZ434hQ4FIGTAQ2GuDF+l84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YRRbJ3nFdz4f3jMy;
	Mon,  6 Jan 2025 16:06:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9CCE91A14AC;
	Mon,  6 Jan 2025 16:06:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S8;
	Mon, 06 Jan 2025 16:06:56 +0800 (CST)
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
Subject: [PATCH bpf-next 04/19] bpf: Remove migrate_{disable|enable} from bpf_cgrp_storage_lock helpers
Date: Mon,  6 Jan 2025 16:18:45 +0800
Message-Id: <20250106081900.1665573-5-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw48urW5Xw4UJw1rZFW3GFg_yoW8tF43pr
	WxKasxZr4UA3WrZrZrJr4xAFy5C3WIgr17KFWDJr4xC395XF9xWr12yFZ8Zay3Z34Uur1a
	v3WYgF4UCr18ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Three callers of bpf_cgrp_storage_lock() are ->map_lookup_elem,
->map_update_elem, ->map_delete_elem from bpf syscall. BPF syscall for
these three operations of cgrp storage has already disabled migration.

Two call sites of bpf_cgrp_storage_trylock() are bpf_cgrp_storage_get(),
and bpf_cgrp_storage_delete() helpers. The running contexts of these
helpers have already disabled migration.

Therefore, it is safe to remove migrate_disable() for these callers.
However, bpf_cgrp_storage_free() also invokes bpf_cgrp_storage_lock()
and its running context doesn't disable migration. Therefore, also add
the missed migrate_{disabled|enable} in bpf_cgrp_storage_free().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_cgrp_storage.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 20f05de92e9c..d5dc65bb1755 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -15,22 +15,20 @@ static DEFINE_PER_CPU(int, bpf_cgrp_storage_busy);
 
 static void bpf_cgrp_storage_lock(void)
 {
-	migrate_disable();
+	cant_migrate();
 	this_cpu_inc(bpf_cgrp_storage_busy);
 }
 
 static void bpf_cgrp_storage_unlock(void)
 {
 	this_cpu_dec(bpf_cgrp_storage_busy);
-	migrate_enable();
 }
 
 static bool bpf_cgrp_storage_trylock(void)
 {
-	migrate_disable();
+	cant_migrate();
 	if (unlikely(this_cpu_inc_return(bpf_cgrp_storage_busy) != 1)) {
 		this_cpu_dec(bpf_cgrp_storage_busy);
-		migrate_enable();
 		return false;
 	}
 	return true;
@@ -47,17 +45,18 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 	struct bpf_local_storage *local_storage;
 
+	migrate_disable();
 	rcu_read_lock();
 	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
-	if (!local_storage) {
-		rcu_read_unlock();
-		return;
-	}
+	if (!local_storage)
+		goto out;
 
 	bpf_cgrp_storage_lock();
 	bpf_local_storage_destroy(local_storage);
 	bpf_cgrp_storage_unlock();
+out:
 	rcu_read_unlock();
+	migrate_enable();
 }
 
 static struct bpf_local_storage_data *
-- 
2.29.2


