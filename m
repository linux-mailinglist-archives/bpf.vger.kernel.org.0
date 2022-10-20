Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065F9606059
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJTMhY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJTMhW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:37:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E776F13D19
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v11so4812129wmd.1
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJc2WTeQ79aN7lw9j3ViprJPP9RDB1+5PaPrZJopgzo=;
        b=jchz0dVKbvRcD+RevPINYGXa69CHh5VGIHdmd+IHrWx/dxqHNVTAFQgvMSO2X82i7o
         qCa6RqnAbWXAcnR16P1HtZDsYruPrF5QFzbuz3R+NHpLpD7LUUdnNc5OMdkgTq+BZBof
         LmyxRCfPRhcdceD8tr/4LA0OnAnl4QjtjngfMghEmi7UbLG6CW3zFdr2rLrYyG8Yjsq8
         3d3rxqp3gUZetLscfWZo401bRBbyot2C68AIx6GjvJ/3lUiseXmMkHFQLEJMmlENAKj8
         WikoXkVPuHmF05EyRhgKwXkSWhxeIEgMsMxZv1QSCR2sUfWKft7i7OpVLkDfCQJfcxuq
         OEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJc2WTeQ79aN7lw9j3ViprJPP9RDB1+5PaPrZJopgzo=;
        b=WWgPTb9cY2omF3YsIy2fl/FnhQGXzvfPukmB/rT1jWJN5ZS+ECsDqCGVcvWzFdu8pR
         KX/FKNAmO1p0iRvfRftvjMmHRBQgs/rfO8U1VWl5anOYM0snKImmEpuRZ0DcXEioiIfB
         TBGsmqU31AW9OjzNBl7F4tItvevjgl3W1euUEmWtcywWJQZFIpI4ZEqfltfpEPiagRnX
         fFr+DlJhmfM8Ob9QWo8PDM7/yjqZjZkVTqg8DbEjKjeYGZ8Cm2gW87VFCWc78oreGZfE
         wlZYH2ApbISet+9FUxbHnbRjiwFQIZVSN8KydacRICz09onW++G6OzEFYtFvUArjifjl
         2qMQ==
X-Gm-Message-State: ACrzQf2X5cJ2kIaCewbBJGrmAhtWOYQg5a6cx8QV7coTGKNVQx/XXi+r
        bhyu2h54OO93oEztTlGAXQPmaUA6tE7naFLq
X-Google-Smtp-Source: AMsMyM5miSJidwxoHhTghzhHpYYBtis7zszr6XqNG4KQ8DYXk1Crs4FZ6MEJgU8KxH4gbJyZ9NwFmg==
X-Received: by 2002:a05:600c:6885:b0:3bd:d782:623c with SMTP id fn5-20020a05600c688500b003bdd782623cmr9091693wmb.102.1666269439485;
        Thu, 20 Oct 2022 05:37:19 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm16329581wrt.41.2022.10.20.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:37:18 -0700 (PDT)
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
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v3 1/8] bpftool: Define _GNU_SOURCE only once
Date:   Thu, 20 Oct 2022 13:36:57 +0100
Message-Id: <20221020123704.91203-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020123704.91203-1-quentin@isovalent.com>
References: <20221020123704.91203-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Song Liu <song@kernel.org>
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

