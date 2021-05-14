Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F238012B
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhENAho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhENAho (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:37:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16CCC061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l19so1322519plk.11
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0APCxo42sriASzfTIgsN0pOzQHJUG5OpjcgHrwDifuI=;
        b=SDiQR2A9yDYYu5zEofqMALTpvPibnNRLDaRt6Dp9iZVnSgk03eV3LGFJJ/5puKiEtb
         9j1QjoTdL7zXxcLwl1FwD26ov1ByLXXyKrChyzwfq57LiQFnLeKTD4UKSnL0cxboMPwk
         uG6xK/odFXQXxaw7l99Kcy2NXQUFdEQuJ31bUeZoEUOyMfMMWfoDQtvSCnkRlpATX6Tx
         nnFklyk6CmmuAYStQ5oxE4ggeiPb3Yv1TwgaKwzAtRe1lazyKxXjlG0hy3iD03RfUmsn
         Fup66yNMcSuoAqQEndn7Mzo3dxh7I0FChKeBsDtTfgtEcbPlql24DgjoNm5VYH/ReQVp
         B8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0APCxo42sriASzfTIgsN0pOzQHJUG5OpjcgHrwDifuI=;
        b=m+hT1moz0uY1sscVqzXm1SgDBmRzfPeZP6ecqdKib4lkYyeujDeFHU60UNdGqBIrw5
         qAbH2xrfeNgwEnSpaa8RX9g6PBOiGQrLASWS/121Sc7ytLu9CVoCxVVO+xCx3WZS5WyQ
         2sd8tywssRp6tbdJOeuZSIcBznZGHE2gKdPFbBZX5AG0bfG2WCNrA907Bu6rQf3Kebkq
         0xD3ih2u3Xg81nr9//MtCi+VfTwpXDG93WxQkj16DmfLgvDxRF0lM+EjEQShEPqDT98/
         ANuw4xlPGy3fqx7I5CgD/Ecn9fU/Hkcv1t9l1ixzW45XYTuJfA5jM6lkIZn5Do25mM2H
         zOxg==
X-Gm-Message-State: AOAM531xkDE847oRIFn8fsJ9B93PmsOlubK3g3177enUh7gNfIv4K9ke
        Muo6xVqOFwisXtostCaGliM=
X-Google-Smtp-Source: ABdhPJznPLqZSObDlg/i2jVbqyDqfH8e29ZnVa157p6bloDqe1v0V4tCyvQCsievtrDgbs8VZFxIwQ==
X-Received: by 2002:a17:90a:3041:: with SMTP id q1mr12820pjl.191.1620952592194;
        Thu, 13 May 2021 17:36:32 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:31 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 02/21] bpf: Introduce bpfptr_t user/kernel pointer.
Date:   Thu, 13 May 2021 17:36:04 -0700
Message-Id: <20210514003623.28033-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Similar to sockptr_t introduce bpfptr_t with few additions:
make_bpfptr() creates new user/kernel pointer in the same address space as
existing user/kernel pointer.
bpfptr_add() advances the user/kernel pointer.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpfptr.h | 75 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 include/linux/bpfptr.h

diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
new file mode 100644
index 000000000000..5cdeab497cb3
--- /dev/null
+++ b/include/linux/bpfptr.h
@@ -0,0 +1,75 @@
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
+		return KERNEL_BPFPTR((void*) (uintptr_t) addr);
+	else
+		return USER_BPFPTR(u64_to_user_ptr(addr));
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

