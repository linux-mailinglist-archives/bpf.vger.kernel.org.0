Return-Path: <bpf+bounces-58667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4FABFCEE
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243221BC11C1
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4928ECEE;
	Wed, 21 May 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3Yenc73"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99BD231A3B;
	Wed, 21 May 2025 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852759; cv=none; b=K/cfEUPCbYrKD71pDu7JGcELx+I8dvFwaSX4SgTrafju8V9rlzmqqXcjc8lsIsdu34w6bfXzRcEJG+kPCYQXzyiN14vuDb+an8qcDjFwKaEzZ8gO8pcOmEfTjgeDCXPf/ftWZqmDW6MFPrS95byC9OUQRzXx8X93hsD+hWfRhCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852759; c=relaxed/simple;
	bh=SBLn1mgsCy1yNEPCrv9gyDzDQdEqfOao0Sm1vEgW7PA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DNw2Wb00XCIoPgPeOQdVjqsVeQ0ccitRAWM8l0tM68UhkpoNDxHqYfhyVx0JPPDS9QwaOdSxRz1I3+uSzLocpaJ+qrkJfnIwfwRBw4HHt8I9zw3veOIgwf3t8Jv8fPlSJT3uv/2gv/JG0c/G2/qW1L3qfH3xRp9XGNSHMGs+x/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3Yenc73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA2AC4CEE4;
	Wed, 21 May 2025 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747852758;
	bh=SBLn1mgsCy1yNEPCrv9gyDzDQdEqfOao0Sm1vEgW7PA=;
	h=From:To:Subject:Date:From;
	b=E3Yenc7324pISYWoa4gqYevKb7WyXAR4Sqja93qV0uAesVQUVzrh7qJPfqb+0W7kI
	 V/VJ8bErdlbIyUGaq+2yHgG9ahz2fwykiCcJotU9RF8mPeHsPcwIDBCcohVTYiMQlU
	 ZMgTnDQ3ZmKQYGpEjBN0FDqs2cJeYZwZVQR4wDkLR70Ls7t3wftBqb5mBNLKnZX5nW
	 Eafb8Dk4csYUPwp7R1EALiVWOraeHIkMv6qXb1Q4Kq9niyPh19UW1zk7j01GMCM0dE
	 hU/eB/k4feF0qErLAV4vysR0X+ufke+VFTZnZqnhLuapCisYZRSIccHoIM9N2MHdS1
	 pN9CYluQOlRgQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: verifier: support BPF_LOAD_ACQ in insn_def_regno()
Date: Wed, 21 May 2025 18:39:09 +0000
Message-ID: <20250521183911.21781-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

insn_def_regno() currently returns -1 for a BPF_LOAD_ACQ which is
incorrect as BPF_LOAD_ACQ loads a value from (src_reg + off) into the
dst_reg.

This was uncovered by syzkaller while fuzzing on arm32 architecture
where this function was being called by opt_subreg_zext_lo32_rnd_hi32()
and the warning inside this function was triggered because the
BPF_LOAD_ACQ instruction can read 32 bit values so it needs to be
zero-extended on some archs (eg. arm32) but the destination register (to
be zero-extended) returned by insn_def_regno() was invalid (-1).

Fixes: 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
Reported-by: syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/682dd10b.a00a0220.29bc26.028e.GAE@google.com/T/#m1457e14da8cf6c1d9703b446c224407bca758f5c
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..9aa67e46cb8b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3643,6 +3643,9 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 /* Return the regno defined by the insn, or -1. */
 static int insn_def_regno(const struct bpf_insn *insn)
 {
+	if (is_atomic_load_insn(insn))
+		return insn->dst_reg;
+
 	switch (BPF_CLASS(insn->code)) {
 	case BPF_JMP:
 	case BPF_JMP32:
-- 
2.47.1


