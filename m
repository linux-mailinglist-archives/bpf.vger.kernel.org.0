Return-Path: <bpf+bounces-14421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17117E4175
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 15:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C65428125E
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FCA30F8F;
	Tue,  7 Nov 2023 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929E30F93
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 14:06:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C59B4
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:05:58 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPqkV4vsHz4f3kpF
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B7AA61A019A
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhA_REpl+VkmAQ--.3051S9;
	Tue, 07 Nov 2023 22:05:55 +0800 (CST)
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
Subject: [PATCH bpf 05/11] bpf: Add bpf_map_of_map_fd_{get,put}_ptr() helpers
Date: Tue,  7 Nov 2023 22:06:56 +0800
Message-Id: <20231107140702.1891778-6-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDHyhA_REpl+VkmAQ--.3051S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4xuw1fJr4fCry7Cr4Uurg_yoW5uryUpF
	WrKFW5C395XrW7WrW3Za1Dur98trn3W34DG3s3Ga4Yyr1jgr97WF1kZa42qr15Cr4DGrs3
	Zw13KryFg34kAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

bpf_map_of_map_fd_get_ptr() will convert the map fd to the pointer
saved in map-in-map. bpf_map_of_map_fd_put_ptr() will release the
pointer saved in map-in-map. These two helpers will be used by the
following patches to fix the use-after-free problems for map-in-map.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/map_in_map.c | 51 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/map_in_map.h | 11 +++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 8323ce201159d..96e32f4167c4e 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -4,6 +4,7 @@
 #include <linux/slab.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/rcupdate.h>
 
 #include "map_in_map.h"
 
@@ -139,3 +140,53 @@ u32 bpf_map_fd_sys_lookup_elem(void *ptr)
 {
 	return ((struct bpf_map *)ptr)->id;
 }
+
+void *bpf_map_of_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
+			       int ufd)
+{
+	struct bpf_inner_map_element *element;
+	struct bpf_map *inner_map;
+
+	element = kmalloc(sizeof(*element), GFP_KERNEL);
+	if (!element)
+		return ERR_PTR(-ENOMEM);
+
+	inner_map = bpf_map_fd_get_ptr(map, map_file, ufd);
+	if (IS_ERR(inner_map)) {
+		kfree(element);
+		return inner_map;
+	}
+
+	element->map = inner_map;
+	return element;
+}
+
+static void bpf_inner_map_element_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_inner_map_element *elem = container_of(rcu, struct bpf_inner_map_element, rcu);
+
+	bpf_map_put(elem->map);
+	kfree(elem);
+}
+
+static void bpf_inner_map_element_free_tt_rcu(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		bpf_inner_map_element_free_rcu(rcu);
+	else
+		call_rcu(rcu, bpf_inner_map_element_free_rcu);
+}
+
+void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
+{
+	struct bpf_inner_map_element *element = ptr;
+
+	/* Do bpf_map_put() after a RCU grace period and a tasks trace
+	 * RCU grace period, so it is certain that the bpf program which is
+	 * manipulating the map now has exited when bpf_map_put() is called.
+	 */
+	if (need_defer)
+		call_rcu_tasks_trace(&element->rcu, bpf_inner_map_element_free_tt_rcu);
+	else
+		bpf_inner_map_element_free_rcu(&element->rcu);
+}
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index 63872bffd9b3c..8d38496e5179b 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -9,11 +9,18 @@
 struct file;
 struct bpf_map;
 
+struct bpf_inner_map_element {
+	struct bpf_map *map;
+	struct rcu_head rcu;
+};
+
 struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd);
 void bpf_map_meta_free(struct bpf_map *map_meta);
-void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
-			 int ufd);
+void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file, int ufd);
 void bpf_map_fd_put_ptr(void *ptr, bool need_defer);
 u32 bpf_map_fd_sys_lookup_elem(void *ptr);
 
+void *bpf_map_of_map_fd_get_ptr(struct bpf_map *map, struct file *map_file, int ufd);
+void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer);
+
 #endif
-- 
2.29.2


