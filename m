Return-Path: <bpf+bounces-65538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73854B25457
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564159A68D8
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752C2C0F95;
	Wed, 13 Aug 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b="juGJRm1H"
X-Original-To: bpf@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144B2FD7C3;
	Wed, 13 Aug 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115766; cv=none; b=anixHLGDt92KfcT1lzqWE3ljc2CkULNn44oCXzt75aVJXl+Hf07P7enF4gTn1m56b6GQoTHPkm6viQifcL1aMhVXLTCgkb09+CfATp/k9Sa8H32uPMPEMPHSAeDwnF2etzG+c94IbY0PJpLNydnUoRJIzy5xZ8ZX5YtoM0DvfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115766; c=relaxed/simple;
	bh=uha4YPBwY0siDbPuNcVFmIqyzecp+ej35gK9XBoC900=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B43p2lo0LlmR3PTy7MxjmTiBl6VkItLStuDIacFgRNzQWGzye6oWbQe7uSlK3xEv6fciE2JmUYrtt6OPtoPnyE792PMR7nL9meTgpk+aU6Xumy822rc6pOCflaFKe6WH8Vs9WoC8spLxKtnKmyRDrlYPgzcX4aWzw+PSCPLEArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev; spf=pass smtp.mailfrom=yuka.dev; dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b=juGJRm1H; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuka.dev
From: Yureka Lilian <yuka@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
	t=1755115756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7PissMhQJM4ELvQ0HSUmc/Boqi8269rmDMbPvSD+as=;
	b=juGJRm1HuS9F/DII8xdkBL7a/v03H17TQTwwoZxqCb4mLAi5dPZsKTf+nyUM8j1lsu3qb5
	OrRIzXrMskMbeeHFhzNZchHyIlkbcKOl56hKR4HArHQkzA2lHABvsi+DuqHNfEPR0dtBW7
	R+0h2+SofInvizbFgC0P7P7wUcUIaVE=
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Yureka Lilian <yuka@yuka.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] bpf: fix reuse of DEVMAP
Date: Wed, 13 Aug 2025 22:09:10 +0200
Message-ID: <20250813200912.3523279-2-yuka@yuka.dev>
In-Reply-To: <20250813200912.3523279-1-yuka@yuka.dev>
References: <20250813200912.3523279-1-yuka@yuka.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, re-using pinned DEVMAP maps would always fail, because
get_map_info on a DEVMAP always returns flags with BPF_F_RDONLY_PROG set,
but BPF_F_RDONLY_PROG being set on a map during creation is invalid.

Thus, ignore the BPF_F_RDONLY_PROG flag on both sides when checking for
compatibility with an existing DEVMAP.

Ignoring it on both sides ensures that it continues to work on older
kernels which don't set BPF_F_RDONLY_PROG on get_map_info.

The same problem is handled in a third-party ebpf library:
- https://github.com/cilium/ebpf/issues/925
- https://github.com/cilium/ebpf/pull/930

Fixes: 0cdbb4b09a06 ("devmap: Allow map lookups from eBPF")
Signed-off-by: Yureka Lilian <yuka@yuka.dev>
---
 tools/lib/bpf/libbpf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d41ee26b9..049b0c400 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5076,6 +5076,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 {
 	struct bpf_map_info map_info;
 	__u32 map_info_len = sizeof(map_info);
+	__u32 map_flags_for_check = map->def.map_flags;
 	int err;
 
 	memset(&map_info, 0, map_info_len);
@@ -5088,11 +5089,22 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 		return false;
 	}
 
+	/* get_map_info on a DEVMAP will always return flags with
+	 * BPF_F_RDONLY_PROG set, but it will never be set on a map
+	 * being created.
+	 * Thus, ignore the BPF_F_RDONLY_PROG flag on both sides when
+	 * checking for compatibility with an existing DEVMAP.
+	 */
+	if (map->def.type == BPF_MAP_TYPE_DEVMAP || map->def.type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		map_info.map_flags |= BPF_F_RDONLY_PROG;
+		map_flags_for_check |= BPF_F_RDONLY_PROG;
+	}
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


