Return-Path: <bpf+bounces-5635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3175CFAE
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385171C21811
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F621518;
	Fri, 21 Jul 2023 16:36:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3525923
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:36:06 +0000 (UTC)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C64420F;
	Fri, 21 Jul 2023 09:35:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6vw01JDVz9xFZw;
	Sat, 22 Jul 2023 00:22:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3hl1bs7pkcDDSBA--.22409S12;
	Fri, 21 Jul 2023 17:34:55 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	jarkko@kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 10/12] tools: Add tool to manage digest lists
Date: Fri, 21 Jul 2023 18:33:24 +0200
Message-Id: <20230721163326.4106089-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
References: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC3hl1bs7pkcDDSBA--.22409S12
X-Coremail-Antispam: 1UD129KBjvAXoWftryrWF1rCw4rXF1rCFyrCrg_yoW8Kw4rWo
	Z2qF43Gw4ftr17CF4kuFn3Xa1UGwnYkrWkCry8JrWDZF1rJF18KanFkFW5uF13Wr4rKFy3
	ur40q348ur48JrZ7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOo7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
	Aaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIF
	yTuYvjxUxrcTDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj5DJRQABss
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a tool to generate and manage the digest lists. Digest lists can be
generated from a directory, an individual file, or from a list.

Once generated, digest list content can be showed (digest algorithm and
value, file path). Also, the tool can add/remove the security.digest_list
xattr to/from each file in the generated digest lists.

To select the proper generator and parser, each digest list file name must
start with 'format-'.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                                |   1 +
 tools/Makefile                             |  16 +-
 tools/digest-lists/.gitignore              |   3 +
 tools/digest-lists/Makefile                |  48 +++
 tools/digest-lists/common.c                | 163 ++++++++++
 tools/digest-lists/common.h                |  90 ++++++
 tools/digest-lists/manage_digest_lists.c   | 342 +++++++++++++++++++++
 tools/digest-lists/manage_digest_lists.txt |  82 +++++
 8 files changed, 739 insertions(+), 6 deletions(-)
 create mode 100644 tools/digest-lists/.gitignore
 create mode 100644 tools/digest-lists/Makefile
 create mode 100644 tools/digest-lists/common.c
 create mode 100644 tools/digest-lists/common.h
 create mode 100644 tools/digest-lists/manage_digest_lists.c
 create mode 100644 tools/digest-lists/manage_digest_lists.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index d3af1e179b0..6ee11828f2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10294,6 +10294,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 F:	security/integrity/
 F:	security/integrity/ima/
+F:	tools/digest-lists/
 
 INTEL 810/815 FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
diff --git a/tools/Makefile b/tools/Makefile
index 37e9f680483..3789b5f292e 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -15,6 +15,7 @@ help:
 	@echo '  counter                - counter tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
 	@echo '  debugging              - tools for debugging'
+	@echo '  digest-lists           - tools for managing digest lists'
 	@echo '  firewire               - the userspace part of nosy, an IEEE-1394 traffic sniffer'
 	@echo '  firmware               - Firmware tools'
 	@echo '  freefall               - laptop accelerometer program for disk protection'
@@ -69,7 +70,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
+cgroup counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing digest-lists: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -120,7 +121,8 @@ all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio mm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing thermal thermometer thermal-engine
+		pci debugging tracing thermal thermometer thermal-engine \
+		digest-lists
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -128,7 +130,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
+cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install digest-lists_install:
 	$(call descend,$(@:_install=),install)
 
 selftests_install:
@@ -161,7 +163,8 @@ install: acpi_install cgroup_install counter_install cpupower_install gpio_insta
 		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
-		tracing_install thermometer_install thermal-engine_install
+		tracing_install thermometer_install thermal-engine_install \
+		digest-lists_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -169,7 +172,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
+cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean digest-lists_clean:
 	$(call descend,$(@:_clean=),clean)
 
 libapi_clean:
@@ -214,6 +217,7 @@ clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_cl
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
-		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean
+		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
+		digest-lists_clean
 
 .PHONY: FORCE
diff --git a/tools/digest-lists/.gitignore b/tools/digest-lists/.gitignore
new file mode 100644
index 00000000000..1b8a7b9c205
--- /dev/null
+++ b/tools/digest-lists/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+manage_digest_lists
+manage_digest_lists.1
diff --git a/tools/digest-lists/Makefile b/tools/digest-lists/Makefile
new file mode 100644
index 00000000000..05af3a91c06
--- /dev/null
+++ b/tools/digest-lists/Makefile
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../scripts/Makefile.include
+include ../scripts/utilities.mak
+BINDIR=usr/bin
+MANDIR=usr/share/man
+MAN1DIR=$(MANDIR)/man1
+CFLAGS=-ggdb -Wall
+
+PROGS=manage_digest_lists
+
+MAN1=manage_digest_lists.1
+
+A2X=a2x
+a2x_path := $(call get-executable,$(A2X))
+
+all: man $(PROGS)
+
+manage_digest_lists: manage_digest_lists.c common.c
+	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS) -lcrypto
+
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+  ifneq ($(V),1)
+     QUIET_A2X = @echo '  A2X     '$@;
+  endif
+endif
+
+%.1: %.txt
+ifeq ($(a2x_path),)
+	$(error "You need to install asciidoc for man pages")
+else
+	$(QUIET_A2X)$(A2X) --doctype manpage --format manpage $<
+endif
+
+clean:
+	rm -f $(MAN1) $(PROGS)
+
+man: $(MAN1)
+
+install-man: man
+	install -d -m 755 $(INSTALL_ROOT)/$(MAN1DIR)
+	install -m 644 $(MAN1) $(INSTALL_ROOT)/$(MAN1DIR)
+
+install-tools: $(PROGS)
+	install -d -m 755 $(INSTALL_ROOT)/$(BINDIR)
+	install -m 755 -p $(PROGS) "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
+
+install: install-tools install-man
+.PHONY: all clean man install-tools install-man install
diff --git a/tools/digest-lists/common.c b/tools/digest-lists/common.c
new file mode 100644
index 00000000000..5378e677c09
--- /dev/null
+++ b/tools/digest-lists/common.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Common functions and data.
+ */
+
+#include <sys/mman.h>
+#include <sys/random.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <linux/types.h>
+#include <linux/hash_info.h>
+#include <openssl/sha.h>
+#include <openssl/evp.h>
+#include <asm/byteorder.h>
+
+#include "common.h"
+
+const char *const hash_algo_name[HASH_ALGO__LAST] = {
+	[HASH_ALGO_MD4]		= "md4",
+	[HASH_ALGO_MD5]		= "md5",
+	[HASH_ALGO_SHA1]	= "sha1",
+	[HASH_ALGO_RIPE_MD_160]	= "rmd160",
+	[HASH_ALGO_SHA256]	= "sha256",
+	[HASH_ALGO_SHA384]	= "sha384",
+	[HASH_ALGO_SHA512]	= "sha512",
+	[HASH_ALGO_SHA224]	= "sha224",
+	[HASH_ALGO_RIPE_MD_128]	= "rmd128",
+	[HASH_ALGO_RIPE_MD_256]	= "rmd256",
+	[HASH_ALGO_RIPE_MD_320]	= "rmd320",
+	[HASH_ALGO_WP_256]	= "wp256",
+	[HASH_ALGO_WP_384]	= "wp384",
+	[HASH_ALGO_WP_512]	= "wp512",
+	[HASH_ALGO_TGR_128]	= "tgr128",
+	[HASH_ALGO_TGR_160]	= "tgr160",
+	[HASH_ALGO_TGR_192]	= "tgr192",
+	[HASH_ALGO_SM3_256]	= "sm3",
+	[HASH_ALGO_STREEBOG_256] = "streebog256",
+	[HASH_ALGO_STREEBOG_512] = "streebog512",
+};
+
+const int hash_digest_size[HASH_ALGO__LAST] = {
+	[HASH_ALGO_MD4]		= MD5_DIGEST_SIZE,
+	[HASH_ALGO_MD5]		= MD5_DIGEST_SIZE,
+	[HASH_ALGO_SHA1]	= SHA1_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_160]	= RMD160_DIGEST_SIZE,
+	[HASH_ALGO_SHA256]	= SHA256_DIGEST_SIZE,
+	[HASH_ALGO_SHA384]	= SHA384_DIGEST_SIZE,
+	[HASH_ALGO_SHA512]	= SHA512_DIGEST_SIZE,
+	[HASH_ALGO_SHA224]	= SHA224_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_128]	= RMD128_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_256]	= RMD256_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_320]	= RMD320_DIGEST_SIZE,
+	[HASH_ALGO_WP_256]	= WP256_DIGEST_SIZE,
+	[HASH_ALGO_WP_384]	= WP384_DIGEST_SIZE,
+	[HASH_ALGO_WP_512]	= WP512_DIGEST_SIZE,
+	[HASH_ALGO_TGR_128]	= TGR128_DIGEST_SIZE,
+	[HASH_ALGO_TGR_160]	= TGR160_DIGEST_SIZE,
+	[HASH_ALGO_TGR_192]	= TGR192_DIGEST_SIZE,
+	[HASH_ALGO_SM3_256]	= SM3256_DIGEST_SIZE,
+	[HASH_ALGO_STREEBOG_256] = STREEBOG256_DIGEST_SIZE,
+	[HASH_ALGO_STREEBOG_512] = STREEBOG512_DIGEST_SIZE,
+};
+
+int read_file(const char *path, size_t *len, unsigned char **data)
+{
+	struct stat st;
+	int rc = 0, fd;
+
+	if (stat(path, &st) == -1)
+		return -ENOENT;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -EACCES;
+
+	*len = st.st_size;
+
+	*data = mmap(NULL, *len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (*data == MAP_FAILED)
+		rc = -ENOMEM;
+
+	close(fd);
+	return rc;
+}
+
+int calc_digest(__u8 *digest, void *data, __u64 len, enum hash_algo algo)
+{
+	EVP_MD_CTX *mdctx;
+	const EVP_MD *md;
+	int ret = -EINVAL;
+
+	OpenSSL_add_all_algorithms();
+
+	md = EVP_get_digestbyname(hash_algo_name[algo]);
+	if (!md)
+		goto out;
+
+	mdctx = EVP_MD_CTX_create();
+	if (!mdctx)
+		goto out;
+
+	if (EVP_DigestInit_ex(mdctx, md, NULL) != 1)
+		goto out_mdctx;
+
+	if (EVP_DigestUpdate(mdctx, data, len) != 1)
+		goto out_mdctx;
+
+	if (EVP_DigestFinal_ex(mdctx, digest, NULL) != 1)
+		goto out_mdctx;
+
+	ret = 0;
+out_mdctx:
+	EVP_MD_CTX_destroy(mdctx);
+out:
+	EVP_cleanup();
+	return ret;
+}
+
+int calc_file_digest(__u8 *digest, const char *path, enum hash_algo algo)
+{
+	unsigned char *data;
+	size_t len;
+	int ret;
+
+	ret = read_file(path, &len, &data);
+	if (ret < 0)
+		return ret;
+
+	ret = calc_digest(digest, data, len, algo);
+
+	munmap(data, len);
+	return ret;
+}
+
+ssize_t _write(int fd, void *buf, size_t buf_len)
+{
+	ssize_t len;
+	loff_t offset = 0;
+
+	while (offset < buf_len) {
+		len = write(fd, buf + offset, buf_len - offset);
+		if (len < 0)
+			return -errno;
+
+		offset += len;
+	}
+
+	return buf_len;
+}
diff --git a/tools/digest-lists/common.h b/tools/digest-lists/common.h
new file mode 100644
index 00000000000..d65168e2932
--- /dev/null
+++ b/tools/digest-lists/common.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header of common.c
+ */
+
+#include <stdint.h>
+#include <sys/stat.h>
+#include <linux/types.h>
+#include <linux/hash_info.h>
+
+#define MD5_DIGEST_SIZE 16
+#define SHA1_DIGEST_SIZE 20
+#define RMD160_DIGEST_SIZE 20
+#define SHA256_DIGEST_SIZE 32
+#define SHA384_DIGEST_SIZE 48
+#define SHA512_DIGEST_SIZE 64
+#define SHA224_DIGEST_SIZE 28
+#define RMD128_DIGEST_SIZE 16
+#define RMD256_DIGEST_SIZE 32
+#define RMD320_DIGEST_SIZE 40
+#define WP256_DIGEST_SIZE 32
+#define WP384_DIGEST_SIZE 48
+#define WP512_DIGEST_SIZE 64
+#define TGR128_DIGEST_SIZE 16
+#define TGR160_DIGEST_SIZE 20
+#define TGR192_DIGEST_SIZE 24
+#define SM3256_DIGEST_SIZE 32
+#define STREEBOG256_DIGEST_SIZE 32
+#define STREEBOG512_DIGEST_SIZE 64
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+
+#define DIGEST_LIST_SIZE_MAX (64 * 1024 * 1024 - 1)
+
+/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
+#define MODULE_SIG_STRING "~Module signature appended~\n"
+
+enum pkey_id_type {
+	PKEY_ID_PGP,		/* OpenPGP generated key ID */
+	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
+	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
+};
+
+/*
+ * Module signature information block.
+ *
+ * The constituents of the signature section are, in order:
+ *
+ *	- Signer's name
+ *	- Key identifier
+ *	- Signature data
+ *	- Information block
+ */
+struct module_signature {
+	__u8	algo;		/* Public-key crypto algorithm [0] */
+	__u8	hash;		/* Digest algorithm [0] */
+	__u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
+	__u8	signer_len;	/* Length of signer's name [0] */
+	__u8	key_id_len;	/* Length of key identifier [0] */
+	__u8	__pad[3];
+	__be32	sig_len;	/* Length of signature data */
+};
+
+enum ops { OP_GEN, OP_SHOW, OP_ADD_XATTR, OP_RM_XATTR, OP__LAST };
+
+struct generator {
+	const char *name;
+	void *(*new)(int dirfd, char *input, enum hash_algo algo);
+	int (*add)(int dirfd, void *ptr, char *input);
+	void (*close)(void *ptr);
+};
+
+struct parser {
+	const char *name;
+	int (*parse)(const char *digest_list_path, enum ops op);
+};
+
+extern const char *ops_str[OP__LAST];
+extern const char *const hash_algo_name[HASH_ALGO__LAST];
+extern const int hash_digest_size[HASH_ALGO__LAST];
+
+int read_file(const char *path, size_t *len, unsigned char **data);
+int calc_digest(__u8 *digest, void *data, __u64 len, enum hash_algo algo);
+int calc_file_digest(__u8 *digest, const char *path, enum hash_algo algo);
+ssize_t _write(int fd, void *buf, size_t buf_len);
diff --git a/tools/digest-lists/manage_digest_lists.c b/tools/digest-lists/manage_digest_lists.c
new file mode 100644
index 00000000000..9da62bd3570
--- /dev/null
+++ b/tools/digest-lists/manage_digest_lists.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement a tool to manage digest lists..
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <limits.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <linux/hash_info.h>
+#include <linux/xattr.h>
+#include <fts.h>
+
+#include "common.h"
+
+const char *ops_str[OP__LAST] = {
+	[OP_GEN] = "gen",
+	[OP_SHOW] = "show",
+	[OP_ADD_XATTR] = "add-xattr",
+	[OP_RM_XATTR] = "rm-xattr",
+};
+
+struct generator generators[] = {
+};
+
+struct parser parsers[] = {
+};
+
+static int generator_add(struct generator *generator, int dirfd,
+			 void *ptr, char *input)
+{
+	char *full_path = input;
+	int ret;
+
+	if (!generator->add)
+		return -ENOENT;
+
+	if (strncmp(input, "rpmdb", 5)) {
+		full_path = realpath(input, NULL);
+		if (!full_path) {
+			printf("Error generating full path of %s\n", full_path);
+			return -ENOMEM;
+		}
+	}
+
+	ret = generator->add(dirfd, ptr, full_path);
+
+	if (full_path != input)
+		free(full_path);
+
+	return ret;
+}
+
+static int gen_digest_list(char *digest_list_format, char *digest_list_dir,
+			   char *input, int input_is_list, __u8 algo)
+{
+	struct generator *generator;
+	void *ptr;
+	FTS *fts = NULL;
+	FTSENT *ftsent;
+	FILE *fp;
+	int fts_flags = (FTS_PHYSICAL | FTS_COMFOLLOW | FTS_NOCHDIR | FTS_XDEV);
+	char *paths[2] = { input, NULL };
+	char line[1024], *p;
+	int ret, i, dirfd;
+
+	for (i = 0; i < ARRAY_SIZE(generators); i++)
+		if (!strcmp(generators[i].name, digest_list_format))
+			break;
+
+	if (i == ARRAY_SIZE(generators)) {
+		printf("Cannot find generator for %s\n", digest_list_format);
+		return -ENOENT;
+	}
+
+	generator = &generators[i];
+
+	dirfd = open(digest_list_dir, O_RDONLY | O_DIRECTORY);
+	if (dirfd < 0) {
+		printf("Unable to open %s, ret: %d\n", digest_list_dir, -errno);
+		return -errno;
+	}
+
+	if (generator->new) {
+		ptr = generator->new(dirfd, input, algo);
+		if (!ptr) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	if (input_is_list) {
+		fp = fopen(input, "r");
+		if (!fp) {
+			ret = -EACCES;
+			goto out_close;
+		}
+
+		while ((fgets(line, sizeof(line), fp))) {
+			p = strrchr(line, '\n');
+			*p = '\0';
+
+			ret = generator_add(generator, dirfd, ptr, line);
+			if (ret < 0) {
+				printf("Error generating entry for %s, ret: %d\n",
+				       line, ret);
+				fclose(fp);
+				goto out_close;
+			}
+		}
+
+		fclose(fp);
+		goto out_close;
+	} else if (!strncmp(input, "rpmdb", 5)) {
+		ret = generator_add(generator, dirfd, ptr, input);
+		if (ret < 0) {
+			printf("Error generating entry for %s, ret: %d\n",
+			       input, ret);
+			goto out_close;
+		}
+	}
+
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		printf("Unable to open %s\n", input);
+		ret = -EACCES;
+		goto out_close;
+	}
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_F:
+			ret = generator_add(generator, dirfd, ptr,
+					    ftsent->fts_path);
+			if (ret < 0) {
+				printf("Error generating entry for %s, ret: %d\n",
+				       ftsent->fts_path, ret);
+				goto out_fts_close;
+			}
+		default:
+			break;
+		}
+	}
+
+out_fts_close:
+	fts_close(fts);
+out_close:
+	if (generator->close)
+		generator->close(ptr);
+out:
+	close(dirfd);
+	return ret;
+}
+
+static struct parser *get_parser(const char *filename)
+{
+	const char *separator;
+	int i;
+
+	separator = strchr(filename, '-');
+	if (!separator)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(parsers); i++)
+		if (!strncmp(parsers[i].name, filename, separator - filename))
+			break;
+
+	if (i == ARRAY_SIZE(parsers)) {
+		printf("Cannot find parser for %s\n", filename);
+		return NULL;
+	}
+
+	return &parsers[i];
+}
+
+static int parse_digest_list(char *digest_list_format, char *digest_list_path,
+			     enum ops op)
+{
+	struct parser *parser;
+	FTS *fts = NULL;
+	FTSENT *ftsent;
+	int fts_flags = (FTS_PHYSICAL | FTS_COMFOLLOW | FTS_NOCHDIR | FTS_XDEV);
+	char *paths[2] = { NULL, NULL };
+	char *full_path = NULL;
+	int ret;
+
+	full_path = realpath(digest_list_path, NULL);
+	if (!full_path)
+		return -ENOMEM;
+
+	paths[0] = full_path;
+
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		printf("Unable to open %s\n", digest_list_path);
+		free(full_path);
+		return -EACCES;
+	}
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_F:
+			parser = get_parser(ftsent->fts_name);
+			if (!parser)
+				continue;
+
+			ret = parser->parse(ftsent->fts_path, op);
+			if (ret < 0) {
+				printf("Error parsing entry %s, ret: %d\n",
+				       ftsent->fts_path, ret);
+				goto out_fts_close;
+			}
+
+			break;
+		default:
+			break;
+		}
+	}
+
+out_fts_close:
+	fts_close(fts);
+	free(full_path);
+	return ret;
+}
+
+static void usage(char *progname)
+{
+	printf("Usage: %s <options>\n", progname);
+	printf("Options:\n");
+	printf("\t-d <directory>: directory digest lists are written to\n"
+	       "\t-i <input>: input digest list for an operation"
+	       "\t-L: input is a list of files/directories\n"
+	       "\t-a <algo>: digest list algorithm\n"
+	       "\t-f <format>: digest list format\n"
+	       "\t-o <operation>: operation to perform\n"
+	       "\t\tgen: generate a digest list\n"
+	       "\t\tshow: show the content of a digest list\n"
+	       "\t\tadd-xattr: set the " XATTR_NAME_DIGEST_LIST " xattr to the digest list path\n"
+	       "\t\trm-xattr: remove the " XATTR_NAME_DIGEST_LIST " xattr\n"
+	       "\t-h: display help\n");
+}
+
+int main(int argc, char *argv[])
+{
+	char *digest_list_dir = NULL, *digest_list_format = NULL, *input = NULL;
+	enum hash_algo algo = HASH_ALGO_SHA256;
+	enum ops op = OP__LAST;
+	struct stat st;
+	int c, i;
+	int ret, input_is_list = 0;
+
+	while ((c = getopt(argc, argv, "d:i:La:f:o:h")) != -1) {
+		switch (c) {
+		case 'd':
+			digest_list_dir = optarg;
+			break;
+		case 'i':
+			input = optarg;
+			break;
+		case 'L':
+			input_is_list = 1;
+			break;
+		case 'a':
+			for (i = 0; i < HASH_ALGO__LAST; i++)
+				if (!strcmp(hash_algo_name[i], optarg))
+					break;
+			if (i == HASH_ALGO__LAST) {
+				printf("Invalid algo %s\n", optarg);
+				exit(1);
+			}
+			algo = i;
+			break;
+		case 'f':
+			digest_list_format = optarg;
+			break;
+		case 'o':
+			for (op = 0; op < OP__LAST; op++)
+				if (!strcmp(ops_str[op], optarg))
+					break;
+			if (op == OP__LAST) {
+				printf("Invalid op %s\n", optarg);
+				exit(1);
+			}
+			break;
+		case 'h':
+			usage(argv[0]);
+			exit(0);
+		default:
+			printf("Invalid option %c\n", c);
+			exit(1);
+		}
+	}
+
+	if (op == OP__LAST) {
+		printf("Operation not specified\n");
+		exit(1);
+	}
+
+	switch (op) {
+	case OP_GEN:
+		if (!digest_list_format || !input || !digest_list_dir) {
+			printf("Missing format/input/digest list directory\n");
+			exit(1);
+		}
+
+		if (stat(digest_list_dir, &st) == -1) {
+			ret = mkdir(digest_list_dir, 0755);
+			if (ret < 0) {
+				printf("Unable to create %s, ret: %d\n",
+				       digest_list_dir, -errno);
+				return(-errno);
+			}
+		}
+
+		ret = gen_digest_list(digest_list_format, digest_list_dir,
+				      input, input_is_list, algo);
+		break;
+	case OP_SHOW:
+	case OP_ADD_XATTR:
+	case OP_RM_XATTR:
+		if (!input) {
+			printf("Missing input\n");
+			exit(1);
+		}
+
+		ret = parse_digest_list(digest_list_format, input, op);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
diff --git a/tools/digest-lists/manage_digest_lists.txt b/tools/digest-lists/manage_digest_lists.txt
new file mode 100644
index 00000000000..62d655516e8
--- /dev/null
+++ b/tools/digest-lists/manage_digest_lists.txt
@@ -0,0 +1,82 @@
+manage_digest_lists(1)
+======================
+
+NAME
+----
+manage_digest_lists - manage digest lists lifecycle
+
+
+SYNOPSIS
+--------
+manage_digest_lists [options]
+
+
+DESCRIPTION
+------------
+manage_digest_lists can be used to manage the lifecycle of digest lists (e.g. generate, show).
+
+
+OPTIONS
+-------
+-d <directory>::
+	directory digest lists are written to
+
+-i <input>::
+	input digest list for an operation
+
+-L::
+	input is a list of files/directories
+
+-a <algo>::
+	digest list algorithm
+
+-f <format>::
+	digest list format
+
+-o <operation>::
+	operation to perform:::
+		gen::::
+			generate a digest list
+		show::::
+			show the content of a digest list
+		add-xattr::::
+			set the security.digest_list xattr to the digest list path
+		rm-xattr::::
+			remove the security.digest_list xattr
+
+-h::
+	display help
+
+
+EXAMPLES
+--------
+Generate digest lists from the RPM database:
+
+# manage_digest_lists -d /etc/digest_lists -i rpmdb -o gen -f rpm
+
+
+Generate digest lists for the kernel modules (for custom kernels):
+
+# manage_digest_lists -d /etc/digest_lists -i /lib/modules/`uname -r` -o gen -f tlv
+
+
+Show digest lists content in /etc/digest_lists
+
+# manage_digest_lists -i /etc/digest_lists -o show
+
+
+Add security.digest_list xattr for digest lists in /etc/digest_lists
+
+# manage_digest_lists -i /etc/digest_lists -o add-xattr
+
+
+AUTHOR
+------
+Written by Roberto Sassu, <roberto.sassu at huawei.com>.
+
+
+COPYING
+-------
+Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH. Free use of
+this software is granted under the terms of the GNU Public License 2.0
+(GPLv2).
-- 
2.34.1


