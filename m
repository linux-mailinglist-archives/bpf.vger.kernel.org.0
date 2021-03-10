Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457EA334ADE
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 23:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhCJWDO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 17:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbhCJWCm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 17:02:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F0EC0613D8
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:32 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a18so25009188wrc.13
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPXJZO7MToUvf4q+MCl8l3dLahahtNLVnU5sI9beblw=;
        b=NLYx5TphKj9sRLeVfLuFQrvYg3epOz+xFbTZFuwZs3r433Qw/RdxeKFjteTUEAMBi1
         aGej6L8jUSdppH+eygN6vpyU8vEPzh33SzaLT7vCE3WFMspGhJuSe2OOSArZ/mU7EE+a
         isXrj4JZn0M2b/3EtXQ4QGwTRySKfNw9y7smg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPXJZO7MToUvf4q+MCl8l3dLahahtNLVnU5sI9beblw=;
        b=q4ZFq/t1pE5RKAr0l0oh1YaNy4++ltg0fLKMOjg/r+5r67NNg5pcbLXQeffnlakNOP
         LUt2O0lujmS2olQCQvkc6TKXyvNqE9AexOxwl26+AHpc6CLcQx0gBSRtdH1E72lrUtCk
         03YIc71dSFXNRWr1hBBjDt+6y5o7E9XK6fPGwoAEIWM4tCh5KMJDBG4eaXEvGec7iqbo
         1ORykpAZE5FXq+AaS9jVoiSoGEi1fMM3IjRTMCRJEQm5CYVzTV1MulwN/FkK0RXYQAy1
         etW99W3EoIbLqyvEFvWhLJviaqAXHAUeyH8TBLqOZ6XoXb1sc1QoNT9gXuCqsy+Re2h7
         +sKw==
X-Gm-Message-State: AOAM5336YxY5Qd/jwz6wmS9ack9C4+XraZZgsPOepos/IjLTE9ixIOzQ
        SPzqqZJ5OBE3Ch8XRBxDgp4uNI0BAV9W2g==
X-Google-Smtp-Source: ABdhPJwuPfFDGCTxE9brofNXk2DcargQP8ONxDJUt9MQUP7V0CwVDtkM1/xVW0D8lV+5TBiZFDdZpg==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr5516389wra.47.1615413750578;
        Wed, 10 Mar 2021 14:02:30 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:e08c:1e90:4e6b:365a])
        by smtp.gmail.com with ESMTPSA id y16sm699234wrh.3.2021.03.10.14.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:02:30 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 4/5] libbpf: Introduce a BPF_SNPRINTF helper macro
Date:   Wed, 10 Mar 2021 23:02:10 +0100
Message-Id: <20210310220211.1454516-5-revest@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210310220211.1454516-1-revest@chromium.org>
References: <20210310220211.1454516-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to BPF_SEQ_PRINTF, this macro turns variadic arguments into an
array of u64, making it more natural to call the bpf_snprintf helper.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/lib/bpf/bpf_tracing.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index f6a2deb3cd5b..89e82da9b8a0 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -457,4 +457,19 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 		___ret;							    \
 	})
 
+/*
+ * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
+ * an array of u64.
+ */
+#define BPF_SNPRINTF(out, out_size, fmt, args...)			    \
+	({								    \
+		_Pragma("GCC diagnostic push")				    \
+		_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	    \
+		___bpf_build_param(args);				    \
+		_Pragma("GCC diagnostic pop")				    \
+		int ___ret = bpf_snprintf(out, out_size, fmt,		    \
+					    ___param, sizeof(___param));    \
+		___ret;							    \
+	})
+
 #endif
-- 
2.30.1.766.gb4fecdf3b7-goog

