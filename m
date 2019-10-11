Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A62DD35F5
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 02:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfJKA3E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 20:29:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42901 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfJKA2i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so7996823lje.9
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wbL2nu6acnton90gIbsX5qxq9tLlNkmN4RUryN8fm7M=;
        b=KZ4g7bs4fOSGzk9FRyjF0hoqEh7hKsbUdY26yluEIfz8HrbcVogNxnuyoe/hxPcvfY
         TkU3hAUOhkLrtq5AzSARGyoZtpIAwa6YiJutpgj2IfhDFd7rccQbQb6TXAJO3UHkSoTS
         KVLv4z+Y+wn1/bGde0X3XLQCzqxwzgrKWEYXuOOv5w100VI2wuVg8Z1pJWKOOw2QGMIu
         xAD92jGqtR5FbkoIFvEdmTYUmuUV51K4APESpxgabNPn1RethPshg4jMreKr/ZBPFC6Z
         mKPdfQ4ukG2GmYFcT5pC+tXxG/DwLE1KaehHzD/wBCkNIFKCnOdDqIYiyjJkoVevysU6
         FEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wbL2nu6acnton90gIbsX5qxq9tLlNkmN4RUryN8fm7M=;
        b=Jq8fodva2vJy4h5KdtxWLEB7NRpv7/fsSvqPClN8BsTLm8IJvOftOLKg6ii8WoCgXx
         wbsx59AOB7pdzEEDZlkYoes7NQfLIMtK6pdSadD3K2t2ZBbrnAr9DYGWlE54c1gVIVix
         FgWO7feaWbSV5nt9W/ip8Fx7CfDhZL7scyEh5vcrvxwYDcSypVEWwgmjYo6mxEofbyIt
         z6Ge2deSD/EhUlvZ2f4rkR87P407LLh6WS024zBpgA5mdEDTKCJ79yIphyFwfBnlv5Ky
         +1Yh1Cas30I6/AZ29GnxlCT3mAqjIVtBCSDIiKie4rUYB2OyGIiqeEtux2bPOueBMeSv
         nP6g==
X-Gm-Message-State: APjAAAUMK0uwMs4y7yb6qlU4lptmIKRaeLLcEM0C2oU8GxwiKCV7B4nD
        ELfhC2VUZ/S0DDJZnjTK4PVBUg==
X-Google-Smtp-Source: APXvYqy9hnP8VV2RBY2j/1IOquHYPBvEdhG4CzJDaEV75yWkYlbvEM/9W8Q+EDRq2LWuZlNNlkmCxg==
X-Received: by 2002:a2e:89c4:: with SMTP id c4mr7438097ljk.65.1570753714541;
        Thu, 10 Oct 2019 17:28:34 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:33 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 10/15] samples/bpf: use target CC environment for HDR_PROBE
Date:   Fri, 11 Oct 2019 03:28:03 +0300
Message-Id: <20191011002808.28206-11-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No need in hacking HOSTCC to be cross-compiler any more, so drop
this trick and use target CC for HDR_PROBE.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 57a15ff938a6..a6c33496e8ca 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -205,15 +205,14 @@ BTF_PAHOLE ?= pahole
 
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
-HOSTCC = $(CROSS_COMPILE)gcc
 CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
 ifneq ($(src),)
 HDR_PROBE := $(shell printf "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
-	$(HOSTCC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
-	echo okay)
+	$(CC) $(TPROGS_CFLAGS) $(TPROGS_LDFLAGS) -x c - \
+	-o /dev/null 2>/dev/null && echo okay)
 
 ifeq ($(HDR_PROBE),)
 $(warning WARNING: Detected possible issues with include path.)
-- 
2.17.1

