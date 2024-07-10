Return-Path: <bpf+bounces-34372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2174092CE2D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 11:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C682A28742A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394E18FA0F;
	Wed, 10 Jul 2024 09:29:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE118FA06
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603767; cv=none; b=Vn5/x4WuwryNtC6WaqAiQ42NLZmG3cNZLVjZOpdMuftGHvGdMF05fWIjXPFU0SzhxHur9NitVwbY8GDqWstMnYZaL7dyd+JtmCvnYOvWbOFRDUicBTQJrYAYX9zqsysLTzJhOmhpZawf1MJLEm91SHpKqatuetAIgicWEZOb/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603767; c=relaxed/simple;
	bh=5GI1M2g1JiPQVP7Co1htoM4Zv3LgQLf6v87gnutD0cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWGP9yI5Q6GJVEyBMaAT2/BN2cvmtJ5ijxWcGR0YAHMu9iEgr9mzu3VGtDTuBwEsAxHrt48Rzmi/SZ+3z85t2clAsns7YuMkLaO2Mj3ZLyrYgJjf+uX2vE6R1r7JKDGXRsmh+XChPZ4/yBi/7MpaECR81GP+gOnEJRchUzfZXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WJsxc5pdlz4f3jM8
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:29:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A65C11A0189
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:29:21 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP3 (Coremail) with SMTP id _Ch0CgCXpF5jVI5mTxF_Bg--.1219S3;
	Wed, 10 Jul 2024 17:29:21 +0800 (CST)
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
Subject: [PATCH bpf v3 1/3] bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT
Date: Wed, 10 Jul 2024 17:29:02 +0800
Message-Id: <20240710092904.3438141-2-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710092904.3438141-1-wutengda@huaweicloud.com>
References: <20240710092904.3438141-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXpF5jVI5mTxF_Bg--.1219S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy7CF4fCw1xZr4xKF4kJFb_yoWrGr1rpr
	1UGr17Gr4kJrW7Z3ZrAr1UJr1UZFyDAF15tr1ftw4rZFn8ur4xKr4UGayUGr1Yyr4DJFZx
	JFyqgF18tw1UCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
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

Fix this by adding dst_prog non-empty check in BPF_PROG_TYPE_EXT case
when bpf_prog_load().

Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Cc: stable@vger.kernel.org # v5.18+
Acked-by: Leon Hwang <hffilwlqm@gmail.com>
---
 kernel/bpf/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f45ed6adc092..4490f8ccf006 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2632,9 +2632,12 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 			return 0;
 		return -EINVAL;
 	case BPF_PROG_TYPE_SYSCALL:
-	case BPF_PROG_TYPE_EXT:
 		if (expected_attach_type)
 			return -EINVAL;
+		return 0;
+	case BPF_PROG_TYPE_EXT:
+		if (expected_attach_type || !dst_prog)
+			return -EINVAL;
 		fallthrough;
 	default:
 		return 0;
-- 
2.34.1


