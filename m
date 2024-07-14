Return-Path: <bpf+bounces-34764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B6930931
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A521C20974
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7513C81C;
	Sun, 14 Jul 2024 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug3WLnQh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F944AECB;
	Sun, 14 Jul 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945790; cv=none; b=TxS7M0uV8CM16414Bb2ElAnfl1qeUXgb6RDl64h6AU8XFJAbUXe+/PaVr9CHNrbZiFO9A9VyfMcwjmhcgZEqCiHnJPlftFAuCxzap4IeHYHjKH0TmI50Y1d01Vd8JSQarY9TPaxppH0V6QH+vm+dEODVmZWUvyPnlSlzyl8NKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945790; c=relaxed/simple;
	bh=LJPviOMmRIjz0uro4r36QiA8kKEiN0rClRqnRvEe5pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHW24qi6OdhmxjD2ePbiZOiaAHeCo7VxUXLbe2GYoa4MS5A4+JyPzjMPFgEmvav0peb3HIqkeEZdfGpI+4sMwlxjzhl055QJWGTrK5glgfXQRYZwbUzw5s8SNOPPN/WBfOtbnH1HQvwJW7vhLTBy+mpeSNswNBJwU4ZiP1qAogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug3WLnQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AA3C116B1;
	Sun, 14 Jul 2024 08:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945790;
	bh=LJPviOMmRIjz0uro4r36QiA8kKEiN0rClRqnRvEe5pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ug3WLnQhtxYBuJ3k5NkmRlo7cmPPGONQDtikam7v0eKto6gU2mk16oxGh+1+HxGR4
	 /JjEiD3VTDoYyrHzuBVgAlt7TlAVddyYeGuVmytB5zYxN1A4/PCUsr0WFJbyQi2bYM
	 FASrcPigNL4lAUGQU5GhSslZCWjqUoLKXlWAgMYjhrU0an5dpQhUAU/290RkI4FsAD
	 oYShdgBIqm3Fea0HO+v3Ag4jNNwRrD6IHZWKJ436F5mGy/+jojZ0bPS22hsrJ02Iz2
	 PXu1Pyy2IVUxvJCzw4LAAabMwxkAuEEmIdMf3lX24ZCCU/496TWOxWFZM9Z6Yo3N0o
	 KH9kYrZSWOxvw==
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
Subject: [RFC PATCH v4 07/17] powerpc/ftrace: Skip instruction patching if the instructions are the same
Date: Sun, 14 Jul 2024 13:57:43 +0530
Message-ID: <2aba0401f39fee0726e3342b21160d2b05bfa53b.1720942106.git.naveen@kernel.org>
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

To simplify upcoming changes to ftrace, add a check to skip actual
instruction patching if the old and new instructions are the same. We
still validate that the instruction is what we expect, but don't
actually patch the same instruction again.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index fe0546fbac8e..719517265d39 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -82,7 +82,7 @@ static inline int ftrace_modify_code(unsigned long ip, ppc_inst_t old, ppc_inst_
 {
 	int ret = ftrace_validate_inst(ip, old);
 
-	if (!ret)
+	if (!ret && !ppc_inst_equal(old, new))
 		ret = patch_instruction((u32 *)ip, new);
 
 	return ret;
-- 
2.45.2


