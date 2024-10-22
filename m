Return-Path: <bpf+bounces-42777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3C9AA27A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F98283AF1
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE30819C579;
	Tue, 22 Oct 2024 12:49:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC212D1F1
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601372; cv=none; b=gCjWoEdfJwK0rEl5JhVae3I5wVv7urh+e4McTDFEsIwz264Gz7mr0vZUYU1FxE5+g8Ay/sgh43O9mhQP5fYjUSS9SY5jOirf7F2WmlB9QMGc8/e/oiCShxJa337dOYCJLjJsC7PCMkGP5mCx2OLOVtyoFR2IuOxZY//zs6E8VeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601372; c=relaxed/simple;
	bh=qxW0SyRkmfxK6jsY/Agw+437swO/9hKsyHl4Gne155M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iYAcVF9eRkNBlKWw7ImCZqw3x5GEUSGJjboNF8Y1Yvv92fXX7XirtxZob5hJiBy3gvAqazONp3oit4uu4VXitsK20PBttFhivNAX4196kH9SB8qg7uWLwoLuu5eMWg2KKLGonSt3So77mJhqeAmE9So56sK4sSQd0cbGzgDCfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXsSM2xPNz4f3jXm
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:49:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C74441A0359
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:49:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCHusZQnxdnd_k7Ew--.1774S4;
	Tue, 22 Oct 2024 20:49:22 +0800 (CST)
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v3] bpf: Preserve param->string when parsing mount options
Date: Tue, 22 Oct 2024 21:01:33 +0800
Message-Id: <20241022130133.3798232-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHusZQnxdnd_k7Ew--.1774S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1kXrW5uF4xuF1UWr1Utrb_yoW8Zw4kpF
	WrG34Uuw48XF4UAw4vqF4kWrWYv3W0kFW8Ka1kAr1Syr13tr92gF9Fkw4a9r1ft3yrCrWY
	vr4Yy34I9w1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1aFAJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

In bpf_parse_param(), keep the value of param->string intact so it can
be freed later. Otherwise, the kmalloc area pointed to by param->string
will be leaked as shown below:

unreferenced object 0xffff888118c46d20 (size 8):
  comm "new_name", pid 12109, jiffies 4295580214
  hex dump (first 8 bytes):
    61 6e 79 00 38 c9 5c 7e                          any.8.\~
  backtrace (crc e1b7f876):
    [<00000000c6848ac7>] kmemleak_alloc+0x4b/0x80
    [<00000000de9f7d00>] __kmalloc_node_track_caller_noprof+0x36e/0x4a0
    [<000000003e29b886>] memdup_user+0x32/0xa0
    [<0000000007248326>] strndup_user+0x46/0x60
    [<0000000035b3dd29>] __x64_sys_fsconfig+0x368/0x3d0
    [<0000000018657927>] x64_sys_call+0xff/0x9f0
    [<00000000c0cabc95>] do_syscall_64+0x3b/0xc0
    [<000000002f331597>] entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 6c1752e0b6ca ("bpf: Support symbolic BPF FS delegation mount options")
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
v3: split the patch from the "Misc fixes for bpf" patch set
v2: https://lore.kernel.org/bpf/d49fa2f4-f743-c763-7579-c3cab4dd88cb@huaweicloud.com

 kernel/bpf/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index d8fc5eba529d..9aaf5124648b 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -880,7 +880,7 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		const struct btf_type *enum_t;
 		const char *enum_pfx;
 		u64 *delegate_msk, msk = 0;
-		char *p;
+		char *p, *str;
 		int val;
 
 		/* ignore errors, fallback to hex */
@@ -911,7 +911,8 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 
-		while ((p = strsep(&param->string, ":"))) {
+		str = param->string;
+		while ((p = strsep(&str, ":"))) {
 			if (strcmp(p, "any") == 0) {
 				msk |= ~0ULL;
 			} else if (find_btf_enum_const(info.btf, enum_t, enum_pfx, p, &val)) {
-- 
2.29.2


