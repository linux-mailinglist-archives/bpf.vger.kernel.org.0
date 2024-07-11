Return-Path: <bpf+bounces-34597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452D92F0B5
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 23:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFF61F22618
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD919EEDF;
	Thu, 11 Jul 2024 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Jb9JjMxd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69F19EEC6
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732203; cv=none; b=SUw95dXQNe+b71q8btdwW7tObaotpX7EA+Mwc7A5RBdp0b5teV0ysNQh2N0iHNT5IG+cFx9VmREivKRhydUN6UWS/qqO33I4jBS+0iywQVzP9VLqjgPIccOGcm3vqPbAMV9ID0bjD7UXh9woUVKYUuQYQ9gLO2Vw9eA2ruZ//cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732203; c=relaxed/simple;
	bh=vy8v2NnlaJAsqTe0Z0JC+4b3Q3MXXTC2mjReKURoP3M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZnH6zjYkqcuMCrNxLKHoGhDd7r1R3THoyFPxmZsR8RZMymsLl6YqNlVTx25RDtl6XTGGmB4GWP1ZY5/XitpUtN5MzRtalL2fhpZNGDqgDK/QgdSvd332yr0tHrc1fxqdlxu1aQoCIv+gs6iY9GkLp0wPzBrH7zAxFolaVGTHn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Jb9JjMxd; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1720732193; x=1720991393;
	bh=W5YxVXQt9/h5tPr5tgKWTkAZ4ypIALT+wrpB/FGZVH0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Jb9JjMxdQ5xS/kNTGkS3M/GED3IU5rloqsw3L0NVKPpwg19r5ywisj0DrtD4cSiaZ
	 EyLQ//8gnpdsWLS/1d7AtgMvLABDrpl5MqSnyoJT/LloMqZQMJvHkwS9RVOHS6sXg0
	 TbseWLTS8p9CkMUr4UJT+WOrae8+t43yiUsmmKV8yvk3DExKE9euMEFW/vhJoO1N6X
	 oZK3vSHqp38BnBrZs+O+sIxdjRMPVniVVeqp+Tv71cY4dbUFxC/qWD+bvLspfbddxS
	 UMUj9U3kGTlj+ILnnttV/NJpnel9hTReY704AqPEDEgeMPtGtceRugSA1E2imbIBJm
	 0hlIHIYHw4Y5w==
Date: Thu, 11 Jul 2024 21:09:49 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: use auto-dependencies for test objects
Message-ID: <Naz7DRaOm6WPfVO0YqehujmRBSUi1RDWI6XYE-9zcqusFHfJ9VXevAlYMbcYORj2r8277pIQlbO5qHcpBrJpbeHAscLS9eo1AoKlkEiwt5k=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 72aeba889a2c89da6bf9ecc59af1bf386d18f01d
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
 tools/testing/selftests/bpf/.gitignore |  1 +
 tools/testing/selftests/bpf/Makefile   | 41 +++++++++++++++++++-------
 2 files changed, 31 insertions(+), 11 deletions(-)

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
index dd49c1d23a60..95bb0b38d84b 100644
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
@@ -768,8 +787,8 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
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


