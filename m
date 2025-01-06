Return-Path: <bpf+bounces-47930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A6A02057
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF541639CE
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49B31D9663;
	Mon,  6 Jan 2025 08:07:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCC1D9A62;
	Mon,  6 Jan 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150831; cv=none; b=GO3Yr0UfP7XeGDE25jlVS6n+dvFgAVc+EAo6jOst2bkpk7wPbC3wgLe+YqK1QEkObHZe54h9ZNGu74cN9cmeOfKqLV62wD1jW4tQ99eFIZnwNtpWk65VUOHsdZoLF4uuQ+p2tLd+weq4FjeD8MdwXdKPGitbBrFReDYIS8lnYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150831; c=relaxed/simple;
	bh=TtbJg5fLauKt2HphBxYSqr/z/j8GJ/RNAz5tbdjYhp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TCOhZMGSAKViU9GM6H3+aJ4ZZk+9FEyxFvnyt0eFI668/lWtU71mV1pZ+H9eThqmxRgZMNIM8WgQWmF8xIsQHxHfuVxReo6rXDiFbMCDFsgr/RpOOS2kyVj3g6AU9Tp2kLwo1mUiq7DHrkCrdQLW71dH/PpHHFgKqzQbdvWEdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YRRbS1tzfz4f3jd2;
	Mon,  6 Jan 2025 16:06:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5D0CB1A0E87;
	Mon,  6 Jan 2025 16:07:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S20;
	Mon, 06 Jan 2025 16:07:04 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 16/19] bpf: Remove migrate_{disable|enable} from bpf_selem_alloc()
Date: Mon,  6 Jan 2025 16:18:57 +0800
Message-Id: <20250106081900.1665573-17-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250106081900.1665573-1-houtao@huaweicloud.com>
References: <20250106081900.1665573-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S20
X-Coremail-Antispam: 1UD129KBjvJXoW7CrykWF45uw48KFy7uw45Wrg_yoW8Gw1UpF
	Z29r1Skr4rtayru3ZrXF4fAry5Jw48Wr12kw4kCrySvwsxXrn8Wr4xKF18Za45Jw4UXr4f
	ZF1ftF109a18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

bpf_selem_alloc() has two callers:
(1) bpf_sk_storage_clone_elem()
bpf_sk_storage_clone() has already disabled migration before invoking
bpf_sk_storage_clone_elem().

(2) bpf_local_storage_update()
Its callers include: cgrp/task/inode/sock storage ->map_update_elem()
callbacks and bpf_{cgrp|task|inode|sk}_storage_get() helpers. These
running contexts have already disabled migration

Therefore, there is no need to add extra migrate_{disable|enable} pair
in bpf_selem_alloc(). Also add a cant_migrate() check in
bpf_selem_alloc().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_local_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 12cf6382175e..fd48a2a17ccd 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -80,10 +80,10 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
+	cant_migrate();
+
 	if (smap->bpf_ma) {
-		migrate_disable();
 		selem = bpf_mem_cache_alloc_flags(&smap->selem_ma, gfp_flags);
-		migrate_enable();
 		if (selem)
 			/* Keep the original bpf_map_kzalloc behavior
 			 * before started using the bpf_mem_cache_alloc.
-- 
2.29.2


