Return-Path: <bpf+bounces-42554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4A59A5889
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C2A1C20C70
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 01:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC41773A;
	Mon, 21 Oct 2024 01:28:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE61BC3C
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474087; cv=none; b=K4iANsOIKi23WGJFJ9GDxK8ng9+KkukY2K9FYueI9ZGowfi77NHYSOC4pulfgjSehqncmuL25dmBUn49DUiKWRi39R1O9i6JxU18RwtoRysCVRA0s4prx4/OmZJzFNl8AaWoqNhXKIN3H5GGyhuBOWoB7kGXskoEWSgnMOUTlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474087; c=relaxed/simple;
	bh=rYd6E700QVt5zoc/9RmdM7o5Aj0Fx9iEt1yb+w4iAAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpOropF1AN0hqYz6uDESNVxGziIDdKPR0P1g/j32H5BKQCXYzalXOuTCdbi03cJRlI4zmRJTA1YLKYew51CE+5xBRagf0I3WszoaRsrKaO+wcwxymiVzMDHFx4Chwjt4+dSNNmfpadAfD5ZtXDCAQUOT1Yj+Q0vJGWaXkS/4fF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XWyNb1zgZz4f3jks
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7D35A1A0568
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYXrhVnot2wEg--.32425S5;
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
Subject: [PATCH bpf v2 1/7] bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
Date: Mon, 21 Oct 2024 09:39:58 +0800
Message-Id: <20241021014004.1647816-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYXrhVnot2wEg--.32425S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17ur1DXF48ur47ArWfGrg_yoW8uw1UpF
	n5ArsrCr4UuayUZryYkFWIvry8Ww4Uur1UK398Wr1jva4Sva4kCF4kGrWUAF9ag3ykAF4x
	Jw1jkrZ3G3s8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

There is an out-of-bounds read in bpf_link_show_fdinfo() for the sockmap
link fd. Fix it by adding the missing BPF_LINK_TYPE invocation for
sockmap link

Also add comments for bpf_link_type to prevent missing updates in the
future.

Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb progs")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_types.h      | 1 +
 include/uapi/linux/bpf.h       | 3 +++
 tools/include/uapi/linux/bpf.h | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 9f2a6b83b49e..fa78f49d4a9a 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -146,6 +146,7 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
+BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
 #endif
 #ifdef CONFIG_PERF_EVENTS
 BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e8241b320c6d..4a939c90dc2e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1121,6 +1121,9 @@ enum bpf_attach_type {
 
 #define MAX_BPF_ATTACH_TYPE __MAX_BPF_ATTACH_TYPE
 
+/* Add BPF_LINK_TYPE(type, name) in bpf_types.h to keep bpf_link_type_strs[]
+ * in sync with the definitions below.
+ */
 enum bpf_link_type {
 	BPF_LINK_TYPE_UNSPEC = 0,
 	BPF_LINK_TYPE_RAW_TRACEPOINT = 1,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e8241b320c6d..4a939c90dc2e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1121,6 +1121,9 @@ enum bpf_attach_type {
 
 #define MAX_BPF_ATTACH_TYPE __MAX_BPF_ATTACH_TYPE
 
+/* Add BPF_LINK_TYPE(type, name) in bpf_types.h to keep bpf_link_type_strs[]
+ * in sync with the definitions below.
+ */
 enum bpf_link_type {
 	BPF_LINK_TYPE_UNSPEC = 0,
 	BPF_LINK_TYPE_RAW_TRACEPOINT = 1,
-- 
2.29.2


