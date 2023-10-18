Return-Path: <bpf+bounces-12561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D67CDA79
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 13:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8B7B21227
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566242EAFF;
	Wed, 18 Oct 2023 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123D200DE
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:32:43 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCD0197
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 04:32:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S9TGm1z0Rz4f3pG8
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 19:32:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnfd1Mwi9l9jYmDQ--.41845S9;
	Wed, 18 Oct 2023 19:32:35 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
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
	houtao1@huawei.com,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH bpf-next v2 5/7] bpf: Move the declaration of __bpf_obj_drop_impl() to bpf.h
Date: Wed, 18 Oct 2023 19:33:41 +0800
Message-Id: <20231018113343.2446300-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231018113343.2446300-1-houtao@huaweicloud.com>
References: <20231018113343.2446300-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnfd1Mwi9l9jYmDQ--.41845S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UJr43Jw4DCFW7JFW7twb_yoW8Zr4rpa
	nxAr1Ikr48tF4j93s8Wa1ru34agrW7Ww1aka4DGw1avr4SqryDZa1DKF1fuFy3trW0krs2
	vr1I9rWayry8ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

both syscall.c and helpers.c have the declaration of
__bpf_obj_drop_impl(), so just move it to a common header file.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h  | 1 +
 kernel/bpf/helpers.c | 2 --
 kernel/bpf/syscall.c | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4b40b45962b..ebd412179771 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2058,6 +2058,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec);
 bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
+void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
 
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 61f51dee8448..c67012d28e52 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1811,8 +1811,6 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	}
 }
 
-void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
-
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 341f8cb4405c..69998f84f7c8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -626,8 +626,6 @@ void bpf_obj_free_timer(const struct btf_record *rec, void *obj)
 	bpf_timer_cancel_and_free(obj + rec->timer_off);
 }
 
-extern void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
-
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 {
 	const struct btf_field *fields;
-- 
2.29.2


