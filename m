Return-Path: <bpf+bounces-70071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C965BAFEFF
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 11:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8861C6603
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CC296BBC;
	Wed,  1 Oct 2025 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="kvmv4k3D"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFE28C5BE;
	Wed,  1 Oct 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312613; cv=none; b=h2Zb4t2gLAnx6tAkYMUit7FpOCNCIorIA9qhQNqaEwptUjQ1UAB+O6QbBDMcxXvpK/BpzpqzC4xJRXPapXl3Qm9uUcsbmt4yJV/gFu4GtdVTUm1Mhy5eI9TK9zTFreSdt7M4URYYZ+GEqzgiXgK/PEvrlS0R46yqvwuYod9dOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312613; c=relaxed/simple;
	bh=b+/c4W+RzknpNkDay02LrrvdC3AQVy2QaY78zoLH9j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNdlutJPWf9u4ojG8zZePlmZdaJbEqpkAZsGT9DOIxbItviwgyPIcPw9CjGQwtmawyKDSEEm97Eyfq8r2SwjViCRjaw9fUstFGni1m2BQidtb8CISshRQEJ+s2cfq5wkso+PYaB1zy+BmFy2yg7oyMt8PkqaAnb5FsPFg30Dc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=kvmv4k3D; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cc9Lc5fzsz9tgh;
	Wed,  1 Oct 2025 11:56:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759312600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZAuF+EBwynVPrSFcy+C7ZyNzvXJyx6NhxkrvAlXADY=;
	b=kvmv4k3DWz3QHJwM/6VkxaPyOCg+rLUyR+GvkOp/0Qf6II5evj5XTY8vdr7c2Shb1o+5YK
	TLaknGgeAOq3GQklqr2vS6S6Ge45jH8krDQgm7wUKz0p8mM/vC9yk8DQyZtkEsJ9TwPhKc
	rs1MxQXljSySIDWfOGQG5BSPjiOdfTKnBMlD3f7XJaTSk4hpTcqiS4niVTY3YL+oxWahVq
	gjiq9/FP9mBE2czx4B8opp78OMZ/79oUBnvNBMBvpAHbDmLRo/RqYhZyCfKZsHR5zGh/Ep
	xg+r9FWLMmoMIRUsF9WCe2l94FzLIBuB/GGV8F8zXEy9V8Cqm1RX6XCUasn+Hg==
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
	kafai.wan@linux.dev
Subject: [PATCH v3 0/2] bpf: Fix verifier crash on BPF_NEG with pointer register
Date: Wed,  1 Oct 2025 15:26:11 +0530
Message-ID: <20251001095613.267475-1-listout@listout.xyz>
In-Reply-To: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a crash in the BPF verifier triggered when the BPF_NEG
operation is applied to a pointer-typed register. The verifier now
checks that the destination register is not a pointer before performing
the operation.

Tested with syzkaller reproducer and new BPF sefltest.
Closes: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58

Brahmajit Das (1):
  bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer

KaFai Wan (1):
  selftests/bpf: Add test for BPF_NEG alu on CONST_PTR_TO_MAP

 kernel/bpf/verifier.c                          |  3 ++-
 .../bpf/progs/verifier_value_illegal_alu.c     | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.51.0


