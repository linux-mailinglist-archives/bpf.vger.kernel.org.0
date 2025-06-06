Return-Path: <bpf+bounces-59976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD86AD0A51
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5196F3B20FA
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59C23FC5F;
	Fri,  6 Jun 2025 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzRWirsS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E11F4C94;
	Fri,  6 Jun 2025 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252587; cv=none; b=aLYUE4PYH82iGe7DFsmQ9nTzxfw8RqDfH0TmKa6k8lBrXrdYwo8cjvP8wwYyJlVXjNYe/RtN171nrSPUI2CFUT+tY6OnArLuJrLCQHFueFJnm6X+ldEGTG8enNzIn36AJsZc+BKV9MMQSGe15ByEBAxUFTWcmnoCMedIbzhjydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252587; c=relaxed/simple;
	bh=8ctlzKseucpE7aGXDNMTlsA5aXRSrdbgZ77QeTtQd84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecbPe4C7VEXZunyFz4kga2RhQw+sZQdtQJx3Ko/0oCQJAMbspXf+EpeM4C7Nctjw6iAAIWjjLXHCuviQaiED9yRHA1xa8cXczKlfDfXzjnKadEV5FZ/S4jJtBFZIwnIDqfHoxDHQaHb+DAUXUTMeIJxblxhZj5WmhvTvcIfqa1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzRWirsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AF6C4CEEF;
	Fri,  6 Jun 2025 23:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252587;
	bh=8ctlzKseucpE7aGXDNMTlsA5aXRSrdbgZ77QeTtQd84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzRWirsSgY2/TMCcyrbgODFjccmpba9+ygpm1pvKBepBEKLWrgeMcARFp0IPRWRn0
	 KoiqYRhW7Xjz7ohX0gC1IezCok1iggLyKHtvPeYrtGp/mlrlCYeZ8lyO8XVsp5c+8A
	 ECKIFIUJYUWp1g7yPWufxJDyMMkSqyvTmVCRM84CG254ILNbmG6+P8Ws4Qa9enA4AV
	 DM//189NphZxHelBTBoDxb6vySEvbiLn/g3vKzX5Nowuqk2LZNWKzh55O3HoZUCfbk
	 1kgxiCoiraHBEjJOT+dyZpyF2p2K31DKlLxISwYC+JXVmvZqMAisXJux3VEr3GUgY+
	 X2ukg674LmLQg==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH 12/12] selftests/bpf: Enable signature verification for all lskel tests
Date: Sat,  7 Jun 2025 01:29:14 +0200
Message-ID: <20250606232914.317094-13-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606232914.317094-1-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the kernel's generated verification certificate into a C header
file using xxd.  Finally, update the main test runner to load this
certificate into the session keyring via the add_key() syscall before
executing any tests.

The kernel's module signing verification certificate is converted to a
headerfile and loaded as a session key and all light skeleton tests are
updated to be signed.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore   |  1 +
 tools/testing/selftests/bpf/Makefile     | 13 +++++++++++--
 tools/testing/selftests/bpf/test_progs.c | 13 +++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index e2a2c46c008b..5ab96f8ab1c9 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -45,3 +45,4 @@ xdp_redirect_multi
 xdp_synproxy
 xdp_hw_metadata
 xdp_features
+verification_cert.h
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cf5ed3bee573..778b54be7ef4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -7,6 +7,7 @@ CXX ?= $(CROSS_COMPILE)g++
 
 CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
+CERTSDIR := $(abspath ../../../../certs)
 LIBDIR := $(TOOLSDIR)/lib
 BPFDIR := $(LIBDIR)/bpf
 TOOLSINCDIR := $(TOOLSDIR)/include
@@ -534,7 +535,7 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
 # $1 - test runner base binary name (e.g., test_progs)
 # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER
-
+LSKEL_SIGN := -S -k $(CERTSDIR)/signing_key.pem -i $(CERTSDIR)/signing_key.x509
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
 TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
@@ -601,7 +602,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
 	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
-	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
+	$(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
 	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
 $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
@@ -697,6 +698,13 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 
 endef
 
+CERT_HEADER := verification_cert.h
+CERT_SOURCE := $(CERTSDIR)/signing_key.x509
+
+$(CERT_HEADER): $(CERT_SOURCE)
+	@echo "GEN-CERT-HEADER: $(CERT_HEADER) from $<"
+	$(Q)xxd -i -n test_progs_verification_cert $< > $@
+
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
@@ -716,6 +724,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 disasm.c		\
 			 disasm_helpers.c	\
 			 json_writer.c 		\
+			 $(CERT_HEADER)		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 309d9d4a8ace..02a85dda30e6 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -14,12 +14,14 @@
 #include <netinet/in.h>
 #include <sys/select.h>
 #include <sys/socket.h>
+#include <linux/keyctl.h>
 #include <sys/un.h>
 #include <bpf/btf.h>
 #include <time.h>
 #include "json_writer.h"
 
 #include "network_helpers.h"
+#include "verification_cert.h"
 
 /* backtrace() and backtrace_symbols_fd() are glibc specific,
  * use header file when glibc is available and provide stub
@@ -1928,6 +1930,13 @@ static void free_test_states(void)
 	}
 }
 
+static __u32 register_session_key(const char *key_data, size_t key_data_size)
+{
+	return syscall(__NR_add_key, "asymmetric", "libbpf_session_key",
+			(const void *)key_data, key_data_size,
+			KEY_SPEC_SESSION_KEYRING);
+}
+
 int main(int argc, char **argv)
 {
 	static const struct argp argp = {
@@ -1961,6 +1970,10 @@ int main(int argc, char **argv)
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 	libbpf_set_print(libbpf_print_fn);
+	err = register_session_key((const char *)test_progs_verification_cert,
+				   test_progs_verification_cert_len);
+	if (err < 0)
+		return err;
 
 	traffic_monitor_set_print(traffic_monitor_print_fn);
 
-- 
2.43.0


