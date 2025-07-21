Return-Path: <bpf+bounces-63956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E3B0CC76
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E453D1AA6249
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9724167D;
	Mon, 21 Jul 2025 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM3tJomE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030223FC74;
	Mon, 21 Jul 2025 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132832; cv=none; b=rXaXZ6nKHKFW+Oa8wW5r4XZKJutEwSk2ThGa8PT2DOLRlkt0vrraBgui4Hlb6sLpsebUTw0qsaDgmTmInQ8p8jDWqaRLEl697bjRxdSN94gGKXBmwlGJaL+lEQHCAIrXnQls4UbhNUB9DDcIYUbbkWUdMqGhkARO6Os8wrj+wGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132832; c=relaxed/simple;
	bh=v2IGH6ggacHLY/Tc2IyDw81uK04nWzv1/mb0SN7RxSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj1ZtFW8SZTrbWqpfXG+WguOmolTurM4qcqNjmugA31fvHQW0iKhVdkt5BD7PByV3gEFpXzufAb6ObzEn/PfX++veu0g54RLrbodfJGdKqTfW4luMjchAH1jaEUUBojqG6gCuS4kkGqcnxmgOS4e4QeGqNPPi6n4O/zcluRgH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM3tJomE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE9EC4CEF8;
	Mon, 21 Jul 2025 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132832;
	bh=v2IGH6ggacHLY/Tc2IyDw81uK04nWzv1/mb0SN7RxSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bM3tJomEyvLeNg5kNo1alviSP25tW6qQFUIPjPSLrrd4TzbJddZwYeuA0abvWc9AU
	 2KzBHcbeeLhQYN98haF6Yy2XkYpaTYELxTxlXjUQAG2rfGmlouhzpDlj4xlnDlBnUK
	 znBcFhy2PGj1posmriHPvZ9kXjj6yG/e5tNVHheggGlFTl8JDs0ThnCfPrYIu5cbPv
	 frnGl2udRjIpILPlEJJn0z6NfPn+A2+ZpNpZXdj7EXf97g0ZAsVBS7rJoOgrIlCQ30
	 OXr2kXal9Re6bINdXNG4n10H7ZfFdpCFGeVl7Gh902doPFmW6qzL2nTWOZ0/g2ZMOZ
	 h9JUd4gnssfsw==
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
Subject: [PATCH v2 12/13] selftests/bpf: Enable signature verification for all lskel tests
Date: Mon, 21 Jul 2025 23:19:57 +0200
Message-ID: <20250721211958.1881379-13-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721211958.1881379-1-kpsingh@kernel.org>
References: <20250721211958.1881379-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the kernel's generated verification certificate into a C header
file using xxd. Finally, update the main test runner to load this
certificate into the session keyring via the add_key() syscall before
executing any tests.

The test harness uses the verify_sig_setup.sh to generate the required
key material for program signing.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          | 19 +++++++++++++++++--
 tools/testing/selftests/bpf/test_progs.c      | 13 +++++++++++++
 .../testing/selftests/bpf/verify_sig_setup.sh | 13 +++++++++++--
 4 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 3d8378972d26..be1ee7ba7ce0 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -44,3 +44,4 @@ xdp_redirect_multi
 xdp_synproxy
 xdp_hw_metadata
 xdp_features
+verification_cert.h
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4863106034df..1295ff8f26ff 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -535,6 +535,7 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
 # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER
 
+LSKEL_SIGN := -S -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
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
@@ -667,6 +668,7 @@ $(foreach N,$(patsubst $(TRUNNER_OUTPUT)/%.o,%,$(TRUNNER_EXTRA_OBJS)),	\
 $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 		       %.c						\
 		       $(TRUNNER_EXTRA_HDRS)				\
+		       $(VERIFY_SIG_HDR)				\
 		       $(TRUNNER_TESTS_HDR)				\
 		       $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
@@ -697,6 +699,18 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 
 endef
 
+VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
+VERIFY_SIG_HDR := verification_cert.h
+VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
+PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
+
+$(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
+	$(Q)mkdir -p $(BUILD_DIR)
+	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
+
+$(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
+	$(Q)xxd -i -n test_progs_verification_cert $< > $@
+
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
@@ -716,6 +730,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 disasm.c		\
 			 disasm_helpers.c	\
 			 json_writer.c 		\
+			 $(VERIFY_SIG_HDR)		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
@@ -725,7 +740,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/uprobe_multi				\
 		       $(TEST_KMOD_TARGETS)				\
 		       ima_setup.sh 					\
-		       verify_sig_setup.sh				\
+		       $(VERIFY_SIG_SETUP)				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
 		       $(wildcard progs/*.bpf.o)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
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
 
diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
index f2cac42298ba..0834f504f66d 100755
--- a/tools/testing/selftests/bpf/verify_sig_setup.sh
+++ b/tools/testing/selftests/bpf/verify_sig_setup.sh
@@ -32,7 +32,7 @@ usage()
 	exit 1
 }
 
-setup()
+genkey()
 {
 	local tmp_dir="$1"
 
@@ -46,8 +46,15 @@ setup()
 	openssl x509 -in ${tmp_dir}/signing_key.pem -out \
 		${tmp_dir}/signing_key.der -outform der
 
-	key_id=$(cat ${tmp_dir}/signing_key.der | keyctl padd asymmetric ebpf_testing_key @s)
+}
 
+setup()
+{
+	local tmp_dir="$1"
+
+	genkey "${tmp_dir}"
+
+	key_id=$(cat ${tmp_dir}/signing_key.der | keyctl padd asymmetric ebpf_testing_key @s)
 	keyring_id=$(keyctl newring ebpf_testing_keyring @s)
 	keyctl link $key_id $keyring_id
 }
@@ -105,6 +112,8 @@ main()
 
 	if [[ "${action}" == "setup" ]]; then
 		setup "${tmp_dir}"
+	elif [[ "${action}" == "genkey" ]]; then
+		genkey "${tmp_dir}"
 	elif [[ "${action}" == "cleanup" ]]; then
 		cleanup "${tmp_dir}"
 	elif [[ "${action}" == "fsverity-create-sign" ]]; then
-- 
2.43.0


