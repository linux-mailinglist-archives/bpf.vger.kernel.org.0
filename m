Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6E567829
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 22:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiGEUFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 16:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGEUFD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 16:05:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749F6167D5
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 13:05:00 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so8106366wms.5
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+9ND9gGDdv03MueNmUboLKE7fp+u4ZOtfMBglb+qFM=;
        b=MSjFFclrhQB6GcyXKubNcqzLwyOc83+SKMLlqYJnE2Ki2a7LHlP6I7OkFEWusLaXls
         95mLE2/hkX1bODVhwxAylRgMoIiZ9KHTRC+1QO6CeGa8P3y4Y3KzuD2k8A9191sAuUAq
         rdqJRLr1jcX/ufMOcWTtlvfjhHazK8Ps+k+qAvP+drnP/P1/51GA80g3cHr3VkSwJUr+
         J6zLY+2JAJuFcYSP9n9nwhFBoM5x+t14o0BQKzZCKuolmwyxpFZc3+BxH6WgbzSs8Q2N
         LAZDpjWosmRI6x9JPWkjlEPiGRu1e0Ko9cmrflBA2sgqEbaW2WJmVmAZwYiqmjPc/Lqp
         m2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+9ND9gGDdv03MueNmUboLKE7fp+u4ZOtfMBglb+qFM=;
        b=NOPyz2AJX350qJmpGosLmuZQBQw+1omRkZqrgNDRN4r+L6MljpEDto/p5ObqRN8skZ
         wTrJj8oGLO1UehdjE2hWUwXkvnWWlIUJHjX8sHT0nQXpkV2dSjrnXjJWIVYVQzgFxVCu
         4fRxmJvUQoQ8lapN041gE8ruad4NhsepdU/effRoOweFShXaUdXQmsItrb/B59sj+ojo
         Il/fLHYwCNUlu5JiiaFluml8XzqwBjTm+evqWsL4Mp2G1T758SaNcfBngF3T/NcOJQgA
         IZ8vrcT1uBNJJjdK+Z6ZYZ7lWsq1Oquy+AUqO2j/7t4OpOYoXTQAO1kg7dVeY65JWXHv
         8D5w==
X-Gm-Message-State: AJIora826NWGiHmKlC421zd8LPYGrTSRdDZqsxJoLz91jaRoZWH68zTT
        18b/ZYUg9086abRwyDv+s/SezgtazYY4VbmF
X-Google-Smtp-Source: AGRyM1sTO0BLYQsF5GZRzZkMwHEe/+p1FooN2FbYJgy1KdEvaM53Gf77cf2KD6EYaT/HMNc2uaM9mw==
X-Received: by 2002:a05:600c:1d94:b0:3a0:4e09:122f with SMTP id p20-20020a05600c1d9400b003a04e09122fmr40462903wms.190.1657051499044;
        Tue, 05 Jul 2022 13:04:59 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id az38-20020a05600c602600b003a0323463absm23552144wmb.45.2022.07.05.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:04:58 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] bpftool: Remove zlib feature test from Makefile
Date:   Tue,  5 Jul 2022 21:04:56 +0100
Message-Id: <20220705200456.285943-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The feature test to detect the availability of zlib in bpftool's
Makefile does not bring much. The library is not optional: it may or may
not be required along libbfd for disassembling instructions, but in any
case it is necessary to build feature.o or even libbpf, on which bpftool
depends.

If we remove the feature test, we lose the nicely formatted error
message, but we get a compiler error about "zlib.h: No such file or
directory", which is equally informative. Let's get rid of the test.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Makefile | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index c19e0e4c41bd..e64b81e1c1ba 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,9 +93,9 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd disassembler-four-args zlib libcap \
+FEATURE_TESTS = libbfd disassembler-four-args libcap \
 	clang-bpf-co-re
-FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
+FEATURE_DISPLAY = libbfd disassembler-four-args libcap \
 	clang-bpf-co-re
 
 check_feat := 1
@@ -204,11 +204,6 @@ $(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
 
-$(OUTPUT)feature.o:
-ifneq ($(feature-zlib), 1)
-	$(error "No zlib found")
-endif
-
 $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
 	$(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
 
-- 
2.34.1

