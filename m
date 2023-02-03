Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76320688FAA
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 07:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjBCG2e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 01:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBCG2c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 01:28:32 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD72577FB
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 22:28:30 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v3so2992778pgh.4
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 22:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJKW0BP2BREIf05/srvhsL59YDOa9UfqeOOlhPDHeos=;
        b=VIePh4vuO3Z9VI6ttvpe75YPwZJwclk4LV51B59fl0qKdOwXHmG0yPZ2kae1tMCHMT
         7uM0/WoKbdKtW0YxcxzdGntCFbkUt4k3an4zlHeNEmg2Pcv5HcJ7d+22r7tq3TrZZ735
         T379QJeQRU8OmvJgWQFhIr3QOpf+uZMtaf6JEQA23J1YI2QE6REcF7b7MkZaF9gUYtaK
         iaSQOiRWSQr7QO6WW8HcqMFGoIp2tCp2s1f6qQuFXCfcYgEc11bgJ4egxPfT6NHHSVkS
         K/tu5v248qlrqxFA8YDw19TP9Wslv18eW+zNgo41CYhkWJ6JE0lz4NgB8KXeLbm+9DJi
         NfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJKW0BP2BREIf05/srvhsL59YDOa9UfqeOOlhPDHeos=;
        b=FSmtw+sCcKoLgIaz9cyskKmmxcpmpOo2RuJC8jYF5A+bFRp2T7P0RE+zHMj1AhcqqY
         q6OjHeG6cmWtGDAV6Yj3DzLKippUGmfw7QREf8Mu/QqSWjy8anTunxRyWryY80kHN9i4
         tpR0DJa3GBFBIY7DT4HYhULbbMGfPvM1q6y2TQf1UDnxd1JT3+zUntGW+98Q9XHbJv/u
         qNB37Y/w8CSnmMfKBaTyiQCN2jBb0U8y68W/i01c2GHZPomin8vLrYnpxg127aCOIVTp
         pwR4PhJQEM8TCjLw9fgQX9sc+ePkZWLTduUvhF35XvwuARESNXnPzgJSW0pj2uvZkCNb
         9yaw==
X-Gm-Message-State: AO0yUKXGLxzvj0gJfe2uHLkzNaUy3vB/3XA0x24ip20+ejSJmnHeADIn
        1KPD4uhjyVWRv3MRi4wzpGgeWEC5iNmIAxA1VYGXlRTgk+S8FiYS
X-Google-Smtp-Source: AK7set+/U2hxYNStTu0SJdOHuX4rYP/PbgWN2H8qF2Gb2SFVzBbdJFHHVC/8p6pdmyrNtW/Sqa1op7JWKFv+sskSNzs=
X-Received: by 2002:a62:33c4:0:b0:592:ecb5:f51f with SMTP id
 z187-20020a6233c4000000b00592ecb5f51fmr1858273pfz.34.1675405709836; Thu, 02
 Feb 2023 22:28:29 -0800 (PST)
MIME-Version: 1.0
From:   "Hao Xiang ." <hao.xiang@bytedance.com>
Date:   Thu, 2 Feb 2023 22:28:18 -0800
Message-ID: <CAAYibXha2zHsqvh=SYNKS3cd6JF4z-YmCTevL=uMGa3ZA4C5tw@mail.gmail.com>
Subject: [PATCH bpf-next v3 1/1] libbpf: Correctly set the kernel code version
 in Debian kernel.
To:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Xiaoning Ding <xiaoning.ding@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
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
@@ -870,42 +869,6 @@ bpf_object__add_programs(struct bpf_object *obj,
Elf_Data *sec_data,
        return 0;
}

-__u32 get_kernel_version(void)
-{
-        /* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
-         * but Ubuntu provides /proc/version_signature file, as described at
-         * https://ubuntu.com/kernel, with an example contents below, which we
-         * can use to get a proper LINUX_VERSION_CODE.
-         *
-         *   Ubuntu 5.4.0-12.15-generic 5.4.8
-         *
-         * In the above, 5.4.8 is what kernel is actually expecting, while
-         * uname() call will return 5.4.0 in info.release.
-         */
-        const char *ubuntu_kver_file = "/proc/version_signature";
-        __u32 major, minor, patch;
-        struct utsname info;
-
-        if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {
-                FILE *f;
-
-                f = fopen(ubuntu_kver_file, "r");
-                if (f) {
-                        if (fscanf(f, "%*s %*s %d.%d.%d\n", &major,
&minor, &patch) == 3) {
-                                fclose(f);
-                                return KERNEL_VERSION(major, minor, patch);
-                        }
-                        fclose(f);
-                }
-                /* something went wrong, fall back to uname() approach */
-        }
-
-        uname(&info);
-        if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
-                return 0;
-        return KERNEL_VERSION(major, minor, patch);
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
+        const char *ubuntu_kver_file = "/proc/version_signature";
+        __u32 major, minor, patch;
+
+        if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {
+                FILE *f;
+
+                f = fopen(ubuntu_kver_file, "r");
+                if (f) {
+                        if (fscanf(f, "%*s %*s %d.%d.%d\n", &major,
&minor, &patch) == 3) {
+                                fclose(f);
+                                return KERNEL_VERSION(major, minor, patch);
+                        }
+                        fclose(f);
+                }
+                /* something went wrong, fall back to uname() approach */
+        }
+
+        return 0;
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
+        __u32 major, minor, patch;
+        char *version;
+        char *p;
+
+        version = info->version;
+
+        p = strstr(version, "Debian ");
+        if (!p) {
+                /* This is not a Debian kernel. */
+                return 0;
+        }
+
+        if (sscanf(p, "Debian %u.%u.%u", &major, &minor, &patch) != 3)
+                return 0;
+
+        return KERNEL_VERSION(major, minor, patch);
+}
+
+static __u32 get_general_kernel_version(struct utsname *info)
+{
+        __u32 major, minor, patch;
+
+        if (sscanf(info->release, "%u.%u.%u", &major, &minor, &patch) != 3)
+                return 0;
+
+        return KERNEL_VERSION(major, minor, patch);
+}
+
+__u32 get_kernel_version(void)
+{
+        __u32 version;
+        struct utsname info;
+
+        /* Check if this is an Ubuntu kernel. */
+        version = get_ubuntu_kernel_version();
+        if (version != 0)
+                return version;
+
+        uname(&info);
+
+        /* Check if this is a Debian kernel. */
+        version = get_debian_kernel_version(&info);
+        if (version != 0)
+                return version;
+
+        return get_general_kernel_version(&info);
+}
+
static int probe_prog_load(enum bpf_prog_type prog_type,
                           const struct bpf_insn *insns, size_t insns_cnt,
                           char *log_buf, size_t log_buf_sz)
--
2.30.2
