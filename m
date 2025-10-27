Return-Path: <bpf+bounces-72401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D501C1200B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CF80501474
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC1332918;
	Mon, 27 Oct 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E2R/gY6d"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B073328E5
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607366; cv=none; b=FgXDy6turxuJaEw2CrvLE+EEa5dkab9D9+Y45wbnR4mzFR6FwQDvg+TVyrkWqZo9/WG7uwU0XDxT1YmcwprSqXmyFtCMQcWoEe3SH4O7oouznUPVOFTWBDDEPFSbAsE8PQsZX+Ak9ix0LmAWLf5KriOutl8vpgvXSYCKaab1584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607366; c=relaxed/simple;
	bh=xkUl2/NCrVjAluUScBtGf1qkHK3ETgy7/lVU2ik/bYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvmiekJRu3aUNdGDYAldWB5XHWJ1IN+KHAlioIZSGE+DStMSSZiU8f4AJLfVpNmijpq9CRN3s1phePq3wBk/DnTQ46D5mbbXocdjPx9yv5hUul0wJ8QbjWyKb+65py99jjjKt8BYQtVBa6jniPoooLh/gA4JC433Nr3ELL7yQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E2R/gY6d; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AWwjc0UoLvD3R3stojTytlItHxwa9yZiXLoT7TlRbg=;
	b=E2R/gY6dpHc7tWdh2+SxrYb70jSrc+m4mTkzm8fiv+R208YyNOi5toAkZJW+XpSTdsRMWG
	CxfajUVb7/hMGhEZW+K68iAgYHlMVmvljO29+sOcgPtnnkNVwvK8Y5EVxdZ2tjl1QNwByj
	5Ilr9Kh1kpumgiJSwtKp99IyxtK+EJI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 16/23] libbpf: introduce bpf_map__attach_struct_ops_opts()
Date: Mon, 27 Oct 2025 16:21:59 -0700
Message-ID: <20251027232206.473085-6-roman.gushchin@linux.dev>
In-Reply-To: <20251027232206.473085-1-roman.gushchin@linux.dev>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce bpf_map__attach_struct_ops_opts(), an extended version of
bpf_map__attach_struct_ops(), which takes additional struct
bpf_struct_ops_opts argument.

struct bpf_struct_ops_opts has the relative_fd member, which allows
to pass an additional file descriptor argument. It can be used to
attach struct ops maps to cgroups.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/lib/bpf/bpf.c      |  8 ++++++++
 tools/lib/bpf/libbpf.c   | 18 ++++++++++++++++--
 tools/lib/bpf/libbpf.h   | 14 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..4c8944f8d6ba 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -883,6 +883,14 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, cgroup))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_STRUCT_OPS:
+		relative_fd = OPTS_GET(opts, cgroup.relative_fd, 0);
+		attr.link_create.cgroup.relative_fd = relative_fd;
+		attr.link_create.cgroup.expected_revision =
+			OPTS_GET(opts, cgroup.expected_revision, 0);
+		if (!OPTS_ZEROED(opts, cgroup))
+			return libbpf_err(-EINVAL);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b90574f39d1c..be56a5dee505 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13196,12 +13196,19 @@ static int bpf_link__detach_struct_ops(struct bpf_link *link)
 	return close(link->fd);
 }
 
-struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
+struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
+						 const struct bpf_struct_ops_opts *opts)
 {
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts);
 	struct bpf_link_struct_ops *link;
 	__u32 zero = 0;
 	int err, fd;
 
+	if (!OPTS_VALID(opts, bpf_struct_ops_opts)) {
+		pr_warn("map '%s': invalid opts\n", map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
 	if (!bpf_map__is_struct_ops(map)) {
 		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
 		return libbpf_err_ptr(-EINVAL);
@@ -13237,7 +13244,9 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 		return &link->link;
 	}
 
-	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
+	link_opts.cgroup.relative_fd = OPTS_GET(opts, relative_fd, 0);
+
+	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, &link_opts);
 	if (fd < 0) {
 		free(link);
 		return libbpf_err_ptr(fd);
@@ -13249,6 +13258,11 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 	return &link->link;
 }
 
+struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
+{
+	return bpf_map__attach_struct_ops_opts(map, NULL);
+}
+
 /*
  * Swap the back struct_ops of a link with a new struct_ops map.
  */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..dc84898715cf 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -922,6 +922,20 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
+
+struct bpf_struct_ops_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 flags;
+	__u32 relative_fd;
+	__u64 expected_revision;
+	size_t :0;
+};
+#define bpf_struct_ops_opts__last_field expected_revision
+
+LIBBPF_API struct bpf_link *
+bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
+				const struct bpf_struct_ops_opts *opts);
 LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
 
 struct bpf_iter_attach_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..bc00089343ce 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_map__attach_struct_ops_opts;
 } LIBBPF_1.6.0;
-- 
2.51.0


