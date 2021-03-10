Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF177334ADD
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 23:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhCJWDN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 17:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhCJWCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 17:02:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C5C061764
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:31 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l11so21661473wrp.7
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQ2hKQWhpJ/WTdKG9UWGdly9pe3CMhv89pfXyaQmgfE=;
        b=YhsFvX1QktFHIWBCy6YnZtuUwh/y9Vkf5pPz9uqPdkC55xYf3v7ff2d67tv52x/bo2
         XFJR2svsqaTSYeQUOk+dnEj44wtY9uUjNHSXL7BK55ZFHhuB/HEToOG5uM9gc0VxPY4G
         y45qELB7GtbglYR6i+U8wM9UYYHCticWOwKBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQ2hKQWhpJ/WTdKG9UWGdly9pe3CMhv89pfXyaQmgfE=;
        b=roWLacGt6Ig/umSE8UebJFIjWVYS8tBlD26q82Zk9fvahdRwYV6rpcPz4L7JyMOmTX
         Ky9VtJd1O4imSeId/Pfimi67qPrfxt7lon0rwX9dj6tMsOy4f6NZT2GW3UAbd79Gzo3b
         YvDIb7CTGA3PYyPmmvoU33NN68LdPKbUxgvHIjRS3rf0PgCke6jKveWUElM+hHeg6img
         yLQgWj90CDoClW7l/UFoH4gVzwlP0blnZA7/mrkWPWJscvPJjjZ73/MjoTud5pvOu90J
         IAMX4witFSc2FRBY9TwyFX9ylm7NBt8ooAhdJcaB4+XAt7rAfUMO4qJ0m6eK8hISda7/
         9yJg==
X-Gm-Message-State: AOAM530gvVf29Vh4LpgeXbsWxr3kzG7a7nZEvhtU1sxDTV0Qf367cIPU
        /2Z+Hb0jt8NWebIEDSFKJjhxvs1Hm8HyGQ==
X-Google-Smtp-Source: ABdhPJyR3we1bikA48yPH7LSQyZ6ykyowWWr2CR5qm+5WfsA0mofpIB4dthmSTwirh+/fG0c0Geoeg==
X-Received: by 2002:a5d:4b06:: with SMTP id v6mr5676166wrq.41.1615413749649;
        Wed, 10 Mar 2021 14:02:29 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:e08c:1e90:4e6b:365a])
        by smtp.gmail.com with ESMTPSA id y16sm699234wrh.3.2021.03.10.14.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:02:29 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 3/5] libbpf: Initialize the bpf_seq_printf parameters array field by field
Date:   Wed, 10 Mar 2021 23:02:09 +0100
Message-Id: <20210310220211.1454516-4-revest@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210310220211.1454516-1-revest@chromium.org>
References: <20210310220211.1454516-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When initializing the __param array with a one liner, if all args are
const, the initial array value will be placed in the rodata section but
because libbpf does not support relocation in the rodata section, any
pointer in this array will stay NULL.

This is a workaround, ideally the rodata relocation should be supported
by libbpf but this would require a disproportionate amount of work given
the actual usecases. (it is very unlikely that one uses a const array of
relocated addresses)

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/lib/bpf/bpf_tracing.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index f9ef37707888..f6a2deb3cd5b 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -413,6 +413,34 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 
+#define ___bpf_build_param0(narg, x)
+#define ___bpf_build_param1(narg, x) ___param[narg - 1] = x
+#define ___bpf_build_param2(narg, x, args...) ___param[narg - 2] = x; \
+					      ___bpf_build_param1(narg, args)
+#define ___bpf_build_param3(narg, x, args...) ___param[narg - 3] = x; \
+					      ___bpf_build_param2(narg, args)
+#define ___bpf_build_param4(narg, x, args...) ___param[narg - 4] = x; \
+					      ___bpf_build_param3(narg, args)
+#define ___bpf_build_param5(narg, x, args...) ___param[narg - 5] = x; \
+					      ___bpf_build_param4(narg, args)
+#define ___bpf_build_param6(narg, x, args...) ___param[narg - 6] = x; \
+					      ___bpf_build_param5(narg, args)
+#define ___bpf_build_param7(narg, x, args...) ___param[narg - 7] = x; \
+					      ___bpf_build_param6(narg, args)
+#define ___bpf_build_param8(narg, x, args...) ___param[narg - 8] = x; \
+					      ___bpf_build_param7(narg, args)
+#define ___bpf_build_param9(narg, x, args...) ___param[narg - 9] = x; \
+					      ___bpf_build_param8(narg, args)
+#define ___bpf_build_param10(narg, x, args...) ___param[narg - 10] = x; \
+					       ___bpf_build_param9(narg, args)
+#define ___bpf_build_param11(narg, x, args...) ___param[narg - 11] = x; \
+					       ___bpf_build_param10(narg, args)
+#define ___bpf_build_param12(narg, x, args...) ___param[narg - 12] = x; \
+					       ___bpf_build_param11(narg, args)
+#define ___bpf_build_param(args...) \
+	unsigned long long ___param[___bpf_narg(args)];			\
+	___bpf_apply(___bpf_build_param, ___bpf_narg(args))(___bpf_narg(args), args)
+
 /*
  * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
  * in a structure.
@@ -422,7 +450,7 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 		_Pragma("GCC diagnostic push")				    \
 		_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	    \
 		static const char ___fmt[] = fmt;			    \
-		unsigned long long ___param[] = { args };		    \
+		___bpf_build_param(args);				    \
 		_Pragma("GCC diagnostic pop")				    \
 		int ___ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),    \
 					    ___param, sizeof(___param));    \
-- 
2.30.1.766.gb4fecdf3b7-goog

