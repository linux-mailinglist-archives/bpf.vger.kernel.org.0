Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5986E42E0
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 10:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDQIpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDQIpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 04:45:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB32358D
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 01:44:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so14442025pjk.4
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681721097; x=1684313097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NmX+x9DqsXNcwyQ2AzQA++eNv/lGS7QxnupRL+FL2+k=;
        b=Wv8kL57awpXRXk0EW9fQQUFcNJ2J/nff5Thkeftm3tWKRmEgFD+RBldf1zyEBEDkmA
         46rwpDSM9A7x7dtso8ZBruxf9fz4B3RvcOL0Yokk/WSyECsf5Gns1EX/jQqJZDnZMtxB
         OkVXxFKhz9GwTWW6H13EtmWHN+qWm/YucyMBCv+PVzsDWicc22sOuZrmL18ZADCRZ58z
         dqnYkrjeddOp7rPSVJgixl0pVjPJ8Z4rfB4KpXJrJyTwJiTnxpyKuxZ7rZhghUT9k3N1
         JMSqElLyhb/Sa6Mvwt/GQQ2hbwqSd9+eLfkJw6rNUBrc+HwlmnhtMASXw4U/CM6Y7xxQ
         t/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681721097; x=1684313097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmX+x9DqsXNcwyQ2AzQA++eNv/lGS7QxnupRL+FL2+k=;
        b=A5vB1Zc/PzZu+BFBTEi726gVpeRiOsAzMu9bMLtlZzz+/jYH2essT9MMbEjZ4nVV4A
         N1L23RFKDoJCxHYRGnepbaFkcH1F7aJsjHnAKl2C4ox2BEunZe/bBCnuIfNR96kwReEJ
         07+vnP4+677e5eVvVDTEEjeIe+Moa6MItaVvfmmaZO3o0oI06V+Xu46Nl5B+MhJqgkMT
         nQY65XJ7dyiH33pWp0HJb1uM14U8HZ4+zjcl/L1RnzVxEetkyYvOVRmhB6supXgLqFZp
         qtdDO8CcEWycbyC0P6sZ9jzzmpdLAA6ojBT0955YXOzQlKFJUWgRlLk+eumpyrDh7cmM
         bL8A==
X-Gm-Message-State: AAQBX9e+GqHXpo36Qi9/mzBS4NV/6zblDBdF9w4DubpqeAxgzJMfj0u4
        VH9c5f4Ty3ppkIP+UetGsJhI
X-Google-Smtp-Source: AKy350a5zEFkTizr11zAP8X9j+v5+H2omsRZxk1T4qjyH/MeZJDIN2agaSCVBBv1gbyuRPQ/1AF77A==
X-Received: by 2002:a05:6a20:12c6:b0:ef:f558:b80 with SMTP id v6-20020a056a2012c600b000eff5580b80mr2234565pzg.58.1681721097130;
        Mon, 17 Apr 2023 01:44:57 -0700 (PDT)
Received: from HX3YDL60GM.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id u17-20020aa78491000000b0063ba9108c5csm1571536pfn.149.2023.04.17.01.44.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Apr 2023 01:44:56 -0700 (PDT)
From:   "songrui.771" <songrui.771@bytedance.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        "songrui.771" <songrui.771@bytedance.com>
Subject: [PATCH] libbpf: correct the macro KERNEL_VERSION for old kernel
Date:   Mon, 17 Apr 2023 16:44:49 +0800
Message-Id: <20230417084449.99848-1-songrui.771@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The introduced header file linux/version.h in libbpf_probes.c may have a
wrong macro KERNEL_VERSION for calculating LINUX_VERSION_CODE in some old
kernel (Debian9, 10). Below is a version info example from Debian 10.

release: 4.19.0-22-amd64
version: #1 SMP Debian 4.19.260-1 (2022-09-29)

The macro KERNEL_VERSION is defined to (((a) << 16) + ((b) << 8)) + (c)),
which a, b, and c stand for major, minor and patch version. So in example here,
the major is 4, minor is 19, patch is 260, the LINUX_VERSION(4, 19, 260) which
is 267268 should be matched to LINUX_VERSION_CODE. However, the KERNEL_VERSION_CODE
in linux/version.h is defined to 267263.

I noticed that the macro KERNEL_VERSION in linux/version.h of some new kernel is
defined to (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c))). And
KERNEL_VERSION(4, 19, 260) is equal to 267263 which is the right LINUX_VERSION_CODE.

The mismatched LINUX_VERSION_CODE which will cause failing to load kprobe BPF
programs in the version check of BPF syscall.

The return value of get_kernel_version in libbpf_probes.c should be matched to
LINUX_VERSION_CODE by correcting the macro KERNEL_VERSION.

Signed-off-by: songrui.771 <songrui.771@bytedance.com>
---
 tools/lib/bpf/libbpf_probes.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 4f3bc968ff8e..5b22a880c7e7 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -18,6 +18,10 @@
 #include "libbpf.h"
 #include "libbpf_internal.h"
 
+#ifndef LIBBPF_KERNEL_VERSION
+#define LIBBPF_KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))
+#endif
+
 /* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
  * but Ubuntu provides /proc/version_signature file, as described at
  * https://ubuntu.com/kernel, with an example contents below, which we
@@ -47,7 +51,7 @@ static __u32 get_ubuntu_kernel_version(void)
 	if (ret != 3)
 		return 0;
 
-	return KERNEL_VERSION(major, minor, patch);
+	return LIBBPF_KERNEL_VERSION(major, minor, patch);
 }
 
 /* On Debian LINUX_VERSION_CODE doesn't correspond to info.release.
@@ -74,7 +78,7 @@ static __u32 get_debian_kernel_version(struct utsname *info)
 	if (sscanf(p, "Debian %u.%u.%u", &major, &minor, &patch) != 3)
 		return 0;
 
-	return KERNEL_VERSION(major, minor, patch);
+	return LIBBPF_KERNEL_VERSION(major, minor, patch);
 }
 
 __u32 get_kernel_version(void)
@@ -97,7 +101,7 @@ __u32 get_kernel_version(void)
 	if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
 		return 0;
 
-	return KERNEL_VERSION(major, minor, patch);
+	return LIBBPF_KERNEL_VERSION(major, minor, patch);
 }
 
 static int probe_prog_load(enum bpf_prog_type prog_type,
-- 
2.39.2 (Apple Git-143)

