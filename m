Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3724813C51D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgAOOM7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 09:12:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23386 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729277AbgAOOM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 09:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdkfMOU4O1JSYnyvWTMVAu0Pbml2FCrACzP/iFrbkaQ=;
        b=U8mwVOrcQ0wFH57DSFnxRKUN3Co5bbiBm8PRUjCoaNyIRHoTq7DN0R+tbY/IGU5zJtYqn+
        Xo18lg49zQuot5qxgb5N2SzP8JqRczozzIp4wuJW6p/5hqzCZ5sCsPG8s0IY8dxlWsM4dQ
        r7PiTtdw2l4L3lCnqGMzHwCSh4wEM/0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-Ym5m_pxKNSinvzIqhqrlpA-1; Wed, 15 Jan 2020 09:12:56 -0500
X-MC-Unique: Ym5m_pxKNSinvzIqhqrlpA-1
Received: by mail-lj1-f199.google.com with SMTP id o9so4192785ljc.6
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 06:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tdkfMOU4O1JSYnyvWTMVAu0Pbml2FCrACzP/iFrbkaQ=;
        b=QObSW4+TbtabhG8GYXG59J8LrYTe6pnoq7+p81ZZ1N05xkzSNsrGJ3nZoLFaZQrsOo
         TmrnQMBCMi0s9m1RhMjrEOZbvlY+qRJBFkqimcCUcAZ2R3LXfXFe5DO3Kqvqpy6gMCDB
         umnmIWok/HCutho17oAzH64DpF1VTFtNittRN8huwUPVUeEnZubqfSi5zOl3tmhYEFZP
         wU5XvtWex3XbhEUEk4G8pFNHjhP4oY7ibyGsPdYswgkvzTwGT9RVEnpGnnpS9MhGsLNB
         yFznCxNg9oQWyF0wLvd/q4WXtl8EjX6JGFdmsIcxk0dAdgPwxMdYeRbttrSFgRjcWtGk
         EkRA==
X-Gm-Message-State: APjAAAUPR0KNbl832JeBz6ARVXH090Ow9XQQXtQTsWrjZwvukSZWTnj9
        wEmgkieJA1ukIlDz8K1Kg3tg9ftuVl/igoOVSPPoIcq8u1bJrX4ymxvBPSCtItOnRSRATd+OTl5
        gVEOinlw9fmmx
X-Received: by 2002:ac2:58ea:: with SMTP id v10mr4813040lfo.202.1579097574927;
        Wed, 15 Jan 2020 06:12:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUFS3e2zIy8rA7HqNCGr/3h2PBROEBA0CL5i8AxlW9KAm7efsIsFDqmChe4488tRaJn+o0VQ==
X-Received: by 2002:ac2:58ea:: with SMTP id v10mr4813000lfo.202.1579097574687;
        Wed, 15 Jan 2020 06:12:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 195sm9156230ljj.55.2020.01.15.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:12:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 149BD1804D6; Wed, 15 Jan 2020 15:12:52 +0100 (CET)
Subject: [PATCH bpf-next v2 03/10] tools/runqslower: Use consistent include
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
        Jakub Kicinski <jakub.kicinski@netronome.com>,
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
Date:   Wed, 15 Jan 2020 15:12:52 +0100
Message-ID: <157909757197.1192265.9826436565959764419.stgit@toke.dk>
In-Reply-To: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
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
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile         |    5 +++--
 tools/bpf/runqslower/runqslower.bpf.c |    2 +-
 tools/bpf/runqslower/runqslower.c     |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index fb93ce2bf2fe..3b7ae76c8ec4 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -5,6 +5,7 @@ LLC := llc
 LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
+LIBBPF_INCLUDE := -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
 CFLAGS := -g -Wall
 
@@ -59,13 +60,13 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(OUTPUT)/libbpf.a | $(OUTPUT)
 	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 -target bpf -I$(OUTPUT) -I$(LIBBPF_SRC)	      \
+	$(Q)$(CLANG) -g -O2 -target bpf -I$(OUTPUT) $(LIBBPF_INCLUDE)	      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
 $(OUTPUT)/%.o: %.c | $(OUTPUT)
 	$(call msg,CC,$@)
-	$(Q)$(CC) $(CFLAGS) -I$(LIBBPF_SRC) -I$(OUTPUT) -c $(filter %.c,$^) -o $@
+	$(Q)$(CC) $(CFLAGS) $(LIBBPF_INCLUDE) -I$(OUTPUT) -c $(filter %.c,$^) -o $@
 
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
 

