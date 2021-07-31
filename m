Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B689C3DC651
	for <lists+bpf@lfdr.de>; Sat, 31 Jul 2021 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhGaOdS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Jul 2021 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhGaOdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Jul 2021 10:33:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E6FC0613D3
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 07:33:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso18535880pjo.1
        for <bpf@vger.kernel.org>; Sat, 31 Jul 2021 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8waAPUBBhE73M4k8JLkClONjUvvZERERntzJH0x7kc=;
        b=QviQMjL3u51xB2iny40UXAsjBm5GyOa9RQQqwlp3QGWeisPYPTjZxRa3tOsj9rSmk3
         owDf+6c8XylF43tlFyV2fU1gpxLetNCRJ6SfWyfc8z89jBw3wGAzdsNc6FKDal6JWIyf
         OKMMB1EsO0BNaLQOvb6nV/5e8YZZPIeTtkqV2DQgMg0IuNEanxT9eMUerAuBwS/J9nP7
         aEqxM/w3cqZmifGNb+KBsC8J9xjkOZ5F87wIWrYkdLV1+0cz5Rli2lWxEGwcN2m79Nr2
         Cn8cHnNxghh23NspZu5COu2KFe+pLOC/Bt6ooDjM0z+BOwUsEHXIpTrN6407ycEZmMx+
         rcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8waAPUBBhE73M4k8JLkClONjUvvZERERntzJH0x7kc=;
        b=rm0kPGFXALd9h4OVFsFM3iqFErtFtxeZuT0Jq76zffTE6kAsR17woWtt7Etz/fiw/u
         X+JhuH69yHLYCHLO60XxaMOZXHLFRsl9bYoz3fiFpei+g3ZEE94XBhvQpQDYRCIGdXux
         VHTfWLBq+O6tzUBbCZisH2S1lX2gqDiAGiPt5jmCuMVKbw0zAkawqroUPjO7jKqVZVZn
         jFS+Clx2/65Z/qngrAiLf457j+em/bGGBzLMbg4khx9pkOn3R4Nr0TKmic4faI2NCmQv
         AzuS6mP5RBiHd//PzWMl3XwWUlHzFnjcykZ3U8DGakhFb0gxODv7IKcLIBIKPg0G0Vs9
         6nyw==
X-Gm-Message-State: AOAM530JL2F4xR8N0agPoubpE3MlZf44RHaByBymoXw1HalhAL3wXWbJ
        MPxm9EW7OwF/wFUIqJn5hcMpFHXMh/YiVw==
X-Google-Smtp-Source: ABdhPJyev52wHqRvi3huxUqphzEk6E6r8YARQxkYPFXYEZ2k5Aulqh4mMDzBM01HqJZekE6iMfXWrg==
X-Received: by 2002:aa7:838a:0:b029:3b7:31a5:649c with SMTP id u10-20020aa7838a0000b02903b731a5649cmr835161pfm.44.1627741990547;
        Sat, 31 Jul 2021 07:33:10 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id k5sm6219594pfu.142.2021.07.31.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 07:33:10 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH] selftests/bpf: Test btf__load_vmlinux_btf/btf__load_module_btf APIs
Date:   Sat, 31 Jul 2021 22:32:44 +0800
Message-Id: <20210731143244.784959-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test for btf__load_vmlinux_btf/btf__load_module_btf APIs. It first
checks that if btrfs module BTF exists, if yes, load module BTF and
check symbol existence.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_module.c     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module.c b/tools/testing/selftests/bpf/prog_tests/btf_module.c
new file mode 100644
index 000000000000..cad1314e3356
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+static const char *module_path = "/sys/kernel/btf/btrfs";
+static const char *module_name = "btrfs";
+
+void test_btf_module()
+{
+	struct btf *vmlinux_btf, *module_btf;
+	__s32 type_id;
+
+	if (access(module_path, F_OK))
+		return;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
+		return;
+
+	module_btf = btf__load_module_btf(module_name, vmlinux_btf);
+	if (!ASSERT_OK_PTR(module_btf, "could not load module BTF"))
+		return;
+
+	type_id = btf__find_by_name(module_btf, "btrfs_file_open");
+	ASSERT_GT(type_id, 0, "func btrfs_file_open not found");
+
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+}
-- 
2.30.2

