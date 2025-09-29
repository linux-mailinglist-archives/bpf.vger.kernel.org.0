Return-Path: <bpf+bounces-69992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9FBAAA71
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 23:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64D17A19AB
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E874257AEC;
	Mon, 29 Sep 2025 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IdTxIcw7"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4DE17996;
	Mon, 29 Sep 2025 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759181732; cv=none; b=Ss8lSlqWBFl68qZCr1kEeT3z8Cg8IcNrAUpLp0tolT1HonyiRzUj4umWCyAvKCAYH+b+o0Wbxy644x+zXu8txCMSu/bihnl+2ia2jApPYlMv7LDCaswJJ+3d6BwigfySLkqAEfTxmgxccvvmxHXNWqPJXeRKJE9CYGLSs7eCLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759181732; c=relaxed/simple;
	bh=WnGVIxSSYfW4H7nZfxQbK87MTpdMrSbJgsu7fd+tR8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1d8G8wY08DOuWYxYDEkTzIkcXKTHWIIech3CSC6DTAtLCUm7O6cghaVJlti97ZwMo6sPiJrH3plTVnFxPlckBaGzvXv3vH+FImNHYuL7oC6aXixvib7WJTV73jSrV3DCYTzHP2GLybqEd5pV3ZtAChgPL0zGBom/x0CvgUivvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IdTxIcw7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 41B0A202189C;
	Mon, 29 Sep 2025 14:35:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41B0A202189C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759181730;
	bh=DPkk3urLu5ZicvDtE8AkV75gv7uHPVzlIHjEZNjpYt8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IdTxIcw7I2jIe0BCI+O2JmZBDqdK7OlgvnmzUzC0DtGlA+d6LGlqip8ALT4KR9o1X
	 jpDBDfkLn+EZ8fnKa2ql0INa+5/R4xtbkg/HbHaopZgXp8RsXvTs2k/sychgB/Fd5G
	 clg7RxaLUTSZw6KpGnup9FKh6BUtr4GDYRj63vEQ=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kpsingh@kernel.org,
	bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	James.Bottomley@hansenpartnership.com,
	wufan@linux.microsoft.com,
	qmo@kernel.org
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Enable map verification for some lskel tests
Date: Mon, 29 Sep 2025 14:34:26 -0700
Message-ID: <20250929213520.1821223-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert an existing signed lskel test to use the newly introduced map
signature hash-chain support added to libbpf.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 tools/testing/selftests/bpf/Makefile | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f00587d4ede68..ae03fa9001a61 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -500,12 +500,14 @@ LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
 
-LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
+LSKELS_SIGNED := fentry_test.c fexit_test.c
+
+LSKELS_SIGNED_MAPS := atomics.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
 	kfunc_call_test_subprog.c
-SKEL_BLACKLIST += $$(LSKELS) $$(LSKELS_SIGNED)
+SKEL_BLACKLIST += $$(LSKELS) $$(LSKELS_SIGNED) $$(LSKELS_SIGNED_MAPS)
 
 test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
 linked_funcs.skel.h-deps := linked_funcs1.bpf.o linked_funcs2.bpf.o
@@ -537,6 +539,7 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
 define DEFINE_TEST_RUNNER
 
 LSKEL_SIGN := -S -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
+LSKEL_SIGN_MAPS := -S -M -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
 TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
@@ -553,6 +556,7 @@ TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
 TRUNNER_BPF_LSKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS) $$(LSKELS_EXTRA))
 TRUNNER_BPF_SKELS_LINKED := $$(addprefix $$(TRUNNER_OUTPUT)/,$(LINKED_SKELS))
 TRUNNER_BPF_LSKELS_SIGNED := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS_SIGNED))
+TRUNNER_BPF_LSKELS_SIGNED_MAPS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(LSKELS_SIGNED_MAPS))
 TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
 
 # Evaluate rules now with extra TRUNNER_XXX variables above already defined
@@ -616,6 +620,15 @@ $(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
 	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
+$(TRUNNER_BPF_LSKELS_SIGNED_MAPS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY) (signed),$$@)
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
+	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+	$(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN_MAPS) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
+	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+
 $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
 
 # .SECONDEXPANSION here allows to correctly expand %-deps variables as prerequisites
@@ -666,6 +679,7 @@ $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_BPF_SKELS)			\
 			    $(TRUNNER_BPF_LSKELS)			\
 			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
+			    $(TRUNNER_BPF_LSKELS_SIGNED_MAPS)		\
 			    $(TRUNNER_BPF_SKELS_LINKED)			\
 			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 
-- 
2.48.1


