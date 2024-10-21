Return-Path: <bpf+bounces-42553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA89A5888
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5470A28241C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 01:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C0515E96;
	Mon, 21 Oct 2024 01:28:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AD1C69A
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474087; cv=none; b=I4tjyVdH4PguFZaUHD7ngWFcvOTgI8wqigbVMyD61jyQu1LrCVU9tnI2SNHCur46miIXbfZraRilRjOKxGVv4IOCcEespIFu/FySNFJzR9Jeu4rreAxAKr1bN3eyWAa8zXCkhm16mVuSFgyM4pkAr0qkKgZ/Bvx4Oe3Vs9yBsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474087; c=relaxed/simple;
	bh=bwS2pmwg5O+sxjqVNk5Nbe0+9QivTFTOAfAWYpmJQfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmefLIp7uDVimhlHf9RbKCEzx38MezfRxkJbVsrxGu8kYRit5wE/P6acHyf1GYJFgN2Cu67bu7D72+RLQ1Br5x/Z/jCYoooDvPDjG/P1fZd+DDF1PwFvWgpeDZ+wiANIb3bD78EqK0i7o3Hvmu+C++nWDgxqYPNrGXjcN8sX5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XWyNV5njzz4f3jXv
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 252191A0568
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYXrhVnot2wEg--.32425S6;
	Mon, 21 Oct 2024 09:27:55 +0800 (CST)
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
	Yafang Shao <laoar.shao@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v2 2/7] bpf: Add assertion for the size of bpf_link_type_strs[]
Date: Mon, 21 Oct 2024 09:39:59 +0800
Message-Id: <20241021014004.1647816-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241021014004.1647816-1-houtao@huaweicloud.com>
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYXrhVnot2wEg--.32425S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWryUJw4UuFy3Xr43tr47Jwb_yoW5Wr45pF
	1rKr4DGw45uw47Xry3tFW29ryrGa1Uur1UtrWkWr1F934Svr4DCF18tFyUZ3sIgrWxKFy7
	Jw129rZ3A3sxZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

If a corresponding link type doesn't invoke BPF_LINK_TYPE(), accessing
bpf_link_type_strs[link->type] may result in out-of-bound access.

To prevent such missed invocations in the future, the following static
assertion seems feasible:

  BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) != __MAX_BPF_LINK_TYPE)

However, this doesn't work well. The reason is that the invocation of
BPF_LINK_TYPE() for one link type is optional due to its CONFIG_XXX
dependency and the elements in bpf_link_type_strs[] will be sparse. For
example, if CONFIG_NET is disabled, the size of bpf_link_type_strs will
be BPF_LINK_TYPE_UPROBE_MULTI + 1.

Therefore, in addition to the static assertion, remove all CONFIG_XXX
conditions for the invocation of BPF_LINK_TYPE(). If these CONFIG_XXX
conditions become necessary later, the fix may need to be revised (e.g.,
to check the validity of link_type in bpf_link_show_fdinfo()).

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_types.h | 6 ------
 kernel/bpf/syscall.c      | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fa78f49d4a9a..6b7eabe9a115 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -136,21 +136,15 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
-#ifdef CONFIG_CGROUP_BPF
 BPF_LINK_TYPE(BPF_LINK_TYPE_CGROUP, cgroup)
-#endif
 BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
-#ifdef CONFIG_NET
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
 BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
 BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
-#endif
-#ifdef CONFIG_PERF_EVENTS
 BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
-#endif
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
 BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8cfa7183d2ef..9f335c379b05 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3071,6 +3071,8 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 	const struct bpf_prog *prog = link->prog;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 
+	BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) != __MAX_BPF_LINK_TYPE);
+
 	seq_printf(m,
 		   "link_type:\t%s\n"
 		   "link_id:\t%u\n",
-- 
2.29.2


