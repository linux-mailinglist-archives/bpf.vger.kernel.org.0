Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6DC36DED
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 09:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfFFH5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 03:57:07 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42108 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfFFH5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 03:57:06 -0400
Received: by mail-yw1-f66.google.com with SMTP id s5so506841ywd.9
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uI1TPeuSd92UbPS5N8KX6krfL9bLASM56BYU9fb4POc=;
        b=EK+JXrEb8VZeAve5rLD+Ic/Gr9G7cOKUKRQnt3SOMK+SMmMPKBMI+B0StZwtvAWh1D
         aBEv5d/DrZVVRllIXm915E2xHNU8V5RG/EiWbcA/AbyqyqyiFJOrT83ecKGDkF7i9tJY
         GpckMQnpe3QSIqMStsVcUDMErMzwZ4opdg5k7/YHlRovgOSvj9xRCuITR2V/S9RX+FBc
         U7vAhEqS/GK2I3xjJGUiyIMMXYRGNUY8a4ut5u4Y5q+Hwcvw+ATyrJdCFA1295pinl45
         lDcxuOjC2Jy+XnANxtciH4TLAqcmexvePomh1YCeWNPFD8cxJmHmXf09mKK+2o9etBYr
         mVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uI1TPeuSd92UbPS5N8KX6krfL9bLASM56BYU9fb4POc=;
        b=fHsqy35bU3aGpMEwx0lJp6Sh9YDl5bFEgIvTbuYODGbkQOb6opI4MoNWGvd8XGt2gs
         RwR3aSZUUSp5LC6TdnvDF8rqhcrAx9KBrtCzGJuwERDDcfC5H0/JBaF21Exq5iqKM8te
         SvrupdMWJeix9hGLtA86IVTCrNSRUK70PnzMqG4S77fjlfyHLkh0ZhbrtmOZCssAuW7Z
         4SmZSsQcDSw2dmQVAFCQJR+FweotVDwTYVrZLHeYqxwT6Lp4HvkXrzflMDXpJV7GIGaP
         LC1s5zWIZ0NzTnT8feyFxQH1UtzlDS4KnIzT5r+H4aDV7VwNEBUpNnQZqDVmqTi9kVRc
         z+SQ==
X-Gm-Message-State: APjAAAWUhGeh+P5myC9ZFj9nef+FNniyqyUEWfAYK+jBppkZ0RjE67k3
        jCqqmd8V/ogBK9samq9ZuS5Q4A==
X-Google-Smtp-Source: APXvYqwawStzIwou/O3xsYrAU5aPquQ94myNiyOSNQU3EYzZCpIHUF8OmPh0kwyflIJZ2LrFUHDCEQ==
X-Received: by 2002:a81:308d:: with SMTP id w135mr5488572yww.110.1559807825644;
        Thu, 06 Jun 2019 00:57:05 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 14sm316343yws.16.2019.06.06.00.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:57:05 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/4] perf augmented_raw_syscalls: Document clang configuration
Date:   Thu,  6 Jun 2019 15:56:17 +0800
Message-Id: <20190606075617.14327-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606075617.14327-1-leo.yan@linaro.org>
References: <20190606075617.14327-1-leo.yan@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To build this program successfully with clang, there have three
compiler options need to be specified:

  - Header file path: tools/perf/include/bpf;
  - Specify architecture;
  - Define macro __NR_CPUS__.

This patch add comments to explain the reasons for building failure and
give two examples for llvm.clang-opt variable, one is for x86_64
architecture and another is for aarch64 architecture.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index f4ed101b697d..5adc0b3bb351 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -6,6 +6,25 @@
  *
  * perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c cat /etc/passwd > /dev/null
  *
+ * This program include two header files 'unistd.h' and 'pid_filter.h', which
+ * are placed in the folder tools/perf/include/bpf, but this folder is not
+ * included in env $KERNEL_INC_OPTIONS and it leads to compilation failure.
+ * For building this code, we also need to specify architecture and define macro
+ * __NR_CPUS__.  To resolve these issues, variable llvm.clang-opt can be set in
+ * the file ~/.perfconfig:
+ *
+ * E.g. Test on a platform with 8 CPUs with x86_64 architecture:
+ *
+ *   [llvm]
+ *		clang-opt = "-D__NR_CPUS__=8 -D__x86_64__ \
+ *			     -I./tools/perf/include/bpf"
+ *
+ * E.g. Test on a platform with 5 CPUs with aarch64 architecture:
+ *
+ *   [llvm]
+ *		clang-opt = "-D__NR_CPUS__=5 -D__aarch64__ \
+ *			     -I./tools/perf/include/bpf"
+
  * This exactly matches what is marshalled into the raw_syscall:sys_enter
  * payload expected by the 'perf trace' beautifiers.
  *
-- 
2.17.1

