Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE941DDE96
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 06:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgEVENY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 00:13:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727809AbgEVENY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 00:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590120803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tji7WPFNFTY8HvN0hdb7X6vbE18lCPYkuP1ROCt8rXU=;
        b=gzdPFT9YN/jWJCzzyckia92mi7Zn306+R2ScMY1ReG2QHcG7ezcw6hYkklNrVes1B0Ay2k
        KU7Wl78aSJvKsm5v10I4Q3IG3pTBoZOZJJOYAFN75EjZTNmMMzkon9f3ljTtlAy4uLhoDI
        IfiFa8aRJRA8/pwngzq6S7Dg9M2BFn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-wdiCbQxHPYudeSc4zKxUCA-1; Fri, 22 May 2020 00:13:18 -0400
X-MC-Unique: wdiCbQxHPYudeSc4zKxUCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E172C1009600;
        Fri, 22 May 2020 04:13:17 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-74.ams2.redhat.com [10.36.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72E9A5D9C9;
        Fri, 22 May 2020 04:13:16 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 2/8] selftests/bpf: build bench.o for any $(OUTPUT)
Date:   Fri, 22 May 2020 07:13:04 +0300
Message-Id: <20200522041310.233185-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bench.o is produced by implicit rule only if it's built in the same
directory where bench.c is located. If OUTPUT points somewhere else,
build fails.

Make an explicit rule for it (factor out common part).
Add bench.c as a dependency to make it source for CC.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 09700db35c2d..f0b7d41ed6dd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -243,6 +243,11 @@ define GCC_BPF_BUILD_RULE
 	$(BPF_GCC) $3 $4 -O2 -c $1 -o $2
 endef
 
+define COMPILE_C_RULE
+	$(call msg,CC,,$@)
+	$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
+endef
+
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 
 # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
@@ -409,11 +414,11 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
-	$(call msg,CC,,$@)
-	$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(COMPILE_C_RULE)
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
-$(OUTPUT)/bench.o: bench.h testing_helpers.h
+$(OUTPUT)/bench.o: bench.c bench.h testing_helpers.h
+	$(COMPILE_C_RULE)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 		 $(OUTPUT)/bench_count.o \
-- 
2.26.2

