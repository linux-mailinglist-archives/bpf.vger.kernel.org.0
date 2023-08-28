Return-Path: <bpf+bounces-8864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B878B740
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C41C2039E
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B2134C3;
	Mon, 28 Aug 2023 18:33:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF6125D5
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 18:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434E3C433C7;
	Mon, 28 Aug 2023 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693247615;
	bh=d9s+rleTXjh+026kI2xWsxmN3r2l1b03zx5KLcfxN1o=;
	h=From:To:Cc:Subject:Date:From;
	b=JLl7eKcVOYvqYwCZx8WuoW5qAEQxNojEVCj58HmPzmnbXaDXNc+9KIC3d1egAZf/i
	 G9wacsZ5VdVSc+x3ogaIsPtGMC7K8JoZI+5bVnrM/OCqUvHB6F6FRAWhHqJiEFT1df
	 QJHwXmkfyblzKeg8pPr6QuaCH+LOvdPMrsPmb4h/CeQTuT2U85a/pHoHhAwvSEBtCk
	 wt98pjgYRQDgVjMu7PfwZtqhiaOStwuDvZI2bRBBdHbp4cmZGHt619296TVT+D42g6
	 ta59kocFoNrWKE4qQObSKDMl7UTvD0aj4+VjNBpwojAluxPqOcmrCU2tJQSGZhZSms
	 FimAYEksbRE4Q==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Include build flavors for install target
Date: Mon, 28 Aug 2023 20:33:29 +0200
Message-Id: <20230828183329.546959-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

When using the "install" or targets depending on install,
e.g. "gen_tar", the BPF machine flavors weren't included.

A command like:
  | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- O=/workspace/kbuild \
  |    HOSTCC=gcc FORMAT= SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" \
  |    -C tools/testing/selftests gen_tar
would not include bpf/no_alu32, bpf/cpuv4, or bpf/bpf-gcc.

Include the BPF machine flavors for "install" make target.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edef49fcd23e..7c77a21c3371 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -598,12 +598,14 @@ $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
+INSTDIRS := no_alu32
 
 # Define test_progs-cpuv4 test runner.
 ifneq ($(CLANG_CPUV4),)
 TRUNNER_BPF_BUILD_RULE := CLANG_CPUV4_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
+INSTDIRS += cpuv4
 endif
 
 # Define test_progs BPF-GCC-flavored test runner.
@@ -611,6 +613,7 @@ ifneq ($(BPF_GCC),)
 TRUNNER_BPF_BUILD_RULE := GCC_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(call get_sys_includes,gcc,)
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,bpf_gcc))
+INSTDIRS += bpf_gcc
 endif
 
 # Define test_maps test runner.
@@ -714,3 +717,12 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
+
+DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
+override define INSTALL_RULE
+	$(DEFAULT_INSTALL_RULE)
+	@for DIR in $(INSTDIRS); do		  \
+		mkdir -p $(INSTALL_PATH)/$$DIR;   \
+		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
+	done
+endef

base-commit: 8be6f88b9d3fe1f6724daec4a70d6023742c9df7
-- 
2.39.2


