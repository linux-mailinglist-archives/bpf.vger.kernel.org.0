Return-Path: <bpf+bounces-34571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E0292EB1C
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 16:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE706284B1A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748FD16A95A;
	Thu, 11 Jul 2024 14:58:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CDF15279A
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709926; cv=none; b=jgrC0TNUpTdvLYm7KFWlPLTqdSVLcMdt4LMcrAc9hE0IapNvSUQIOyCwI+3lBTUUlJO6uA8K56Vqmomd0hZZsW8LlgL/kcdBL6t2JgoUf2z6Ycm7+nRBIFxEgDQOPqZt3atjAd8Bq1rOr3KVCVs4N0bLPpTd+PPe6K7TQlmK0OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709926; c=relaxed/simple;
	bh=9je8hYGgMJeN5uemrAluOuqVCizLEtuku3CP0/0jMyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m9nhUkrHiG799H2Rbf1gx4PKCXNDTrlHe9YXv9lG582IwHUwGgwcnuxUNluvXxUPvDJmFTmrDPIkGVs/UHC+sSKJWMK2NTnvL+80QWiE0+NmS1Z1x6ePT5kHRYBhLx8M4RMC5M3ELibm7QwJPUKD5Fx0SM1geThPwvdLx2u/+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WKdC75rK0z4f3jrs
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 22:58:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 816BE1A0568
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 22:58:39 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP2 (Coremail) with SMTP id Syh0CgBXC4EQ849m425BBw--.32411S3;
	Thu, 11 Jul 2024 22:58:39 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	hffilwlqm@gmail.com
Subject: [PATCH bpf v4 1/2] bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT
Date: Thu, 11 Jul 2024 22:58:18 +0800
Message-Id: <20240711145819.254178-2-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711145819.254178-1-wutengda@huaweicloud.com>
References: <20240711145819.254178-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXC4EQ849m425BBw--.32411S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy7CF4fCw1xZr4xKF4kJFb_yoWrtry3pF
	1DGr17Gr4kJ3y7AwnrAF13AryUZFyDAF15tr13Kw1UuF1Uur4xGrWUG3yUCrn0yF4DJrZ3
	Xw12gr1Dtw1UCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When loading a EXT program without specifying `attr->attach_prog_fd`,
the `prog->aux->dst_prog` will be null. At this time, calling
resolve_prog_type() anywhere will result in a null pointer dereference.

Example stack trace:

[    8.107863] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
[    8.108262] Mem abort info:
[    8.108384]   ESR = 0x0000000096000004
[    8.108547]   EC = 0x25: DABT (current EL), IL = 32 bits
[    8.108722]   SET = 0, FnV = 0
[    8.108827]   EA = 0, S1PTW = 0
[    8.108939]   FSC = 0x04: level 0 translation fault
[    8.109102] Data abort info:
[    8.109203]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    8.109399]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    8.109614]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    8.109836] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101354000
[    8.110011] [0000000000000004] pgd=0000000000000000, p4d=0000000000000000
[    8.112624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    8.112783] Modules linked in:
[    8.113120] CPU: 0 PID: 99 Comm: may_access_dire Not tainted 6.10.0-rc3-next-20240613-dirty #1
[    8.113230] Hardware name: linux,dummy-virt (DT)
[    8.113390] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.113429] pc : may_access_direct_pkt_data+0x24/0xa0
[    8.113746] lr : add_subprog_and_kfunc+0x634/0x8e8
[    8.113798] sp : ffff80008283b9f0
[    8.113813] x29: ffff80008283b9f0 x28: ffff800082795048 x27: 0000000000000001
[    8.113881] x26: ffff0000c0bb2600 x25: 0000000000000000 x24: 0000000000000000
[    8.113897] x23: ffff0000c1134000 x22: 000000000001864f x21: ffff0000c1138000
[    8.113912] x20: 0000000000000001 x19: ffff0000c12b8000 x18: ffffffffffffffff
[    8.113929] x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
[    8.113944] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
[    8.113958] x11: 0720072007200720 x10: 0000000000f9fca4 x9 : ffff80008021f4e4
[    8.113991] x8 : 0101010101010101 x7 : 746f72705f6d656d x6 : 000000001e0e0f5f
[    8.114006] x5 : 000000000001864f x4 : ffff0000c12b8000 x3 : 000000000000001c
[    8.114020] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
[    8.114126] Call trace:
[    8.114159]  may_access_direct_pkt_data+0x24/0xa0
[    8.114202]  bpf_check+0x3bc/0x28c0
[    8.114214]  bpf_prog_load+0x658/0xa58
[    8.114227]  __sys_bpf+0xc50/0x2250
[    8.114240]  __arm64_sys_bpf+0x28/0x40
[    8.114254]  invoke_syscall.constprop.0+0x54/0xf0
[    8.114273]  do_el0_svc+0x4c/0xd8
[    8.114289]  el0_svc+0x3c/0x140
[    8.114305]  el0t_64_sync_handler+0x134/0x150
[    8.114331]  el0t_64_sync+0x168/0x170
[    8.114477] Code: 7100707f 54000081 f9401c00 f9403800 (b9400403)
[    8.118672] ---[ end trace 0000000000000000 ]---

One way to fix it is by forcing `attach_prog_fd` non-empty when
bpf_prog_load(). But this will lead to `libbpf_probe_bpf_prog_type`
API broken which use verifier log to probe prog type and will log
nothing if we reject invalid EXT prog before bpf_check().

Another way is by adding null check in resolve_prog_type().

The issue was introduced by commit 4a9c7bbe2ed4 ("bpf: Resolve to
prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT") which wanted
to correct type resolution for BPF_PROG_TYPE_TRACING programs. Before
that, the type resolution of BPF_PROG_TYPE_EXT prog actually follows
the logic below:

  prog->aux->dst_prog ? prog->aux->dst_prog->type : prog->type;

It implies that when EXT program is not yet attached to `dst_prog`,
the prog type should be EXT itself. This code worked fine in the past.
So just keep using it.

Fix this by returning `prog->type` for BPF_PROG_TYPE_EXT if `dst_prog`
is not present in resolve_prog_type().

Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
Cc: stable@vger.kernel.org # v5.18+
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e4070fb02b11..ff2a6cdb1fa3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -846,7 +846,7 @@ static inline u32 type_flag(u32 type)
 /* only use after check_attach_btf_id() */
 static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
-	return prog->type == BPF_PROG_TYPE_EXT ?
+	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
 		prog->aux->dst_prog->type : prog->type;
 }
 
-- 
2.34.1


