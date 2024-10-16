Return-Path: <bpf+bounces-42195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCAA9A0BDE
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 15:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F23A1C23CC1
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C820B208;
	Wed, 16 Oct 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MwvxH7cc"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21715209F25
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086560; cv=none; b=oGJNIChtkKoqcyXycBx5PtJi1FLG/LE8cScE1EQYMk516Yp722KwUG3aAJ8b8omU5yWzymjv0ykVeUYjk/ixzPZns9LhbcSKP3jwQpnxh0aCKE8N+kTVtRF48ZtqOjr2YLwzWWmWgv8FdnbzItsJX2uwvOCo1gqDZvsxGOwNbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086560; c=relaxed/simple;
	bh=BkumHPdp3xpkvtFTHp4VE7s72zNQZuyK+PYf3+Lj6bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u0HKps5mXodQFhCP7MldWUl0YMt+S+CFtaKM+D9ZEKuJmAucE+/f/DWOT7VNQeO8nUGvgB1cfXKPRQMT93UjbzrzwvK5UEovUARsFqG+0ws43jpJO+WDr1vT+H5iOIki2u0erejfxN+QqWSQAKgJwI63XYZ5dID2VPjBxNykl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MwvxH7cc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=uCHOh/Z0G3t+pSGtFSIJ4dFiSuqSvVnpqGofYrFhSWw=; b=MwvxH7ccPpBcxenWpLO1PlAiF6
	FKSAkvTpCXNWWjoMLBY9V/3B66IONZ2lWinds3kkREDEmUt7t4Be4vk90W6H79t03eIMOwFIomoS8
	NBVEwIiqwD7no0ES+lybj8rfGrfwoo3K41gn4aGsFseZemBkHC3ViJmxrgkh3NZvaNodkICmZPeez
	7BTEhgIkCsj5gxDuYwDuys/0dnGHiGwBU1R1nUIraiWKkhhWT9FQa/Yi3Zro6sVVhI1gFyrTyC03i
	kh0i5PXW8TVfh+0MIo3ZaGX5cdriK0XFzsEV0fZo0BiziaB6ALZyowZkyr4RpAlc513h72PIwUYbv
	rSFNfEVA==;
Received: from 44.248.197.178.dynamic.cust.swisscom.net ([178.197.248.44] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t14Oo-000Nf5-3U; Wed, 16 Oct 2024 15:49:14 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: nathaniel.theis@nccgroup.com,
	ast@kernel.org,
	eddyz87@gmail.com,
	andrii@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH bpf 1/3] bpf: Fix incorrect delta propagation between linked registers
Date: Wed, 16 Oct 2024 15:49:11 +0200
Message-Id: <20241016134913.32249-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27429/Wed Oct 16 10:34:11 2024)

Nathaniel reported a bug in the linked scalar delta tracking, which can lead
to accepting a program with OOB access. The specific code is related to the
sync_linked_regs() function and the BPF_ADD_CONST flag, which signifies a
constant offset between two scalar registers tracked by the same register id.

The verifier attempts to track "similar" scalars in order to propagate bounds
information learned about one scalar to others. For instance, if r1 and r2
are known to contain the same value, then upon encountering 'if (r1 != 0x1234)
goto xyz', not only does it know that r1 is equal to 0x1234 on the path where
that conditional jump is not taken, it also knows that r2 is.

Additionally, with env->bpf_capable set, the verifier will track scalars
which should be a constant delta apart (if r1 is known to be one greater than
r2, then if r1 is known to be equal to 0x1234, r2 must be equal to 0x1233.)
The code path for the latter in adjust_reg_min_max_vals() is reached when
processing both 32 and 64-bit addition operations. While adjust_reg_min_max_vals()
knows whether dst_reg was produced by a 32 or a 64-bit addition (based on the
alu32 bool), the only information saved in dst_reg is the id of the source
register (reg->id, or'ed by BPF_ADD_CONST) and the value of the constant
offset (reg->off).

Later, the function sync_linked_regs() will attempt to use this information
to propagate bounds information from one register (known_reg) to others,
meaning, for all R in linked_regs, it copies known_reg range (and possibly
adjusting delta) into R for the case of R->id == known_reg->id.

For the delta adjustment, meaning, matching reg->id with BPF_ADD_CONST, the
verifier adjusts the register as reg = known_reg; reg += delta where delta
is computed as (s32)reg->off - (s32)known_reg->off and placed as a scalar
into a fake_reg to then simulate the addition of reg += fake_reg. This is
only correct, however, if the value in reg was created by a 64-bit addition.
When reg contains the result of a 32-bit addition operation, its upper 32
bits will always be zero. sync_linked_regs() on the other hand, may cause
the verifier to believe that the addition between fake_reg and reg overflows
into those upper bits. For example, if reg was generated by adding the
constant 1 to known_reg using a 32-bit alu operation, then reg->off is 1
and known_reg->off is 0. If known_reg is known to be the constant 0xFFFFFFFF,
sync_linked_regs() will tell the verifier that reg is equal to the constant
0x100000000. This is incorrect as the actual value of reg will be 0, as the
32-bit addition will wrap around.

Example:

  0: (b7) r0 = 0;             R0_w=0
  1: (18) r1 = 0x80000001;    R1_w=0x80000001
  3: (37) r1 /= 1;            R1_w=scalar()
  4: (bf) r2 = r1;            R1_w=scalar(id=1) R2_w=scalar(id=1)
  5: (bf) r4 = r1;            R1_w=scalar(id=1) R4_w=scalar(id=1)
  6: (04) w2 += 2147483647;   R2_w=scalar(id=1+2147483647,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  7: (04) w4 += 0 ;           R4_w=scalar(id=1+0,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  8: (15) if r2 == 0x0 goto pc+1
 10: R0=0 R1=0xffffffff80000001 R2=0x7fffffff R4=0xffffffff80000001 R10=fp0

What can be seen here is that r1 is copied to r2 and r4, such that {r1,r2,r4}.id
are all the same which later lets sync_linked_regs() to be invoked. Then, in
a next step constants are added with alu32 to r2 and r4, setting their ->off,
as well as id |= BPF_ADD_CONST. Next, the conditional will bind r2 and
propagate ranges to its linked registers. The verifier now believes the upper
32 bits of r4 are r4=0xffffffff80000001, while actually r4=r1=0x80000001.

One approach for a simple fix suitable also for stable is to limit the constant
delta tracking to only 64-bit alu addition. If necessary at some later point,
BPF_ADD_CONST could be split into BPF_ADD_CONST64 and BPF_ADD_CONST32 to avoid
mixing the two under the tradeoff to further complicate sync_linked_regs().
However, none of the added tests from dedf56d775c0 ("selftests/bpf: Add tests
for add_const") make this necessary at this point, meaning, BPF CI also passes
with just limiting tracking to 64-bit alu addition.

Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
Reported-by: Nathaniel Theis <nathaniel.theis@nccgroup.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a8a0b6e4110e..411ab1b57af4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14270,12 +14270,13 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	 * r1 += 0x1
 	 * if r2 < 1000 goto ...
 	 * use r1 in memory access
-	 * So remember constant delta between r2 and r1 and update r1 after
-	 * 'if' condition.
+	 * So for 64-bit alu remember constant delta between r2 and r1 and
+	 * update r1 after 'if' condition.
 	 */
-	if (env->bpf_capable && BPF_OP(insn->code) == BPF_ADD &&
-	    dst_reg->id && is_reg_const(src_reg, alu32)) {
-		u64 val = reg_const_value(src_reg, alu32);
+	if (env->bpf_capable &&
+	    BPF_OP(insn->code) == BPF_ADD && !alu32 &&
+	    dst_reg->id && is_reg_const(src_reg, false)) {
+		u64 val = reg_const_value(src_reg, false);
 
 		if ((dst_reg->id & BPF_ADD_CONST) ||
 		    /* prevent overflow in sync_linked_regs() later */
-- 
2.43.0


