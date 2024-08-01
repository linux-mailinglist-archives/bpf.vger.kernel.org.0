Return-Path: <bpf+bounces-36202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CD943F9F
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C073E1C221F5
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D91E8BA4;
	Thu,  1 Aug 2024 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKoSwzcX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C114D6F1;
	Thu,  1 Aug 2024 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472818; cv=none; b=YguaOi5HC4+JedZSLX9WBmoCVer12/5xhmnVJvjjf5tcC4GJOX76lpokwPQuV8G5HEUlBS2c5r7+dnbPNZDXXALmg4JJV1oOg5PbF2pWOA46oz78E8LHN20ng4rXtK+MwkUcccmAVZ5y8pdF2SMwJBCPsmXOM2/3KX3fVZZKjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472818; c=relaxed/simple;
	bh=Hd5NowUcUAp541sQ2PvaAZrGVSsqTq0O3BLmgzGh0so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI3sT7ZuS0ocPWCRcHLZkIU8D7Xkcarg8v4KlA2ghfqq3Xk+xv+EEWAqlwHgUb9gK8lt1zFVt7GlD9555GtZ7sXo1GrvbbfWosSwtnq6d9hHCSTZqBulIgu45a8+KPT+MqD6gzZg7CHOr3ey+5soc/YWITtRwB3F3RKrR9voEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKoSwzcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDE2C4AF0C;
	Thu,  1 Aug 2024 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472818;
	bh=Hd5NowUcUAp541sQ2PvaAZrGVSsqTq0O3BLmgzGh0so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKoSwzcX6mnR0Fx2zIGzViv7wDEHb1A3eUp7jo2EGP1gk6Oo3Q8SQzzQk02ER/clt
	 Kb6i5yyjYJ65XEkkq+x5qDEFusiJcwGlCpXlp1903V13auCVptUAKTrbMjY5s2+dHK
	 k3mNMhRqeYjKhqz5Ja50NXAN3YLgUkoxV9OKCOSBRikqpdrR1Uli3Sk7LJFdTXosef
	 IS0EgdRvb6m9UP2kUs7g9IKaeIiZ2uU1Rpshozrd2zqKmRZG7ymiZ28kfJ8Q2VbmgL
	 AvttMs7lw7/7Za/cTfq3GEnQrEyHXBPXIe5hd/N+Uu3uyOBPQb5KY/IKMzgnRgVnG4
	 CBNSD4cqCy4BQ==
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
Subject: [PATCH AUTOSEL 5.4 21/22] libbpf: Add NULL checks to bpf_object__{prev_map,next_map}
Date: Wed, 31 Jul 2024 20:38:50 -0400
Message-ID: <20240801003918.3939431-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index b8849812449c3..98e34c5172673 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4754,7 +4754,7 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 struct bpf_map *
 bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
 {
-	if (prev == NULL)
+	if (prev == NULL && obj != NULL)
 		return obj->maps;
 
 	return __bpf_map__iter(prev, obj, 1);
@@ -4763,7 +4763,7 @@ bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
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


