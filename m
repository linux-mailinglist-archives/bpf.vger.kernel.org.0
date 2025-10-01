Return-Path: <bpf+bounces-70139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD98BB198C
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACF24C01B1
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107822D7D41;
	Wed,  1 Oct 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="UPTarL9p"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E42D640D;
	Wed,  1 Oct 2025 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346969; cv=none; b=nyTHufjGyhEOeoEXPW2rZVgVJoRb2POH1CzYWOCda/FySuWUnAk9JghO2dkVBTChFfqts/4wltIwCRHlB1aC0Gr/3v/SyQtnyJJvrX80Lx6KInGnmhvAIr+V/hLyUWhAgjfU4juD3gUpbvP5KAlZJRkjUhWBWAwVCcrM+vYihD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346969; c=relaxed/simple;
	bh=b+/c4W+RzknpNkDay02LrrvdC3AQVy2QaY78zoLH9j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjcDpxTV0EWFkmyFZ8QTl6FKv/+x2VBAMmeRihjkwFiUkMIMDPYQcsX8ENipjzvfTxRiDYYZvQhQOQuBZ31Q+1iNaagMbK7n+rSRMUpGFsD57eg2VAYHFH032UnlP68fysQ4ZMcAAGdu1k55cS1gvVVEhv+u+A+O/PGPOuzhFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=UPTarL9p; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ccQ3R4jGgz9vD5;
	Wed,  1 Oct 2025 21:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759346963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZAuF+EBwynVPrSFcy+C7ZyNzvXJyx6NhxkrvAlXADY=;
	b=UPTarL9pf2YXTnI6YntZLQpUJRSzkLMX0IUsynyzzkTdttD7QwP37P4x9xkquCPfKA9N0S
	463QFsiby/MhtrQPMoCfURi2NpdmKPCXxEu/CrbKhasp/qwOkB1HiERrPsI0G45AzlO7+z
	ED8Aon1chOFskU60p5AopyZyDvRw4+b8Ys59x+FhpHf2oSykDTEnl1orXPEfhxS1zizPwm
	UeViRkJHRGxtDAa13jinnNL9udOyf2S/+O6R0eaV4zHwyxDjFm5X1bkCb5YJ7cciSyR1+o
	Z+z7OAxGU0AH9DllwY7clwzfQwqa6aZZY0haoL7dRk1MGAywlAmNbC3o2VUSqg==
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
	yonghong.song@linux.dev
Subject: [PATCH v4 0/2] bpf: Fix verifier crash on BPF_NEG with pointer register
Date: Thu,  2 Oct 2025 00:58:57 +0530
Message-ID: <20251001192859.2343567-1-listout@listout.xyz>
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


