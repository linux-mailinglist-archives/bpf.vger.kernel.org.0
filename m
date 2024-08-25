Return-Path: <bpf+bounces-38032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348595E379
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2231281CDC
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770281547E0;
	Sun, 25 Aug 2024 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hQMx4ZGZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD854437C
	for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724591410; cv=none; b=fFj+w0SWVkFLy3aFh5Ghe38+/v3MBddFplcNT9dFfK4le7hhcdxpiolo+Cv01p0yxWc2iQ9ehbr/+TSn3KXuArbuUhS4hsn+h+O2IxSubyohcKvjlzD9kyj2mzbxUZvAAIlXRueTvUoWC9K3NhmfS0hwwugVil31QboiTR2eQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724591410; c=relaxed/simple;
	bh=qPaXYSWgQRz7zQRtOwVm1O9VlecsIIWajI47YPesIEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDapnsu4CsJXTo3V5/IZKUOGfwQdSsgTH+EcBukCRjYYiObjXGF0Nm2UR4UP6UB6eiHJVjn1Uo2D8PapY1lF9Aodw6tZHmODl5PCq1zQmiON+kcpq7yAZ7U61AtlE7Otn94vr+T0Q+KhVyeT2UrytlI8WMNaAsvahXd4F47tSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hQMx4ZGZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724591406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//XW1C5dZBrecgnjydaJAHSbDQqnYGyaX8YPs3KNj+Y=;
	b=hQMx4ZGZKrZaNjMql6uckBzqHjwZ9rKumsMn8eeTop0t04zG819KIspo2ppgsldFQuDzlH
	3pZUCs0qtQafp0P0PiG+kUAQgLmNXQz6gibjhoLJyVU5MgY8hpE9vt9f08z8MYTL08eTjD
	EwVRalj9e1szQyBRhCLPJYKwW0YcCbA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	eddyz87@gmail.com,
	iii@linux.ibm.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 4/4] selftests/bpf: Fix verifier tailcall jit selftest
Date: Sun, 25 Aug 2024 21:09:43 +0800
Message-ID: <20240825130943.7738-5-leon.hwang@linux.dev>
In-Reply-To: <20240825130943.7738-1-leon.hwang@linux.dev>
References: <20240825130943.7738-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The verifier tailcall jit selftest is broken, because the prologue of x86
bpf prog has been updated to fix the tailcall infinite loop issue caused
by freplace.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
index 8d60c634a114f..60a6045e2d9ae 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -33,8 +33,8 @@ __success
 __arch_x86_64
 /* program entry for main(), regular function prologue */
 __jited("	endbr64")
-__jited("	nopl	(%rax,%rax)")
 __jited("	xorq	%rax, %rax")
+__jited("	nopl	(%rax,%rax)")
 __jited("	pushq	%rbp")
 __jited("	movq	%rsp, %rbp")
 /* tail call prologue for program:
@@ -63,8 +63,8 @@ __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
 __jited("...")
 /* subprogram entry for sub(), regular function prologue */
 __jited("	endbr64")
-__jited("	nopl	(%rax,%rax)")
 __jited("	nopl	(%rax)")
+__jited("	nopl	(%rax,%rax)")
 __jited("	pushq	%rbp")
 __jited("	movq	%rsp, %rbp")
 /* tail call prologue for subprogram address of tail call counter
-- 
2.44.0


