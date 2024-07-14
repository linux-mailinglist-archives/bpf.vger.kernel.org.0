Return-Path: <bpf+bounces-34749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B519308D2
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38C1B212FC
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D0A1643A;
	Sun, 14 Jul 2024 06:55:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3948514A81;
	Sun, 14 Jul 2024 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720940121; cv=none; b=Uy20ArG6K+7e21UY0lJkz6+cJ6JdfHCuokit+1J1Yqr75Lmn1q6YJrkHeO22LfTNI2H/Hkfbk3oKdG8bGofATyR25vgWT5lHRsTLBd/pdNcEC2RgXUv2rLoTpYNwuDHLMjT+Vo+nzZZai9FR48YZ+4Whsz9q9fawh1S1F3TiPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720940121; c=relaxed/simple;
	bh=G2UYAZbIACJBeDr9ndHd8ff6w2mMSgA0YsCtCyUYTkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TC0w5EKFHn2p+Hjq2dSG7yLEFnvZIix+3KTp7BnNA4HDM78r3r3l8ljrVQ/ZL/IhBZdmynk2gp2IbPKWXLHhH5oBBCMy07AWaEMd75yYedHc6Bwod0G4czE5Lw0khBUie+cZchf7i4za8upy6LGYlHdqhx9yERlSxbjwVrXgTWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WMGKy2p4jz4f3jdb;
	Sun, 14 Jul 2024 14:55:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 401CE1A0170;
	Sun, 14 Jul 2024 14:55:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXuzlQdpNmimNZAA--.49126S4;
	Sun, 14 Jul 2024 14:55:14 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next] perf/bpf: Use prog to emit ksymbol event for main program
Date: Sun, 14 Jul 2024 14:55:33 +0800
Message-Id: <20240714065533.1112616-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXuzlQdpNmimNZAA--.49126S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4xuF4rWFyfCrWfGw1UGFg_yoW5WFyDpF
	W3Gw1Sy34rX3y2qw45Jr4rJa4UGr4kXanIgr93J3yFvr43Cr93WayUGayfu3s0yryjkFyf
	u3s2v3y3Kr98JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Since commit 0108a4e9f358 ("bpf: ensure main program has an extable"),
prog->aux->func[0]->kallsyms is left as uninitialized. For bpf program
with subprogs, the symbol for the main program is missed just as shown
in the output of perf script below:

 ffffffff81284b69 qp_trie_lookup_elem+0xb9 ([kernel.kallsyms])
 ffffffffc0011125 bpf_prog_a4a0eb0651e6af8b_lookup_qp_trie+0x5d (bpf...)
 ffffffff8127bc2b bpf_for_each_array_elem+0x7b ([kernel.kallsyms])
 ffffffffc00110a1 +0x25 ()
 ffffffff8121a89a trace_call_bpf+0xca ([kernel.kallsyms])

Fix it by always using prog instead prog->aux->func[0] to emit ksymbol
event for the main program. After the fix, the output of perf script
will be correct:

 ffffffff81284b96 qp_trie_lookup_elem+0xe6 ([kernel.kallsyms])
 ffffffffc001382d bpf_prog_a4a0eb0651e6af8b_lookup_qp_trie+0x5d (bpf...)
 ffffffff8127bc2b bpf_for_each_array_elem+0x7b ([kernel.kallsyms])
 ffffffffc0013779 bpf_prog_245c55ab25cfcf40_qp_trie_lookup+0x25 (bpf...)
 ffffffff8121a89a trace_call_bpf+0xca ([kernel.kallsyms])

Fixes: 0108a4e9f358 ("bpf: ensure main program has an extable")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
Hi,

ksymbol for bpf program had been broken twice, and I think it is better
to add a bpf selftest for it, but I'm not so familiar with the
perf_event_open(), for now I just post the fix patch and will post the
selftest later.

 kernel/events/core.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0128c5ff278..e1b7d9e61fa0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9289,21 +9289,19 @@ static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
 	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
 	int i;
 
-	if (prog->aux->func_cnt == 0) {
-		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
-				   (u64)(unsigned long)prog->bpf_func,
-				   prog->jited_len, unregister,
-				   prog->aux->ksym.name);
-	} else {
-		for (i = 0; i < prog->aux->func_cnt; i++) {
-			struct bpf_prog *subprog = prog->aux->func[i];
-
-			perf_event_ksymbol(
-				PERF_RECORD_KSYMBOL_TYPE_BPF,
-				(u64)(unsigned long)subprog->bpf_func,
-				subprog->jited_len, unregister,
-				subprog->aux->ksym.name);
-		}
+	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
+			   (u64)(unsigned long)prog->bpf_func,
+			   prog->jited_len, unregister,
+			   prog->aux->ksym.name);
+
+	for (i = 1; i < prog->aux->func_cnt; i++) {
+		struct bpf_prog *subprog = prog->aux->func[i];
+
+		perf_event_ksymbol(
+			PERF_RECORD_KSYMBOL_TYPE_BPF,
+			(u64)(unsigned long)subprog->bpf_func,
+			subprog->jited_len, unregister,
+			subprog->aux->ksym.name);
 	}
 }
 
-- 
2.29.2


