Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267C4142BAE
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2020 14:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgATNGv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jan 2020 08:06:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728776AbgATNGu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Jan 2020 08:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO0YZDCYDI2J/1ujIzZCIdgWpSFgOqfh62+GspZ7r0s=;
        b=Zo01GYPwwK1TRmA94JwqQhr2JtUZXpXZ5r+WKE1oGZN2hdEflEYTGxItPHsEOOnnOqL5+p
        +yhygjR5Ipc+SwC3TFYZsyU8WOMzS2xIdpVaCEr96JzEk/e/j0cp+cOtq6PpTCX4HGmqJ1
        P40cUJnNjEp2Gq+7z32LThmpgiD7x1Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400--NmwAaxBN76crR3ldTslTA-1; Mon, 20 Jan 2020 08:06:48 -0500
X-MC-Unique: -NmwAaxBN76crR3ldTslTA-1
Received: by mail-lf1-f70.google.com with SMTP id y21so6209087lfl.11
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2020 05:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FO0YZDCYDI2J/1ujIzZCIdgWpSFgOqfh62+GspZ7r0s=;
        b=TWKErsoM8jDUDl4ygny+a+8Vm0UxEAfn5DTYl3mtZ81E1+K8bsDOa2aPraebafd3gp
         15KMMPvbHZ8F1pF1g+0Rjm7j/2mYk0fVl8DckA7ERfRTYIbVSVnRY/pTN6k9dSzmmzf9
         kFsOridvOxKQOFb9kCuvbJgvkx7RpdtX7YSeUSJml3akQfU88e4MCglKOpHsJzXpT+or
         s1wfaVW7eSRh/bKpD4HSHtLKceKqJZfmBuYAsav51Q588pTw8bWABtJxQfj1o3lXlVf7
         rANHJvPTu4VOy4g63HNZsF5OSQmSbK8N6tZLaXDImW55/N9Wq/7LUtGUOgrzUPDZc/+Z
         8LHQ==
X-Gm-Message-State: APjAAAUgN116eeR6Du3aHv9KatfBYoTaqtqzPM4D+DwRwxyKR/W2coLz
        a8mc+Q1Ooj2nXCvcDCgTgLGfOJma1qHfGXytVCuRK7FJqsXmJuJjM6WjhRYrVvZ4jwWUb4ncrk/
        JMtO3qJCBJRqC
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr13288199ljj.243.1579525606549;
        Mon, 20 Jan 2020 05:06:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2KwgfqhZ3/kgpwvu4ucvjAcbXYeXmUKFWMhAUlmDBXohA1PpkILdg2v6ESrPD9/+UsXHfOg==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr13288163ljj.243.1579525606301;
        Mon, 20 Jan 2020 05:06:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g24sm16765412lfb.85.2020.01.20.05.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:06:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A70281804D6; Mon, 20 Jan 2020 14:06:44 +0100 (CET)
Subject: [PATCH bpf-next v5 04/11] tools/runqslower: Use consistent include
 paths for libbpf
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Mon, 20 Jan 2020 14:06:44 +0100
Message-ID: <157952560457.1683545.9913736511685743625.stgit@toke.dk>
In-Reply-To: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
References: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Fix the runqslower tool to include libbpf header files with the bpf/
prefix, to be consistent with external users of the library. Also ensure
that all includes of exported libbpf header files (those that are exported
on 'make install' of the library) use bracketed includes instead of quoted.

To not break the build, keep the old include path until everything has been
changed to the new one; a subsequent patch will remove that.

Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken from selftests dir")
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile         |    5 +++--
 tools/bpf/runqslower/runqslower.bpf.c |    2 +-
 tools/bpf/runqslower/runqslower.c     |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 3242ab874ac0..b7b2230f807b 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -6,6 +6,7 @@ LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
+INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
 CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source
@@ -51,13 +52,13 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(OUTPUT)/libbpf.a | $(OUTPUT)
 	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 -target bpf -I$(OUTPUT) -I$(LIBBPF_SRC)	      \
+	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
 $(OUTPUT)/%.o: %.c | $(OUTPUT)
 	$(call msg,CC,$@)
-	$(Q)$(CC) $(CFLAGS) -I$(LIBBPF_SRC) -I$(OUTPUT) -c $(filter %.c,$^) -o $@
+	$(Q)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
 
 $(OUTPUT):
 	$(call msg,MKDIR,$@)
diff --git a/tools/bpf/runqslower/runqslower.bpf.c b/tools/bpf/runqslower/runqslower.bpf.c
index 623cce4d37f5..48a39f72fadf 100644
--- a/tools/bpf/runqslower/runqslower.bpf.c
+++ b/tools/bpf/runqslower/runqslower.bpf.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #include "vmlinux.h"
-#include <bpf_helpers.h>
+#include <bpf/bpf_helpers.h>
 #include "runqslower.h"
 
 #define TASK_RUNNING 0
diff --git a/tools/bpf/runqslower/runqslower.c b/tools/bpf/runqslower/runqslower.c
index 996f0e2c560e..d89715844952 100644
--- a/tools/bpf/runqslower/runqslower.c
+++ b/tools/bpf/runqslower/runqslower.c
@@ -6,8 +6,8 @@
 #include <string.h>
 #include <sys/resource.h>
 #include <time.h>
-#include <libbpf.h>
-#include <bpf.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
 #include "runqslower.h"
 #include "runqslower.skel.h"
 

