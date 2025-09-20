Return-Path: <bpf+bounces-69103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDB7B8CBB8
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689821B22BB7
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1221CC64;
	Sat, 20 Sep 2025 15:35:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351992AEF5
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382549; cv=none; b=Zf/f0s4TgaEa0e6GFZu5Vs9XmOBCJddVAihX4nKGB9AJG7G/Hi7f1RPmFYtMhLcEli0QWfHT+CPQWCdsCwBqk7m7V+80W4Cqn/9tE42LPkdClgf+q/tZ1/sJEH9spIydnNJQSvLNEv85U7VmjuvLJ3uXGmfjHRh0L6+rwYPLlMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382549; c=relaxed/simple;
	bh=sUs+mD7oXIa2PGxIiUnqGQOS1pO5Uhe8Gvgvj2gZvfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrT5ybdTYwpAM67DwlcuS8Ft5KBX22uLG4WKLrHcq5FbHj/ZvmJN1YQXkZwWOoFpbh8ey525lOtk+WKd+Foclf77tAt1MWK4LVp67TCd44ztWOPdzbLKZT9fb3wkBPpC8V0Dg3VNItZLEbBfCIUcq0GRsEFH97+sfanmLjYr+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0B09410968823; Sat, 20 Sep 2025 08:35:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] libbpf: Silence newly-added and unused sections
Date: Sat, 20 Sep 2025 08:35:31 -0700
Message-ID: <20250920153531.3675700-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest llvm22, when building bpf selftest, I got the following info
emitted by libbpf:
  ...
  libbpf: elf: skipping unrecognized data section(14) .comment
  libbpf: elf: skipping section(15) .note.GNU-stack (size 0)
  ...

The reason is due to llvm patch [1]. Previously, bpf class BPFMCAsmInfo
inherits class MCAsmInfo. With [1], BPFMCAsmInfo inherits class
MCAsmInfoELF. Such a change added two more sections in the bpf binary, e.=
g.
  [Nr] Name              Type            Address          Off    Size   E=
S Flg Lk Inf Al
  ...
  [23] .comment          PROGBITS        0000000000000000 0035ac 00006d 0=
1  MS  0   0  1
  [24] .note.GNU-stack   PROGBITS        0000000000000000 003619 000000 0=
0      0   0  1
  ...

Adding the above two sections in elf section ignore list can avoid the
above info dump during selftest build.

  [1] https://github.com/llvm/llvm-project/commit/d9489fd073c0e100c6fbb1e=
5aef140b00cf62b81

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5161c2b39875..34aed7904039 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3788,6 +3788,14 @@ static bool ignore_elf_section(Elf64_Shdr *hdr, co=
nst char *name)
 	if (is_sec_name_dwarf(name))
 		return true;
=20
+	/* .comment section */
+	if (strcmp(name, ".comment") =3D=3D 0)
+		return true;
+
+	/* .note.GNU-stack section */
+	if (strcmp(name, ".note.GNU-stack") =3D=3D 0)
+		return true;
+
 	if (str_has_pfx(name, ".rel")) {
 		name +=3D sizeof(".rel") - 1;
 		/* DWARF section relocations */
--=20
2.47.3


