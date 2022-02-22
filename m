Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817724C0541
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 00:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiBVXSm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 18:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiBVXSc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 18:18:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0369D91350;
        Tue, 22 Feb 2022 15:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645571884; x=1677107884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZmqwJd98e/tHrMZYdUSv1VTrR7CudfjRu1cxgafDIxA=;
  b=C1CcwEJvTe1Ht6gbsNqH5zKTry43tPDrSOeo4D/kKxGfkSICpEIeQ5tq
   5WPzWloJDS8WpFW9pH3II3rudhxUibgvLP5d3q0XS6DP0nuqAIOeOUGjC
   UACbkD67hxPzjIYpba0gPl7oZgfYV+yY8fvsXTSnxO2903t0zlNJIZFpm
   75JoYFwfTBFrD4KJvMASeL0diTOaMbdEMdTp5KUTWCjtYWGLCguJeoVVm
   6CIMn7QoETKF3Jvimzm7ia5+ZTUpOfkvsYcUQx7SRUbZCRDNPEUAiw/TN
   BHtd6nc3LgedQxD/YvJUkLuk1i/Ta3oGsApThDOPXGPnVEi4XRdbBGTfn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231810102"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="231810102"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 15:18:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="776476652"
Received: from skoppolu-mobl4.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.252.138.103])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 15:18:03 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v1 6/6] tools/tdx: Add a sample attestation user app
Date:   Tue, 22 Feb 2022 15:17:35 -0800
Message-Id: <20220222231735.268919-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222231735.268919-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220222231735.268919-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This application uses the misc device /dev/tdx-attest to get TDREPORT
from the TDX Module or request quote from the VMM.

It tests following attestation features:

  - Get report using TDX_CMD_GET_TDREPORT IOCTL.
  - Using report data request quote from VMM using TDX_CMD_GEN_QUOTE IOCTL.
  - Get the quote size using TDX_CMD_GET_QUOTE_SIZE IOCTL.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 tools/Makefile                     |  13 +-
 tools/tdx/Makefile                 |  19 +++
 tools/tdx/attest/.gitignore        |   2 +
 tools/tdx/attest/Makefile          |  24 +++
 tools/tdx/attest/tdx-attest-test.c | 240 +++++++++++++++++++++++++++++
 5 files changed, 292 insertions(+), 6 deletions(-)
 create mode 100644 tools/tdx/Makefile
 create mode 100644 tools/tdx/attest/.gitignore
 create mode 100644 tools/tdx/attest/Makefile
 create mode 100644 tools/tdx/attest/tdx-attest-test.c

diff --git a/tools/Makefile b/tools/Makefile
index db2f7b8ebed5..e40783b7726d 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -30,6 +30,7 @@ help:
 	@echo '  selftests              - various kernel selftests'
 	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
+	@echo '  tdx                    - TDX related test tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  tracing                - misc tracing tools'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
@@ -65,7 +66,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup counter firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
+cgroup counter firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing tdx: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -101,7 +102,7 @@ all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing
+		pci debugging tracing tdx
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -109,7 +110,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
+cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install tdx_install:
 	$(call descend,$(@:_install=),install)
 
 selftests_install:
@@ -133,7 +134,7 @@ install: acpi_install cgroup_install counter_install cpupower_install gpio_insta
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
-		tracing_install
+		tracing_install tdx_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -141,7 +142,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
+cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean tdx_clean:
 	$(call descend,$(@:_clean=),clean)
 
 libapi_clean:
@@ -177,6 +178,6 @@ clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_cl
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
-		intel-speed-select_clean tracing_clean
+		intel-speed-select_clean tracing_clean tdx_clean
 
 .PHONY: FORCE
diff --git a/tools/tdx/Makefile b/tools/tdx/Makefile
new file mode 100644
index 000000000000..e2564557d463
--- /dev/null
+++ b/tools/tdx/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../scripts/Makefile.include
+
+all: attest
+
+clean: attest_clean
+
+install: attest_install
+
+attest:
+	$(call descend,attest)
+
+attest_install:
+	$(call descend,attest,install)
+
+attest_clean:
+	$(call descend,attest,clean)
+
+.PHONY: all install clean attest latency_install latency_clean
diff --git a/tools/tdx/attest/.gitignore b/tools/tdx/attest/.gitignore
new file mode 100644
index 000000000000..5f819a8a6c49
--- /dev/null
+++ b/tools/tdx/attest/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+tdx-attest-test
diff --git a/tools/tdx/attest/Makefile b/tools/tdx/attest/Makefile
new file mode 100644
index 000000000000..bf47ba718386
--- /dev/null
+++ b/tools/tdx/attest/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for vm tools
+#
+VAR_CFLAGS := $(shell pkg-config --cflags libtracefs 2>/dev/null)
+VAR_LDLIBS := $(shell pkg-config --libs libtracefs 2>/dev/null)
+
+TARGETS = tdx-attest-test
+CFLAGS = -static -Wall -Wextra -g -O2 $(VAR_CFLAGS)
+LDFLAGS = -lpthread $(VAR_LDLIBS)
+
+all: $(TARGETS)
+
+%: %.c
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+
+clean:
+	$(RM) tdx-attest-test
+
+prefix ?= /usr/local
+sbindir ?= ${prefix}/sbin
+
+install: all
+	install -d $(DESTDIR)$(sbindir)
+	install -m 755 -p $(TARGETS) $(DESTDIR)$(sbindir)
diff --git a/tools/tdx/attest/tdx-attest-test.c b/tools/tdx/attest/tdx-attest-test.c
new file mode 100644
index 000000000000..08f776f6802a
--- /dev/null
+++ b/tools/tdx/attest/tdx-attest-test.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * tdx-attest-test.c - utility to test TDX attestation feature.
+ *
+ * Copyright (C) 2021 - 2022 Intel Corporation. All rights reserved.
+ *
+ * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <getopt.h>
+#include <stdint.h> /* uintmax_t */
+#include <sys/mman.h>
+#include <time.h>
+
+#include "../../../include/uapi/misc/tdx.h"
+
+#define devname		"/dev/tdx-attest"
+
+#define HEX_DUMP_SIZE	16
+#define MAX_ROW_SIZE	70
+
+#define ATTESTATION_TEST_BIN_VERSION "0.1"
+
+struct tdx_attest_args {
+	bool is_dump_data;
+	bool is_get_tdreport;
+	bool is_get_quote_size;
+	bool is_gen_quote;
+	bool debug_mode;
+	char *out_file;
+};
+
+struct tdx_gen_quote {
+	void *buf;
+	size_t len;
+};
+
+static void print_hex_dump(const char *title, const char *prefix_str,
+			   const void *buf, int len)
+{
+	const __u8 *ptr = buf;
+	int i, rowsize = HEX_DUMP_SIZE;
+
+	if (!len || !buf)
+		return;
+
+	printf("\t\t%s", title);
+
+	for (i = 0; i < len; i++) {
+		if (!(i % rowsize))
+			printf("\n%s%.8x:", prefix_str, i);
+		printf(" %.2x", ptr[i]);
+	}
+
+	printf("\n");
+}
+
+static void gen_report_data(__u8 *report_data, bool dump_data)
+{
+	int i;
+
+	srand(time(NULL));
+
+	for (i = 0; i < TDX_REPORT_DATA_LEN; i++)
+		report_data[i] = rand();
+
+	if (dump_data)
+		print_hex_dump("\n\t\tTDX report data\n", " ",
+			       report_data, TDX_REPORT_DATA_LEN);
+}
+
+static int get_tdreport(int devfd, bool dump_data, __u8 *report_data)
+{
+	__u8 tdrdata[TDX_TDREPORT_LEN] = {0};
+	int ret;
+
+	if (!report_data)
+		report_data = tdrdata;
+
+	gen_report_data(report_data, dump_data);
+
+	ret = ioctl(devfd, TDX_CMD_GET_TDREPORT, report_data);
+	if (ret) {
+		printf("TDX_CMD_GET_TDREPORT ioctl() %d failed\n", ret);
+		return -EIO;
+	}
+
+	if (dump_data)
+		print_hex_dump("\n\t\tTDX tdreport data\n", " ", report_data,
+			       TDX_TDREPORT_LEN);
+
+	return 0;
+}
+
+static __u64 get_quote_size(int devfd)
+{
+	int ret;
+	__u64 quote_size;
+
+	ret = ioctl(devfd, TDX_CMD_GET_QUOTE_SIZE, &quote_size);
+	if (ret) {
+		printf("TDX_CMD_GET_QUOTE_SIZE ioctl() %d failed\n", ret);
+		return -EIO;
+	}
+
+	printf("Quote size: %lld\n", quote_size);
+
+	return quote_size;
+}
+
+static int gen_quote(int devfd, bool dump_data)
+{
+	__u8 *quote_data;
+	__u64 quote_size;
+	int ret;
+	struct tdx_gen_quote getquote_arg;
+
+	quote_size = get_quote_size(devfd);
+
+	quote_data = malloc(sizeof(char) * quote_size);
+	if (!quote_data) {
+		printf("%s queue data alloc failed\n", devname);
+		return -ENOMEM;
+	}
+
+	ret = get_tdreport(devfd, dump_data, quote_data);
+	if (ret) {
+		printf("TDX_CMD_GET_TDREPORT ioctl() %d failed\n", ret);
+		goto done;
+	}
+
+	getquote_arg.buf = quote_data;
+	getquote_arg.len = quote_size;
+
+	ret = ioctl(devfd, TDX_CMD_GEN_QUOTE, &getquote_arg);
+	if (ret) {
+		printf("TDX_CMD_GEN_QUOTE ioctl() %d failed\n", ret);
+		goto done;
+	}
+
+	print_hex_dump("\n\t\tTDX Quote data\n", " ", quote_data,
+		       quote_size);
+
+done:
+	free(quote_data);
+
+	return ret;
+}
+
+static void usage(void)
+{
+	puts("\nUsage:\n");
+	puts("tdx_attest [options] \n");
+
+	puts("Attestation device test utility.");
+
+	puts("\nOptions:\n");
+	puts(" -d, --dump                Dump tdreport/tdquote data");
+	puts(" -r, --get-tdreport        Get TDREPORT data");
+	puts(" -g, --gen-quote           Generate TDQUOTE");
+	puts(" -s, --get-quote-size      Get TDQUOTE size");
+}
+
+int main(int argc, char **argv)
+{
+	int ret, devfd;
+	struct tdx_attest_args args = {0};
+
+	static const struct option longopts[] = {
+		{ "dump",           no_argument,       NULL, 'd' },
+		{ "get-tdreport",   required_argument, NULL, 'r' },
+		{ "gen-quote",      required_argument, NULL, 'g' },
+		{ "gen-quote-size", required_argument, NULL, 's' },
+		{ "version",        no_argument,       NULL, 'V' },
+		{ NULL,             0, NULL, 0 }
+	};
+
+	while ((ret = getopt_long(argc, argv, "hdrgsV", longopts,
+				  NULL)) != -1) {
+		switch (ret) {
+		case 'd':
+			args.is_dump_data = true;
+			break;
+		case 'r':
+			args.is_get_tdreport = true;
+			break;
+		case 'g':
+			args.is_gen_quote = true;
+			break;
+		case 's':
+			args.is_get_quote_size = true;
+			break;
+		case 'h':
+			usage();
+			return 0;
+		case 'V':
+			printf("Version: %s\n", ATTESTATION_TEST_BIN_VERSION);
+			return 0;
+		default:
+			printf("Invalid options\n");
+			usage();
+			return -EINVAL;
+		}
+	}
+
+	devfd = open(devname, O_RDWR | O_SYNC);
+	if (devfd < 0) {
+		printf("%s open() failed\n", devname);
+		return -ENODEV;
+	}
+
+	if (args.is_get_quote_size)
+		get_quote_size(devfd);
+
+	if (args.is_get_tdreport)
+		get_tdreport(devfd, args.is_dump_data, NULL);
+
+	if (args.is_gen_quote)
+		gen_quote(devfd, args.is_dump_data);
+
+	close(devfd);
+
+	return 0;
+}
-- 
2.25.1

