Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB032A814E
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 15:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKEOsl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 09:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbgKEOsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:07 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E88C0613D2
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 06:48:06 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q3so1542530edr.12
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 06:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kutD/q+xVupSFcvYOVJRfZWueeRA7xbNvILSb9eee7Q=;
        b=VG7qNYYUemOQM8KbZ3/dUVwfn72Hqs5J7y6AJmEDztdBwPqUmWs3ZeD2UVkyKFen1s
         8Y9HKIL/3ilRGzicWr+BGhk3w20lWNyTamIE+0Quj62rTjJbmMWlQ0i8K3waYQ6IhUOo
         dBrX5eciJELbMWRqQNrtH/IFOv9x28rlUw6sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kutD/q+xVupSFcvYOVJRfZWueeRA7xbNvILSb9eee7Q=;
        b=iTnCL0Qj2CHIiCZ+I7iMrqHWEivBXesVYgRSYUeWCbin6z56ALZI7RvDoljyrl6fn4
         H7Hu/CxgRVX6bCH+W1EYWOCEx9F24ge38HSK/VefmOvbh6x84/r+xNnJwkrZqwMa1kF6
         eRLhPzfGIbRP1wicskDK1FljKKUx7sZ7E0Rcl3Lk7NF3pEF+LjdjShJsO2cqS9N+Dl74
         jULOuk5WsYznTmKA1Nw3sy8hDOE8lpVh9WWMXeYQHvAD1/1ZEhV+FtOxRRlc5glr69c/
         86T1xDkKqeSYBVrMmFMPBEfxE2rZAdHPrZOfYxEHfG1GsrIjeNEXKZ57awgvGvD5O9cd
         j/bQ==
X-Gm-Message-State: AOAM530CwQ9SBdyDk7A2uWx8+/SDxNzfvmRxy7arSyY0yQOM8b74vq3y
        pQvraZsCG4KMoBrD48xUyglEmg==
X-Google-Smtp-Source: ABdhPJyM6SD6455KtwDo3hL5u7kXEsIr3C+GquEQ5o2m+Y/bQHaP6JHKTwmIaYQFsfE2gizQUcO1fg==
X-Received: by 2002:a05:6402:a57:: with SMTP id bt23mr2821967edb.62.1604587685433;
        Thu, 05 Nov 2020 06:48:05 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id z13sm1075870ejp.30.2020.11.05.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:48:04 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v4 7/9] bpf: Update selftests for local_storage to use vmlinux.h
Date:   Thu,  5 Nov 2020 15:47:53 +0100
Message-Id: <20201105144755.214341-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105144755.214341-1-kpsingh@chromium.org>
References: <20201105144755.214341-1-kpsingh@chromium.org>
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

