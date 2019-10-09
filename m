Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9FFD19F5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 22:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbfJIUms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 16:42:48 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:46142 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731992AbfJIUls (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:48 -0400
Received: by mail-lj1-f173.google.com with SMTP id d1so3828869ljl.13
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q8GViA3rslKXoIblVB14HOdim3G08AtxcYrIekVeHcE=;
        b=pfrCF401TvMKnGGNl+mGcNqDCp2vUaNFpxEHOZUq1XK5MSPm3P1fYAf7wPUa+ETpQy
         VOVS4CBzr+1pxsUk6OaY9H5cdbJJGJ79afBvAVM7dhtqB3p/rgd3mhnIdLqFLvDK0mTd
         g0BL+HT0f/ysat5klwdZ82W7ujyD7W84PDhXsN3PpZ6AVA+ItryF/xgSXb9ZFPZ0XQH8
         bbDmHihjaFmyodxwsKWZK1D9NAxKeEqJpo8wMBZLQH4UaAtgHRCn4mApNkvdxUcnXGbV
         DQg/S8s66IiuaM28TVfm+AHtC3W49BgIRvSedebxXVHbJ/nrr4jh4KffMFSzscaK04Ud
         MiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q8GViA3rslKXoIblVB14HOdim3G08AtxcYrIekVeHcE=;
        b=f4ArjmAteFTCBU0rYyMkHJJdNMHThDF9CYSxF35W4pFDHYAiIfM4LBRNcmDAt2z7Ez
         pb4u2FM1eJZlOhxMkOr2ocJ7BG+ndmg8ykopheEpWoPmVTkTiRxbc7rLd86nNMqgFuLe
         175iFNh2cUuQdze7K4H23WqHdENxnYTtx1MZHtefvD1rdvhgTTpZGYLHKfR0TEHuyVo7
         aCQXCqmH40f/9Otc8eXM1MaYcT2y8FKpOZmcJWKcuXci3tZwX5r0FdOnuK7heGYiW9Hx
         ehgwDjbwh4vWaLAAzi7JDIjgE16ouK4zn3NCJcUkQu3UbWja9zROOZ/gj8v4OWcHA/3g
         cxMA==
X-Gm-Message-State: APjAAAXq1/cdGJzCnIPkZqJ8XJCTvpsrC13yW61xVAU8YXwugwUAG4/E
        zC/mQ2b55yx1sl+zrEKjx8U2dw==
X-Google-Smtp-Source: APXvYqxuctn/aA7ZrMAT8XQt+9VdRu1DrxUiAKw6n2hPLrMceayMK9zf2VM0qBBS8IA1Bb4098YjEA==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr3652941ljj.4.1570653706617;
        Wed, 09 Oct 2019 13:41:46 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:46 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 05/15] samples/bpf: use __LINUX_ARM_ARCH__ selector for arm
Date:   Wed,  9 Oct 2019 23:41:24 +0300
Message-Id: <20191009204134.26960-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For arm, -D__LINUX_ARM_ARCH__=X is min version used as instruction
set selector and is absolutely required while parsing some parts of
headers. It's present in KBUILD_CFLAGS but not in autoconf.h, so let's
retrieve it from and add to programs cflags. In another case errors
like "SMP is not supported" for armv7 and bunch of other errors are
issued resulting to incorrect final object.
---
 samples/bpf/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index cf882e43648a..9b33e7395eac 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -185,6 +185,14 @@ HOSTLDLIBS_map_perf_test	+= -lrt
 HOSTLDLIBS_test_overhead	+= -lrt
 HOSTLDLIBS_xdpsock		+= -pthread
 
+ifeq ($(ARCH), arm)
+# Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
+# headers when arm instruction set identification is requested.
+ARM_ARCH_SELECTOR := $(filter -D__LINUX_ARM_ARCH__%, $(KBUILD_CFLAGS))
+BPF_EXTRA_CFLAGS := $(ARM_ARCH_SELECTOR)
+KBUILD_HOSTCFLAGS += $(ARM_ARCH_SELECTOR)
+endif
+
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
 LLC ?= llc
-- 
2.17.1

