Return-Path: <bpf+bounces-41216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7C9943D3
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417D0B29607
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111E21C243E;
	Tue,  8 Oct 2024 09:05:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32AA1BFE1F
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378312; cv=none; b=VeWQKu/M0lB2ZlyT9xdzBcfS75Z70HXAsDdw4hIL6CQ3QmIUOKVWTDqIuc51SpvU/M1N0t+70HXaSFnRQowp/vlLy1qa4W+D0nlVp3BtlwFmUN/zp8fLb/KgYKlImr+A/XhOoBzxFGel/AjGNMX2wqahQtNZ+7aSz1q2N6eTJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378312; c=relaxed/simple;
	bh=+6Ltg0zFxYHrwKKCk5DE/LnyAaRZQloQdIxucdErGDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwLOW1uRSTnxs+the7VPdxNd8zp2LNZGdfUw/tIk/zt9Ts6OECBNh1JWdJkE/nsOIFiosKyhKOENpk+67O68KXJwAgVyTw6ofYHgHh8bFI+fXJ/MyTa7YebpeZ7gXahTm1ZT769AWxEsU9skn1S0ky7RU5tFK1+4k5sFUlmhWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XN98319M6z4f3jcx
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:04:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EF1621A018D
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:05:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3yobB9QRnm_6TDQ--.2069S5;
	Tue, 08 Oct 2024 17:05:07 +0800 (CST)
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
Subject: [PATCH bpf 1/7] bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
Date: Tue,  8 Oct 2024 17:17:12 +0800
Message-Id: <20241008091718.3797027-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241008091718.3797027-1-houtao@huaweicloud.com>
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3yobB9QRnm_6TDQ--.2069S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17ur1DXF48ur47CF45Wrg_yoW8Wr17pF
	n8CrsrGw4UuayUZryYyFWIvry8Wa1Uur1UKrZ8Wr1jva4S9F1kCF1kGrWUA3sagrZ7JFW7
	Jw1jkrZ3G3sxZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn
	pnQUUUUU=
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
 include/linux/bpf_types.h | 1 +
 include/uapi/linux/bpf.h  | 3 +++
 2 files changed, 4 insertions(+)

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
-- 
2.29.2


