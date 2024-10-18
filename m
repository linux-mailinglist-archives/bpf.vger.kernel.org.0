Return-Path: <bpf+bounces-42369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469039A3616
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 08:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0DF284F9E
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 06:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24F18A95A;
	Fri, 18 Oct 2024 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSuMGMJx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511BB18A959
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234169; cv=none; b=CC2/obdp/kao5uJfUAPC8EACQTq4NkBNpOMUR5fYTxRCx4z//rkmhyQ1TNdvhEaTdnnXZ1I9/ip2jz+wZzNVJTSRcXrA0Ran6Vtqwzx7DpiO1goqkO9keLhehMwTGzNZjY9ltN60QJk0VT3u4LPnAU3onQach60Pvpv4wtcpN8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234169; c=relaxed/simple;
	bh=V3Vb2hf//zshHIZfpIUfjoEH/tVqVkH6391gX7FKJDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USjkcNILdbcOY9//rVFiYEvi6Q0fyvY5LzNUoVwoirNXI2tWHmz2NcnyD0YmM/VbPkGR2Bl1+vVZp+pGCBulKOEKyB4hODgVXj2Rc8J0ixypTFDmPx+FkNai9esealx7VEM9QfQL/6+NyhmdyvxWY++cr3NgumofntDUKn5/CSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSuMGMJx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729234165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcw3NNb274pgteWF0Xo0SQs7I5PdB8y/Fp9748ZLkf4=;
	b=gSuMGMJx3eltBoXyseN0h5aHMJ2SLI4jNdSbuO+QKq8xt+xsWhY96iECQPbRJuFhBozYHF
	xcIm90zHTyDFVtnZUZjr0STldnSHCCJKiVGQfA2Ps6q+4AbsxHVV/uY5HhJGdxEXHp1mno
	cAEzYO6n9hzr/NdsMohCJpBK0sIKNdU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-aF-5OCOjNYCwcbo3Liib6Q-1; Fri,
 18 Oct 2024 02:49:21 -0400
X-MC-Unique: aF-5OCOjNYCwcbo3Liib6Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B42019560AF;
	Fri, 18 Oct 2024 06:49:19 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.232])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07E781956056;
	Fri, 18 Oct 2024 06:49:12 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: Allow building with extra flags
Date: Fri, 18 Oct 2024 08:48:59 +0200
Message-ID: <e2ec5f8c7ee79e18161a359dfa19f80a90fdc3fc.1729233447.git.vmalik@redhat.com>
In-Reply-To: <cover.1729233447.git.vmalik@redhat.com>
References: <cover.1729233447.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In order to specify extra compilation or linking flags to BPF selftests,
it is possible to set EXTRA_CFLAGS and EXTRA_LDFLAGS from the command
line. The problem is that they are not propagated to sub-make calls
(runqslower, bpftool, libbpf) and in the better case are not applied, in
the worse case cause the entire build fail.

Propagate EXTRA_CFLAGS and EXTRA_LDFLAGS to the sub-makes.

This, for instance, allows to build selftests as PIE with

    $ make EXTRA_CFLAGS='-fPIE' EXTRA_LDFLAGS='-pie'

Without this change, the command would fail because libbpf.a would not
be built with -fPIE and other PIE binaries would not link against it.

The only problem is that we have to explicitly provide empty
EXTRA_CFLAGS='' and EXTRA_LDFLAGS='' to the builds of kernel modules
(bpf_testmod and bpf_test_no_cfi) as we don't want to build modules with
flags used for userspace (the above example would fail as kernel doesn't
support PIE).

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 28a76baa854d..1fc7c38e56b5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -294,13 +294,17 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
 	$(Q)$(RM) bpf_testmod/bpf_testmod.ko # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_testmod
+	$(Q)$(MAKE) $(submake_extras) -C bpf_testmod \
+		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)     \
+		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
 	$(Q)cp bpf_testmod/bpf_testmod.ko $@
 
 $(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_no_cfi/Makefile bpf_test_no_cfi/*.[ch])
 	$(call msg,MOD,,$@)
 	$(Q)$(RM) bpf_test_no_cfi/bpf_test_no_cfi.ko # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_no_cfi
+	$(Q)$(MAKE) $(submake_extras) -C bpf_test_no_cfi \
+		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	 \
+		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
 	$(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
 
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
@@ -319,8 +323,8 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
 		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
 		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
-		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&			       \
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
+		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' &&	       \
 		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
 
 TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)
@@ -354,7 +358,8 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
 		    ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" 	       \
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS)'			       \
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'	       \
+		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'			       \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
 		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
@@ -365,7 +370,8 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
 		    $(BPFOBJ) | $(BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
 		    ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)			\
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS)'				\
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'		\
+		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'				\
 		    OUTPUT=$(BUILD_DIR)/bpftool/				\
 		    LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/				\
 		    LIBBPF_DESTDIR=$(SCRATCH_DIR)/				\
@@ -388,8 +394,8 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   $(APIDIR)/linux/bpf.h					       \
 	   | $(BUILD_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
-		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)'			       \
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
+		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)'	       \
 		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
 
 ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
@@ -397,7 +403,9 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 		$(APIDIR)/linux/bpf.h					       \
 		| $(HOST_BUILD_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS)' ARCH= CROSS_COMPILE=	       \
+		    ARCH= CROSS_COMPILE=				       \
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'	       \
+		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'			       \
 		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/			       \
 		    CC="$(HOSTCC)" LD="$(HOSTLD)"			       \
 		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
-- 
2.47.0


