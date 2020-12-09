Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2092D4C3E
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 21:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgLIUxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 15:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgLIUxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 15:53:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63D2C0613CF
        for <bpf@vger.kernel.org>; Wed,  9 Dec 2020 12:53:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n186so3954228ybg.17
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 12:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=PPxRouLs713+goBDtoVbiilQ60mn7ruryaOTRQQrgWc=;
        b=P0gc8lbVRDCSAFvPPDdeDtgL8C92otq9hyZnFnlqUFC9nNnBxX6xa75JpDqdcNuwOv
         pu7HP65j50qCgjC/0pkwVWkoOvP2uW/l2GL/NTOVceZfOJbLyoQa07M3wHOiaNcdT20B
         eyDCanBUvXFctVdbejGVXNASZU9lr6WABsCeoDuXzjwSq+vyOHMtY+8OKGC/DHz3KM9s
         MfwVqIe/nT4Fdj2jb+ZOan2Ib58EyV19tMwxCoN5ykO6ljqcvq0T7IQRB/OnH7d9rJ1T
         geEkCxFhr1qdBZNmIsGGeWm7vWL6EbqFh6+12Znjb3GK/cpznIpMcg2mbb/KmYNb+8Fe
         upJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=PPxRouLs713+goBDtoVbiilQ60mn7ruryaOTRQQrgWc=;
        b=qNsVTTr1OZiyjZLWc4WACOsSRRxBWewHFlOnrVQNkG6XlM0DYJgZUX1fmF5mZ4rYi0
         JXRCrsBUUzEKabhci+HfZYXYM6iOxDKBCN7vAUS+1SeV395XC4lIZM/ldDJKDUs43pp9
         eWa3Lkg952sXKNyqZJCCouXXNNJWh+ifFAKjg79UdDfq3SO76DfwJ/eGP9f6pR/cyL0a
         K7bBJKqKPMeKwNox+3wQp3HTisCBIrAL9rpneKsOwYzp4omeH+IqGfGM3IkJn4c60omv
         IaZCt88O7bguusSEFQpQMaJl7gxdElLmitTJBDGLpq2poSQgGfJRq85QI0PeqhpMIpPE
         gA9g==
X-Gm-Message-State: AOAM53074DnwFiu6J8463kZKRZLfDk73su4tX/JrohXsraiqZVgQp89G
        5HzhGWj4v71pg6a3zusu8JpP8DkV/X5LLGKVeGZfPJv+U+SSVy8O8E3P07d+xDWTpQGyRerw3f1
        y6eCHR678si/CzSORMgKq87vN4bRstVHlHwys37kDZ0uqM+csiMctJ4c=
X-Google-Smtp-Source: ABdhPJxhkXmud1RSLwzdkiJfBDJyfWX1JXX3segyV1hIQrW5HlSSb7DW5dLfNCDfaWj/DpkAnypnYILJ5A==
Sender: "adelg via sendgmr" <adelg@adelg.c.googlers.com>
X-Received: from adelg.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:a16])
 (user=adelg job=sendgmr) by 2002:a25:8808:: with SMTP id c8mr6207882ybl.140.1607547190063;
 Wed, 09 Dec 2020 12:53:10 -0800 (PST)
Date:   Wed,  9 Dec 2020 20:53:01 +0000
Message-Id: <20201209205301.2586678-1-adelg@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next] selftests/bpf: Drop the need for LLVM's llc
From:   Andrew Delgadillo <adelg@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrew Delgadillo <adelg@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLC is meant for compiler development and debugging. Consequently, it
exposes many low level options about its backend. To avoid future bugs
introduced by using the raw LLC tool, use clang directly so that all
appropriate options are passed to the back end.

Additionally, the native clang build rule was not being use in the
selftests Makefile, so remove it.

Signed-off-by: Andrew Delgadillo <adelg@google.com>
---
 tools/testing/selftests/bpf/Makefile | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 944ae17a39ed..74870d365b62 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -19,7 +19,6 @@ ifneq ($(wildcard $(GENHDR)),)
 endif
 
 CLANG		?= clang
-LLC		?= llc
 LLVM_OBJCOPY	?= llvm-objcopy
 BPF_GCC		?= $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=
@@ -256,24 +255,13 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
 # $3 - CFLAGS
 # $4 - LDFLAGS
 define CLANG_BPF_BUILD_RULE
-	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
-	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
-		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
+	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -Xclang -target-feature -Xclang +dwarfris -mcpu=v3 $4
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
-	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
-	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
-		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -march=bpf -mcpu=v2 $4 -filetype=obj -o $2
-endef
-# Similar to CLANG_BPF_BUILD_RULE, but using native Clang and bpf LLC
-define CLANG_NATIVE_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)($(CLANG) $3 -O2 -emit-llvm					\
-		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v2 $4
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
@@ -402,7 +390,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
-TRUNNER_BPF_LDFLAGS := -mattr=+alu32
+TRUNNER_BPF_LDFLAGS := -Xclang -target-feature -Xclang +alu32
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
 # Define test_progs-no_alu32 test runner.
-- 
2.29.2.576.ga3fc446d84-goog

