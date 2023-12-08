Return-Path: <bpf+bounces-17127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA380A089
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031AC1F2181D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75DB14F61;
	Fri,  8 Dec 2023 10:22:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AF0172B
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 02:22:54 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SmnJp07l5z4f3kGJ
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 565F01A076A
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxF57nJlY85LDA--.46390S6;
	Fri, 08 Dec 2023 18:22:52 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 2/7] bpf: Call maybe_wait_bpf_programs() only once for generic_map_update_batch()
Date: Fri,  8 Dec 2023 18:23:50 +0800
Message-Id: <20231208102355.2628918-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231208102355.2628918-1-houtao@huaweicloud.com>
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxF57nJlY85LDA--.46390S6
X-Coremail-Antispam: 1UD129KBjvJXoWrtry7JFyUZw1kCr4UWFy8Zrb_yoW8Jry3pF
	Z5K348Kr4Fgr4j9rsIqa1j9wnIyr4DGw1fKFs2yrWFvwnrX393Kr1F9ayv9F1Y9r4ktrWY
	qryIvrWrK3y8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Just like commit 9087c6ff8dfe ("bpf: Call maybe_wait_bpf_programs() only
once from generic_map_delete_batch()"), there is also no need to call
maybe_wait_bpf_programs() for each update in batched update, so only
call it once in generic_map_update_batch().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 71d869f74236..9d9bb82e6062 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -203,7 +203,6 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 		rcu_read_unlock();
 	}
 	bpf_enable_instrumentation();
-	maybe_wait_bpf_programs(map);
 
 	return err;
 }
@@ -1561,6 +1560,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 	}
 
 	err = bpf_map_update_value(map, f.file, key, value, attr->flags);
+	maybe_wait_bpf_programs(map);
 
 	kvfree(value);
 free_key:
@@ -1800,6 +1800,8 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 
 	kvfree(value);
 	kvfree(key);
+
+	maybe_wait_bpf_programs(map);
 	return err;
 }
 
-- 
2.29.2


