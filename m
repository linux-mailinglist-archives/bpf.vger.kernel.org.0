Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAD4BC838
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 12:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiBSLiT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 06:38:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbiBSLiT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 06:38:19 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0E48E45
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:38:00 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x11so9121458pll.10
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W8/uMm/yePwUax8PTgNxj8Upo9G0EV9CAtamuh101aU=;
        b=Ulzq87OPp4Isjk01FOHx0Ec46nXaambUsUqFdYkvRc/qaK1uvDtFgJRkg1NZJMjKOA
         K4NWRuGyq+0Uw6XeYqNJnVQaN7XJtXk1lmgIdVNBS4SIwoi0g7qINHLL87ivm1lt4/LJ
         D0WPfQggqW+2RlwrGjFWRAv3oN5zZnF+ZsgKrnavr1l18N9gnCU57hIpkrpf4RkLsilt
         wBkptqynVn6OmGfJDnne7dh2kNTOx6WloQtqW+wfKzH+wEpAXBiWTaaa9UdX9x5/Kbw7
         us4YYusCUCE8fpHnU3xpl3+Ls9Wu1CFKtPhaSRcG3eMf0usu6b6S4/ca+ci4WCZzXsmS
         G27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8/uMm/yePwUax8PTgNxj8Upo9G0EV9CAtamuh101aU=;
        b=3950VKFWn1u4NBWZhoOqFtlhVpLJljeAw9ixyHwdOhkkxSZvfSJygmoAVc6Rfs3Ksi
         HiIp7HnZ1b03XEftvkoRuypZwTnFqQr+3H1mJ6eIL4qTxhQsIX13GsxRddkZ9KD6ALB4
         gWTJEkDBCiedjhfQvl0KbQVnReBKhTQlEgTxN2aRc0RdJH7jxmsHCTOcz1tvhQ6zA9Ls
         h0YVY1w40Pd4/EWtBFSCySOuDU/SV96+5fMmHithAYasz1KlpgWtX9cvHfxouB+sJk9I
         B2lyjnBAgVSvI0h89Bv9IkcYvJB8VO5fjHWxuINu6qq2L4uDZSi548Qxv3T0JdVBNvPd
         VXjQ==
X-Gm-Message-State: AOAM531yXI8BSZbvQNABLu14qzzg9T+J6qGhjFj7hrKqyqYyM5ZZnCt0
        46JN9LeZhTv9ylzRzIT9PWkRD1Q/K3w=
X-Google-Smtp-Source: ABdhPJxlF4YwYEJo3//rXhGKu6qe86gGOnnWApmzsMjZhMH9NEwLyLHMMOaahdgKjCL/bjsPoHPfGg==
X-Received: by 2002:a17:90a:8048:b0:1b9:55dd:b72d with SMTP id e8-20020a17090a804800b001b955ddb72dmr12572526pjw.90.1645270680056;
        Sat, 19 Feb 2022 03:38:00 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id k13sm6674129pfc.176.2022.02.19.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:37:59 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v1 4/5] selftests/bpf: Add selftest for PTR_TO_BTF_ID NULL + off case
Date:   Sat, 19 Feb 2022 17:07:43 +0530
Message-Id: <20220219113744.1852259-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220219113744.1852259-1-memxor@gmail.com>
References: <20220219113744.1852259-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; h=from:subject; bh=aDFN3hYw6lKlFeFeVPPfGXY2lA4mXjxanbHB6TECqbQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiENZ6xlDoxjSMxZ72D7eH1Uz57Fk2spGFEYg+KhtL 7JEp9LCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYhDWegAKCRBM4MiGSL8RyixdD/ 99WbRztzjlp7u3Jyb9taosPp4aElBvIyjTzdnIcF9iX218s8yZEdopW/+/XHKEi55Nh9vnA5Rr0ekY zgO1rQol5dbyeE2/z7FXua9oO3L1M4TO3/r2EW1NcW4OEi1/E1dvk/IUPqeaFHuwmh2syzwSrUgr5f p5dh7u54mkHKJehnuXHd2dLPebnDfw7M5jbuAnaWcTLhJvb3021HcJ7MnnSYTvbCHlyMr8KBHA7kwy vFmthvba0FFozckh+SF0HFeEyC7DdX0dN4hRBrfRAqCcwNbrhsA6+u4Om/eZfs35xeDzg0eNh7EWw6 2+N8DzfnpZ6eak+hOVqV57YKj1YDTfjHLdtNRiLrbNWRI0LlFwj5f4jozmkctziK3ruqnlI29Eo9u1 DW2sFdn3PY7K7qSQwKpq/WE+0x8HgT1BzyQ/ux9H78bYPpPstWCKumR4JW/9ylLtl6mbVz7P46SlZ5 6a0H4YUKfxBl1OCFv1BHU5c8qubrw9ufm1DVZXVvEIWvwC4zqQ9l6kbO8+xVMUjIZ28xvJFsDTVvPN LozpkjggOQT+KMkA02X+CoNx5qIzKCkqsR9/OBl8iOsaH0lE2AZfNz6vEk1zxxCR1zHcevL7s41sOk F+2ZNpVucwZy2uhZy/gpXvPTVcuTJjfjutMdCePZszvCL5O59oMtNCth+Feg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While at it, also try breaking bpf_sock_from_file, since it doesn't
check its argument for NULL in the first place. With our fix, both
shouldn't crash.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/d_path_crash.c   | 19 ++++++++++++++
 .../selftests/bpf/progs/d_path_crash.c        | 26 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path_crash.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_crash.c

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path_crash.c b/tools/testing/selftests/bpf/prog_tests/d_path_crash.c
new file mode 100644
index 000000000000..b1ee705d2108
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/d_path_crash.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "d_path_crash.skel.h"
+
+void test_d_path_crash(void)
+{
+	struct d_path_crash *skel;
+
+	skel = d_path_crash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "d_path_crash__open_and_load"))
+		return;
+	skel->bss->pid = getpid();
+	ASSERT_OK(d_path_crash__attach(skel), "d_path__attach");
+	close(open("/dev/null", O_RDONLY));
+	d_path_crash__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/d_path_crash.c b/tools/testing/selftests/bpf/progs/d_path_crash.c
new file mode 100644
index 000000000000..a4b1a8b200f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/d_path_crash.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+int pid = 0;
+
+SEC("lsm/file_open")
+int BPF_PROG(lsm_file_open, struct file *file)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+	unsigned long *val, l;
+	char buf[64] = {};
+	struct file *f;
+
+	if (current->tgid != pid)
+		return 0;
+
+	f = current->files->fd_array[63];
+	bpf_d_path(&f->f_path, buf, sizeof(buf));
+	/* If we survived, let's try our luck here */
+	bpf_sock_from_file(f);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.35.1

