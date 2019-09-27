Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C9BBFC9D
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2019 03:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfI0BNs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Sep 2019 21:13:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40678 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfI0BNs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Sep 2019 21:13:48 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so11799368iof.7
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2019 18:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8j9rA1WD839oUqijh+Vh8zZRtr0Ej8NqAU1MM5cNTJc=;
        b=dX6f3lPvSg9p2xx0kSYYtSRW/JjhIx4eA1YpglOO+6kZKvxeJICogR/PdXk9SyluNE
         d/qt5V5/PUpkaX+OSSVc5kSdh/AmzoxZ5aMrEr4rEgwa7fil0v9ZZX4A34BfhjiZdyLo
         xxSwfEFenWsZrSvfYTJwR5aDCJitIxqWKE8tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8j9rA1WD839oUqijh+Vh8zZRtr0Ej8NqAU1MM5cNTJc=;
        b=QFYN8/SgXqBB0sGlGPlal7U4QSmLdTtAZ5/bz+x4dNQhmjXrRamdwCWkwmizjE42s5
         LEnaEae2KxT1f+u+Xisdc5eEmF0YASB0a9yDAv//V4jxmUqfN96rpVWZNJRpu1bzuyYa
         YkmgZZyJL/CqZIadtKazsUoI44m91/+buQKoGD4wmdg2JyCOdpqEvszK5XJfSuvj52q4
         MBvWjcvvok/vmXTLF/bQyu4KcMaDIdgiLgmyS8nyN3V3WMDcYpXFNnPkBG3UJ8KQK/w7
         n+/CyesEVX4NtmVqeKenxFMidXx9wHBw+ds3K612WJ1K7490qNeTtIjS1MVn1KJLYcso
         fcaQ==
X-Gm-Message-State: APjAAAVEgoUkwWy5Klivg6EBIZqk6N/nag0CmPVezBNNIo5BFV4KeQJ7
        Ohf70Hl+3HoBCda4PoC7X1wN3w==
X-Google-Smtp-Source: APXvYqyXeSPC+d9QdCWlvsXRPQVaxLUlT8C3HCTK3Kg9BOMblYLJYajtK7SPVki2xvpeDwPQEca/3A==
X-Received: by 2002:a02:1cc5:: with SMTP id c188mr6360952jac.26.1569546827184;
        Thu, 26 Sep 2019 18:13:47 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h70sm1907469iof.48.2019.09.26.18.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 18:13:46 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] tools: bpf: Use !building_out_of_srctree to determine srctree
Date:   Thu, 26 Sep 2019 19:13:44 -0600
Message-Id: <20190927011344.4695-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

make TARGETS=bpf kselftest fails with:

Makefile:127: tools/build/Makefile.include: No such file or directory

When the bpf tool make is invoked from tools Makefile, srctree is
cleared and the current logic check for srctree equals to empty
string to determine srctree location from CURDIR.

When the build in invoked from selftests/bpf Makefile, the srctree
is set to "." and the same logic used for srctree equals to empty is
needed to determine srctree.

Check building_out_of_srctree undefined as the condition for both
cases to fix "make TARGETS=bpf kselftest" build failure.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/bpf/Makefile     | 6 +++++-
 tools/lib/bpf/Makefile | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index fbf5e4a0cb9c..5d1995fd369c 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -12,7 +12,11 @@ INSTALL ?= install
 CFLAGS += -Wall -O2
 CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi -I$(srctree)/include
 
-ifeq ($(srctree),)
+# This will work when bpf is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is set to ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index c6f94cffe06e..20772663d3e1 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -8,7 +8,11 @@ LIBBPF_MAJOR_VERSION := $(firstword $(subst ., ,$(LIBBPF_VERSION)))
 
 MAKEFLAGS += --no-print-directory
 
-ifeq ($(srctree),)
+# This will work when bpf is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is a ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
-- 
2.20.1

