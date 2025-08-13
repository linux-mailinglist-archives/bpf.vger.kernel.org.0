Return-Path: <bpf+bounces-65557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8979B254D7
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A916B7B7BFE
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBC2ECD37;
	Wed, 13 Aug 2025 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDNhfX28"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48822F998C;
	Wed, 13 Aug 2025 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118559; cv=none; b=uAOnk+ybK3tyzmBqF0B7tjIDwlILRYHi/5zEqYfBmzEdfPzS7s2UoVxobBs9Z5+e0YBE6/0pCIrJVRdIi/F7Ys3HMsuxaTBO5txspyrAz1CQhzGW1VsndR0RKTTvZf9HsnDspW4yZcgvTyiPVtKvQjIDqilrpz5U82z/3DZn8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118559; c=relaxed/simple;
	bh=cDDbaUuqmeovPCASl5dvkY+bbA72/NFYrCc/cCS0UMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVDDfYYCyolbK14tw5omh8lp/InsupV/Q/3x8TIs4rTcoZQn2nimOdF44VYt9RLVnp6HUGMmtBEllb+pi/Kr//XbNIUeXm1USctIBnXEeMYjVuwFED9e+7m9TJola4DcBnezwYakO2deeDjTgDEY3enul/gy6yTYRweVwgWqCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDNhfX28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FCAC4CEF5;
	Wed, 13 Aug 2025 20:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755118559;
	bh=cDDbaUuqmeovPCASl5dvkY+bbA72/NFYrCc/cCS0UMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XDNhfX28a+eq63KLKQd+yPSvkxzmVwJFV6TO/Cj19Sj19gmYnzDjUgFK2dRjshb1Y
	 7pljwD+5WIlFjO9bgYnYoC5/Wh+Eyn/+qrsFBPJuYYbUYhC4Z4EJPQb49Kq/c/kVCr
	 NyWHfhgWxwIUCnPcwJf+F9v4PH4gr0Ez88gULlpp7RbwsC8wGEXDfz+mrvRS4qxI3J
	 VMNSfJNB0PhFZIBRFM8mvRcxXQ8k1N54/PL7USvKDeRikBEsICRmRoqHq2APNZc5Ud
	 liU4qP2faU4vHb9zl0KpLhKa7gKwH8T278cVXP4Bjl4Wicfsx3RNbTqtndggy30Wsr
	 Pmy5fQSuYauHQ==
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
Subject: [PATCH v3 12/12] selftests/bpf: Enable signature verification for some lskel tests
Date: Wed, 13 Aug 2025 22:55:26 +0200
Message-ID: <20250813205526.2992911-13-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813205526.2992911-1-kpsingh@kernel.org>
References: <20250813205526.2992911-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test harness uses the verify_sig_setup.sh to generate the required
key material for program signing.

Generate key material for signing LSKEL some lskel programs and use
xxd to convert the verification certificate into a C header file.

Finally, update the main test runner to load this
certificate into the session keyring via the add_key() syscall before
executing any tests.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          | 35 ++++++++++++++++---
 tools/testing/selftests/bpf/test_progs.c      | 13 +++++++
 .../testing/selftests/bpf/verify_sig_setup.sh | 13 +++++--
 4 files changed, 56 insertions(+), 6 deletions(-)

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
index 4863106034df..e473e2d780fb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -496,15 +496,16 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h
 
-LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
-	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
+LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
 
+LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
+
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
 	kfunc_call_test_subprog.c
-SKEL_BLACKLIST += $$(LSKELS)
+SKEL_BLACKLIST += $$(LSKELS) $$(LSKELS_SIGNED)
 
 test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
 linked_funcs.skel.h-deps := linked_funcs1.bpf.o linked_funcs2.bpf.o
@@ -535,6 +536,7 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
 # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER
 
+LSKEL_SIGN := -S -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
 TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
@@ -550,6 +552,7 @@ TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
 					       $$(TRUNNER_BPF_SRCS)))
 TRUNNER_BPF_LSKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS) $$(LSKELS_EXTRA))
 TRUNNER_BPF_SKELS_LINKED := $$(addprefix $$(TRUNNER_OUTPUT)/,$(LINKED_SKELS))
+TRUNNER_BPF_LSKELS_SIGNED := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS_SIGNED))
 TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
 
 # Evaluate rules now with extra TRUNNER_XXX variables above already defined
@@ -604,6 +607,15 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
 	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
+$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY) (signed),$$@)
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
+	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+	$(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
+	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+
 $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
 
 # .SECONDEXPANSION here allows to correctly expand %-deps variables as prerequisites
@@ -653,6 +665,7 @@ $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_EXTRA_HDRS)			\
 			    $(TRUNNER_BPF_SKELS)			\
 			    $(TRUNNER_BPF_LSKELS)			\
+			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
 			    $(TRUNNER_BPF_SKELS_LINKED)			\
 			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 
@@ -667,6 +680,7 @@ $(foreach N,$(patsubst $(TRUNNER_OUTPUT)/%.o,%,$(TRUNNER_EXTRA_OBJS)),	\
 $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 		       %.c						\
 		       $(TRUNNER_EXTRA_HDRS)				\
+		       $(VERIFY_SIG_HDR)				\
 		       $(TRUNNER_TESTS_HDR)				\
 		       $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
@@ -697,6 +711,18 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 
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
@@ -716,6 +742,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 disasm.c		\
 			 disasm_helpers.c	\
 			 json_writer.c 		\
+			 $(VERIFY_SIG_HDR)		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
@@ -725,7 +752,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
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


