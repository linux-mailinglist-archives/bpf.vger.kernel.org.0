Return-Path: <bpf+bounces-23248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA56386F17A
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 17:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184FF1C2116A
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3867322636;
	Sat,  2 Mar 2024 16:50:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0520DC5
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398241; cv=none; b=i3/TIesE10gbvhTS+JyWUvVUvDRZVfP0yNxD9VQVrLzuEZ5BINaXL13pO5ooDb/HA5DUJ9Q5w3TY5pf9HRjF+Q5XJzXPk7VbwFj6waFPMp/QmkyDNbNefF1c5nfe9fmRZwF6cwbtHAoyk+GZ2cy6LoN0ZVcnQQB08f/+BNA2nkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398241; c=relaxed/simple;
	bh=r8v/NSiCBB8CdbYb+ClQEZtGaq+Dewk9RsQ7YoaddyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BigXUR6nJm3sX4IvcK2jq+MTUv7AsL1pwLCijLNYjHHyqaWH7+fDba3tEOaYH89Bg2ylV6ig0xkU7RlQzJ4PybhBnk2fj9t7seJFxkVA3gy7s4xyMoeLr2gzsySaO9yY71w39EHtJ/D52LUjh8S0nVncVjmmwbEseJ5W8YmXEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1BBC411F11FD; Sat,  2 Mar 2024 08:50:27 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/4] selftests/bpf: Add check_lto_kernel() helper
Date: Sat,  2 Mar 2024 08:50:27 -0800
Message-ID: <20240302165027.1628051-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302165017.1627295-1-yonghong.song@linux.dev>
References: <20240302165017.1627295-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add check_lto_kernel() helper to detect whether the underlying kernel
enabled CONFIG_LTO or not. The function check_lto_kernel() can be
used by selftests to handle some lto-specific situations.

The code is heavily borrowed from libbpf function
bpf_object__read_kconfig_file().

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/testing_helpers.c | 47 +++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  1 +
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
index 28b6646662af..3f74f73843cf 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -5,6 +5,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <zlib.h>
+#include <sys/utsname.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 #include "test_progs.h"
@@ -475,3 +477,48 @@ bool is_jit_enabled(void)
=20
 	return enabled;
 }
+
+int check_lto_kernel(void)
+{
+	static int check_lto =3D 2;
+	char buf[PATH_MAX];
+	struct utsname uts;
+	gzFile file;
+	int len;
+
+	if (check_lto !=3D 2)
+		return check_lto;
+
+	uname(&uts);
+	len =3D snprintf(buf, PATH_MAX, "/boot/config-%s", uts.release);
+	if (len < 0) {
+		check_lto =3D -EINVAL;
+		goto out;
+	} else if (len >=3D PATH_MAX) {
+		check_lto =3D -ENAMETOOLONG;
+		goto out;
+	}
+
+	/* gzopen also accepts uncompressed files. */
+	file =3D gzopen(buf, "re");
+	if (!file)
+		file =3D gzopen("/proc/config.gz", "re");
+
+	if (!file) {
+		check_lto =3D -ENOENT;
+		goto out;
+	}
+
+	check_lto =3D 0;
+	while (gzgets(file, buf, sizeof(buf))) {
+		/* buf also contains '\n', skip it during comparison. */
+		if (!strncmp(buf, "CONFIG_LTO=3Dy", 12)) {
+			check_lto =3D 1;
+			break;
+		}
+	}
+
+	gzclose(file);
+out:
+	return check_lto;
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testin=
g/selftests/bpf/testing_helpers.h
index d55f6ab12433..57683b3a1280 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -55,5 +55,6 @@ struct bpf_insn;
 int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
 int testing_prog_flags(void);
 bool is_jit_enabled(void);
+int check_lto_kernel(void);
=20
 #endif /* __TESTING_HELPERS_H */
--=20
2.43.0


