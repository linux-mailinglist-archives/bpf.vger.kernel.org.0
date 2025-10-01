Return-Path: <bpf+bounces-70140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46446BB1998
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3097A9B3B
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A22ED853;
	Wed,  1 Oct 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="FZVF9LpV"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DA2EC572;
	Wed,  1 Oct 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346980; cv=none; b=pUHZyE1AqHi8gqy8gFNh8y2UUIIcFQ+D45AVWUs5jpTqMlFvUenFV+UOZQ2xH09nN4NIEUEa1zbKzHFKFNpY6O5PpD1+NxOw1K3KRuxGBGBstrZp2tfNd1CO10QXJtzjJI/zilsn59GdmRlBQRgLNgz7qf5B/u9aMQ+wW2UB76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346980; c=relaxed/simple;
	bh=NWsYpEpETenNEyKSRXa29OMqa6Pxo8OfTji6y8Fv7Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKO1F/Wa9KxJcdlpycX8/eu4McYTYBM98whEg4bY1BIJk4EDuxGI7ou2LeNzR870MoI8hBWYRQYtf3h1PFNVr+f+30iL/0fW1mUKB2cTDozVDAe/v1oAqOptXBEqzPE9asNF5/E8TE8Ns1IGmjf2+Efpwhm/bpqT7rUi6Cu67xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=FZVF9LpV; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ccQ3f5Bmmz9vDC;
	Wed,  1 Oct 2025 21:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759346974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOO4zIFMU9Puw7DtgnyRREAICz2pYE44sks8lsosEKM=;
	b=FZVF9LpVbdZ3hYQehDLr5Fr8xGiEMBScuU4blRYHhmwotns33swtzIAC+vfrjmJ9vHT+qV
	v7eVRU/Qe5H02I1UrFxHnYvwjAU88oecVJxxMVLGTCiESVCRkqUk7euFdyP5ED4e4FPc4q
	sd2bt54G/3ebajYiHaCxm/HQsQ1L8SrAPu0QhMqr9Br8OCeuPCbH0AuuzNH7JTqHl9Lh41
	Zpf+dCBheABilMYF7pu8eXfNrCPryhdBtS7wgkBqDrAaI6Eoqe/qujicGg96phZKV0qJSc
	dDPeq88hPBUxWoG5xdJl4z2XG7fHfB5ndGpH9VpBE2tfDQrkv76IpkQvDVh/Dg==
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH v4 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer
Date: Thu,  2 Oct 2025 00:58:58 +0530
Message-ID: <20251001192859.2343567-2-listout@listout.xyz>
In-Reply-To: <20251001192859.2343567-1-listout@listout.xyz>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
 <20251001192859.2343567-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In check_alu_op(), the verifier currently calls check_reg_arg() and
adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
However, if the destination register holds a pointer, these scalar
adjustments are unnecessary and potentially incorrect.

This patch adds a check to skip the adjustment logic when the destination
register contains a pointer.

Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58
Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")
Suggested-by: KaFai Wan <kafai.wan@linux.dev>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
Changes v4:
Cleaning up, instead of using __is_pointer_value it's further
simplified by checking if regs[insn->dst_reg].type of SCALAR_VALUE
Link: 

Changes in v3:
using __is_pointer_value to check if register if of pointer type
Link: https://lore.kernel.org/all/20251001095613.267475-1-listout@listout.xyz/

Changes in v2: 
Checking if reg->map_ptr is NULL in bpf/log.c but with cleaner approach
(wrong approach)
Link: https://lore.kernel.org/all/20250923174738.1713751-1-listout@listout.xyz/

Changes in v1: 
Checking if reg->map_ptr is NULL in bpf/log.c (wrong approach)
Link: https://lore.kernel.org/all/20250923164144.1573636-1-listout@listout.xyz/
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..f3d8ba142faa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15645,7 +15645,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 
 		/* check dest operand */
-		if (opcode == BPF_NEG) {
+		if (opcode == BPF_NEG &&
+		    regs[insn->dst_reg].type == SCALAR_VALUE) {
 			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
 			err = err ?: adjust_scalar_min_max_vals(env, insn,
 							 &regs[insn->dst_reg],
-- 
2.51.0


