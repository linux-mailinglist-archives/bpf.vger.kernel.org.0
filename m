Return-Path: <bpf+bounces-78018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AA8CFB485
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 23:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D99063086250
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 22:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A930FC1D;
	Tue,  6 Jan 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVpulXBA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C1223328;
	Tue,  6 Jan 2026 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767739469; cv=none; b=A43xxcEIhggXp/jGmIAVS1ntPmzeNJ/lId8FQ2DcA8oXv3STAv0Lu/4O5ANECfkFZMwvK8CKHKk4we2CRNMZ/u2r8HqLxF1nDDjraVzYXb25E8jiRZWnlqiMtjtjViBirMRo2kAOJB475uUInysRInDceVB7q0Uc01OMC5YSjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767739469; c=relaxed/simple;
	bh=ZImdrhVwIvXY5i6DEvxY+nzy/CyOo32UThWkKiwRZW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kjS0zO1Bej9LDW3XIDbU6KO6RVkF1Jr6j5wJOh5GYUhCnFLtYyrBfGVkXgk7d1oANL3bLSNuEdqRG14ab6XVudd74fzU/drFV/A+BLtFRIzuY5mHLnwkJg9c17I6NxH1xisDHwlUaYticTDriwEEaP3R3OeBemuBVs6XjgFsI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVpulXBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999AFC19421;
	Tue,  6 Jan 2026 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767739469;
	bh=ZImdrhVwIvXY5i6DEvxY+nzy/CyOo32UThWkKiwRZW8=;
	h=From:Date:Subject:To:Cc:From;
	b=EVpulXBAZitxeQtZ34+1p6L0bOn8Te6Vz95N5ytFdAARkicVcm26Kt2T8FZiD5KAP
	 x+c3r0ogbpRKM5gaW7F+sJFeIXFcdkj47E5/iogKxYuOszwO99fYAVd93uoWX+XhKd
	 RjC+avH8JuZJYINCkGLe+MbdEFh6DUSTwkiWX/AjoDVF8M7O8/dhVKRbIVFglNJmNC
	 bFNB5d6P7xQ6h6mNP6JKvMWUXOT6c8VKX0NYvrP3rXeJoAklPoH+M9MbFP5sjumiK0
	 C97hFcgQzXDl2gC12b0gJjzFyEOux2pbhzWWImIwV79TXJwTv/7B2bggLl2k+P4g8M
	 JaEa3+MOIS22w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 06 Jan 2026 15:44:20 -0700
Subject: [PATCH bpf-next v2] scripts/gen-btf.sh: Ensure initial object in
 gen_btf_o is ELF with correct endianness
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-fix-gen-btf-sh-lto-v2-1-01d3e1c241c4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEOQXWkC/32NwQ6CMBBEf4Xs2TVLYwU88R+GA+AWqqQlbSUY0
 n+34N3MaTJvZjbw7DR7uGUbOF6019YkI04Z9GNrBkb9SB4EiSvlJFHpFQc22AWFfsQpWCQqFF8
 qKqkgSMXZcaKO0Tt0s0LDa4Dml/h39+Q+7Js7O2ofrPsc/0t+NP5dLTkmlSQFtyRlW9Uvdoans
 3UDNDHGL8kEb+TRAAAA
X-Change-ID: 20260105-fix-gen-btf-sh-lto-007fe4908070
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ZImdrhVwIvXY5i6DEvxY+nzy/CyOo32UThWkKiwRZW8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJmxE7yfvHjirqdrnHe4/fy2DrNt4aoxuccv2/YG6KpzM
 mumZ7zsKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABNxZmBk+Pbm5xGZZcHFt9kz
 HYs/RadriNwR95t+Jok5d+o+r5OMKowM7f4/9ETbIicwbShM0tHa3hruuzdr9ssVO3tmbq7rWMz
 JCQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 600605853f87 ("scripts/gen-btf.sh: Fix .btf.o generation
when compiling for RISCV"), there is an error from llvm-objcopy when
CONFIG_LTO_CLANG is enabled:

  llvm-objcopy: error: '.tmp_vmlinux1.btf.o': The file was not recognized as a valid object file
  Failed to generate BTF for vmlinux

KBUILD_CFLAGS includes CC_FLAGS_LTO, which makes clang emit an LLVM IR
object, rather than an ELF one as expected by llvm-objcopy.

Most areas of the kernel deal with this by filtering out CC_FLAGS_LTO
from KBUILD_CFLAGS for the particular object or directory but this is
not so easy to do in bash. Just include '-fno-lto' after KBUILD_CFLAGS
to ensure an ELF object is consistently created as the initial .o file.

Additionally, while there is no reported or discovered bug yet, the
absence of KBUILD_CPPFLAGS from this command could result in incorrect
endianness because KBUILD_CPPFLAGS typically contains '-mbig-endian' and
'-mlittle-endian' so that biendian toolchains can be used. Include it in
this ${CC} command to hopefully limit necessary changes to this command
for the foreseeable future.

Fixes: 600605853f87 ("scripts/gen-btf.sh: Fix .btf.o generation when compiling for RISCV")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Conservatively include KBUILD_CPPFLAGS as well, as it contains
  endianness flags for some targets.
- Link to v1: https://patch.msgid.link/20260105-fix-gen-btf-sh-lto-v1-1-18052ea055a9@kernel.org
---
 scripts/gen-btf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index d6457661b9b6..be21ccee3487 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -87,7 +87,7 @@ gen_btf_o()
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
 	# deletes all symbols including __start_BTF and __stop_BTF, which will
 	# be redefined in the linker script.
-	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -c -x c -o ${btf_data} -
+	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
 	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
 		--set-section-flags .BTF=alloc,readonly ${btf_data}
 	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}

---
base-commit: a069190b590e108223cd841a1c2d0bfb92230ecc
change-id: 20260105-fix-gen-btf-sh-lto-007fe4908070

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


