Return-Path: <bpf+bounces-19885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8283279E
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB5D1C234A9
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEC3CF6D;
	Fri, 19 Jan 2024 10:24:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FE3CF4A
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659879; cv=none; b=KxWOQaIUIkKkYbw7NxhZsbgwQzw+gUgD8Pt1HCXSXbPenK5SUNgOeBZWmj6PkbsHjOCuV4osTjT5SdTYx0YnDlWTYFm0ZPenW4QwebM5JLlnPZqyKLTDDbBe8fYXGgAaUZ8C89EgVzwq9vVH4jhstmlM6yRr8t8Mi+nnMTEYTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659879; c=relaxed/simple;
	bh=hhuQUlrtgt7WMCw+BGqZQ5IcsFFMEVtAHZ6YJNERvHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zy7kCVOHnqGK6IfmVIw3HeVeRUloorxrf+77M8wwzuNXHNMS2x7DkR12d7B5mv4KtEvUtDOa7Qw1Wubv9nt0Z/B1YgVHP+ZdRSFJILbHhXX8FVV9qaqGh0wqIEJOiqlUhwcgFkYtT7zz05/ku9mjnWTj4Ej7vdwK3Li2JO4hrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TGbMN0Pvvz4f3kKt
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 18:24:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 42F2A1A027B
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 18:24:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHfTapl+I07BQ--.50408S5;
	Fri, 19 Jan 2024 18:24:34 +0800 (CST)
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
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 1/2] bpf, arm64: Enable the inline of bpf_kptr_xchg()
Date: Fri, 19 Jan 2024 18:25:28 +0800
Message-Id: <20240119102529.99581-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240119102529.99581-1-houtao@huaweicloud.com>
References: <20240119102529.99581-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBHfTapl+I07BQ--.50408S5
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4DCw17uFWxZFWkCr43GFg_yoWfWrc_Jr
	n7Xa4xGw1Fyw12vFyqyFy5Grya93yrWFn3Xrn2grnrAr13Xa1rAFWvyr9ag348Gr9I9rW3
	W397Za4Svw4akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

ARM64 bpf jit satisfies the following two conditions:
1) support BPF_XCHG() on pointer-sized word.
2) the implementation of xchg is the same as atomic_xchg() on
   pointer-sized words. Both of these two functions use arch_xchg() to
   implement the exchange.

So enable the inline of bpf_kptr_xchg() for arm64 bpf jit.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8955da5c47cf7..cfd5434de4832 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2305,3 +2305,8 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 
 	return ret;
 }
+
+bool bpf_jit_supports_ptr_xchg(void)
+{
+	return true;
+}
-- 
2.29.2


