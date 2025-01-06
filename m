Return-Path: <bpf+bounces-47921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6A1A02044
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA8B163AA2
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F61D935A;
	Mon,  6 Jan 2025 08:07:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119C1D6DC9;
	Mon,  6 Jan 2025 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150823; cv=none; b=tLyTjpsG+zKQNpIR9NTqR45OU5OhxE5MjTncxkvwhCjfyb0mvOsgpEQf59w/UDrXzintRYvKiucT7VSE4Caknm5ov9nu4rqMApfu0eU/EtOfVTIqEllM/F5rWYdFUw+8O+qkKouiTrK1AvlJrIjknT4CcaimBPsF03ysO8Fhz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150823; c=relaxed/simple;
	bh=7qzJ8Ksyo9MGJycen55qwiVKEUhRpzMhpfQoq1SLXtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Et5mr+x74Ss78bRhZxcwRkXBiWmhQRQTTjQrzAS+7fia2ucE45IYtUfhY4VmIIoD4fZbPIGg6n2pQieoB+Ud/kL8tJq2xOTE2PwBzj0lN/FX+z0/bUPG5EMtWZUy9k74nCurExZ48IsMLMCZxaQmtBYkbABq+HGjZQmzXYjwEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YRRbK1Dbwz4f3jRC;
	Mon,  6 Jan 2025 16:06:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 455DD1A1126;
	Mon,  6 Jan 2025 16:06:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S9;
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
Subject: [PATCH bpf-next 05/19] bpf: Remove migrate_{disable|enable} from bpf_task_storage_lock helpers
Date: Mon,  6 Jan 2025 16:18:46 +0800
Message-Id: <20250106081900.1665573-6-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw48XF17Gr48Cr48CFy5XFb_yoW5JryUpr
	yxtF9xAr45J3ZYyrsxXws7AryUAwn3Ww47Krs0kF97Krs5XF93Wr1xt3ZrZFy3J34jqF43
	ZFs0g3ZxCr1DJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Three callers of bpf_task_storage_lock() are ->map_lookup_elem,
->map_update_elem, ->map_delete_elem from bpf syscall. BPF syscall for
these three operations of task storage has already disabled migration.
Another two callers are bpf_task_storage_get() and
bpf_task_storage_delete() helpers which will be used by BPF program.

Two callers of bpf_task_storage_trylock() are bpf_task_storage_get() and
bpf_task_storage_delete() helpers. The running contexts of these helpers
have already disabled migration.

Therefore, it is safe to remove migrate_{disable|enable} from task
storage lock helpers for these call sites. However,
bpf_task_storage_free() also invokes bpf_task_storage_lock() and its
running context doesn't disable migration, therefore, add the missed
migrate_{disable|enable} in bpf_task_storage_free().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_task_storage.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index bf7fa15fdcc6..1109475953c0 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -24,22 +24,20 @@ static DEFINE_PER_CPU(int, bpf_task_storage_busy);
 
 static void bpf_task_storage_lock(void)
 {
-	migrate_disable();
+	cant_migrate();
 	this_cpu_inc(bpf_task_storage_busy);
 }
 
 static void bpf_task_storage_unlock(void)
 {
 	this_cpu_dec(bpf_task_storage_busy);
-	migrate_enable();
 }
 
 static bool bpf_task_storage_trylock(void)
 {
-	migrate_disable();
+	cant_migrate();
 	if (unlikely(this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
 		this_cpu_dec(bpf_task_storage_busy);
-		migrate_enable();
 		return false;
 	}
 	return true;
@@ -72,18 +70,19 @@ void bpf_task_storage_free(struct task_struct *task)
 {
 	struct bpf_local_storage *local_storage;
 
+	migrate_disable();
 	rcu_read_lock();
 
 	local_storage = rcu_dereference(task->bpf_storage);
-	if (!local_storage) {
-		rcu_read_unlock();
-		return;
-	}
+	if (!local_storage)
+		goto out;
 
 	bpf_task_storage_lock();
 	bpf_local_storage_destroy(local_storage);
 	bpf_task_storage_unlock();
+out:
 	rcu_read_unlock();
+	migrate_enable();
 }
 
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
-- 
2.29.2


