Return-Path: <bpf+bounces-39601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106F597506D
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 13:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC11C226D5
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D376D185B68;
	Wed, 11 Sep 2024 11:05:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D714A097
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052757; cv=none; b=BHiS4EIlT3v8JRPQWmwf5jvQhEop1NqwLdq5WGkEqeAiCPULtZGs5+PW5VGwiNaqm7w6Slr2Q3xcFW32BewTxQFGKq4sIBWYsm6n281ZXjFGD0NMs24sYDLEbpU9A4mS7VKkswOkIYKp0VFAUJtvzD74HC8gnVgbfGPRUKLLpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052757; c=relaxed/simple;
	bh=6MtSOvYysnHX7PRdeyF4wWw6R1oiB5x/o/1VQDDMDTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BxFh2PpEfVeUX84XCupGHheooOFevU6GyyNpa6hl5gFKNHwXvcu5CqK92XY4pNkFfkhfxIZBHQcDRsfOEBmrj7XvYHuYZlI3Xx+7XJMaBFiE/IEHi3XtI6fU7YHEPJ6XpS0dN4bfA2gsijAoKheVPxn1Rd4UrFA++J42ttI3K2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X3d5q3nN7z4f3l20
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 19:05:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C07FB1A177C
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 19:05:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMiMeeFmB9sSBA--.4297S5;
	Wed, 11 Sep 2024 19:05:51 +0800 (CST)
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
	Kui-Feng Lee <thinker.li@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [RESEND][PATCH bpf 1/2] bpf: Check the remaining info_cnt before repeating btf fields
Date: Wed, 11 Sep 2024 19:05:56 +0800
Message-Id: <20240911110557.2759801-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240911110557.2759801-1-houtao@huaweicloud.com>
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMiMeeFmB9sSBA--.4297S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8Cw43GFy3AFWrtF1xuFg_yoW8Crykpr
	4Syw13Ar48KFsa9a1Ut3Waka42yws5Ww12yFZ7KryFyF4Yvr93Xw4Utr1rZFy3K393Xryx
	ZFnFqFykta98Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When trying to repeat the btf fields for array of nested struct, it
doesn't check the remaining info_cnt. The following splat will be
reported when the value of ret * nelems is greater than BTF_FIELDS_MAX:

  ------------[ cut here ]------------
  UBSAN: array-index-out-of-bounds in ../kernel/bpf/btf.c:3951:49
  index 12 is out of range for type 'btf_field_info [12]'
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

Fix it by checking the remaining info_cnt before btf field repetition.

Fixes: 64e8ee814819 ("bpf: look into the types of the fields of a struct type recursively.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/btf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a4e4f8d43ecf..9a4a074d26f5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3592,6 +3592,12 @@ static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *
 		info[i].off += off;
 
 	if (nelems > 1) {
+		/* The type of struct size or variable size is u32,
+		 * so the multiplication will not overflow.
+		 */
+		if (ret * nelems > info_cnt)
+			return -E2BIG;
+
 		err = btf_repeat_fields(info, ret, nelems - 1, t->size);
 		if (err == 0)
 			ret *= nelems;
-- 
2.29.2


