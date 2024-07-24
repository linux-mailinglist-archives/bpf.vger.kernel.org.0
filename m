Return-Path: <bpf+bounces-35569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD9D93B949
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A242E2848E2
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301C13CA97;
	Wed, 24 Jul 2024 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ5vO9qh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BF6F068
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861540; cv=none; b=of4HLgDTIcNRxmlgDMPopuCa4ZR6QzJQD5NK7gX2YvrdzF6OwlpulxHrr7pjfERgQqlozQRKHXuMlCTgkNDW8s0id3ZUNEJU/8Lx2q8oZU53Qow4bD+j1wYuE/cJIVaI5QZ5+VPBA89yWASqGzXMRuEdCd3Q7AnUcOqvxnUZXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861540; c=relaxed/simple;
	bh=C6pZlI4b95ZXtBjMHdytNmZo2a2DbuYqAFHnzJFYuwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja1gpEWsSvye2HnkLCodkAqJcoVRVWnMesiAQB2K3MlGfqvgAzQXBENi79NRPnQ3oioX+/v5FbxEG0zUTRSzqUUnTCPMt/1BBZyRHaE4Lzdtj/+3A/L2N2207mYihzXKkfGBJGJ5q5+yhDr3AZvLl8F1xuH1XLp46ejHc09M5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ5vO9qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABE4C32781;
	Wed, 24 Jul 2024 22:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721861540;
	bh=C6pZlI4b95ZXtBjMHdytNmZo2a2DbuYqAFHnzJFYuwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQ5vO9qhbM2GJE56vZsS/lOuShzvkYaxdZObXx7h0SBq5zPT+TFk3JKaQtNMmPm/b
	 Zt/UnPeecmXrpRtskvooa1y4ovCwvyNHYlX4tohVHjDNJsRCuNZXQkXj8xjHj7BCCj
	 Hb9RSTDC86TG4steWnHHflvUG2Ct63Fub0wiHe3Q+4kJmd7M/Jkm/+VoVXZG4ESrGj
	 2XJmGVlhE4wEnkf2FfU4pg+p3VnxQ4d3afOk4exQvPBXk0JfkNYXEUNz0Iqo/btYbJ
	 bhAtrJ0zu3zaRayCKdmpE1OaU33VqG5DMp+b1mkKaVJ4yw/zuIMGHO6QHvuP/d+seT
	 pQoXN6KfioxaA==
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
Subject: [PATCH v2 bpf-next 02/10] lib/buildid: take into account e_phoff when fetching program headers
Date: Wed, 24 Jul 2024 15:52:02 -0700
Message-ID: <20240724225210.545423-3-andrii@kernel.org>
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

Current code assumption is that program (segment) headers are following
ELF header immediately. This is a common case, but is not guaranteed. So
take into account e_phoff field of the ELF header when accessing program
headers.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 1442a2483a8b..ce48ffab4111 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -206,7 +206,7 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 {
 	const Elf32_Ehdr *ehdr;
 	const Elf32_Phdr *phdr;
-	__u32 phnum, i;
+	__u32 phnum, phoff, i;
 
 	ehdr = freader_fetch(r, 0, sizeof(Elf32_Ehdr));
 	if (!ehdr)
@@ -214,13 +214,14 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 
 	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
 	phnum = ehdr->e_phnum;
+	phoff = READ_ONCE(ehdr->e_phoff);
 
 	/* only supports phdr that fits in one page */
 	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
 	for (i = 0; i < phnum; ++i) {
-		phdr = freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
+		phdr = freader_fetch(r, phoff + i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
 		if (!phdr)
 			return r->err;
 
@@ -237,6 +238,7 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 	const Elf64_Ehdr *ehdr;
 	const Elf64_Phdr *phdr;
 	__u32 phnum, i;
+	__u64 phoff;
 
 	ehdr = freader_fetch(r, 0, sizeof(Elf64_Ehdr));
 	if (!ehdr)
@@ -244,13 +246,14 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 
 	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
 	phnum = ehdr->e_phnum;
+	phoff = READ_ONCE(ehdr->e_phoff);
 
 	/* only supports phdr that fits in one page */
 	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
 	for (i = 0; i < phnum; ++i) {
-		phdr = freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
+		phdr = freader_fetch(r, phoff + i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
 		if (!phdr)
 			return r->err;
 
-- 
2.43.0


