Return-Path: <bpf+bounces-17664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBF810FD2
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 12:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CADB1F213EB
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227C241FD;
	Wed, 13 Dec 2023 11:24:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68217B2
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 03:24:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SqtRc5pVlz4f3js5
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:24:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 541BC1A0AD5
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:24:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3OhBqlHllBOIgDg--.15138S6;
	Wed, 13 Dec 2023 19:24:31 +0800 (CST)
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
	xingwei lee <xrivendell7@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 2/4] bpf: Limit the number of kprobes when attaching program to multiple kprobes
Date: Wed, 13 Dec 2023 19:25:29 +0800
Message-Id: <20231213112531.3775079-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231213112531.3775079-1-houtao@huaweicloud.com>
References: <20231213112531.3775079-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3OhBqlHllBOIgDg--.15138S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWDXF4xCF1fAr1DJF13Jwb_yoW8JF4xpF
	yDJa4qvr4rXF47Kan5Zan5WFyIvan3W3y7GFWDXrnxAa1xZws5Wr12gr4Yq3WF9rZ5t3yx
	JFZ2qryUtrW7ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

An abnormally big cnt may also be assigned to kprobe_multi.cnt when
attaching multiple kprobes. It will trigger the following warning in
kvmalloc_node():

	if (unlikely(size > INT_MAX)) {
	    WARN_ON_ONCE(!(flags & __GFP_NOWARN));
	    return NULL;
	}

Fix the warning by limiting the maximal number of kprobes in
bpf_kprobe_multi_link_attach().

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/trace/bpf_trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2d1201f7b554..944678529f5c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -43,6 +43,7 @@
 	rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
 
 #define MAX_UPROBE_MULTI_CNT (1U << 20)
+#define MAX_KPROBE_MULTI_CNT (1U << 20)
 
 #ifdef CONFIG_MODULES
 struct bpf_trace_module {
@@ -2970,7 +2971,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	cnt = attr->link_create.kprobe_multi.cnt;
-	if (!cnt)
+	if (!cnt || cnt > MAX_KPROBE_MULTI_CNT)
 		return -EINVAL;
 
 	size = cnt * sizeof(*addrs);
-- 
2.29.2


