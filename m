Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7DC192C59
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 16:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgCYP0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 11:26:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40475 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgCYP0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 11:26:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so3161957wmf.5
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gr2YowP7xZurwhXRmAY/lGUCfPPt09BjXH0RtGSlGeM=;
        b=jOtKOWyTFlnI/HR751jZDGLmFII6PtQqnMWGGc6Kuplu+oLGGOyoVx/n2KE9AEXfa7
         S7Q8DjwzxNI5Dfx0qEYkavRH2hNu9bmEzzUZFSVfmmJw1Ox0SZ3iel47ilMw1cLL+ETj
         R8OXrs1soxud01CII8flpnkTsDNk6QMVRbGkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gr2YowP7xZurwhXRmAY/lGUCfPPt09BjXH0RtGSlGeM=;
        b=fqN7Szl/nY8U8c1JpsgD78lxARDGzb5UxoO1XM0LMJ527nS0WeZkhUaV6EJo2d1jK2
         pBvJ095uOh8j8l2bYTPBkKB6k6wm7Ueq4Ouu0EgVlIr6id63jc219l333nqQ6Tx7pNmL
         rdOK/jH2lBP0c2Dn8vSkd10pYf03ejWMPiZ+NLDDIFoB+N+8VYoEpKqSnW5KWnDwW5Vt
         U7rOdQEBwbZA6ydO0GeRhKHkVDSR6enOWFp6WhTHnvLUqoBI6md3sNc6uNgNjanFsvBT
         oeS7wWXgx8JJGoFoXO2Xyy8rc9lYorlBcDQ//78CL4+7z3zLzeVOdDNOYKCXsMSm/74B
         wQwQ==
X-Gm-Message-State: ANhLgQ3/SjhAvdqOalvmaX8TIzFDytj6bM4hDvDRv3MSqwq9q9RZlsox
        8wrb707Kcnog/ZgsMpo8p8/A2A==
X-Google-Smtp-Source: ADFU+vvy259BxeGiK8c7t1ayuKqsAgNDwtV6vzhjuhUBg/FiqUoeBqmrE08UcneZC4pHHld1lJDKpw==
X-Received: by 2002:a1c:df07:: with SMTP id w7mr3820469wmg.7.1585150000943;
        Wed, 25 Mar 2020 08:26:40 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a2sm4033701wrp.13.2020.03.25.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:26:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/8] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Wed, 25 Mar 2020 16:26:24 +0100
Message-Id: <20200325152629.6904-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325152629.6904-1-kpsingh@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
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
index 82875039ca90..1210a819ca52 100644
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
+noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)	\
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

