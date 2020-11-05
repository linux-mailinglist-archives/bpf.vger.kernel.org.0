Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901552A8A3F
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 23:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbgKEW6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 17:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732493AbgKEW6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 17:58:39 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2211C061A4D
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 14:58:37 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k18so3152515wmj.5
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 14:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kutD/q+xVupSFcvYOVJRfZWueeRA7xbNvILSb9eee7Q=;
        b=O0UaKdb831VJd35rDCAIsQGLZIeemuz8R8J+bq3zj8tBa3eJZm83/8SAfpGy3na6r+
         3P7feCGyz5dkFyQ/jqUqZsfAAmv7MVINeujsI3BjzeqjOimKyIuoJ8UFcz3/8PGbq4rZ
         HGJLSAmIduXqL7YNxniqdhSTb5NeOvhHNkBXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kutD/q+xVupSFcvYOVJRfZWueeRA7xbNvILSb9eee7Q=;
        b=ZPKjSHFchNB8PrVFtMMtpIvRCas+vbnSLlRpFVs1UKUxTnQQFxlJfq5UpgMJSzUYpH
         L7xVcLS/wZrim4qqiYwJ0TuAPDsuJW9GacJuhQpOQcdJnYs8NoNCV1eYQSzHt3Oly57b
         FVaz+PnGoyn6LVbA8P43LvHl4lGCKoRACpY/pxKQDnxHVAYB7JrpkKngg90C5TKXHX2W
         SPJCTCWbuaKmtxZqfJbR1dSN6jkV0y1IFKVLL3eYuvrC3y2uyB6mzF4wjghNWGGaZv80
         QlyuT2gCpv0iqid6IFF4IYXqSWLBVnSFPIHK6RUihXX35eZXEyttpa3vgNzD7A1SA/Bz
         cMBQ==
X-Gm-Message-State: AOAM530FRHDXFYk3jYZZGXbHJXmYVc65jAFwbUXsJuZnr2FO+U3Z4oxI
        uch3x/hzkNLTyy2xhoUvz7VG/g==
X-Google-Smtp-Source: ABdhPJySlj98bQuFKZYByvbxDUgqoiMpk7JGnYvcVwRUZaDRfrljallgbZJNGIDdfKfbErd15d9fzw==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr5118625wmj.89.1604617116690;
        Thu, 05 Nov 2020 14:58:36 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f19sm3977366wml.21.2020.11.05.14.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:58:35 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v5 7/9] bpf: Update selftests for local_storage to use vmlinux.h
Date:   Thu,  5 Nov 2020 22:58:25 +0000
Message-Id: <20201105225827.2619773-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105225827.2619773-1-kpsingh@chromium.org>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

With the fixing of BTF pruning of embedded types being fixed, the test
can be simplified to use vmlinux.h

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../selftests/bpf/progs/local_storage.c       | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 09529e33be98..ef3822bc7542 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -4,9 +4,8 @@
  * Copyright 2020 Google LLC.
  */
 
+#include "vmlinux.h"
 #include <errno.h>
-#include <linux/bpf.h>
-#include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
@@ -36,23 +35,6 @@ struct {
 	__type(value, struct dummy_storage);
 } sk_storage_map SEC(".maps");
 
-/* TODO Use vmlinux.h once BTF pruning for embedded types is fixed.
- */
-struct sock {} __attribute__((preserve_access_index));
-struct sockaddr {} __attribute__((preserve_access_index));
-struct socket {
-	struct sock *sk;
-} __attribute__((preserve_access_index));
-
-struct inode {} __attribute__((preserve_access_index));
-struct dentry {
-	struct inode *d_inode;
-} __attribute__((preserve_access_index));
-struct file {
-	struct inode *f_inode;
-} __attribute__((preserve_access_index));
-
-
 SEC("lsm/inode_unlink")
 int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
-- 
2.29.1.341.ge80a0c044ae-goog

