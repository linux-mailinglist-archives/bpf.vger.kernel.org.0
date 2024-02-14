Return-Path: <bpf+bounces-21928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8F8540D3
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295ED28DD0C
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1418370;
	Wed, 14 Feb 2024 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVTqTRrT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F9B641
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870350; cv=none; b=prFzTgLyoRduEBrWT6P0w9CmW8BW9VwmTJ7yv0QCmE40Lxf9eK+mHO9+zVqfAZkkKBo+BVrYAflGZfBMUPHRDxb43+PQOgxKAGMe/EOBrO0p4bjP18GMYfjy0RAb9POzgjjk+/Tsb9+uu7ANFNYCgDNjkaUkJ6TISsBmUoG2WjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870350; c=relaxed/simple;
	bh=71zp8Tof5AdJ44vcPGUDE2WjD/WPn0PIdQnHriyispQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QsbqPEJgii/3Aca20sY9vdrwZM7LBMK8iGesysaWoKb7G1I2JN7QizblysSbxC8j8IBFaZAbqgOBWaMmw4hwiHi2W2d7+9mMwzTtqQ8333tAc93K/IrgmztX6wZKzGn12OGYdd4nF1wjnN8RMhqQc01HjSe8DrQTZpcWttWVz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVTqTRrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06AFC433C7;
	Wed, 14 Feb 2024 00:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707870349;
	bh=71zp8Tof5AdJ44vcPGUDE2WjD/WPn0PIdQnHriyispQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RVTqTRrTDvSRCUP6O5FenEjnZuEHv2eIwq4MrxR3JrpMR502XMQ9k2TkVQTb3rcdx
	 41tSgdEM6VT0iwUqG/mZ6I7yE67072xcAJOpQicGldhLFj9tAAFCCUMpiy8Qq/7OQ+
	 6lphZVpVLMGtkZ4spPuKzMQTzuDxmX3B0vWcL4zZ8qShVo+ZRlY6pbb4K06nLxNAjf
	 JEYhoIvjcnukYuCyt+dWw2WDBSBvqcq01FEYyqmqFE0x9JP4kCK+h6h8ImH+d+ckWY
	 yNoKE8ICLdR6Ro9DDybzKsGjUln1++98UGbX21JsLJzXb1LupskFTelCbF6C0Hi/SU
	 Aw7cjn8LYpHog==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: use O(log(N)) binary search to find line info record
Date: Tue, 13 Feb 2024 16:23:11 -0800
Message-Id: <20240214002311.2197116-1-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Real-world BPF applications keep growing in size. Medium-sized production
application can easily have 50K+ verified instructions, and its line
info section in .BTF.ext has more than 3K entries.

When verifier emits log with log_level>=1, it annotates assembly code
with matched original C source code. Currently it uses linear search
over line info records to find a match. As complexity of BPF
applications grows, this O(K * N) approach scales poorly.

So, let's instead of linear O(N) search for line info record use faster
equivalent O(log(N)) binary search algorithm. It's not a plain binary
search, as we don't look for exact match. It's an upper bound search
variant, looking for rightmost line info record that starts at or before
given insn_off.

Some unscientific measurements were done before and after this change.
They were done in VM and fluctuate a bit, but overall the speed up is
undeniable.

BASELINE
========
File                              Program           Duration (us)   Insns
--------------------------------  ----------------  -------------  ------
katran.bpf.o                      balancer_ingress        2497130  343552
pyperf600.bpf.linked3.o           on_event               12389611  627288
strobelight_pyperf_libbpf.o       on_py_event              387399   52445
--------------------------------  ----------------  -------------  ------

BINARY SEARCH
=============

File                              Program           Duration (us)   Insns
--------------------------------  ----------------  -------------  ------
katran.bpf.o                      balancer_ingress        2339312  343552
pyperf600.bpf.linked3.o           on_event                5602203  627288
strobelight_pyperf_libbpf.o       on_py_event              294761   52445
--------------------------------  ----------------  -------------  ------

While Katran's speed up is pretty modest (about 105ms, or 6%), for
production pyperf BPF program (on_py_event) it's much greater already,
going from 387ms down to 295ms (23% improvement).

Looking at BPF selftests's biggest pyperf example, we can see even more
dramatic improvement, shaving more than 50% of time, going from 12.3s
down to 5.6s.

Different amount of improvement is the function of overall amount of BPF
assembly instructions in .bpf.o files (which contributes to how much
line info records there will be and thus, on average, how much time linear
search will take), among other things:

$ llvm-objdump -d katran.bpf.o | wc -l
3863
$ llvm-objdump -d strobelight_pyperf_libbpf.o | wc -l
6997
$ llvm-objdump -d pyperf600.bpf.linked3.o | wc -l
87854

Granted, this only applies to debugging cases (e.g., using veristat, or
failing verification in production), but seems worth doing to improve
overall developer experience anyways.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 594a234f122b..2dfac246a27d 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -333,7 +333,8 @@ find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
 {
 	const struct bpf_line_info *linfo;
 	const struct bpf_prog *prog;
-	u32 i, nr_linfo;
+	u32 nr_linfo;
+	int l, r, m;
 
 	prog = env->prog;
 	nr_linfo = prog->aux->nr_linfo;
@@ -342,11 +343,30 @@ find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
 		return NULL;
 
 	linfo = prog->aux->linfo;
-	for (i = 1; i < nr_linfo; i++)
-		if (insn_off < linfo[i].insn_off)
-			break;
+	/* Loop invariant: linfo[l].insn_off <= insns_off.
+	 * linfo[0].insn_off == 0 which always satisfies above condition.
+	 * Binary search is searching for rightmost linfo entry that satisfies
+	 * the above invariant, giving us the desired record that covers given
+	 * instruction offset.
+	 */
+	l = 0;
+	r = nr_linfo - 1;
+	while (l < r) {
+		/* (r - l + 1) / 2 means we break a tie to the right, so if:
+		 * l=1, r=2, linfo[l].insn_off <= insn_off, linfo[r].insn_off > insn_off,
+		 * then m=2, we see that linfo[m].insn_off > insn_off, and so
+		 * r becomes 1 and we exit the loop with correct l==1.
+		 * If the tie was broken to the left, m=1 would end us up in
+		 * an endless loop where l and m stay at 1 and r stays at 2.
+		 */
+		m = l + (r - l + 1) / 2;
+		if (linfo[m].insn_off <= insn_off)
+			l = m;
+		else
+			r = m - 1;
+	}
 
-	return &linfo[i - 1];
+	return &linfo[l];
 }
 
 static const char *ltrim(const char *s)
-- 
2.39.3


