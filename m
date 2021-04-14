Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C7535FB2F
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353162AbhDNSzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348599AbhDNSyo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 14:54:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556E4C06138C
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:54:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so1103766wmf.3
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xaIEhg0p0tQW9aj3I3BsxMZ2xq8px+zcdbX4G7AebBQ=;
        b=g0R+92KfHZ4/oubiZuCF64P7B7v4z0HFtlXN5l4q6DU8B7CTIXVV7QugLGXpdPWrfk
         0MahzYKLQDjTgx8p2NEya38/oxAWGM++De4uj0wfUw9Tnxc89wsf+U6Jsyf157iv1GRk
         S0Ewa1AyzYCTCl6YVjrJpv6PzfwmJDO+8WYjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xaIEhg0p0tQW9aj3I3BsxMZ2xq8px+zcdbX4G7AebBQ=;
        b=si3+1soCz1ASXo31wgsjq5TerDSrhY/NB2r5kJsumNTCSYKRLYbfqLBQdXVedV3D13
         Lp3JBaxdkAwCGjNNNed2wyu4GyTq1xoPXU90NY9nUmDIPPO/Xhg0FsI1VqyYcvUUrevJ
         AJp/AuDdzM2wYRJkEtLhT6pBbwkFajXK7S+JiGJKkLRSihumqEnuI4atX5I4CmV9v29N
         BJ8p6G1FRbmp0RenGhFgp04MErtXhizLIbg7OHCi5oSyZ9FgFo8w5+5vdr7beSEAdq1/
         o1XoxbGHnr/4Mg8A4yn3T1vNJVeHOxPNQ6aiT+10qfRyUwY2zGOB7NExz2nBfqIsubnc
         PT2g==
X-Gm-Message-State: AOAM530LS9FbIgP/g1ui3VCipdRAa2W1eHG+pryPaJBZbUk3TciZFWEh
        2OgfVGs5IGAqquuKMcPO0r82mgvoloHUeQ==
X-Google-Smtp-Source: ABdhPJwaFNeD9hX3VaDQMufideEFY2UHqxxNRzq10KUP1crzIybzw5HVgaE37LYfsz8sJwVICiMW4A==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr4315903wmk.52.1618426459835;
        Wed, 14 Apr 2021 11:54:19 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:8b2a:41bd:9d62:10d5])
        by smtp.gmail.com with ESMTPSA id f12sm253131wrr.61.2021.04.14.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:54:19 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 5/6] libbpf: Introduce a BPF_SNPRINTF helper macro
Date:   Wed, 14 Apr 2021 20:54:05 +0200
Message-Id: <20210414185406.917890-6-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414185406.917890-1-revest@chromium.org>
References: <20210414185406.917890-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to BPF_SEQ_PRINTF, this macro turns variadic arguments into an
array of u64, making it more natural to call the bpf_snprintf helper.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

