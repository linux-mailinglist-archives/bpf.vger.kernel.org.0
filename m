Return-Path: <bpf+bounces-62839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC3CAFF4AD
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 00:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC915C19E6
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D6243951;
	Wed,  9 Jul 2025 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eu5DiILW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065421B9F1
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099975; cv=none; b=jTAURMvP1mrFI76euOXnq2KmvjRT6fx2LgV3MjKKMtVsC2s/Bi5OsX3Ab3zeP7iD0yFNOg4Z2ZLeRHwmZwALUMu5J8Ltl65XbnK88tR9ipZJgbovIH0loR0npC0LmZ/Mou9m2ehk9p/wCEKXN5ePWwROa9UAv1PgB1qMi4GmgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099975; c=relaxed/simple;
	bh=/dHkRZkput1bVSHKMdHk7tpzrTTNE+NVtMfagcDYmVo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZfY0elslrOZhJ+wSaLROgeWBf8EX/HxdrSkqdtA6CRvyx5uYMeks/usECiQSKCkfGvq2EfDC0YeSf5VsWGdPDCpr35b8bsTRj9G1S9gfqLYX71qtVVn3PtLibe/Wa3yxWlMu9G3zikIAl1rVE34IWQKO3Jy1vp/R7xRhUrNM3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eu5DiILW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso2910445e9.2
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752099972; x=1752704772; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i71hOiXgbL84B1rlMk74ywEskAXmKSHVn4fki+TbdpM=;
        b=eu5DiILW6LR03gtMYkPkO93HHG3bEqJm4J9l++krzX/ETw32TZ6iBwLRYVgQ2YGjZd
         rlYuGqrrstDqyGhI4AZ79RWxy2EfpyU5MHjo1WYKJuSkO79fXVc/JEtNXwC2198RGNWQ
         +WFBcAUyBcWy2UX4Dyz/ujg0YjpS5xg+sBMSxZgae1xalIJRgeFV2EkHj+2+8jEuNmov
         1fycW6KxlqJxMs0e11bOf8+ClM3yW2+fN035rnQg7LR7L4RbQ9Zq5RsMUR9GOSVz1dOf
         Jzgw4XgzFwRGOC0/zb2CpxI+xqtXQKH/snttVkKyRAVqyYBZ9pDqZ4VbHa4YFX5SayI4
         jt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099972; x=1752704772;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i71hOiXgbL84B1rlMk74ywEskAXmKSHVn4fki+TbdpM=;
        b=sopy34tY/yt9IlLZ0YW09cLSs94xy5Fa8H1fnPLqWfMA8PiMdruZzz4P1YVYeXzesT
         Y//1iHTtXbcdW1d4Z6LKoTa5MNoP3qs+Cf86xD4A5c/P4o+A/ZofABfK0GriAHjKdNoo
         TJ+ak9aSQ+AYkvzZxdlIbsHdXNEG+GkjUab5XauortWn4azJ/2noeTjrIpiVYU3qSRMN
         hcpgrDtUcYkTKDj4l2yLjs839bYOtEoj+FE3noPtpIEeav1Ug6nIfR33DTdbhRElRtQY
         ta9Akx7RdbPEQdXe9QC6mM518+/m09lPsOudP4X0HtGJ+oMXZEd4Wu7mPq1CdDLXuDaZ
         ooFw==
X-Gm-Message-State: AOJu0YwGgA36jBakir7wR0Bv8knpV0r/bprwNdxwXzoNVveNS3ATFZA1
	y1vcQwiqdthi3hthXib9dKLNLzoOzdNjSYfXQnK9O94zh1mK46HYTO3SzgW59A==
X-Gm-Gg: ASbGncuBSVd/ZrAxZ3cLPeRNu2dlChkPX1sD6BR8duepzt5EU3Wnq9EMbUt1lK5z5nB
	RCEAMxxa3TFyKlDfu2+jyVeUg/EstEVu+ymxlhDpxDnVs5XafanVnMWFxSelc1lX2YO/nTsrYmS
	bJoWe9y4zqG7Y8vCBpTAliCcGcYJbfiZ9j4nDOSyHCMHiZGwwXzjzuLPS3VgftcNn0WqH+jBH/u
	cwujZYTGh7AdQlm5uN5gDOY60r7dVVuoeua8PGFrL4JE/QU3kBKkESZwMqzmwUBB5m8GWVgmO2l
	STGXDmNGJkex8u6mCvEZrLpxyMPu1M+ifRgkeIUKZsfAVLTFGe089UaO/zwdsj47rT1j4E33gwg
	1j62mjKGqTno3HodCHiF4+ijahJYHPNauTC8shPiClwWiwaAZmt5hsSEMqmo=
X-Google-Smtp-Source: AGHT+IH4DP7vm6zB8zbbKf7DVt2sTtPFVV/zLxeX5SfaKUv53jiG0vrm5lVn0PvD1ED5LjwUsyuOLw==
X-Received: by 2002:a05:600c:8b55:b0:453:a88:d509 with SMTP id 5b1f17b1804b1-454db7eafa0mr14874835e9.10.1752099972318;
        Wed, 09 Jul 2025 15:26:12 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f9b02e2208aa1971.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f9b0:2e22:8aa:1971])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d719sm94560f8f.54.2025.07.09.15.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:26:11 -0700 (PDT)
Date: Thu, 10 Jul 2025 00:26:09 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Forget ranges when refining tnum after JSET
Message-ID: <75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Syzbot reported a kernel warning due to a range invariant violation on
the following BPF program.

  0: call bpf_get_netns_cookie
  1: if r0 == 0 goto <exit>
  2: if r0 & Oxffffffff goto <exit>

The issue is on the path where we fall through both jumps.

That path is unreachable at runtime: after insn 1, we know r0 != 0, but
with the sign extension on the jset, we would only fallthrough insn 2
if r0 == 0. Unfortunately, is_branch_taken() isn't currently able to
figure this out, so the verifier walks all branches. The verifier then
refines the register bounds using the second condition and we end
up with inconsistent bounds on this unreachable path:

  1: if r0 == 0 goto <exit>
    r0: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0xffffffffffffffff)
  2: if r0 & 0xffffffff goto <exit>
    r0 before reg_bounds_sync: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0)
    r0 after reg_bounds_sync:  u64=[0x1, 0] var_off=(0, 0)

Improving the range refinement for JSET to cover all cases is tricky. We
also don't expect many users to rely on JSET given LLVM doesn't generate
those instructions. So instead of reducing false positives due to JSETs,
Eduard suggested we forget the ranges whenever we're narrowing tnums
after a JSET. This patch implements that approach.

Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53007182b46b..e2fcea860755 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16208,6 +16208,10 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		if (!is_reg_const(reg2, is_jmp32))
 			break;
 		val = reg_const_value(reg2, is_jmp32);
+		/* Forget the ranges before narrowing tnums, to avoid invariant
+		 * violations if we're on a dead branch.
+		 */
+		__mark_reg_unbounded(reg1);
 		if (is_jmp32) {
 			t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
 			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
-- 
2.43.0


