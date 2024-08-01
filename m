Return-Path: <bpf+bounces-36201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D8C943F6B
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C550728295D
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AE1E4F14;
	Thu,  1 Aug 2024 00:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWB9ltp2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB41E4EFE;
	Thu,  1 Aug 2024 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472726; cv=none; b=maQMi+utzM2qAsfXfVNWLEBF4wTfDeMJ3CA9xYuDPvkiAJHk9LZXpAhkOPJnB7QzAFtn17+EZcYrBXSMI8Ktz7gW7cpgHcRP2mlCE9WHbZYokbnlXB1NH9S4NmeakLjuxKQ5UKQVWYpdhOKrjLaplX/Hv+Waq6RDeqG12zb/+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472726; c=relaxed/simple;
	bh=ASK0R6WhsZLnJDYmu57syN4fShPd6cBH2o0eR4UoDwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msfyitPWb5UbqTF9oFr4tBkF03R+1xqt1oUerXSzPwkEJhtOm6jIZ5OpQboyBN8ccHP9/y7elM59w5vZVPE6LpdGp7z/amHNdjzhf7SLMpTw4tJ7SgRjhsaKzPKCmSKGRUI6uPzeQCKyEfeiAbVdvbVtBVQtozNtPpmegAM0d6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWB9ltp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A517C4AF0C;
	Thu,  1 Aug 2024 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472726;
	bh=ASK0R6WhsZLnJDYmu57syN4fShPd6cBH2o0eR4UoDwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWB9ltp2j1Pj320QaUxb+vYoNMtlOEfuXk4FJK87Cw9iOYNGpaj1gjuy7ahJR/KIU
	 B1VtKVrd/qNbCq3LWpU91B7U8eM1xw2XrTA3HsqCgoHAyf1mjiyxCuS/wHqE6DHFvg
	 SaRrC4042CtN3vfbztxPp7f0H/wmwMThI4LhqLmqRP1/Ghxaavn0gfG+PdQlXg9nvo
	 7WRNd0OKTfTgBcZZmFFh69El+mQjJil+NxGSlRGgS/x2fgnzqaFrSu72pF5MY/bdi3
	 vK357cQF7Uf7nem/UGJJcmbP/U1bNh8wzsU4QTbgBZvO7Y7tA3dESfkrtGzFsyxQ5p
	 S0WuUVfk5LVng==
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
Subject: [PATCH AUTOSEL 5.10 37/38] libbpf: Add NULL checks to bpf_object__{prev_map,next_map}
Date: Wed, 31 Jul 2024 20:35:43 -0400
Message-ID: <20240801003643.3938534-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 015ed8253f739..33cdcfe106344 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9005,7 +9005,7 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 struct bpf_map *
 bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
 {
-	if (prev == NULL)
+	if (prev == NULL && obj != NULL)
 		return obj->maps;
 
 	return __bpf_map__iter(prev, obj, 1);
@@ -9014,7 +9014,7 @@ bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
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


