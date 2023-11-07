Return-Path: <bpf+bounces-14425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9097E4178
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 15:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8070D1C20A3A
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C5430FB5;
	Tue,  7 Nov 2023 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B030FAF
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 14:06:02 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4CDB3
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:06:00 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPqkX58vcz4f3knv
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C08711A0181
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhA_REpl+VkmAQ--.3051S13;
	Tue, 07 Nov 2023 22:05:57 +0800 (CST)
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
Subject: [PATCH bpf 09/11] bpf: Remove unused helpers for map-in-map
Date: Tue,  7 Nov 2023 22:07:00 +0800
Message-Id: <20231107140702.1891778-10-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231107140702.1891778-1-houtao@huaweicloud.com>
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhA_REpl+VkmAQ--.3051S13
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47tr17tryfAw4UCFyfZwb_yoW5JrWrpF
	yftryxGrW0qr4UWrW5Xa1UZr98tF17W34DG3s5Ga4Fvr1qgr9ruF1kXayxWF15GrWDGrZ3
	AryxKryFk3s7ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

bpf_map_fd_put_ptr() and bpf_map_fd_sys_lookup_elem() are no longer used
for map-in-map, so just remove these two helpers. bpf_map_fd_get_ptr()
is only used internally, so make it be static.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/map_in_map.c | 19 ++-----------------
 kernel/bpf/map_in_map.h |  3 ---
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 3cd08e7fb86e6..372e89edc2d57 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -106,9 +106,7 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 		btf_record_equal(meta0->record, meta1->record);
 }
 
-void *bpf_map_fd_get_ptr(struct bpf_map *map,
-			 struct file *map_file /* not used */,
-			 int ufd)
+static void *bpf_map_fd_get_ptr(struct bpf_map *map, int ufd)
 {
 	struct bpf_map *inner_map, *inner_map_meta;
 	struct fd f;
@@ -128,19 +126,6 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 	return inner_map;
 }
 
-void bpf_map_fd_put_ptr(void *ptr, bool deferred)
-{
-	/* ptr->ops->map_free() has to go through one
-	 * rcu grace period by itself.
-	 */
-	bpf_map_put(ptr);
-}
-
-u32 bpf_map_fd_sys_lookup_elem(void *ptr)
-{
-	return ((struct bpf_map *)ptr)->id;
-}
-
 void *bpf_map_of_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
 			       int ufd)
 {
@@ -151,7 +136,7 @@ void *bpf_map_of_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
 	if (!element)
 		return ERR_PTR(-ENOMEM);
 
-	inner_map = bpf_map_fd_get_ptr(map, map_file, ufd);
+	inner_map = bpf_map_fd_get_ptr(map, ufd);
 	if (IS_ERR(inner_map)) {
 		kfree(element);
 		return inner_map;
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index f8719bcd7c254..903eb33896723 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -19,9 +19,6 @@ struct bpf_inner_map_element {
 
 struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd);
 void bpf_map_meta_free(struct bpf_map *map_meta);
-void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file, int ufd);
-void bpf_map_fd_put_ptr(void *ptr, bool need_defer);
-u32 bpf_map_fd_sys_lookup_elem(void *ptr);
 
 void *bpf_map_of_map_fd_get_ptr(struct bpf_map *map, struct file *map_file, int ufd);
 void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer);
-- 
2.29.2


