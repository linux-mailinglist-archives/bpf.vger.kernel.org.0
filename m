Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE962A6A2C
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKDQpC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 11:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbgKDQpB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 11:45:01 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E635CC061A4A
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 08:45:00 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id o18so23181644edq.4
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GqRxMuRSCk3pA8cj/SIZ2TBkRpOcHYXrUjExpfJnAs=;
        b=nG1z420yGZvqqFXpI+0coJ/yx6cAUdwWP9rssOjDBDfg7ETelQLL5qoOl8j5Zzi/RD
         9t9QgKcNslkMhmtZ8L9be69BMYxvMJZZGYEAmEMvhjfKjOs/RN10vXAcbZvEjKOKGSci
         ZMVAHRFKud6bI2/8sYvx72iKWI0YpW6y8fnZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GqRxMuRSCk3pA8cj/SIZ2TBkRpOcHYXrUjExpfJnAs=;
        b=Vx5mssr6W4K3faZe25L9Z9DTAYdhZzBi8qrYiGab3otvCUJmzyb5FJMjpOMlf87EBC
         1+lPfpDOG30gWrzp/FayNxxQ96HUiMTvhu/V460ld2+gNX1/idZ9loH7qVKz0prlEqQF
         XlYqgPrMMhQiNzX6Bq/Gznu1e5/nhKFkkIZQjHM77ON8OY44jx97t/20OKiVvldZEkJo
         fuJ6dogaC5gPxKIdOGWMch5rsrdLE7psPGuxI6JlhC4Pk0J1X7heOjbD+G/iciCp70hJ
         XG2Hh6UrUQkNFsdKCU9ZuWf62qwnUUFTYp+KooTSSSfc6Cdyl0D4caCiBgBhFO+b6ni/
         KD7g==
X-Gm-Message-State: AOAM532VQ0jsDeloUUSPOyv9vlf34d+3cIgjvKMovCe4ndRFRjoy+Dno
        uqQ3uxqVztTfXzBBKuiI3bOQTw==
X-Google-Smtp-Source: ABdhPJyaK21fS98vxgrLdIHMXL0fy1Fr9HE2Z0WgWnLT2VMWt8vw5ugi861/PzqBpU3l2J4qxwSx8w==
X-Received: by 2002:a05:6402:142c:: with SMTP id c12mr28897416edx.41.1604508299644;
        Wed, 04 Nov 2020 08:44:59 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id g20sm1283551ejz.88.2020.11.04.08.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:44:58 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v3 2/9] libbpf: Add support for task local storage
Date:   Wed,  4 Nov 2020 17:44:46 +0100
Message-Id: <20201104164453.74390-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201104164453.74390-1-kpsingh@chromium.org>
References: <20201104164453.74390-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Updates the bpf_probe_map_type API to also support
BPF_MAP_TYPE_TASK_STORAGE similar to other local storage maps.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf_probes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5482a9b7ae2d..ecaae2927ab8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -230,6 +230,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.29.1.341.ge80a0c044ae-goog

