Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B629446AD8
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 23:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhKEWVv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 18:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhKEWVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 18:21:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3BC061714
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 15:19:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so15924028wrg.5
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwEmQN7iuyGwHgTXFsIw/xVKZJ4qPZjUOVQsJw5aWGw=;
        b=Sd8kvulXdaLPVfbLZft0TAAolBRS+c95hKuA/NQGiLse9xPDKu+h3OJsE7JDXG4TF3
         w4p7EP03PHnmFSFLhf6ySbsOQ3v7bc5R2J+yxlhAAQWCu7XwbWrakch+/F2xBGdnfXAD
         P4Cl1ZQFiL+7LSWjkJJQEKcYqNc53juX9e0HzNP3pBOpEI41+2TeRY7LOKNj2SzE920o
         l9qgaKZCY7uANl1D+75uUI6BS2n0oeJv5ZL/ClHGuPZsbnXpj61trXw2C+cRG69m+uaT
         EZomnbFU8ZDQSyjWh4LxDFRrcE19IJDby5jGosuzBS2OS98r02D6lLCfj1oBR8R/9twM
         VUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwEmQN7iuyGwHgTXFsIw/xVKZJ4qPZjUOVQsJw5aWGw=;
        b=hWym5nqQjZgYjBdtxwdT2YrUsNWRfqB5HF1pDanWVu2X0v309SJXW4gWo8J149OpzO
         BJbnEVzToozAC1dZy4ZRdgU5oPJGdE6w+B/+Q/ZTc2/idx6dDxl28fLZqBvo/T9CYj1P
         td16wc+qaYwK16KH3swvqh8wO3Rj9Qw/3zZheDjcczSzK8M+V7vCbdG/5Ikb51RyRary
         gfcH7q+TVIE3fFkLIk0ZpM4NQECBE+HivGa+ec7bd4za7ZmkkswLCh/wdY44dSWxlkfo
         NDZbYoqxqHKUK7396+4s2QZ9/36/OAqOXRprSKZD6b4Yy6mBChuhhyLJXpcPzPJhkBUH
         s7dQ==
X-Gm-Message-State: AOAM530mNM771i+7dlMjOVfj/Z46kIJ0KKH+v6yD++TrLXsZbSsNURtq
        6EBglj3E2kmrAq1UwevXy90/WA==
X-Google-Smtp-Source: ABdhPJyn4MVY/LmkuOSj0E9tqgW6faEVsiVA7kH3ME2QW9JOUzLw1cYsDbzDlFCZT4rZdqSPA0nXrg==
X-Received: by 2002:a5d:47a9:: with SMTP id 9mr24706910wrb.42.1636150749378;
        Fri, 05 Nov 2021 15:19:09 -0700 (PDT)
Received: from localhost.localdomain ([149.86.68.127])
        by smtp.gmail.com with ESMTPSA id l18sm9536381wrt.81.2021.11.05.15.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:19:08 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Joe Stringer <joe@cilium.io>,
        Peter Wu <peter@lekensteyn.nl>, Roman Gushchin <guro@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH bpf-next] bpftool: Fix SPDX tag for Makefiles and .gitignore
Date:   Fri,  5 Nov 2021 22:19:04 +0000
Message-Id: <20211105221904.3536-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bpftool is dual-licensed under GPLv2 and BSD-2-Clause. In commit
907b22365115 ("tools: bpftool: dual license all files") we made sure
that all its source files were indeed covered by the two licenses, and
that they had the correct SPDX tags.

However, bpftool's Makefile, the Makefile for its documentation, and the
.gitignore file were skipped at the time (their GPL-2.0-only tag was
added later). Let's update the tags.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Stringer <joe@cilium.io>
Cc: Peter Wu <peter@lekensteyn.nl>
Cc: Roman Gushchin <guro@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/.gitignore             | 2 +-
 tools/bpf/bpftool/Documentation/Makefile | 2 +-
 tools/bpf/bpftool/Makefile               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
index 05ce4446b780..a736f64dc5dc 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 *.d
 /bootstrap/
 /bpftool
diff --git a/tools/bpf/bpftool/Documentation/Makefile b/tools/bpf/bpftool/Documentation/Makefile
index c49487905ceb..44b60784847b 100644
--- a/tools/bpf/bpftool/Documentation/Makefile
+++ b/tools/bpf/bpftool/Documentation/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 include ../../../scripts/Makefile.include
 include ../../../scripts/utilities.mak
 
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index c0c30e56988f..622568c7a9b8 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 include ../../scripts/Makefile.include
 include ../../scripts/utilities.mak
 
-- 
2.32.0

