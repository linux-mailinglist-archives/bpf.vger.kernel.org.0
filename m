Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C936732E
	for <lists+bpf@lfdr.de>; Wed, 21 Apr 2021 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhDUTIQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Apr 2021 15:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhDUTIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Apr 2021 15:08:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E948C06174A
        for <bpf@vger.kernel.org>; Wed, 21 Apr 2021 12:07:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id k17so11096910edr.7
        for <bpf@vger.kernel.org>; Wed, 21 Apr 2021 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfuyWzaRCHi4p0AIL1yf6uYPLz6so+Mgoph5gf0xKEE=;
        b=GQLyPeSgUnxmCprFj4i5Sx5FH2Bbf+ND/0vOqqOUHFhkZ4gCvWQxE2WMT1Vffbh5Tx
         zsYsxEk1j/mXKNlvc8U1peFxcWlA017nrakG7fkpTYcX1IUwBYG0cQzyPITNqRSxKHAu
         JMTlowccj/u4w6yvu/m6mDLZTi+AwUKKih/5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfuyWzaRCHi4p0AIL1yf6uYPLz6so+Mgoph5gf0xKEE=;
        b=IM2BRDpom7ug5EUHZeXEBUYw7zdZCUL3+Degsn0vM95d9UEt2WVF3KTQqSsvAXsfko
         eL/8pm+4wzd6yFye4agZEzr5mlw/8yKEt7jUTOuOKvzsPkMGtb14oOQZ5q0X1SuePkax
         bMkB/Aa+OGLw2BjRRQrgZo1QXOCig9YKnIEhZxceBUBP1nVsp9apV2KmrLc9Ckafe1tl
         VjHwulzE1N+w65MHal7cNQhy+Hd63jwVpKqEwReNYnxtIKWGoChwOvBYrnzdnx5tmi9J
         ZTLKonn7VRoC91MOP8sCVFA3zV9DfgzGjky/ZAP14jxoSVeqc5z6wOn4umkjaMixnzkl
         y8Zw==
X-Gm-Message-State: AOAM532naQZwNyMIW6oaaZh04lX1YgH2bgAiGXh4NQppP7bSH1Xc4f0U
        HEdZIks8M7gX778kG4vGGXgkyw==
X-Google-Smtp-Source: ABdhPJwZuKHB1GLs7hfQZCw+Zja/AgwnA3tCfOM3vVmdk62srIHyqWCuFcXvt8ILWyO9So28UlV3jQ==
X-Received: by 2002:aa7:d693:: with SMTP id d19mr24515304edr.8.1619032059428;
        Wed, 21 Apr 2021 12:07:39 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id e5sm251908ejq.85.2021.04.21.12.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:07:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] bpf: remove pointless code from bpf_do_trace_printk()
Date:   Wed, 21 Apr 2021 21:07:36 +0200
Message-Id: <20210421190736.1538217-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The comment is wrong. snprintf(buf, 16, "") and snprintf(buf, 16,
"%s", "") etc. will certainly put '\0' in buf[0]. The only case where
snprintf() does not guarantee a nul-terminated string is when it is
given a buffer size of 0 (which of course prevents it from writing
anything at all to the buffer).

Remove it before it gets cargo-culted elsewhere.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/trace/bpf_trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b0c45d923f0f..4ee55df84cd3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -412,9 +412,6 @@ static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
 	va_start(ap, fmt);
 	ret = vsnprintf(buf, sizeof(buf), fmt, ap);
 	va_end(ap);
-	/* vsnprintf() will not append null for zero-length strings */
-	if (ret == 0)
-		buf[0] = '\0';
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-- 
2.29.2

