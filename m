Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FBD2CCDD4
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 05:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgLCERB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 23:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgLCERB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 23:17:01 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C63AC061A4E
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 20:16:21 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id n9so375495qvp.5
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 20:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgW4X2iCaSYw98VUpDq6aeDlPG5HqYjAxBk44d1Z5bc=;
        b=Gzr4ha3Z5MzFwzRKt1pXo8niNXRADuRcDdXa05/nWSz1WzqivZGUZZqcvqZ+cqgAwi
         X+pGEJQHLFAHa1WrSdvGXLQ/whlQtc4H2FMQK/7msIAtNzVO43sEB5QqRqzW24Ovh0UM
         V6YhV5AcJjR9/ju+8NyaNHfx2HIUo8EpCsgdIY0/Y7vGj74mHCwIHnSydunQ5uLoGb63
         HwK/5CaDO9qe+FY7k/bsJy4WcDJDCI89LNbobe+U/izfFQ7M24atx97p2jgm7tgMkBBZ
         Jai8e+FrMnto2WR7v5Np/VVFsQcRwgDllY4R2G53/OsQobNw5EhLeDzz8rGhtV3h9/0f
         QTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgW4X2iCaSYw98VUpDq6aeDlPG5HqYjAxBk44d1Z5bc=;
        b=Y26zxCwmt2uByaaZFChl/Ny/hVe4k3KB5sNWvwY4NlEz4X5iFHUvoDLdVGcDYMv7x+
         ewM+iZCDtf45LMx4AUFHZsbynjLb7kbdAG/eZFy4ZAQh6y0HEDBFAs8WEfU6ixNNd7gQ
         dIXspGwWdKq8nudl0gwy7gEXZL44fSYXgLej8cyTLJnBdc93/Lye7FrCVINzzkC3Ifw5
         ISddBKeAOVVdLvq2kMSB5TV4jz+QSQNR0ytc5PBD8fztjhoAZz+ohifmr2akUssNvjNC
         DjxQd54z09QBjky/B18OVFFA8FvBZo7cin+uxAZszg99FLyp7y4z3V5eCWC0dG2T3sH5
         VbXg==
X-Gm-Message-State: AOAM532m+GUeIU44OCcJhwE6K6tViRXtI5P9G+LK6hkNKzOfXU08mBT5
        On6YQqgrc4Ude2FDWq4j6Ejq5u7Yta28Hg==
X-Google-Smtp-Source: ABdhPJx8Rz22TfOiNbgjXNeJ27JEfPzacd84jTRrhDsMzBmqMJT97vlGyuE3GIHcAQLpHKDndSYo0w==
X-Received: by 2002:a0c:b3d6:: with SMTP id b22mr1317206qvf.10.1606968979815;
        Wed, 02 Dec 2020 20:16:19 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id n9sm1376440qti.75.2020.12.02.20.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 20:16:18 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v2] libbpf: fail early when loading programs with unspecified type
Date:   Wed,  2 Dec 2020 23:15:58 -0500
Message-Id: <20201203041558.52055-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before this patch, a program with unspecified type
(BPF_PROG_TYPE_UNSPEC) would be passed to the BPF syscall, only to have
the kernel reject it with an opaque invalid argument error. This patch
makes libbpf reject such programs with a nicer error message - in
particular libbpf now tries to diagnose bad ELF section names at both
open time and load time.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
v2: address Andrii's comments

 tools/lib/bpf/libbpf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 313034117070..44a3fe6ef9e5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6629,6 +6629,16 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	char *log_buf = NULL;
 	int btf_fd, ret;
 
+	if (prog->type == BPF_PROG_TYPE_UNSPEC) {
+      /*
+       * The program type must be set.  Most likely we couldn't find a proper
+       * section definition at load time, and thus we didn't infer the type.
+       */
+      pr_warn("prog '%s': missing BPF prog type, check ELF section name '%s'\n",
+					prog->name, prog->sec_name);
+		return -EINVAL;
+	}
+
 	if (!insns || !insns_cnt)
 		return -EINVAL;
 
@@ -6920,9 +6930,11 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 
 	bpf_object__for_each_program(prog, obj) {
 		prog->sec_def = find_sec_def(prog->sec_name);
-		if (!prog->sec_def)
+		if (!prog->sec_def) {
 			/* couldn't guess, but user might manually specify */
+			pr_debug("prog '%s': unrecognized ELF section name '%s'\n", prog->name, prog->sec_name);
 			continue;
+    }
 
 		if (prog->sec_def->is_sleepable)
 			prog->prog_flags |= BPF_F_SLEEPABLE;
-- 
2.27.0

