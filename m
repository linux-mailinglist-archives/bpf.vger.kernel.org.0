Return-Path: <bpf+bounces-59421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7439ACA7F5
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 03:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B04A17D338
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 01:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3F1922F5;
	Mon,  2 Jun 2025 00:36:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BE0211F
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824604; cv=none; b=UiwQTRAelMZoWSfudhMzSFtfgThxVxCQ8mAtyjSu+aD5CaSgXO0iRYEHnLypItWnrCK2OwACqMUI9gSZLunEUAPCR9QvNgId08GGhGrerjR8L92EAy/g0qJm6EBx4rOE737e8nWdmxM3acKCLaN0EuMBRcdmTd7wW3zUTHQh/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824604; c=relaxed/simple;
	bh=ty91GlAxMJLJfFgKsTiHr854awnxOcxq/vwcQmfQJ1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCEgHxCsvnXw73uFb7bv61Q1Xp8xWEqYzHc7xjR8sw0YhsjaO/hsOyew/HZjg1AcXCvKQD/MdpGgzBS/cAMqqt1/2dLOU/JO1FtfFWuU6szIQMuf4jB2lf4R8LU5E/DDOluwe//lCm38MxSGVZum0yyItTuNN9wgNKIcIRc98Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BB9BC8A7A7EB; Sun,  1 Jun 2025 17:36:27 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix a testmod compilation failure due to missing const modifier
Date: Sun,  1 Jun 2025 17:36:27 -0700
Message-ID: <20250602003627.1921138-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_attri=
bute::read/write()")
added constant modifier to 'struct bin_attribute *' for read/write
func pointer members. This caused compilation failure with clang20:

   bpf_testmod.c:494:10: error: incompatible function pointer types initi=
alizing
  'ssize_t (*)(struct file *, struct kobject *, const struct bin_attribut=
e *, char *, loff_t, size_t)'
  (aka 'long (*)(struct file *, struct kobject *, const struct bin_attrib=
ute *,
                 char *, long long, unsigned long)')
  with an expression of type 'ssize_t (struct file *, struct kobject *, s=
truct bin_attribute *,
                                       char *, loff_t, size_t)'
  (aka 'long (struct file *, struct kobject *, struct bin_attribute *, ch=
ar *, long long, unsigned long)')
  [-Wincompatible-function-pointer-types]
  494 |         .read =3D bpf_testmod_test_read,
      |                 ^~~~~~~~~~~~~~~~~~~~~
  ...

The same compilation error for functions bpf_testmod_test_write() and bpf=
_testmod_uprobe_write().

Fix the build failure by adding proper 'const' modifier.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e6c248e3ae54..e9e918cdf31f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
=20
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
-		      struct bin_attribute *bin_attr,
+		      const struct bin_attribute *bin_attr,
 		      char *buf, loff_t off, size_t len)
 {
 	struct bpf_testmod_test_read_ctx ctx =3D {
@@ -465,7 +465,7 @@ ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO);
=20
 noinline ssize_t
 bpf_testmod_test_write(struct file *file, struct kobject *kobj,
-		      struct bin_attribute *bin_attr,
+		      const struct bin_attribute *bin_attr,
 		      char *buf, loff_t off, size_t len)
 {
 	struct bpf_testmod_test_write_ctx ctx =3D {
@@ -567,7 +567,7 @@ static void testmod_unregister_uprobe(void)
=20
 static ssize_t
 bpf_testmod_uprobe_write(struct file *file, struct kobject *kobj,
-			 struct bin_attribute *bin_attr,
+			 const struct bin_attribute *bin_attr,
 			 char *buf, loff_t off, size_t len)
 {
 	unsigned long offset =3D 0;
--=20
2.47.1


