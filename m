Return-Path: <bpf+bounces-31365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196678FBB1D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496771C219E7
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BB4149DF4;
	Tue,  4 Jun 2024 18:00:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB61179BC
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524047; cv=none; b=rNwZllxnwpTJ0wGVWUQNent5qOf29C4JwrR/QiymK0iSqCj/6vCDb3tRFGBdh8IF2hESOAiK20p8dCNG7cgWmx8dfacQjLE4dgpwcpkWjGVKVadUPe3I3px6fa33DMJnTosxHewdSLn12PBYoHZGzlBn/wo7hwZbWwC2Uk/52Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524047; c=relaxed/simple;
	bh=fwORXAf0vGkgNor15LiulCZCerTJbuReDRgx6kQMv88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPTD/dae7xrdlQlnE6RwIuAtl4Pb6hwk/idCnBZAuRvE6tZj4/wh2uhlFTPb/FaAZzTBS/MNXTtvnDf9zsyKpB4x85FpZtIgCV8M0fLqPuyMpjv6SLQUXyuCkwuhyc97syeHghUapZ+ROu73RMm+L0J1WEIVgG4uaeaas2pAH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 18293518A725; Tue,  4 Jun 2024 11:00:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2] selftests/bpf: Ignore .llvm.<hash> suffix in kallsyms_find()
Date: Tue,  4 Jun 2024 11:00:34 -0700
Message-ID: <20240604180034.1356016-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I hit the following failure when running selftests with
internal backported upstream kernel:
  test_ksyms:PASS:kallsyms_fopen 0 nsec
  test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
  #123     ksyms:FAIL

In /proc/kallsyms, we have
  $ cat /proc/kallsyms | grep bpf_link_fops
  ffffffff829f0cb0 d bpf_link_fops.llvm.12608678492448798416
The CONFIG_LTO_CLANG_THIN is enabled in the kernel which is responsible
for bpf_link_fops.llvm.12608678492448798416 symbol name.

In prog_tests/ksyms.c we have
  kallsyms_find("bpf_link_fops", &link_fops_addr)
and kallsyms_find() compares "bpf_link_fops" with symbols
in /proc/kallsyms in order to find the entry. With
bpf_link_fops.llvm.<hash> in /proc/kallsyms, the kallsyms_find()
failed.

To fix the issue, in kallsyms_find(), if a symbol has suffix
.llvm.<hash>, that suffix will be ignored for comparison.
This fixed the test failure.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/trace_helpers.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
index 70e29f316fe7..dc871e642ed5 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -221,6 +221,18 @@ int kallsyms_find(const char *sym, unsigned long lon=
g *addr)
 		return -EINVAL;
=20
 	while (fscanf(f, "%llx %c %499s%*[^\n]\n", &value, &type, name) > 0) {
+		/* If CONFIG_LTO_CLANG_THIN is enabled, static variable/function
+		 * symbols could be promoted to global due to cross-file inlining.
+		 * For such cases, clang compiler will add .llvm.<hash> suffix
+		 * to those symbols to avoid potential naming conflict.
+		 * Let us ignore .llvm.<hash> suffix during symbol comparison.
+		 */
+		if (type =3D=3D 'd') {
+			char *res =3D strstr(name, ".llvm.");
+
+			if (res)
+				*res =3D '\0';
+		}
 		if (strcmp(name, sym) =3D=3D 0) {
 			*addr =3D value;
 			goto out;
--=20
2.43.0


