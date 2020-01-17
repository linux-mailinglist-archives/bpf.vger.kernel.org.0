Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44C140AEE
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 14:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAQNgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 08:36:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48958 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728688AbgAQNgr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 08:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579268206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OknDVKXPzEk2i0iYFrlDPLSC26NRFKasACpxW1z9e2E=;
        b=KzHo9sKDLUIdMeQFdTb2y7vmYZ37+ZU+vCzF5SPmedTd+7SH5H64bYHldndq3ppSXMg8w0
        TWNzqtQhAP9ZJcYPdbUxN9OyDd+YHItyvXJ7vvoZ8l1a+f0OaIFcOVStBp5i1C2zSnGYyj
        rDXi9lK/jlz5SgCIG3TvlT7MAA5ObFU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-6i4-LOncPGWj3ndaqvIulA-1; Fri, 17 Jan 2020 08:36:45 -0500
X-MC-Unique: 6i4-LOncPGWj3ndaqvIulA-1
Received: by mail-lf1-f72.google.com with SMTP id a11so4359725lff.12
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 05:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OknDVKXPzEk2i0iYFrlDPLSC26NRFKasACpxW1z9e2E=;
        b=jlFdIpCatrSibRSWcHOkSOayiN0Co5giJgwsYy/j6EQCdRa8HPVfYX+NFDTAVjN8gm
         K+ZPhvHvuKSYKoE/2O0lI57KbuyoI/hZ0pqrIPG+7nvnCdd7wB/gK1P5+AVtL5cA4jjr
         V5Fhr4vWMcVUvGlZsh5tIDRwoiCHMiZJC2PVDRYNFO8JcPOXNAjo8Dy6SYC91JSMsVcP
         ZJBpoptP1G3bDMfDNpF3dQK+3Oe3619VvF7IQ3LTTG/RHp5jOhFSEVbvb65na4CQIn7U
         SLN8gmkpDdO4mZdGVLL8O9byg0kaUCwNCGqIyQUBYPRvJhKKP7AXCEMuE15fw2argqU/
         NTPA==
X-Gm-Message-State: APjAAAWo3PRGAv0Qtt1aamlvLsT3xdhDbwZSnllqiMzSNOVrgmIAYTtC
        8s3cYxBCs2I7Q9oC1VnaOhVejrEfmJfI7hsTehwkmsPOSDUy00qpPmo77EMrp5jgYZn6cNX01A6
        sTJ03/H3wc7s/
X-Received: by 2002:ac2:5c4a:: with SMTP id s10mr5379674lfp.88.1579268204096;
        Fri, 17 Jan 2020 05:36:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyusVvlyEVdd3oS7WZRleumOv0TA50N1Au6MBvbWFLhChF/RcwKRx+cbLE29JwaFPZjnu+u7Q==
X-Received: by 2002:ac2:5c4a:: with SMTP id s10mr5379639lfp.88.1579268203914;
        Fri, 17 Jan 2020 05:36:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l64sm12147018lfd.30.2020.01.17.05.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:36:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5BD791804D6; Fri, 17 Jan 2020 14:36:41 +0100 (CET)
Subject: [PATCH bpf-next v4 04/10] tools/runqslower: Use consistent include
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
Date:   Fri, 17 Jan 2020 14:36:41 +0100
Message-ID: <157926820131.1555735.1177228853838027248.stgit@toke.dk>
In-Reply-To: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
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
index b62fc9646c39..9f022f7f2593 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -5,6 +5,7 @@ LLC := llc
 LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
+INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
 CFLAGS := -g -Wall
 
@@ -51,13 +52,13 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(OUTPUT)/libbpf.a | $(OUTPUT)
 	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 -target bpf -I$(OUTPUT) -I$(LIBBPF_SRC)	      \
+	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)	      \
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
 

