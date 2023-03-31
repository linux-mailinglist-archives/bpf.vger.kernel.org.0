Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE106D1C70
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 11:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjCaJc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjCaJcf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 05:32:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37F1DF9D
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 02:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40E89B82DB3
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 09:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9F6C433EF;
        Fri, 31 Mar 2023 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680255132;
        bh=wzuEiTIMzvjsnnlVEq3YrTr3kfF165Yyu73HHn/E8D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6EoH6ohj92Iajy5nvxqKtG4OJVltJDPfkf85Rr2Mf50MIjrwScqBQzZxG/nNi0BU
         FZWIQ7NFMlheNQXzA+MLyTh8JOALhhiUxwMt9IqNCPDdZ/cOMDWMFmacHOXI6IJBSB
         iQc+wUX+RYwwx4gTW98QG6WO3gFbVbUKtwO4TyrGe2D1qpmFnSPWFsKvm9mSli4bYP
         yeMO/jhpIxlrNVwgrrQCIywAheIC+OFuxFz+HynGJUpWIzTevc7gbpZia2zXovroMC
         EMsMuAJMAp3CyuveKrRlT9dkfZPvS87gUS08zhkiltehnYr1nvg3+1q/Wd1yhW27om
         CMeuJ6XGgJKPw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 1/3] selftests/bpf: Add err.h header
Date:   Fri, 31 Mar 2023 11:31:55 +0200
Message-Id: <20230331093157.1749137-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331093157.1749137-1-jolsa@kernel.org>
References: <20230331093157.1749137-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving error macros from profiler.inc.h to new err.h header.
It will be used in following changes.

Also adding PTR_ERR macro that will be used in following changes.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/progs/err.h        | 18 ++++++++++++++++++
 .../testing/selftests/bpf/progs/profiler.inc.h |  3 +--
 2 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/err.h

diff --git a/tools/testing/selftests/bpf/progs/err.h b/tools/testing/selftests/bpf/progs/err.h
new file mode 100644
index 000000000000..d66d283d9e59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/err.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ERR_H__
+#define __ERR_H__
+
+#define MAX_ERRNO 4095
+#define IS_ERR_VALUE(x) (unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO
+
+static inline int IS_ERR_OR_NULL(const void *ptr)
+{
+	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
+}
+
+static inline long PTR_ERR(const void *ptr)
+{
+	return (long) ptr;
+}
+
+#endif /* __ERR_H__ */
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 875513866032..f799d87e8700 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -6,6 +6,7 @@
 #include <bpf/bpf_tracing.h>
 
 #include "profiler.h"
+#include "err.h"
 
 #ifndef NULL
 #define NULL 0
@@ -16,7 +17,6 @@
 #define O_DIRECTORY 00200000
 #define __O_TMPFILE 020000000
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-#define MAX_ERRNO 4095
 #define S_IFMT 00170000
 #define S_IFSOCK 0140000
 #define S_IFLNK 0120000
@@ -34,7 +34,6 @@
 #define S_ISBLK(m) (((m)&S_IFMT) == S_IFBLK)
 #define S_ISFIFO(m) (((m)&S_IFMT) == S_IFIFO)
 #define S_ISSOCK(m) (((m)&S_IFMT) == S_IFSOCK)
-#define IS_ERR_VALUE(x) (unsigned long)(void*)(x) >= (unsigned long)-MAX_ERRNO
 
 #define KILL_DATA_ARRAY_SIZE 8
 
-- 
2.39.2

