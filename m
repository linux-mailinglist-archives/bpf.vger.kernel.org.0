Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618E926BE58
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 09:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIPHma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 03:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgIPHm2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 03:42:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DC7C06174A;
        Wed, 16 Sep 2020 00:42:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q4so1130173pjh.5;
        Wed, 16 Sep 2020 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjUD0F6XmJJIFT5UAlzkPPx1enPEzZw4LiZfY+PSTUk=;
        b=bLL86q+ZcOR1A4VJ1duYRTdx6XqB66Wn3Xygvjuss1rMYTIezkiOVlB04WJS4wprxK
         czipKQk+YDFnf+SKMSJ/ccEzZ/ZIAfFVPgpLWG1EHWU9Xh1+ViF2F9t8kdYCCNPJqAQ8
         9e+2m/8YKK2E/VNqjidKWHZkxc/KRxvw57jSTQHnyCzoWit53U3pznQLmAqBOoAA8UUw
         44idV0N1OS814TFucxiZUh5wBsveHanKCQD0o3eb/A6CWCUWHItAVK70tImgIeRoZJIS
         vnSISoKxNfD5AMkS1YgCiUd9tCQitEjB1Cc2T0sLC8brqfDTU4JqXgMUzOF5KtAhAiJq
         Vc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjUD0F6XmJJIFT5UAlzkPPx1enPEzZw4LiZfY+PSTUk=;
        b=PBKZOZhzpBGh25Fyv6ffYDkhp4mCqGiVMGzM2NVanB7l/flRpmoW00sZMcY/KfjgpP
         hMMAMmxymzBogeeWbVV2DKqKyprT4y6Ag+Q53okKLlRls8QKW0uUHXD6ngppc30kk9HY
         o4HV86WMlOBJmYqq2bqu2gfPRVc0xAMHdD/2pZn3AgyuLlFyQ8VjDvVasj1kpKn5PmBb
         MD+vdRaNvmpmKvZuck943WrJbfvymOQNfkoP99eGLDzI57aZ0PkqIFQ2APVpNVAR0hVR
         wM0csq1RL/ZGcHP0D7ItDOQVVERf8Afuji6cykWAaNM2k/Q4MvysTcmTyY8hma1b8y42
         NT5A==
X-Gm-Message-State: AOAM531zRg+MvW/PQqvC45Bzf9rASVyZKQCFAYF5V/7IqJc0yQSAf5jG
        pKm/lBkVLHYknvtrFDM+SiE=
X-Google-Smtp-Source: ABdhPJza/sEXEDVNzVMlUYOQCWVI82fWeZ5KduXPTQK59ttTaEQQZILDfaf521IzMVIQ75m1GsSstA==
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr2817089pjv.94.1600242147868;
        Wed, 16 Sep 2020 00:42:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:e92d:10:3481:f05e:64c3:d2bd])
        by smtp.gmail.com with ESMTPSA id z127sm7393152pfb.34.2020.09.16.00.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 00:42:27 -0700 (PDT)
From:   Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Tony Ambardar <Tony.Ambardar@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Subject: [PATCH v1] powerpc: fix EDEADLOCK redefinition error in uapi/asm/errno.h
Date:   Wed, 16 Sep 2020 00:42:14 -0700
Message-Id: <20200916074214.995128-1-Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A few archs like powerpc have different errno.h values for macros
EDEADLOCK and EDEADLK. In code including both libc and linux versions of
errno.h, this can result in multiple definitions of EDEADLOCK in the
include chain. Definitions to the same value (e.g. seen with mips) do
not raise warnings, but on powerpc there are redefinitions changing the
value, which raise warnings and errors (if using "-Werror").

Guard against these redefinitions to avoid build errors like the following,
first seen cross-compiling libbpf v5.8.9 for powerpc using GCC 8.4.0 with
musl 1.1.24:

  In file included from ../../arch/powerpc/include/uapi/asm/errno.h:5,
                   from ../../include/linux/err.h:8,
                   from libbpf.c:29:
  ../../include/uapi/asm-generic/errno.h:40: error: "EDEADLOCK" redefined [-Werror]
   #define EDEADLOCK EDEADLK

  In file included from toolchain-powerpc_8540_gcc-8.4.0_musl/include/errno.h:10,
                   from libbpf.c:26:
  toolchain-powerpc_8540_gcc-8.4.0_musl/include/bits/errno.h:58: note: this is the location of the previous definition
   #define EDEADLOCK       58

  cc1: all warnings being treated as errors
  make[5]: *** [target-powerpc_8540_musl/bpftools-5.8.9/tools/build/Makefile.build:97: /home/kodidev/openwrt-project/build_dir/target-powerpc_8540_musl/bpftools-minimal/bpftools-5.8.9//libbpf/staticobjs/libbpf.o] Error 1

Fixes: 95f28190aa01 ("tools include arch: Grab a copy of errno.h for arch's
                      supported by perf")
Fixes: c3617f72036c ("UAPI: (Scripted) Disintegrate arch/powerpc/include/asm")

Reported-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
---
 arch/powerpc/include/uapi/asm/errno.h       | 1 +
 tools/arch/powerpc/include/uapi/asm/errno.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/errno.h b/arch/powerpc/include/uapi/asm/errno.h
index cc79856896a1..4ba87de32be0 100644
--- a/arch/powerpc/include/uapi/asm/errno.h
+++ b/arch/powerpc/include/uapi/asm/errno.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_POWERPC_ERRNO_H
 #define _ASM_POWERPC_ERRNO_H
 
+#undef	EDEADLOCK
 #include <asm-generic/errno.h>
 
 #undef	EDEADLOCK
diff --git a/tools/arch/powerpc/include/uapi/asm/errno.h b/tools/arch/powerpc/include/uapi/asm/errno.h
index cc79856896a1..4ba87de32be0 100644
--- a/tools/arch/powerpc/include/uapi/asm/errno.h
+++ b/tools/arch/powerpc/include/uapi/asm/errno.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_POWERPC_ERRNO_H
 #define _ASM_POWERPC_ERRNO_H
 
+#undef	EDEADLOCK
 #include <asm-generic/errno.h>
 
 #undef	EDEADLOCK
-- 
2.25.1

