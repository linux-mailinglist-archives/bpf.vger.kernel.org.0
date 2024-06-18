Return-Path: <bpf+bounces-32430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDA090DCB0
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6531C22976
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 19:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0816D4E7;
	Tue, 18 Jun 2024 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2UCoRi8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0016CD2F;
	Tue, 18 Jun 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739791; cv=none; b=kIKosu8RrgI3kMNfUpL6wpAgRtqPi/5TLv8ghx+AEiO9NiHaANwEnDtvA5RRUavOtXH4flIhImiMX8T+7RlK5wW4zDx2Y5LqbDKNDwPuHwYjSbVECERHC0ilyUCpkrNuF/nmENb9ZXeTCHO+hLI5S0TL1zKbOsqMkbMtxSVJdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739791; c=relaxed/simple;
	bh=zwl6yr893bBfcdiqEmF2QjAt7NjyQRGKsWlJ2ipbcWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUEk0YjTVsoDOhF9iv7Nj+nrvP5qHsGyDAZzFbu/GK/3TPBJHpOQXSIQjvpPSa2aAH3p42YfdF6JHpqhPCzB8hQS1bXpmyvRSEkVSLdRNouSNGkpgF7WC/rnqYsAfVnWizulJFvptFZzoBVpPdFsCD/fdYXMv23oPsX6zs9KXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2UCoRi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E78C3277B;
	Tue, 18 Jun 2024 19:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718739791;
	bh=zwl6yr893bBfcdiqEmF2QjAt7NjyQRGKsWlJ2ipbcWw=;
	h=From:To:Cc:Subject:Date:From;
	b=r2UCoRi8UhpFvz6j1T82/uNvxvuR1UoWmq4cH+Q/GoWUNUnz++FOck2Uf4bATbU7V
	 qSrfvyjQ2/Y9Fd8244L29eVy+GdjsS8Pwp9PMQ+yMgKfswyfVvnI+wexmdxEHcC3ZL
	 WGywm17Bb4wdihGiwqbRnh8LIvyu8TdAkhauXcug3fC6A3Yms2GAugxRB5KLtfY85V
	 XKcfOs9kEHGJIyOmCZhfBwmCoQyJWcyZ2Bb37kctHYJ+AGJXqXURPaarfjnb/A12Gy
	 AnBYCpwsp8i8GTc/pDMabaTZLi6iT0zuDQknWCM8APN2bzONcnMwFeltrB6R6f+Fee
	 UaUoU/gRuwMYw==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] uprobe: Do not use UPROBE_SWBP_INSN as static initializer
Date: Tue, 18 Jun 2024 21:43:06 +0200
Message-ID: <20240618194306.1577022-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nathan reported compilation fail for loongarch arch:

  kernel/events/uprobes.c: In function 'arch_uprobe_trampoline':
  arch/loongarch/include/asm/uprobes.h:12:33: error: initializer element is not constant
     12 | #define UPROBE_SWBP_INSN        larch_insn_gen_break(BRK_UPROBE_BP)
        |                                 ^~~~~~~~~~~~~~~~~~~~
  kernel/events/uprobes.c:1479:39: note: in expansion of macro 'UPROBE_SWBP_INSN'
   1479 |         static uprobe_opcode_t insn = UPROBE_SWBP_INSN;

Loongarch defines UPROBE_SWBP_INSN as function call, so we can't
use it to initialize static variable.

Cc: Oleg Nesterov <oleg@redhat.com>
Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2816e65729ac..6986bd993702 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1476,8 +1476,9 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 
 void * __weak arch_uprobe_trampoline(unsigned long *psize)
 {
-	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	static uprobe_opcode_t insn;
 
+	insn = insn ?: UPROBE_SWBP_INSN;
 	*psize = UPROBE_SWBP_INSN_SIZE;
 	return &insn;
 }
-- 
2.45.1


