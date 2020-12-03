Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CAF2CDAB9
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgLCQEs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgLCQEr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:47 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A8AC09424B
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:03:34 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id o203so1479063wmo.3
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IbyQm/n8+pi2q0Ky7fqqHIueT8J7malorhV/m8hIHd0=;
        b=Nurb0bQUXgEwLKlH5E+dwxUOfz6ZXl/yQpQCvW3kVvQiJ2raqNbOIazSDz9hNWteRv
         +LvxNCxOuTAnxMk8JjZ3Qtj2MFeuGLY/cCt/E6bvMZKUtwH/Vr5zo88LCYux8jXHt9IL
         iP2g4OF7JFbLDleVFjYUSBewEgColqkcr4Bhr7k79rR08y33F1Su5i8Zg6eU093n9HP3
         8rnyG4VwE+aTRu1+LOCCnKtEcbyaBSvkluzY+ijUltDeczBfmQSdqiBLSoF4nkXe6QQx
         EtbumVv2MTkwa8D38k+kIrgtW8GM2AFDu40LM8e+C89nIA5kGZK/MYSzZbUNVfnPzZOS
         ZLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IbyQm/n8+pi2q0Ky7fqqHIueT8J7malorhV/m8hIHd0=;
        b=EQvYVAg9bX6CzKl93dYE/YIHzUjE5ZCirc5DfmcddZH+9Ve88dVeUqnNRd1+sBN9tu
         K//LO2eRxjaTWmMhwBNiPzbV6al7kj0skc5lJsMHWzT5v5hcmDjpsWHoBvBx74i6jICG
         umDLD83H4vbwPL7X7oVliB2r+ByBhTBL03eqfwZUEGbVGAi5cHO3guh31dJOqWbZpqJ3
         33RLrqY+Mo7tfISbVytpGwgOugr5yOEbu/QkHx+toirZKVP0JLE6uVj6Q3QviwDoyJGc
         FCVTcVCVJEXgVALcE3fVNyGLV5FqBliXaxUQXn32oFGsbFTjCoBosLP3wRwCRE1SR/CX
         JbJA==
X-Gm-Message-State: AOAM531W0ngIUeylEKkdFiUN2sLlVF+tp2Jwq82EyfaXfoSlaBRwIhO0
        PGSUnXKH1oBsa6UeJL4wdfDUNjGSpB3YwIIFfGo9WOZR/2FSG6dioFMQftvBXsMjGxgNEvUEhGO
        9rllfBS/e+qfXrfDEsnWJcsiq+YSsp0p+QCx4QtGihP3bUBixKp/CUCKMXHg9QbU=
X-Google-Smtp-Source: ABdhPJwODx9KkTc4wAZ00voMZnuvUvFetzDzkNineD7k8tCokZqHIMO8OE449/1wHAHd88n53eCq7kCl9djk9A==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:3d86:: with SMTP id
 k128mr4029962wma.66.1607011412987; Thu, 03 Dec 2020 08:03:32 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:42 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-12-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 11/14] tools build: Implement feature check for
 BPF atomics in Clang
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Hebb <tommyhebb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change-Id: Ia15bb76f7152fff2974e38242d7430ce2987a71e

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Hebb <tommyhebb@gmail.com>
Change-Id: Ie2c3832eaf050d627764071d1927c7546e7c4b4b
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/build/feature/Makefile                 | 4 ++++
 tools/build/feature/test-clang-bpf-atomics.c | 9 +++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 tools/build/feature/test-clang-bpf-atomics.c

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index cdde783f3018..81370d7fa193 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -70,6 +70,7 @@ FILES=                                          \
          test-libaio.bin			\
          test-libzstd.bin			\
          test-clang-bpf-co-re.bin		\
+         test-clang-bpf-atomics.bin		\
          test-file-handle.bin			\
          test-libpfm4.bin
 
@@ -331,6 +332,9 @@ $(OUTPUT)test-clang-bpf-co-re.bin:
 	$(CLANG) -S -g -target bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
 		grep BTF_KIND_VAR
 
+$(OUTPUT)test-clang-bpf-atomics.bin:
+	$(CLANG) -S -g -target bpf -mcpu=v3 -Werror=implicit-function-declaration -o - $(patsubst %.bin,%.c,$(@F)) 2>&1
+
 $(OUTPUT)test-file-handle.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-clang-bpf-atomics.c b/tools/build/feature/test-clang-bpf-atomics.c
new file mode 100644
index 000000000000..8b5fcdd4ba6f
--- /dev/null
+++ b/tools/build/feature/test-clang-bpf-atomics.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Google
+
+int x = 0;
+
+int foo(void)
+{
+	return __sync_val_compare_and_swap(&x, 1, 2);
+}
-- 
2.29.2.454.gaff20da3a2-goog

