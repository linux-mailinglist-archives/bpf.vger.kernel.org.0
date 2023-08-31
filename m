Return-Path: <bpf+bounces-9085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9B78F14B
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBF528166C
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477714A94;
	Thu, 31 Aug 2023 16:30:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9715ACD;
	Thu, 31 Aug 2023 16:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAF8C433C8;
	Thu, 31 Aug 2023 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693499405;
	bh=Yc26o0/FY2D6dfkAPvN4YeN+YrHn6pS0APrtvKi+iJY=;
	h=From:To:Cc:Subject:Date:From;
	b=GDhWBuBscGEAJYnkRo1z17fL4qXj3Yg/oY523IeIFbdDGS+aOE2gzrrL5vKEw2t7a
	 2JPJZJQ0Ey7q4Bjd+OUgo3fTtwN0YDKNCG2crMzIHElbdJ0uHNEzzehmA+FPcXAjKr
	 bzH2OBA5Zh6EV02Q4JRxlNDGArUuF+8EwCyGtGs+C8mtZN5nveKGJchpB+dUZMyWZw
	 jAqvyPIlDAyUmoZOAvGIlfEx0wrDUHUpMKMpjkJ4zX6cS/V2nxS4PWcUXUSrfYTljF
	 key1DDeceUlJgqrZjxK53E2mkqC3ajlvf1oHphVJCLbgJkQIMN+I3vOfI2jzwNn7BW
	 5MzAOJwqMkC3g==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] selftests/bpf: Include build flavors for install target
Date: Thu, 31 Aug 2023 18:29:54 +0200
Message-Id: <20230831162954.111485-1-bjorn@kernel.org>
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
  v1->v2: Rename the subdir variable, and define/populate it at more
  clear locations. (Daniel)
---
 tools/testing/selftests/bpf/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edef49fcd23e..caede9b574cb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -50,14 +50,17 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
 	test_progs-no_alu32
+TEST_INST_SUBDIRS := no_alu32
 
 # Also test bpf-gcc, if present
 ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
+TEST_INST_SUBDIRS += bpf_gcc
 endif
 
 ifneq ($(CLANG_CPUV4),)
 TEST_GEN_PROGS += test_progs-cpuv4
+TEST_INST_SUBDIRS += cpuv4
 endif
 
 TEST_GEN_FILES = test_lwt_ip_encap.bpf.o test_tc_edt.bpf.o
@@ -714,3 +717,12 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
+
+DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
+override define INSTALL_RULE
+	$(DEFAULT_INSTALL_RULE)
+	@for DIR in $(TEST_INST_SUBDIRS); do		  \
+		mkdir -p $(INSTALL_PATH)/$$DIR;   \
+		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
+	done
+endef

base-commit: d11ae1b16b0a57fac524cad8e277a20ec62600d1
-- 
2.39.2


