Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65610D19EA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbfJIUmR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 16:42:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42235 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbfJIUl7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so3848847lje.9
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPicZ6dKiXggVDaTmZsHbexmmGF0NBX0XkLCl2NE9e8=;
        b=kPel8NhRVnyQDF2w6QWADNKWtsbDrjQPr/EdHwNRDl4cLpDTWXyvgReDZ91tE3VFXh
         dXHtbNI4k24um1FnMS7LDF9GQriPKlXm2AfN93wb6AlJCjBcZ+1ovPI3gmCbHjz7YiUG
         VTdR6WGa4vqentsck08qtxZzbc8hvVkqXMbD3LMwWWynxWghejtOT4tGdHljpAs/7Ago
         p43hmGYeoMy4u8J0oJUns/wP/+M+48aW9ccDLPcj4/rU/oCy+pYw5NM9CgumGq3C6Bar
         V0Sd3jBn0QjysTdCA5u0gfWo6eZSg9xv2soEhRb0SroRn5shjSsYspO+3Hs+E+nHixXg
         0/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPicZ6dKiXggVDaTmZsHbexmmGF0NBX0XkLCl2NE9e8=;
        b=UI0AB5RMUjAZbbvbyURatpQ9MqzUNY+4Dqr5CmsF5xoNWXJq9UZ1KR3UQSzXiiKo5L
         po9cVPbh/cu3oHAGLBg9ZAIOMdB9YHOCH7jftTqDDbT0hkPHMW2+VR3kOaGhAYzwF8bK
         5WebpLy5cSQbscCTkMSodl9BFsgjIZHX8EYWTTsQOc203fpSMdj3dUEhQFlAHLYuEr6R
         MjYvWxkt/wPQjlzeltGGE7Tw4Avl918GhenM39Iepd+A9cIw0KhmDX5xmqjGI48rbjgj
         ybyegl7wOXgfpMM4supiOiX5840hZV47C5pqe0Bu9RkXJr+sUWM5Qd4Pgf690qapKSXN
         2gwA==
X-Gm-Message-State: APjAAAXeprYweL76t3SaSWYSI/hligio3Klg4TslPj+fezwHc2SAnpTc
        Q8vOoySKIeWxSSc7u5juvzBvfA==
X-Google-Smtp-Source: APXvYqzwWGi4GRBV7LqCTbrCRo2MAQiJrRU4pTiOllSLBVV5JYfE6TfutDsHiizQlpYTCl6wwSaK9Q==
X-Received: by 2002:a2e:2943:: with SMTP id u64mr3622095lje.241.1570653716268;
        Wed, 09 Oct 2019 13:41:56 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:55 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 12/15] libbpf: add C/LDFLAGS to libbpf.so and test_libpf targets
Date:   Wed,  9 Oct 2019 23:41:31 +0300
Message-Id: <20191009204134.26960-13-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case of C/LDFLAGS there is no way to pass them correctly to build
command, for instance when --sysroot is used or external libraries
are used, like -lelf, wich can be absent in toolchain. This can be
used for samples/bpf cross-compiling allowing to get elf lib from
sysroot.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 46280b5ad48d..75b538577c17 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -174,8 +174,9 @@ bpf_helper_defs.h: $(srctree)/include/uapi/linux/bpf.h
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
-				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
+	$(QUIET_LINK)$(CC) $(LDFLAGS) \
+		--shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
+		-Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
 	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(LIBBPF_MAJOR_VERSION)
 
@@ -183,7 +184,7 @@ $(OUTPUT)libbpf.a: $(BPF_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
 $(OUTPUT)test_libbpf: test_libbpf.c $(OUTPUT)libbpf.a
-	$(QUIET_LINK)$(CC) $(INCLUDES) $^ -lelf -o $@
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(INCLUDES) $^ -lelf -o $@
 
 $(OUTPUT)libbpf.pc:
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
-- 
2.17.1

