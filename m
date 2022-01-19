Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7316493AE3
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 14:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354689AbiASNMy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 08:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354629AbiASNMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 08:12:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ACBC06161C
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 05:12:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 188so2585627pgf.1
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 05:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVhBlQ6BqPBOEVuhkNMnDPjKekiyjTuVmHKgmvjqM1g=;
        b=VItzWtleMJti3aG1obM5A3hyYMxlMmBwfv4//I/FaRyLVst06GW+RV4SOxf2gU9jSr
         l7Vqs5K1igTLp/uzOXz1igNy51XyhGKrjxNAS/1e2AMsNn268ZoPtR3RqNHq3qcA0Zyh
         T+YLb7GNdZntDSyPK7BCQVxdk7z2R30jQkNLCwQnD9K6vF357q3IFJ/NErrpdUzrHLCl
         tUbKHZ3zzHxLK5ZdOCsSBZNk/ZH3vsaTXAb5sXIgkehIICFpylG9U5gx2ceZGri9Eso8
         HwYm2mGl7KRI8RnYBqsfItTwXk912z6iGK3ax84V4D4N+Vf6Yk3mfA7cdl2n5pzz2k2K
         sPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fVhBlQ6BqPBOEVuhkNMnDPjKekiyjTuVmHKgmvjqM1g=;
        b=w7WB2r0Dx8zv71YNqLQ22fmUT6bLB2UpAC9BTadU3yXukGz91KnGKNzhAbqjiTf+hM
         XlQQvFd1lQznX2tZ025kxUm+ARuCXe0AmwAzgTOylf+Gd93EPz0kY5Gyh0vC+CR8eBBr
         XehogmxfgTJg73fCsEI/2Rf5b+CNnEnf7N/id8PaJyX1VnCG1hdrVNW1lHs20bu3jeSr
         5fyoSJMCiYT/zSN5brbc0CL4Zs5iUB29poFeyTnQ+zhb9ZmCAhh85+qjkymaxcrobgQD
         Y2WRJfuSpN4D7AP1ilNXqAUrd7m8o/i/q7/eTIbzn2mQFB6wnY7Jo4zQZorb244797xf
         ygew==
X-Gm-Message-State: AOAM530NX1Gu8aYorQ1aTrOC36yxQdMOmQ3iascB+ZuKXxlnCTejYL/p
        JSC5oAj/2HP52sqXKIReXtI=
X-Google-Smtp-Source: ABdhPJx0EV2PZY5+P+qoq31SHHCBwR3nI8OXYP3uP5d4OK3W53mp7q8+Ug9GYzkSG0rxZMKWfhsIAQ==
X-Received: by 2002:a63:8bca:: with SMTP id j193mr27008854pge.227.1642597973120;
        Wed, 19 Jan 2022 05:12:53 -0800 (PST)
Received: from ktada-Stealth-15M-A11UEK.. (fpa446d38e.knge002.ap.nuro.jp. [164.70.211.142])
        by smtp.gmail.com with ESMTPSA id v13sm3603208pjd.13.2022.01.19.05.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 05:12:52 -0800 (PST)
Sender: KENTA TADA <kenta.tada.s@gmail.com>
From:   Kenta Tada <Kenta.Tada@sony.com>
To:     andrii@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH v4 1/3] libbpf: Extract syscall wrapper
Date:   Wed, 19 Jan 2022 22:12:07 +0900
Message-Id: <20220119131209.36092-2-Kenta.Tada@sony.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119131209.36092-1-Kenta.Tada@sony.com>
References: <20220119131209.36092-1-Kenta.Tada@sony.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extract the helper to set up SYS_PREFIX for fentry and kprobe selftests
that use __x86_sys_* attach functions.

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 19 +++++++++++++++++++
 .../selftests/bpf/progs/test_probe_user.c     | 15 +--------------
 2 files changed, 20 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_misc.h

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
new file mode 100644
index 000000000000..0b78bc9b1b4c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BPF_MISC_H__
+#define __BPF_MISC_H__
+
+#if defined(__TARGET_ARCH_x86)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX "__x64_"
+#elif defined(__TARGET_ARCH_s390)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX "__s390x_"
+#elif defined(__TARGET_ARCH_arm64)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX "__arm64_"
+#else
+#define SYSCALL_WRAPPER 0
+#define SYS_PREFIX ""
+#endif
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
index 8812a90da4eb..702578a5e496 100644
--- a/tools/testing/selftests/bpf/progs/test_probe_user.c
+++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
@@ -7,20 +7,7 @@
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-
-#if defined(__TARGET_ARCH_x86)
-#define SYSCALL_WRAPPER 1
-#define SYS_PREFIX "__x64_"
-#elif defined(__TARGET_ARCH_s390)
-#define SYSCALL_WRAPPER 1
-#define SYS_PREFIX "__s390x_"
-#elif defined(__TARGET_ARCH_arm64)
-#define SYSCALL_WRAPPER 1
-#define SYS_PREFIX "__arm64_"
-#else
-#define SYSCALL_WRAPPER 0
-#define SYS_PREFIX ""
-#endif
+#include "bpf_misc.h"
 
 static struct sockaddr_in old;
 
-- 
2.32.0

