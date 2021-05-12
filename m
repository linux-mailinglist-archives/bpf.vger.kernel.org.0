Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA037EF23
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhELW7T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 18:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344614AbhELVnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:43:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DDC08C5C3
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s20so13226720plr.13
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0APCxo42sriASzfTIgsN0pOzQHJUG5OpjcgHrwDifuI=;
        b=OZy4mXyUo7trxwBY4pl3OfZhR7o1GgOBmSqhltI1VYHt5Ak3WkzKB3/Q2vDnFgVkx8
         Y4uimZxQU4q5OfNIhsHrri4TmDdN7BPck+lUmo11azs4rusF96oh0rDks3c9G5TyAGHB
         9zWeZd/d1nWL41gYb+Dw5TyhcXyYb4pdGSlSqsRoT3KzgWEnqNdRJNZf8w2mX5FIMKie
         e3vtDrNjIm2z3WWuKy+x9kWdsVc8Xg0pWbBHUHP5Og+fCwZLaUW7WyIkWL0yM9FNFcaU
         YyLSAc5/+GjgIIGv+QNT4NMm90vnBNbiVkLIgoJ7MCYz7ajHLAGtnnpfhly390sRBGFs
         9psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0APCxo42sriASzfTIgsN0pOzQHJUG5OpjcgHrwDifuI=;
        b=GKvSKYKWzvzrE/IhEhqiVFNj50h3QV5HB3SlgSlYod6kff+cAti9rsp2o1qcLCZa5M
         CAgGG+khPsLj8jnshFIxKpfvTXJqyjdaC/gUvbq8zzSm5k3RsxAuPuTNCuQaO9cvg+7O
         Dpho3f9rtrkWtaAp8YRv4N+tDQeJwUs4s9tsN0hVMnd0T0XPMJCH5W9KN/33BaM7ZPj7
         XiEbH/VBDoKpAbm/dq6XzygG5UUx5kaC/x1xEJZSbibkDcqKzAeLWwp07qV+sw5qca/J
         CRWBznFvBR3oBJ24goyQ+OsJ8z35ft2Oi8Bv5/zl39cDH/yETF0mEEpLE4yF/l8NV2cF
         9kRQ==
X-Gm-Message-State: AOAM533eqKsddUDO79sNFUeaJH75qW6t/YoS+bPEUac7upR4/acnrgUF
        8iN6UuCNvX6H4U36Mg5ckbg=
X-Google-Smtp-Source: ABdhPJxWidqv+iCnRorPQ1vAcSitzg7KOfxCGFgzQeXKp/VFGuMbiqeQHTtg1gsou5DUN+x+PesC3A==
X-Received: by 2002:a17:902:8205:b029:ee:aa49:489b with SMTP id x5-20020a1709028205b02900eeaa49489bmr37835132pln.5.1620855183963;
        Wed, 12 May 2021 14:33:03 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:03 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 02/21] bpf: Introduce bpfptr_t user/kernel pointer.
Date:   Wed, 12 May 2021 14:32:37 -0700
Message-Id: <20210512213256.31203-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
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

