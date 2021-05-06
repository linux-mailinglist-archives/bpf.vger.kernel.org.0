Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8200374E0D
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 05:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhEFDqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 23:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhEFDqK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 23:46:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A48C061574
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 20:45:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d10so3755522pgf.12
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 20:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nwc5XWdKz5jG+SAGsD0OMALB7sp2qsIR5lQRCTO9YJs=;
        b=OJgWP9DlAiWztSj3XxxV3ESLNLPEci0gfq1Oo/MBUxm7wB+UrGSW8b+58GiQs6JwFJ
         L/UvCKCBUG1qII0K7n9fTNYwuylFiJbpppcXZ0C7G4YiQZVo7e3Jc5Jum28DJ3hRAlzm
         pOCqVTV9fOEOAmU8sGecV+hoNR3CU9tseaiiislLOjm4sRLAdkW3q8gtwS8GAq2F1eKp
         7zYjmSxkdFCQxrtMDX56+87k+GTvb/WpZNbLQ3HdsHinT/nCafhang5/v+Cdaqlz9R7u
         mo5RAQG7mGh+MucbJdh7HcP6aUGuwwmmnnsbKiEkR77H7R287tTHzG4QJUCRIxXlQI1H
         AR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nwc5XWdKz5jG+SAGsD0OMALB7sp2qsIR5lQRCTO9YJs=;
        b=d5dY7+RztpOfiHvP4nMsNMz4P/EDuY5rGxsVn5jUe8DvoT08V4c/Oj3YA05ATInlVn
         9IqTz4C2aVO0jte8KnY3PeyjMPuFqd2GkuvmXNNBWffMSSQGeL7AHp3q3TzWPFYIgixp
         JwP1odExjX4174OuhZMEkuRFvLcCfZbC3czmo87AW5cWm8QaxUK9E/BdPKqZbRjZRBPJ
         uU2VbmNAPsf+TafA7WBI8w3rqP1sLwBO66lXDDB0aFix4iKojPpeaJa1Xb5m46+ZTbh2
         +lbJdkl/QV4WoWoppnUVvV5+qLmjQNBg6v6yYaK6OlILNjbf+hNGrQ3QITTWnDuRcp2L
         j6kA==
X-Gm-Message-State: AOAM5318m0CnJOCJ/oU2i/vGEFXraDXbtMCFR+OPq6n3JMaeRESJSL3b
        NGct4OA7epT5ZFc2qkVJ+z4=
X-Google-Smtp-Source: ABdhPJzefxG/Z8U0aL9rVc+t3fDpEkoW1Qy8NfUtRRXdW2sagPBYE5AiVfUs/u198lA9hDy2lPxfhA==
X-Received: by 2002:a05:6a00:706:b029:217:9e8d:f9cc with SMTP id 6-20020a056a000706b02902179e8df9ccmr2393260pfl.1.1620272710388;
        Wed, 05 May 2021 20:45:10 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r22sm578997pgr.1.2021.05.05.20.45.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 20:45:09 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 02/17] bpf: Introduce bpfptr_t user/kernel pointer.
Date:   Wed,  5 May 2021 20:44:50 -0700
Message-Id: <20210506034505.25979-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
References: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Similar to sockptr_t introduce bpfptr_t with few additions:
make_bpfptr() creates new user/kernel pointer in the same address space as
existing user/kernel pointer.
bpfptr_add() advances the user/kernel pointer.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpfptr.h | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 include/linux/bpfptr.h

diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
new file mode 100644
index 000000000000..e370acb04977
--- /dev/null
+++ b/include/linux/bpfptr.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* A pointer that can point to either kernel or userspace memory. */
+#ifndef _LINUX_BPFPTR_H
+#define _LINUX_BPFPTR_H
+
+#include <linux/sockptr.h>
+
+typedef sockptr_t bpfptr_t;
+
+static inline bool bpfptr_is_kernel(bpfptr_t bpfptr)
+{
+	return bpfptr.is_kernel;
+}
+
+static inline bpfptr_t KERNEL_BPFPTR(void *p)
+{
+	return (bpfptr_t) { .kernel = p, .is_kernel = true };
+}
+
+static inline bpfptr_t USER_BPFPTR(void __user *p)
+{
+	return (bpfptr_t) { .user = p };
+}
+
+static inline bpfptr_t make_bpfptr(u64 addr, bool is_kernel)
+{
+	if (is_kernel)
+		return (bpfptr_t) {
+			.kernel = (void*) (uintptr_t) addr,
+			.is_kernel = true,
+		};
+	else
+		return (bpfptr_t) {
+			.user = u64_to_user_ptr(addr),
+			.is_kernel = false,
+		};
+}
+
+static inline bool bpfptr_is_null(bpfptr_t bpfptr)
+{
+	if (bpfptr_is_kernel(bpfptr))
+		return !bpfptr.kernel;
+	return !bpfptr.user;
+}
+
+static inline void bpfptr_add(bpfptr_t *bpfptr, size_t val)
+{
+	if (bpfptr_is_kernel(*bpfptr))
+		bpfptr->kernel += val;
+	else
+		bpfptr->user += val;
+}
+
+static inline int copy_from_bpfptr_offset(void *dst, bpfptr_t src,
+					  size_t offset, size_t size)
+{
+	return copy_from_sockptr_offset(dst, (sockptr_t) src, offset, size);
+}
+
+static inline int copy_from_bpfptr(void *dst, bpfptr_t src, size_t size)
+{
+	return copy_from_bpfptr_offset(dst, src, 0, size);
+}
+
+static inline int copy_to_bpfptr_offset(bpfptr_t dst, size_t offset,
+					const void *src, size_t size)
+{
+	return copy_to_sockptr_offset((sockptr_t) dst, offset, src, size);
+}
+
+static inline void *memdup_bpfptr(bpfptr_t src, size_t len)
+{
+	return memdup_sockptr((sockptr_t) src, len);
+}
+
+static inline long strncpy_from_bpfptr(char *dst, bpfptr_t src, size_t count)
+{
+	return strncpy_from_sockptr(dst, (sockptr_t) src, count);
+}
+
+#endif /* _LINUX_BPFPTR_H */
-- 
2.30.2

