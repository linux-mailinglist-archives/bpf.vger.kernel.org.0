Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A80CAE86C
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 12:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393863AbfIJKjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 06:39:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46571 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436569AbfIJKiu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id e17so15856281ljf.13
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Ec4H0Qe1jdzuqdUWFKh+P+h2+Aff+D7k9SQeZ/p30E=;
        b=RTYn6wq8HZB0SSigIWSrQkukTm2rdfngleNyu72MpsqM1lASZH9QE0Y6SHFkcdPW6t
         SUOlRyMvW63YiViGvW+w5uk9hhQHo6nROk5fexs4TrYZfHMoghxAmfs8Fi4tYH5bhdAr
         H016Wcl9zaGW2Qpi1EEMaMjyWk9fKH9Fhqh8Z4QDBgavFL0xuFAaOgfeMMcsQXpirM/U
         /hK3lqrFAb7/Jgtpp0I4jcHmrSqHFOf/1N5hxkhhF3nYHCoFtapOmz5fR/J9tPgo5aHB
         vvWGKjSkJB1FQ4JwvfFF2A/Grho+rsOw6/naVUBStw26OlIwGjwsmVM6X3/T103Kh1kT
         rUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Ec4H0Qe1jdzuqdUWFKh+P+h2+Aff+D7k9SQeZ/p30E=;
        b=pCNjPak1VHu0dmh8w0CtkcWqx07vrZvWtrtnrh5ZZN2/p8GUDJi2h15r+/E1nw/Cog
         0dFIFcKtU1NsrTTLjOsuXec0U3oetwXJiOlS2TWvcL6eLgQ4KDG/4SANnT1/D6G8RsRb
         ln+eV0tTXlQFGfPfALYIvVWDl5MAlrn3Bpu0lZTnlHujoxPfZ0ONA0mHDdkYfZOzAWaw
         ruz5dDpMuHW3o6G1d7X6KjnoXpb09wlGcH+B7FPG0sHm30syOVDe68CNO2k3d4J6Kyrt
         mo6ZU4BKC0wFUAdP/LwjxMORu6nm7/cckf/U58ILWS8r7CnTtt9A59eGvjWdjUwXP+Vg
         qDFQ==
X-Gm-Message-State: APjAAAXbkqzQARexO7/O8hAJNT5g/6UeRl46IuQvXDMuKKLfZopLyJyh
        WeJCMS9CGixSJUe4gsEa0JR03ac3SaA=
X-Google-Smtp-Source: APXvYqzPB+B0bg5nLoDm5HKJeXxgAipfRshWy6+hrgOhOjmn58JdlEAIpXk1Ak2vmtOsyQpizW3Efg==
X-Received: by 2002:a2e:7210:: with SMTP id n16mr19306668ljc.235.1568111928714;
        Tue, 10 Sep 2019 03:38:48 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:47 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 09/11] samples: bpf: makefile: use CC environment for HDR_PROBE
Date:   Tue, 10 Sep 2019 13:38:28 +0300
Message-Id: <20190910103830.20794-10-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No need in hacking HOSTCC to be cross-compiler any more, so drop
this trick and use CC for HDR_PROBE

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 625a71f2e9d2..79c9aa41832e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -209,15 +209,14 @@ BTF_PAHOLE ?= pahole
 
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
+	$(CC) $(PROGS_CFLAGS) $(PROGS_LDFLAGS) -x c - -o /dev/null 2>/dev/null \
+	&& echo okay)
 
 ifeq ($(HDR_PROBE),)
 $(warning WARNING: Detected possible issues with include path.)
-- 
2.17.1

