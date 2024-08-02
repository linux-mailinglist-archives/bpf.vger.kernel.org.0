Return-Path: <bpf+bounces-36308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D36946366
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 20:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289A41F230D4
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A21547C2;
	Fri,  2 Aug 2024 18:54:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E21ABEC2
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624893; cv=none; b=JllOG1RTXP3iVe56R8XUN7eUNpKfOzaZ18Eu0K3auG1IavlS76yO2zrkwEhwE+ezKTduBlYPDMY5X+VMEAatXJz/JGe4XHjhATUS0rcjr1BvK19iM78Un3ADxyd9Xg1mD33GSkTUU8Bh1F38ILJt6Szsm/CcRXTzUP52rIqCg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624893; c=relaxed/simple;
	bh=er5i1laqw7R5n7eweUqIzQYykdJJYf4P/J/WJNmyWUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwXJs07Y9u2tpWGofasRWtfRj8mv7PS71AWB+gMfXeDUCd8ZMLU/hNVob3zp+VT2DWMmhc/VZwQvCUT/qCP3uBW2YWXRj70yRpQkqIKnS77pd/VySUsWS23e83DTYvOxE1Ib4IRLVxcqltMSW/ARsdrOqu+BUhLJIuU9430+BeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id C60C2748DCDF; Fri,  2 Aug 2024 11:54:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix a btf_dump selftest failure
Date: Fri,  2 Aug 2024 11:54:34 -0700
Message-ID: <20240802185434.1749056-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Jakub reported bpf selftest "btf_dump" failure after forwarding to
v6.11-rc1 with netdev.
  Error: #33 btf_dump
  Error: #33/15 btf_dump/btf_dump: var_data
    btf_dump_data:FAIL:find type id unexpected find type id: actual -2 < =
expected 0

The reason for the failure is due to
  commit 94ede2a3e913 ("profiling: remove stale percpu flip buffer variab=
les")
where percpu static variable "cpu_profile_flip" is removed.

Let us replace "cpu_profile_flip" with a variable in bpf subsystem
so whenever that variable gets deleted or renamed, we can detect the
failure immediately. In this case, I picked a static percpu variable
"bpf_cgrp_storage_busy" which is defined in kernel/bpf/bpf_cgrp_storage.c=
.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
index 09a8e6f9b379..b293b8501fd6 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -805,8 +805,8 @@ static void test_btf_dump_var_data(struct btf *btf, s=
truct btf_dump *d,
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number =3D (int)100", 100);
 #endif
-	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_profile_flip", int, BTF_F_COM=
PACT,
-			  "static int cpu_profile_flip =3D (int)2", 2);
+	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_cgrp_storage_busy", int, BTF_=
F_COMPACT,
+			  "static int bpf_cgrp_storage_busy =3D (int)2", 2);
 }
=20
 static void test_btf_datasec(struct btf *btf, struct btf_dump *d, char *=
str,
--=20
2.43.0


