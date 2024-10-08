Return-Path: <bpf+bounces-41191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09E7993F95
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F45B1C2089E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB61EF954;
	Tue,  8 Oct 2024 06:59:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AD1C231F
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370752; cv=none; b=KOxV+PYPPQ7Png0v2ZlmsQZd7UJicVLdpV0IgD1Jy2CHTqzuygQKvicHUykABaRLafY/2li/7IWh6y+Z6ONin6FKN+VYRwSsEYtFJuuLB+xaapvJw3vPaFvSJFrLGbZaLxJsDEHhnsS5Ch94LQ6Y8b0SFOb3tQQSAZr8vzeRgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370752; c=relaxed/simple;
	bh=SM0h8CEofiH8Yjp6gg0mQ+1MG5ycAGBYA+pVnNpE0TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+qYK2JSst4kQUdJ+Q6qbtvfnKOT3CegO34A91B390XQHw5hvEEECnOgmwBnHzjP/GUikFdkc0o8mRGV8J8JD7PFRnqFgWCf3qjDnEjQEDTWMH+yuvqHRoPcRC7mlNxCmwcfWyA/ihBaGM0a9qwduqR5fnxIW2E4zJuh2gEhx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XN6Ld64tbz4f3jXP
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 14:58:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A25311A08FC
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 14:59:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMg22ARnFIP_DQ--.38499S5;
	Tue, 08 Oct 2024 14:59:06 +0800 (CST)
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
	Kui-Feng Lee <thinker.li@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf RESEND 1/2] bpf: Check the remaining info_cnt before repeating btf fields
Date: Tue,  8 Oct 2024 15:11:13 +0800
Message-Id: <20241008071114.3718177-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241008071114.3718177-1-houtao@huaweicloud.com>
References: <20241008071114.3718177-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMg22ARnFIP_DQ--.38499S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW7GrW3ZrW3GFy5GFW3Jrb_yoW5AryDpF
	4fAr13CF48trZ3u3WDtFn0kayayr4fu34ayF97KryFyF45tr1DXF4rtr4rAFWfKrWvyrW8
	CF4qqFZ8t3y3u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnpnQU
	UUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When trying to repeat the btf fields for array of nested struct, it
doesn't check the remaining info_cnt. The following splat will be
reported when the value of ret * nelems is greater than BTF_FIELDS_MAX:

  ------------[ cut here ]------------
  UBSAN: array-index-out-of-bounds in ../kernel/bpf/btf.c:3951:49
  index 11 is out of range for type 'btf_field_info [11]'
  CPU: 6 UID: 0 PID: 411 Comm: test_progs ...... 6.11.0-rc4+ #1
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ...
  Call Trace:
   <TASK>
   dump_stack_lvl+0x57/0x70
   dump_stack+0x10/0x20
   ubsan_epilogue+0x9/0x40
   __ubsan_handle_out_of_bounds+0x6f/0x80
   ? kallsyms_lookup_name+0x48/0xb0
   btf_parse_fields+0x992/0xce0
   map_create+0x591/0x770
   __sys_bpf+0x229/0x2410
   __x64_sys_bpf+0x1f/0x30
   x64_sys_call+0x199/0x9f0
   do_syscall_64+0x3b/0xc0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7fea56f2cc5d
  ......
   </TASK>
  ---[ end trace ]---

Fix it by checking the remaining info_cnt in btf_repeat_fields() before
repeating the btf fields.

Fixes: 64e8ee814819 ("bpf: look into the types of the fields of a struct type recursively.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/btf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 75e4fe83c509..9cf0ec2e7cb6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3523,7 +3523,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
  *   (i + 1) * elem_size
  * where i is the repeat index and elem_size is the size of an element.
  */
-static int btf_repeat_fields(struct btf_field_info *info,
+static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
 {
 	u32 i, j;
@@ -3543,6 +3543,12 @@ static int btf_repeat_fields(struct btf_field_info *info,
 		}
 	}
 
+	/* The type of struct size or variable size is u32,
+	 * so the multiplication will not overflow.
+	 */
+	if (field_cnt * (repeat_cnt + 1) > info_cnt)
+		return -E2BIG;
+
 	cur = field_cnt;
 	for (i = 0; i < repeat_cnt; i++) {
 		memcpy(&info[cur], &info[0], field_cnt * sizeof(info[0]));
@@ -3587,7 +3593,7 @@ static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *
 		info[i].off += off;
 
 	if (nelems > 1) {
-		err = btf_repeat_fields(info, ret, nelems - 1, t->size);
+		err = btf_repeat_fields(info, info_cnt, ret, nelems - 1, t->size);
 		if (err == 0)
 			ret *= nelems;
 		else
@@ -3681,10 +3687,10 @@ static int btf_find_field_one(const struct btf *btf,
 
 	if (ret == BTF_FIELD_IGNORE)
 		return 0;
-	if (nelems > info_cnt)
+	if (!info_cnt)
 		return -E2BIG;
 	if (nelems > 1) {
-		ret = btf_repeat_fields(info, 1, nelems - 1, sz);
+		ret = btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.29.2


