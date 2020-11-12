Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C152A2B0EBD
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 21:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKLUDw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 15:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgKLUDv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 15:03:51 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480FDC0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:03:51 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so6320748wmg.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XvDI+wpjgB/udB/U6ZUMsnDIItG6AuNAvWmNdWpIRQ=;
        b=dhQ8kJuhFZGAfKx5/P+68g0YfqOiER21XLOeWatvwbhmto4adSSdyxnwL1DDPhMlOU
         jeq7QSlfEXzfxE+Jj+6gdGWgCiVUQycpZMHORgHjxrlk9cl9n/ORjyIBQAhdyKJdyuqH
         ljuRpjXPLvpjERXK/VH700QO4WPw5J/RgXpTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XvDI+wpjgB/udB/U6ZUMsnDIItG6AuNAvWmNdWpIRQ=;
        b=NUtSMw1jUYmHzdayW6yKkU1tMjONZIuRL7fgFdCKcT7YPrBHqz9SS55ibc1H5MhmQ0
         oN5jpuywrnBJgSgLg6u35q9J2rdxG2pEs0tJVsqpV0+Pk6K100CVYafqzhWPQfmDFwms
         NOenVHvc7FAwAQ91CiSKRsu0bwjcxmecWxUXUQyTbkD3h34RGLJVwVD63AJJzJfBOr1N
         RmEENliB+GstBIB4UhHasM4SFGr3R6MXjaaeX6CCeTE2+7q71Wu0LHGbuTeLczIsMGC1
         V5ht9aORjYJiaCwbzW/86PrX2gg9LmPIM/vOxJEUz0vwRyD1ttzSlx5gu4GKA8WpuegA
         XOuw==
X-Gm-Message-State: AOAM5335ksNSdinsx1Jy8PER2JlFUwWZMEf0gth2qn4CwHYovpqOZrUB
        nLTwxJrj/t0S/C2ZDebGdYdmmQ==
X-Google-Smtp-Source: ABdhPJwrX54iWcDGKz0HeNvEQPqmgSDXxgBOwoPc4cdWoBVBRrjzZ09+sWbLY+RQBALjcPD4mURyRQ==
X-Received: by 2002:a1c:1906:: with SMTP id 6mr1249717wmz.87.1605211429993;
        Thu, 12 Nov 2020 12:03:49 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f5sm8488472wrg.32.2020.11.12.12.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:03:49 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 2/2] bpf: Expose bpf_d_path helper to sleepable LSM hooks
Date:   Thu, 12 Nov 2020 20:03:46 +0000
Message-Id: <20201112200346.404864-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201112200346.404864-1-kpsingh@chromium.org>
References: <20201112200346.404864-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Sleepable hooks are never called from an NMI/interrupt context, so it is
safe to use the bpf_d_path helper in LSM programs attaching to these
hooks.

The helper is not restricted to sleepable programs and merely uses the
list of sleeable hooks as the initial subset of LSM hooks where it can
be used.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/trace/bpf_trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e4515b0f62a8..eab1af02c90d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_lsm.h>
 
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/btf.h>
@@ -1178,7 +1179,11 @@ BTF_SET_END(btf_allowlist_d_path)
 
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 {
-	return btf_id_set_contains(&btf_allowlist_d_path, prog->aux->attach_btf_id);
+	if (prog->type == BPF_PROG_TYPE_LSM)
+		return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
+
+	return btf_id_set_contains(&btf_allowlist_d_path,
+				   prog->aux->attach_btf_id);
 }
 
 BTF_ID_LIST_SINGLE(bpf_d_path_btf_ids, struct, path)
-- 
2.29.2.222.g5d2a92d10f8-goog

