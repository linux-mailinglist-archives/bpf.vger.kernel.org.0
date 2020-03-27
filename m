Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA33195EAF
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 20:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgC0T3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 15:29:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52249 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgC0T3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 15:29:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id z18so12659263wmk.2
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R06x0mive4StEspSChp8nXo8gNb0lFU1htQmKzctqw8=;
        b=Z7zva+1H9Ng1imInyY27caOwyw10M/swWEMpQ8Mt/HV3BUB/lM080e5kqPFcP/eaHG
         QYVhrR6LeZ3TSB9Ndst735+/YfMRd7ZHauPWZHM14E6UDuQIcCh2+zP2d87Y0vh0xexN
         IUXiTfsOMwkFhwexpe/Nxa8FuGodE/f95Vd34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R06x0mive4StEspSChp8nXo8gNb0lFU1htQmKzctqw8=;
        b=RJrKBW/JqYOMfmRCmN6rPWIAVBxkf0mIJJRpxJOjcl9sjZTKMKrXCUDS1vmfey1nH3
         OrZ9kQ9wPdnJjX33fe2x7jm1t621Pq+cxebbGrCa/4MJXthIz9is74Pf/2z+Lt4bXfZ/
         ZuARQNZZnro3ue2v4Xshwsv9a9fPyhV1gHuxEbgZW/e1OCIq4WLWrL3cLvro/bhoFPCM
         GCHkbPh01MNiFj++pNDPK+XhI3c2C4GDynL0i8zYQTjelG01kOCxKybpkkG+7CyFn9Uy
         k85fiq4i+PoMEKuZAAcHojmA/uJkPLQ+nkLbKZw+k1qy+mZIioDIyewsiiKBVVQzXX/d
         kkmw==
X-Gm-Message-State: ANhLgQ0bC57GgcPGJ07q+IMh9c9+20VPS+69gUwlf6hytWsLbQeVBMXX
        uq/gHaBcgflwoWcZQY7lzquj7Q==
X-Google-Smtp-Source: ADFU+vsURyzyLHsYKVKSarKoYYkz4RkDde+olmwWaEXzivFrIaIwr/kh4Yuwm/+7Oys2J37oKItZtw==
X-Received: by 2002:a1c:1dcf:: with SMTP id d198mr255524wmd.121.1585337341148;
        Fri, 27 Mar 2020 12:29:01 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id h132sm9828537wmf.18.2020.03.27.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:29:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 3/8] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Fri, 27 Mar 2020 20:28:49 +0100
Message-Id: <20200327192854.31150-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327192854.31150-1-kpsingh@chromium.org>
References: <20200327192854.31150-1-kpsingh@chromium.org>
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

