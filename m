Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0512CC86F
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 21:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgLBU5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 15:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgLBU5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 15:57:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512CBC061A4B
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 12:55:53 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so5567255wrn.3
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 12:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4beLIa3KJ8+MUkP/0+ZlqhuHQAr4Y2kV+lpaUplNzE=;
        b=e+PPU1x0oI1ydxbhlMsNEEWpMzZy+NBUCct8cTNT47jwZfmkBcR00W2FIeVEZC/t4Q
         EBOXpVe13FBkxnKrGaQvlGYPcT6fMO5Cz6Cd09yWDt/L/1dpXHQG/ZWKJ2Feovzb1uWr
         uJQs+7TcBo9I0GNsyVBnn0fC38wB2/uL2JR+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4beLIa3KJ8+MUkP/0+ZlqhuHQAr4Y2kV+lpaUplNzE=;
        b=RCXFrWOyzdmKnNMFsM876Cuh+6zh2wcA+0zh9z4l7T5uH6QxqmdwZ5c9+F5qEKgieP
         byY85Ot3k2IcPWGqfW79/42X+6eUzQ3kbjoolP08EUpq/GsoHhSyTY6D1T0tSEMMdU+p
         RE6P1zGmnGrUbQRMC+RQVMWlO8zarK+t7v91LgbuPaVsgvm2CIiV0skHGnoAlGTwx0nC
         Rwjkbdf38qvugaRUzIS3uIp5eOle3TZ1rZm+M4u592PrZH4rgwuYtxdTTcXUh3L9ULs3
         8+l8Ph669rgXs6GxQT1/XOjUQNlROwWatTWGdRMb3aq2SBcWN34AW5xOlp4k9BX4xtpq
         mOPQ==
X-Gm-Message-State: AOAM532+uiB9Y2XxVWlT4Pt9x/rl7D94ICfn/uxoimZRUi+pM01rB97S
        zQXscILz9HKL2nr9VwinQlSw2CYKg6ED6Q==
X-Google-Smtp-Source: ABdhPJw2S8DkFi9xJHuGpcygik9qGwFOKDt2nDTyCfPY0UXodM1/fRNXpZLIP6cLRjuyPFRnt6AxPw==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr5848300wru.260.1606942551727;
        Wed, 02 Dec 2020 12:55:51 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id d2sm3438486wrn.43.2020.12.02.12.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:55:51 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        KP Singh <kpsingh@google.com>
Subject: [PATCH bpf-next v4 3/6] bpf: Expose bpf_sk_storage_* to iterator programs
Date:   Wed,  2 Dec 2020 21:55:24 +0100
Message-Id: <20201202205527.984965-3-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201202205527.984965-1-revest@google.com>
References: <20201202205527.984965-1-revest@google.com>
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
Acked-by: KP Singh <kpsingh@google.com>
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

