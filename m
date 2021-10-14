Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9827642DB7C
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhJNO2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhJNO2N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:28:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BFFC061760
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:26:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y3so20200257wrl.1
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgl8mZ/YrF8TfvvRQz3SdK85Z+G04kK8iCOR7zSeTw4=;
        b=Lkoux+c6UA1oHasGJ/r8HQtqbC5B9HrSLLHEkQAG3UQGRAXXBugFRBQSfv3RJcZ9rf
         LEJ6dsMUgbYfWleimFXH3kfT8MDUsXnlZAv5pr8HOBsD/bYgM++k1B4dqqj9G7Q13Dd8
         BV2f3zEPg0PzEYuK+1yQV0Q0r5oy4LaIQqnnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgl8mZ/YrF8TfvvRQz3SdK85Z+G04kK8iCOR7zSeTw4=;
        b=WetnC6kV6Lxi0Gxn4iYA3mzu/CQSmkZNpvlQJacYKlxVNAKSsrkgzxDtu+rxPVNhX7
         BMIscPYy36e9j0NWDDHDwBvPWo4uRacg3J97PS9TDgiUMZ5p7Sieu9b6DlwVXrhJAIJD
         hEIhdSK1lAHcFI4FDpeFsP9cRp30QFWJNLWADfoIbovmD9tdpGHAHgRe1K5Frxx0MER5
         yRv6j1hNemwIaEhWm0TTOXqWQphhJhaS62Pj6IqMsFMu7QSZEbl0+4ek1e3ateAEszOZ
         zAcohsEhI4u7Meygqsx4lR8mp+0s3M2ibztsk7WIhFj2Gb1bgIcx7UeMr9k8ThR2J7f9
         Eh6g==
X-Gm-Message-State: AOAM532+k5+Pafj1Uuj9l+S3UNvosy8mc3jckN/uOZ5/L4jDL6d30dA+
        Ln9uEsauYJzbbpJK/KZeUMrCojW17pj/gVN9
X-Google-Smtp-Source: ABdhPJzukZ7AV61dROfIxRv1Lfgv+4xIL2tgaMjZiAoRX7cQziN9II70oV45qMpSTCcq+p7wQN86qA==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr7055659wrs.96.1634221567412;
        Thu, 14 Oct 2021 07:26:07 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id e8sm3731111wrg.48.2021.10.14.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:26:07 -0700 (PDT)
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
Subject: [PATCH v3 3/3] bpf: prevent increasing bpf_jit_limit above max
Date:   Thu, 14 Oct 2021 15:25:53 +0100
Message-Id: <20211014142554.53120-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014142554.53120-1-lmb@cloudflare.com>
References: <20211014142554.53120-1-lmb@cloudflare.com>
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

