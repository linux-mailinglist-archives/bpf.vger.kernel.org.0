Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7960CFDE
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiJYPDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiJYPDm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 11:03:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC581B2BBD
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so11051230wrq.3
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM6m8ABDHy9/yDjET8mC473qdbIttwuMCtSmPhs3VzM=;
        b=0OodaKVssFUxxQQTJWxrIB1mfo1iaGuCAnIZU53ibrmEO7luzo/RYwlC3ueCwEP0Qs
         OuJ1y7nxVJE1cXQ8992JsZNsQ24ESK+MvwIZhpjtJOdbm/rQHHZZkUTQk/1kqFoGliGw
         fuuEumnx3XJb4Q2I764PDzEd/mdQw4vi6phpbodNbqQjjuQC8ab0LE6kiXrVj/2BRBSa
         4Y0PDG0gIPXKUvBk+je9mH7Ts6EPtitY75lPOy0uIj8Y+4jqF4DbJF4TP0UtpPxqsxfo
         SuGbE4XtSp8SF5IvAhkNWzNrefR/rZc6xkZMpuD3nGg3pd4+9OoEBByxoHdVn99BKORh
         e8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM6m8ABDHy9/yDjET8mC473qdbIttwuMCtSmPhs3VzM=;
        b=X2kiKwz4YG1SFP30dQWdIMAxebwBrgp97g5qrZQWiEP1aFkoZEJWYLie5vQ3HJQpb3
         oxLMQyJVPxAQb4Siex8TTfJ9a3+q4oyR3YrdU+UU462zLuicTyRoQAt7lQQV+QfifaYP
         xsy4BeBuYkwXXDdS3JyDx+J3RPdwSr7zPNMnU3yjatxtNtLPTLhxzm0e+HFYerX9o7c4
         egMCTvuCUtGZ8N4yo5chqjdmOikyEr3EzzPTvdtxEd75BoEW4/am2vG+vUWr+VM+9JTx
         IBqup4zatYTXb1jcjrmihBl17Wd4NOzzwM5OqPZRB6o+abUU8oi8+T8flVJElZDF9SDW
         IR0Q==
X-Gm-Message-State: ACrzQf0Fmu8K4GmV9VwWvG8joJ04Y+XGum39VvazQkObVFi8nBWTRndB
        eu02cNixVCNaber6dpFUFdISDw==
X-Google-Smtp-Source: AMsMyM6BSnj8J0VN8ymMU0fvo1NJ5OyOpcdx8TKPctiZIMw+i7UgouiIj+rEh/eeOc55+K2wFDYl3w==
X-Received: by 2002:a05:6000:178e:b0:22e:6d9f:1592 with SMTP id e14-20020a056000178e00b0022e6d9f1592mr26137626wrg.6.1666710219688;
        Tue, 25 Oct 2022 08:03:39 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i7-20020adff307000000b0023659925b2asm2724182wro.51.2022.10.25.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:03:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/8] bpftool: Define _GNU_SOURCE only once
Date:   Tue, 25 Oct 2022 16:03:22 +0100
Message-Id: <20221025150329.97371-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025150329.97371-1-quentin@isovalent.com>
References: <20221025150329.97371-1-quentin@isovalent.com>
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
index 10ec29cb4598..dbf5489b8fde 100644
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

