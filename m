Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E6B3DDD14
	for <lists+bpf@lfdr.de>; Mon,  2 Aug 2021 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhHBQGf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 12:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhHBQGa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 12:06:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2012C06175F
        for <bpf@vger.kernel.org>; Mon,  2 Aug 2021 09:06:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a20so20238792plm.0
        for <bpf@vger.kernel.org>; Mon, 02 Aug 2021 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuAmYoVNW8Q1fX1J1Fx9NIdVbte+AF5bJ27mivgP9yw=;
        b=T50/lBRU6oPce5v2MazFxwffQ7nk4fZMmPJJxqluvSGVbSLrVKeiLub0tg4vgAOihq
         nZWusVODXsSBRNbFWrliP2xUCAW9/vsHviJNj1GeUFOqcsYQnsWrnAn7VrQniAJ7dVdf
         fuWD6RFXh8Eh8Ykd0/2T3vlNOTdNoB/zR61xvN3379emk5KloHUIGTANAEzo+1KHpmhs
         saTyDadpU4Z6UYYwiUtwftbka1z8zbSbh8j2oNFr9Yth90rPOBsE8DhFeCX2IqVIy4Xb
         Qa0bbOU4LezEw9CJQno6U490Szd2iFirGSmTYSINQyW91Jae0F1GbLz8BUpz1lQKK7vr
         ao5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuAmYoVNW8Q1fX1J1Fx9NIdVbte+AF5bJ27mivgP9yw=;
        b=S85fdsK7ReSHeEVM5vDVilUXt/zetYh6vnxcnnwJ0WMrZtBCBmcZOcRbFAY5SiMXHF
         gcsILkjFjOEUQHBS599KgY3zVfMLoixCSMxjUa5r6e7eS4/dXYvURx0jhHa6QjVX4qo5
         GMpOz43mciGDqKVusBsVG6/kqmkcgUQyLElKsmLC8TAZh2hhIj3WCiaFxcpSo1W4OnBB
         cjXvUTW1Vu+bLDaxtaF8BNQHZXegYsw0R62bfHbyhzKvg8Xi901GPhWODhojRI8xfOwE
         KLew7gGHLZbCvVHY41crK5pRbDf65FkY2fIOyxBLuNuhGefx4BQRi9YuUomtVktUXudG
         FbKw==
X-Gm-Message-State: AOAM533/o4RSF+SEwahGevL+u8ziyENjQUIYqdFx3prnrygmAOpsgtLU
        d3W/9WLWZ8/LUolSRSRm8q3mRndEAAHKOw==
X-Google-Smtp-Source: ABdhPJyQpzg8qauGGmW9XhFLA1QFpfmXMT5Q/nLIedyRoXkatAU8Mq0Aw8bV60BfVIf/A0Tp7Iapjw==
X-Received: by 2002:a17:902:eac1:b029:12b:8309:1196 with SMTP id p1-20020a170902eac1b029012b83091196mr14234598pld.41.1627920379461;
        Mon, 02 Aug 2021 09:06:19 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id c12sm11763683pfl.56.2021.08.02.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:06:19 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2] selftests/bpf: Test btf__load_vmlinux_btf/btf__load_module_btf APIs
Date:   Tue,  3 Aug 2021 00:05:56 +0800
Message-Id: <20210802160556.1271747-1-hengqi.chen@gmail.com>
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
 .../selftests/bpf/prog_tests/btf_module.c     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module.c b/tools/testing/selftests/bpf/prog_tests/btf_module.c
new file mode 100644
index 000000000000..9314a46e001c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module.c
@@ -0,0 +1,32 @@
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
+		goto cleanup;
+
+	type_id = btf__find_by_name(module_btf, "btrfs_file_open");
+	ASSERT_GT(type_id, 0, "func btrfs_file_open not found");
+
+cleanup:
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+}
--
2.25.1
