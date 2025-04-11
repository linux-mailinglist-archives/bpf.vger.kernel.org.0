Return-Path: <bpf+bounces-55704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF4A85121
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 03:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFF44654B7
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 01:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566626FA7B;
	Fri, 11 Apr 2025 01:15:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8BAD24
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334152; cv=none; b=X+wAmP86we0SuGPT3NK3B0CRTWe9BA22n8ePWy1l6pJmZSTafDBMfEcBAZlP6X/6/IUnCsp0OUjFzKSL+Yr/KsrsLbhWe1vwjJdNpcSdsAwE2tZSP3AgFf67BNHi84GN68TaOFIUmDszzwIsgkdNCoSjZJ/ELE1+B5gIN1jTtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334152; c=relaxed/simple;
	bh=6IgFVkQRfl96Rj22uo8IhmAS0o25Wi7nrUfKSufVujg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgC5OxguOBq3C2nhtaxFvviSaNhcxKlHk94GWwHljq+mCAcjmTnlcvH0yJFGyWoHcnvzNXH7PVHF3lyA0HERRb2dPjbvflcL+IVbI7zTnX/xbrLOQNurofnSB5oqH87dis4GPdegT8+QLdLyfievg9qZPBCVK9TZTo+nnK9c+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1C08A514908C; Thu, 10 Apr 2025 18:15:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 3/4] libbpf: Support link-based cgroup attach with options
Date: Thu, 10 Apr 2025 18:15:39 -0700
Message-ID: <20250411011539.1839815-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411011523.1838771-1-yonghong.song@linux.dev>
References: <20250411011523.1838771-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently libbpf supports bpf_program__attach_cgroup() with signature:
  LIBBPF_API struct bpf_link *
  bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_f=
d);

To support mprog style attachment, additionsl fields like flags,
relative_{fd,id} and expected_revision are needed.

Add a new API:
  LIBBPF_API struct bpf_link *
  bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgr=
oup_fd,
                                  const struct bpf_cgroup_opts *opts);
where bpf_cgroup_opts contains all above needed fields.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/bpf.c      | 44 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      |  5 +++++
 tools/lib/bpf/libbpf.c   | 28 +++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 15 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 93 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a9c3e33d0f8a..6eb421ccf91b 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -837,6 +837,50 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, netkit))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_CGROUP_INET_INGRESS:
+	case BPF_CGROUP_INET_EGRESS:
+	case BPF_CGROUP_INET_SOCK_CREATE:
+	case BPF_CGROUP_INET_SOCK_RELEASE:
+	case BPF_CGROUP_INET4_BIND:
+	case BPF_CGROUP_INET6_BIND:
+	case BPF_CGROUP_INET4_POST_BIND:
+	case BPF_CGROUP_INET6_POST_BIND:
+	case BPF_CGROUP_INET4_CONNECT:
+	case BPF_CGROUP_INET6_CONNECT:
+	case BPF_CGROUP_UNIX_CONNECT:
+	case BPF_CGROUP_INET4_GETPEERNAME:
+	case BPF_CGROUP_INET6_GETPEERNAME:
+	case BPF_CGROUP_UNIX_GETPEERNAME:
+	case BPF_CGROUP_INET4_GETSOCKNAME:
+	case BPF_CGROUP_INET6_GETSOCKNAME:
+	case BPF_CGROUP_UNIX_GETSOCKNAME:
+	case BPF_CGROUP_UDP4_SENDMSG:
+	case BPF_CGROUP_UDP6_SENDMSG:
+	case BPF_CGROUP_UNIX_SENDMSG:
+	case BPF_CGROUP_UDP4_RECVMSG:
+	case BPF_CGROUP_UDP6_RECVMSG:
+	case BPF_CGROUP_UNIX_RECVMSG:
+	case BPF_CGROUP_SOCK_OPS:
+	case BPF_CGROUP_DEVICE:
+	case BPF_CGROUP_SYSCTL:
+	case BPF_CGROUP_GETSOCKOPT:
+	case BPF_CGROUP_SETSOCKOPT:
+	case BPF_LSM_CGROUP:
+		relative_fd =3D OPTS_GET(opts, cgroup.relative_fd, 0);
+		relative_id =3D OPTS_GET(opts, cgroup.relative_id, 0);
+		if (relative_fd && relative_id)
+			return libbpf_err(-EINVAL);
+		if (relative_id) {
+			attr.link_create.cgroup.relative_id =3D relative_id;
+			attr.link_create.flags |=3D BPF_F_ID;
+		} else {
+			attr.link_create.cgroup.relative_fd =3D relative_fd;
+		}
+		attr.link_create.cgroup.expected_revision =3D
+			OPTS_GET(opts, cgroup.expected_revision, 0);
+		if (!OPTS_ZEROED(opts, cgroup))
+			return libbpf_err(-EINVAL);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 777627d33d25..1342564214c8 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -438,6 +438,11 @@ struct bpf_link_create_opts {
 			__u32 relative_id;
 			__u64 expected_revision;
 		} netkit;
+		struct {
+			__u32 relative_fd;
+			__u32 relative_id;
+			__u64 expected_revision;
+		} cgroup;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b2591f5cab65..129a3382abb9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12848,6 +12848,34 @@ struct bpf_link *bpf_program__attach_xdp(const s=
truct bpf_program *prog, int ifi
 	return bpf_program_attach_fd(prog, ifindex, "xdp", NULL);
 }
=20
+struct bpf_link *
+bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgro=
up_fd,
+				const struct bpf_cgroup_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
+	__u32 relative_id;
+	int relative_fd;
+
+	if (!OPTS_VALID(opts, bpf_cgroup_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	relative_id =3D OPTS_GET(opts, relative_id, 0);
+	relative_fd =3D OPTS_GET(opts, relative_fd, 0);
+
+	if (relative_fd && relative_id) {
+		pr_warn("prog '%s': relative_fd and relative_id cannot be set at the s=
ame time\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	link_create_opts.cgroup.expected_revision =3D OPTS_GET(opts, expected_r=
evision, 0);
+	link_create_opts.cgroup.relative_fd =3D relative_fd;
+	link_create_opts.cgroup.relative_id =3D relative_id;
+	link_create_opts.flags =3D OPTS_GET(opts, flags, 0);
+
+	return bpf_program_attach_fd(prog, cgroup_fd, "cgroup", &link_create_op=
ts);
+}
+
 struct bpf_link *
 bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
 			const struct bpf_tcx_opts *opts)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d39f19c8396d..622de1b932ee 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -877,6 +877,21 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_netkit(const struct bpf_program *prog, int ifindex,
 			   const struct bpf_netkit_opts *opts);
=20
+struct bpf_cgroup_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 flags;
+	__u32 relative_fd;
+	__u32 relative_id;
+	__u64 expected_revision;
+	size_t :0;
+};
+#define bpf_cgroup_opts__last_field expected_revision
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgro=
up_fd,
+				const struct bpf_cgroup_opts *opts);
+
 struct bpf_map;
=20
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1205f9a4fe04..c7fc0bde5648 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -437,6 +437,7 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
 		bpf_object__prepare;
+		bpf_program__attach_cgroup_opts;
 		bpf_program__func_info;
 		bpf_program__func_info_cnt;
 		bpf_program__line_info;
--=20
2.47.1


