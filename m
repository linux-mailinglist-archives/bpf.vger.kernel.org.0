Return-Path: <bpf+bounces-34618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0229092F4A6
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 06:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99229B239D5
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 04:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082431426C;
	Fri, 12 Jul 2024 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ndpd7f54"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEDFC12
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758987; cv=none; b=UV4BZZDVzNTnnVF9h3aoaMY/wL0BQ6FWlm0ZVWKh06V5vExIU1x6/Q3UnFho7oAGgwoYpz2E6wKHg/c402svdrtwnGqEE50c5N1LPGZf4fuhCaLrXUv9cHDDzx7pApTBad/kGvVFQL/j4pRwCUx1NULfOfD/JYOOOGzDAPVdybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758987; c=relaxed/simple;
	bh=qjgnVZfzSfWHWRqImDLw+9pHbW0ORZpITOLr/VMI8go=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ybn76GqmxExAmUC+aYCrKo65Li1gtfzpvvFQeK0IMT6d7KCl4XX5lZ2/zXop5WkHGvXcVZCHmzYXnggATjEbzxTNGYnBkzVsux6vM+7RlVjA5WwD9Tn0AFJye4hxHbiX+gSUpY3FWxBvp8+RDa3iibMrIwvGTbeF9d9LU06pkb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ndpd7f54; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1720758976; x=1721018176;
	bh=ufaLyx34rsX9zDqXhAguhKZ5jwz+NItnuexGiUvy77g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ndpd7f54VcZ/FjtS+qVne2rRu5fmJx2r5wlNq8zjWjVA83JuwMmRYvF43mlSKo09W
	 OEjzp5xXBmgR3XTqWW7c8Oc2+PPmqaB0demfE9HfO9EDuItYGJ8ycVgSmo7ruYUf2f
	 jch/zHXZYq4efNTP5s8kJjz1vEJUToBpagykNn79oyQ4bVbFuQRJkkv1fLAmAQZ9DP
	 uDWU++Ehr+kQGEO6JWPQk5TvGNorJAfV7y9sw6X8xyo75yMeRhp1g2gSu71aSUG2jG
	 CPRGL/0NRgiaP4Tkdd5UkQJdszuSP48bp1PJhfeVX3R0iRVNK6VQzq6WggOkkni0FW
	 CKi7qddnpGX0g==
Date: Fri, 12 Jul 2024 04:36:12 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Subject: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
Message-ID: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 6b48a37469a5b4a84daa669bd68a33d4038d0516
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
v1 -> v2: Make %.test.d prerequisite order only
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
index dd49c1d23a60..254d92a3b791 100644
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
+=09=09      | $(TRUNNER_OUTPUT)/%.test.d
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



