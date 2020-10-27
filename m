Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D19C29BF9E
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 18:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1815656AbgJ0RDv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 13:03:51 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37285 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1815592AbgJ0RD1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 13:03:27 -0400
Received: by mail-ej1-f66.google.com with SMTP id p9so3291422eji.4
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzzUDsidrUC7RWDOol9n2PVflwyj7TpsFpUs6H5wqJA=;
        b=arItqxgk/9qAZij7+w4t2K4qnzeonxHSGtMsdEcN1VWM0eGu//+/5vezf7J97mobGz
         QDpjF+dXBZ/heCAzn4xOmjhbPgZATE0zoDG4W2nd7ZH33TSBgC7vp6JqQ9webblx60Nu
         17pLacCP6vh253pUL46jRoCXH+k6hhbR9C53E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzzUDsidrUC7RWDOol9n2PVflwyj7TpsFpUs6H5wqJA=;
        b=GhPLvS/qVaMpMIonvmFxeOoMMTyNk1cSXmeTrrq91i1BSThdAVEhOAAuHQOMz6aTzO
         qg05EcxlsABIXP12nindk8vFDgXlGBEItGLiGwjl6HzGcGbH88k4rNFlol0m8E574UTM
         sJqSwDPDZBR7Y4ih6Z7Vklk08idjHINIaCR6ZrltwTNO+TYdVDPD0jCZOCmlCKmlJXPA
         YoND61elqeKp7034ez9jn7pijjMA1Rqi4p20EtyPCQSH7aw78SSwAaAivokidzUQTPto
         apXiXdjjzIqnbopPKT8/zCD5MRdj6SvGh3sB5RnkGuIQr25nrZDQOH/aqLXWSoLgS7HQ
         8L+Q==
X-Gm-Message-State: AOAM532Wa8TzDddPkbu47XTgHUbX4arlMPJE9i1qiI/40snDNKWZRdKB
        nWXfsdGIKvbXbAxY/onU9hmUsg==
X-Google-Smtp-Source: ABdhPJzsrVgb1Oxm1IFy4IfZF2gSTGB4bJE60+0bDIScSo64rTssL7rGffuf23uUypG88/PcsvTvZg==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr3203290ejz.97.1603818205481;
        Tue, 27 Oct 2020 10:03:25 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id ba6sm1315006edb.61.2020.10.27.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:03:24 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 4/5] bpf: Update selftests for local_storage to use vmlinux.h
Date:   Tue, 27 Oct 2020 18:03:16 +0100
Message-Id: <20201027170317.2011119-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
In-Reply-To: <20201027170317.2011119-1-kpsingh@chromium.org>
References: <20201027170317.2011119-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

With the fixing of BTF pruning of embedded types being fixed, the test
can be simplified to use vmlinux.h

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../selftests/bpf/progs/local_storage.c       | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index a3d034eb768e..5acf9203a69a 100644
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
2.29.0.rc2.309.g374f81d7ae-goog

