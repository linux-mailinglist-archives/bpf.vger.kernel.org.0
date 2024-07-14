Return-Path: <bpf+bounces-34762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5526493092B
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD272813C1
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932A13AA3F;
	Sun, 14 Jul 2024 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2nELLwT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169971D559;
	Sun, 14 Jul 2024 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945782; cv=none; b=XSdqqGnlAw8tYSmERvl8lJuGy8w8yYoPAzcZRUmYce6ZK0YKeKD//rTb+f9JwVRNm55Va49JONib4SHaYijkIpj1y8bNj70/pIX7OHXQFOq4T9M8MhnoW7Hepdp1eXKu0wRAnFqiisXXw5y14rYPIikUmVfY6HuJ9HLyrG8Cy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945782; c=relaxed/simple;
	bh=hcwZI/Cz4N2FGpqi2ddwK6JV0n+9v2tr6M/Imbpdp7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJvm8Fu5OsvfcV8souxaNMA7OhPoFPOM2FVB8mXKrqTh7ICPiP6UVHBjiFr6gcUNw/fsH6VIvv0NT1qQeSHxNciOIFzMRaLMcH36F5fouYs7xg2JakkiDiKo2h853CVOfC+rkJLUbpFtZfEoCKLrAKsiHY6ObMJQ2brA39mfa/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2nELLwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3398C116B1;
	Sun, 14 Jul 2024 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945781;
	bh=hcwZI/Cz4N2FGpqi2ddwK6JV0n+9v2tr6M/Imbpdp7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2nELLwTExThswaNc3gvJbTEHCVHQG8q3TDv+8qWn0dUsPg3NgQTBhueuZqPUYB0R
	 uKsn+It1hk3tYrV3TFNALoZDe9E1h/hCUf4fjike7RaycGcA0dfxOrjqnf64k+ly1z
	 MgIT1m0Tq/Re+eiK9SGoVe4yO0vUp5vmYMhpIBPB68NU8tE5Kt2xsB/REoZSWraFti
	 qTlL0+VJI3s84x508yJ14T5V3yanX43PLvaDTRJmczicKACS/ox2egOCQWFa/XrOBz
	 bzhi3BQfRhlyZv9Khpw/vIVK3a6g2Si3ki95bt5Hfv+GDZUyaPh3rJS9KGTrUmu/TR
	 Oxer6ihxFwK3w==
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
Subject: [RFC PATCH v4 05/17] powerpc/module_64: Convert #ifdef to IS_ENABLED()
Date: Sun, 14 Jul 2024 13:57:41 +0530
Message-ID: <212c6945c642a8805c73e48d63e63ab5edcaa5dd.1720942106.git.naveen@kernel.org>
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

Minor refactor for converting #ifdef to IS_ENABLED().

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/module_64.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index e9bab599d0c2..1db88409bd95 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -241,14 +241,8 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 		}
 	}
 
-#ifdef CONFIG_DYNAMIC_FTRACE
-	/* make the trampoline to the ftrace_caller */
-	relocs++;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	/* an additional one for ftrace_regs_caller */
-	relocs++;
-#endif
-#endif
+	/* stubs for ftrace_caller and ftrace_regs_caller */
+	relocs += IS_ENABLED(CONFIG_DYNAMIC_FTRACE) + IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS);
 
 	pr_debug("Looks like a total of %lu stubs, max\n", relocs);
 	return relocs * sizeof(struct ppc64_stub_entry);
-- 
2.45.2


