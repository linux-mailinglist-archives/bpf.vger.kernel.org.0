Return-Path: <bpf+bounces-59364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2936AC94D4
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04143A42F53
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AEC22D4F2;
	Fri, 30 May 2025 17:38:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6112609FD
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626724; cv=none; b=EkWgvHDPN9tDkNiZHAUSDTXFFAwqejU/oEW4kFvN2OuQtW1Z6+V9AgrNK6AbgRJPNdGoSsoBSHBWq9MgCvacXcg3WrrIXJ2DlO5vwe/7guglvYSiBDG3qoECgHRYLwj3yrhvb7JmQ41xpKN2O2CSquWZUi5fse9mh5m8eras+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626724; c=relaxed/simple;
	bh=1D7k5ZoOUIjdasVeus6Xm3V9VHldFXPDrrlkYLpRHoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoqapVhp6ztXCBQ8+CA/2lDbgM6dYvKKhfFUAmpr8Qjts8Or8XJmpsiMcI3qi8xydXBb5UTXq7CcsCQfUi8mgaC/0Ha6UwuKqN6Aokeyv37ih4UaQxjAoySxA+ONltcwQOihAygBwTXBPQcbtG1C0dLP8OrycE4kjgV5C59yP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2361F88B398D; Fri, 30 May 2025 10:38:33 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 4/5] selftests/bpf: Move some tc_helpers.h functions to test_progs.h
Date: Fri, 30 May 2025 10:38:33 -0700
Message-ID: <20250530173833.1825358-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250530173812.1823479-1-yonghong.song@linux.dev>
References: <20250530173812.1823479-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move static inline functions id_from_prog_fd() and id_from_link_fd()
from prog_tests/tc_helpers.h to test_progs.h so these two functions
can be reused for later cgroup mprog selftests.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/tc_helpers.h     | 28 -------------------
 tools/testing/selftests/bpf/test_progs.h      | 28 +++++++++++++++++++
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h b/tools/=
testing/selftests/bpf/prog_tests/tc_helpers.h
index 924d0e25320c..d52a62af77bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
@@ -8,34 +8,6 @@
 # define loopback 1
 #endif
=20
-static inline __u32 id_from_prog_fd(int fd)
-{
-	struct bpf_prog_info prog_info =3D {};
-	__u32 prog_info_len =3D sizeof(prog_info);
-	int err;
-
-	err =3D bpf_obj_get_info_by_fd(fd, &prog_info, &prog_info_len);
-	if (!ASSERT_OK(err, "id_from_prog_fd"))
-		return 0;
-
-	ASSERT_NEQ(prog_info.id, 0, "prog_info.id");
-	return prog_info.id;
-}
-
-static inline __u32 id_from_link_fd(int fd)
-{
-	struct bpf_link_info link_info =3D {};
-	__u32 link_info_len =3D sizeof(link_info);
-	int err;
-
-	err =3D bpf_link_get_info_by_fd(fd, &link_info, &link_info_len);
-	if (!ASSERT_OK(err, "id_from_link_fd"))
-		return 0;
-
-	ASSERT_NEQ(link_info.id, 0, "link_info.id");
-	return link_info.id;
-}
-
 static inline __u32 ifindex_from_link_fd(int fd)
 {
 	struct bpf_link_info link_info =3D {};
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index 870694f2a359..df2222a1806f 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -460,6 +460,34 @@ static inline void *u64_to_ptr(__u64 ptr)
 	return (void *) (unsigned long) ptr;
 }
=20
+static inline __u32 id_from_prog_fd(int fd)
+{
+	struct bpf_prog_info prog_info =3D {};
+	__u32 prog_info_len =3D sizeof(prog_info);
+	int err;
+
+	err =3D bpf_obj_get_info_by_fd(fd, &prog_info, &prog_info_len);
+	if (!ASSERT_OK(err, "id_from_prog_fd"))
+		return 0;
+
+	ASSERT_NEQ(prog_info.id, 0, "prog_info.id");
+	return prog_info.id;
+}
+
+static inline __u32 id_from_link_fd(int fd)
+{
+	struct bpf_link_info link_info =3D {};
+	__u32 link_info_len =3D sizeof(link_info);
+	int err;
+
+	err =3D bpf_link_get_info_by_fd(fd, &link_info, &link_info_len);
+	if (!ASSERT_OK(err, "id_from_link_fd"))
+		return 0;
+
+	ASSERT_NEQ(link_info.id, 0, "link_info.id");
+	return link_info.id;
+}
+
 int bpf_find_map(const char *test, struct bpf_object *obj, const char *n=
ame);
 int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
--=20
2.47.1


