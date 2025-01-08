Return-Path: <bpf+bounces-48193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C220EA04E66
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FA716622B
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF25183CA9;
	Wed,  8 Jan 2025 00:55:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206815853B;
	Wed,  8 Jan 2025 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297732; cv=none; b=jvh8LGxrVLod61jfgyhgObgIGewrwD0qP7gXVzDKif4v5cWbhS7psYqr7ux0UdVzfJKghERxjma6WD3maxmxRlY2+BfQ9D6QsgK/le7MQiSfMjyPpgpDVVs2zAh0JubsKISQLBjrqJaXnSSDVGYVrPyHhSou0YxbHSZDMusdCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297732; c=relaxed/simple;
	bh=J4fiA2QpCPQQCDuYno0mJRRvDHQu0tE108S1lPmY1y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyvBb1eBWMDvIKWhEiLgtLfFRn280oMmxzijzbb5UoALcgdsMLD7WsNFEymFFnoKdwcOgIpiGjHuh23T+5SPHZe1haSYssyVYFqniZ6l8PmlTgDLk1OKNslHVX1k2KMwe418MsR50TD9S07wzpxZJmeX4ptSqL1ldwe+XfuWnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YSTwc3mhNz4f3jqs;
	Wed,  8 Jan 2025 08:55:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 83C6C1A0D7B;
	Wed,  8 Jan 2025 08:55:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_1zH1nBtZdAQ--.51859S15;
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
Subject: [PATCH bpf-next v2 11/16] bpf: Remove migrate_{disable|enable} in bpf_obj_free_fields()
Date: Wed,  8 Jan 2025 09:07:23 +0800
Message-Id: <20250108010728.207536-12-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHq1_1zH1nBtZdAQ--.51859S15
X-Coremail-Antispam: 1UD129KBjvJXoWxJryfWr1DCFykCF45GFy3Arb_yoW8Zry3pr
	s3tw1fKr48XFn29rZxJr40k3yrAw43Ga47G34DGryFvws0yryqqw1DCr1ruF1rtrykKwsa
	vwn0gr90v34UXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The callers of bpf_obj_free_fields() have already guaranteed that the
migration is disabled, therefore, there is no need to invoke
migrate_{disable,enable} pair in bpf_obj_free_fields()'s underly
implementation.

This patch removes unnecessary migrate_{disable|enable} pairs from
bpf_obj_free_fields() and its callees: bpf_list_head_free() and
bpf_rb_root_free().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 4 ----
 kernel/bpf/syscall.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cd5f9884d85bf..bcda671feafd9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2066,9 +2066,7 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 		/* The contained type can also have resources, including a
 		 * bpf_list_head which needs to be freed.
 		 */
-		migrate_disable();
 		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
-		migrate_enable();
 	}
 }
 
@@ -2105,9 +2103,7 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 		obj -= field->graph_root.node_offset;
 
 
-		migrate_disable();
 		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
-		migrate_enable();
 	}
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5d24204929461..0daf098e32074 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -796,11 +796,9 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			if (!btf_is_kernel(field->kptr.btf)) {
 				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
 									   field->kptr.btf_id);
-				migrate_disable();
 				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
 								 pointee_struct_meta->record : NULL,
 								 fields[i].type == BPF_KPTR_PERCPU);
-				migrate_enable();
 			} else {
 				field->kptr.dtor(xchgd_field);
 			}
-- 
2.29.2


