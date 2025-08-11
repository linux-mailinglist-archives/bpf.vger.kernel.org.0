Return-Path: <bpf+bounces-65324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6BCB203E7
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 11:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B4F3A2E22
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20B223DFF;
	Mon, 11 Aug 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b="jxyTIrUs"
X-Original-To: bpf@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DB374EA;
	Mon, 11 Aug 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905211; cv=none; b=u4/3w+bgpWfToCS0e0KrRbwFUQT2dSqQaa07QqitkrnRLKAG2XtcZm6eg0qfT5xsxwtxzx05CE5LNlQ8GGbHCtp/UZWOaoCPeJKGV3SuGsPzt1N6+J6MkuZvGN7foxwMRNCcolXu1QqYqIfZPdOUjwwYkcgJlu6FVYTEVcRKy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905211; c=relaxed/simple;
	bh=uCJtmPEFzY+QWjgExO8MW8+SvPrYxIduutknzX5sQKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqvl0wmY6OOLWZQZnrKfz0if3QUKhVQ3uO5xXBQhyWFD7PYYMPQGvQD5g7YOeWDM6dEBc7xuqYFPfIeJMpVtFBY4nPOlWLJ2Y7ifzDa7ehDTeDAmRMV0WS4JHdohCCmkbPIEO9vxRsHuA9b6kSQw0Fo5PUrstqgeQ6iFIzNtY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev; spf=pass smtp.mailfrom=yuka.dev; dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b=jxyTIrUs; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuka.dev
From: Yureka Lilian <yuka@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
	t=1754905206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FU6aEs8zwpQqV/O36lHWhC0ilYDhDHPiAL8/2sMKVS8=;
	b=jxyTIrUs7YwDk7yYAQJJiJxjWCtET/D66F5zYINIm0pbLPLyNOyrD7dAKtP7AxQ47czp8y
	/21Ng0L0GMp38sPHbFyDMVve4G6HEr7jB6uRPNHA5IfAqfNsQanuvGM4RcAfEsY6mleLND
	lGIUEoV603BcUrsWZlh3O60mR28Wlpc=
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
Subject: [PATCH] bpf: fix reuse of DEVMAP
Date: Mon, 11 Aug 2025 11:39:44 +0200
Message-ID: <20250811093945.41028-1-yuka@yuka.dev>
In-Reply-To: <20250811091046.35696-1-yuka@yuka.dev>
References: <20250811091046.35696-1-yuka@yuka.dev>
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


