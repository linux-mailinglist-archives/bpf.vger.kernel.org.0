Return-Path: <bpf+bounces-74045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDAEC452F0
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 08:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07F3188E7AB
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92792EA731;
	Mon, 10 Nov 2025 07:14:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CE194A73
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758861; cv=none; b=WolJAVjR8zO+dtKBQhX3Akmu3r2J2I+1270JI67m6eyRRiYPajThSMzlkia+mYwoHwchztyhbkzZbNyQOABkio665Tbjlm8NL9Cnmafx7XbBnHbwfnLlbmvc6WiX4/19DBdSJVthMSqVg9wWlJpPUxo9WQ4gf+gYBrGMgJmgH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758861; c=relaxed/simple;
	bh=1GG94ZiCAJuNul31EEdlrpKMq+8Uk3NoKv6HNBdNSsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bzqi7EbDIn0GmOpCvMicHpnVtplG1EZbeOBNiOXHhYav/XFDNgaMFw7dqfip36vhIn321pWo124vlkuB6raRuRFwBv9Fx8dd09teBssIdprjv0n52SBYKkAjzvkm0pt/qXKJUiaWPumMu6t0t/fkRDWH+Y0phfYL3x+TyncS/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d4grR5v5lzKHMgn
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 15:13:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1CAC81A07C0
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 15:14:14 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgCnA3rBkBFp0c30AA--.43605S2;
	Mon, 10 Nov 2025 15:14:10 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
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
Subject: [PATCH bpf v2] bpf: Fix invalid mem access when update_effective_progs fails in __cgroup_bpf_detach
Date: Mon, 10 Nov 2025 07:17:14 +0000
Message-Id: <20251110071714.4069712-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnA3rBkBFp0c30AA--.43605S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW3KrWDGF4DCF17ZrW5Wrg_yoW8ZF1rpa
	ykW343Awn0gr4DZFWDJF40qF45Jan8WF4rGFWUG34fWFW2vrn2kw1xurZ0yrWYgrZFk3WF
	va1YqrZrJasrZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
purge_effective_progs. Then a softirq came, and accessing the stats of
dummy_bpf_prog.prog in the softirq triggers invalid mem access.

To fix it, we can use static per-cpu variables to initialize the stats
of dummy_bpf_prog.prog.

Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v2:
- Use static per-cpu variables to initialize the stats of
  dummy_bpf_prog.prog suggested by Eduard.

v1: https://lore.kernel.org/all/20251105100302.2968475-1-pulehui@huaweicloud.com

 kernel/bpf/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..c7c9c78f171a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2536,11 +2536,14 @@ static unsigned int __bpf_prog_ret1(const void *ctx,
 	return 1;
 }
 
+DEFINE_PER_CPU(struct bpf_prog_stats, __dummy_stats);
+
 static struct bpf_prog_dummy {
 	struct bpf_prog prog;
 } dummy_bpf_prog = {
 	.prog = {
 		.bpf_func = __bpf_prog_ret1,
+		.stats = &__dummy_stats,
 	},
 };
 
-- 
2.34.1


