Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1909B35FB2D
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347332AbhDNSyy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347620AbhDNSyn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 14:54:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A6C06175F
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:54:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso11064276wmq.4
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irlDC7BwaWt5pY8na/M+SXAiJ/Wnr/e+GZWx5sW8jdk=;
        b=WxSAKMPN1lYSmD8p3MuuOh3/L292fGegWmwEns59d55Om2x193E4U6Gxbx52vx6Mbq
         77w88fFfnX6uXmPuEnwYoMytguBwcIsxqw5XFU9EXFMM5gu438jl7euptSDz278BDKhH
         g+dy+raIUneFTbe3Ph1NPXD9GUGGWGFpjGVs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irlDC7BwaWt5pY8na/M+SXAiJ/Wnr/e+GZWx5sW8jdk=;
        b=XkkOnvOL4WMvxbN6lc9QOtpADUYEdwpVylb0eQVL3/j5pidVHV4YcNBbTag7ZEFl/2
         lFLOF6lgV65eJK369UKjcEjni3Upjo1v7pYRUJ3/THSE1ODJNkl/yy6hd/IBBt5WiE3v
         b+PETHyUr4ROAZZctbRkc0CkKDF2ofnzWg2IbTgGzMar1e1qPU0D06UKKCSJ11u/nSAq
         iYcsSlGllao6R9v/KfckgkedAfI0AVgQdfyOAr0m6o9fd2FIsnIJ7aHYiiqOgZGN8RPh
         McGtYVBO48ObziQaDeeqaCutMCy5hti8d7BDo1IjHlmE2ReZuhrPhLSn44TXW1EhPBzb
         VCGQ==
X-Gm-Message-State: AOAM530YVp3CZcllvNCFJ96Pz+SZUT4Mqtrlr5bNMe2s2OIhB2Aj2QQ6
        kN3BAXy6bca9NHO1L9ZvAx9RvvV4jueG+Q==
X-Google-Smtp-Source: ABdhPJwsgZC1dNdCCl+Upp7K8UhiKwONgV9CkZNboIAnHD1pklEb2U8rz1wF+FPN12qTRFdxmiXYJw==
X-Received: by 2002:a1c:a953:: with SMTP id s80mr4330993wme.176.1618426458960;
        Wed, 14 Apr 2021 11:54:18 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:8b2a:41bd:9d62:10d5])
        by smtp.gmail.com with ESMTPSA id f12sm253131wrr.61.2021.04.14.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:54:18 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 4/6] libbpf: Initialize the bpf_seq_printf parameters array field by field
Date:   Wed, 14 Apr 2021 20:54:04 +0200
Message-Id: <20210414185406.917890-5-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414185406.917890-1-revest@chromium.org>
References: <20210414185406.917890-1-revest@chromium.org>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

