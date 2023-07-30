Return-Path: <bpf+bounces-6349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F7776857D
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83491C209AB
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FFE1FDA;
	Sun, 30 Jul 2023 13:18:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8717C7
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:18:12 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150610B
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 06:18:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686ed1d2594so3572045b3a.2
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690723089; x=1691327889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoKJbbiWl8hUg0Dy6YLVM9iQokjVlJ3D8prlTQfzCzg=;
        b=NipgZv6PiVltkSLreFuviTiDabA7maZ6wrCQ8AActBCPMzoNsHRKcJuD98lVWSDg/G
         1GqLvQo5oSPgaof8RVK+SvP2qhVfeQo8PGCdk/mKqcV7bjw91nPcqInkz1VKDvSIXcHG
         LlEv3jk1LQDLXoX3GyGduUm4ZRTrcybzDADzfO3d6pch3YrWXGzoyjEtiKjp+d/mcnPO
         xyEgZARbZlQhB4fkDcTJmTyvcB6L+GtgXRpGtA0eeCKGiy5hNuwF/7YmODZfI88PzKzY
         VYUqTSysDTDZqoTeNLJPEQeC+/B862LSm8LuGmvO9Ek8I0m9XK9IidFNbwZaJaqlIdwA
         cm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690723089; x=1691327889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoKJbbiWl8hUg0Dy6YLVM9iQokjVlJ3D8prlTQfzCzg=;
        b=OiJBr/Vph7HclPbMlaUwsaTFeRjMZK22JJf6V6hIMFnN8CSxJfto+Ye0VVj8yg1AJ/
         YMEz75SC41gIbsCKNP43JowTE4C/gHE0E0ptzrtx4P65NwtXuZVFRl96NqNoknjK9vtR
         5LFGrVTSBGlUvbQGfS1KbJbVlQWfzH+oyWi8ma+GxTyNEzqZ9WOAXLOxWW0RbBRtVGZE
         fQdhLImHAFpgGHMlVZTXFzk/L0xcWPv/cUzhX/HVfRJoxuq09Y9Qn1YBfXMaait73VAh
         nrzTH6h8C7QRfNd6hj5R4qdKEYqod57MexE7yICCNt7J5KVfGjiWtAOt9K6sXEKBw3w5
         tLRA==
X-Gm-Message-State: ABy/qLZr8gI2toZaXETxzKlxmgrkuLK5+rbg8RZ1xywnBeFc4TcF01eT
	SdKGeEtO+iJ2PCKBFDDtF7k=
X-Google-Smtp-Source: APBJJlGxWL7Q6ft5ubK3ML9kE6ZI8AqfCONOxLIrr78jTbF4pjdiSSPx1VgbgZwRSVHQLa72iYD0Wg==
X-Received: by 2002:a05:6a00:23c8:b0:668:81c5:2f8d with SMTP id g8-20020a056a0023c800b0066881c52f8dmr8427462pfc.3.1690723088736;
        Sun, 30 Jul 2023 06:18:08 -0700 (PDT)
Received: from pop-os.. ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id 2-20020aa79142000000b0067ab572c72fsm434727pfi.84.2023.07.30.06.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 06:18:08 -0700 (PDT)
From: Anh Tuan Phan <tuananhlfc@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sdf@google.com
Cc: bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Anh Tuan Phan <tuananhlfc@gmail.com>
Subject: [PATCH v3] samples/bpf: Fix build out of source tree
Date: Sun, 30 Jul 2023 20:17:50 +0700
Message-Id: <20230730131750.16552-1-tuananhlfc@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
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
index 615f24ebc49c..cfc960b3713a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
 # TPROGS_CFLAGS causes conflicts
 XDP_SAMPLE_CFLAGS += -Wall -O2 \
-		     -I$(src)/../../tools/include \
-		     -I$(src)/../../tools/include/uapi \
+		     -I$(srctree)/tools/include \
+		     -I$(srctree)/tools/include/uapi \
 		     -I$(LIBBPF_INCLUDE) \
-		     -I$(src)/../../tools/testing/selftests/bpf
+		     -I$(srctree)/tools/testing/selftests/bpf
 
 $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
 $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
@@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/xdp_sample_shared.h
 	@echo "  CLANG-BPF " $@
 	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
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


