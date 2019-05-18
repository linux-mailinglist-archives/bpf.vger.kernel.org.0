Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30239220F6
	for <lists+bpf@lfdr.de>; Sat, 18 May 2019 02:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfERArI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 May 2019 20:47:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41082 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfERArI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 May 2019 20:47:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so8497927wro.8
        for <bpf@vger.kernel.org>; Fri, 17 May 2019 17:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztONs/ilpqhABMMCgDjaDAIxaMOKsVQPs5VxFfPZ+L4=;
        b=rVufWbSafaQdPzx7fY2+wkGaRcaS6SiFaYw3jh28lPDBhXh7pZkzX6fTv94YM+4J5x
         8t8f578j1w6S8+ATRdSPPqVKDpQxzj35+C348bslSC+Z0AoG3VumvUdk9QZEDjRIHyMS
         p4eEZMsEwD+nIsb0gNx5Mqj2VO0cQ4IMQ1fWVnVzMpfMNrdWxykZOYjTincZ6iGqP0/l
         g2IdxZB/6kquf60G8w6pqWToh39coUr6XabLLqiVPbvCHz6Qwzi2MmgHZfQGJzsbIlo/
         r71d8haRr+DUzgibxTk+zofAOJxvS9/itbBHAG57DnlfH5LLB46ugsm2ONJ3tq0NaxHJ
         7khQ==
X-Gm-Message-State: APjAAAVoxTYfns+gDvrxVOIRpG9jerc5qwK3DTl/+unAjO0gb17c9rtc
        H30bALI53KTEKrwVJQNH34kTzw==
X-Google-Smtp-Source: APXvYqySeRxKRfcQcrMkvk93KB69u60Ely6RnRXiNtroTSQkTdsZTvs4MWwBvXlTm2jtY+qmRpitfg==
X-Received: by 2002:adf:fe49:: with SMTP id m9mr35001659wrs.73.1558140426607;
        Fri, 17 May 2019 17:47:06 -0700 (PDT)
Received: from raver.teknoraver.net (net-47-53-225-211.cust.vodafonedsl.it. [47.53.225.211])
        by smtp.gmail.com with ESMTPSA id v184sm13126356wma.6.2019.05.17.17.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 17:47:05 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 3/5] samples/bpf: fix xdpsock_user build error
Date:   Sat, 18 May 2019 02:46:37 +0200
Message-Id: <20190518004639.20648-3-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190518004639.20648-1-mcroce@redhat.com>
References: <20190518004639.20648-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove duplicate typedef, and use PRIu64 to be both 32 and 64 bit aware.
Fix the following error:

samples/bpf/xdpsock_user.c:52:15: error: conflicting types for ‘u64’
   52 | typedef __u64 u64;
      |               ^~~
In file included from ./tools/include/linux/compiler.h:87,
                 from ./tools/include/asm/barrier.h:2,
                 from samples/bpf/xdpsock_user.c:4:
./tools/include/linux/types.h:30:18: note: previous declaration of ‘u64’ was here
   30 | typedef uint64_t u64;
      |                  ^~~
make[2]: *** [scripts/Makefile.host:109: samples/bpf/xdpsock_user.o] Error 1
make[1]: *** [Makefile:1763: samples/bpf/] Error 2

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 samples/bpf/xdpsock_user.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index d08ee1ab7bb4..a4cd42c2f0b0 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -24,6 +24,7 @@
 #include <sys/resource.h>
 #include <sys/socket.h>
 #include <sys/types.h>
+#include <inttypes.h>
 #include <time.h>
 #include <unistd.h>
 
@@ -49,9 +50,6 @@
 #define DEBUG_HEXDUMP 0
 #define MAX_SOCKS 8
 
-typedef __u64 u64;
-typedef __u32 u32;
-
 static unsigned long prev_time;
 
 enum benchmark_type {
@@ -243,7 +241,7 @@ static void hex_dump(void *pkt, size_t length, u64 addr)
 	if (!DEBUG_HEXDUMP)
 		return;
 
-	sprintf(buf, "addr=%llu", addr);
+	sprintf(buf, "addr=%" PRIu64, addr);
 	printf("length = %zu\n", length);
 	printf("%s | ", buf);
 	while (length-- > 0) {
-- 
2.21.0

