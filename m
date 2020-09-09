Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B412E2633F9
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgIIRMy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbgIIRMG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B89EC061756
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so3816835wrm.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ftypMfD9as2FgBF1X0Pf2dywiRppR0lwxPdnQRmU7wU=;
        b=IRMZrEuBmAiuJ5El6UaMnfisIp070by9JNRUC4busqKg3AwfoR1zkKGPaFLPA+2Lmn
         PF9qsUtLbD4V79FH9RIuW3TQkkNlHWGT9j1Hxvzhqxr9PZ01Lw8y2faE8BVH7Q8jx5pX
         lziHsrU6FXcOtMclte5uc20d2e/4KrDIHbhAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftypMfD9as2FgBF1X0Pf2dywiRppR0lwxPdnQRmU7wU=;
        b=IPv05hbOOfHO4avPcaCBIIp4ixEoBS8ws2jRfN2hcAYRdG5l+qKJK3TWHiiLdwmI8q
         qljJWU5Kc4J3X6IkaMnw4oN2DEi0/Vyg3JXYVm+k+MUMU31J5dEJPG2qo9+uI/ACxdkC
         bQS4VYC8rGM0RaMVFw7eMteW7kSkXCg1uW++gVoE/kcRZfj61jjVb6WHe15qfS0fNAIt
         NlyPe68nYffmFrCaOCjHPzI+IHNqeRj9EyoQUigJ6hKJ551PD2Jy11ZskdfzstfCAotq
         49ICK4fKIvkxut4qbvj0Nhcwslw+28hPJu+vN8JJAIKbkjpdUgFjgnuIN0Z+pI9Z09Mm
         hSGw==
X-Gm-Message-State: AOAM531EYf12xywZjnKebHJBQQTvfyGPAlAmBC7SM7Xy+ZB0/s3/j39s
        yG/rwINheDGJrNWjDtv3oMYiIQ==
X-Google-Smtp-Source: ABdhPJzH1aUDLTRY27NE4fpaT3JvvDLuWlN+c3liSna83U/NR7k3KgBuaNF91Fb9SGlfQhX0ALgg6Q==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr4968698wrn.205.1599671524784;
        Wed, 09 Sep 2020 10:12:04 -0700 (PDT)
Received: from antares.lan (1.3.0.0.8.d.4.4.b.b.8.a.1.4.5.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:e541:a8bb:44d8:31])
        by smtp.gmail.com with ESMTPSA id g131sm3746743wmf.25.2020.09.09.10.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:04 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 03/11] btf: Add BTF_ID_LIST_SINGLE macro
Date:   Wed,  9 Sep 2020 18:11:47 +0100
Message-Id: <20200909171155.256601-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909171155.256601-1-lmb@cloudflare.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a convenience macro that allows defining a BTF ID list with
a single item. This lets us cut down on repetitive macros.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Suggested-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/btf_ids.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 210b086188a3..d6a959572175 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -76,6 +76,13 @@ extern u32 name[];
 #define BTF_ID_LIST_GLOBAL(name)			\
 __BTF_ID_LIST(name, globl)
 
+/* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
+ * a single entry.
+ */
+#define BTF_ID_LIST_SINGLE(name, prefix, typename)	\
+	BTF_ID_LIST(name) \
+	BTF_ID(prefix, typename)
+
 /*
  * The BTF_ID_UNUSED macro defines 4 zero bytes.
  * It's used when we want to define 'unused' entry
-- 
2.25.1

