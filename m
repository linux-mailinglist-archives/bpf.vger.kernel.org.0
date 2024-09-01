Return-Path: <bpf+bounces-38685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F2A9676CC
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D7828144B
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8017F4F2;
	Sun,  1 Sep 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SyfnEoA7"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6A17DFEC
	for <bpf@vger.kernel.org>; Sun,  1 Sep 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725198081; cv=none; b=uZlRRLhHIEDfYRYb/EnroEmF5ARG6p/nMn2rY5ZJClA+ey8krNERMUvoBiJwQrULbrmDVmvwytnhIC27qvTDJlUbfUQDV8nUE4rxp1Vq6xQpfNw2EF7nF8uGBR+kNk72r1eTg7A3mTIaOupSt1c9gzZEZXVeTmuGiXgcaQlXDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725198081; c=relaxed/simple;
	bh=qPaXYSWgQRz7zQRtOwVm1O9VlecsIIWajI47YPesIEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtqJ2Ien3KMX/HDvLaGke5qCtY1MvXGvMzAwXbu+lCu5/966IsyBtUrTVPlWOmywRhrx3strXAhgRw8KMBIt0hAFMYVWPhP/PzCLIvqbPWolxU4XXuYzg/Q4znNMhbp6BJt7M8vVXT4kUqXybbLl0OjnEEc5r/dJfiXG3A3B64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SyfnEoA7; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725198077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//XW1C5dZBrecgnjydaJAHSbDQqnYGyaX8YPs3KNj+Y=;
	b=SyfnEoA7j2BwLNmUTAPgpFF92l2p3r8AbQjpl5qgSx3vAfopvVTw7vz7HA46fB732/imiF
	g78oZPcbp1hdSDmcP4adXQiKg8502nYQT0gjhYIq26Xgbj4UE28AR4utYgSMCvdlL5/8Ir
	/jsHRBDYzPLu+7sWF6xCQgZYwGynkRQ=
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
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Fix verifier tailcall jit selftest
Date: Sun,  1 Sep 2024 21:38:56 +0800
Message-ID: <20240901133856.64367-5-leon.hwang@linux.dev>
In-Reply-To: <20240901133856.64367-1-leon.hwang@linux.dev>
References: <20240901133856.64367-1-leon.hwang@linux.dev>
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


