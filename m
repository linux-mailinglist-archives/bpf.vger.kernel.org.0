Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57988B38CC
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfIPKz2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 06:55:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36839 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732551AbfIPKy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so5649911ljj.3
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MLJcNNJZkagwGK0zIyaqmigCmuc2QO9sJ0CkQCG94a8=;
        b=E9WHFu0TVM9YPIg7e9FZQRJiw7GUUX46qDnJ7XJhp3tzqNkGIEkdZ/VfJkd5CiXCIu
         soL1+mGe5drovecAMdpE93IRIhgR5mqv5Inm7FMZtz3sR+ufpAD/Vj+CYguj9jaX979F
         eFqpi/6RF90/XKCxiwnqHbTubyY2+/Q2q7UmsEzAUVdYX0iubLOvOOMtNb6rLhLftlI8
         LGDNDWirLx7qPTGiEj+xYJs+l+TAonQmkRLwyJcjWSOCrpnM1a9qakwXyDalWaCOcOpj
         avbgMt/cu6EWydrCF+LYQy6vWHBc6xfHcI6HCINSXEg03CYbhAha+4hat/DwPB08BSH0
         IXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MLJcNNJZkagwGK0zIyaqmigCmuc2QO9sJ0CkQCG94a8=;
        b=SL8ltAkzHKeDvcrXOO7FgI1mhfOe8CiFdllqOSZxGnXyLksosGkEzgStdaVY7jJtkS
         zhcMukshEopvYbp4P+34rSRBXZxzx4Hi1VALGroaqRVTUzP+ZzXFibOLcOG79L/o1sdX
         0pSfJT+OAxmgcgLkbytVjdc45wdwr10mn1XAA8Bty5Oe8y8PsYlOmtQV8Ikp5WN/8Ysa
         kKyQSq1g1bLm52htXYiH3eGoVh9CyTFb2ePVmQ18/B69xVSMVWNZ7zubffSgbU+IuomG
         rTPUIW89+NlDqJmaMsLoRJcShlzOdDeWjYye4l+0bVZCM+7ejABPJJ6S4/DId1ma5x6k
         Imeg==
X-Gm-Message-State: APjAAAW+Z5xAnxgNtphjd8shPk1eCeGx0ElOpfil2NFTV6XEA+v99n0r
        kzTokLD2kaOscs+Cu/9l5pqR/Q==
X-Google-Smtp-Source: APXvYqwG3Sc5PdJ1BDI/ndJboxqwuppsJ0jjMTGaqjlVv0sD9MuujWpRu2ErqSb6ATwnfxiTcaiRgQ==
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr2122827ljk.241.1568631294682;
        Mon, 16 Sep 2019 03:54:54 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:54 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 11/14] libbpf: makefile: add C/CXX/LDFLAGS to libbpf.so and test_libpf targets
Date:   Mon, 16 Sep 2019 13:54:30 +0300
Message-Id: <20190916105433.11404-12-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case of LDFLAGS and EXTRA_CC/CXX flags there is no way to pass them
correctly to build command, for instance when --sysroot is used or
external libraries are used, like -lelf, wich can be absent in
toolchain. This can be used for samples/bpf cross-compiling allowing
to get elf lib from sysroot.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index c6f94cffe06e..bccfa556ef4e 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -94,6 +94,10 @@ else
   CFLAGS := -g -Wall
 endif
 
+ifdef EXTRA_CXXFLAGS
+  CXXFLAGS := $(EXTRA_CXXFLAGS)
+endif
+
 ifeq ($(feature-libelf-mmap), 1)
   override CFLAGS += -DHAVE_LIBELF_MMAP_SUPPORT
 endif
@@ -176,8 +180,9 @@ $(BPF_IN): force elfdep bpfdep
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
-				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
+	$(QUIET_LINK)$(CC) $(LDFLAGS) \
+		--shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
+		-Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
 	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(LIBBPF_MAJOR_VERSION)
 
@@ -185,7 +190,7 @@ $(OUTPUT)libbpf.a: $(BPF_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
 $(OUTPUT)test_libbpf: test_libbpf.cpp $(OUTPUT)libbpf.a
-	$(QUIET_LINK)$(CXX) $(INCLUDES) $^ -lelf -o $@
+	$(QUIET_LINK)$(CXX) $(CXXFLAGS) $(LDFLAGS) $(INCLUDES) $^ -lelf -o $@
 
 $(OUTPUT)libbpf.pc:
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
-- 
2.17.1

