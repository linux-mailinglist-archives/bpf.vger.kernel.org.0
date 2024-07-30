Return-Path: <bpf+bounces-36087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803939421AD
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F83E282B21
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBB18DF7C;
	Tue, 30 Jul 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXX4rvyZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3F184553
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371971; cv=none; b=RQlV0BzO6n/641FoX9kGK6DI8J+Y8ed4SStXpXdyE/WiwT8L4OGWGQNwDdcI/4V/x90XR7WPN7DxlDTpcLJjmfilFw0X1YTfDe6HWrliUxzL9EdWuh/s15Im45o8iVpx4VbRl09deGf8JV3Jy5GkNzxRkbrvxJSb+vmKcz7GpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371971; c=relaxed/simple;
	bh=GUqeiOWs92MpwBboJ0qXM//0rJO16RNb6rfoIYo9S10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IblAFjTuA/lj0ZF7DcsPmaZFI06Fd361CXKTXhsoZCNyB5iGQRF0IRoGoXPyZ8fjV2//axxxY3J8OIymVJgfQ7EuTJFcRP+LxeXwOtI2xWtSYpUFhdGxXhMaH8w+LAn1jYg5cYGfPGZC0+qEz5yI2zhr+FuFV4jdtt/8wcy/BTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXX4rvyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A714AC4AF0B;
	Tue, 30 Jul 2024 20:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722371970;
	bh=GUqeiOWs92MpwBboJ0qXM//0rJO16RNb6rfoIYo9S10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXX4rvyZw8450YmvvFwxvviqZXlbtriu8fEHWqrGOUv1XfLApBmyxINQfj3YnY0Bl
	 vZWFVhW9Pq0NMHeRUxsR9VcbZfoK/UrZPdI2aHrEsPKQud1c08aTblq8cSsNZ/ZzZL
	 F6eGgBHvXSiJamEzY85jPZVCALN/Nm3XGIkz2anGpISmD/uJOEk0UTHKNx2hgEyUdU
	 +JmjVyH5xwmx+DgwSZLtMhGRgkD7gC+2AMGhTPqnlp6NPOy2t/Q3Z09Db8/HQwKD0+
	 s+oMsmE63soYP23u6u0EA5vhTbhD6KBNbMBjoAPVsojUIRe4twSJIp+2SMRakWpSrj
	 VqvWJDTkt2X4g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	song@kernel.org,
	jannh@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 bpf-next 04/10] lib/buildid: remove single-page limit for PHDR search
Date: Tue, 30 Jul 2024 13:39:08 -0700
Message-ID: <20240730203914.1182569-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730203914.1182569-1-andrii@kernel.org>
References: <20240730203914.1182569-1-andrii@kernel.org>
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
index ba453a3784d1..095e79158b85 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -8,6 +8,8 @@
 
 #define BUILD_ID 3
 
+#define MAX_PHDR_CNT 256
+
 struct freader {
 	void *buf;
 	u32 buf_sz;
@@ -217,9 +219,9 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 	phnum = READ_ONCE(ehdr->e_phnum);
 	phoff = READ_ONCE(ehdr->e_phoff);
 
-	/* only supports phdr that fits in one page */
-	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
-		return -EINVAL;
+	/* set upper bound on amount of segments (phdrs) we iterate */
+	if (phnum > MAX_PHDR_CNT)
+		phnum = MAX_PHDR_CNT;
 
 	for (i = 0; i < phnum; ++i) {
 		phdr = freader_fetch(r, phoff + i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
@@ -250,9 +252,9 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 	phnum = READ_ONCE(ehdr->e_phnum);
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


