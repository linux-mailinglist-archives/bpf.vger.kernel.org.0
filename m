Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB42D6860
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 21:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393463AbgLJUNu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 15:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390124AbgLJTmv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 14:42:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B12C061794
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 11:42:08 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id n8so3902953plp.3
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 11:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8NmwOfahTCP7W/9rBoKHiTMD1hQFyRHLTlM9386FI0k=;
        b=i4/+TevYKmQrfagv1lHzkydO5vS2rulq+OrcO7GxhpQ2uzlLX2XJyVTrjxO/N8xpwM
         gMKtP8dvTKUH8RDTcLxfUR5TfUW/a3HbCniNRhhpK/P2G0HaZcD5MrWmTxN+SzgehTyW
         GlbiiuCOjf0mtYFhUi1M2hS4jEi2v4lQnM5+dfRePV0lSJYY6WZGREbjlXWGSKmwvVSG
         FgdlUmWR6Gw6vFC7OlAc7W5dOLxjXiZxXO9+FlOMV3WhLcw68zEhXZqXhZOwIJTnzbwh
         xNIqiIK/DeLKKiaiS92fGIzRROZKTy7khtpsQpBo6kxC8rBU5He+eCxMsVuCw7KbYD33
         2i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8NmwOfahTCP7W/9rBoKHiTMD1hQFyRHLTlM9386FI0k=;
        b=SIZFA6RNpj53G0xyc5SQGEasImxRG1xWv3Ht0VsUhr0I8rlOB403fgoi9qTCuJeYh9
         k8EYgoW3H/KswkkVz0YX97em7CE9dJBLC5STsZiKVAG1WgNNKrLMiSb1/aXKYOLBDplW
         9qKzt1o038z91mLDyQpsDOlX8UoLXeuPKlRzaRwtwIz5NeDlbmocwB+IE5gxc9ta0NfB
         +zguCmAhPC5ak7LKokebOpDWp38ZB1C8Owd6d9XK/Bwfge77wTbh/yYZQt4TVRzACUaT
         NPN9MZZkc095yVPOiG8gcYw4kmRq5Hj018qoinScpCLUGJxO1BJM1DcebNzICs9itxeu
         QytA==
X-Gm-Message-State: AOAM530YGRDHt2t2wdHuDIfngLFxhEhdZl7euHqJ0SVXcLXSjd6lzl/i
        5Rx4s2TnMGHcK4w1Oe4nbMQNQGb9u/XtkMBMAU/Nn2hF8Ik2HIxsf9qBxn0YTqqzU3PWTfTnbnP
        VJqPdO+i7s5evY0wmk4mVr2p/9FAGA3vgni+N3QteUEj/k6xxr/d/2dA=
X-Google-Smtp-Source: ABdhPJwxIe/tMguVpGXKWvzQ36MvRSWiQrR7xTCsePMDGM+6NUTpi+DgbR88gwXo+HsWdkjEd9LtoB3Avw==
Sender: "adelg via sendgmr" <adelg@adelg.c.googlers.com>
X-Received: from adelg.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:a16])
 (user=adelg job=sendgmr) by 2002:a17:90a:c203:: with SMTP id
 e3mr2634004pjt.8.1607629327720; Thu, 10 Dec 2020 11:42:07 -0800 (PST)
Date:   Thu, 10 Dec 2020 19:41:56 +0000
In-Reply-To: <20201209205301.2586678-1-adelg@google.com>
Message-Id: <20201210194157.3218806-1-adelg@google.com>
Mime-Version: 1.0
References: <20201209205301.2586678-1-adelg@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v2] selftests/bpf: Drop the need for LLVM's llc
From:   Andrew Delgadillo <adelg@google.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        daniel@iogearbox.net, yhs@fb.com
Cc:     adelg@google.com
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
Changes since v1:
* do not pass +dwarfris
* do not pass +alu32 when using -mcpu=v3
---
 tools/testing/selftests/bpf/Makefile | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 944ae17a39ed..a96f63dfd8dc 100644
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
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v3 $4
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
@@ -402,7 +390,6 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
-TRUNNER_BPF_LDFLAGS := -mattr=+alu32
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
 # Define test_progs-no_alu32 test runner.
-- 
2.29.2.576.ga3fc446d84-goog

