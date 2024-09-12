Return-Path: <bpf+bounces-39678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F57C975E7F
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 03:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976A41C2269C
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 01:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190482AF16;
	Thu, 12 Sep 2024 01:28:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE72A1DC
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104525; cv=none; b=BOxZTP1rXBQFD0daxQZ3oPCu6RvMqb7SWIzB+Iy8XrPXfEp0b4teufkIoXSzAdJkeGLNHHRwcHb1yyZwgJESe6cdlF2RTyXOSAc6eT082t4mP2kNnolz23EGTHBA0ertyCcB6dg8dquDvUtw2aa8uPtFvJTD4xhR3UGHFseJ8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104525; c=relaxed/simple;
	bh=I/8/SlMp9k4v1DPCWCy23t8S2OMzE2+XlfFbP6H46To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgsVrVsayaZcJf0GpvVan5yfNaVt1HE59g9vc2wnbJ+9yt14n10fQrL/jA0Yb6zfm0ji/iUt2pEnXsbjHG0IpH3fqS65HvUZpBbv5ZqKCxrwvAlxZnoQAwG2qPZGr9sExH1UI4zWHtMr2Y6NTVe7+AP+78EbuE66uXUJR+YdbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X40FN3XQ6z4f3kvP
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:28:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C00B31A06D7
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:28:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysbFQ+JmOHBLBA--.63562S6;
	Thu, 12 Sep 2024 09:28:40 +0800 (CST)
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
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 2/2] bpf: Call the missed kfree() when there is no special field in btf
Date: Thu, 12 Sep 2024 09:28:45 +0800
Message-Id: <20240912012845.3458483-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240912012845.3458483-1-houtao@huaweicloud.com>
References: <20240912012845.3458483-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysbFQ+JmOHBLBA--.63562S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4rGw1DZr17ur4xJr4xZwb_yoW8GFW7pa
	43Cry8Gr4xGr17uF4jyF10kF13J3Za93ZrJF48Kr13KF47Xr95t3W7W3y3u3yayrW8tr13
	AFnFyFnYqw4kA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIID7
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Call the missed kfree() in btf_parse_struct_metas() when there is no
special field in btf, otherwise will get the following kmemleak report:

unreferenced object 0xffff888101033620 (size 8):
  comm "test_progs", pid 604, jiffies 4295127011
  ......
  backtrace (crc e77dc444):
    [<00000000186f90f3>] kmemleak_alloc+0x4b/0x80
    [<00000000ac8e9c4d>] __kmalloc_cache_noprof+0x2a1/0x310
    [<00000000d99d68d6>] btf_new_fd+0x72d/0xe90
    [<00000000f010b7f8>] __sys_bpf+0xec3/0x2410
    [<00000000e077ed6f>] __x64_sys_bpf+0x1f/0x30
    [<00000000a12f9e55>] x64_sys_call+0x199/0x9f0
    [<00000000f3029ea6>] do_syscall_64+0x3b/0xc0
    [<000000005640913a>] entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 7a851ecb1806 ("bpf: Search for kptrs in prog BTF structs")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/btf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 59b4f7265761..31eae516f701 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5572,8 +5572,10 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		aof->ids[aof->cnt++] = i;
 	}
 
-	if (!aof->cnt)
+	if (!aof->cnt) {
+		kfree(aof);
 		return NULL;
+	}
 	sort(&aof->ids, aof->cnt, sizeof(aof->ids[0]), btf_id_cmp_func, NULL);
 
 	for (i = 1; i < n; i++) {
-- 
2.29.2


