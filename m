Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADC2A6A23
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgKDQpI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 11:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbgKDQpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 11:45:07 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706BFC040201
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 08:45:06 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id oq3so28844300ejb.7
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 08:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kutD/q+xVupSFcvYOVJRfZWueeRA7xbNvILSb9eee7Q=;
        b=UR/q/Nn1X/y65cTeJfdgWYcCtSKQyBLclIjrztWUIvvPunynakU3O6KgHQNspU42Ck
         owF7m5lCaKXa/Vscp/JlS7bbQZlqobpKty25OyiAAJ/TjZTCgSnR23XCE2vSFrsZFLzs
         0S+5Z+3zYW0Cua6bsQQbtq1IswVI4BU6spRCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kutD/q+xVupSFcvYOVJRfZWueeRA7xbNvILSb9eee7Q=;
        b=BrWVUYF1OOweET5CKZ7scJVaMepK6AtYGJYK59vfgFrpuE8oHnYJtkv9k4oWVvP5mC
         LnJpllA0dmcv21rHweYSIIRSBjZYPAHw5fWgUQIp+vUzBDR6Z9xEnDVExKfzGpNvuaeq
         eVsKIfa8nu5qvMCN3DMOCGdSSZbsfJ/h6LvzU1A4syweFvWq0t9s4YaD0ZcEmjJmRNB7
         ghGyqeva3ktQeum+LreUQFFCALW7I0lOVqPdeuxZDaCweXo+T38kdk5EbMrlBOxDh7bk
         NC81ihzDb9x9IjwetY7SLjyftsRzec9Xtapn1QveZJF8eEpizeDMBMM4CIBjZuP5fAP/
         VATQ==
X-Gm-Message-State: AOAM531I1qMQ8YV70+wVSVdS/NiKgI36vsOCWnpq6l17EAFpU4oW5RbJ
        NosNgIW1UJp3YiZFKJxa6Xcxwg==
X-Google-Smtp-Source: ABdhPJyRDdmq7NWXYAFlGH/uNx7rCU+Nk5gt4kpw6GcPQW7WBnSgC9XU+K7b8rZFJVarcBuNWnXjBQ==
X-Received: by 2002:a17:906:1643:: with SMTP id n3mr25456761ejd.459.1604508305184;
        Wed, 04 Nov 2020 08:45:05 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id g20sm1283551ejz.88.2020.11.04.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:45:04 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v3 7/9] bpf: Update selftests for local_storage to use vmlinux.h
Date:   Wed,  4 Nov 2020 17:44:51 +0100
Message-Id: <20201104164453.74390-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201104164453.74390-1-kpsingh@chromium.org>
References: <20201104164453.74390-1-kpsingh@chromium.org>
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

