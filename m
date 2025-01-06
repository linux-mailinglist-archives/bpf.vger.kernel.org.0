Return-Path: <bpf+bounces-47934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA83A0205F
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0203A5136
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE461DC982;
	Mon,  6 Jan 2025 08:07:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE11DA636;
	Mon,  6 Jan 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150836; cv=none; b=FL1vGKY91lsNEt0rMPbAw1+A238KDHT4XXGBHnm0hRug614junXPkCeLDGiEHJlfHM9fh+ZpZ/gujnUQyby8iOWa/V5ObLtcRohYU80Fi6MYV2PJV77DUJPScNz7Fa4YxoVsNxDowiwQwZ26pmjfsfI2s+L4+2OmplYqzliGNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150836; c=relaxed/simple;
	bh=3Sz+ywtkER1M9h387/qHdktL3V9OGGrTpmLyuJjOW4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEtb9WyL3mBjGEGCNpjvEeJSDvCtpU7EJhV+hK62j3K1lYRP2gqTVEyGoQXqBy1WCfsazuozLw28geV1SVvUCf0DsUlqYU/9VrmtH6NMe2SaJIm55WfKrqtYyXSJ+oPIV9Qn1qQSbgkOQPCHpkowaInhwf4lckPNygnSn1Nyiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRRbZ0Jnxz4f3jss;
	Mon,  6 Jan 2025 16:06:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 005A91A14E0;
	Mon,  6 Jan 2025 16:07:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S21;
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
Subject: [PATCH bpf-next 17/19] bpf: Remove migrate_{disable|enable} from bpf_local_storage_alloc()
Date: Mon,  6 Jan 2025 16:18:58 +0800
Message-Id: <20250106081900.1665573-18-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S21
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4rJw48AF4xXr13Cw18uFg_yoW8JFyDpF
	Z7Kr1rCrWYqa1rZa9rJF4fAry5Gw1fWr12kws8ZrySqrsxZr95Ww1xK3W2va43Jryjqr4f
	ZFyYgF1j9r1DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

These two callers of bpf_local_storage_alloc() are the same as
bpf_selem_alloc(): bpf_sk_storage_clone() and
bpf_local_storage_update(). The running contexts of these two callers
have already disabled migration, therefore, there is no need to add
extra migrate_{disable|enable} pair in bpf_local_storage_alloc(). Also
add a cant_migrate() check in bpf_local_storage_alloc() to ensure such
guarantee will not be broken.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_local_storage.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index fd48a2a17ccd..0970766278f7 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -500,15 +500,13 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		return err;
 
-	if (smap->bpf_ma) {
-		migrate_disable();
+	cant_migrate();
+
+	if (smap->bpf_ma)
 		storage = bpf_mem_cache_alloc_flags(&smap->storage_ma, gfp_flags);
-		migrate_enable();
-	} else {
+	else
 		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
 					  gfp_flags | __GFP_NOWARN);
-	}
-
 	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
-- 
2.29.2


