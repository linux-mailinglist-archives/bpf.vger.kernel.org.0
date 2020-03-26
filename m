Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB12E194151
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgCZO2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 10:28:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52369 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgCZO2i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 10:28:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id z18so6697427wmk.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j07f/KzJ7k+DtL/yee5b5Abm77tcNc5e4RspF4NSPCU=;
        b=BtzWiqbrA9vNGQNLQ7i3X3lIisoJ70EbTLKoeDKh4ynqtgT20nsgrPep9oRA+ThBNM
         sTgcc7tCvLn4hRroqmFvXPp6LEhv1hJgK+NuDnEQjA6lp2v5QFyHstWBNdC8FrUCfB9I
         r6rtP2+G07yQACHyQB5WQrX9ODsyqva//pSlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j07f/KzJ7k+DtL/yee5b5Abm77tcNc5e4RspF4NSPCU=;
        b=KQ0JqPzy1VmQm1pLXSRzI0bu2jmA/8tBLeBKe6RCbEMltORC+bgD/wYO/djeZsP1TS
         MqaL48wkdVx/yGvRjy0dYfuTPNm01TgafsG/T1H1zrz6sbWJScosXl+fPR2wslWd7Ydq
         j689hT/F4t12i+yp1i55tHe7ByKcBttu/gHqoIyKo0CV+dQs1RZlSgaU8dLjlafEpv3Y
         q1TJG08RTVZCg/5TlLx76+X9HhcxomSFIKgVtwYI9nmJHPmvwAKDWjpCJjeTmQ+IKSHK
         id8il/pkIk3LjqlxH0IjiV0hVJi8+IB66dOAbBkGB8xiNFMm4wFP74cTCDUQvMlTJD3o
         3r9A==
X-Gm-Message-State: ANhLgQ0WIInceR1hMD78dDHzyQUbeLYYisN4d6/vTvFeWyqDyU7tg342
        PdOn7tXugFTfPuNGVkJQlyZBTQ==
X-Google-Smtp-Source: ADFU+vutgl9irGrOWo1Oy+wIUY3Iql7GTMzctB2SxqB93HywTobxHEGn2nZcyEY/OKcK0SkRSb3aRQ==
X-Received: by 2002:a1c:56d5:: with SMTP id k204mr230651wmb.13.1585232916247;
        Thu, 26 Mar 2020 07:28:36 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q3sm3643971wru.87.2020.03.26.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:28:35 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Kees Cook <keescook@chromium.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v7 3/8] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Thu, 26 Mar 2020 15:28:18 +0100
Message-Id: <20200326142823.26277-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326142823.26277-1-kpsingh@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

When CONFIG_BPF_LSM is enabled, nop functions, bpf_lsm_<hook_name>, are
generated for each LSM hook. These functions are initialized as LSM
hooks in a subsequent patch.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf_lsm.h | 22 ++++++++++++++++++++++
 kernel/bpf/bpf_lsm.c    | 14 ++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/linux/bpf_lsm.h

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
new file mode 100644
index 000000000000..83b96895829f
--- /dev/null
+++ b/include/linux/bpf_lsm.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#ifndef _LINUX_BPF_LSM_H
+#define _LINUX_BPF_LSM_H
+
+#include <linux/bpf.h>
+#include <linux/lsm_hooks.h>
+
+#ifdef CONFIG_BPF_LSM
+
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	RET bpf_lsm_##NAME(__VA_ARGS__);
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+
+#endif /* CONFIG_BPF_LSM */
+
+#endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82875039ca90..e43e29690f22 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -7,6 +7,20 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/lsm_hooks.h>
+#include <linux/bpf_lsm.h>
+
+/* For every LSM hook that allows attachment of BPF programs, declare a nop
+ * function where a BPF program can be attached.
+ */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) 	\
+noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
+{						\
+	return DEFAULT;				\
+}
+
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
 
 const struct bpf_prog_ops lsm_prog_ops = {
 };
-- 
2.20.1

