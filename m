Return-Path: <bpf+bounces-40975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAAF990ADF
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F4B1C22806
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CEC1DAC87;
	Fri,  4 Oct 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhLGaLMB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64B1E377A;
	Fri,  4 Oct 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065911; cv=none; b=UOJ7uspxVisie/hDW4WK7o1VVEht/X+xWondlrMWrHF551qs4wP0nlvKKzLLe4+FZ95BwMpWobVpJJfHT0KlR+v5JFa7t+ZobxADnnZMgSzqnVyNoxeRKXbGLYf0+w1wKwB2N44sXFGohOBGLVa+pRHoBzBL+V4Zc/0tHE5wT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065911; c=relaxed/simple;
	bh=+rY6ogzP8pw23D8gaAAwalxuvbQoC9+8WuL1rjqfgG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVgnzPCJOvm4mBUwsg88EBnMu2FtwoxWRdh9TIFPJTkDpiNn7jJE0WDWHozr6cIEb8P31L4h4egOZTfP5kujDgJZyKI4qARcIngSUaGyQmPdwu2lLZt4Mm+tF54rrJsK1STzYEvqi60sVLEyWBI8LYsmkJviriXHZLC5INS1/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhLGaLMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121C4C4CEC6;
	Fri,  4 Oct 2024 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065911;
	bh=+rY6ogzP8pw23D8gaAAwalxuvbQoC9+8WuL1rjqfgG0=;
	h=From:To:Cc:Subject:Date:From;
	b=fhLGaLMB93bxMZsGai8gqsyZWQjyhS2lB9F7axk2uNR2SI4iQtixSAoXPWX8KLIl2
	 WCb9WzlIzPNYnYWsLIexXOLQos3lZERoHy1+2tak0k11teRMyLZxAtHW/t/K2Sa50K
	 JBv2kfePs1grINQVHJhYQhEDwYyUnBdaTQo7e3a83tCkgXWgkIG28M9l6+wwpsjJ4w
	 yZ0VkXbYBOjcyqWirrm4RGAx49J/EWRLjAHloYLTTvMIezVgV8i4/jzXdXl0KjKkh5
	 75mTzNp/Ai042QNX1Ecdvwt6ZXcivap2/3VCNOPB2KpEPsMBFsBn0v6+oKO5S5P04H
	 Wz7RUmIUOrLng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 01/76] bpf: Call the missed btf_record_free() when map creation fails
Date: Fri,  4 Oct 2024 14:16:18 -0400
Message-ID: <20241004181828.3669209-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 87e9675a0dfd0bf4a36550e4a0e673038ec67aee ]

When security_bpf_map_create() in map_create() fails, map_create() will
call btf_put() and ->map_free() callback to free the map. It doesn't
free the btf_record of map value, so add the missed btf_record_free()
when map creation fails.

However btf_record_free() needs to be called after ->map_free() just
like bpf_map_free_deferred() did, because ->map_free() may use the
btf_record to free the special fields in preallocated map value. So
factor out bpf_map_free() helper to free the map, btf_record, and btf
orderly and use the helper in both map_create() and
bpf_map_free_deferred().

Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20240912012845.3458483-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bf6c5f685ea22..931ae9ad78149 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -733,15 +733,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 	}
 }
 
-/* called from workqueue */
-static void bpf_map_free_deferred(struct work_struct *work)
+static void bpf_map_free(struct bpf_map *map)
 {
-	struct bpf_map *map = container_of(work, struct bpf_map, work);
 	struct btf_record *rec = map->record;
 	struct btf *btf = map->btf;
 
-	security_bpf_map_free(map);
-	bpf_map_release_memcg(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
 	/* Delay freeing of btf_record for maps, as map_free
@@ -760,6 +756,16 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	btf_put(btf);
 }
 
+/* called from workqueue */
+static void bpf_map_free_deferred(struct work_struct *work)
+{
+	struct bpf_map *map = container_of(work, struct bpf_map, work);
+
+	security_bpf_map_free(map);
+	bpf_map_release_memcg(map);
+	bpf_map_free(map);
+}
+
 static void bpf_map_put_uref(struct bpf_map *map)
 {
 	if (atomic64_dec_and_test(&map->usercnt)) {
@@ -1411,8 +1417,7 @@ static int map_create(union bpf_attr *attr)
 free_map_sec:
 	security_bpf_map_free(map);
 free_map:
-	btf_put(map->btf);
-	map->ops->map_free(map);
+	bpf_map_free(map);
 put_token:
 	bpf_token_put(token);
 	return err;
-- 
2.43.0


