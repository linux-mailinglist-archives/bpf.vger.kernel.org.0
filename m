Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A396B38CA
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 12:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbfIPKzX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 06:55:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38296 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732544AbfIPKy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so6301843lfc.5
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9NLfs5AbYJF7ESK5xuIslXoD/IqVsX2Fckqfe1g6VEo=;
        b=cgMjU9VgF66MpK+7cYVgFwTXHUUXY3RP+fbPS5mQhKXJebmvwfYOjylIzcce/vVR2v
         S+Q2ARJDsEjUmMLBvWPgyIemeej5MAEsmwCTWAXgyiGhlec/IcmFIuHE2w4MGODPMnAL
         bgDdARhEqXqiXSVKGttt9Ic2kiDIxJTYWpr2QZ7eq3Kq+vb+xaaUiKWqbP9RCl+1FVGm
         wfSdI25syQcaHAndrFmcwKOMieb7zGLpuNLod/Jgak9EvgP2vCbT3KakYeCI222YAi3Q
         rIJRdyU1aAK7zl8igzE+e9wcGVBm2kmpvFM6x9RBSAu1gfp0/WZI11dbglu9eIbMMPe8
         0n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9NLfs5AbYJF7ESK5xuIslXoD/IqVsX2Fckqfe1g6VEo=;
        b=J4G8M1B9qq1i0qcCfZNoWPDwqCYf8WYdqw5GSlPXLCrnFVbeS0icoJl/LGJ02C4LId
         Uyi3+MJj7JrzMlljg/PLrjZenZJHEHKA/oO1ut80KBr/MCNjEPmvDEw7OJkywRptbilg
         RO0bBrYPAXzNRAN8s3GMp4236OExwgFR/Pi6ySrPivtHojRcpVCTfV6DP+h4DIrXkKBW
         VKq1oeU/WgtGKGhmrpFZ0ysiPj3XTiGUeTMpWAwssC/YlO/K8cZigRAZYWTBaqPKNrWP
         Gg0+5wDaKSpH8nuE2G/9/equEEBkhl3+Jjn26zKfzR7x3ydsMdGoztq1rqvYPsEWwXB0
         J83g==
X-Gm-Message-State: APjAAAXekcAM4Nc9R36cjhd4nwUr/2jMahcrbyLk8gnSV+3e4KMw5tSD
        IJUTCNvKUuVlCGMxpi8wpfk6mw==
X-Google-Smtp-Source: APXvYqy5rXpPGbBIsS2Xs24nn7pskO84cmqAOdnBucJG9wzJR6f8tLHNvHsrmbiR8vWLgF0rsAnH1w==
X-Received: by 2002:ac2:5a19:: with SMTP id q25mr15112277lfn.178.1568631293376;
        Mon, 16 Sep 2019 03:54:53 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:52 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 10/14] samples: bpf: makefile: use target CC environment for HDR_PROBE
Date:   Mon, 16 Sep 2019 13:54:29 +0300
Message-Id: <20190916105433.11404-11-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No need in hacking HOSTCC to be cross-compiler any more, so drop
this trick and use target CC for HDR_PROBE.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index b5c87a8b8b51..18ec22e7b444 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -214,15 +214,14 @@ BTF_PAHOLE ?= pahole
 
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

