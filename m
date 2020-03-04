Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B1179B90
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 23:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbgCDWOX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 17:14:23 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42655 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388483AbgCDWOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:22 -0500
Received: by mail-io1-f68.google.com with SMTP id q128so4192358iof.9
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 14:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yZwBZUwL8PIwAcU8o7bWc8CP5XNPRFSTvCyJ7jQ5mQ=;
        b=I4UUtFHvX08Sx91UacVsT5PS2tj7qzVvr6l/ln4WrvjZxc/i8jv/oFJQOcNxDSmPBd
         ybh5nq8cpARJYCIJvgXwLurW1TEnq2g9Nv81GdPBn4liETzXdczFoTIvy6Zw3R1y+sam
         aa2bFrPARsOlrcGFyug0jM1U6XwTvVb4XBbbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yZwBZUwL8PIwAcU8o7bWc8CP5XNPRFSTvCyJ7jQ5mQ=;
        b=hVZcnkATYfrqFvoJTfY4IncwQwbhyzmKbZ+A6c2vCB0gP+h5dN+NK5HBSe7JPJ9C+9
         DOUCchihCpSCKvfDGo0ZSgop6bK2LgwXhO60tBS2/aqxCQENEuvmbvvyzlqPIsgVxfq0
         1RyJ/MIwyRmIvVFxqVx57Ob1dBnYfVq/utxmvwTqdOuOPW5uidUJL0VPSUHRjlSIUTYS
         4Rf8AaEujy1CPSJucs5wHzoUu/60HN3x0NhWNw9+Oty8G2zZCuIFxfixYPgm8pXVqARi
         eCAhBJ1Vkih7iedUs4D94InV4wX6pI7k1YywFK+/VuZQexNWovK7o+pjvA/wG0NCLimR
         eeUw==
X-Gm-Message-State: ANhLgQ3+JdaH8lgbeSiN/qt3G0VY58zx8KOjS77X4SXJt3nVlqLyPoXa
        clF0Yg7TCqP2O/eCZ8XArZJjBg==
X-Google-Smtp-Source: ADFU+vu9yfqsq5F9oa+zo3RCZeuK0hGfEJ8oFClTaKU0IJAaGmFuBoMBmSAKAqtJ7WlWRbKZ5R7jew==
X-Received: by 2002:a5d:9697:: with SMTP id m23mr4104634ion.45.1583360060224;
        Wed, 04 Mar 2020 14:14:20 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:19 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 2/4] selftests: Fix seccomp to support relocatable build (O=objdir)
Date:   Wed,  4 Mar 2020 15:13:33 -0700
Message-Id: <11967e5f164f0cd717921bd382ff9c13ef740146.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix seccomp relocatable builds. This is a simple fix to use the
right lib.mk variable TEST_GEN_PROGS for objects to leverage
lib.mk common framework for relocatable builds.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/seccomp/Makefile | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 1760b3e39730..a8a9717fc1be 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,17 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-all:
-
-include ../lib.mk
-
-.PHONY: all clean
-
-BINARIES := seccomp_bpf seccomp_benchmark
 CFLAGS += -Wl,-no-as-needed -Wall
+LDFLAGS += -lpthread
 
-seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
-
-TEST_PROGS += $(BINARIES)
-EXTRA_CLEAN := $(BINARIES)
+TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
 
-all: $(BINARIES)
+include ../lib.mk
-- 
2.20.1

