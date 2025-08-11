Return-Path: <bpf+bounces-65322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD82DB202F0
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 11:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784621893220
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 09:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAE32DCF74;
	Mon, 11 Aug 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b="md1645lh"
X-Original-To: bpf@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695422DCF76
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903490; cv=none; b=HUr2pRIM6CP3o49MqYhe6l6PgWsbb52BbQpZ4bYqTZVlG7j/R3LMMReu5Fud17nP/O3qPXvumNMPmGI0k6SKSWhYuLVkJ2G8dkIHE9dIpk4PFMIdX5+qCVQut0NqS6zXNKHKRyuCF72OgtuV91gASOZBMptDX4JopDWywc63S78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903490; c=relaxed/simple;
	bh=uCJtmPEFzY+QWjgExO8MW8+SvPrYxIduutknzX5sQKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBhGfIQy4wy8QkL33l+jEWkGkhIj38g0ukga8LsDYi/FQIwlHSpDFtiLF8SGDBT7+VgX5N1BRU+r4wRb683GEN1vWzJekiYr9wT7Wz33GGffxMOMBFUAA3lL6DycAFBcCu6pV7HdbDVZVpFnWU+KbKG1L/DB8CPdkGVEsqCaMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev; spf=pass smtp.mailfrom=yuka.dev; dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b=md1645lh; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuka.dev
From: Yureka Lilian <yuka@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
	t=1754903484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FU6aEs8zwpQqV/O36lHWhC0ilYDhDHPiAL8/2sMKVS8=;
	b=md1645lh50Rqn9fltNKbli+Iltmz4zOhqPdqfox170IYLZgP8mK/pq5sHZg4cnRzj5kgWS
	qdW+/jlxpK22+DQ+vn8WYDaK8OKPe+XUQ//ZOTJQdjSuEQI3fKTJO0i7bzbBm9z0TICMIF
	NYtsW1iCRimsblQ16KJDjt3+u2e21Ro=
To: bpf@vger.kernel.org
Cc: Yureka Lilian <yuka@yuka.dev>
Subject: [PATCH] bpf: fix reuse of DEVMAP
Date: Mon, 11 Aug 2025 11:10:18 +0200
Message-ID: <20250811091046.35696-1-yuka@yuka.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, re-using pinned DEVMAP maps would always fail, because
get_map_info on a DEVMAP always returns flags with BPF_F_RDONLY_PROG set,
it BPF_F_RDONLY_PROG being set on a map being created is invalid.

Thus, match the BPF_F_RDONLY_PROG flag being set on the new map when
checking for compatibility with an existing DEVMAP

The same problem is handled in third-party ebpf library:
- https://github.com/cilium/ebpf/issues/925
- https://github.com/cilium/ebpf/pull/930

Signed-off-by: Yureka Lilian <yuka@yuka.dev>
---
 tools/lib/bpf/libbpf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fb4d92c5c..a554d7fff 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5081,6 +5081,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 {
 	struct bpf_map_info map_info;
 	__u32 map_info_len = sizeof(map_info);
+	__u32 map_flags_for_check = map->def.map_flags;
 	int err;
 
 	memset(&map_info, 0, map_info_len);
@@ -5093,11 +5094,20 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 		return false;
 	}
 
+	/* get_map_info on a DEVMAP will always return flags with
+	 * BPF_F_RDONLY_PROG set, but it will never be set on a map
+	 * being created.
+	 * Thus, match the BPF_F_RDONLY_PROG flag being set on the new
+	 * map when checking for compatibility with an existing DEVMAP
+	 */
+	if (map->def.type == BPF_MAP_TYPE_DEVMAP || map->def.type == BPF_MAP_TYPE_DEVMAP_HASH)
+		map_flags_for_check |= BPF_F_RDONLY_PROG;
+
 	return (map_info.type == map->def.type &&
 		map_info.key_size == map->def.key_size &&
 		map_info.value_size == map->def.value_size &&
 		map_info.max_entries == map->def.max_entries &&
-		map_info.map_flags == map->def.map_flags &&
+		map_info.map_flags == map_flags_for_check &&
 		map_info.map_extra == map->map_extra);
 }
 
-- 
2.50.1


