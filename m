Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7652C5979
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 17:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403926AbgKZQpn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 11:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403901AbgKZQpn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 11:45:43 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99109C061A4F
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:45:42 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so3024077wmb.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=satiAp7q7vxp1zQmeNmE59ZD3HlYoTJcGcwpTzuEPC0=;
        b=fgliAF2Sz+QGPKBp4FiAzSvtfZOF7X/v9rcdOtzOseupTGyRIbwNAS4OUUle3/h8+l
         rk7N6gZ4JrwfofolDrrcTiS52Hrx8X6IEIM4b1cpxPNZafVYRM1E1LxRvOUN4y6/skLV
         yvw76LTXAJ3qK4WEUPs1J/Ff67cswZgDrv7z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=satiAp7q7vxp1zQmeNmE59ZD3HlYoTJcGcwpTzuEPC0=;
        b=jFQUC3R7No7uCA24rkcYlT0a68o8zOcyAStUeX/Tn5R0XboTNu6TMAQH/1V6Ye0qDj
         i7L9LRwDF3YbGGHbOy0369Kgb+DkPXkVhHh7qv7BEbHgq4kSLTSMCiNGk1mrcqLgFFQd
         wL3Ifks8TwjnI6oTPECDx7Q2JNuOmgHfT+LIcBoQReHXvsqYnDWDI23zAHHXxhaXTDMo
         T53QHSDXLuYAP46719HJla8rcm0mVIzvV292JlqM4abzDxOk0fDyxmSL7uoB+xWb9NJ7
         i9Ui3cvqpZbdmMqzlACB4GaxO51TGU3B42OSwVr9l5IXLCy6sLS6rtbIJcUa13+tHjms
         AL4A==
X-Gm-Message-State: AOAM533eyBA4UZVdYkmFRk1yF1+DMxGsiZ9l720mr4AVJVE2WPQaQYI+
        fORDO8D74IpvttFHgQWRU6ufq2gOcJk01hNm
X-Google-Smtp-Source: ABdhPJxro2BM0uV+9MCG3jYYWVG89Rgp+wglSySpeJeHg6JxH5CR3TLj4hTfoXxWpnJZJSyuO0BkBg==
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr4437025wmh.88.1606409141127;
        Thu, 26 Nov 2020 08:45:41 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id f17sm8805824wmh.10.2020.11.26.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 08:45:40 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 3/6] bpf: Expose bpf_sk_storage_* to iterator programs
Date:   Thu, 26 Nov 2020 17:44:46 +0100
Message-Id: <20201126164449.1745292-3-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201126164449.1745292-1-revest@google.com>
References: <20201126164449.1745292-1-revest@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Iterators are currently used to expose kernel information to userspace
over fast procfs-like files but iterators could also be used to
manipulate local storage. For example, the task_file iterator could be
used to initialize a socket local storage with associations between
processes and sockets or to selectively delete local storage values.

Signed-off-by: Florent Revest <revest@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/bpf_sk_storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index a32037daa933..4edd033e899c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -394,6 +394,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 	 * use the bpf_sk_storage_(get|delete) helper.
 	 */
 	switch (prog->expected_attach_type) {
+	case BPF_TRACE_ITER:
 	case BPF_TRACE_RAW_TP:
 		/* bpf_sk_storage has no trace point */
 		return true;
-- 
2.29.2.454.gaff20da3a2-goog

