Return-Path: <bpf+bounces-36196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6610A943E3E
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980AF1C2242E
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C2F1B9B54;
	Thu,  1 Aug 2024 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMw5Y1Gb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1A1B9B44;
	Thu,  1 Aug 2024 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472289; cv=none; b=OeSml5VaWVz8pPR9+eTtdQr54tjf2Ewa8Em0kLBjgGnwPBvwd0U+7k2mxRciNnUgvppwDX58B0kMypz3B7SmVaJQe3ZcB7EuDFdT1smmvpaXKfXwft3NgPzq93MkPHBGKrWSCIUVhvCYxU5WiIL/ett+SnypxmOuzYMKSotewC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472289; c=relaxed/simple;
	bh=VaLgtgOcypCoEoB3nA6QhNyuyNe0UQ/BECoW65aRAfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWLlaU2KIJgMEVRuUgJgQqEwH4Ib4cDRocVCat47BQC+e6O4k3gValuA8XsffkBcltgM0vtoUQByeqLBkal64bdD8CEHhN24HIyvA+8KGlLg5WXDcOXQb0rYA05okX0Mwu28pSrtjRy8G5eV9Li+X9Kj0nZIaofAGeSBP8bPF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMw5Y1Gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED44C116B1;
	Thu,  1 Aug 2024 00:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472288;
	bh=VaLgtgOcypCoEoB3nA6QhNyuyNe0UQ/BECoW65aRAfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMw5Y1GbQDgU2d2QUP2GTbneMjTQdekH7BN44Rx2ephiu1JRCGVTuOeIzGl/oy0iD
	 S01DIqCmMnhPKY4ZjlHmwwB5T2HXfs0RpccUJsoU/kBWE98m7/C1mvfKRvkDsafP3p
	 g/oEigve8EXwFACnSxt19vhNZn640HxTPdnjVz8QR0ZDirE2l3IzOx9pIavkmjp2tU
	 NMXLqq16w/Xgiqmp+LrTvcveLYkFq7+LIKXSYtuGPdvQ2qnOWUZourZKedL24hxKcC
	 J6hui1+Jy7vWY0oz/yvmUfJStn/gYPdelZqA76LN/GYvZr0GXMzS5rFUF8HCpS2Vfj
	 AHErk77YIuE0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 59/61] libbpf: Add NULL checks to bpf_object__{prev_map,next_map}
Date: Wed, 31 Jul 2024 20:26:17 -0400
Message-ID: <20240801002803.3935985-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Andreas Ziegler <ziegler.andreas@siemens.com>

[ Upstream commit cedc12c5b57f7efa6dbebfb2b140e8675f5a2616 ]

In the current state, an erroneous call to
bpf_object__find_map_by_name(NULL, ...) leads to a segmentation
fault through the following call chain:

  bpf_object__find_map_by_name(obj = NULL, ...)
  -> bpf_object__for_each_map(pos, obj = NULL)
  -> bpf_object__next_map((obj = NULL), NULL)
  -> return (obj = NULL)->maps

While calling bpf_object__find_map_by_name with obj = NULL is
obviously incorrect, this should not lead to a segmentation
fault but rather be handled gracefully.

As __bpf_map__iter already handles this situation correctly, we
can delegate the check for the regular case there and only add
a check in case the prev or next parameter is NULL.

Signed-off-by: Andreas Ziegler <ziegler.andreas@siemens.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20240703083436.505124-1-ziegler.andreas@siemens.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bb27dfd6b97a7..878f05a424218 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9364,7 +9364,7 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 struct bpf_map *
 bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 {
-	if (prev == NULL)
+	if (prev == NULL && obj != NULL)
 		return obj->maps;
 
 	return __bpf_map__iter(prev, obj, 1);
@@ -9373,7 +9373,7 @@ bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 struct bpf_map *
 bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map *next)
 {
-	if (next == NULL) {
+	if (next == NULL && obj != NULL) {
 		if (!obj->nr_maps)
 			return NULL;
 		return obj->maps + obj->nr_maps - 1;
-- 
2.43.0


