Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C2689188
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 09:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjBCIFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 03:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjBCIEC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 03:04:02 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F11B333
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 00:02:18 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id f10so4700765qtv.1
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 00:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WmkVdp76LerEG9T/7XRcFo3OtfHKIV/m4o/JxJ/hMzA=;
        b=NTRFeKyXt5flBihyacfNNYZ/Bykh9W/fa5B9fZvhp07PXGMM87LM4ogxSmTA/SqtpG
         Aw4X8n5vXbVsQ5yTSRex7lvt1+4xkjiH6L7U6XzcjHs86cHPr27DAPM1W5OlT1X/X9Rm
         l987af1YQJfNwqEDhqqFyWRCg8MQhZ8vGi5lqrNCCDKJUTWt6Om43f/82z36BHoLN4kX
         hndALbmwOJ1U4H0XjkdzSg9+Hd7AsYQN/v31ZiVPYY1JsjRAujD5uzh/c9t3/B0qbbu9
         oJfNGPt4XWDh6MM4z0q4x9/a+S3w+SxqoEu/Dcmukr/e2pqMQLhNxKQ+OEoUhSUhWGS3
         hjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmkVdp76LerEG9T/7XRcFo3OtfHKIV/m4o/JxJ/hMzA=;
        b=3+BWoTUQuPJHHHK+W9rbEWeC0WHcinAk/HEes9U3y/cT8bmIvOuApIeB7E5AowDqvC
         TuRr3qBTntm63UGCeb0tRk4BrbGPg6Q/M6G7g3LWM90Ln8piurXqytNLH2Ajm2lp/Pv6
         UW0M9X5Ng5z4otvdyM62xMhA38OLQEDgSBJCVIo4CrWGKGIOAIOHjrkCJpXuq3zc9aNc
         Y8G4VwON5S63IhvKxMB5HK48oIKBoY/GJcav4rXugyyUSFKmNngGkUhgx09o/ZhqSNnN
         EPbbdSVJBUi8Lr4aSukCYy/rX2VyVmepofxwiwH/IoRwB/zLSPAIBYyt5xRJPxDdR5lz
         O+2A==
X-Gm-Message-State: AO0yUKWOnwqTs5QGAfZx2hghL6nbznGgOLzPAtQZiAaV7h7l9v6yi/o/
        lUi38mK8maNBv+OuOdW+hLkva9PrCiv/aXtw
X-Google-Smtp-Source: AK7set/wofr3Epg0TBZTH9RO9Q9NMGBI7i62o1PJCFvcIUT6PpCazDrJcgPETxx6km+xPUcrwQ7KVw==
X-Received: by 2002:a05:622a:189d:b0:3b9:cd2a:f13d with SMTP id v29-20020a05622a189d00b003b9cd2af13dmr8747922qtc.59.1675411337118;
        Fri, 03 Feb 2023 00:02:17 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.215.126])
        by smtp.gmail.com with ESMTPSA id y18-20020ac87c92000000b003b630ea0ea1sm1164914qtv.19.2023.02.03.00.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:02:16 -0800 (PST)
From:   Hao Xiang <hao.xiang@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     Hao Xiang <hao.xiang@bytedance.com>,
        Ho-Ren Chuang <horenchuang@bytedance.com>
Subject: [PATCH bpf-next v4 1/1] libbpf: Correctly set the kernel code version in Debian kernel.
Date:   Fri,  3 Feb 2023 08:02:10 +0000
Message-Id: <20230203080210.2459384-1-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a previous commit, Ubuntu kernel code version is correctly set
by retrieving the information from /proc/version_signature.

commit<5b3d72987701d51bf31823b39db49d10970f5c2d>
(libbpf: Improve LINUX_VERSION_CODE detection)

The /proc/version_signature file doesn't present in at least the
older versions of Debian distributions (eg, Debian 9, 10). The Debian
kernel has a similar issue where the release information from uname()
syscall doesn't give the kernel code version that matches what the
kernel actually expects. Below is an example content from Debian 10.

release: 4.19.0-23-amd64
version: #1 SMP Debian 4.19.269-1 (2022-12-20) x86_64

Debian reports incorrect kernel version in utsname::release returned
by uname() syscall, which in older kernels (Debian 9, 10) leads to
kprobe BPF programs failing to load due to the version check mismatch.

Fortunately, the correct kernel code version presents in the
utsname::version returned by uname() syscall in Debian kernels. This
change adds another get kernel version function to handle Debian in
addition to the previously added get kernel version function to handle
Ubuntu. Some minor refactoring work is also done to make the code more
readable.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
---
 tools/lib/bpf/libbpf.c        | 37 --------------
 tools/lib/bpf/libbpf_probes.c | 93 +++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 37 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index eed5cec6f510..4191a78b2815 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -34,7 +34,6 @@
 #include <linux/limits.h>
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
-#include <linux/version.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
@@ -870,42 +869,6 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 	return 0;
 }
 
-__u32 get_kernel_version(void)
-{
-	/* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
-	 * but Ubuntu provides /proc/version_signature file, as described at
-	 * https://ubuntu.com/kernel, with an example contents below, which we
-	 * can use to get a proper LINUX_VERSION_CODE.
-	 *
-	 *   Ubuntu 5.4.0-12.15-generic 5.4.8
-	 *
-	 * In the above, 5.4.8 is what kernel is actually expecting, while
-	 * uname() call will return 5.4.0 in info.release.
-	 */
-	const char *ubuntu_kver_file = "/proc/version_signature";
-	__u32 major, minor, patch;
-	struct utsname info;
-
-	if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {
-		FILE *f;
-
-		f = fopen(ubuntu_kver_file, "r");
-		if (f) {
-			if (fscanf(f, "%*s %*s %d.%d.%d\n", &major, &minor, &patch) == 3) {
-				fclose(f);
-				return KERNEL_VERSION(major, minor, patch);
-			}
-			fclose(f);
-		}
-		/* something went wrong, fall back to uname() approach */
-	}
-
-	uname(&info);
-	if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
-		return 0;
-	return KERNEL_VERSION(major, minor, patch);
-}
-
 static const struct btf_member *
 find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
 {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index b44fcbb4b42e..8d2a2bc5eec9 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -12,11 +12,104 @@
 #include <linux/btf.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
+#include <linux/version.h>
 
 #include "bpf.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
 
+/* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
+ * but Ubuntu provides /proc/version_signature file, as described at
+ * https://ubuntu.com/kernel, with an example contents below, which we
+ * can use to get a proper LINUX_VERSION_CODE.
+ *
+ *   Ubuntu 5.4.0-12.15-generic 5.4.8
+ *
+ * In the above, 5.4.8 is what kernel is actually expecting, while
+ * uname() call will return 5.4.0 in info.release.
+ */
+static __u32 get_ubuntu_kernel_version(void)
+{
+	const char *ubuntu_kver_file = "/proc/version_signature";
+	__u32 major, minor, patch;
+
+	if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {
+		FILE *f;
+
+		f = fopen(ubuntu_kver_file, "r");
+		if (f) {
+			if (fscanf(f, "%*s %*s %d.%d.%d\n", &major, &minor, &patch) == 3) {
+				fclose(f);
+				return KERNEL_VERSION(major, minor, patch);
+			}
+			fclose(f);
+		}
+		/* something went wrong, fall back to uname() approach */
+	}
+
+	return 0;
+}
+
+/* On Debian LINUX_VERSION_CODE doesn't correspond to info.release.
+ * Instead, it is provided in info.version. An example content of
+ * Debian 10 looks like the below.
+ *
+ *   utsname::release   4.19.0-22-amd64
+ *   utsname::version   #1 SMP Debian 4.19.260-1 (2022-09-29)
+ *
+ * In the above, 4.19.260 is what kernel is actually expecting, while
+ * uname() call will return 4.19.0 in info.release.
+ */
+static __u32 get_debian_kernel_version(struct utsname *info)
+{
+	__u32 major, minor, patch;
+	char *version;
+	char *p;
+
+	version = info->version;
+
+	p = strstr(version, "Debian ");
+	if (!p) {
+		/* This is not a Debian kernel. */
+		return 0;
+	}
+
+	if (sscanf(p, "Debian %u.%u.%u", &major, &minor, &patch) != 3)
+		return 0;
+
+	return KERNEL_VERSION(major, minor, patch);
+}
+
+static __u32 get_general_kernel_version(struct utsname *info)
+{
+	__u32 major, minor, patch;
+
+	if (sscanf(info->release, "%u.%u.%u", &major, &minor, &patch) != 3)
+		return 0;
+
+	return KERNEL_VERSION(major, minor, patch);
+}
+
+__u32 get_kernel_version(void)
+{
+	__u32 version;
+	struct utsname info;
+
+	/* Check if this is an Ubuntu kernel. */
+	version = get_ubuntu_kernel_version();
+	if (version != 0)
+		return version;
+
+	uname(&info);
+
+	/* Check if this is a Debian kernel. */
+	version = get_debian_kernel_version(&info);
+	if (version != 0)
+		return version;
+
+	return get_general_kernel_version(&info);
+}
+
 static int probe_prog_load(enum bpf_prog_type prog_type,
 			   const struct bpf_insn *insns, size_t insns_cnt,
 			   char *log_buf, size_t log_buf_sz)
-- 
2.30.2

