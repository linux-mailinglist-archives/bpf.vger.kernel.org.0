Return-Path: <bpf+bounces-32893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B037A914953
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104991F24D35
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AD013A879;
	Mon, 24 Jun 2024 12:06:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F92E636
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719230762; cv=none; b=IuWW3k8VBE9pfZeg32we7QsksiVb7K1awiYvPvRzr4/Agu97RnLXPcZmlS8ur2rzsjZJ3yqQLKR8mNXkoT+AIfXrW11Avh6LBFnzaFyQTV83m69floh5gbLZTOVoRJzkbHP2bDLAtzW3ZoUZQWjPg0M0rmYrZ4fkNqYbHU0CiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719230762; c=relaxed/simple;
	bh=iUDwmWowhQhoH7chaD0uFNN+JzCY9oTr05sCOGN6gEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RB63DmYjhlIcXDWTBOj6suVWGlbxV+g6LABpV3Vh2Y6bUqHhNqPtLlTPwZjRc1h11fLZF8hw3cLYSbUIx1d1FbncoMFl8p2JNZk/CIrD/PW5pHjXUHPAYA2kTo7Ij2Pk4Cr75iaWEQaMBmtcsqq7j/TUX589Hex51kaK20XHKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W769W6q6bz4f3jHg
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 20:05:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A19161A0187
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 20:05:46 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP1 (Coremail) with SMTP id cCh0CgAHMHwTYXlmPpXPAA--.52351S2;
	Mon, 24 Jun 2024 20:05:45 +0800 (CST)
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
Subject: [PATCH bpf v2] bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT
Date: Mon, 24 Jun 2024 20:05:33 +0800
Message-Id: <20240624120533.873789-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHMHwTYXlmPpXPAA--.52351S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WryfXF1rGF45uFyfXw4Utwb_yoW7ZrW3pF
	yDGr15Gr4kJ3y7Z3ZrAw1j9r15AFnrAF15tr43tw1ruF15Wr4xGr4UWay3Ar1agFZ8Ja93
	t3Wjgr1DKw1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
	wVCI4VW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
	rWrJUUUUU==
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
when calling bpf_prog_load().

Note the BPF_PROG_TYPE_EXT type detection in libbpf also needs to be
adapted by passing a valid attach_prog_fd, since an empty attach_prog_fd
is no longer allowed when loading EXT program.

Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Cc: stable@vger.kernel.org # v5.18+
---
v2: Fix libbpf_probe_prog_types test failure reported by CI by adapting
libbpf code. (thanks for jirka's reminder)

v1: https://lore.kernel.org/all/20240620060701.1465291-1-wutengda@huaweicloud.com/

 kernel/bpf/syscall.c          |  5 ++++-
 tools/lib/bpf/libbpf_probes.c | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

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
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..37f87c824933 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -112,6 +112,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	int fd, err, exp_err = 0;
 	const char *exp_msg = NULL;
 	char buf[4096];
+	int attach_prog_fd = -1;
 
 	switch (prog_type) {
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
@@ -148,9 +149,17 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 		opts.log_size = sizeof(buf);
 		opts.log_level = 1;
 		opts.attach_btf_id = 1;
+		/* choose socket_filter as the target program to attach, since it
+		 * is the earliest and most likely BPF program to be supported.
+		 */
+		attach_prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL,
+					       "GPL", insns, insns_cnt, NULL);
+		if (attach_prog_fd < 0)
+			return attach_prog_fd;
+		opts.attach_prog_fd = attach_prog_fd;
 
 		exp_err = -EINVAL;
-		exp_msg = "Cannot replace kernel functions";
+		exp_msg = "FENTRY/FEXIT program can only be attached to another program annotated with BTF";
 		break;
 	case BPF_PROG_TYPE_SYSCALL:
 		opts.prog_flags = BPF_F_SLEEPABLE;
@@ -192,6 +201,8 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	err = -errno;
 	if (fd >= 0)
 		close(fd);
+	if (attach_prog_fd >= 0)
+		close(attach_prog_fd);
 	if (exp_err) {
 		if (fd >= 0 || err != exp_err)
 			return 0;
-- 
2.34.1


