Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DFB364776
	for <lists+bpf@lfdr.de>; Mon, 19 Apr 2021 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbhDSPxZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241804AbhDSPxZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 11:53:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11992C06138D
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 08:52:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so18373774wmg.0
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81f1son52XVDAEK91VVd7eOwFElRFc/QYfZDjUricSQ=;
        b=awcoGd5ah9jTHf9eWbR4CuUk3Cr6iesTNkFIdoOBaHT6/zQFFF6UIUGp2veeXIDwhZ
         kEr6VGsGNNu0vL3UX9kz0VVMBXUjdDD7kjZsoAifdDv+WFz0Wczzgr2lfX40LbvzTCzw
         acR4PsYi+YXN+MxPmxBhPvGPD7uAX/288oxnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81f1son52XVDAEK91VVd7eOwFElRFc/QYfZDjUricSQ=;
        b=n4Tre/eTmOnDTuwikljLo8rAQUg8ej/rz7Mn0MdbOSG/A8unQeEBTnQSabYuW1dxiN
         VC4CD5rHu3XueINtxP1fn5oBlUK6ylxCw/zCP+N7l2p3B9YVeoz3WLijcNe7KawS15bR
         9MaT06/OKkSpJUAlpzDT3mYfqtOybmkgXQEyTt09I/1Qq1Fq9+yFi1j87LcJRSzTfkO5
         HAO1SyJarz4L66g1dHfGpcX5nBC9QOtcPdjgkqe0X80LrlwZRoQGSo8TJn1F++NB/A9/
         n5eGUgTWBJE9Twujy2AjDWbnKrMYFEofscVdKyZE57tjpzWUVQokRVhlQm4IHU6Rpf/h
         KVmw==
X-Gm-Message-State: AOAM5315wa4weNtX4NpfkNgBakD+VtF0RbyA5CasshYBPGCxOiSxtxCr
        Yp6EdTp7eGR8N0qsoV0Uq/9dMkn7vsdu0JzW
X-Google-Smtp-Source: ABdhPJx8REppVKZkSF6SO4pLfdvDW3VBm/7/sLkBHwjOZ8CAky4sbHTnDx7kb2EEqCwzl+IBov5SDA==
X-Received: by 2002:a1c:7516:: with SMTP id o22mr21889834wmc.91.1618847573640;
        Mon, 19 Apr 2021 08:52:53 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:3bbb:3f8f:826f:7f55])
        by smtp.gmail.com with ESMTPSA id l9sm22868669wrz.7.2021.04.19.08.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:52:53 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 5/6] libbpf: Introduce a BPF_SNPRINTF helper macro
Date:   Mon, 19 Apr 2021 17:52:42 +0200
Message-Id: <20210419155243.1632274-6-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210419155243.1632274-1-revest@chromium.org>
References: <20210419155243.1632274-1-revest@chromium.org>
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
2.31.1.368.gbe11c130af-goog

