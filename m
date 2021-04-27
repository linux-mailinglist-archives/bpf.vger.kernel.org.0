Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4536C517
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 13:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhD0Lay (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 07:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhD0Lau (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 07:30:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B76C061756
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 04:30:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so59118727wrr.2
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4t3fwu407mErMmjxG6jssxxaD8OTJLeJVELqfTsXsW4=;
        b=X5gtZi3PonClOX9mpJRZO2m9QL6bXITgK2KAn4xLSC32/vbkx9DhT2H+eq4jjq8ybG
         eOqlhyuqN/sFkTtls21q6EcLYufp95g1dVJqcAcx5AbicTZjfyB/hk92gffzULZEHLjU
         c7+7LHRFl4Ra8g5XnPLtHQoBMs2W6XGuIWyz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4t3fwu407mErMmjxG6jssxxaD8OTJLeJVELqfTsXsW4=;
        b=V9H3f016HVTmj5vfua5hsAs0GeR0oykqJGH45gfxZann/Vk58/QMVQ3tv8GLou1PaS
         lY/UW4LV4ctDz3gXmIH+7xhtFbIEXY1N2I/ekpDbpT63E4gdl7iOSu7/EZqqDowWHVyq
         DdoSZHzpXFwqjOVhKafScI2oUGlEC3f3VtiqRZ84lpgMPQRWw0KAr3k6tpuZoJ7g+OCX
         AyKRFm53JbkmK6sQUybmp1ZRkX27wpesd5ktnygzrXkg8J92r7Gm7nopgL34z64DeSxt
         LYJGWPtlQwwdozX4NnGQudDWcTewAuhkr9xSzcUIBsPAeGnWssSbJ89FRENjxOQrOuwP
         yefA==
X-Gm-Message-State: AOAM5316GmKWt53eb4fSH685zE1jdtsznzjyI4lxkOS953szSg1HH87R
        IUJqONnCqoSt3ZgPuv7Huid+7Por/0JNgA==
X-Google-Smtp-Source: ABdhPJzljCvKmxwUWLOFfiuC7lqbL3FbUzmKBuU2Je2HB9tXIPa/wjpsFO96TOH0sWRkUqwqiv7kJw==
X-Received: by 2002:a05:6000:110d:: with SMTP id z13mr13163489wrw.92.1619523005399;
        Tue, 27 Apr 2021 04:30:05 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:28bf:825e:e514:98a1])
        by smtp.gmail.com with ESMTPSA id b12sm4320984wrn.18.2021.04.27.04.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:30:04 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next] bpf: Lock bpf_trace_printk's tmp buf before it is written to
Date:   Tue, 27 Apr 2021 13:29:58 +0200
Message-Id: <20210427112958.773132-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_trace_printk uses a shared static buffer to hold strings before they
are printed. A recent refactoring moved the locking of that buffer after
it gets filled by mistake.

Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2a8bcdc927c7..0e67d12a8f40 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -391,13 +391,13 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	if (ret < 0)
 		return ret;
 
+	raw_spin_lock_irqsave(&trace_printk_lock, flags);
 	ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
 		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
 	/* snprintf() will not append null for zero-length strings */
 	if (ret == 0)
 		buf[0] = '\0';
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

