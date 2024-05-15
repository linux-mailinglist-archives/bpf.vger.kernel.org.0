Return-Path: <bpf+bounces-29739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 167458C60BE
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 08:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C2B1C21766
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 06:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779963BBE0;
	Wed, 15 May 2024 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTvSRXjX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73A3BB4D;
	Wed, 15 May 2024 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754283; cv=none; b=cLD1gMDbWlIzlB5stCKa85WiN0KA6EioXX8Va9Omj+aU/nsv1mJM4b8jYHEDMUtrvD8g0tAVYyc4s/xhpRrwlNJvPLSYWyMdyDxS+8Zj58kvxBCIZpYOGG5kudOsfDq+jignCJbRmqVo9EJAs5VnD1yXIHEdVKPoBH0AE8tF92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754283; c=relaxed/simple;
	bh=4okc3Dw/20GI8ZQAD0LcDA30L9uZnSu68jzTvkmU+3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoyAw8lc3RuqxJamvPouqp5YmEKtepuzZ5b6MH7DmjBvR+oc6Am4IeEbtL2r39ccQfoGgZoSZXYTzkJBPQgOI7tu3gBKWIjO8wb3K0vNWIv2Vkn0euOWXivKtklubJeZfKj/pJKFHxCOSGPYwKS83az40+etOGL4xVlk+C7ur54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTvSRXjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C43C116B1;
	Wed, 15 May 2024 06:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715754282;
	bh=4okc3Dw/20GI8ZQAD0LcDA30L9uZnSu68jzTvkmU+3g=;
	h=From:To:Cc:Subject:Date:From;
	b=rTvSRXjXUw2TL8LU9FuMox5QrLTr4H4h2qtHVAHExZ22aShcXhZK0j7wA8Ug3L33t
	 3G6D+g3mU9zt2vWhW10JzFhxYkxl4Bt/0yKJ90A9TUPo6qGmc4E4xL8DxzmXUMczsw
	 F5DbcJWGg03nndiRbqG4fGyJ5MEhrSPXGV4YEzN0+lZaTkgnV98k5X18QL3EinzN1T
	 ghle1LMpSETjzThGRaHPQE0DwUGnN6g7/hrMgMk6RaFJcpuOELEnZF+PRZ4pVsCy8f
	 KMoNdFSbvXsbMZLXHJFotZ0iED2MD1zYhT5b95cQnyZiRlpj2bsxmpUcpfTAuvslBp
	 FHK/BiRCM9wUg==
From: Andrii Nakryiko <andrii@kernel.org>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] bpf: save extended inner map info for percpu array maps as well
Date: Tue, 14 May 2024 23:24:39 -0700
Message-ID: <20240515062440.846086-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARRAY_OF_MAPS and HASH_OF_MAPS map types have special logic to save
a few extra fields required for correct operations of ARRAY maps, when
they are used as inner maps. PERCPU_ARRAY maps have similar
requirements as they now support generating inline element lookup
logic. So make sure that both classes of maps are handled correctly.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Fixes: db69718b8efa ("bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/map_in_map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 8ef269e66ba5..b4f18c85d7bc 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -32,7 +32,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 	inner_map_meta_size = sizeof(*inner_map_meta);
 	/* In some cases verifier needs to access beyond just base map. */
-	if (inner_map->ops == &array_map_ops)
+	if (inner_map->ops == &array_map_ops || inner_map->ops == &percpu_array_map_ops)
 		inner_map_meta_size = sizeof(struct bpf_array);
 
 	inner_map_meta = kzalloc(inner_map_meta_size, GFP_USER);
@@ -68,7 +68,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 	/* Misc members not needed in bpf_map_meta_equal() check. */
 	inner_map_meta->ops = inner_map->ops;
-	if (inner_map->ops == &array_map_ops) {
+	if (inner_map->ops == &array_map_ops || inner_map->ops == &percpu_array_map_ops) {
 		struct bpf_array *inner_array_meta =
 			container_of(inner_map_meta, struct bpf_array, map);
 		struct bpf_array *inner_array = container_of(inner_map, struct bpf_array, map);
-- 
2.43.0


