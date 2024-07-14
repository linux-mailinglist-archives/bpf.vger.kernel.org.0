Return-Path: <bpf+bounces-34765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E380930935
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4CB1F217A9
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680413C9C0;
	Sun, 14 Jul 2024 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stapOdy5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00722313;
	Sun, 14 Jul 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945794; cv=none; b=g0awvAXZeudxIBAxT9e0E3RJuQFvSHAB+tZRaigMQgIGARasOsz4liMYZP0bNyPktlA0M8IcOfiAiSDRYq/oLB4vvb4pveWj4URqdtXj9cZ14DHQfmwjvd0/XgVI+6oNmLop2+Zq/l0H8mewoU5LlKTj3ppvaoCxeGVQNU9WUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945794; c=relaxed/simple;
	bh=Mm/vplktDeK53IWrh3itHTbGXRGKBBYh38qELYFlNEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qESUBcixE3brF53/h2pevlyUDU8xl7cKIdySnpKOOrtYMhwNfbyX6XoS29FwP/O8O5+3mlGLY8kBFWk1hJzzjeO68mrbzE80wsTvv696bJ6MQBwPhROX967Nmk07A87FxOdya+iexrKooiPtPIYKuGOrCFOQf/RjRQPvqA53TWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stapOdy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1705C116B1;
	Sun, 14 Jul 2024 08:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945794;
	bh=Mm/vplktDeK53IWrh3itHTbGXRGKBBYh38qELYFlNEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stapOdy5N4c8llhRcXvRrV2vbGUQLT6Hj3ExUX7QaGkrpIjrCwe6YH514stkMyCBF
	 AsGWkJpmXodE2OTVhBmDwTR9ElgKPuwagg2+0jVfefLnP1EVqqQ0/4E4qeDNiA9aAW
	 ZPisF5J1ctW2+D7aOzCl8gmhBXXwaenz2B/hu41Px/xuB4bCDbwsQ51y4y+glnIEmH
	 /4POmB+DapyXuPhUxi9IP1TtCNCfo9bC3thQ8sOIqlwqpPddTkU1Lyc4TOGm0nZGeN
	 gg9xSx7sHSNCZlWhqf93j2mjYXCQDnejOu7drshSpl/SMU2Cnm6mM91PfMyO+yU1M9
	 y6EOBnNTWF12g==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>,
	linux-kbuild@vger.kernel.org,
	<linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [RFC PATCH v4 08/17] powerpc/ftrace: Move ftrace stub used for init text before _einittext
Date: Sun, 14 Jul 2024 13:57:44 +0530
Message-ID: <ce15b4bfe271a49b5edad8149be113bc78207fda.1720942106.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720942106.git.naveen@kernel.org>
References: <cover.1720942106.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the ftrace stub used to cover inittext before _einittext so that it
is within kernel text, as seen through core_kernel_text(). This is
required for a subsequent change to ftrace.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index f420df7888a7..0aef9959f2cd 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -267,14 +267,13 @@ SECTIONS
 	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
 		_sinittext = .;
 		INIT_TEXT
-
+		*(.tramp.ftrace.init);
 		/*
 		 *.init.text might be RO so we must ensure this section ends on
 		 * a page boundary.
 		 */
 		. = ALIGN(PAGE_SIZE);
 		_einittext = .;
-		*(.tramp.ftrace.init);
 	} :text
 
 	/* .exit.text is discarded at runtime, not link time,
-- 
2.45.2


