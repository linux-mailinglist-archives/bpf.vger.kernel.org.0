Return-Path: <bpf+bounces-48198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17B2A04E6D
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ECA18881A7
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D7419995E;
	Wed,  8 Jan 2025 00:55:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB0189B91;
	Wed,  8 Jan 2025 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297734; cv=none; b=AjnIlPEL0F5I+H4xEzKmtZbeefcJirt5bADfHOV0ylOfOhcPViE3txSz4BCInCbbSHS36EbEjJeBRTdrhurV2BLQQ3ytGOSlZWJcQJraSN2mago5YKpnNNoCuhqslPAjHWs5DXz5JJexJzAfliSEHd/x9kyhhKPCXZzCjzzfjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297734; c=relaxed/simple;
	bh=ikB/vYh5qE7JK1x//CjtfwtRZ1h/e4WwVZ7juOoQh4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eH4dCShEHhDnN31w0TJrthkJ9RR9ir+tyUjHfgMblQRL2R31hBtueipk44GrEyyXXr/Qbf/+wQy26gHIYnAS2K7Bdx1WRhVrm4ixuX8Kz91DW1oWu9xizC1507gGAGc3CRuYKRu0K0sLvz8cz1XC0rF6vmvOGFiZ5daU0tY+ncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YSTwY5vR1z4f3kFc;
	Wed,  8 Jan 2025 08:55:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F3DB71A0DA8;
	Wed,  8 Jan 2025 08:55:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_1zH1nBtZdAQ--.51859S19;
	Wed, 08 Jan 2025 08:55:29 +0800 (CST)
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
Subject: [PATCH bpf-next v2 15/16] bpf: Remove migrate_{disable|enable} from bpf_local_storage_free()
Date: Wed,  8 Jan 2025 09:07:27 +0800
Message-Id: <20250108010728.207536-16-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHq1_1zH1nBtZdAQ--.51859S19
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4DCrW3Ww13JFWktFykAFb_yoW8WFWrpF
	97Gr9akr4Uta1FvFsrWF4fur9xXw45Gryjkws8ArySyrZxZrZ8Gr42kFWUZFy3Cw1DXF4S
	9r90gF1j9w1UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
bpf_local_storage_free().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_local_storage.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index d78d53b921180..7c18298b139c3 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -172,17 +172,14 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
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


