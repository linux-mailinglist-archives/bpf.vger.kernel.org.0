Return-Path: <bpf+bounces-39677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB30975E7E
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 03:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21662853BB
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 01:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78013262A3;
	Thu, 12 Sep 2024 01:28:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648CF2A1D3
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104525; cv=none; b=jTlYeZOpueqetNOXQTHewIM30B0kOsb1q4+5iYErDBIYsul7CcUejwUPxyOqDmiwrcMnoUlJNAEupDRWVK1xNsYMXC4MXDzHDs40uSzjVygBiR/oyFZp4XNKC7OWYu4swmWYEtQKKD22y2vmQY2i2v27txoJaIiTzGnLAYwg3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104525; c=relaxed/simple;
	bh=XaY+pOjvOOAxSTZoP9+9M6SOp4bXuqT8YKmQZHEI72U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DfBbayZALS3ZpYgTwwJ9IWkeKzy/KVjvm5w6QKXjp4MT8FSeC4VxCDhG2jdd/QiPbrREbjcdHz1ttcFw9oFy0DcdldjaYOKBK+hu17dgPxcVfUZP+HDuJx7fte0l2ge4hGgDM8P4Dz4vzpNg1iYoMAbY8sNWEiYQVX36aJQ1hI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X40FT3Z7Rz4f3jkT
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:28:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 296AA1A0359
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:28:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysbFQ+JmOHBLBA--.63562S5;
	Thu, 12 Sep 2024 09:28:39 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 1/2] bpf: Call the missed btf_record_free() when map creation fails
Date: Thu, 12 Sep 2024 09:28:44 +0800
Message-Id: <20240912012845.3458483-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240912012845.3458483-1-houtao@huaweicloud.com>
References: <20240912012845.3458483-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysbFQ+JmOHBLBA--.63562S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1DXr48tFWxZryxCF1rZwb_yoW8tw1xpF
	sxtF10kr48XF4UurZxXa1Yga4akrWfW34j934kGa4FkrW3Wr9Fy3WIvFy7uFy5CFWkJ3y7
	ZrsrK348JrW0yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jqYL9U
	UUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When security_bpf_map_create() in map_create() fails, map_create() will
call btf_put() and ->map_free() callback to free the map. It doesn't
free the btf_record of map value, so add the missed btf_record_free()
when map creation fails.

However btf_record_free() needs to be called after ->map_free() just
like bpf_map_free_deferred() did, because ->map_free() may use the
btf_record to free the special fields in preallocated map value. So
factor out bpf_map_free() helper to free the map, btf_record, and btf
orderly and use the helper in both map_create() and
bpf_map_free_deferred().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6988e432fc3d..1a0dc1d81118 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -735,15 +735,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 	}
 }
 
-/* called from workqueue */
-static void bpf_map_free_deferred(struct work_struct *work)
+static void bpf_map_free(struct bpf_map *map)
 {
-	struct bpf_map *map = container_of(work, struct bpf_map, work);
 	struct btf_record *rec = map->record;
 	struct btf *btf = map->btf;
 
-	security_bpf_map_free(map);
-	bpf_map_release_memcg(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
 	/* Delay freeing of btf_record for maps, as map_free
@@ -762,6 +758,16 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	btf_put(btf);
 }
 
+/* called from workqueue */
+static void bpf_map_free_deferred(struct work_struct *work)
+{
+	struct bpf_map *map = container_of(work, struct bpf_map, work);
+
+	security_bpf_map_free(map);
+	bpf_map_release_memcg(map);
+	bpf_map_free(map);
+}
+
 static void bpf_map_put_uref(struct bpf_map *map)
 {
 	if (atomic64_dec_and_test(&map->usercnt)) {
@@ -1413,8 +1419,7 @@ static int map_create(union bpf_attr *attr)
 free_map_sec:
 	security_bpf_map_free(map);
 free_map:
-	btf_put(map->btf);
-	map->ops->map_free(map);
+	bpf_map_free(map);
 put_token:
 	bpf_token_put(token);
 	return err;
-- 
2.29.2


