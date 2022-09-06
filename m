Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C705AEACD
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiIFNox (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiIFNnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 09:43:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9817E836
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 06:37:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bj14so2232182wrb.12
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+OnVpQlgeliEtJDW+k76IyF+cUaA+kRBkYQqfBc1NCI=;
        b=H/Ud2tSAMTumlwbQh8zIdUxFFBynBEGZOM1bbt3HTlOMEtnZPP+zvQ3hoTtxY0JX3m
         sWGVkJA63mOO6sYNjxyJg599B6aT2P1FJC9H1reJeEVMQGzfqVUdSpG7p4SReBTIg0aJ
         /uLxvARcmv9NvY3QgAz9HdTn50AlRgW1Lq1DTxFpPACyFdNzNlkfvCEwJ4k8fZ1rQGJ8
         Q2z+Czf8avXEW1S6kLLm7tgfrDf3ZtMu7TWRHBALEyAqqJ+RN86cqVlCq1zpSbkhW8kS
         Hk5TwFvPytmS2PbrPlSrTtCp5JX0BZxAQiuL87HQzRbSlmoS2CMUfDZHxKCEJHtwdNqs
         k0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+OnVpQlgeliEtJDW+k76IyF+cUaA+kRBkYQqfBc1NCI=;
        b=ktkkV9/IKWdLJSO4wg9yqet60B2Op4zO/ncwj1/LkmZCR3cceyhqoPAukqgBRNASr7
         CLDevLNYmY7suEbdpcLAjvTEKdpbdALz6mbACtUk3YtLCKmRDk8891ZH5RwWk3xbR3fx
         QP1aKx6lfj924XyVAr5itUv4+MOqRJabF5YUmh6OIprRXdCZC+mug21GGsC7NMuMVgjq
         3JndYyqUuh23sfSVUUgIGR6/cibsnNzqqryWe56Tb0YQuDL2rgBzKYo0JFLbXmwkyZnL
         U6+j+uYY0AwocJwnax4f5auNypJVJCipwoc9r8FBrS6sfOguaTA5t3l2SYsgbLQCcl1A
         dBLA==
X-Gm-Message-State: ACgBeo0jGSMFT6Wqz5hrBeqV08Do1tDL9gLKiDkQLT09xVGHMecnDZEY
        hzpIoSXtYpYLPbEP+ECTd98foA==
X-Google-Smtp-Source: AA6agR7wi+8YjFtYIRZUShCcA2ibFauosWbPq1YrXWb+/Yg98FuUJKAUmIBD3jVqRxByJe6HvU9nXQ==
X-Received: by 2002:a5d:64c3:0:b0:226:de7e:d3eb with SMTP id f3-20020a5d64c3000000b00226de7ed3ebmr22003660wri.95.1662471392517;
        Tue, 06 Sep 2022 06:36:32 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a5c244fc13sm21775621wme.2.2022.09.06.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:36:32 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/7] bpftool: Define _GNU_SOURCE only once
Date:   Tue,  6 Sep 2022 14:36:07 +0100
Message-Id: <20220906133613.54928-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906133613.54928-1-quentin@isovalent.com>
References: <20220906133613.54928-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

_GNU_SOURCE is defined in several source files for bpftool, but only one
of them takes the precaution of checking whether the value is already
defined. Add #ifndef for other occurrences too.

This is in preparation for the support of disassembling JIT-ed programs
with LLVM, with $(llvm-config --cflags) passing -D_GNU_SOURCE as a
compilation argument.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/common.c        | 2 ++
 tools/bpf/bpftool/iter.c          | 2 ++
 tools/bpf/bpftool/jit_disasm.c    | 2 ++
 tools/bpf/bpftool/net.c           | 2 ++
 tools/bpf/bpftool/perf.c          | 2 ++
 tools/bpf/bpftool/prog.c          | 2 ++
 tools/bpf/bpftool/xlated_dumper.c | 2 ++
 7 files changed, 14 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 8727765add88..4c2e909a2d67 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /* Copyright (C) 2017-2018 Netronome Systems, Inc. */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index f88fdc820d23..a3e6b167153d 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (C) 2020 Facebook
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <unistd.h>
 #include <linux/err.h>
 #include <bpf/libbpf.h>
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index aaf99a0168c9..71cb258ab0ee 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -11,7 +11,9 @@
  * Licensed under the GNU General Public License, version 2.0 (GPLv2)
  */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdint.h>
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 526a332c48e6..c40e44c938ae 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (C) 2018 Facebook
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <errno.h>
 #include <fcntl.h>
 #include <stdlib.h>
diff --git a/tools/bpf/bpftool/perf.c b/tools/bpf/bpftool/perf.c
index 226ec2c39052..91743445e4c7 100644
--- a/tools/bpf/bpftool/perf.c
+++ b/tools/bpf/bpftool/perf.c
@@ -2,7 +2,9 @@
 // Copyright (C) 2018 Facebook
 // Author: Yonghong Song <yhs@fb.com>
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index c81362a001ba..a31ae9f0c307 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /* Copyright (C) 2017-2018 Netronome Systems, Inc. */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 2d9cd6a7b3c8..6fe3134ae45d 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /* Copyright (C) 2018 Netronome Systems, Inc. */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.34.1

