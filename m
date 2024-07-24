Return-Path: <bpf+bounces-35570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D561093B94A
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120011C2189F
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951613D882;
	Wed, 24 Jul 2024 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjGKrOEr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0513C683
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861543; cv=none; b=NM3JjjB0bSftr12emCF4fBxlGVt56gOnhM/ONDIN4bcqDx83iMvq3NfU+6eImwOQUu5HZ7UDQFNMS0WdPxJ+UcK0HwCDIY3H6/YM3KHhmwmafeAMg+bIHZFf64gJXCtSVD5CrgmNw36nwdGH98C+/V/Ot7QT2P9NrYioxOSi51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861543; c=relaxed/simple;
	bh=azpAbr+6SOKGRgY4Eh1WfByGTMRsHGb35RAVJRMiCV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQpY9JhQSPdNe/rKRJcAZug0q9OU/wpUjotO9fhvz4Q2VV1RdNVMihWg+OoIk013f5gqWoGPlEDpdz/1kLW9iHH7XMBGlJqvpymNTlsXKrXw2/31GzEAbAEJounHBTX3iC2IwC/s4hZTEznKDyG4vsxKWZgiDhox22x1t/CG3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjGKrOEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826EAC32781;
	Wed, 24 Jul 2024 22:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721861543;
	bh=azpAbr+6SOKGRgY4Eh1WfByGTMRsHGb35RAVJRMiCV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjGKrOEr8SUACvJMfJ7sDCw9seYAgaMF3ZMxmmZpq4vj4qMYa9xiqeAmuuKoohnBo
	 7+duYW6MfOp2gbqM7OlYLUwOZZASzT+SMf6Ho3xL2Pi2VfeWd1EAN9VDOf7BXja1lc
	 mjCGPgBTNySMRJpVrFk0vOteGjmcj5j3cRTooKuOIj5POsidfNKxtbMTM+Jf0ZOcGK
	 dq7xrFoHuU8iDX8rQmcWNNDNH7M7TsroTDYTF5aHNuwhOLmlgW/kXUn8YE2RQAG4sh
	 m957If7WczlcdFQOpAXnRrOnl7eSXxJbNVc0s21u2tDNru3WMztTenxeZuJSV+UdDp
	 RQQWSQ+iWStvA==
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
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 03/10] lib/buildid: remove single-page limit for PHDR search
Date: Wed, 24 Jul 2024 15:52:03 -0700
Message-ID: <20240724225210.545423-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724225210.545423-1-andrii@kernel.org>
References: <20240724225210.545423-1-andrii@kernel.org>
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


