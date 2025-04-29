Return-Path: <bpf+bounces-56996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 193CBAA3D7C
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964D31893C80
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A64289E13;
	Tue, 29 Apr 2025 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcoAUxiZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894A256995;
	Tue, 29 Apr 2025 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970682; cv=none; b=pCG2xpqWlRa9UZRs01k3wNcIlTs3k86szQm/N//mcEcwJgidFGhm2QCvWiJn9OQziMhGuSRr0KFXsUEb6AdNrqwZrNAfV5jhRrolnlVGlEnJnB+/QRuErLhXpOqVF82D4He1+Jbd2yB3PiA+lnC8/NE7f/kVaEF7HUfmn50CYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970682; c=relaxed/simple;
	bh=ugnFpq/CJSiQpHZT0kH7G9ZFQdagTJgfEfE3JRV6fFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6+WAi4m6oTcN0CnHgzQNMQ8AT4csymWcY/pHsuZLNHfz20m+9z8eWckYELSDXnyPRigZ8PNchsrELRVo+ZLgOF5UWV9XRhCta3vQJjTYaWEB8RN5mgsLH9mbWt4BjRHWjdA8HCAnBaVI7cRxrjxIA4cHisltOsp0MkndPaCSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcoAUxiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD48BC4CEE3;
	Tue, 29 Apr 2025 23:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970682;
	bh=ugnFpq/CJSiQpHZT0kH7G9ZFQdagTJgfEfE3JRV6fFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcoAUxiZoOPYCuhS6vf9GK0Fw2CVOeI0C03x8dlkOSb23N8uNIEz/wxaSvvP21tj2
	 ikG3OrxwJPFX/j4rDveqBuawR43z1jpXlrmBW+rkCuQBA/3gnqmILqHXgPh+Ncu+jc
	 o//749AfFbsNfG5iSa6tEv6vC3gWPwC1YkGOB+NImrj1I0kBnB7k31oogQLDOgmCfV
	 O3M/nsCnREVIDuf1GcYexcmmljCqWAKZTIHV8qnCv0Gtd9+bp+zr0kyDz1ZPTg5F9G
	 g6WZA1sc4BnWAtk8+4leMOCPutykXstm7gERnKC4GguEO561ER7bwC5gpEqMwj3kdC
	 dhs0QgaIvdlIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoran Jiang <jianghaoran@kylinos.cn>,
	zhangxi <zhangxi@kylinos.cn>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	nathan@kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 39/39] samples/bpf: Fix compilation failure for samples/bpf on LoongArch Fedora
Date: Tue, 29 Apr 2025 19:50:06 -0400
Message-Id: <20250429235006.536648-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Haoran Jiang <jianghaoran@kylinos.cn>

[ Upstream commit 548762f05d19c5542db7590bcdfb9be1fb928376 ]

When building the latest samples/bpf on LoongArch Fedora

     make M=samples/bpf

There are compilation errors as follows:

In file included from ./linux/samples/bpf/sockex2_kern.c:2:
In file included from ./include/uapi/linux/in.h:25:
In file included from ./include/linux/socket.h:8:
In file included from ./include/linux/uio.h:9:
In file included from ./include/linux/thread_info.h:60:
In file included from ./arch/loongarch/include/asm/thread_info.h:15:
In file included from ./arch/loongarch/include/asm/processor.h:13:
In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
./arch/loongarch/include/asm/loongarch.h:13:10: fatal error: 'larchintrin.h' file not found
         ^~~~~~~~~~~~~~~
1 error generated.

larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
and the header file location is specified at compile time.

Test on LoongArch Fedora:
https://github.com/fedora-remix-loongarch/releases-info

Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
Signed-off-by: zhangxi <zhangxi@kylinos.cn>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250425095042.838824-1-jianghaoran@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 5b632635e00dd..95a4fa1f1e447 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -376,7 +376,7 @@ $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
 	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
 		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
-		-I$(LIBBPF_INCLUDE) \
+		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.39.5


