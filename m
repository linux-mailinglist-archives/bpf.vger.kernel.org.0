Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B7E42A699
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 15:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhJLOBu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbhJLOBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 10:01:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63D0C06174E
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 06:59:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i12so54572914wrb.7
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgl8mZ/YrF8TfvvRQz3SdK85Z+G04kK8iCOR7zSeTw4=;
        b=INxp6FXwb6b2KjWNVfqnMSgcpV68kvNe9sNWshotThFLh64Nc6bBRKSU7r7yhl7ZWa
         ZIbiQA3t1WZjMeKB9nfdLZjXwAAtDk99IfxP2lRRq7oDFzGi1zN59vslvFotpPyoYuXB
         bvdbLnC0lFAENBfYhwKn3dWhzg+d4ejOZDyBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgl8mZ/YrF8TfvvRQz3SdK85Z+G04kK8iCOR7zSeTw4=;
        b=8L3XDZw1JNI326A/mK0Z/VyXKSy82Ty2MaNDDq85wMqMM15ukmo6BJC4FOjOej5TTr
         JzIRTKgn7O/lsrYzGun7cmgw0HnzpC6DacUHpGIVPfCSqjizfYq0IW3w6gXCuYAWAV1h
         QG8eKEytHh4RMrwEaPNFXw/H+mn2SYUkOFkcfwNk9OG9ANopMO3wG2g6BcTtBcZgN7qg
         ChWnK2kPjz2kJ3K9a+s5cPpqeDi1jCCatpeheC48fUVPEEAN/QOTzen6ykByGy2gxSFH
         VnDVj0dnmsAzA+VelBmhjCb6SYByDcMUyuTamEu1BqDQjYDaEXUVC2URP5dcxOGHixKA
         hemQ==
X-Gm-Message-State: AOAM530bTXy4HaG5BUm8unUrQlXICrYM7RvXTuQi4uRAADfVYZwIUTxa
        wM6UNS1vqX28ncrchk4ACocpeA==
X-Google-Smtp-Source: ABdhPJy1HhfVjeplT9k8ozZK1KW/HdYVfy8ElQhu/HQmiit9QYUN+f7Ph8+bd8sGaZWoygh3o50nOg==
X-Received: by 2002:a05:6000:1567:: with SMTP id 7mr32439654wrz.408.1634047186275;
        Tue, 12 Oct 2021 06:59:46 -0700 (PDT)
Received: from antares.. (d.5.b.3.f.b.d.4.c.0.9.7.6.8.3.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1386:790c:4dbf:3b5d])
        by smtp.gmail.com with ESMTPSA id o6sm14875894wri.49.2021.10.12.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:59:46 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     nicolas.dichtel@6wind.com, luke.r.nels@gmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] bpf: prevent increasing bpf_jit_limit above max
Date:   Tue, 12 Oct 2021 14:59:34 +0100
Message-Id: <20211012135935.37054-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012135935.37054-1-lmb@cloudflare.com>
References: <20211012135935.37054-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Restrict bpf_jit_limit to the maximum supported by the arch's JIT.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/filter.h     | 1 +
 kernel/bpf/core.c          | 4 +++-
 net/core/sysctl_net_core.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 47f80adbe744..8231a6a257f6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1050,6 +1050,7 @@ extern int bpf_jit_enable;
 extern int bpf_jit_harden;
 extern int bpf_jit_kallsyms;
 extern long bpf_jit_limit;
+extern long bpf_jit_limit_max;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b6c72af64d5d..ab84b3816339 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -525,6 +525,7 @@ int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
 int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
 int bpf_jit_harden   __read_mostly;
 long bpf_jit_limit   __read_mostly;
+long bpf_jit_limit_max __read_mostly;
 
 static void
 bpf_prog_ksym_set_addr(struct bpf_prog *prog)
@@ -818,7 +819,8 @@ u64 __weak bpf_jit_alloc_exec_limit(void)
 static int __init bpf_jit_charge_init(void)
 {
 	/* Only used as heuristic here to derive limit. */
-	bpf_jit_limit = min_t(u64, round_up(bpf_jit_alloc_exec_limit() >> 2,
+	bpf_jit_limit_max = bpf_jit_alloc_exec_limit();
+	bpf_jit_limit = min_t(u64, round_up(bpf_jit_limit_max >> 2,
 					    PAGE_SIZE), LONG_MAX);
 	return 0;
 }
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index c8496c1142c9..5f88526ad61c 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -419,7 +419,7 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0600,
 		.proc_handler	= proc_dolongvec_minmax_bpf_restricted,
 		.extra1		= &long_one,
-		.extra2		= &long_max,
+		.extra2		= &bpf_jit_limit_max,
 	},
 #endif
 	{
-- 
2.30.2

