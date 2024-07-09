Return-Path: <bpf+bounces-34289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8B592C4E6
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A621F22341
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2F618D4AE;
	Tue,  9 Jul 2024 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uymoLYG0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31098185635
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557779; cv=none; b=eT9HkdYoSwA/tFC5CNDJRmveCw4xzIQAVl1x05GID9Gh8s0Y/vYZNaNedZRcbq2w7/UMdp8gDJMAI0RfGRbdLynXQ4iMZtkR6lq4ctGvlAloN5e1VcwL6u19MzC9cwLoVYQI9sSKx0quCTtQ/z17XgEPtri70Pb9h02fLaQ2cj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557779; c=relaxed/simple;
	bh=C6pZlI4b95ZXtBjMHdytNmZo2a2DbuYqAFHnzJFYuwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hpzfepq2YCruMBS7IXkoY2phHwohJjyVcGj0yZin4Z7qpmHaccyFWkCIEV0Eo4VoVIDJJlFe1ZgvbgNjDO+LF5mN6Og5O15DJhPedDVnsvhGgDpBervNBYpuOpCSvYHPkqmRf8Owc1Ao9qQo8zDUyi0eXBpqizBAlLPRy6c4M+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uymoLYG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F973C32786;
	Tue,  9 Jul 2024 20:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557778;
	bh=C6pZlI4b95ZXtBjMHdytNmZo2a2DbuYqAFHnzJFYuwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uymoLYG0Q9SwCI7KQesqLBFvnArB0/gIUKz3koEE36GLmnH/t6Hnm7YORfXF3TtLR
	 UKV0yis/gKz6Xvzr4AmQRHAOOAl9ZY30qvaanFYSSOXcssDkZtWcighSgsEbkol3PC
	 tbPi/R15irjarwVMdKzVktzp/HPknwURi5Xgo13swWH1SYajub6Hyuocw+P4Lyl7da
	 77OH9LrPv5JINgUMj1vVlgU0Pcdvi2WJ2ntIj8pH3+wSHEE44KzlMy/r8bAdDWXV+p
	 BRBfzJs3zH6o0SiqpXQ+4qiMCv7zqV0iILQhHpdlRKyh8fVHhjq0M20WNBvrofiX+4
	 ucJ88atYNDVeg==
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
Subject: [PATCH bpf-next 02/10] lib/buildid: take into account e_phoff when fetching program headers
Date: Tue,  9 Jul 2024 13:42:37 -0700
Message-ID: <20240709204245.3847811-3-andrii@kernel.org>
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


