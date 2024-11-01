Return-Path: <bpf+bounces-43709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008EE9B8D19
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 09:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F092856B4
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766FE165EFA;
	Fri,  1 Nov 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwxWykoz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FE1607B7
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449662; cv=none; b=Bs7RLqTnxzppqIn70RNL67DzKl3NeWs2fvn0CGMu6OZyvyAWSKn4QzWRiAKZD4tVERWs6UzaIZSwmNWzGDYzCJfXzNgg+WAnR9K7BKiX/PS2fBzGs6lHNS3fyCoXuXW/lLqEBWkg7sIpJHgF5235ev1gfHKUzdR5CthrIcIlPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449662; c=relaxed/simple;
	bh=7ZHNFaFx8pUEQVaEswgvWXggqrncwN3RgH0vdan6d0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jv5aIk456jRgwP1RDVERYIO931B/Gl7t2KYzxHqImlvWim9YlPPBNNYKW5PDGl/EOI4teKrM8q0vcPbzRvdGZrzsS+jFeCwR2yj2rvWRp/rT9j+y+CaGey4Kz3iqAH1HNhM3MO8WuKO08czUu72hz8s2S93AZXZH6BsmNEKANJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwxWykoz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730449658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nTn3NRtbZeKG+wZ11qCno9RYlbzzuezoY2348iMbQo=;
	b=TwxWykozVICOC52HDA/hlurXj+7DGGHnyvgQ04gfU40BezK+7LEJpANTLoWFt8+e1MzL6/
	3WqA5GjMijxnR5+wZERRMVJQxXGv3+S7gfP9/sx+5T1XCQIWj2vWRd4X4rKtgyWILl2Jyp
	x7WsQpZ5lakJW+cRMJey+JNuI+ia+v0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-gWvCd-7rPo2ZmZX-mR4XIw-1; Fri,
 01 Nov 2024 04:27:33 -0400
X-MC-Unique: gWvCd-7rPo2ZmZX-mR4XIw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28E111956088;
	Fri,  1 Nov 2024 08:27:30 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 722841956056;
	Fri,  1 Nov 2024 08:27:24 +0000 (UTC)
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
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: Allow building with extra flags
Date: Fri,  1 Nov 2024 09:27:11 +0100
Message-ID: <6cb7d34d0ff257deaf5bb818ac4bce3c95994d29.1730449390.git.vmalik@redhat.com>
In-Reply-To: <cover.1730449390.git.vmalik@redhat.com>
References: <cover.1730449390.git.vmalik@redhat.com>
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
EXTRA_CFLAGS='' and EXTRA_LDFLAGS='' to the builds of kernel modules as
we don't want to build modules with flags used for userspace (the above
example would fail as kernel doesn't support PIE).

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 34 +++++++++++++++++++---------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a226d0647c4e..3b43d7db8d2c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -295,25 +295,33 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
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
 
 $(OUTPUT)/bpf_test_modorder_x.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_modorder_x/Makefile bpf_test_modorder_x/*.[ch])
 	$(call msg,MOD,,$@)
 	$(Q)$(RM) bpf_test_modorder_x/bpf_test_modorder_x.ko # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_modorder_x
+	$(Q)$(MAKE) $(submake_extras) -C bpf_test_modorder_x \
+		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	     \
+		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
 	$(Q)cp bpf_test_modorder_x/bpf_test_modorder_x.ko $@
 
 $(OUTPUT)/bpf_test_modorder_y.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_modorder_y/Makefile bpf_test_modorder_y/*.[ch])
 	$(call msg,MOD,,$@)
 	$(Q)$(RM) bpf_test_modorder_y/bpf_test_modorder_y.ko # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_modorder_y
+	$(Q)$(MAKE) $(submake_extras) -C bpf_test_modorder_y \
+		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	     \
+		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
 	$(Q)cp bpf_test_modorder_y/bpf_test_modorder_y.ko $@
 
 
@@ -333,8 +341,8 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
 		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
 		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
-		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&			       \
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
+		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' &&	       \
 		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
 
 TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)
@@ -367,7 +375,8 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
 		    ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" 	       \
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS)'			       \
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'	       \
+		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'			       \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
 		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
@@ -378,7 +387,8 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
 		    $(BPFOBJ) | $(BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
 		    ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)			\
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS)'				\
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'		\
+		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'				\
 		    OUTPUT=$(BUILD_DIR)/bpftool/				\
 		    LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/				\
 		    LIBBPF_DESTDIR=$(SCRATCH_DIR)/				\
@@ -401,8 +411,8 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   $(APIDIR)/linux/bpf.h					       \
 	   | $(BUILD_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
-		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)'			       \
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
+		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)'	       \
 		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
 
 ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
@@ -410,7 +420,9 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
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


