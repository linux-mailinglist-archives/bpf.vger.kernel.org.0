Return-Path: <bpf+bounces-17389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291580C7F7
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CBA1C20F72
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72317374D1;
	Mon, 11 Dec 2023 11:27:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46989B6
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 03:27:45 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Spfc95qz8z4f3m7L
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 19:27:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B2A881A0999
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 19:27:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxEp8nZlUTNnDQ--.13914S6;
	Mon, 11 Dec 2023 19:27:42 +0800 (CST)
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
Subject: [PATCH bpf-next 2/4] bpf: Use __GFP_NOWARN for kvmalloc_array() when attaching multiple kprobes
Date: Mon, 11 Dec 2023 19:28:41 +0800
Message-Id: <20231211112843.4147157-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCnqxEp8nZlUTNnDQ--.13914S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWDXF4xCw1rGFWfAF13Arb_yoW8CF48pF
	yDJw1DGF1rAF4agay8Z3ykWF17Zws5G34Utan3X3sIvan8Xrs8GrsFyFyjgF1F9r95Jw4f
	XrykKF1Utr4DXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

An abnormally big cnt may also be assigned to kprobe_multi.cnt when
attaching multiple kprobes. It will trigger the following warning in
kvmalloc_node():

	if (unlikely(size > INT_MAX)) {
	    WARN_ON_ONCE(!(flags & __GFP_NOWARN));
	    return NULL;
	}

Fix the warning by using __GFP_NOWARN when invoking kvmalloc_array() in
bpf_kprobe_multi_link_attach().

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/trace/bpf_trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 07b9b5896d6c..64f200890c19 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2605,11 +2605,11 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
 	int err = -ENOMEM;
 	unsigned int i;
 
-	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
+	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL | __GFP_NOWARN);
 	if (!syms)
 		goto error;
 
-	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
+	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL | __GFP_NOWARN);
 	if (!buf)
 		goto error;
 
@@ -2972,13 +2972,13 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	size = cnt * sizeof(*addrs);
-	addrs = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
+	addrs = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL | __GFP_NOWARN);
 	if (!addrs)
 		return -ENOMEM;
 
 	ucookies = u64_to_user_ptr(attr->link_create.kprobe_multi.cookies);
 	if (ucookies) {
-		cookies = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
+		cookies = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL | __GFP_NOWARN);
 		if (!cookies) {
 			err = -ENOMEM;
 			goto error;
-- 
2.29.2


