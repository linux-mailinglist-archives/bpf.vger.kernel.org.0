Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E039B416FBA
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 11:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbhIXJ6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245443AbhIXJ5z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 05:57:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C6C061757
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 02:56:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d21so25510602wra.12
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzgR0BqQv/FPhfZPF5T0qfZHuwykiaSgdLA+aUJj4v4=;
        b=NXWVy3Jr0UbQxas9exfy/W4mG5xTI82Js+uuM1UUbejUWm8M1FxV6s1tTFwVbs+IKm
         UQPSTwVg6pj4ZlPnkONB3VfiCPDELulXSdKQEGpEDXu+KGR7RsEuz7O83y1HMbhcurxd
         XnP6EKcWoTaYS/8gZMJ7eGfVPtt4rXJxKduqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzgR0BqQv/FPhfZPF5T0qfZHuwykiaSgdLA+aUJj4v4=;
        b=pmPZBbP48lsUP2qCRJ+roCRUtceyUuydwWA5PLowJk+27Uj6qOJ1H46lt4XxXAxO2M
         sooK50OE6nmKSmHzb8pTmWQ8CVy4sBaYwUYT1b48rnGg2FVaQIJBgcy8vWO9XsYWtwmh
         qonJsiigZpZUd91EORCGep6cCJKX+uvnX4b96tpW38MjJnSWJkzeNPh6RXo+7zkDpn8b
         UaveP0tKh5N9NIc98I5Mc7gj+beVIWSuCGvMp4FJuH1p40wtwyiAoge0oZp3nswOqKbo
         dTCnW1+pkgdTvZHZ6swdVunebCApCuyOKA10ze8vaBfGCxAWz2mDrpwvncoWo4QaFbmB
         zvhg==
X-Gm-Message-State: AOAM531/sl0kPnGCvfXAFDPJlMEhXfpR2shrdimV93Rlg6GDMmoRctcP
        yK/7a2n21LLLVgTKziRtdh4XuA==
X-Google-Smtp-Source: ABdhPJw9dKmwRCKWobc24inKFMURnJ/SXNNtMuE6CNiKmo4sm+L1ffxQuSZ6reyd8y/eaSRhTDq3Eg==
X-Received: by 2002:a05:600c:4f54:: with SMTP id m20mr1161495wmq.96.1632477380954;
        Fri, 24 Sep 2021 02:56:20 -0700 (PDT)
Received: from antares.. (1.8.8.f.e.b.b.b.5.6.9.e.c.8.5.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:58c:e965:bbbe:f881])
        by smtp.gmail.com with ESMTPSA id v20sm7871106wra.73.2021.09.24.02.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:56:20 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/4] bpf: export bpf_jit_current
Date:   Fri, 24 Sep 2021 10:55:42 +0100
Message-Id: <20210924095542.33697-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924095542.33697-1-lmb@cloudflare.com>
References: <20210924095542.33697-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Expose bpf_jit_current as a read only value via sysctl.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/filter.h     | 1 +
 kernel/bpf/core.c          | 3 +--
 net/core/sysctl_net_core.c | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index ef03ff34234d..b2143ad5ce00 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1052,6 +1052,7 @@ extern int bpf_jit_harden;
 extern int bpf_jit_kallsyms;
 extern long bpf_jit_limit;
 extern long bpf_jit_limit_max;
+extern atomic_long_t bpf_jit_current;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e844a2a4c99a..93f95e9ee8be 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -525,6 +525,7 @@ int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
 int bpf_jit_harden   __read_mostly;
 long bpf_jit_limit   __read_mostly;
 long bpf_jit_limit_max __read_mostly;
+atomic_long_t bpf_jit_current __read_mostly;
 
 static void
 bpf_prog_ksym_set_addr(struct bpf_prog *prog)
@@ -800,8 +801,6 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 	return slot;
 }
 
-static atomic_long_t bpf_jit_current;
-
 /* Can be overridden by an arch's JIT compiler if it has a custom,
  * dedicated BPF backend memory area, or if neither of the two
  * below apply.
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5f88526ad61c..674aac163b84 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -421,6 +421,13 @@ static struct ctl_table net_core_table[] = {
 		.extra1		= &long_one,
 		.extra2		= &bpf_jit_limit_max,
 	},
+	{
+		.procname	= "bpf_jit_current",
+		.data		= &bpf_jit_current,
+		.maxlen		= sizeof(long),
+		.mode		= 0400,
+		.proc_handler	= proc_dolongvec_minmax_bpf_restricted,
+	},
 #endif
 	{
 		.procname	= "netdev_tstamp_prequeue",
-- 
2.30.2

