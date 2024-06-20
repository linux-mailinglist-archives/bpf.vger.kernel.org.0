Return-Path: <bpf+bounces-32619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED90F911198
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 20:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A779F28841C
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 18:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FABE1B5821;
	Thu, 20 Jun 2024 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW9h6l4o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F261B4C52;
	Thu, 20 Jun 2024 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909849; cv=none; b=hRrCVqW9207ONuvYzKCk+FTT/hvaD5egPKFe22UKZ4EPupJCR8pSSnG5muBa8B39HlbawP8E/BAbzU1y50qypm7TcJDF2/6SZRYHRZ09tsiHy9KsxAMzdSv/O8c15pY0aYZ4DTDoRXSRTAp85ptRWzyNsirG3KbZftfybkoovnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909849; c=relaxed/simple;
	bh=0ZTJnkb+12h9K7fDEj4OZ82shNV1u3ppXKLPLG9H5Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oN26YjJNT2p8rpZxM9XJvU9PwkdSH55GqVCMWS991uuNkkxjmcJDgxrha1fjOG8a50hs2OYkK2PO+rMJhoLfB/Cj4FaHyi4ARA0npcivTOAXazzH4eMh0nmHJ/Pb83mG4aA4OyDcCB2tXOQVaKPN40sBcTTABwisyvXgrGoTIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW9h6l4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3871DC4AF11;
	Thu, 20 Jun 2024 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718909849;
	bh=0ZTJnkb+12h9K7fDEj4OZ82shNV1u3ppXKLPLG9H5Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FW9h6l4o/Xsvb/aycYg8aPTzLUE/3h7KlB4uTFFt5Bftou8RIZj1PVuJeiiPhZT6/
	 cE+rBTLi+a8O9C1du7RLA/lht8M9EjUt7W8RaFDcftaUHpE58xFOqmb0qHqUeLFFo4
	 MX0XQrsFVvNKbVTbcr/F74wDSqtI6QUxJ/K6Yf0e0WCuDaQ/9zEqZvQ+oCJvbSF4aU
	 mK3GghfvrZpkPVl/ZtASis7Okq2KGLM5UFT8a7G+QXvIm0DmG2A/cRifbYsZM6jyVX
	 Z6WK1kH9duY9H7aLt2Hhnmxg8fwoMBYFhVJxQUWy70Epnsy5vQrOZhKklkc+ZgDdRC
	 FhmRTY2Av1HYA==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [RFC PATCH v3 03/11] powerpc/module_64: Convert #ifdef to IS_ENABLED()
Date: Fri, 21 Jun 2024 00:24:06 +0530
Message-ID: <e0782cdf680a645d7f8d311a16530be7004bb0ef.1718908016.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718908016.git.naveen@kernel.org>
References: <cover.1718908016.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor refactor for converting #ifdef to IS_ENABLED().

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/module_64.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index e9bab599d0c2..c202be11683b 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -241,14 +241,13 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 		}
 	}
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 	/* make the trampoline to the ftrace_caller */
-	relocs++;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE))
+		relocs++;
+
 	/* an additional one for ftrace_regs_caller */
-	relocs++;
-#endif
-#endif
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		relocs++;
 
 	pr_debug("Looks like a total of %lu stubs, max\n", relocs);
 	return relocs * sizeof(struct ppc64_stub_entry);
-- 
2.45.2


