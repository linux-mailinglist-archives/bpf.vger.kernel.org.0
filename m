Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0CF39A6A9
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhFCRIF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Jun 2021 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFCRIF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Jun 2021 13:08:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D55C06174A
        for <bpf@vger.kernel.org>; Thu,  3 Jun 2021 10:06:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id og14so5006000ejc.5
        for <bpf@vger.kernel.org>; Thu, 03 Jun 2021 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDiaveGReuaoiNMHxszkQB0RlZZMsAokFGbSq8UB4Sg=;
        b=ul0PzCbFupLkCpnVctCVIeN1BTPpbb4qaF2yEbAOkQwupeGm6ujM8tmniAir2+dS3H
         srWjWRdlEG4ENPRoIMOyBEJzF0Qc07KRl++f8/VNzcSPtVw+sohbpC7itEDApvRYFKbQ
         A8FM0Sjdlz24dXUKPyv24L230d2V1zQegUed6o6evvzlEQak5tI0LTis/qjN9EdtsgOR
         amv95kzOSLdDp87234fekUmQgq8CZjhBHrD/IuisTDfPb4Me26pI9a5YRGV9RCKecC29
         yhIK5ytSh83jYzUeECNph7QYizHn2BUW26u+7sWyoeNvID8PhVIEICVH527eJdH7ynnq
         e2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDiaveGReuaoiNMHxszkQB0RlZZMsAokFGbSq8UB4Sg=;
        b=K1q6YBjJN7/x8qPTvxOK/P1bxlJvkQ7J2kXpHGdfeCU2nzD+nh09leomMbdw7es1IK
         RQokX5LxurqgZzSDPLV89RhOxEnNOUr7I7sRRJTtxJ5Krr1aKBS/x7Gj3nwrrrvn/58A
         ihe+WNhKE+Lh3RpQlVOjfnt33Pm6o/kYu/nDDn9V9WJtsWBp6UcWxP32drU7iWzk1TQl
         5yMRJVxTLbrdKKZ9SFCbY3P2ydNKlxIyWodReCCgzxHichtkdRbZCeoJMAO87tyDXwvc
         jfQGK1k6ZpSn5ib/nXnR30E5pcRwES0l0PcE1I3CxT01KeBLr0suqWgCW3p4wGF9dkcp
         W1Pw==
X-Gm-Message-State: AOAM530cneTRMt8govLzO78x/UeS1WHuFHy4qrTJz51rkd5xB9CCg7kq
        C76FxdcgJvCiKq1CskWNUy9ZDQ==
X-Google-Smtp-Source: ABdhPJwBRx1J//3jL7Gw8fCqJDbMKaS7HfwCTl2U2QAOhq8iZGMybt/8ui52bVhSCPekoBE82i1k0Q==
X-Received: by 2002:a17:906:2a41:: with SMTP id k1mr334826eje.177.1622739978667;
        Thu, 03 Jun 2021 10:06:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id t18sm2060199edw.47.2021.06.03.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 10:06:18 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next] tools/bpftool: Fix cross-build
Date:   Thu,  3 Jun 2021 19:05:16 +0200
Message-Id: <20210603170515.1854642-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the bootstrap and final bpftool have different architectures, we
need to build two distinct disasm.o objects. Add a recipe for the
bootstrap disasm.o

Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/bpftool/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index d16d289ade7a..d73232be1e99 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -136,7 +136,7 @@ endif
 
 BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
-BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o) $(OUTPUT)disasm.o
+BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
 
 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
@@ -180,6 +180,9 @@ endif
 
 CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
 
+$(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
+	$(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD -o $@ $<
+
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
 
-- 
2.31.1

