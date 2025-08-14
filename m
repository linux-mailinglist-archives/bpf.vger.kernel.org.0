Return-Path: <bpf+bounces-65678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65FB26E90
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA41AA1D81
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180B29D27A;
	Thu, 14 Aug 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b="lePV3CC3"
X-Original-To: bpf@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431915855E;
	Thu, 14 Aug 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194531; cv=none; b=G0SN+QJnNlSx/NtbOhFvTyXoZT7dhrf5X2T4i4KEeoPG22NWoQvAvIyMytbM+HXk5Ou3b3+vB/KPNgV1+eGM+skvSQRy8MesfWSOtPXM6wbJF7Inh0IYEc0kbGS8d+PMJL7PEoxY4lE5cIHY5+LV+wQks0XW3cy635FnAmwf/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194531; c=relaxed/simple;
	bh=gETrYTUSxPyYNdyon9BOH6C2hcZqinpne34HGLVzowc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzUPACve7MYbE/V5iTUM5QwqwVQ3s5WyZZGWinE17a/oxIUMZiCNxCGRg3Efcbm+iyHHuvzLJlWRxQuq4kTzoeyMMDJSNlNHJv6QeblA2ZKr8eO9r+ymQPZkASb9aokCiMB9pvpTtVVFRcSQLjKNP8jut4mEeH2zrdRczbSDEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev; spf=pass smtp.mailfrom=yuka.dev; dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b=lePV3CC3; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuka.dev
From: Yureka Lilian <yuka@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
	t=1755194526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdxi0jU5vM3I1jrMekEXPFlRfKSHNBslgCtIr7Ic8W0=;
	b=lePV3CC3cAfRWS53LJwdV0+LzstjpROUjhvLrLfhzFil/Xf9C7ofDetp2CncB7mKo8rhz2
	bzG9QV2MvcRAkrQjQ1fqJUBHMF/joPwOP+5QUVEsnj827gl7xZAWn20oC3xk0i93HrsK+5
	3kq6xOGeCuzP/4rjMj3AVb6P3ihVkW8=
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
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
Subject: [PATCH v3 1/2] libbpf: fix reuse of DEVMAP
Date: Thu, 14 Aug 2025 20:01:12 +0200
Message-ID: <20250814180113.1245565-3-yuka@yuka.dev>
In-Reply-To: <20250814180113.1245565-2-yuka@yuka.dev>
References: <20250814180113.1245565-2-yuka@yuka.dev>
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

Thus, ignore the BPF_F_RDONLY_PROG flag in the flags returned from
get_map_info when checking for compatibility with an existing DEVMAP.

The same problem is handled in a third-party ebpf library:
- https://github.com/cilium/ebpf/issues/925
- https://github.com/cilium/ebpf/pull/930

Fixes: 0cdbb4b09a06 ("devmap: Allow map lookups from eBPF")
Signed-off-by: Yureka Lilian <yuka@yuka.dev>
---
 tools/lib/bpf/libbpf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d41ee26b9..affcbb231 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5088,6 +5088,17 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 		return false;
 	}
 
+	/* get_map_info on a DEVMAP will always return flags with
+	 * BPF_F_RDONLY_PROG set, but it will never be set on a map
+	 * being created.
+	 * Thus, ignore the BPF_F_RDONLY_PROG flag in the flags
+	 * returned from get_map_info when checking for compatibility
+	 * with an existing DEVMAP.
+	 */
+	if (map->def.type == BPF_MAP_TYPE_DEVMAP || map->def.type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		map_info.map_flags &= ~BPF_F_RDONLY_PROG;
+	}
+
 	return (map_info.type == map->def.type &&
 		map_info.key_size == map->def.key_size &&
 		map_info.value_size == map->def.value_size &&
-- 
2.50.1


