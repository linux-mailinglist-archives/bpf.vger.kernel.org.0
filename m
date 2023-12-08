Return-Path: <bpf+bounces-17131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70180A08D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF84A1C20C74
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51D14ABF;
	Fri,  8 Dec 2023 10:23:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8DE1723
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 02:22:55 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SmnJm0HGnz4f3lfj
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CE6981A04FC
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxF57nJlY85LDA--.46390S7;
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
Subject: [PATCH bpf-next 3/7] bpf: Add missed maybe_wait_bpf_programs() for htab of maps
Date: Fri,  8 Dec 2023 18:23:51 +0800
Message-Id: <20231208102355.2628918-4-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCnqxF57nJlY85LDA--.46390S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4DJr45uFy5uw4xKw43GFg_yoW8GF13pF
	ZYg34UCr40gr129rsxXa109F43Ar4DKw13tw4kK34Svr4UZrWkKr1F9ayF9F1a9r97t3yY
	qr4ftFWSq3yUCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When doing batched lookup and deletion operations on htab of maps,
maybe_wait_bpf_programs() is needed to ensure all programs don't use the
inner map after the bpf syscall returns.

Instead of adding the wait in __htab_map_lookup_and_delete_batch(),
adding the wait in bpf_map_do_batch() and also removing the calling of
maybe_wait_bpf_programs() from generic_map_{delete,update}_batch().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9d9bb82e6062..47a7c8786e70 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1742,7 +1742,6 @@ int generic_map_delete_batch(struct bpf_map *map,
 
 	kvfree(key);
 
-	maybe_wait_bpf_programs(map);
 	return err;
 }
 
@@ -1801,7 +1800,6 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	kvfree(value);
 	kvfree(key);
 
-	maybe_wait_bpf_programs(map);
 	return err;
 }
 
@@ -4959,8 +4957,10 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	else
 		BPF_DO_BATCH(map->ops->map_delete_batch, map, attr, uattr);
 err_put:
-	if (has_write)
+	if (has_write) {
+		maybe_wait_bpf_programs(map);
 		bpf_map_write_active_dec(map);
+	}
 	fdput(f);
 	return err;
 }
-- 
2.29.2


