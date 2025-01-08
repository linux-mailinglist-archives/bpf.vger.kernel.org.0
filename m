Return-Path: <bpf+bounces-48195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BC1A04E6B
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260F9166F50
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD9F19258B;
	Wed,  8 Jan 2025 00:55:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22E17B4FF;
	Wed,  8 Jan 2025 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297732; cv=none; b=uEOaxGCiWyocmL+EheagAznRcwy0n2MISwaDTgHw4PnkMB7a8Sk8825KqjrShiHHPilaIaY189YzIrKcIzHgE0YUxVSkBSUn36YkuybtIRqiLEYzIbeJmWonwyEFNVhye2joGhOnl59FysJuoqf+pDH1FMyuIpt8IsF23FjeTmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297732; c=relaxed/simple;
	bh=BancbvxGV6TxVyD3aWGvTSmDBYAonmGvuMEw5ddE4JY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rb9Q7oogPc+NZexAaCJCiVi5j2IFpRP3PAQyl15P2XfR/i0ws6pxhvrYeUo42qFvRzP/xO9NLENG65BJLKePRNhyf0/lpGITAl5VF5ZSr53SRFzskoREFzN630RPYzIBk8OizBpaUujgtyZKuJa6JFoeBYdMOMiArpZqVabLyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YSTwW6xPFz4f3jMX;
	Wed,  8 Jan 2025 08:55:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2474B1A10C2;
	Wed,  8 Jan 2025 08:55:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_1zH1nBtZdAQ--.51859S16;
	Wed, 08 Jan 2025 08:55:27 +0800 (CST)
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
Subject: [PATCH bpf-next v2 12/16] bpf: Remove migrate_{disable,enable} in bpf_cpumask_release()
Date: Wed,  8 Jan 2025 09:07:24 +0800
Message-Id: <20250108010728.207536-13-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHq1_1zH1nBtZdAQ--.51859S16
X-Coremail-Antispam: 1UD129KBjvdXoWrur1fWr1fWFykKFyfAw1UWrg_yoWDGwb_Ar
	4UWr1kWrn0yws7Kr1jkw13XrWaq3yvqa92yw1kWFW8WFyYgw4jya15Ar4YyrZ5Jws7KFWa
	gwn5Grn5Ar17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When BPF program invokes bpf_cpumask_release(), the migration must have
been disabled. When bpf_cpumask_release_dtor() invokes
bpf_cpumask_release(), the caller bpf_obj_free_fields() also has
disabled migration, therefore, it is OK to remove the unnecessary
migrate_{disable|enable} pair in bpf_cpumask_release().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/cpumask.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 33c473d676a52..cfa1c18e3a483 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -91,9 +91,7 @@ __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 	if (!refcount_dec_and_test(&cpumask->usage))
 		return;
 
-	migrate_disable();
 	bpf_mem_cache_free_rcu(&bpf_cpumask_ma, cpumask);
-	migrate_enable();
 }
 
 __bpf_kfunc void bpf_cpumask_release_dtor(void *cpumask)
-- 
2.29.2


