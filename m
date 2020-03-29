Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6957C196A50
	for <lists+bpf@lfdr.de>; Sun, 29 Mar 2020 01:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC2AoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Mar 2020 20:44:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33857 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgC2AoF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 20:44:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id 26so13039409wmk.1
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2020 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R06x0mive4StEspSChp8nXo8gNb0lFU1htQmKzctqw8=;
        b=PMY8KHelbwaNa5xYBYDcWyEk94/0a2gh2tMn0Q3NqQjOr84u0kOMBhjAZJvXfucvnD
         7kq5k5vcsQrc/xL4Ugpec9xTSjW+xkYonCBlU3FutlOy50av8YXw+YRL6J3j+SjfPaGL
         +CZeRoYm+WJGtT7lztYXA5+rfTbl+Tb7evYVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R06x0mive4StEspSChp8nXo8gNb0lFU1htQmKzctqw8=;
        b=VzEPuByd6iinurUJO8my38aiGQVdX3vx9zV+FSiq4uMaYN61nwS3r0tI7s2tCwWShH
         tnesxwuZ8KlSOfsvWxpLJ4qh7kD6dJknHJecLJWzyfwGa1hkMDg40xyOVjqSO+vje6nj
         qPcE3He+JTWJih+RgUlo9hbxZxv8hhCwimJ/8xWuDMyOnTJVClAjwm55/VDSkheWkKFd
         h4iN0XyIuw80+p24PN28mRSJweUojT9WpiAkSb8JaKkFCYjenGLE6RMCr6kBwtABHEo0
         V98Pm6FIeE4UOfWigK0tah6qlN6DF+ZA6ggdgutuSO2hJLQkDONhC8Aw8TAWhCUZ9Epa
         iXjA==
X-Gm-Message-State: ANhLgQ2cP5rp79ZyAwaHKLesp95nc42F5/KsbGYGCGgcWHjMIZCobVca
        N9vT6PvjTtQ51zSypXTG4JD9nw==
X-Google-Smtp-Source: ADFU+vsyGkhX3SOTyLgCNzb2toTt7FNMiXNaSN34rKBoCi4LpY6Cqns9hhN73YF/13ZQuL/6iRJ14g==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr5831470wmj.15.1585442643969;
        Sat, 28 Mar 2020 17:44:03 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id e5sm14577647wru.92.2020.03.28.17.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 17:44:03 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v9 3/8] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Sun, 29 Mar 2020 01:43:51 +0100
Message-Id: <20200329004356.27286-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200329004356.27286-1-kpsingh@chromium.org>
References: <20200329004356.27286-1-kpsingh@chromium.org>
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
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
index 82875039ca90..3b3bbb28603e 100644
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
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
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

