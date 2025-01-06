Return-Path: <bpf+bounces-47923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C8DA02047
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7051885176
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00941D95A3;
	Mon,  6 Jan 2025 08:07:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBD1D8DE0;
	Mon,  6 Jan 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150826; cv=none; b=L3Nl3JjwJ3mKR2qWIoy5uyKQn/pwGVTn6pYwb/RVrC9zJghR8R/9lCduYAKoqS25UvolxuOtRYl/JJzjmilC0WHqrO7eJo51rbVGelkFjY3F4fOLLy5F5fi+BnMEiA8tJEYWQFXYdTP7o0e1RANLo2rCxMCysdO7O5egn47jglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150826; c=relaxed/simple;
	bh=0uqOBEj3rl9AfX02y+nWxuJuK85j8pOzj5mUXULVNqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYrmmTuBdw4+bZLIU4NEgl7jgI7F++dbXT0JnCCDoSOtgqKMZrb5bJDotiEXDgdVJsaSR7WVwK+iMZ7hU3NiXzzmX+vN5/0dGcqZA6EhMkMl8nnrFG5xwoZd7SV74OXTK9pPgcSnUO+rQFWd3vIM9kfr0G4YVZv4JqJhH1GinWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRRbK6dwHz4f3l24;
	Mon,  6 Jan 2025 16:06:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 371971A0E6A;
	Mon,  6 Jan 2025 16:06:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S12;
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
Subject: [PATCH bpf-next 08/19] bpf: Disable migration when cloning sock storage
Date: Mon,  6 Jan 2025 16:18:49 +0800
Message-Id: <20250106081900.1665573-9-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S12
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrWw4DuF1kKFy7Jry8uFg_yoW8XFW8pF
	97JrnxJrWUX3y8ursrJ3Z3Cr1UZwsYgFy7Krs5Aw1fZrsaqF95G39akF10vFy3u3y0vryf
	XwnIqF98Cwn7Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

bpf_sk_storage_clone() will call bpf_selem_free() to free the clone
element when the allocation of new sock storage fails. bpf_selem_free()
will call check_and_free_fields() to free the special fields in the
element. Since the allocated element is not visible to bpf syscall or
bpf program when bpf_local_storage_alloc() fails, these special fields
in the element must be all zero when invoking bpf_selem_free().

To be uniform with other callers of bpf_selem_free(), disabling
migration when cloning sock storage. Adding migrate_{disable|enable}
pair also benefits the potential switching from kzalloc to bpf memory
allocator for sock storage.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 net/core/bpf_sk_storage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index aa536ecd5d39..7d41cde1bcca 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -161,6 +161,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
 
+	migrate_disable();
 	rcu_read_lock();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 
@@ -213,6 +214,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 
 out:
 	rcu_read_unlock();
+	migrate_enable();
 
 	/* In case of an error, don't free anything explicitly here, the
 	 * caller is responsible to call bpf_sk_storage_free.
-- 
2.29.2


