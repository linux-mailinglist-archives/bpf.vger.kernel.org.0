Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D6A2BDD
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 02:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfH3Avp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 20:51:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42624 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfH3Aur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so4804362ljj.9
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 17:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=baF6/BEW5KEVo2LOFkZZTRTkQs3Veu82MyQ6XaftpOU=;
        b=biPM7KPdLtnr+xQRNp5xESVEeouLUJKehD24Gd9ioxx2OUh6OIbrndSWFIo+qFylSI
         kWdpwF+J69U+3pO4IuT7c63y1CwY11q0cXDK5OXsQnG4N+5QSF0rdTNyreizSd4oQ8ux
         Am84VUumVDcjZ1RoEaa413ZVsTrv4I2GuzRZa59p3t9MedXqHlG7BxfFeXGP1smCN1Rm
         pj+FEwpD4ZadSIML4/3wTI9ldsdEy1/4SBL2pH8rHBRmKHSJVdGhBCPlnrs46hM1tr7p
         VF5+0TZbcNTyjM8g81MSG9ZbEwNHniA392B0IqMVwrg9G2ma9dMcEqh7oNjuVlu+1z81
         Z/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=baF6/BEW5KEVo2LOFkZZTRTkQs3Veu82MyQ6XaftpOU=;
        b=prM+zdLlxaH26TDcIg2zJtGZt9X79oKpKCbW6Ydk0Ir0VH3y1qU8PPRt7z6aPpccnX
         zAclFmd61xiiNQ1dO5HvyLdjZtTJiQb2bbAqAy4jMNKVWuy0wuFY+dn1lrXU+4WAHJlP
         c4y2H6ZSxb9Z9rIoy3ELYGS0EHN86kJ0HlXCIGQ3vMIksaIYa6F1vC7BB+lQrLrcab/e
         NZP3oikB8PIws3h7pZMu5msnLtSYSPiGm0wo5Gr5wVJCMpFGwFur+OAbdfIEOXugz/Pi
         tMiftogXUxhOPgi1Ql9sUFoFkgfPXtm+r94/qgTsKZc4ep1gFL8gEFdviBgG/Fqjuiu3
         FLuw==
X-Gm-Message-State: APjAAAV1T+1YIRyx28UvdMXWpiYWlCfSTVz9NAVwplMQSqkDKhZpxQYn
        1eLLlG9wbJDoTHOywMYPzw6qkBt8KXk=
X-Google-Smtp-Source: APXvYqwlf7D/N+8AETmyrADFpsR/4uDHEHGgehGXXJJxn9PraZ2fAYxITTtvWqzPcr0SP5k+C+brcg==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr6901426ljg.151.1567126245707;
        Thu, 29 Aug 2019 17:50:45 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:45 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 03/10] libbpf: Makefile: add C/CXX/LDFLAGS to libbpf.so and test_libpf targets
Date:   Fri, 30 Aug 2019 03:50:30 +0300
Message-Id: <20190830005037.24004-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case of LDFLAGS and EXTRA_CC flags there is no way to pass them
correctly to build command, for instance when --sysroot is used or
external libraries are used, like -lelf. In follow patches this is
used for samples/bpf cross-compiling.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 844f6cd79c03..d606d249e334 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -99,6 +99,10 @@ else
   CFLAGS := -g -Wall
 endif
 
+ifdef EXTRA_CXXFLAGS
+  CXXFLAGS := $(EXTRA_CXXFLAGS)
+endif
+
 ifeq ($(feature-libelf-mmap), 1)
   override CFLAGS += -DHAVE_LIBELF_MMAP_SUPPORT
 endif
@@ -179,8 +183,9 @@ $(BPF_IN): force elfdep bpfdep
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(VERSION) \
-				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
+	$(QUIET_LINK)$(CC) $(LDFLAGS) \
+		--shared -Wl,-soname,libbpf.so.$(VERSION) \
+		-Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
 	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(VERSION)
 
@@ -188,7 +193,7 @@ $(OUTPUT)libbpf.a: $(BPF_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
 $(OUTPUT)test_libbpf: test_libbpf.cpp $(OUTPUT)libbpf.a
-	$(QUIET_LINK)$(CXX) $(INCLUDES) $^ -lelf -o $@
+	$(QUIET_LINK)$(CXX) $(CXXFLAGS) $(LDFLAGS) $(INCLUDES) $^ -lelf -o $@
 
 $(OUTPUT)libbpf.pc:
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
-- 
2.17.1

