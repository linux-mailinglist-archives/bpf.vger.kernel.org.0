Return-Path: <bpf+bounces-35031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB429370E8
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 00:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215191F22683
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF79146591;
	Thu, 18 Jul 2024 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="oIoTz7Y8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D023E7E0E9
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343476; cv=none; b=g5GSl3+D+kVxE0vXQk+eCXySWr9O67keA89/CteHqe9IHBZDZE9xxIhTaTbJtUaAqoGotPQbRycMLq6SkEnqYB9Dv4cEDPZqKmt7/x0TF7P+4girToIm2vis+hgqBbNCqIBuOkki+pA5IyJuKy3YNsAGr3dzrq65yWVma4kj2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343476; c=relaxed/simple;
	bh=EwFUUV8bBGp+Bc7VlvHUHFom4JLotQBLvGsGiErIWoo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kdCskjwtuZd8O/6wh7UJkLQsiCFvl2M9aF0yUv/tx2f3vPx+cWvdaE9eyGAWfyq3nDSNTMdE0NfsdhM/ovtOHNKFikgnOJ9anJ0Uh5gDy/J4bhp9M8hfCW2fraVFrQKdvqW20FF1eBJHr23cyNcSs19OP93wDWrwjw5FevH2utU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=oIoTz7Y8; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721343472; x=1721602672;
	bh=UskqmxzlfmsmXtPYX9oRen7SlZ9yNurdfa6N2eAWb2A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=oIoTz7Y8/ct4E4aOqUDlEYXWS831t7HzQ3beNjdLrVRuFbXzcblHJvNjnotqI9nJ1
	 EZRcSGNz6xQCUS+EwRuB0veluovvoI9EWAfHME169EX7VeZ0bq960fLvKghPKUTu5A
	 PqMI3LdoZQSQ9oO/nWeRUntVuy+FXj/UxJ7JwgpyKWB6tkDHrNDdYVygzzGjc+DGzY
	 AUAyIMetHIftWvXM1hzpbybeANA1RClDucbHv4rY4GSAXlaVcsqb/y6HhlCbU3jkLV
	 CZoPm2fEe/W1sCmwIMJycj7HlEzumGVYNXxNwd2uDRADsI2UXAo53qe9CS9/6+J586
	 ukOa1nOGFy1KQ==
Date: Thu, 18 Jul 2024 22:57:43 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "ast@kernel.org" <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, "mykolal@fb.com" <mykolal@fb.com>
Subject: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
Message-ID: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: e74a9f40b1e2c94dc2bdbb49672f4d3a9350f352
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Make use of -M compiler options when building .test.o objects to
generate .d files and avoid re-building all tests every time.

Previously, if a single test bpf program under selftests/bpf/progs/*.c
has changed, make would rebuild all the *.bpf.o, *.skel.h and *.test.o
objects, which is a lot of unnecessary work.

A typical dependency chain is:
progs/x.c -> x.bpf.o -> x.skel.h -> x.test.o -> trunner_binary

However for many tests it's not a 1:1 mapping by name, and so far
%.test.o have been simply dependent on all %.skel.h files, and
%.skel.h files on all %.bpf.o objects.

Avoid full rebuilds by instructing the compiler (via -MMD) to
produce *.d files with real dependencies, and appropriately including
them. Exploit make feature that rebuilds included makefiles if they
were changed by setting %.test.d as prerequisite for %.test.o files.

A couple of examples of compilation time speedup (after the first
clean build):

$ touch progs/verifier_and.c && time make -j8
Before: real=090m16.651s
After:  real=090m2.245s
$ touch progs/read_vsyscall.c && time make -j8
Before: real=090m15.743s
After:  real=090m1.575s

A drawback of this change is that now there is an overhead due to make
processing lots of .d files, which potentially may slow down unrelated
targets. However a time to make all from scratch hasn't changed
significantly:

$ make clean && time make -j8
Before: real=091m31.148s
After:  real=091m30.309s

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

---
v3 -> v4: Make $(TRUNNER_BPF_OBJS) order only prereq of trunner binary
v2 -> v3: Restore dependency on $(TRUNNER_BPF_OBJS)
v1 -> v2: Make %.test.d prerequisite order only
---
 tools/testing/selftests/bpf/.gitignore |  1 +
 tools/testing/selftests/bpf/Makefile   | 44 +++++++++++++++++++-------
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftes=
ts/bpf/.gitignore
index 5025401323af..4e4aae8aa7ec 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -31,6 +31,7 @@ test_tcp_check_syncookie_user
 test_sysctl
 xdping
 test_cpp
+*.d
 *.subskel.h
 *.skel.h
 *.lskel.h
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index dd49c1d23a60..66478446af9d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -477,7 +477,8 @@ xsk_xdp_progs.skel.h-deps :=3D xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps :=3D xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps :=3D xdp_features.bpf.o
=20
-LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS)=
,$($(skel)-deps)))
+LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
+LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
=20
 # Set up extra TRUNNER_XXX "temporary" variables in the environment (relie=
s on
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
@@ -556,7 +557,11 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) |=
 $(TRUNNER_OUTPUT)
 =09$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=3D.llinked3.o) name $$(notdir $=
$(<:.bpf.o=3D_lskel)) > $$@
 =09$(Q)rm -f $$(<:.o=3D.llinked1.o) $$(<:.o=3D.llinked2.o) $$(<:.o=3D.llin=
ked3.o)
=20
-$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OU=
TPUT)
+$(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
+
+# .SECONDEXPANSION here allows to correctly expand %-deps variables as pre=
requisites
+.SECONDEXPANSION:
+$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) =
| $(TRUNNER_OUTPUT)
 =09$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=3D.bpf.o))
 =09$(Q)$$(BPFTOOL) gen object $$(@:.skel.h=3D.linked1.o) $$(addprefix $(TR=
UNNER_OUTPUT)/,$$($$(@F)-deps))
 =09$(Q)$$(BPFTOOL) gen object $$(@:.skel.h=3D.linked2.o) $$(@:.skel.h=3D.l=
inked1.o)
@@ -566,6 +571,14 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPF=
TOOL) | $(TRUNNER_OUTPUT)
 =09$(Q)$$(BPFTOOL) gen skeleton $$(@:.skel.h=3D.linked3.o) name $$(notdir =
$$(@:.skel.h=3D)) > $$@
 =09$(Q)$$(BPFTOOL) gen subskeleton $$(@:.skel.h=3D.linked3.o) name $$(notd=
ir $$(@:.skel.h=3D)) > $$(@:.skel.h=3D.subskel.h)
 =09$(Q)rm -f $$(@:.skel.h=3D.linked1.o) $$(@:.skel.h=3D.linked2.o) $$(@:.s=
kel.h=3D.linked3.o)
+
+# When the compiler generates a %.d file, only skel basenames (not
+# full paths) are specified as prerequisites for corresponding %.o
+# file. This target makes %.skel.h basename dependent on full paths,
+# linking generated %.d dependency with actual %.skel.h files.
+$(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
+=09@true
+
 endif
=20
 # ensure we set up tests.h header generation rule just once
@@ -583,14 +596,20 @@ endif
 # Note: we cd into output directory to ensure embedded BPF object is found
 $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:=09=09=09\
 =09=09      $(TRUNNER_TESTS_DIR)/%.c=09=09=09=09\
-=09=09      $(TRUNNER_EXTRA_HDRS)=09=09=09=09\
-=09=09      $(TRUNNER_BPF_OBJS)=09=09=09=09\
-=09=09      $(TRUNNER_BPF_SKELS)=09=09=09=09\
-=09=09      $(TRUNNER_BPF_LSKELS)=09=09=09=09\
-=09=09      $(TRUNNER_BPF_SKELS_LINKED)=09=09=09\
-=09=09      $$(BPFOBJ) | $(TRUNNER_OUTPUT)
+=09=09      $(TRUNNER_OUTPUT)/%.test.d
 =09$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-=09$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -c $(CURDIR)/$$< $$(LDLIBS) -o $=
$(@F)
+=09$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F)
+
+$(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:=09=09=09\
+=09=09=09    $(TRUNNER_TESTS_DIR)/%.c=09=09=09\
+=09=09=09    $(TRUNNER_EXTRA_HDRS)=09=09=09\
+=09=09=09    $(TRUNNER_BPF_SKELS)=09=09=09\
+=09=09=09    $(TRUNNER_BPF_LSKELS)=09=09=09\
+=09=09=09    $(TRUNNER_BPF_SKELS_LINKED)=09=09=09\
+=09=09=09    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
+
+include $(wildcard $(TRUNNER_TEST_OBJS:.o=3D.d))
+
=20
 $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:=09=09=09=09\
 =09=09       %.c=09=09=09=09=09=09\
@@ -608,6 +627,9 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
 =09$(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
 endif
=20
+# some X.test.o files have runtime dependencies on Y.bpf.o files
+$(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
+
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)=09=09=09\
 =09=09=09     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)=09=09\
 =09=09=09     $(RESOLVE_BTFIDS)=09=09=09=09\
@@ -768,8 +790,8 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
=20
 EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)=09=09=09\
 =09prog_tests/tests.h map_tests/tests.h verifier/tests.h=09=09\
-=09feature bpftool=09=09=09=09=09=09=09\
-=09$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h=09\
+=09feature bpftool =09=09=09=09=09=09\
+=09$(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h=09\
 =09=09=09       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko=09\
 =09=09=09       bpf_test_no_cfi.ko=09=09=09\
 =09=09=09       liburandom_read.so)
--=20
2.34.1



