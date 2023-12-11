Return-Path: <bpf+bounces-17388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BA480C7F6
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE0E2817BA
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F253716B;
	Mon, 11 Dec 2023 11:27:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4682B0
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 03:27:44 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Spfc92MJzz4f3lfc
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 19:27:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 35E8E1A01F5
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 19:27:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxEp8nZlUTNnDQ--.13914S5;
	Mon, 11 Dec 2023 19:27:40 +0800 (CST)
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
Subject: [PATCH bpf-next 1/4] bpf: Use __GFP_NOWARN for kvcalloc when attaching multiple uprobes
Date: Mon, 11 Dec 2023 19:28:40 +0800
Message-Id: <20231211112843.4147157-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231211112843.4147157-1-houtao@huaweicloud.com>
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxEp8nZlUTNnDQ--.13914S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJF18GrW7AFy3uF1fCF1xZrb_yoW8JFy8pa
	4DJryUGF1rJF4jqaykZrZ7WFy2vws5W3y7Ga9rZry3Zr47XrZ5Grn7KrWjgr1FvrZ0krZ7
	Xr1jgryjvayUZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

An abnormally big cnt may be passed to link_create.uprobe_multi.cnt,
and it will trigger the following warning in kvmalloc_node():

	if (unlikely(size > INT_MAX)) {
		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
		return NULL;
	}

Fix the warning by using __GFP_NOWARN when invoking kvzalloc() in
bpf_uprobe_multi_link_attach().

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Reported-by: xingwei lee <xrivendell7@gmail.com>
Closes: https://lore.kernel.org/bpf/CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 774cf476a892..07b9b5896d6c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3378,7 +3378,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	err = -ENOMEM;
 
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
-	uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
+	uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL | __GFP_NOWARN);
 
 	if (!uprobes || !link)
 		goto error_free;
-- 
2.29.2


