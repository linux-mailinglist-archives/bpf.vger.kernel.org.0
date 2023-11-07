Return-Path: <bpf+bounces-14418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D097E4172
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 15:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9323D1C20CD0
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2E30FB4;
	Tue,  7 Nov 2023 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350330F90
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 14:06:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27FC2
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:05:58 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPqkT173vz4f3kjT
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3556D1A0176
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhA_REpl+VkmAQ--.3051S6;
	Tue, 07 Nov 2023 22:05:54 +0800 (CST)
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
Subject: [PATCH bpf 02/11] bpf: Reduce the scope of rcu_read_lock when updating fd map
Date: Tue,  7 Nov 2023 22:06:53 +0800
Message-Id: <20231107140702.1891778-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDHyhA_REpl+VkmAQ--.3051S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4kuF1DGFyDKr1fKrykZrb_yoW8ZFWfp3
	95CFy7Kw4Fq3ZF9w1avan29rWUGw15J3yUZFWkJrWrAF17Xrnagr17tas3XFyayFnrArWr
	Xa4ava9Ykw4UXrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
callbacks.

For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't need
rcu-read-lock because array->ptrs will not be freed until the map-in-map
is released. For bpf_fd_htab_map_update_elem(), htab_map_update_elem()
requires rcu-read-lock to be held, so only use rcu_read_lock() during
the invocation of htab_map_update_elem().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 2 ++
 kernel/bpf/syscall.c | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index fd8d4b0addfca..7d1457360c99b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2523,7 +2523,9 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
 
+	rcu_read_lock();
 	ret = htab_map_update_elem(map, key, &ptr, map_flags);
+	rcu_read_unlock();
 	if (ret)
 		map->ops->map_fd_put_ptr(ptr);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a144eb286974b..696b1af8cecbd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -180,15 +180,11 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 		err = bpf_percpu_cgroup_storage_update(map, key, value,
 						       flags);
 	} else if (IS_FD_ARRAY(map)) {
-		rcu_read_lock();
 		err = bpf_fd_array_map_update_elem(map, map_file, key, value,
 						   flags);
-		rcu_read_unlock();
 	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
-		rcu_read_lock();
 		err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
 						  flags);
-		rcu_read_unlock();
 	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
 		/* rcu_read_lock() is not needed */
 		err = bpf_fd_reuseport_array_update_elem(map, key, value,
-- 
2.29.2


