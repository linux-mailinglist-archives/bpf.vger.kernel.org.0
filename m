Return-Path: <bpf+bounces-73613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A23BDC34FF7
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F4514E286B
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1910F309EE8;
	Wed,  5 Nov 2025 10:00:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BA30149F
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336807; cv=none; b=r7pCCRlPqADDHM5SyLFZXElObfD1mddmNyb7RdkoE9vXRu8K1LAXONqqfkzQUD6qReZJhhzLa51a+Cz4uLK06GSOxq7+120HIrUjsK84+OlL6Am/s/UQ0Ljk0SeBPsfgzNeYIh64MdqRC5w7erNZ+FppiVgRDXh/wV99FVm5xME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336807; c=relaxed/simple;
	bh=cT9qURmWvIIZDrxBISAUA2/xnz4VH0jTuOb3DAgflEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Brn5/Tel8xR7947+PhgT/9bFDMmgR++OHZUC8sCh4XFTm/TzTvz0JkdiZiOBLV6bGns1+/C/SK1UshWRQhXCyRA02FhcYrLUBKiwK3Y8L4RxJNzr+vDYrLsCYsjCUEEIg89JgWLTfgPqamT6Odwkally1vUBpTxxbiqRQdLfowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d1gm21tvxzYQtrB
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 17:59:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BE3801A07F4
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 18:00:02 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgBH6EAgIAtpkhAgCw--.32880S2;
	Wed, 05 Nov 2025 18:00:02 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf] bpf: Fix invalid mem access when update_effective_progs fails in __cgroup_bpf_detach
Date: Wed,  5 Nov 2025 10:03:02 +0000
Message-Id: <20251105100302.2968475-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBH6EAgIAtpkhAgCw--.32880S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy7Ary3Jr4kKF4rKrW5trb_yoW5ZrW8pF
	WDJ347Aw45Gr4DZryDJw409F43JF15WF1rGFWUC34xWFW2vrn7K3WUur90yFWY9rWqkw1f
	X3WY9rZIyFyUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Syzkaller triggers an invalid memory access issue following fault
injection in update_effective_progs. The issue can be described as
follows:

__cgroup_bpf_detach
  update_effective_progs
    compute_effective_progs
      bpf_prog_array_alloc <-- fault inject
  purge_effective_progs
    /* change to dummy_bpf_prog */
    array->items[index] = &dummy_bpf_prog.prog

---softirq start---
__do_softirq
  ...
    __cgroup_bpf_run_filter_skb
      __bpf_prog_run_save_cb
        bpf_prog_run
          stats = this_cpu_ptr(prog->stats)
          /* invalid memory access */
          flags = u64_stats_update_begin_irqsave(&stats->syncp)
---softirq end---

  static_branch_dec(&cgroup_bpf_enabled_key[atype])

The reason is that fault injection caused update_effective_progs to fail
and then changed the original prog into dummy_bpf_prog.prog in
purge_effective_progs. Then a softirq came, and accessing the members of
dummy_bpf_prog.prog in the softirq triggers invalid mem access.

To fix it, we can skip executing the prog when it's dummy_bpf_prog.prog.

Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 include/linux/bpf.h | 6 ++++++
 kernel/bpf/cgroup.c | 5 +++--
 kernel/bpf/core.c   | 5 ++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d808253f2e94..923687c47111 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2212,6 +2212,12 @@ struct bpf_prog_array {
 	struct bpf_prog_array_item items[];
 };
 
+struct bpf_prog_dummy {
+	struct bpf_prog prog;
+};
+
+extern struct bpf_prog_dummy dummy_bpf_prog;
+
 struct bpf_empty_prog_array {
 	struct bpf_prog_array hdr;
 	struct bpf_prog *null_prog;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 248f517d66d0..baad33b34cef 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -77,7 +77,9 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 	item = &array->items[0];
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	while ((prog = READ_ONCE(item->prog))) {
-		run_ctx.prog_item = item;
+		run_ctx.prog_item = item++;
+		if (prog == &dummy_bpf_prog.prog)
+			continue;
 		func_ret = run_prog(prog, ctx);
 		if (ret_flags) {
 			*(ret_flags) |= (func_ret >> 1);
@@ -85,7 +87,6 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 		}
 		if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
 			run_ctx.retval = -EPERM;
-		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock_migrate();
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..eac8cc341725 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2536,13 +2536,12 @@ static unsigned int __bpf_prog_ret1(const void *ctx,
 	return 1;
 }
 
-static struct bpf_prog_dummy {
-	struct bpf_prog prog;
-} dummy_bpf_prog = {
+struct bpf_prog_dummy dummy_bpf_prog = {
 	.prog = {
 		.bpf_func = __bpf_prog_ret1,
 	},
 };
+EXPORT_SYMBOL(dummy_bpf_prog);
 
 struct bpf_empty_prog_array bpf_empty_prog_array = {
 	.null_prog = NULL,
-- 
2.34.1


