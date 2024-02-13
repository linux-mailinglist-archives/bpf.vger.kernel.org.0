Return-Path: <bpf+bounces-21821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B7C852742
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 03:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA1B22BD2
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712C1C3D;
	Tue, 13 Feb 2024 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRj+SELi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ADD17CD;
	Tue, 13 Feb 2024 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789993; cv=none; b=XlaTpqLurxMG51Mnm6v2WtDfbrcOS/29uqq8EgpkAMcQ8ymdWi4jfjfZbdHIxPhgeouucriFbR4L0uoX8A3jAeh7pcdoncSM2QT/zBwqg8BpNEELiGisVtTP2XUqUESpN9jOB2j11+JVPyR4532HXpzAunMpTtd8wbdV/1lCKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789993; c=relaxed/simple;
	bh=GhodOs1V2xvOg/8UtJ2cJDvK0Yy+94bNZ2qlcF51JzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lPy0hqfsYoxTWSiP2A2rhjaky12fyw/HCd9RV/6O9feB5IiW6n86/nJqOEWUb4lX2+6bqyyMjXr1LX1KibRPGvw0KZQi4BQTBV+BjMEjanxYWydCMnJ3RiGzUqbOB2cfde3nb4VvpKRXepDfMjMnfUTv19EJ4XZ6+Yk4N5KdZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRj+SELi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67687C43390;
	Tue, 13 Feb 2024 02:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707789993;
	bh=GhodOs1V2xvOg/8UtJ2cJDvK0Yy+94bNZ2qlcF51JzE=;
	h=From:Date:Subject:To:Cc:From;
	b=CRj+SELiZgtse3AvGDswZUGQtNGurzicPdya+lzZpVN6mn8erquLzSmQb6BsS7GQ8
	 8V2Iu7BOiqcQlsKJx1p2BE8QHoauzDlVSZ1dzxbQ/4MdkcqcHDnQl8ShSEL1vvfF9L
	 miEXJ9mSJ3fZGSXYx887CZ9mNQS4GLlZzFBjaueDEHk4FbDVEVWtUqg9ffH7Qr6HQO
	 HMYBRw5BO5N2HDHoTazB63qbZbL/L0FwWzzXNZAlfEkeU3JvQCFs7RKcbJsGtc0HjY
	 jgtzKMt7lb5H7+ts27HbBYxUBy5s+4wwOXDhqqYCz95949hLZwqM7MdGcOGpPPXLMI
	 hF7H78tXGoHeg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 12 Feb 2024 19:05:10 -0700
Subject: [PATCH v2] kbuild: Fix changing ELF file type for output of
 gen_btf for big endian
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-fix-elf-type-btf-vmlinux-bin-o-big-endian-v2-1-22c0a6352069@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFXOymUC/52NQQ6CMBBFr0K6dgxTwYgr72FY0HaAidiStjYQw
 t2tHMHNT95P/n+bCOSZgrgXm/CUOLCzGeSpEHrs7EDAJrOQpaxKWd6g5wVo6iGuM4GKPaT3xPa
 zgGILLucAZA13FozSdd0hoWyuIv/NnvL4cD3bzCOH6Px6qBP+2n8sCQFBqwuirBokox8v8pams
 /ODaPd9/wK60mOo4wAAAA==
To: masahiroy@kernel.org
Cc: nicolas@fjasle.eu, ndesaulniers@google.com, morbo@google.com, 
 justinstitt@google.com, keescook@chromium.org, maskray@google.com, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3417; i=nathan@kernel.org;
 h=from:subject:message-id; bh=GhodOs1V2xvOg/8UtJ2cJDvK0Yy+94bNZ2qlcF51JzE=;
 b=kA0DAAoWHWsmkXHAGpYByyZiAGXKzqiiMLNKtKv9HTNpLWHt7NZXR3+qPImDrmxtWD1S+S6yN
 Ih1BAAWCgAdFiEEe+MlxzExnM0B2MqSHWsmkXHAGpYFAmXKzqgACgkQHWsmkXHAGpZowQD9HgK/
 EKkJcLelCNEJj8ruFirq96NFEySH3V7/YfAazHMA/jBB7etsCJZp0turV2NVbyGj0WmJvoZnykM
 UoQQk2GMJ
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
changed the ELF type of .btf.vmlinux.bin.o to ET_REL via dd, which works
fine for little endian platforms:

   00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
  -00000010  03 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |................|
  +00000010  01 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |................|

However, for big endian platforms, it changes the wrong byte, resulting
in an invalid ELF file type, which ld.lld rejects:

   00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF............|
  -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
  +00000010  01 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|

  Type:                              <unknown>: 103

  ld.lld: error: .btf.vmlinux.bin.o: unknown file type

Fix this by updating the entire 16-bit e_type field rather than just a
single byte, so that everything works correctly for all platforms and
linkers.

   00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF............|
  -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
  +00000010  00 01 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|

  Type:                              REL (Relocatable file)

While in the area, update the comment to mention that binutils 2.35+
matches LLD's behavior of rejecting an ET_EXEC input, which occurred
after the comment was added.

Cc: stable@vger.kernel.org
Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
Link: https://github.com/llvm/llvm-project/pull/75643
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Rather than change the seek value for dd, update the entire e_type
  field (Masahiro). Due to this change, I did not carry forward the
  tags of v1.
- Slightly update commit message to remove mention of ET_EXEC, which
  does not match the dump (Masahiro).
- Update comment to mention binutils 2.35+ has the same behavior as LLD
  (Fangrui).
- Link to v1: https://lore.kernel.org/r/20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org
---
 scripts/link-vmlinux.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a432b171be82..7862a8101747 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -135,8 +135,13 @@ gen_btf()
 	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
 		--strip-all ${1} ${2} 2>/dev/null
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
-	# Unlike GNU ld, lld does not allow an ET_EXEC input.
-	printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16 status=none
+	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
+	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
+		et_rel='\0\1'
+	else
+		et_rel='\1\0'
+	fi
+	printf "${et_rel}" | dd of=${2} conv=notrunc bs=1 seek=16 status=none
 }
 
 # Create ${2} .S file with all symbols from the ${1} object file

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-dbc55a1e1296

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


