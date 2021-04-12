Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5405335CA34
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbhDLPid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 11:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbhDLPiZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 11:38:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D507AC061346
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a6so13426484wrw.8
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HieyIFDYADVp9hdpXGUE06JI+EqmG9gWTrz44DpsDOA=;
        b=Y12irK4UC1V+WHktYjO6tKjeJ4qK6i36Es1wCrG6pt8Ixl+LUk2nOnVDdINIkSVq58
         X9rN3k1lVCiZPezh5XtCnRatn1ZOoSsbQuTtQygROTFB2qidJK1+tpaF8Sf3x60eVyMQ
         zRLIW5jYR+PctjzAiMbayXltvAB2SPL+vNv4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HieyIFDYADVp9hdpXGUE06JI+EqmG9gWTrz44DpsDOA=;
        b=hA6FBe/2FjW868TF4mM7PFj8mpYWEnDb7cAZ6+w4a8NBkGDnFa4SyFYQ1tF3WA4D9E
         7G7e8F1mTnYlUKIeYjYmdx50XeHeFB7btw7iYWPVkSlIJ3punaTOX87yalkcOB5s+3wL
         cXY0uRbSS4i6LOdBFis8An/JfXmv8r8fpfJBrBAKMLteGnPGzO8W2UqJ6mKqZ54UJ0Se
         5NRWGthmiPmrmmC2q21ILnRDn+hk7U6rDqSjw/jzOQ55tsqaiwwpQ9H3zEvMwNxumgvi
         FxUq6GiTbdDYthN0fZOsBu8LCoaeWmgAAWCz8LxH1TrXRkRXoh9Dt9aO2SVSrzVQugvm
         KZZQ==
X-Gm-Message-State: AOAM531bI2sKDZJIfU9HrSBaF805JFM9pyZVqN3Uq7DL1MQyIsC8XUoT
        yGbDjAB+e/bcsbemEPmwPNAaQbo2Z+aoeA==
X-Google-Smtp-Source: ABdhPJw0naPqHzam6FP++PjaREc0bH6auYYcPBnDJ+3ie+6p/R29ECfQVy09Fc/xyH0XjgiJZ7WWog==
X-Received: by 2002:a5d:610f:: with SMTP id v15mr32345740wrt.236.1618241883304;
        Mon, 12 Apr 2021 08:38:03 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:a372:3c3b:eeb:ad14])
        by smtp.gmail.com with ESMTPSA id i4sm2501449wrx.56.2021.04.12.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:38:02 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 4/6] libbpf: Initialize the bpf_seq_printf parameters array field by field
Date:   Mon, 12 Apr 2021 17:37:52 +0200
Message-Id: <20210412153754.235500-5-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210412153754.235500-1-revest@chromium.org>
References: <20210412153754.235500-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When initializing the __param array with a one liner, if all args are
const, the initial array value will be placed in the rodata section but
because libbpf does not support relocation in the rodata section, any
pointer in this array will stay NULL.

Fixes: c09add2fbc5a ("tools/libbpf: Add bpf_iter support")
Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/lib/bpf/bpf_tracing.h | 40 +++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index f9ef37707888..1c2e91ee041d 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -413,20 +413,38 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 
+#define ___bpf_fill0(arr, p, x) do {} while (0)
+#define ___bpf_fill1(arr, p, x) arr[p] = x
+#define ___bpf_fill2(arr, p, x, args...) arr[p] = x; ___bpf_fill1(arr, p + 1, args)
+#define ___bpf_fill3(arr, p, x, args...) arr[p] = x; ___bpf_fill2(arr, p + 1, args)
+#define ___bpf_fill4(arr, p, x, args...) arr[p] = x; ___bpf_fill3(arr, p + 1, args)
+#define ___bpf_fill5(arr, p, x, args...) arr[p] = x; ___bpf_fill4(arr, p + 1, args)
+#define ___bpf_fill6(arr, p, x, args...) arr[p] = x; ___bpf_fill5(arr, p + 1, args)
+#define ___bpf_fill7(arr, p, x, args...) arr[p] = x; ___bpf_fill6(arr, p + 1, args)
+#define ___bpf_fill8(arr, p, x, args...) arr[p] = x; ___bpf_fill7(arr, p + 1, args)
+#define ___bpf_fill9(arr, p, x, args...) arr[p] = x; ___bpf_fill8(arr, p + 1, args)
+#define ___bpf_fill10(arr, p, x, args...) arr[p] = x; ___bpf_fill9(arr, p + 1, args)
+#define ___bpf_fill11(arr, p, x, args...) arr[p] = x; ___bpf_fill10(arr, p + 1, args)
+#define ___bpf_fill12(arr, p, x, args...) arr[p] = x; ___bpf_fill11(arr, p + 1, args)
+#define ___bpf_fill(arr, args...) \
+	___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
+
 /*
  * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
  * in a structure.
  */
-#define BPF_SEQ_PRINTF(seq, fmt, args...)				    \
-	({								    \
-		_Pragma("GCC diagnostic push")				    \
-		_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	    \
-		static const char ___fmt[] = fmt;			    \
-		unsigned long long ___param[] = { args };		    \
-		_Pragma("GCC diagnostic pop")				    \
-		int ___ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),    \
-					    ___param, sizeof(___param));    \
-		___ret;							    \
-	})
+#define BPF_SEQ_PRINTF(seq, fmt, args...)			\
+({								\
+	static const char ___fmt[] = fmt;			\
+	unsigned long long ___param[___bpf_narg(args)];		\
+								\
+	_Pragma("GCC diagnostic push")				\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
+	___bpf_fill(___param, args);				\
+	_Pragma("GCC diagnostic pop")				\
+								\
+	bpf_seq_printf(seq, ___fmt, sizeof(___fmt),		\
+		       ___param, sizeof(___param));		\
+})
 
 #endif
-- 
2.31.1.295.g9ea45b61b8-goog

