Return-Path: <bpf+bounces-47922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C3A02045
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0735A3A4451
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3BF1D6DB6;
	Mon,  6 Jan 2025 08:07:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA451D89E9;
	Mon,  6 Jan 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150824; cv=none; b=VPA9NZnJKpUPbdAhfr2hOLrkeplHJnvkWYWGSmA7hrpXhgC+XS0PC/Zk6RP2q7BIkiYpLaGQM5Wp+huKQhJZhbfKJVYg/HDkxo3IjZSUVvjcfJeF4kqreh4W8sN7L/K0PPAD/1tHcn0vJKQA5ZbannJxwdYqacsRtTLioWWbAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150824; c=relaxed/simple;
	bh=YAPIROEdzONLKsIk4ln7bhwVdLen2GWMJhowmUoGVxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMevcMfg7HDlXENOHSbmPM3tSNn4Jwwfca9Y3Rd2MFrtQrqzfn+M+CpjUXIzq7o9VqvOBSUjxRAzL91IYK4OMJVDw09kBtrcTnKIVbRcIoDg+k66ZF0/0SzeIESMMphFjEtrgzF3F0KrwnZ2PaXKRULCXZVkIASEe81cB9Akb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRRbR4HQ9z4f3jss;
	Mon,  6 Jan 2025 16:06:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 895F61A0E5C;
	Mon,  6 Jan 2025 16:06:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S11;
	Mon, 06 Jan 2025 16:06:58 +0800 (CST)
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
Subject: [PATCH bpf-next 07/19] bpf: Disable migration when destroying sock storage
Date: Mon,  6 Jan 2025 16:18:48 +0800
Message-Id: <20250106081900.1665573-8-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr13CFW5ZF17Xr1xCry8Krg_yoW8ArWDpF
	Z7tr9xKr4DX3yrursxJan3AryfAw4aga47K395Cw1Sqrs3XF98Gw1fCFnY9a43Aryvqryx
	Xwn0qF98Cr4xZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When destroying sock storage, it invokes bpf_local_storage_destroy() to
remove all storage elements saved in the sock storage. The destroy
procedure will call bpf_selem_free() to free the element, and
bpf_selem_free() calls bpf_obj_free_fields() to free the special fields
in map value (e.g., kptr). Since kptrs may be allocated from bpf memory
allocator, migrate_{disable|enable} pairs are necessary for the freeing
of these kptrs.

To simplify reasoning about when migrate_disable() is needed for the
freeing of these dynamically-allocated kptrs, let the caller to
guarantee migration is disabled before invoking bpf_obj_free_fields().
Therefore, the patch adds migrate_{disable|enable} pair in
bpf_sock_storage_free(). The migrate_{disable|enable} pairs in the
underlying implementation of bpf_obj_free_fields() will be removed by
The following patch.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 net/core/bpf_sk_storage.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 2f4ed83a75ae..aa536ecd5d39 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -50,15 +50,16 @@ void bpf_sk_storage_free(struct sock *sk)
 {
 	struct bpf_local_storage *sk_storage;
 
+	migrate_disable();
 	rcu_read_lock();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
-	if (!sk_storage) {
-		rcu_read_unlock();
-		return;
-	}
+	if (!sk_storage)
+		goto out;
 
 	bpf_local_storage_destroy(sk_storage);
+out:
 	rcu_read_unlock();
+	migrate_enable();
 }
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
-- 
2.29.2


