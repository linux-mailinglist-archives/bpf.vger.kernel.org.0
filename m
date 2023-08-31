Return-Path: <bpf+bounces-9020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A4B78E482
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 03:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89421C208C9
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D8F136C;
	Thu, 31 Aug 2023 01:44:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654D10E1;
	Thu, 31 Aug 2023 01:44:03 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64012CD7;
	Wed, 30 Aug 2023 18:43:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RbkTj1r3sz4f3s6G;
	Thu, 31 Aug 2023 09:43:53 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgDHPSpb8O9kuZGDBw--.30099S2;
	Thu, 31 Aug 2023 09:43:56 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next] bpf, sockmap: Rename sock_map_get_from_fd to sock_map_prog_attach
Date: Thu, 31 Aug 2023 09:43:46 +0800
Message-Id: <20230831014346.2931397-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHPSpb8O9kuZGDBw--.30099S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3uw45KF48uF48WF1kuFg_yoW8ury3pF
	s8AF1UWrWrAFW2vFZ8Gw43Xa4xXF15Gw1Yka1DJa4fCrsFgrZ2gF1UKF42vr1Y9FW2k3yx
	ZanFgryvq3y8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6r
	W3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
	CTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

What function sock_map_get_from_fd does is to attach a bpf prog to
a sock map, so rename it to sock_map_prog_attach to make it more
readable.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h  | 2 +-
 kernel/bpf/syscall.c | 2 +-
 net/core/sock_map.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 12596af59c00..7a0c801f2795 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2799,7 +2799,7 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr);
 
-int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
+int sock_map_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
 int sock_map_bpf_prog_query(const union bpf_attr *attr,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ebeb0695305a..087a097d74d4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3822,7 +3822,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	switch (ptype) {
 	case BPF_PROG_TYPE_SK_SKB:
 	case BPF_PROG_TYPE_SK_MSG:
-		ret = sock_map_get_from_fd(attr, prog);
+		ret = sock_map_prog_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		ret = lirc_prog_attach(attr, prog);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 8f07fea39d9e..26706b667f44 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -57,7 +57,7 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 	return &stab->map;
 }
 
-int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog)
+int sock_map_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	u32 ufd = attr->target_fd;
 	struct bpf_map *map;
-- 
2.30.2


