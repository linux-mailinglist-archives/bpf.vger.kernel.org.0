Return-Path: <bpf+bounces-14420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0958E7E4174
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 15:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1351C20BFC
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF73158E;
	Tue,  7 Nov 2023 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B830F95
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 14:06:00 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B046F3
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:05:59 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SPqkS3QnSz4f3m7W
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3F5251A0170
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhA_REpl+VkmAQ--.3051S10;
	Tue, 07 Nov 2023 22:05:56 +0800 (CST)
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
Subject: [PATCH bpf 06/11] bpf: Add bpf_map_of_map_fd_sys_lookup_elem() helper
Date: Tue,  7 Nov 2023 22:06:57 +0800
Message-Id: <20231107140702.1891778-7-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDHyhA_REpl+VkmAQ--.3051S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1rWrW8XF4fKFW5Wr4Durg_yoW8Gr1xpF
	yrtry8WrW0qr4DX3y5Xa1kurW5tw1fW3yUG3WDGa4Fyr1DWr97Ww18XFZFqF1Yqr4jkrZY
	v347KryrK34kArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

bpf_map_of_map_fd_sys_lookup_elem() returns the map id as the value for
map-in-map. It will be used when userspace applications do lookup
operations for map-in-map.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/map_in_map.c | 6 ++++++
 kernel/bpf/map_in_map.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 96e32f4167c4e..3cd08e7fb86e6 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -190,3 +190,9 @@ void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
 	else
 		bpf_inner_map_element_free_rcu(&element->rcu);
 }
+
+u32 bpf_map_of_map_fd_sys_lookup_elem(void *ptr)
+{
+	rcu_read_lock_held();
+	return ((struct bpf_inner_map_element *)ptr)->map->id;
+}
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index 8d38496e5179b..4a0d66757a065 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -22,5 +22,6 @@ u32 bpf_map_fd_sys_lookup_elem(void *ptr);
 
 void *bpf_map_of_map_fd_get_ptr(struct bpf_map *map, struct file *map_file, int ufd);
 void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer);
+u32 bpf_map_of_map_fd_sys_lookup_elem(void *ptr);
 
 #endif
-- 
2.29.2


