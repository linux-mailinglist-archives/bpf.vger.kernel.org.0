Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4468722F
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 01:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBBAKB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 19:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAKB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 19:10:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32C6ACA7
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 16:09:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g68so150601pgc.11
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 16:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3VH1Z7N4Ya6MJ2/T/4f7DAbxWUI3DzQXIZ8w/x6/BzU=;
        b=NNEAMIl4Kyl849A8j2CY24I33/WZxWnaAJsEBIT2MLGYAIadOFSONWjFKEoYHU4LQM
         qRDYwG0EpRfJm4c7lhLRlGZD34SaFqlh6pw+XIyxkaR7CpRRC0hxI3+v/Ahgj2S03PGn
         Ov32HDs5eNhWE1DqOP9WieLW0dO305ERHBj7Z1m7dPfpdjlCk0caXt+sAlAspJbXLfZN
         DfaChUJGc/LnmoSooVQCG0UChlU870DiJ+vApoyP5BI9JPg7ftuEFU97iy4tW7Pc4bTD
         HM9EhNj8rQDV+cO154X+NtBm75rBipIz5tFbCWZW4zuPoUrx3y0agt9oFh7ACWG4jBGq
         Nz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VH1Z7N4Ya6MJ2/T/4f7DAbxWUI3DzQXIZ8w/x6/BzU=;
        b=bLR5hpCzbnsv9HTQ1C6vKaEM9C0KwBuMp/02IthTnqTjZbWszuGHmToc4422CRBGll
         xKizEsh0/1x524H0LnYQM0SGx1Z29xrDN1CppESfKhh6mj6sUqQcd0xkIpiMhDR3TD9l
         sUWTyyGq5FIDGcr+SK4pmG5jjuzcekaISd4+dVMULNZERZ6oa4GZT/RS6NT9CpjxKW0S
         mXSH7G5+SfneT7FqdLGOtklXGrpBS0v9KuTLNNsGdcst7+xEMchk+aqFsZu5dIrW73vl
         4B7Vwkxn0+KLNwv4e/28hZb5fgciePsj9j9UPni3exria2hOQbswS5VK+JOdf7DWp/nX
         rgeQ==
X-Gm-Message-State: AO0yUKUBG6kFdt8WVxnwnp0vFMdNItSw46kFCoVbMSy68QfgTn23mxT2
        asHGMFejaK/pDWptuA5bGEL9PGJEdml7zcrKNFLYevend5ryYsZU
X-Google-Smtp-Source: AK7set+JFWoaUFeQLQkym3BkZ5kH6lgpzgMSaQuY0vC1TD/kyKqqdO49MHlqpvQFctqdSrJTzZYiLCWysBaYSWEsMjs=
X-Received: by 2002:a62:f903:0:b0:58d:bb12:2da5 with SMTP id
 o3-20020a62f903000000b0058dbb122da5mr1064191pfh.27.1675296575244; Wed, 01 Feb
 2023 16:09:35 -0800 (PST)
MIME-Version: 1.0
From:   "Hao Xiang ." <hao.xiang@bytedance.com>
Date:   Wed, 1 Feb 2023 16:09:24 -0800
Message-ID: <CAAYibXg7VYj1maf4_h0ssXUwTLxFJpptekkQ_x7J7GjLtNHphA@mail.gmail.com>
Subject: [PATCH bpf-next v1 1/1] libbpf: Correctly set the kernel code version
 in Debian kernel.
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Yifei Ma <yifeima@bytedance.com>,
        "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
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

In a previous commit, Ubuntu kernel code version is correctly set by
retrieving the information from /proc/version_signature.

   commit<5b3d72987701d51bf31823b39db49d10970f5c2d>
   (libbpf: Improve LINUX_VERSION_CODE detection)

However, the /proc/version_signature file doesn't exist in at least the
older versions of Debian distributions (eg, Debian 9, 10). The Debian
kernel has a similar issue where the release information from uname()
syscall doesn't give the kernel code version that matches what the kernel
actually expects. Below is an example content from Debian 10.

   release: 4.19.0-23-amd64
   version: #1 SMP Debian 4.19.269-1 (2022-12-20) x86_64

Debian reports incorrect kernel version in utsname::release returned
by uname() syscall, which in older kernels (Debian 9, 10) leads to
kprobe BPF programs failing to load due to the version check mismatch.

Fortunately, the correct kernel code version presents in the
utsname::version returned by uname() syscall in Debian kernels.
This change adds another get kernel version function to handle
Debian in addition to the previously added get kernel version function
to handle Ubuntu. Some minor refactoring work is also done to make
the code more readable.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
---
tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++-------
1 file changed, 78 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index eed5cec6f510..bc022d0cd71f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -870,21 +870,20 @@ bpf_object__add_programs(struct bpf_object *obj,
Elf_Data *sec_data,
        return 0;
}

-__u32 get_kernel_version(void)
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
{
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
        const char *ubuntu_kver_file = "/proc/version_signature";
        __u32 major, minor, patch;
-        struct utsname info;

        if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {
                FILE *f;
@@ -900,12 +899,77 @@ __u32 get_kernel_version(void)
                /* something went wrong, fall back to uname() approach */
        }

-        uname(&info);
-        if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
+        return 0;
+}
+
+#define VERSION_PREFIX_DEBIAN "Debian "
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
+        size_t len;
+        char *version;
+        char *find;
+
+        version = info->version;
+
+        find = strstr(version, VERSION_PREFIX_DEBIAN);
+        if (!find) {
+              /* This is not a Debian kernel. */
                return 0;
+        }
+
+        len = strlen(version);
+        find += strlen(VERSION_PREFIX_DEBIAN);
+        if (find - version >= len)
+                return 0;
+
+        if (sscanf(find, "%u.%u.%u", &major, &minor, &patch) != 3)
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
        return KERNEL_VERSION(major, minor, patch);
}

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
static const struct btf_member *
find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
{
-- 
2.30.2
