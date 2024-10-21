Return-Path: <bpf+bounces-42555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612329A588A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4C2B21B09
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 01:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870117C7C;
	Mon, 21 Oct 2024 01:28:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A51CA84
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474087; cv=none; b=QvSYIIkmFEocwuB7CMvBcE2m36RdZhUqEezbB/V5el3aVvBdEAnAdl8enRaT52ustV5gbIwqhClWvQ4PGFE5m9tH0R5R/Eklyi37ZaaEPaRBI9vT041oGE1yyuG7V8I1IE8/Il7h3YvaJhcOhnOuZAwMJjAJzWrsoP/m6ea1ViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474087; c=relaxed/simple;
	bh=fBKAuFfKFhWQx+oYNlggM3JHv0wdtY9wWS1rwjHoRU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXx5GK0i7X2viQYbzqd+jR9Z2mt87S+sGJmlXhKC1Hopcq9PmRv38vfmLK8wc6MgVsFrRu+3PqRolFyidAlo03BA28tn+Uek9iCghMMZXDXRzpXs7v8v8nsDQYnce9T7hwhcpNKIblNCBPbi0hNq+qfp5gV4rFOjbehHU5HQMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XWyNV4VPNz4f3kvv
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BDCFE1A0568
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYXrhVnot2wEg--.32425S7;
	Mon, 21 Oct 2024 09:27:56 +0800 (CST)
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
Subject: [PATCH bpf v2 3/7] bpf: Preserve param->string when parsing mount options
Date: Mon, 21 Oct 2024 09:40:00 +0800
Message-Id: <20241021014004.1647816-4-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYXrhVnot2wEg--.32425S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1kXrW5uF4xuF1UWr1Utrb_yoW8CrWrpF
	WrCa4UC3y8tF4UAr40qF4kWrWYv3WIkFW8Ka1kAr1SyF13tr92gF9rAw1agr1fJ3y8C3yY
	vr4Yyw1I9a1UC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
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
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
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


