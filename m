Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7798718FA40
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 17:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgCWQpA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 12:45:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45622 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgCWQod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 12:44:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so13267862wrw.12
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlA7urqMw8mKHvI9rDt37xMzrwfcfL0wKrtQ00PyQpc=;
        b=Is/fLBhXkfsoYTWL+rb7nbgKjQZDSHeREiaENX/ryr1Klw/wT/paImg2ZmlmRU0LM+
         ye/muNgE3Jxcw0uJbW0K2yyK5O8Xv+MkovtpqtVyRzdBCIVq49/Rd6tRgP1cSIBIpK3h
         G0DKJOPlqTSzhRvHt99l0hw3zeL0nmEbFCjMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlA7urqMw8mKHvI9rDt37xMzrwfcfL0wKrtQ00PyQpc=;
        b=hK9yPWHKNU9x+DAb7q23hPHvqkZSqpSah1jCsu/6sPPFnAZm7KbbI0VjEaTuZAs99s
         l00knxQU1iHVBSL9bt+zAliYKifBWpSFm2SkPKlsnxLWkFurOycxYlS8PngBVP7lcUZQ
         FQ2w8V0YHNrxPn/GYctNSMgtxiWYTiD0KO7GRe8vJgxpnN/vV2aQUs8VKVfMr8ehLNth
         mideu9fyvDr5dVimsy1gG+aOS00ecfwyYWLAxV0mxwSgQ1gtu0yl51DGqjpI1WqXsFmP
         /isGEIO3YfAQlBTA0mhH+fnYkA1EzOXyvrx8gJUvpE4gVjTbly6GriHl6yvx1eFDlPCO
         TLyg==
X-Gm-Message-State: ANhLgQ0NTDP/zObvcumW/nFKGwhcF4LaRhfeAVx+NwvKRoQs/hEFXUsB
        FgUiNihgEe51DDsqAKsPIwzeCQ==
X-Google-Smtp-Source: ADFU+vvenfV9RiF6dhaMgXP3eNwDfXU99Q73rNQBjL6pcYXi5tPMuc0G+60g/ixBpbmYqRRFBqeADA==
X-Received: by 2002:a5d:54cb:: with SMTP id x11mr20563706wrv.179.1584981871985;
        Mon, 23 Mar 2020 09:44:31 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id l8sm199874wmj.2.2020.03.23.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:44:31 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Mon, 23 Mar 2020 17:44:11 +0100
Message-Id: <20200323164415.12943-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323164415.12943-1-kpsingh@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
generated for each LSM hook. These nops are initialized as LSM hooks in
a subsequent patch.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
---
 include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
 kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/linux/bpf_lsm.h

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
new file mode 100644
index 000000000000..c6423a140220
--- /dev/null
+++ b/include/linux/bpf_lsm.h
@@ -0,0 +1,21 @@
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
+#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK
+
+#endif /* CONFIG_BPF_LSM */
+
+#endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82875039ca90..530d137f7a84 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -7,6 +7,25 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/lsm_hooks.h>
+#include <linux/bpf_lsm.h>
+
+/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
+ * function where a BPF program can be attached as an fexit trampoline.
+ */
+#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
+
+#define LSM_HOOK_int(NAME, ...)			\
+noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)	\
+{						\
+	return 0;				\
+}
+
+#define LSM_HOOK_void(NAME, ...) \
+noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
+
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK
 
 const struct bpf_prog_ops lsm_prog_ops = {
 };
-- 
2.20.1

