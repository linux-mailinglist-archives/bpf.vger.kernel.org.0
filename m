Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4042D6CA6
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 01:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390678AbgLKAok (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 19:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390233AbgLKAo2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 19:44:28 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E076C0613D3
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 16:43:48 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m8so5108124qvk.1
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 16:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=X8gxvSC0RzZnuPPRG9NczgiRsahxrrcBxxSpDXbnRn8=;
        b=H1zHdizkNs6UM50TPAqnHzFvrop3ui9T4z5JNtWQVdILg897KAj2Rb0Nsi0ViL2LFV
         p1Dp3owObcRZYtPj88sJtF9RWRL4M4bvf17pkHQYSZIlskZCUpvZ5Id3ftG8VSPrnpCf
         4wCvJ6sMViJBdLlHGPqcU1jQN8ulOO71n1lsz7Ov9lJbILVZPCuAZAd99tspgTSCC0fn
         /5ri5mfV+J/lEO2XSGdM7GVKLPGTCztz3Q7GvQpXTKZYJZ6CO2V4t8uYlsRKStSysxPu
         cAvSNMPeWLSRj1k4oyt9M9CYpImeNxcURLQPQl96i14wecRBZuLL9Cd6tSaHO9oGy7l0
         IdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X8gxvSC0RzZnuPPRG9NczgiRsahxrrcBxxSpDXbnRn8=;
        b=TF5k2jPnfya2GXnJjqb270mCrMx+slUVe1QTS8VAZnfUXtfnPAa0LQl64dBxt9kTRF
         i5Tst6usFTbw43KvtNNXP3G64HlvB8Yjocie+Oz2iPelW6hJey8FYVf0g0G7f2LlT88n
         TFtC0QIE04ggmI/17tCOl1ejhjQxRAwUmQsQcob3nxTFVbOezBNV2EqJL4d9ivRQ/9mS
         QJ81pbl64iWRCjBrva2x4HA25IMkElarbEIwAnN8FnGKLEdSMAFvZO+DF2ZGh5TpBYva
         qeGH8jmk3t8VgXJTDvTifckvo08YSKwj6NZ999okHgajupDdfa2hUOk8pdkjGYo3QdwW
         qo5w==
X-Gm-Message-State: AOAM531Lw6Jx/V2+oE92EQ4T9NSAWWQDpcfwAvHw5HVO5hsxG4zPvJOn
        KsuZOoZxQQNGQh2HPfB9Wa+nTes8Eg==
X-Google-Smtp-Source: ABdhPJyFhLNUpE8FX8BIsfi2PlhIiFHaLdHp5UdNx/EQ53OCBfkZdRfw2j0nFKqxDttZ1/3cVgBkGkKXBg==
Sender: "adelg via sendgmr" <adelg@adelg.c.googlers.com>
X-Received: from adelg.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:a16])
 (user=adelg job=sendgmr) by 2002:a05:6214:114f:: with SMTP id
 b15mr12530405qvt.34.1607647427471; Thu, 10 Dec 2020 16:43:47 -0800 (PST)
Date:   Fri, 11 Dec 2020 00:43:44 +0000
In-Reply-To: <6bdcc1e4-5ce2-7876-e48f-bce04f7298b6@fb.com>
Message-Id: <20201211004344.3355074-1-adelg@google.com>
Mime-Version: 1.0
References: <6bdcc1e4-5ce2-7876-e48f-bce04f7298b6@fb.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v3] selftests/bpf: Drop the need for LLVM's llc
From:   Andrew Delgadillo <adelg@google.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net
Cc:     Andrew Delgadillo <adelg@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLC is meant for compiler development and debugging. Consequently, it
exposes many low level options about its backend. To avoid future bugs
introduced by using the raw LLC tool, use clang directly so that all
appropriate options are passed to the back end.

Additionally, simplify the Makefile by removing the
CLANG_NATIVE_BPF_BUILD_RULE as it is not being use, stop passing
dwarfris attr since elfutils/libdw now supports the bpf backend (which
should work with any recent pahole), and stop passing alu32 since
-mcpu=v3 implies alu32.

Signed-off-by: Andrew Delgadillo <adelg@google.com>
---
Changes since v2:
* Remove TRUNNER_BPF_LDFLAGS since they are not used
Changes since v1:
* do not pass +dwarfris
* do not pass +alu32 when using -mcpu=v3
---
 tools/testing/selftests/bpf/Makefile | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 944ae17a39ed..70122f414bcd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -19,7 +19,6 @@ ifneq ($(wildcard $(GENHDR)),)
 endif
 
 CLANG		?= clang
-LLC		?= llc
 LLVM_OBJCOPY	?= llvm-objcopy
 BPF_GCC		?= $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=
@@ -254,31 +253,19 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
 # $1 - input .c file
 # $2 - output .o file
 # $3 - CFLAGS
-# $4 - LDFLAGS
 define CLANG_BPF_BUILD_RULE
-	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
-	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
-		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
+	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v3
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
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(BPF_GCC) $3 $4 -O2 -c $1 -o $2
+	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
@@ -333,8 +320,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 		     $$(INCLUDE_DIR)/vmlinux.h				\
 		     $(wildcard $(BPFDIR)/bpf_*.h) | $(TRUNNER_OUTPUT)
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
-					  $(TRUNNER_BPF_CFLAGS),	\
-					  $(TRUNNER_BPF_LDFLAGS))
+					  $(TRUNNER_BPF_CFLAGS))
 
 $(TRUNNER_BPF_SKELS): $(TRUNNER_OUTPUT)/%.skel.h:			\
 		      $(TRUNNER_OUTPUT)/%.o				\
@@ -402,19 +388,16 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
-TRUNNER_BPF_LDFLAGS := -mattr=+alu32
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
 # Define test_progs-no_alu32 test runner.
 TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
-TRUNNER_BPF_LDFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
 
 # Define test_progs BPF-GCC-flavored test runner.
 ifneq ($(BPF_GCC),)
 TRUNNER_BPF_BUILD_RULE := GCC_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(call get_sys_includes,gcc)
-TRUNNER_BPF_LDFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,bpf_gcc))
 endif
 
@@ -425,7 +408,6 @@ TRUNNER_EXTRA_SOURCES := test_maps.c
 TRUNNER_EXTRA_FILES :=
 TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 TRUNNER_BPF_CFLAGS :=
-TRUNNER_BPF_LDFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 
 # Define test_verifier test runner.
-- 
2.29.2.576.ga3fc446d84-goog

