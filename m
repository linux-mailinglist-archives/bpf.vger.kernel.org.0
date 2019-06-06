Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB08C36DEC
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfFFH5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 03:57:06 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46056 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfFFH5A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 03:57:00 -0400
Received: by mail-yb1-f195.google.com with SMTP id v1so588499ybi.12
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2oYBhfvK7ZPiWOEwi/H0aRHGINCuJ9bdzg0oB3t3I8=;
        b=Zh8eNxLVnPty5J/NWX1zW05wsPNNZWyvKzHuwuWPy86z2xqivWNWZM/j/ppvwdeVuj
         LHr3pH8+MHJhMqFcaGS+NbuJHQfZhcdzRIJCurDHb7q8kRkGuflNOqzxt/vecFg++PSn
         lku9coxsyZK+/Fad+hdtdoqKRjenEj9owObNe43aldBYv5qDQacIrU6AIUWtlSgcxm1V
         ToLzsFz2muoT5Z8TnjBEvend61T5l9DlsUVI8H9NrDbweLlHWqtnAyJxCmrfOjsiWSuB
         gSsZIDeK80kz4W7cPKSQ3KXiza/hZnKz8+xW0p6i4AWH65z/VmBKL08y5YaV/tPZXqkQ
         nQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2oYBhfvK7ZPiWOEwi/H0aRHGINCuJ9bdzg0oB3t3I8=;
        b=gtngn8jc/kkrC87E8Aoc2O4ZEcfx4ZTELpCjVDpox5+rG9bwbJGFQhLq9pcY1JeaXg
         4BMyw3YdO8yV2UqfWJRS59Qr4pl7qlqCN3sN1zJVrY2/xMwwwnstpQECVe7R540Zp/X4
         5oKGOSEhbWfNFbeEODT5TZ9sX+x2IiUgvcpclysImiE2Kr0fGvqGieSQXXDaR9Yt84zu
         JI9URW+G1ZwlqK16/PBc/wt2Bj5e39Eo7pUPKVUSwXvhC157nh7rMc0MbmgqL1OUJRAl
         x09ca9jJT07Q8kZrY+yedw8rULT/4EbHGC3QLwV5Wn/8twdwH6IXTZNBWzlvuP5tJSZ/
         /wEQ==
X-Gm-Message-State: APjAAAXkBq1BOHFsfZ4ob1AvqNI4fdyyNwF5vyTkIpjTF3txi0liST5T
        vY0AWi+W3+g15g5OUXtPVv41Hg==
X-Google-Smtp-Source: APXvYqz7Po+W5FooKy6Uj799RsupY9ZIZ6Five50fE4OPPlLJlLdoL5iA5N58AlbdYHCmsOeC9WWmw==
X-Received: by 2002:a25:6b46:: with SMTP id o6mr14097845ybm.392.1559807819058;
        Thu, 06 Jun 2019 00:56:59 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 14sm316343yws.16.2019.06.06.00.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:56:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/4] perf augmented_raw_syscalls: Support arm64 raw syscalls
Date:   Thu,  6 Jun 2019 15:56:16 +0800
Message-Id: <20190606075617.14327-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606075617.14327-1-leo.yan@linaro.org>
References: <20190606075617.14327-1-leo.yan@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds support for arm64 raw syscall numbers so that we can use
it on arm64 platform.

After applied this patch, we need to specify macro -D__aarch64__ or
-D__x86_64__ in compilation option so Clang can use the corresponding
syscall numbers for arm64 or x86_64 respectively, other architectures
will report failure when compilation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 5c4a4e715ae6..f4ed101b697d 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -45,6 +45,84 @@ struct augmented_filename {
 	char		value[PATH_MAX];
 };
 
+#if defined(__aarch64__)
+
+/* syscalls where the first arg is a string */
+#define SYS_OPEN               1024
+#define SYS_STAT               1038
+#define SYS_LSTAT              1039
+#define SYS_ACCESS             1033
+#define SYS_EXECVE             221
+#define SYS_TRUNCATE           45
+#define SYS_CHDIR              49
+#define SYS_RENAME             1034
+#define SYS_MKDIR              1030
+#define SYS_RMDIR              1031
+#define SYS_CREAT              1064
+#define SYS_LINK               1025
+#define SYS_UNLINK             1026
+#define SYS_SYMLINK            1036
+#define SYS_READLINK           1035
+#define SYS_CHMOD              1028
+#define SYS_CHOWN              1029
+#define SYS_LCHOWN             1032
+#define SYS_MKNOD              1027
+#define SYS_STATFS             1056
+#define SYS_PIVOT_ROOT         41
+#define SYS_CHROOT             51
+#define SYS_ACCT               89
+#define SYS_SWAPON             224
+#define SYS_SWAPOFF            225
+#define SYS_DELETE_MODULE      106
+#define SYS_SETXATTR           5
+#define SYS_LSETXATTR          6
+#define SYS_GETXATTR           8
+#define SYS_LGETXATTR          9
+#define SYS_LISTXATTR          11
+#define SYS_LLISTXATTR         12
+#define SYS_REMOVEXATTR        14
+#define SYS_LREMOVEXATTR       15
+#define SYS_MQ_OPEN            180
+#define SYS_MQ_UNLINK          181
+#define SYS_ADD_KEY            217
+#define SYS_REQUEST_KEY        218
+#define SYS_SYMLINKAT          36
+#define SYS_MEMFD_CREATE       279
+
+/* syscalls where the second arg is a string */
+#define SYS_PWRITE64           68
+#define SYS_EXECVE             221
+#define SYS_RENAME             1034
+#define SYS_QUOTACTL           60
+#define SYS_FSETXATTR           7
+#define SYS_FGETXATTR          10
+#define SYS_FREMOVEXATTR       16
+#define SYS_MQ_TIMEDSEND       182
+#define SYS_REQUEST_KEY        218
+#define SYS_INOTIFY_ADD_WATCH  27
+#define SYS_OPENAT             56
+#define SYS_MKDIRAT            34
+#define SYS_MKNODAT            33
+#define SYS_FCHOWNAT           54
+#define SYS_FUTIMESAT          1066
+#define SYS_NEWFSTATAT         1054
+#define SYS_UNLINKAT           35
+#define SYS_RENAMEAT           38
+#define SYS_LINKAT             37
+#define SYS_READLINKAT         78
+#define SYS_FCHMODAT           53
+#define SYS_FACCESSAT          48
+#define SYS_UTIMENSAT          88
+#define SYS_NAME_TO_HANDLE_AT  264
+#define SYS_FINIT_MODULE       273
+#define SYS_RENAMEAT2          276
+#define SYS_EXECVEAT           281
+#define SYS_STATX              291
+#define SYS_MOVE_MOUNT         429
+#define SYS_FSPICK             433
+
+#elif defined(__x86_64__)
+
 /* syscalls where the first arg is a string */
 #define SYS_OPEN                 2
 #define SYS_STAT                 4
@@ -119,6 +197,10 @@ struct augmented_filename {
 #define SYS_MOVE_MOUNT         429
 #define SYS_FSPICK             433
 
+#else
+#error "unsupported architecture"
+#endif
+
 pid_filter(pids_filtered);
 
 struct augmented_args_filename {
-- 
2.17.1

