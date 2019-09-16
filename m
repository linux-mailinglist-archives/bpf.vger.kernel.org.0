Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3360CB38C7
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 12:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfIPKzP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 06:55:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44809 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbfIPKzA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:55:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id q11so12131147lfc.11
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L1rbvOW+wQJfkI127ZZlgGnuYj2RYmEzxNGLFnF8DNQ=;
        b=o+zzeQpt0mAYpx6mc2RIjYCWYyOjhTHqnHHulW/RKWFhLKUdVgrqTTPr3iHy5E374v
         gG4cPe1wWsiBBnufog5HnjOQF5rH/3ruhSqJGzFNCB3Tx7RBfcMe458xx/vcOVqdU4ts
         H/5JFK4Mt4r8nE+O035eNaJztJhlPuKngB+tr//LANN79yG1GKmd28Rk5SiJlpiZykoJ
         V2B4/S10B+jsSXXcJqch1uNJyQ2ORizv9Nrw2rUMutmDleyxOSRakaDYiVvDKRcMHhej
         Po+om1loSyc7BuoEjEhiDxDFLDwFH2Zx5+OY39T98MmR5JOB2iRCiX+TxdT2sBk1zq5o
         cVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L1rbvOW+wQJfkI127ZZlgGnuYj2RYmEzxNGLFnF8DNQ=;
        b=q4i32XxEwbOusTtZboqQQE8QsyGxu7o4vQpGxkOWuOOEuhEskC3Aa5BIzQ430JcRTt
         7LTS4EV/zMidaRHOVwjdKB6KEiygQgupIDR9zG6bdsDGi37CYUgULN2v82sGXaxzII0L
         MbwBTHgrceE5tTl0rmfOW5F0yQsstW9kHAOAmscfHmN482Q0zY10LxPTmaZIx6zUtLLs
         Laq+YqI4LnIdso4zZqiAWMPlL6VbRw1nABMQGYAgQi2xn6EzYm+N8D3Cx4BKRNjTGsNk
         kaQm1HqHVDHWMzvEcJvrHttWLRbomxtPQqZgbw5ZecADb5B8bcOPNSdvQoz1N6IwWfrH
         WN/A==
X-Gm-Message-State: APjAAAX5G8rCcZM3bFi1KBMurorRZot8PAuuIeNHZ+/fusYfZs9v2r5c
        DWmiRJHYJU0XQJX5jeNAetjQOQ==
X-Google-Smtp-Source: APXvYqw+IShRYsfCy6UuVP1nv9ec7UYDVaoYikIxgQwnNQBgJGl+EwStDh+PySmzILReJ/PEBeHdIQ==
X-Received: by 2002:a05:6512:251:: with SMTP id b17mr16802393lfo.35.1568631297220;
        Mon, 16 Sep 2019 03:54:57 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:56 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 13/14] samples: bpf: makefile: add sysroot support
Date:   Mon, 16 Sep 2019 13:54:32 +0300
Message-Id: <20190916105433.11404-14-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Basically it only enables that was added by previous couple fixes.
Sysroot contains correct libs installed and its headers ofc. Useful
when working with NFC or virtual machine.

Usage:

clean (on demand)
    make ARCH=arm -C samples/bpf clean
    make ARCH=arm -C tools clean
    make ARCH=arm clean

configure and install headers:

    make ARCH=arm defconfig
    make ARCH=arm headers_install

build samples/bpf:
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- samples/bpf/ \
    SYSROOT="path/to/sysroot"

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 133123d4c7d7..57ddf055d6c3 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -194,6 +194,11 @@ TPROGS_CFLAGS += -I$(srctree)/tools/lib/
 TPROGS_CFLAGS += -I$(srctree)/tools/include
 TPROGS_CFLAGS += -I$(srctree)/tools/perf
 
+ifdef SYSROOT
+TPROGS_CFLAGS += --sysroot=${SYSROOT}
+TPROGS_LDFLAGS := -L${SYSROOT}/usr/lib
+endif
+
 EXTRA_CXXFLAGS := $(TPROGS_CFLAGS)
 
 # options not valid for C++
-- 
2.17.1

