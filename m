Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCFEAA3559
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbfH3LA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 07:00:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33768 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfH3LA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 07:00:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so6566250wrr.0
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 04:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EIr8AwOPiNckdVBY6i7n8z6ctI1h3TpypkoOttv24nk=;
        b=oSAv+pXhnO/OYle9E3G8UH8llVneQ8uAsk1pihGWX5uwFjBzjBvufEYuUW3XNJ+FwR
         1uMAbLiY0F0IQqWGFq0xXf0KzPnHnE5sSLjUr8vYZcWSzcLFRtM9GLhWt3gH83w7Vmdn
         JLne9RTU5uS4fIdoyxr/MeN8hdYAiwqewYTBbaelPwdf4jS2ab4OD+cp9aOtn7ge4tfi
         ff54s2BQt/r5mlQS3I0fuBOl2jnxS/gjZbPuTiD36z9+MmaNlnXkxcYPtMMfYLP+8McT
         x/8aYFRbCTpejazxRia4jk756TuqqvI3+eQ4/bdS5cRQRKDKOM1u37kLN4OLAnxumEOH
         BNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EIr8AwOPiNckdVBY6i7n8z6ctI1h3TpypkoOttv24nk=;
        b=nAdCUdofn7BgyCYNCeMVNktCIRxFpxviCq7J4gwWipj1GpFyvjlqJLenUsaxQYrJCi
         iDgnKeMj6rOY3nkyqCIka1PmRaq8E3rkf+O/uwQbmn3FsWXoX+U8lOUQ579fiF8/3Z2T
         bi6DqOG+SFtsMzxRkRRuWibxsdve+7j90eTIFIykCvkRQgTmB9CAGXk4j1j7kJ2Ng2Yh
         YsXraL35lK1Bwuek1yw4FgEq6D1j27wwQJRiP2bBuVTgXfEWXIl1/wYWWmwHPDkUOCj+
         iI9qiz6TcQawWZbv58xProNz4IxCQtiq/HTEMYyPCNK1IrnNUwzA/MOLpKMHgThMPlQm
         mcBw==
X-Gm-Message-State: APjAAAWrUDDwuJgzJUUPpbH8QCeHXMBiM0HB/FMQSQVMozZhEmFRl2ZX
        oGUP+3Fm51XvXpBzQYW6kxeQ+A==
X-Google-Smtp-Source: APXvYqyePid31/mbtw+pMW7sS/tQSrLG35ES5azqMPRTxsFSVhfSNMx5hJEJYbWfW+gUlX4Ug80n1A==
X-Received: by 2002:adf:dc03:: with SMTP id t3mr17323673wri.80.1567162855349;
        Fri, 30 Aug 2019 04:00:55 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t198sm7848083wmt.39.2019.08.30.04.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 04:00:54 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next v2 4/4] tools: bpftool: do not link twice against libbpf.a in Makefile
Date:   Fri, 30 Aug 2019 12:00:40 +0100
Message-Id: <20190830110040.31257-5-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830110040.31257-1-quentin.monnet@netronome.com>
References: <20190830110040.31257-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In bpftool's Makefile, $(LIBS) includes $(LIBBPF), therefore the library
is used twice in the linking command. No need to have $(LIBBPF) (from
$^) on that command, let's do with "$(OBJS) $(LIBS)" (but move $(LIBBPF)
_before_ the -l flags in $(LIBS)).

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b0c5a369f54a..39bc6f0f4f0b 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -55,7 +55,7 @@ ifneq ($(EXTRA_LDFLAGS),)
 LDFLAGS += $(EXTRA_LDFLAGS)
 endif
 
-LIBS = -lelf -lz $(LIBBPF)
+LIBS = $(LIBBPF) -lelf -lz
 
 INSTALL ?= install
 RM ?= rm -f
@@ -117,7 +117,7 @@ $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 $(OUTPUT)feature.o: | zdep
 
 $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)
 
 $(OUTPUT)%.o: %.c
 	$(QUIET_CC)$(COMPILE.c) -MMD -o $@ $<
-- 
2.17.1

