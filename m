Return-Path: <bpf+bounces-26356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A558C89E8FC
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA81F264F1
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 04:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760228DC0;
	Wed, 10 Apr 2024 04:35:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3A224EA
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723739; cv=none; b=tbD0pai/zwz/cSm9dBQ4t2yhB3uVsVg71ZC/16J5hxVDav0UUTcGTD9ui48sw+b6D1cfMVfB47+eYVghm8fqWkxjafq1IfbXC7bMADitk0fgLDGyxWCa88iRi+sFwtwZ2lrrnwJSccEC2HiaBailLAsEHeFSlRyQakksSqj8nBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723739; c=relaxed/simple;
	bh=P0zWSit67c7JEXq+6EPnAwurjUjgWQhQOkP/mDauxZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx8L0BCzA+eKXRJHhUokc0lQp+smJReiqZ7MtjGkiEWPJ422z+IdeDi0oHYGzu/Y6iy1GTRgQtBi/Bbyw6xCIbivHMSfaFCDEOvnbGHBNvedVPZm83nor44C7NMIzOWv5EKwSmiWi7DjHK0nq6lKsy/iBdyL397M+Drt03I1/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4A5DA2D7F25E; Tue,  9 Apr 2024 21:35:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/5] libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
Date: Tue,  9 Apr 2024 21:35:32 -0700
Message-ID: <20240410043532.3737722-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410043522.3736912-1-yonghong.song@linux.dev>
References: <20240410043522.3736912-1-yonghong.song@linux.dev>
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
 tools/lib/bpf/libbpf.c   | 7 +++++++
 tools/lib/bpf/libbpf.h   | 2 ++
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 10 insertions(+)

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
index 4f775a6dcaa0..1333ae20ebe6 100644
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
index 23d82bba021a..c1ce8aa3520b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -419,6 +419,7 @@ LIBBPF_1.4.0 {
=20
 LIBBPF_1.5.0 {
 	global:
+		bpf_program__attach_sockmap;
 		ring__consume_n;
 		ring_buffer__consume_n;
 } LIBBPF_1.4.0;
--=20
2.43.0


