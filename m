Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBF435CA31
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbhDLPic (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243099AbhDLPiY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 11:38:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1276C061347
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m9so678664wrx.3
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E44IkWJXt1mIhiPJbogZF1L6p/MJV6UuIKV3XnIMCJg=;
        b=kuRvLjhDGAcassWOraX6stme1vIpVIh7fPrjWGcaLuzefIu2hUwmgnd1IHSm8rshtm
         +4i7mbTxVrp9S/BScsrVANyFeyXwlbhamUcrqfMubHcv1kGBh9qKhh2x1GtKIcp/k6lK
         QcllQ9g8r7tNu6Z24Z5PSBABSnsIfz3KvK+so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E44IkWJXt1mIhiPJbogZF1L6p/MJV6UuIKV3XnIMCJg=;
        b=camfnOpTo2vo8V/y2cyaIgzq5PW2OA3LBQosqEb7eLbtf7/yZyGmzSSCvgq4+7WEKE
         Y205Xry2Fbi2w7HlVWPTaHUiLL9A1BvAeh0bqZQtunZpWAg2+ly330mAaf4ccU2t1Lew
         I18xYNAqVTFAS0jFPBdZOwUK0svTBTKY4Dd7FU/uHWvNnFYAG7XHxD3KRUzUw6wAE5+B
         Eb4w8lrFeABBid5V7OwTgOosyFtRMfwZRB12Uzifrbnb4kuV8FZV5su8F52BIh509o8F
         SvNmkAaXY8pu9sPGbx1caFrkzaYlV25aCkLVEe23d29wm6Hf9MUa+3f1VF5qJeuWNjHY
         cTUA==
X-Gm-Message-State: AOAM531twiUnzMOgO+PN+GsC8RkAmvRHfuXtv2OYiWpKwrCITGhoh+Q3
        VtowzEBzVRPIJRcaiY1bxEfVbjdLi8OUyQ==
X-Google-Smtp-Source: ABdhPJxIikMtTG+HgaSzOLo2d8lVMQObhmMLQ3VX7OEYjAmYdAHPOWLbIHk01jPcnGUcxQ4NfP1vcA==
X-Received: by 2002:a5d:6ad1:: with SMTP id u17mr32074623wrw.214.1618241884193;
        Mon, 12 Apr 2021 08:38:04 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:a372:3c3b:eeb:ad14])
        by smtp.gmail.com with ESMTPSA id i4sm2501449wrx.56.2021.04.12.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:38:03 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 5/6] libbpf: Introduce a BPF_SNPRINTF helper macro
Date:   Mon, 12 Apr 2021 17:37:53 +0200
Message-Id: <20210412153754.235500-6-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210412153754.235500-1-revest@chromium.org>
References: <20210412153754.235500-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to BPF_SEQ_PRINTF, this macro turns variadic arguments into an
array of u64, making it more natural to call the bpf_snprintf helper.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/lib/bpf/bpf_tracing.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 1c2e91ee041d..8c954ebc0c7c 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -447,4 +447,22 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 		       ___param, sizeof(___param));		\
 })
 
+/*
+ * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
+ * an array of u64.
+ */
+#define BPF_SNPRINTF(out, out_size, fmt, args...)		\
+({								\
+	static const char ___fmt[] = fmt;			\
+	unsigned long long ___param[___bpf_narg(args)];		\
+								\
+	_Pragma("GCC diagnostic push")				\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
+	___bpf_fill(___param, args);				\
+	_Pragma("GCC diagnostic pop")				\
+								\
+	bpf_snprintf(out, out_size, ___fmt,			\
+		     ___param, sizeof(___param));		\
+})
+
 #endif
-- 
2.31.1.295.g9ea45b61b8-goog

