Return-Path: <bpf+bounces-39903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63788979108
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 15:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E821C2178C
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843441993B0;
	Sat, 14 Sep 2024 13:37:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33ED1CF5C1
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321026; cv=none; b=FzMnfefhxHXu2B7ELoAR0G2Ttan/yzgv8eLW9Rg0z0yKM5ZvkrzCS8fVc7rA5pIxer4A6xo1BTsj7uQiX1uMMNhtW30mF7UrgDLpHkxhhu43JQrhr8t9A4wtDIXrslEVtp/IMIgKVBAwkV9xe9deJBC9Olys8hZUFA3ZtgrPDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321026; c=relaxed/simple;
	bh=OKxLI5Xo2Xn0DNpHlkWRmGnpMSRuGNfHIcHSD6R27hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJlOgRNDPKBray42voHGSdhEw9dPw1jq6niRfJkn8l6+Q0D3/5WyVq39xCPhZQszMpkjI0rs0SAJW51GG6+3VZYq94ZoYLxVSoJ3I9Zdn3bSdmRIdhFHrzteNaTq/NwjTpOpP1Bo5TQGItEC12j2gC04vmRZs6kE1T5nt/B08Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X5XJq4ZPFz4f3lCf
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 21:36:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0E0561A0568
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 21:37:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8R3keVmnUI4BQ--.14337S5;
	Sat, 14 Sep 2024 21:36:59 +0800 (CST)
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
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v2 1/2] bpf: Check the remaining info_cnt before repeating btf fields
Date: Sat, 14 Sep 2024 21:37:02 +0800
Message-Id: <20240914133703.1920767-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240914133703.1920767-1-houtao@huaweicloud.com>
References: <20240914133703.1920767-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHR8R3keVmnUI4BQ--.14337S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW7GrW3ZrW3GFy5GFW3Jrb_yoW5AryDpF
	4Syr13ur48JrZ3u3WDtFs0ka1ayr4fu34ayF97Kr1FyF45tr1DXF4rKr1rAFWfKrWkArW8
	CF4qqFZ8t3y3ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jqYL9U
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
index a4e4f8d43ecf..cf3722113e02 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3528,7 +3528,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
  *   (i + 1) * elem_size
  * where i is the repeat index and elem_size is the size of an element.
  */
-static int btf_repeat_fields(struct btf_field_info *info,
+static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
 {
 	u32 i, j;
@@ -3548,6 +3548,12 @@ static int btf_repeat_fields(struct btf_field_info *info,
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
@@ -3592,7 +3598,7 @@ static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *
 		info[i].off += off;
 
 	if (nelems > 1) {
-		err = btf_repeat_fields(info, ret, nelems - 1, t->size);
+		err = btf_repeat_fields(info, info_cnt, ret, nelems - 1, t->size);
 		if (err == 0)
 			ret *= nelems;
 		else
@@ -3686,10 +3692,10 @@ static int btf_find_field_one(const struct btf *btf,
 
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


