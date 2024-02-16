Return-Path: <bpf+bounces-22124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BC28573A4
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 03:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805511F237AE
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 02:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27945FC0B;
	Fri, 16 Feb 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk9UIQFc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02086F9DA
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049038; cv=none; b=W0i6wzlnhqgWZm/B00CG8zt4l4+pP5xTDdcyAdst9Lp52lA2zBTdtbc/UaA9JqL4ryHMKG4GnbmEWGd28DvK4y10JkWhNxznBPInJmUDpQgP3S8ehd1kG/XQpIAYTUIntj3OAr+OR9rXX9kjNrV6BBe5lN5WX8A6TiYs9TUYlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049038; c=relaxed/simple;
	bh=OJ00/q3G0P+TmTLGbwuldoALduGqwgYFLqS+KYbTzJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNXT/xeL2n/Ney4anExNoz+i+2RxxjJLmnCmvh1b4tIRNEQzqfqUYdUaRxk3rpdeJCuJt+4tuMIhTKhO3rxMdRSeZoVxV6lOOsia+HE+UjrGjhMTvi+RBNVZWaGgnhBMtbCwH5XEkJP1gKb+R6HZHKo957ZxliI8+Mn8xU7KmnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk9UIQFc; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607d633381fso2332187b3.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 18:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708049035; x=1708653835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSQbQ/uzRe0W0iNksWf5m0P0RBpXSeLT97OxFUfVACY=;
        b=Hk9UIQFcdqFcGUe08qNyF98DH4mPQhZlbnqnOVD8XzEgKMMwF7LE55yZ1EItTw8gAZ
         EFYMGzxn6BtzFovEVC9Asur+3O+sVU49qQHibPqZX1zfjr6jkbLpQR2XpbXY+bvrHgpw
         Ijxsfg/IrA4BH629FI92kTgH6lZazX16R1u1UsFIjzwNQiKT4wwTAv01l3yKx8Jou3RT
         grVF7MDi7sdfP13nAXeJ3tYx/oAvNRp5HXpxnb8NEsyTa7bV5K83F7jRUtO+GVPUKz9t
         5nfT8FhMBGUuJ6z5XdhRaMbjl/7Yo2LxgBegsm5RKP/FL95FC+rmzJqBZuudhi8ofLpR
         d6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708049035; x=1708653835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSQbQ/uzRe0W0iNksWf5m0P0RBpXSeLT97OxFUfVACY=;
        b=BCfLV/rzxl57WajUM7a6O9e+e9M3kbPH6kbDkr+ikMraTb3smtAgcAXAI3lgXFvwof
         l66/1rdC3xldTSj8pHs476VpRim5Quh4VX6JXhkW+VUhw0G72KY94agfytGnBEu/evOK
         spWnHRdA3hbK6bjVIPW+lFSrQ2cGZVYJ2eZJz4HpxdN997jCcnYuX0KzhYb2/i3TfXhe
         Fs2LNVjUzvn7uw+LyMFl8fksr4CW/xMKi67xhOtCUSl8NwVZ4lUM0mR1FRHx/VC9qw58
         H2sfXBaau5Dn/dTgDgI1HU5zhS7LvU6ehfhg17Gty6YPNicJUM1IUSEYKdlGgTRRbTOn
         VLXA==
X-Gm-Message-State: AOJu0YyeOpayLpNdMFKEnoywo+/1GyoOefGNw6GJhRWYFHJByiGgyda9
	hhGhWvN6uAPWqqz0mMKG3yaym1k7zNmiFCU0prYEQhHMPxj5Y+CumNw4C+5D
X-Google-Smtp-Source: AGHT+IGD6DddAWCNworSOeg59IoW96pKSqhcJw6Y04FTJSo8EDtF98jLBB0J1L42ebqGXsRZaZbrdA==
X-Received: by 2002:a25:aa84:0:b0:dc7:4b0a:589 with SMTP id t4-20020a25aa84000000b00dc74b0a0589mr3952699ybi.55.1708049035461;
        Thu, 15 Feb 2024 18:03:55 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ad0b:a28:ac5d:fc77])
        by smtp.gmail.com with ESMTPSA id d71-20020a25cd4a000000b00dcd2c2e7550sm133211ybf.21.2024.02.15.18.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 18:03:55 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test case for lacking CFI stub functions.
Date: Thu, 15 Feb 2024 18:03:50 -0800
Message-Id: <20240216020350.2061373-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216020350.2061373-1-thinker.li@gmail.com>
References: <20240216020350.2061373-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Ensure struct_ops rejects the registration of struct_ops types without
proper CFI stub functions.

bpf_test_no_cfi.ko is a module that attempts to register a struct_ops type
called "bpf_test_no_cfi_ops" with varying levels of cfi_stubs. It starts
with a NULL cfi_stub and ends with a fully complete cfi_stub. Only the
fully complete cfi_stub should be accepted by struct_ops. The module can
only be loaded successfully if these registrations yield the expected
results.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 10 +-
 .../selftests/bpf/bpf_test_no_cfi/Makefile    | 19 ++++
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     | 93 +++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 31 +++++++
 tools/testing/selftests/bpf/testing_helpers.c |  4 +-
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 6 files changed, 156 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a38a3001527c..2738d85680ac 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -132,7 +132,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features
+	xdp_features bpf_test_no_cfi.ko
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -255,6 +255,12 @@ $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmo
 	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_testmod
 	$(Q)cp bpf_testmod/bpf_testmod.ko $@
 
+$(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_no_cfi/Makefile bpf_test_no_cfi/*.[ch])
+	$(call msg,MOD,,$@)
+	$(Q)$(RM) bpf_test_no_cfi/bpf_test_no_cfi.ko # force re-compilation
+	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_no_cfi
+	$(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
+
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 ifneq ($(CROSS_COMPILE),)
 CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
@@ -629,6 +635,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
+		       $(OUTPUT)/bpf_test_no_cfi.ko			\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
@@ -757,6 +764,7 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	feature bpftool							\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h	\
 			       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko	\
+			       bpf_test_no_cfi.ko			\
 			       liburandom_read.so)
 
 .PHONY: docs docs-clean
diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile b/tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
new file mode 100644
index 000000000000..ed5143b79edf
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
@@ -0,0 +1,19 @@
+BPF_TEST_NO_CFI_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(BPF_TEST_NO_CFI_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = bpf_test_no_cfi.ko
+
+obj-m += bpf_test_no_cfi.o
+
+all:
+	+$(Q)make -C $(KDIR) M=$(BPF_TEST_NO_CFI_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(BPF_TEST_NO_CFI_DIR) clean
+
diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
new file mode 100644
index 000000000000..0fb63feecb31
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+struct bpf_test_no_cfi_ops {
+	void (*fn_1)(void);
+	void (*fn_2)(void);
+};
+
+static int dummy_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int dummy_init_member(const struct btf_type *t,
+			     const struct btf_member *member,
+			     void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static int dummy_reg(void *kdata)
+{
+	return 0;
+}
+
+static void dummy_unreg(void *kdata)
+{
+}
+
+static const struct bpf_verifier_ops dummy_verifier_ops;
+
+static void bpf_test_no_cfi_ops__fn_1(void)
+{
+}
+
+static void bpf_test_no_cfi_ops__fn_2(void)
+{
+}
+
+static struct bpf_test_no_cfi_ops __bpf_test_no_cfi_ops;
+
+static struct bpf_struct_ops bpf_bpf_test_no_cif_ops = {
+	.verifier_ops = &dummy_verifier_ops,
+	.init = dummy_init,
+	.init_member = dummy_init_member,
+	.reg = dummy_reg,
+	.unreg = dummy_unreg,
+	.name = "bpf_test_no_cfi_ops",
+	.owner = THIS_MODULE,
+};
+
+static int bpf_test_no_cfi_init(void)
+{
+	int ret;
+
+	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
+				      bpf_test_no_cfi_ops);
+	if (!ret)
+		return -EINVAL;
+
+	bpf_bpf_test_no_cif_ops.cfi_stubs = &__bpf_test_no_cfi_ops;
+	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
+				      bpf_test_no_cfi_ops);
+	if (!ret)
+		return -EINVAL;
+
+	__bpf_test_no_cfi_ops.fn_1 = bpf_test_no_cfi_ops__fn_1;
+	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
+				      bpf_test_no_cfi_ops);
+	if (!ret)
+		return -EINVAL;
+
+	__bpf_test_no_cfi_ops.fn_2 = bpf_test_no_cfi_ops__fn_2;
+	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
+				      bpf_test_no_cfi_ops);
+	return ret;
+}
+
+static void bpf_test_no_cfi_exit(void)
+{
+}
+
+module_init(bpf_test_no_cfi_init);
+module_exit(bpf_test_no_cfi_exit);
+
+MODULE_AUTHOR("Kuifeng Lee");
+MODULE_DESCRIPTION("BPF no cfi_stubs test module");
+MODULE_LICENSE("Dual BSD/GPL");
+
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
new file mode 100644
index 000000000000..11fbd9ebf1f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <testing_helpers.h>
+
+void test_struct_ops_no_cfi(void)
+{
+	int fd;
+	int err;
+
+	fd = open("bpf_test_no_cfi.ko", O_RDONLY);
+	if (!ASSERT_GT(fd, 0, "open")) {
+		close(fd);
+		return;
+	}
+
+	/* The module will try to register a struct_ops type with
+	 * no cfi_stubs, incomplete cfi_stubs, and full cfi_stubs.
+	 *
+	 * Only full cfi_stubs should be allowed. The module will be loaded
+	 * successfully if the result of the registration is as expected,
+	 * or it fails.
+	 */
+	err = finit_module(fd, "", 0);
+	close(fd);
+	if (!ASSERT_OK(err, "finit_module"))
+		return;
+
+	err = delete_module("bpf_test_no_cfi", 0);
+	ASSERT_OK(err, "delete_module");
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index a59e56d804ee..28b6646662af 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -356,12 +356,12 @@ __u64 read_perf_max_sample_freq(void)
 	return sample_freq;
 }
 
-static int finit_module(int fd, const char *param_values, int flags)
+int finit_module(int fd, const char *param_values, int flags)
 {
 	return syscall(__NR_finit_module, fd, param_values, flags);
 }
 
-static int delete_module(const char *name, int flags)
+int delete_module(const char *name, int flags)
 {
 	return syscall(__NR_delete_module, name, flags);
 }
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d14de81727e6..d55f6ab12433 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -36,6 +36,8 @@ __u64 read_perf_max_sample_freq(void);
 int load_bpf_testmod(bool verbose);
 int unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
+int finit_module(int fd, const char *param_values, int flags);
+int delete_module(const char *name, int flags);
 
 static inline __u64 get_time_ns(void)
 {
-- 
2.34.1


