Return-Path: <bpf+bounces-21543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4D84E997
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 21:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83546290C5A
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E4383AE;
	Thu,  8 Feb 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZLGP+Hq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A1383AC;
	Thu,  8 Feb 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423692; cv=none; b=bdcxN1G2N190QUXaHj+B3oxloNEq+nDxWJtLZSOS8a0KgwqAWNn/xTCtNff/c/mvRLUk3WX7SP4fROcAT4RoOE4bXyms/+KTzK+w0Xcn3ej5u3tlxJxujjK5pV3/SMu8bowG2kORBIPRMg+7S03BNOq1Uk+Iidfs7A5ZnUPNGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423692; c=relaxed/simple;
	bh=FH8fbuchXr295/cl9XVN63SHOJd9euhFBo7S/R60/uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SmaRNN7lPanMazC1GoBQcd0+Mf5Tie4F3J14n3Js0uHuoY0f+abGVBwzFPxBu9KXcoCmxSosLSB3XEX6yP0UacmfBUcEdvgYkSNbkXcpVp+/QbYrZGp4aatripH90uS7mx9Hae/Bg5mCF15m3RN1ZVJXKURSOwhIpCmUZFzaQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZLGP+Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DE0C433F1;
	Thu,  8 Feb 2024 20:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707423691;
	bh=FH8fbuchXr295/cl9XVN63SHOJd9euhFBo7S/R60/uc=;
	h=From:Date:Subject:To:Cc:From;
	b=iZLGP+HqVUVnrEgMOTFY84TxpPyXDwGiLTL3i/fEQH2lgoflXSLZJFnZdvSTgOkiw
	 jmulPvDIrLt94n56j0neAD2N3y1miHWN+uZ92rfWWEdI+oaEtJv1RFEcBAYifuihBe
	 RjphdedL9zrarPG0WMumv6Zda4HfDBDsPMEOy5AtoB3lSUHFcVDCmS0t9GJSeboZvr
	 V5FZCqxNHiiJgduOShRquh/W46cMHIsfR2d3Bw0gZrQBQBCsYiewRNzJYQcoHQfQT6
	 hSH4hGSW7kWxYSjsWr7CZI8bhVh4JDNcf/LiYWU054Oh+/PTnN/ByddnAcLxf7Y/3Q
	 9BjZZdaSzdYSw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 08 Feb 2024 13:21:06 -0700
Subject: [PATCH] kbuild: Fix changing ELF file type for output of gen_btf
 for big endian
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>
X-B4-Tracking: v=1; b=H4sIALE3xWUC/x2NQQqDMBBFryKz7ock1NL2KqWLxEzsgB0lsaKId
 zd08+At3v87Fc7ChZ7NTpkXKTJqFXtpqPt47RkSq5Mz7mqcuSPJCh4S5m1ihDlh+Q6ivxVBFGN
 lD9YoXhFD17besnWPG9W9KXON/1+v93GcyaHWvXsAAAA=
To: masahiroy@kernel.org
Cc: nicolas@fjasle.eu, ndesaulniers@google.com, morbo@google.com, 
 justinstitt@google.com, keescook@chromium.org, maskray@google.com, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2831; i=nathan@kernel.org;
 h=from:subject:message-id; bh=FH8fbuchXr295/cl9XVN63SHOJd9euhFBo7S/R60/uc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHzU/NN9p7SGvdqcIZ9UdMTaQ9sy9o8flFHr/8fbXxu
 +JP70VbOkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBE9u5hZLjbfmXxQsfdMVP+
 btS8E3UtcH5yWcWZIGWuqP4N5iZ1Ru8YGe5vT2K8eHatw5Mp36aLt2VL20ssX6RlNjH5tPdd9x3
 /4ngB
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
changed the ELF type of .btf.vmlinux.bin.o from ET_EXEC to ET_REL via
dd, which works fine for little endian platforms:

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

Fix this by using a different seek value for dd when targeting big
endian, so that the correct byte gets changed and everything works
correctly for all linkers.

   00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF............|
  -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
  +00000010  00 01 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|

  Type:                              REL (Relocatable file)

Cc: stable@vger.kernel.org
Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
Link: https://github.com/llvm/llvm-project/pull/75643
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/link-vmlinux.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a432b171be82..8a9f48b3cb32 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -135,8 +135,15 @@ gen_btf()
 	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
 		--strip-all ${1} ${2} 2>/dev/null
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
-	# Unlike GNU ld, lld does not allow an ET_EXEC input.
-	printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16 status=none
+	# Unlike GNU ld, lld does not allow an ET_EXEC input. Make sure the correct
+	# byte gets changed with big endian platforms, otherwise e_type may be an
+	# invalid value.
+	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
+		seek=17
+	else
+		seek=16
+	fi
+	printf '\1' | dd of=${2} conv=notrunc bs=1 seek=${seek} status=none
 }
 
 # Create ${2} .S file with all symbols from the ${1} object file

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-dbc55a1e1296

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


