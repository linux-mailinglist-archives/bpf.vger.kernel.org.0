Return-Path: <bpf+bounces-34670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6511892FFF6
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4F6B20CBB
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 17:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47B176ACE;
	Fri, 12 Jul 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="gveUE0CF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A651401B
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806532; cv=none; b=cesffX//yLGC15Jdrtj6BH3fcVv5A3wV9auZEk3yYKir+sk1h9JRYM6gAKyciXHrtK4ebi4Dp/tA9mRRTAvt3d/wh9O6Ktj2o3sA67nbxS09LjHtzv4vsHnk8Kh67i9cPMt8D2XCxOfYykjwfbalHyXATeIMDoJmBk+3vHZBO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806532; c=relaxed/simple;
	bh=L0vPqfOsbqkGpVTZCf2DnmZu0Rp9ntH+QpMxp80c2SI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UZ+9b/SzCxWKoygej6XZSrJZdEpW5ud5ieGddaPTcgMb/PyXmPS5far6/KpRVthUvcPS9/B/NntfbeVg74bWmubTCuSJ1sKnCfjPnz4cuf68Ra9HT38VfsLUh97/RHqVlK4TpE8idiTWWQjoVkt/HMGnOr3mjdCcqLwRLp+R6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=gveUE0CF; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1720806522; x=1721065722;
	bh=s9rY64BmJJi3py/4RPK3lDExNKZtbIKk8/SUKrCAQOc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gveUE0CFvgk8dxa/VA8ngE1AEuEEBphDg/jz4mufwb7tpKvetWa3oKi7rkc5XG1Sg
	 q/yt0AK51ZH9sQwyhEKpUBmi0zANB2YrH3mb87KuQ5ASRvfR+AFzUfTawCtTGpS6ja
	 t+hgwWGdghKivK4nIqZajfnkx9BrWHdakWZvSSPjLx3jMMbrUxDRF7IfJkg/wWtNXP
	 OR54znfLLMAxL2iRnirm3ymkLYQFg+CyRqcZgThqg8wlGS5s8rADvoMrFtE6M0eBYZ
	 eI6RqpzZ+k6BzhD96YRkDtq54V+ye0cOHKw3x9Wu7mdyUazib+NA6e/Znd1/7riepr
	 ElNTjU+Kj/Tcw==
Date: Fri, 12 Jul 2024 17:48:37 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Subject: [PATCH bpf-next v3] selftests/bpf: use auto-dependencies for test objects
Message-ID: <k0mJ337pPAELiYCO24iCt-5yapvpg2rUdhNwvFC6mDFVmGoLcKrrWkxTFTVBS73--NmoI74ErR5E9VZdq8087glOcHxq0kbj9i-zDoxDUN0=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5c2bd844ef0fe2d000f72ba8bb3d9376c926773f
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
v2 -> v3: Restore dependency on $(TRUNNER_BPF_OBJS)
v1 -> v2: Make %.test.d prerequisite order only
---
 tools/testing/selftests/bpf/.gitignore |  1 +
 tools/testing/selftests/bpf/Makefile   | 42 +++++++++++++++++++-------
 2 files changed, 32 insertions(+), 11 deletions(-)

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
index dd49c1d23a60..557078f2cf74 100644
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
@@ -583,14 +596,21 @@ endif
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
+=09=09=09    $(TRUNNER_BPF_OBJS)=09=09=09=09\
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
@@ -768,8 +788,8 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
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



