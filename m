Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6083EC81B
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhHOILg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Aug 2021 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhHOILf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Aug 2021 04:11:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B10C061764
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 01:11:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c4so1071772plh.7
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MkCILxGuJCwqHg7ABo3XTVe/ZdxanaPmoWR94Pi54zY=;
        b=gUY7TBfMd+K9PP8LJiA4DJ8DJR17yArPi41Afx2ZP49ZtMOY/OSH9R9ThX7J+M/qna
         oN312R+C6HJs9SE06Xhs1bUR4tRwa6Yv+w2RCVkHvQkq+1DOyCTTbUhcC5wWv69HCVfb
         ZU23jH7QiBSI+p5XyORBtgo0QxF8MCQXTatKcnrh1vt5P4Yco+ZtdUCEKcsXC5+EW6wv
         0Y/el6W08u9+G3GkRWyNOTw4YoL3EGfhLOhMkNIAV48QzajTOAViDvKDJR2GEz/pvMBJ
         OQANlIZx8JWC5sgP3+xSzCEuGawpJ0dqv/D2xSLVrybC6Wd+4+qyPDaYOFck1gfWYaJm
         K9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MkCILxGuJCwqHg7ABo3XTVe/ZdxanaPmoWR94Pi54zY=;
        b=WC7dUz9YpNxg3+le9Asff/ccKNHivnYAcmGtJQOFjGp7vW6zAxgsLoP8/uj6h5gbn6
         4RAAW0/7PBnYBCRYSrgr8yNf5kntawSRINhzS4dX6tPvnabV1B8Ijq9Sdk8fjj1aRh/J
         zDQZcE5OR0lqv40oAh3hbSDHjF2fsDQYm7PESHHSAmOW/OzxAK2664XGivhwLE+m4Dmy
         M4pAY0MouA8ORuUjJCwpuQgozeWxuloQcrOi7SiUsQHB9voeOb7ih7bVDalNjWRNmmlz
         gCjGePcI3z2yRBOSLs+69gIeSk+qRAeidMtsTSiRVvk6aBtnfHdlxsgs9w/2APDvaLLH
         ByPQ==
X-Gm-Message-State: AOAM531NzrVJMzK2CfaBBoSCIfQMc0mD5Ux9R8dycydSUvtxJ+QkQTpX
        h9cqCMKzkpQ6MpBvN4mxW5/llpxYSY0=
X-Google-Smtp-Source: ABdhPJyMx2fNz0phNfcHg5bC2uiBXtUpMtc30bulP4TRATNAV5vj3wSkmSnVQKDYxUKQFe4YDZYNEA==
X-Received: by 2002:a63:1952:: with SMTP id 18mr10196138pgz.15.1629015065424;
        Sun, 15 Aug 2021 01:11:05 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id b190sm9144970pgc.91.2021.08.15.01.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 01:11:05 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3] selftests/bpf: Test btf__load_vmlinux_btf/btf__load_module_btf APIs
Date:   Sun, 15 Aug 2021 16:10:35 +0800
Message-Id: <20210815081035.205879-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test for btf__load_vmlinux_btf/btf__load_module_btf APIs. The test
loads bpf_testmod module BTF and check existence of a symbol which is
known to exist.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_module.c     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module.c b/tools/testing/selftests/bpf/prog_tests/btf_module.c
new file mode 100644
index 000000000000..2239d1fe0332
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module.c
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+static const char *module_name = "bpf_testmod";
+static const char *symbol_name = "bpf_testmod_test_read";
+
+void test_btf_module()
+{
+	struct btf *vmlinux_btf, *module_btf;
+	__s32 type_id;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
+		return;
+
+	module_btf = btf__load_module_btf(module_name, vmlinux_btf);
+	if (!ASSERT_OK_PTR(module_btf, "could not load module BTF"))
+		goto cleanup;
+
+	type_id = btf__find_by_name(module_btf, symbol_name);
+	ASSERT_GT(type_id, 0, "func not found");
+
+cleanup:
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+}
-- 
2.25.1

