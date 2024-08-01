Return-Path: <bpf+bounces-36199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D63943F07
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53441C21AFA
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575011BDCC5;
	Thu,  1 Aug 2024 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3Ets4xz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91051DE877;
	Thu,  1 Aug 2024 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472534; cv=none; b=doPQ3CJvMg73MS3Rrv1LUwCa9uNXVgOBcWCjPDJNW48RlTQ/zMIhFqGPkTYSxFtbbnXWaOJBvfn4azEwHongK1oXOg/hE0E98CWlDozA06YrQjgwJL+263TMpz/Agw7gZSgukStxliTGQvE1+PTQtabJegSSRZDYBILUOgk2MCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472534; c=relaxed/simple;
	bh=m6Zgv/uCmkXvk1tgah8G7aobC2raujciujpOIG5+KKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWNfpC9A6gJS3fDvVxSp3RI1i+BHNyIOqFrMbrJNexwhXUhUV2cv0ZpfelihX2OtSV6J27CmHUSCMMk/ea8r9iQQk3YK3Ttelj61PBZwv8rQxRePHJ/kFLwzaheAaf9Q8LohUpb5VbtIDNJ/nNxKzjkmpvDj1iUZtuiDveA1/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3Ets4xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50479C4AF10;
	Thu,  1 Aug 2024 00:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472534;
	bh=m6Zgv/uCmkXvk1tgah8G7aobC2raujciujpOIG5+KKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3Ets4xz+jQZxkBmm+VvzFIgKRXo0O7PPv5n7EW55A2/OMV2dVkEeKpFcWPGiIWgO
	 V8UohTGmCcBPsZAV9j2L+iK0x5KG6hz3Gnp4XUC4B+U9mN276utUq4jBw79hHOJqar
	 qNzf9rxN6p245Aix757js1e5779/FRxDOFhO1BtXngqFSd5OASzJjKfxfKt0Emxyac
	 thlDqD8OMPLJF6qnqeJdyIDXWs6ngigVytll8GPQofY0NRzjjPAbv73bKFLwVrY7hK
	 YcUwjpTOz/N+vFgjR/7iI4uChPVzgQgy6M0skQvwQY6ZzEORwXw1Vxci4sWuhVHDI8
	 qW2sQykrej0og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 45/47] libbpf: Add NULL checks to bpf_object__{prev_map,next_map}
Date: Wed, 31 Jul 2024 20:31:35 -0400
Message-ID: <20240801003256.3937416-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 0c201f07d8aef..d201a7356fad6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8729,7 +8729,7 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 struct bpf_map *
 bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
 {
-	if (prev == NULL)
+	if (prev == NULL && obj != NULL)
 		return obj->maps;
 
 	return __bpf_map__iter(prev, obj, 1);
@@ -8738,7 +8738,7 @@ bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
 struct bpf_map *
 bpf_map__prev(const struct bpf_map *next, const struct bpf_object *obj)
 {
-	if (next == NULL) {
+	if (next == NULL && obj != NULL) {
 		if (!obj->nr_maps)
 			return NULL;
 		return obj->maps + obj->nr_maps - 1;
-- 
2.43.0


