Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C145B5116
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIKUPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 16:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIKUPB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 16:15:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ADE13F82
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:14:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t14so12296845wrx.8
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DJc2WTeQ79aN7lw9j3ViprJPP9RDB1+5PaPrZJopgzo=;
        b=tfi0xMhI4A09iIjDRDfwyBGtW76n2eghEso5u138wSFwdlRG8oH1igv4gKvZO4eamO
         yssKtgCvqLQKroPGgLYVUksvwK2Pwv/uGxPTi7WE1NaFnpmIg/0yI0e9yb2UOSBUuZ+d
         NTDIh/HbyvwF+G33e7BZFAYwojKNax7M50Mxlz+sTCqDZcpH/r+vf4d36eHnCCR6WL1z
         YsCLfXxG2CkvcsxSPESJvzcDrUu6lW6vg4TaK9rZxlDhS00VHvIy7pHKpcQhlSHBH2ph
         LSus2B9AID3dyWfIs+8zncWemtzqFeBDvxKkSwWZBLbEC7cTkv6HUcGexBK6Fu9Yk4rV
         nJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DJc2WTeQ79aN7lw9j3ViprJPP9RDB1+5PaPrZJopgzo=;
        b=kyGIoncKZ3+u0Yc7cR3eCYUinDMkYOL6Vyr/lrLcODNsTcyhxvYO72qOG4EQFh5aTF
         fBIsxX7HcynrtsnimngEQri+lzcQaN3+P5v7RDj0eRixs0m8GxrA7gVZUzQFEWGia94u
         yzCQ0yEzyU5PoFJU/0/crFsop9BOzWEJODHYuAg3EqgXKXWOAFlvzf661ZdFksjxCTqc
         TLwDUyQqI4QYAM1WKNnq8X8T7VorcirEO3hzK/yeYAbO0SEUUkoOFk2J8ofTuEO0Ih5s
         rWP6bsxxMtkMnF38jbcUhdMmHtzm9s01BC2tGfk3DFsV4ra/pU8pFJtV0/tzHgZNkzoB
         gB3Q==
X-Gm-Message-State: ACgBeo2ICOJlia7xSXYh2XeNuT78JGPNN5R0NwC2ygkHf8ZNoD5rDKc8
        pfuoAJuJJ6o/wgoOZxvjy5WrNA==
X-Google-Smtp-Source: AA6agR6pNIJy9SyyCH8BRvO5LomTTaBxXFf8wvXJzC//3v3Ao5LszVI/WEwZGV1ljjcpcr0mqma2vQ==
X-Received: by 2002:adf:fc83:0:b0:226:d2d4:bc27 with SMTP id g3-20020adffc83000000b00226d2d4bc27mr12450847wrr.606.1662927297848;
        Sun, 11 Sep 2022 13:14:57 -0700 (PDT)
Received: from harfang.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a60ff7c082sm7603789wmb.15.2022.09.11.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 13:14:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/8] bpftool: Define _GNU_SOURCE only once
Date:   Sun, 11 Sep 2022 21:14:44 +0100
Message-Id: <20220911201451.12368-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911201451.12368-1-quentin@isovalent.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

