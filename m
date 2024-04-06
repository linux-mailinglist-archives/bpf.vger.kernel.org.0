Return-Path: <bpf+bounces-26091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4089ABE1
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532EB28237B
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFDD3CF63;
	Sat,  6 Apr 2024 16:04:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E83BBEB
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419462; cv=none; b=aoQVJknzsDtgxUKcvA9x846z3YJXztS6V0q9bcstBfeJWRLUj403spwW2LVOLWm5+Nzq3EUbCsAGeWWeFfiGjub9P4SgIH++az5vvPhlcxdaZPKC0YFjnaFzPKa5kFqH9DRTvtVrcUFqdZHkXM5Lcp9IIg+g9Ylhdyd1e2wIQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419462; c=relaxed/simple;
	bh=/QLN8iYtSPIhU2F6qkD2bwpbqIfytq5gENKJZrWDuwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlO0F+++oftDd5K6ZhRhQqAW5GSxakKUt1FcIBSWQEXRnhWY9/tYbjG4UQrDn6eQZY1e5P5R6PQMChB/1fUfcZowcYhvrVB4r7dM2agtzA0BV551d9UE7+boF96zU4h6tPIGpmMtUEuSXBRZVUFu3ikx9KX4q/Jp+NbjJ6c+v9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3AAC02B551A0; Sat,  6 Apr 2024 09:04:09 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v5 2/5] libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
Date: Sat,  6 Apr 2024 09:04:09 -0700
Message-ID: <20240406160409.178297-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406160359.176498-1-yonghong.song@linux.dev>
References: <20240406160359.176498-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce a libbpf API function bpf_program__attach_sockmap()
which allow user to get a bpf_link for their corresponding programs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c         | 7 +++++++
 tools/lib/bpf/libbpf.h         | 2 ++
 tools/lib/bpf/libbpf.map       | 5 +++++
 tools/lib/bpf/libbpf_version.h | 2 +-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b091154bc5b5..97eb6e5dd7c8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -149,6 +149,7 @@ static const char * const link_type_name[] =3D {
 	[BPF_LINK_TYPE_TCX]			=3D "tcx",
 	[BPF_LINK_TYPE_UPROBE_MULTI]		=3D "uprobe_multi",
 	[BPF_LINK_TYPE_NETKIT]			=3D "netkit",
+	[BPF_LINK_TYPE_SOCKMAP]			=3D "sockmap",
 };
=20
 static const char * const map_type_name[] =3D {
@@ -12533,6 +12534,12 @@ bpf_program__attach_netns(const struct bpf_progr=
am *prog, int netns_fd)
 	return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
 }
=20
+struct bpf_link *
+bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd)
+{
+	return bpf_program_attach_fd(prog, map_fd, "sockmap", NULL);
+}
+
 struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog,=
 int ifindex)
 {
 	/* target_fd/target_ifindex use the same field in LINK_CREATE */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f88ab50c0229..4c7ada03bf4f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -795,6 +795,8 @@ bpf_program__attach_cgroup(const struct bpf_program *=
prog, int cgroup_fd);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
 LIBBPF_API struct bpf_link *
+bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd);
+LIBBPF_API struct bpf_link *
 bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(const struct bpf_program *prog,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 51732ecb1385..2d0ca3e8ec18 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -416,3 +416,8 @@ LIBBPF_1.4.0 {
 		btf__new_split;
 		btf_ext__raw_data;
 } LIBBPF_1.3.0;
+
+LIBBPF_1.5.0 {
+	global:
+		bpf_program__attach_sockmap;
+} LIBBPF_1.4.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_versio=
n.h
index e783a47da815..d6e5eff967cb 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
=20
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 4
+#define LIBBPF_MINOR_VERSION 5
=20
 #endif /* __LIBBPF_VERSION_H */
--=20
2.43.0


