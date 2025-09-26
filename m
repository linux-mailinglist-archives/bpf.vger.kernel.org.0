Return-Path: <bpf+bounces-69867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E5BA511B
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 22:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620CC1C22438
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 20:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED861C8630;
	Fri, 26 Sep 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tHXOeUQ5"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE7526F29F;
	Fri, 26 Sep 2025 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918685; cv=none; b=TZVVMG4r8aExjbKzN5q/s+OG8re31ItxDXok78l9Fu00XvLDwLUTFHD1y9AxdddY5jcEJfmtMhUkqzV7zyUm7cW0/qQBy69V4EwhTxS7lnwj269lmgfX3sz50s5AGLZ+qpnk4S16ELjZYt+XBb9WSiTpBgQ37V/23sz04O2Uk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918685; c=relaxed/simple;
	bh=sEqmAGxzhbdsg5aU+MjoDuHQdT3MdaCT4ua0EAII40U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7WnMR+ebaMshBumaEsJwTb4K3u5U7Qad27VmNlv6uIF3Dwy7EJvh8G9GzcDZ62CuzYZKb0bGaMyLRYCOeVdKgYWNyPX+UKVrUlYJep4OfbscK8Pm+au3T2oOIzLqP5MA8ewZ3vmNHQ6Wrbyh4sLgadMPwDn4V+EPSRJvykT/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tHXOeUQ5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id EEE052012C33;
	Fri, 26 Sep 2025 13:31:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEE052012C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758918682;
	bh=N2h5E7c6bSXkuhtZXHC29DtAXEY9+FqFhr2aI1vJiXE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tHXOeUQ5kp+gkugkAdAFmPQpuCfAILCFxkZyzsCgHO7P8xQL6dWGtkv9RUDcv/ESh
	 quosdsetyCOhepgCDPpROTiOAuO8NvvvQ/3vQ4ibsGCIXUK/iRJ7kh9swImKGk3jC4
	 RA82tof8dJed2qI6avVXgI6DkhjPvoIgdawNzHnU=
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
	wufan@linux.microsoft.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Enable map verification for some lskel tests
Date: Fri, 26 Sep 2025 13:30:33 -0700
Message-ID: <20250926203111.1305999-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250926203111.1305999-1-bboscaccy@linux.microsoft.com>
References: <20250926203111.1305999-1-bboscaccy@linux.microsoft.com>
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
index 0b6ee902bce51..dab70f6fa6ad8 100644
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


