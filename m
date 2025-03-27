Return-Path: <bpf+bounces-54790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019FA72B57
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191681898654
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12A205506;
	Thu, 27 Mar 2025 08:23:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B82054ED
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063781; cv=none; b=EF59jvvbnthTHPsE8WmJVXvEEciyjQztEhUFPfc9yNw5uPFNnzI5r48NC90bdP1d54nnKs+ZBV9n4UOwNJSFgCPB/O7c7u9pkYg0bK88F7HrZ3PnNKkAjYOlo/RVJm96pAvDzQKoqidrZC9a4wZykWNQQ+5KER/DVVpRiUzpqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063781; c=relaxed/simple;
	bh=AEJO9vFVL52Kxhyeulyf7zWvLcIZD4OL/9top033pw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKdTVmgcxgXjAtCjQIzwBdA/DEWK4aGCOtOOuOjaS18T5w7LMrq+tAWI//S13XwRhFumCENIIBaEjhtTxgBjTTfOjzReuEKmbJ0nxNM7+cCd1nJWt3WLNLxfvT0txyhAV3CbMPwklOL65wh2mjtwz8bNxFFKlLPYfn+xviK1Cf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8v1qQ0z4f3jtP
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CF7611A0E96
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S14;
	Thu, 27 Mar 2025 16:22:56 +0800 (CST)
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
Subject: [PATCH bpf-next v3 10/16] bpf: Export bpf_dynptr_set_size
Date: Thu, 27 Mar 2025 16:34:49 +0800
Message-Id: <20250327083455.848708-11-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S14
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw18tF15tFWrWrWUKrW3Wrg_yoW8Gw13pF
	ykC34xXr48tFZ2qw4UJFsavw4Ykay7Wr17GFykt34rursFqF9I9r1jgry7Kr98t3ykCr43
	Ar92grWFvry8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

It will be used by the following patch to shrink the size of dynptr when
the actual data length is smaller than the size of dynptr during
map_get_next_key operation.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h  | 1 +
 kernel/bpf/helpers.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 737890e5c58b4..4f4b43b68f8d1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1361,6 +1361,7 @@ enum bpf_dynptr_type {
 };
 
 int bpf_dynptr_check_size(u32 size);
+void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
 void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ddaa41a70676c..67c13a6d20dae 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1688,7 +1688,7 @@ u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
 
-static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size)
+void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size)
 {
 	u32 metadata = ptr->size & ~DYNPTR_SIZE_MASK;
 
-- 
2.29.2


