Return-Path: <bpf+bounces-74049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B4C4599D
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 10:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF74E94F3
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E452F7AB5;
	Mon, 10 Nov 2025 09:22:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4461E47C5
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766558; cv=none; b=deFOt5gqAJ+gOidL8VosyWg2ksr20y3jE1Yqmgd4C5aGF1fs1YBxX2+OjJSRUXZysSk9uS3NuUNAuBmwjE5IehzLTAynAynVJ/Bukb+GTvTBwae26mx00ryotB8thmiN5YfHvB/QK+ULcPxn5IhgE6obNJ8VD5YjpTvXXyMAL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766558; c=relaxed/simple;
	bh=sfDO0wIwYy61MIpmd5H6l+8K2JRvz1a2rFyeKO92RbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0S2zuIsWb608moF+3mSKZDlaecNqDhF5+gHbdruDaKmUgyr6xCwgNnqay2HpZGYtXabn3wgO5ILE+vUHqcuiBB0f9chVQR1Zw0dhQkh99WtiTiA+CDQzV5IaF+Z1KdL6JT5EE/REwqAHW6FobFiltPMon536/ustUZ3jcXmNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d4khT68qWzKHMpp
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 17:22:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 46B6F1A19B1
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 17:22:32 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgBHpHrWrhFpKQn_AA--.26441S2;
	Mon, 10 Nov 2025 17:22:32 +0800 (CST)
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
Subject: [PATCH bpf v3] bpf: Fix invalid mem access when update_effective_progs fails in __cgroup_bpf_detach
Date: Mon, 10 Nov 2025 09:25:36 +0000
Message-Id: <20251110092536.4082324-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHpHrWrhFpKQn_AA--.26441S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW3KrWDGF4DCF17ZrW5Wrg_yoW8Zr17pa
	ykW343Cwn0gr4DZFWDJF10qr15Jan5WF48GFWUC34fWa17Zrs7Kw18CrZ0yrWYgrZFk3WF
	va1YqrZrJasrZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
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

To fix it, we can use static per-cpu variable to initialize the stats
of dummy_bpf_prog.prog.

Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v3:
- add static for the per-cpu variable.

v2:
- Use static per-cpu variables to initialize the stats of
  dummy_bpf_prog.prog suggested by Eduard.

 kernel/bpf/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..14c15275b424 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2536,11 +2536,14 @@ static unsigned int __bpf_prog_ret1(const void *ctx,
 	return 1;
 }
 
+static DEFINE_PER_CPU(struct bpf_prog_stats, __dummy_stats);
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


