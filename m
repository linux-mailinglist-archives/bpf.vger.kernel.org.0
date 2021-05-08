Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF70376F31
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEHDtq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEHDtq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:49:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23DFC061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:48:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t2-20020a17090ae502b029015b0fbfbc50so6534529pjy.3
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nwc5XWdKz5jG+SAGsD0OMALB7sp2qsIR5lQRCTO9YJs=;
        b=XHDGtO6ThS73hy5r3lTVUnTdFA9eHcXN0de0UzN1V6f0Cphd33TGtA7dAUgQ2kSkXD
         Z3AODx80pnP1fGpyUBXbhtR3KhSxRm7KP9uPigMvaKAT3VHJsypUIM5QmreoB6tpmYJ9
         88YE2TqItTL0hFZUptwuCb37ac+RBaxdii3CyQ+s5rQN60w05iGZKM0VyLBB939AXKvH
         xK8PrfMzAHkuqVB/L+Q3xpYyW0mOTOQ0/KVHTsn77QvFjk0dlFY//bLWvrTUcDqIaCKg
         ZtuJP9+aLf9evfUBXNvLqfJKuK3Bq1vAOvHXGiQLHMyVs58GvWtd/XSDVBTWL865tiWM
         zwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nwc5XWdKz5jG+SAGsD0OMALB7sp2qsIR5lQRCTO9YJs=;
        b=o69VP5HqWkTcco0If5lSFOM++GN63EVjrPoHV7csCIaOgBQMx3rI8N/8pX2K+eP7qM
         JO88kncK+pYFug4ZJeAxRNOrcWQnuGfAGA5EGZOpfGlfcVc3PTcmC1cOJTRMlZ+EgSTg
         QCzGhdik56N5rWpyEdYwmbO1lGPi4UXkXj2Evvqj0aZX5dtykQjWj6vD2fGwsNHHAxs4
         Qw1x/2Hz+ZF7gfRTwjnXnnps8UfQt/jysVUWk5X9Voz0Iujo2YknzznaEYUyTS88GCR/
         oF8yaNXh1fUyrbdR+K9r4RIFtm05Nns3nsOGXx2xQLDRNS9sCrDLgJKVOgZRPyOcOCdb
         sOGQ==
X-Gm-Message-State: AOAM533ACb8GQyTqv/B8ADntu9jc8NIp7GfhrZyfK32beCyW+h43B3bs
        ZKv92lKjYIPNGvkhGZCuetk=
X-Google-Smtp-Source: ABdhPJw4lyJ/BcCdwSpVjb4S/w6iXUwuhzjmL8izMzBWnR/XwIgtyh1B6ISIR4XV6MWSdrN1t+uEIA==
X-Received: by 2002:a17:902:6bca:b029:ee:b72c:5585 with SMTP id m10-20020a1709026bcab02900eeb72c5585mr12950736plt.46.1620445724376;
        Fri, 07 May 2021 20:48:44 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.48.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:48:43 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 02/22] bpf: Introduce bpfptr_t user/kernel pointer.
Date:   Fri,  7 May 2021 20:48:17 -0700
Message-Id: <20210508034837.64585-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
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

