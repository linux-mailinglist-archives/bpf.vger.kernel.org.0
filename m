Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB9AE862
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 12:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406255AbfIJKiy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 06:38:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39910 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406214AbfIJKix (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id j16so15911637ljg.6
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aOBDMFi7PSb0gHyNeqqhWN1bJP3tg81RdsZh4BrKqUw=;
        b=dZCGaEuJIGUCPQEGK33Sn/a9ZXr1W2in9EPfmjnbwJAMCekhG6gPrUKBXtM9dA6Bua
         CO0ROLT22y9S3G5cB0fUS+NwtMDzJr6+L13qfksUvKAEex3h114d1QzyYZ8sZ6IjKuSt
         rkwhMTdhR2vjcycIZ/U4KfP6/DGiUOHzrf1z1Ykp5RNNE8nDy3evu9ck5pH876DEllqg
         sRw/k+zeukJc80NgALQN0hag/HPBhscdR5rSFY7PjS3o0+DYv3vwXnmOn0f1CoV9/JzP
         FG5HBwd3LzjMCIpehQQdiNtCwLoUdPyT7QvAmxLutks5bbQM/+usVCkuxFOtnq0+Q2uv
         9New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aOBDMFi7PSb0gHyNeqqhWN1bJP3tg81RdsZh4BrKqUw=;
        b=W5jUQRl4N+0FEu1kImb5aNCT+zHmsc2G6kP0dX0ii84owRtF9qLEoBCwXkoecKjwZO
         SB5FAR0YXZS/yiR5vgz9XazGaWav2h2BBF34XEiI/vR/D8EvreSj9D7qMHC3XfXfH7PD
         65LKd0hZV8AHj3Dl1gyWmwZlKlIsmwRSOb1GA4KQUCY/YA21coa+z2CTkullHc36ioC0
         4iu7AjXiHsfq+xTm+pmKAufAdu3psFaSQceousAJWYFHffPur4TzVDeULUCpCRiruZkc
         1APw9SZfVr8jBIctuVj03a1EDCkpFvTkJ4xelUwS1YKFZKWVPb30q2YUH+qlW1wxlL8G
         fZzw==
X-Gm-Message-State: APjAAAWo8DBFcsal0xgKJWkCDtWlpQiCC6VNHYdif18YqdZUHape+7Of
        //aTSn2LhvQbKVnzMHNCHsijBg==
X-Google-Smtp-Source: APXvYqyAutFjXRPV/VcndllZEPdk69aMXnYST9mSOt78qiRws+YgyCDmh/V5o8V9Ost00AHcM8xVsA==
X-Received: by 2002:a2e:8012:: with SMTP id j18mr19477348ljg.36.1568111930993;
        Tue, 10 Sep 2019 03:38:50 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:50 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 11/11] samples: bpf: makefile: add sysroot support
Date:   Tue, 10 Sep 2019 13:38:30 +0300
Message-Id: <20190910103830.20794-12-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Basically it only enables that was added by previous couple fixes.
For sure, just make tools/include to be included after sysroot
headers.

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
make samples/bpf/ SYSROOT="path/to/sysroot"

Sysroot contains correct libs installed and its headers ofc.
Useful when working with NFC or virtual machine.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile   |  5 +++++
 samples/bpf/README.rst | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4edc5232cfc1..68ba78d1dbbe 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -177,6 +177,11 @@ ifeq ($(ARCH), arm)
 CLANG_EXTRA_CFLAGS := $(D_OPTIONS)
 endif
 
+ifdef SYSROOT
+ccflags-y += --sysroot=${SYSROOT}
+PROGS_LDFLAGS := -L${SYSROOT}/usr/lib
+endif
+
 ccflags-y += -I$(objtree)/usr/include
 ccflags-y += -I$(srctree)/tools/lib/bpf/
 ccflags-y += -I$(srctree)/tools/testing/selftests/bpf/
diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 5f27e4faca50..786d0ab98e8a 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -74,3 +74,13 @@ samples for the cross target.
 export ARCH=arm64
 export CROSS_COMPILE="aarch64-linux-gnu-"
 make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
+
+If need to use environment of target board (headers and libs), the SYSROOT
+also can be set, pointing on FS of target board:
+
+export ARCH=arm64
+export CROSS_COMPILE="aarch64-linux-gnu-"
+make samples/bpf/ SYSROOT=~/some_sdk/linux-devkit/sysroots/aarch64-linux-gnu
+
+Setting LLC and CLANG is not necessarily if it's installed on HOST and have
+in its targets appropriate arch triple (usually it has several arches).
-- 
2.17.1

