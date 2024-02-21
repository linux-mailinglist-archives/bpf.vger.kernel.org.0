Return-Path: <bpf+bounces-22389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7170685D1C8
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 08:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E271C248DF
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFFD3AC26;
	Wed, 21 Feb 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4qb/jrQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D43AC24
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501945; cv=none; b=eI9kMOXKF51rTZNGFYuUClKrjqP7zsE9nrTrtOHse/amwGYQFi+fuI1F6AIeLMq9J+3rlCP0fW0TRZwDz2T9qkZqr+HwoRx1fDSm1QZVT/pR2s7XxGH2kcIavh4inPbu11mcaBZymod0oMXSXv/ZkZy//64On33bcERkZKSobmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501945; c=relaxed/simple;
	bh=Dw4CJaNHKe+pg7XSzegbfn6FDwV+t1G1PwNSdjdIsdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KbFR2Eyti+4TIP2HSvrMO8z+yet+fo2udBj+3CFBonSOljFbhlJUTsBc3L7MvJLIYFKyUeo2lcNCM8S7m8+b7H0ZW16T0SUJPmHkCfDfo1a8QioAMEPVPdIyqdMlkQFmobbg9y3p0yeiQse0u4rAScFam5mEbZ4cDoK6tPQoIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4qb/jrQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607f94d0b7cso53340257b3.3
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 23:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708501942; x=1709106742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWynwO0I8208AcDlFWz1kBnWyZmLTlcYH9g+FM611g8=;
        b=Q4qb/jrQIXcmy5rxTGV4+N0SqlOb77JSesFRFNTjp4dxwOWeRWzKQ0mrnYwhdgvwLT
         Wp+ZHEeE5GCUrse7KNFE7obsPZjZk+CHuWxAvSJ5/AhspylLIUIr+BCGRrrVYKOYugDY
         F7H3ryop6GOH0phGffxZpp+mBg48SLgMaPxldlINi0H6gsPndNKuE9HrrVOrlE8h9KFM
         HVT1hY7t6f4Fe54ckIbAcAwVgts1qw5M5qTCPJ1h1pQ8RAiDfgBeAGVneFcH1Q9SKgbn
         JSH3wmdJch2pe6TIVBC5if86PVbb9JuGyZREH+0Ggv07XY+jskGHOt1d33azIjRMiVkH
         R9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708501942; x=1709106742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWynwO0I8208AcDlFWz1kBnWyZmLTlcYH9g+FM611g8=;
        b=KYSvBp70/hw80/Pvsk8X8Rk1b8Olu+VyfpGsOQ/VqFJdBkn78bci2y21aLvpA4fU3G
         8eHj7yv+MR4vBNVct8Ef5WG1aBGKrzfMGgGpjjkKaEkCT0KhrvGlyT2naXE7HVsSt7bL
         IE7+Uzio9dU0nytEw1P+UNeZqkef+LPpn+ickgMTVmQdjc/tBoKbcsTwwsvLS9+0/PE5
         IF3ANMBgKRf2sCRNG/lIn3bgpQxbB+sYYk7jf9cK9GvVIQmyZ01DUDXSerxK3VudU6Yb
         va/slALc863SZj0kK3CA0BkqTz28VhJf6HgKJHvUdbBJFR19vuF04CpsYDGKf7WyKU+O
         JdpQ==
X-Gm-Message-State: AOJu0YxU9ND4BVa60CNCIScefzTH85AFuiHn7WtzIgs1Ygw+uXzs4uj/
	PcP6V+3Czmgwj0iAnCw5AmSotLIGp1ZexGRFwzx7FKFUN/9bAvodGo39uMQy
X-Google-Smtp-Source: AGHT+IFEoD20cdseNyJB1Ku6rcJoEL+vP3FBn32iU/BPRyzxqWWAhMuiwMj3j3JMMdmNEkrdIadMOg==
X-Received: by 2002:a0d:f5c1:0:b0:608:2ad1:bac6 with SMTP id e184-20020a0df5c1000000b006082ad1bac6mr8318678ywf.27.1708501941697;
        Tue, 20 Feb 2024 23:52:21 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id m205-20020a8171d6000000b006048e2331fcsm2488715ywc.91.2024.02.20.23.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:52:21 -0800 (PST)
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
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Test case for lacking CFI stub functions.
Date: Tue, 20 Feb 2024 23:52:13 -0800
Message-Id: <20240221075213.2071454-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221075213.2071454-1-thinker.li@gmail.com>
References: <20240221075213.2071454-1-thinker.li@gmail.com>
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
 .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 38 ++++++++
 tools/testing/selftests/bpf/testing_helpers.c |  4 +-
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 6 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index dbb8c5f94f34..c219da5e60e6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -132,7 +132,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features
+	xdp_features bpf_test_no_cfi.ko
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -254,6 +254,12 @@ $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmo
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
@@ -628,6 +634,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
+		       $(OUTPUT)/bpf_test_no_cfi.ko			\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
@@ -756,6 +763,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
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
index 000000000000..19703e250549
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <testing_helpers.h>
+
+static void load_bpf_test_no_cfi(void)
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
+
+void test_struct_ops_no_cfi(void)
+{
+	if (test__start_subtest("load_bpf_test_no_cfi"))
+		load_bpf_test_no_cfi();
+}
+
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


