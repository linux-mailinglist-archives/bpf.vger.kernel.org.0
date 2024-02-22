Return-Path: <bpf+bounces-22483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7296F85EF03
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 03:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B8D28364D
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 02:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53091428F;
	Thu, 22 Feb 2024 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXLcieXF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774614291
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567874; cv=none; b=RpwWt7EkEq6wakkwTHtaaD41D4zkc6Gbius+m3Sb4+V8UO9kdFz5YQed+PZaXg+yl6wNEXp4rHS+HGHSsbN7FXVFIM/wuPArzOeDF7cyl6dFx9sgZ9vlxTjVSavOGk/gvJtK8JkdM7HNPH07wwHwFsGkhaNNngaLIai8yEZR1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567874; c=relaxed/simple;
	bh=MLIA/ZknjVeX3ercA5IQIixqqOuyMFpfn4y/jpqrx7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2yThqz5BDMvvmTe4eDtfyxn2BYiTduUMooS8n3rYd4pbIp69KfWXEbHezIBzk0dLcoFnZtHyNvJg8iZKYnXh5eHLyvmG2S9Bea3QBe1/1ddFNVAuBm8ayIBDQpouvHkTsz1ppVCxIzlOrDDAjf7aJ89IUImZ/VvqtTUz48eGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXLcieXF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db3a09e96daso6480831276.3
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 18:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708567871; x=1709172671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmP7/E4qUyfUubTrSrh+cg/xb5ozRzks1/kEWD/CJZ8=;
        b=MXLcieXFmQpOjqUxxBMuDbkEkB5l0HyqxgQ1oVf40yo6wekYfHWKJl6Opv4KL5lSo9
         d69L0TRGDee2zjUOJMjHWPY4wgzPMO84AGeX0N1iZXInp4ROgLFY/p41rAKR2oi8wltA
         RHki15qWtaU0gJ2ESQXvp625WbTMCU5XpVUvw2hRQgDBgIexDReDPKUVIJ4N5c/tdMST
         ThtEN9kipicQ4aoUOiUDYBSxfgpe3GZI3936p9EWFzl8skoFqrb3nBd562GG+MZOMu16
         tarzlOKH2T8FLSFIuc/1C9ceBY8jVenQwDXXdmhQyX9y0njLTB0fKqn+rv5QLfAey9gI
         /+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708567871; x=1709172671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmP7/E4qUyfUubTrSrh+cg/xb5ozRzks1/kEWD/CJZ8=;
        b=Vy+xdsV5Z/N29Cta57Ny9ocqyFSporIjkpRG2VXV//sJacrhKNkVhTrfywHIZ44LU0
         HXM8Y6x8l3YqK+qpc1xm6O0jYDoJWewvR7Ix/mlg3Z+PbLveHOAAS+iw3feFyqmwgTRF
         tPgt47t+/Wy6cNIeh6c4TouMhZs4XT81fvbWueIIVM+VCbBA+H3Y3OoNO8cU63iIcz5x
         u7QDCR9zvL5Hp1ic5QsEV+YG9MIA6JxfPPGLrbXViI1itTs5PpTrUm9LAhVErXueohGi
         JPFo8BHtxvamHtgWUejQcucsCkph5bsbcuwvMnmhdZ81ZJqMWr0JsPq0P1hernA8k+AY
         0Vmw==
X-Gm-Message-State: AOJu0Yyk18vnLcbEZCTE/J3FraPjaDleeM7yURMlTFacYHI0dtnpAdP9
	8GSrOsmUS9RQF3fTEVpuHF4wccDknWyf343iHDUk8cyh6SIbPbZrXzS+de2B
X-Google-Smtp-Source: AGHT+IGENjNcDK8fzO2iuR9qiiqI1nRUe/QOeoIwmg5FP57qe/qqQ9enxOxhM2a2QTOIzPKFUJPBqA==
X-Received: by 2002:a25:bed0:0:b0:dcd:2f2d:7a04 with SMTP id k16-20020a25bed0000000b00dcd2f2d7a04mr1117664ybm.10.1708567870819;
        Wed, 21 Feb 2024 18:11:10 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id t34-20020a25f622000000b00dc73705ec59sm2613590ybd.0.2024.02.21.18.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:11:10 -0800 (PST)
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Test case for lacking CFI stub functions.
Date: Wed, 21 Feb 2024 18:11:05 -0800
Message-Id: <20240222021105.1180475-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222021105.1180475-1-thinker.li@gmail.com>
References: <20240222021105.1180475-1-thinker.li@gmail.com>
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
called "bpf_test_no_cfi_ops" with cif_stubs of NULL and non-NULL value.
The NULL one should fail, and the non-NULL one should success. The module
can only be loaded successfully if these registrations yield the expected
results.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 10 ++-
 .../selftests/bpf/bpf_test_no_cfi/Makefile    | 19 +++++
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     | 84 +++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 38 +++++++++
 tools/testing/selftests/bpf/testing_helpers.c |  4 +-
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 6 files changed, 154 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9be69ff701ba..84cb5500e8ef 100644
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
@@ -631,6 +637,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
+		       $(OUTPUT)/bpf_test_no_cfi.ko			\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
@@ -759,6 +766,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
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
index 000000000000..7a2c8c99987f
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
@@ -0,0 +1,84 @@
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
+static struct bpf_test_no_cfi_ops __bpf_test_no_cfi_ops = {
+	.fn_1 = bpf_test_no_cfi_ops__fn_1,
+	.fn_2 = bpf_test_no_cfi_ops__fn_2,
+};
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
index 000000000000..f16d4dcccacf
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
+	/* The module will try to register a struct_ops type without
+	 *  cfi_stubs and with cfi_stubs.
+	 *
+	 * The one without cfi_stub should fail. The module will be loaded
+	 * successfully only if the result of the registration is as
+	 * expected, or it fails.
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


