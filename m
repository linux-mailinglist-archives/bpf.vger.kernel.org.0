Return-Path: <bpf+bounces-6585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CAF76B926
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E46281AD0
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F261ADED;
	Tue,  1 Aug 2023 15:54:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906521ADCA
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 15:54:07 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515BB90
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 08:54:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686fa3fc860so3781559b3a.1
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690905246; x=1691510046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajAF+t6njGTTE10ONTyjICZkmpPMA+YFQnQaKbwByKI=;
        b=QBJdIun1mNOViVW8Uny9lh9MsGjFaQoXV+ZOBDcpUbghZLC8I0EcTDHGlhKqFkoD44
         U3/2OJ7LjlIKgIk9oVrrum/cQyMGMkwM/hvxwfof0rW6hM9RwEizLa1DJk6bef4zThtC
         ONqHBUhkl7eJ3xI6BHkA2FNeT1XQWKSQrlsgNzMMdCKep6TDhbFXH3M3Kf5d1p6QRjbK
         a0gwMblH6PMh+dv3w6dovGaBeNGMjKUmW/yjpz6hYL3wRy4eo1zwohE/M0WrIKBEtQjP
         rG40ddwz3mcOECo7FtFe+cUPIP3+FQsF93OlMU7IYsxGSjaPO+jsazcSsqWpBPltB2GL
         Z2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690905246; x=1691510046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajAF+t6njGTTE10ONTyjICZkmpPMA+YFQnQaKbwByKI=;
        b=UP3sGqITFCHTeS3c5vUMRhk3Rl9918ZHMv61TPEsNWr/ByE4oWloVe/q1edKd7ag+0
         6MnZKy9RCUUW1KssrsbBTZ+Kcsp3TumBqKFCjckkaOqoFnvitmmYHgGcGx55T0dQpvn9
         yMD3SQRSm0hkWm64tSE+r7GpsXkIkQxx9I3su1cvA/yAuPz6gkeNgxvoM8OkadzBd2bF
         b2U0x8+RVJPdZpjt4qfMO4wjsttsffLCrtX2+e+Cp5f1ducpAJrNgnzsc9b/xkcX8Sog
         LzJroojmrKdVwEdSOl8QVWjGZUZ502sxNBf6JaIgVCdUzQSoWrMnAkk9TEVU/PD4XtYq
         n5AQ==
X-Gm-Message-State: ABy/qLYK6eAfQIzx0VDg/eFE85cmRmslgxfOAiqotKksCHr+PVS2aC3h
	hXbHJ58Rjji+Az+1jzmnPoc=
X-Google-Smtp-Source: APBJJlFgNzbmuV8eSVldQHYXyHB7bf23+ZYHg54AdM7BWBEoTgYkgFqHbXdbchtdkQarwNUx56oZJg==
X-Received: by 2002:a05:6a20:430b:b0:13a:52ce:13cc with SMTP id h11-20020a056a20430b00b0013a52ce13ccmr14580644pzk.51.1690905245433;
        Tue, 01 Aug 2023 08:54:05 -0700 (PDT)
Received: from fanta-System-Product-Name.. ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b0054fe7736ac1sm10167912pgc.76.2023.08.01.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:54:04 -0700 (PDT)
From: Anh Tuan Phan <tuananhlfc@gmail.com>
To: sdf@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: Anh Tuan Phan <tuananhlfc@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH bpf-next v4] samples/bpf: Fix build out of source tree
Date: Tue,  1 Aug 2023 22:53:55 +0700
Message-Id: <20230801155355.11885-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit fixes a few compilation issues when building out of source
tree. The command that I used to build samples/bpf:

export KBUILD_OUTPUT=/tmp
make V=1 M=samples/bpf

The compilation failed since it tried to find the header files in the
wrong places between output directory and source tree directory

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
Changes from v1:
- Unconditionally add "-I $(objtree)/$(obj)" to _tprogc_flags and drop unnecessary part
Reference:
- v1: https://lore.kernel.org/all/67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com/
- v2: https://lore.kernel.org/all/2ba1c076-f5bf-432f-50c1-72c845403167@gmail.com/
---
 samples/bpf/Makefile        | 10 +++++-----
 samples/bpf/Makefile.target |  9 +--------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 595b98d825ce..fe0214f21a9d 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
 # TPROGS_CFLAGS causes conflicts
 XDP_SAMPLE_CFLAGS += -Wall -O2 \
-		     -I$(src)/../../tools/include \
-		     -I$(src)/../../tools/include/uapi \
+		     -I(srctree)/tools/include \
+		     -I(srctree)/tools/include/uapi \
 		     -I$(LIBBPF_INCLUDE) \
-		     -I$(src)/../../tools/testing/selftests/bpf
+		     -I(srctree)/tools/testing/selftests/bpf
 
 $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
 $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
@@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/xdp_sample_shared.h
 	@echo "  CLANG-BPF " $@
 	$(Q)$(CLANG) -g -O2 --target=bpf -D__TARGET_ARCH_$(SRCARCH) \
-		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
+		-Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
 		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
@@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
-BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
+BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
 BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
 BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))
 
diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
index 7621f55e2947..d2fab959652e 100644
--- a/samples/bpf/Makefile.target
+++ b/samples/bpf/Makefile.target
@@ -38,14 +38,7 @@ tprog-cobjs	:= $(addprefix $(obj)/,$(tprog-cobjs))
 # Handle options to gcc. Support building with separate output directory
 
 _tprogc_flags   = $(TPROGS_CFLAGS) \
-                 $(TPROGCFLAGS_$(basetarget).o)
-
-# $(objtree)/$(obj) for including generated headers from checkin source files
-ifeq ($(KBUILD_EXTMOD),)
-ifdef building_out_of_srctree
-_tprogc_flags   += -I $(objtree)/$(obj)
-endif
-endif
+                 -I $(objtree)/$(obj)
 
 tprogc_flags    = -Wp,-MD,$(depfile) $(_tprogc_flags)
 
-- 
2.34.1


