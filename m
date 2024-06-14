Return-Path: <bpf+bounces-32182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4528908972
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806101F28BE9
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7112193091;
	Fri, 14 Jun 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4BM4jLm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D10149C4A;
	Fri, 14 Jun 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360114; cv=none; b=hOVm+pmfG1F99O11nwhtTJmi2zTMBS6cHgtPJgyYjHiv7Oo+8h+1NTQzJToudWOHF7a4ukbWdoIlqQvCKaO0F++G8NkzfC9AzxSDOdcCZriHAEkdnqwWittY1OG95w7ylRKpSCXY7B543ZViog3NUy+aVJb65yJyZi7+QAaC4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360114; c=relaxed/simple;
	bh=tWBe86ddbolKGJQq2Ve9/vxZLYSFRHvwl7gFK1J81y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCS29PMC4FMtpTw4TR729oH12w1VNyaDz7wdLBtRdtVfgUdMe7FFgSQNf7uGNwpjU3y2AVK8w0PFxQy3Q7EUYRhhmQd9OkhCCl/7LNZNJj6QyycBTb621BKga9vtSz1oxpKr+4a2Z6lqn+v2hWGIQHVzn9otN6LEoFoBtfKKmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4BM4jLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B254AC2BD10;
	Fri, 14 Jun 2024 10:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718360113;
	bh=tWBe86ddbolKGJQq2Ve9/vxZLYSFRHvwl7gFK1J81y4=;
	h=From:To:Cc:Subject:Date:From;
	b=g4BM4jLmM+sdFob9fg5jZeUdKmPlD0X3KC6gFjDRpXsJV8UYQVGDeBKkbkLK75Yz6
	 I0g0nhapSddehyXg4YTi8/b7QQmFvE8xqYYhKApbsnRrxI6zWgbryrr+5s7pTWxSu4
	 K1/k5cVwbo6yTZkr878ZiTLwTwipwsgSyhJfVYow4fYXw2lY1PBGhh92BCDo5GQ3WA
	 DagGnaW+g0sKpsGslv4Y7F8LaamFobjTitmo76/jthOHpq0iAOirYEBSDLs2mSWHdl
	 v/WVxwW8zwN823jPaeL1eFuQq1BAPbWtvfito/UE4PaVPS4wlCl/lTn8C7umIIjT/v
	 CDqiLarI4EjNA==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] bpf/selftests: Fix __NR_uretprobe in uprobe_syscall test
Date: Fri, 14 Jun 2024 12:15:09 +0200
Message-ID: <20240614101509.764664-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixing the __NR_uretprobe number in uprobe_syscall test,
because it changed due to merge conflict.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c8517c8f5313..bd8c75b620c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
 }
 
 #ifndef __NR_uretprobe
-#define __NR_uretprobe 463
+#define __NR_uretprobe 467
 #endif
 
 __naked unsigned long uretprobe_syscall_call_1(void)
-- 
2.45.1


