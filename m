Return-Path: <bpf+bounces-42988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783719AD929
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 03:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C831C21B18
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E078D38DE9;
	Thu, 24 Oct 2024 01:23:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882B1B7F4
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733035; cv=none; b=sVI82D5qTTA6MQYY9wp4vQHHcwxe2X87Zrhi61jaFx1YgXnD/i+zl1nssYaWe9UpPuTkm2/wdlPKRegnY4R9NC9B8CDh70kxLwwk9LpPWp+etaw/5sd0NiI2yAvzi1CT6bWzU9LMef+MpRU5w05bnhmONDsvRZDu3Gi1hfK/HdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733035; c=relaxed/simple;
	bh=rYd6E700QVt5zoc/9RmdM7o5Aj0Fx9iEt1yb+w4iAAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qSe6JzKKXJougJp7aY8WIDMDCFVUHmY4ZbBrK6TD4xDl5IaakZu6izabaPgKv/bR+VX7n0/5dColeWe5EIXkgMkklyQjDL3A6horLAeGL2H5xzX4/vLi5SUGEm50jpDRnsqrZl7qQTg4/zgJz0O7L8vrJpy8ZdBrow2xTEvRIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XYp8N40CHz4f3jsf
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 09:23:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 068581A0568
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 09:23:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMihoRln4mXLEw--.33103S5;
	Thu, 24 Oct 2024 09:23:49 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
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
Subject: [PATCH bpf v3 1/2] bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
Date: Thu, 24 Oct 2024 09:35:57 +0800
Message-Id: <20241024013558.1135167-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241024013558.1135167-1-houtao@huaweicloud.com>
References: <20241024013558.1135167-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMihoRln4mXLEw--.33103S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17ur1DXF48ur47ArWfGrg_yoW8uw1UpF
	n5ArsrCr4UuayUZryYkFWIvry8Ww4Uur1UK398Wr1jva4Sva4kCF4kGrWUAF9ag3ykAF4x
	Jw1jkrZ3G3s8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnpnQU
	UUUU=
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


