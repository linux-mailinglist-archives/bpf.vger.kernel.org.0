Return-Path: <bpf+bounces-34290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0252A92C4EA
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCFD1F22035
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32C187845;
	Tue,  9 Jul 2024 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOtP9RNv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE618D4BC
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557782; cv=none; b=Ty7o3aNKt0k9hGY+RM6g168JRKAk5ozuXEf8znm8I9ju65Qdqk+TwoSsOI6i69D8i1HBO1ZaqmQ/7csG17MB06oQLTsIfInuGjaHTRwSZx9HQspshdiBJWd9/Aym+vByuKJ924hxCshijdB6+oJHMR7T/LVPhjl0yA8VCJuvmKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557782; c=relaxed/simple;
	bh=azpAbr+6SOKGRgY4Eh1WfByGTMRsHGb35RAVJRMiCV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkhI5gXKBPa+PGVLFlj+AN5R7+RMcpVknsL21nvF0cG3Hm3EVvJR4OqGqGVlYQXSuvdjg2rdUEmDAcN6grqgHZZxhmiMy9zTZnQ26vDKZXYEPjIvx6kHR6K0QMU5+z5tK+4Es/py0pO40amvd34H0Qr/LDPaQoGb0rpekElNTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOtP9RNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D758EC4AF07;
	Tue,  9 Jul 2024 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557782;
	bh=azpAbr+6SOKGRgY4Eh1WfByGTMRsHGb35RAVJRMiCV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOtP9RNv/JJu5/jCkyS+M9BS7SUxW2ejks9KZ2ihPkFrlS7aAoZk8sxAThaQUKtKe
	 FGTCLUADHeEpuzCEU2WvXjl3bJEeV/6zSrDs3zDGSWTxqoTAHEGKhdKq/h6MEpSHJd
	 4RcAwWx+IpDrpEJcMitOcH3zc5WznjT4ZXes4BpdcPH2uN/Y7BYcfTRwEQ6buTU2RF
	 iejKag7U/HcGzFOXmA5TICySYvNi/wKo9oM21D58l4OipS1nccsKnT3V257DXvZ9LG
	 hMrwJwzDYuzvt/BPe7NwBXaBKtjGPY3ujolo3mSwaRmdetENQvxL3m4XChvN0UVtzM
	 D94czy+e+RVyQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 03/10] lib/buildid: remove single-page limit for PHDR search
Date: Tue,  9 Jul 2024 13:42:38 -0700
Message-ID: <20240709204245.3847811-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709204245.3847811-1-andrii@kernel.org>
References: <20240709204245.3847811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that freader allows to access multiple pages transparently, there is
no need to limit program headers to the very first ELF file page. Remove
this limitation, but still put some sane limit on amount of program
headers that we are willing to iterate over (set arbitrarily to 256).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index ce48ffab4111..49fcb9a549bf 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -8,6 +8,8 @@
 
 #define BUILD_ID 3
 
+#define MAX_PHDR_CNT 256
+
 struct freader {
 	void *buf;
 	u32 buf_sz;
@@ -216,9 +218,9 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 	phnum = ehdr->e_phnum;
 	phoff = READ_ONCE(ehdr->e_phoff);
 
-	/* only supports phdr that fits in one page */
-	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
-		return -EINVAL;
+	/* set upper bound on amount of segments (phdrs) we iterate */
+	if (phnum > MAX_PHDR_CNT)
+		phnum = MAX_PHDR_CNT;
 
 	for (i = 0; i < phnum; ++i) {
 		phdr = freader_fetch(r, phoff + i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
@@ -248,9 +250,9 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 	phnum = ehdr->e_phnum;
 	phoff = READ_ONCE(ehdr->e_phoff);
 
-	/* only supports phdr that fits in one page */
-	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
-		return -EINVAL;
+	/* set upper bound on amount of segments (phdrs) we iterate */
+	if (phnum > MAX_PHDR_CNT)
+		phnum = MAX_PHDR_CNT;
 
 	for (i = 0; i < phnum; ++i) {
 		phdr = freader_fetch(r, phoff + i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
-- 
2.43.0


