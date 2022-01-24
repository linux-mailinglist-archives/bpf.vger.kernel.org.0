Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF15F4981E8
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 15:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiAXOTK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 09:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbiAXOTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 09:19:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E22C06173B
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 06:19:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nn16-20020a17090b38d000b001b56b2bce31so6092591pjb.3
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 06:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVhBlQ6BqPBOEVuhkNMnDPjKekiyjTuVmHKgmvjqM1g=;
        b=mkDhdosuH2liI8zTSi63Hz9jODvmp7+Oa33MLkaNlBi13mUitJ5kMRDK/5TdkDVAT8
         0EpGPCT/bSoof6a0ZvWoFOQdLarVzy/jRcLvlYVAhEY+2rFd+XK7k9Q4e0iMcMjQrWo/
         srgkOjstC1QjDFALbSLC56LD91jQ0buE7BDfLZOz2NR+fea4ve1uEKCdCY5sv8ueIkAJ
         wneiKGD96tgFw4Gq8F9zVPDh4yX4bfi6rL2Rq6KlqwF11i2zaWQwEcu8xtdQnGElBb29
         sMR68jIcG8xk+TbVKazTKsC8jEWMXIoO4uHJEiy29C6zY0juXMk3XSctdmE35tWwm9s/
         poeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fVhBlQ6BqPBOEVuhkNMnDPjKekiyjTuVmHKgmvjqM1g=;
        b=X67KH6JSGQRE8xvXIIY0gWVVpXysU+W0IwCLhW8K3hkP0xPf5FBG5kQ15u/AiSrIby
         wE/zFm2QcfnPGAD8YFXMCVZoOUEMKecDQtLndThrI8dHO3DGHf1G3O1eSmzhZe83Enak
         r77tbPIYRthLtvqBu381JDw0Io2eR5WOPX7t0nTVrIYgbdskekKynQhF4qg0Qd9AX03R
         gp8O18zOMgBKz1rBwKBHQ9m3ivqMHum2NMawA8kp57z59nRr3X6y9JC7/h8qOpr16Tz9
         wlQFLQjbIkGh/T4w9XbMQiWEzIylTVPrWSRMhyBg5W9F4IyWqOi2Y87pMiC6r1+8/AV2
         u17w==
X-Gm-Message-State: AOAM531Hptzm0IT9lRRH8ehFTAnL1X5WLybU51HznpKLp3Jy0iot7Zh4
        thjxlXh5qX2bUVWhm/h9wzg=
X-Google-Smtp-Source: ABdhPJyWwEZgZr7vN6wz6KWF7t+Tnd3brXPY5D08Cv7lcJ6saIL+2Mo4rEmdYc4pQEjk/7Bv2hOuAQ==
X-Received: by 2002:a17:903:110d:b0:149:a833:af21 with SMTP id n13-20020a170903110d00b00149a833af21mr14926910plh.14.1643033948853;
        Mon, 24 Jan 2022 06:19:08 -0800 (PST)
Received: from ktada-Stealth-15M-A11UEK.. ([240d:1a:2e0:8a00:d1c2:4b2a:8ba8:7b43])
        by smtp.gmail.com with ESMTPSA id 13sm15629855pfm.161.2022.01.24.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 06:19:08 -0800 (PST)
Sender: KENTA TADA <kenta.tada.s@gmail.com>
From:   Kenta Tada <Kenta.Tada@sony.com>
To:     andrii@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH v5 1/3] libbpf: Extract syscall wrapper
Date:   Mon, 24 Jan 2022 23:16:20 +0900
Message-Id: <20220124141622.4378-2-Kenta.Tada@sony.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141622.4378-1-Kenta.Tada@sony.com>
References: <20220124141622.4378-1-Kenta.Tada@sony.com>
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

