Return-Path: <bpf+bounces-70137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09476BB193B
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710851926D91
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F70277035;
	Wed,  1 Oct 2025 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="H3McHMU5"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DC20468E;
	Wed,  1 Oct 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346303; cv=none; b=MiSFU0qM0xHeJe1S519c0Z0s/fuOteQSNp1wJjO56i4ZG/0Cu51tXIJ6+6Ne3eNGOonltGuK776cV+4n9iRnVUowFjWA2cAfrXB1QFHNELt5l8w4MTkwsYVtBGdToVhF0LQ76hRh5AdzRTm1Wlmn68ByyxmTLWrFOrjuY21p10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346303; c=relaxed/simple;
	bh=7c/pfBV5QewVyLQBc0s/t2vvYsqq8BcZ97dslz/nDGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVbRiUT1mMEiuvP6G65TGauEwsKMcBXotY5ILYIfLWSIb6/j1Ujaj4fJfun2NOTUQQe2WJ91WU3i00OsNFd5749KSGvmFl910XPdm0yNFJOCXibZPm72Q/yMG/2dSfizEcRRoXvLkKardQpizR/314BAKRkWNlJ9eqEKkxdx9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=H3McHMU5; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ccPpc52vgz9tgj;
	Wed,  1 Oct 2025 21:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759346296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxfXZ9WZ6TZzRb+UC3EpRPEYKpysPdldEIWFjqgbt4Y=;
	b=H3McHMU5bfnj7lEBLSL9WvtPpBuaDJzHkveZvnfXtVRbU46ULlB5xUTqBPo4e5+AqIuZOy
	LJWDNcYNuYmfLyLOcJ4J859wXhliur0hz4yJsSzP/ipXz48Uz5JiecJ90JMNanrNknwW6S
	Gc8XgsYjao4747dmTXV57bNEKMva8cdqpbNoEmFkIZV33crgExDdqRt0ZaC3i7PWZ83yu/
	navu9aDpdMSaoq/75n2MNoC0Rv87p4RJZ4Ho74Vz7XoOe2B2UbAwx8rbbojlPi7z4b62c+
	buN6Xjt2ywZ0CUyTT/fnMaXQAYxAP8sbQyxeHUJTJEG1w8j5FD/fHhKx8KbxrQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: listout@listout.xyz
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
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH v4 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer
Date: Thu,  2 Oct 2025 00:47:38 +0530
Message-ID: <20251001191739.2323644-2-listout@listout.xyz>
In-Reply-To: <20251001191739.2323644-1-listout@listout.xyz>
References: <20250923164144.1573636-1-listout@listout.xyz>
 <20251001191739.2323644-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ccPpc52vgz9tgj

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
Checking if reg->map_ptr is NULL in bpf/log.c (wrong approach)
Link: https://lore.kernel.org/all/20250923174738.1713751-1-listout@listout.xyz/
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


