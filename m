Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5F66AE90
	for <lists+bpf@lfdr.de>; Sun, 15 Jan 2023 00:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjANXAd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Jan 2023 18:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjANXAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Jan 2023 18:00:32 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A347EE3B9
        for <bpf@vger.kernel.org>; Sat, 14 Jan 2023 15:00:31 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j15so16522791qtv.4
        for <bpf@vger.kernel.org>; Sat, 14 Jan 2023 15:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3XCi6AfxSAqS5zfTvqe8suxE7tzF8peDwUROyvJdd0=;
        b=DCvz3bkLZakEpTkPpr0XwSu/dWqJzzD2YWAY+4X20tODPd+44+2woBDINF6C7uavGE
         AFTr9bhlIK4sYaWzqEJmomyk79njyBOlnElNd3+5Rps98ZI84gaEsfE9zyATVnfNXZYK
         W+UnBkv5gQcCvTEjV02mQ9yo4neMJ3xGyVMrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3XCi6AfxSAqS5zfTvqe8suxE7tzF8peDwUROyvJdd0=;
        b=aW2AxZ3BkCoe1B8yj05oDf6XgvBlXda+7Iu0p/T2m4QXBgTCGl4qWy+pacvytSn+fT
         yGpzP5kIMYA18SUkv3kottUl+3TsBojRTlqm1UKeVT0iz/r9OlMZ+96uMqDSHFTLtVdn
         OJV5kZndFm6huAfTxqAnqQyVvYFd1NM5LHt62/ifiO2RjxLuWpfo7RpaVaBqGgUV3Wuu
         NRThU4ApNQOP6mAYrVcfTnVWXmmKMQKjjCyqknsAqQdz78rIGPVGNMgT1z4b1FO6PLBS
         juBYO4rZ+z3OiTPbB70pRC77jCpK8PZd4c31pLR6XrUSvDx2GXwwu6ZgaLNMyAD8Cx2a
         BXqg==
X-Gm-Message-State: AFqh2kqOG8RBG1ALdCmq5MgFdAY/xprYXoM2DU8E9otbr/Ti48EwhMph
        q+emvGWZlXHqzfst+yufDfAXFw==
X-Google-Smtp-Source: AMrXdXtV8kzhjM0mYYtQvEKOs5VCP5FkGjdffWhpq0GZ23j78oKYxQYXe68DedpEtslq0G1ShXI9ig==
X-Received: by 2002:a05:622a:4d47:b0:3a6:46b4:2a6b with SMTP id fe7-20020a05622a4d4700b003a646b42a6bmr132730359qtb.27.1673737230600;
        Sat, 14 Jan 2023 15:00:30 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006fa4ac86bfbsm15132169qki.55.2023.01.14.15.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 15:00:30 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Sat, 14 Jan 2023 18:00:18 -0500
Subject: [PATCH] tools: bpf: Disable stack protector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAAI0w2MC/x2MQQqEMAwAvyI5b8FUobpfkT2kGjUHu5KICOLfr
 R6HGeYEYxU2+BYnKO9i8k8Z8FNAP1Oa2MmQGXzpqxKxdnEdXYsNMfoQQyDIZSRjF5VSPz/tQrax
 PmJVHuV4993vum5craNsbgAAAA==
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673737229; l=1810;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=QjHX5cBfbMx9A2AI5fA8Eg+Dzw4jlnZ+WyV+BAFRgnE=;
 b=SEteZLNsaPCTQYt40+vXrNdYOdi+lpPaAj0mBIbbUzFE4hE2tqD65Jb57PS7BkA4E8FTe4SJf0h+
 PnvXw2BLD200psGUovhBHMkygtVbohD3sm4+bOBG6vI4565haZmp
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Avoid build errors on distros that force the stack protector on by
default.
e.g.
  CLANG   /home/peter/linux/work/tools/bpf/bpftool/pid_iter.bpf.o
skeleton/pid_iter.bpf.c:53:5: error: A call to built-in function '__stack_chk_fail' is not supported.
int iter(struct bpf_iter__task_file *ctx)
    ^
1 error generated.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 tools/bpf/bpftool/Makefile    | 1 +
 tools/bpf/runqslower/Makefile | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index f610e184ce02a..36ac0002e386f 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -215,6 +215,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
 		-I$(or $(OUTPUT),.) \
 		-I$(srctree)/tools/include/uapi/ \
 		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
+		-fno-stack-protector \
 		-g -O2 -Wall -target bpf -c $< -o $@
 	$(Q)$(LLVM_STRIP) -g $@
 
diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 8b3d87b82b7a2..f7313cc966a04 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -60,8 +60,9 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
-	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		      \
-		 -c $(filter %.c,$^) -o $@ &&				      \
+	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		\
+		 -fno-stack-protector 					\
+		 -c $(filter %.c,$^) -o $@ &&				\
 	$(LLVM_STRIP) -g $@
 
 $(OUTPUT)/%.o: %.c | $(OUTPUT)

---
base-commit: 97ec4d559d939743e8af83628be5af8da610d9dc
change-id: 20230114-bpf-918ae127b77a

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
