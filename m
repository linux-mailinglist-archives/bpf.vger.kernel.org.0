Return-Path: <bpf+bounces-77881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298BCCF5A39
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 22:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B42C3109E0A
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E32DECBA;
	Mon,  5 Jan 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+ns49Tg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318A2DCC05;
	Mon,  5 Jan 2026 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647597; cv=none; b=kEtUk1FZ8VHVTvEPhJssM9JkMP/PQ537MtZ/oyubseumm+RMgwQN1d9+Zj3gFTgbPXcOFmRN1VZS0C8osqPrdUDdTdtCCmmy2dcfi5DcojU3zBz34qVYmSwOCFF8m+4XVBYtbIrdCxqRGB9kJiRUSX2XN2Da/68+G9tLFi3ZiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647597; c=relaxed/simple;
	bh=WPRm7ypDLH4oUKUKkFSKKcB4TUBktJTRAz56zlFb6VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iiEIwL5+2TMkDVa3e11c+F2yPByb6J8aBr9ykLn0KoF/G3p5kcU+DcKez9pJK4pCkotS04+QS64yOiCLS03RyN4HMZL60fWPWQaNmEp0vJf1Ep2AMYz+8eeUjjhv4aij6EtWK74eYI224fP13DE8wkMa65hzuZ6OrH1kizxbMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+ns49Tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53DAC116D0;
	Mon,  5 Jan 2026 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647597;
	bh=WPRm7ypDLH4oUKUKkFSKKcB4TUBktJTRAz56zlFb6VA=;
	h=From:Date:Subject:To:Cc:From;
	b=S+ns49TgVNGcLLixmeR4+AoejeRF/MxqtaHOPpyz4JU9pExUpJhiRi15q/GJnRxiu
	 X2chpKUJN8cxVr4744gHZaG3jf4Kt6mLodu6eJH+Gj9nmV6hsNJFzBPwxUuy+G8E3/
	 LAtkFA/qqusbvzqchdD2/fdhTO5r+qSQAuptZ2V+E5KhC07nTl+dx2J2jj2A7N9cl5
	 GblkUKX3PC4SZeKxJaX03GY7NbXrTd1bB6txvk1aFTjxugeof9N1c4tUC5It1/mUDP
	 RLwP9hqWCiRb09UVjqS68vJTC4Rm8y7hJaQKB46MkeJpIfacqjB8ovVsIaPoDotSP0
	 Uc+9RYwvT4aoQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 05 Jan 2026 14:12:58 -0700
Subject: [PATCH bpf-next] scripts/gen-btf.sh: Disable LTO when generating
 initial .o file
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-fix-gen-btf-sh-lto-v1-1-18052ea055a9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFkpXGkC/yWM0QqCQBBFf0XmuYFRSqtfCR9au6sTscrOKoL47
 235eLj3nI0MUWF0LzaKWNR0DBnKU0Hd8Aw9WF+ZqZKqllIu7HXlHoFd8mwDf9LIIo3H+SZXaYS
 yOEXk1z/6IDd5DlgTtcdis3ujS78m7fsXEIBPdYAAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=nathan@kernel.org;
 h=from:subject:message-id; bh=WPRm7ypDLH4oUKUKkFSKKcB4TUBktJTRAz56zlFb6VA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJkxmln6mj7PjzkzZ0VccZobV83CNHkC5+S8VVk29yeIf
 FrP9Neto5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAExkQi/DX/m7S3/af5IpeLZN
 aM2mSy1Wd0x+JhlJ/pWe9n7P8at2/LoM/2tW/2xceG/qshN5r4UFTssxqx36em5S5+TpO4JWvu9
 4+4sJAA==
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

Fixes: 600605853f87 ("scripts/gen-btf.sh: Fix .btf.o generation when compiling for RISCV")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/gen-btf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index d6457661b9b6..08b46b91c04b 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -87,7 +87,7 @@ gen_btf_o()
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
 	# deletes all symbols including __start_BTF and __stop_BTF, which will
 	# be redefined in the linker script.
-	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -c -x c -o ${btf_data} -
+	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
 	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
 		--set-section-flags .BTF=alloc,readonly ${btf_data}
 	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}

---
base-commit: a069190b590e108223cd841a1c2d0bfb92230ecc
change-id: 20260105-fix-gen-btf-sh-lto-007fe4908070

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


