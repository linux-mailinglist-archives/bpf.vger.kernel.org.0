Return-Path: <bpf+bounces-54106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C912EA62E6E
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE49175294
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B487A1F9428;
	Sat, 15 Mar 2025 14:50:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809019F130
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050239; cv=none; b=HKF9rALSRRQ2AYWGvPFnMqtipoazHTMQrEvv98sGyifkiOjOk/L392Tkj1jCJFcG1VyeDTP7edYuaet2FcxL9IojQ4FsdoKk2cb57t20WGrdfum4nj9PBfJDb3BVxnldpYZlc0LbGEnaP9pYmDagHnVIQUprA9rV4YZsISprkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050239; c=relaxed/simple;
	bh=42bNIk/iYU8zEwvBMDZcgwwH5YwzGYQDnq0GxeLRRls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ob/NzEeQ16s0CZes74fpl0O4IPqfu38EcixCgIZ3r8R8OECDD+HITmpSOlbUvVan7KVFlwXaXYB9L6Fzu5gunRPpbTSeCFsZGr4nwuj1fZ+1cUEJ53az6Prr1XjXldGDrwTYrzIO4T4ltXvKznY7nekXpZWgGHj9soa13+KzkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZFPKZ1KgSz4f3jRD
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 22:50:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AE9161A0CC6
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 22:50:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2C2k9VnSVpPGg--.17264S4;
	Sat, 15 Mar 2025 22:50:32 +0800 (CST)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next] bpf: Check map->record at the begin of check_and_free_fields()
Date: Sat, 15 Mar 2025 23:02:39 +0800
Message-Id: <20250315150239.1505137-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2C2k9VnSVpPGg--.17264S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtryrXry3ZrWrJw18uF1rWFg_yoWfuwc_K3
	y0qFn5Krs7CwsagryUGFs3WryxGry8KFWvvr4qqrZrtFy5X3WFyw1xZF98ZFyDJwsrJFZx
	XasIgF9rK34fJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When there is no special field in the map value, there is no need to
invoke bpf_obj_free_fields(). Therefore, checking the validity of
map->record in advance.

After the change, the benchmark result of per-cpu update case in
map_perf_test increase 30%+.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6527e9ce83cd9..2623970175dcf 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -906,6 +906,9 @@ static void htab_free_dynptr_key(struct bpf_htab *htab, void *key)
 static void check_and_free_fields(struct bpf_htab *htab,
 				  struct htab_elem *elem)
 {
+	if (IS_ERR_OR_NULL(htab->map.record))
+		return;
+
 	if (htab_is_percpu(htab)) {
 		void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
 		int cpu;
-- 
2.29.2


