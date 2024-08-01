Return-Path: <bpf+bounces-36194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B31943DAC
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991ED1C22234
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE01CCB45;
	Thu,  1 Aug 2024 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr1JcE7A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF21A57F3;
	Thu,  1 Aug 2024 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471968; cv=none; b=VoCZioPU+nx+wmHiDHW+7yMhXlj5mINmBrIKUVcDzzDyRDC0OUDKXMVJaQqvwTYrcZlxv2N7ncJqMgzqQ/f5HoisYV7FTIFyVnztNH7xn86GS3GqiemPJ+O01cWORu8rslVkS5ynES2tuFO2MtSSnnRqXU7EJM4WHzybYiyQ8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471968; c=relaxed/simple;
	bh=ck0D3B4beDeNneQIiMLTKVkPKfIRAfVcdLAfWNYp69w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mn5iCCE7USyfY6YjGwBhD/FG9NV/pltQS/w26BOPuHnXq/r5IwyQeLfGrZyREheyshxRJIH2T0bdsp8YaQ5scn4h6PGydrZVJuhR6Qy8YQG4guKpyJVmaRoVait0r6JM8jkU476b8LeUrvX9OVo1C3LM8H8/6bMjbspmyhd2XDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr1JcE7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23619C116B1;
	Thu,  1 Aug 2024 00:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471968;
	bh=ck0D3B4beDeNneQIiMLTKVkPKfIRAfVcdLAfWNYp69w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sr1JcE7AWwWcmkLDXrTpNE4+zn8eLY0+qQMcww0ztRxD8FqsvN2Ll+1vDRNabiWtQ
	 D6Fya8w8IxNu6YYhEVpMbU4VC3mjCzdsB+8Z3EuFKevDFvQUGkXMweG7sHw6AHRsPX
	 cTKdypBcxHysxl1mVvZrSbcVC4uDG6sU4qnhQiU4l0QvYMXfggC/Oqzyg++iFgIjKp
	 0v5a31/cLxH2kglsJcNngn5xideFgq5gho0Goz0//viFZ5nYTEhEsfJaoxzjVFbSES
	 Xi4VYF72CxfITCDUoC35N6BySX/SXXoL57nKJTjZR3YMLQbJiT/V+lu7mj24JAIVw/
	 iO8QtybS/2ZmA==
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
Subject: [PATCH AUTOSEL 6.6 81/83] libbpf: Add NULL checks to bpf_object__{prev_map,next_map}
Date: Wed, 31 Jul 2024 20:18:36 -0400
Message-ID: <20240801002107.3934037-81-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index de35b9a21dad7..ceed16a10285a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9753,7 +9753,7 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 struct bpf_map *
 bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 {
-	if (prev == NULL)
+	if (prev == NULL && obj != NULL)
 		return obj->maps;
 
 	return __bpf_map__iter(prev, obj, 1);
@@ -9762,7 +9762,7 @@ bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
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


