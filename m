Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669C0416FB1
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245452AbhIXJ54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 05:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245422AbhIXJ5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 05:57:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECADC061574
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 02:56:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so25772196wri.1
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CNNuOuPK9wKje+YlF31CNcS9Cb8He0qIWrXOq09DgM=;
        b=ytSNvAbACk+V4wd6bEDLyR+m7sz0p29/e7Zc1NRLHvhWSR0lCtD1NuoFAT0hjjwZ/G
         vs0IBisrpZ9xA4yDdxrs3YC3MuypsCAAVQacVbYmrkCRKVXiLnHtgNjwHHBOUifu24dC
         eA4tRxl7f5UTI9hbdcxF6lxLhXekVC1c5MNlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CNNuOuPK9wKje+YlF31CNcS9Cb8He0qIWrXOq09DgM=;
        b=ZMwntsMvQYZC0cLQX4A4vt+lu/OXE1+diklB5U8/XH+rNiNCg/VkKCFkMReeIFZTjY
         NAErUVknztS1GSQxl8EQX6SwBz8foecgSRPR0jC9sIlO0L/6dl0wMujnL8sLoUMrHFCn
         SFnWfHltsNOV3HWdMFA4uQz5VGbOa7FBh8TmhJw10iBKM3x9wE9NMjpjcFuTnkSFyQLO
         bcOyXoz4a5rKIREkXZfbQxdhHPzF12sYuoP8GBw8+CjHiGgJx5zjr8ur/DkZGMAKrUu4
         qT+fY1Xqr3PihRbukFSalK6mj8WunOjaqM5kr0SsAaCy+iZfroV76lyw0Ht6cO87TM37
         qhBw==
X-Gm-Message-State: AOAM531gPGFQImnHvM2SvsSNELwgPCcQHByAJnkJVkYpy7lCFZkcPC+T
        YIJbSWRx6Bo5ryGK7K6GL1xqtA==
X-Google-Smtp-Source: ABdhPJxk2j4nV2vW4VF5ElLtZo7rkIEfDWzE9a+3mZRtcXpy6NKpbbPDIuzglmoO6D/bGygwBPkZ9g==
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr10432974wrw.225.1632477379485;
        Fri, 24 Sep 2021 02:56:19 -0700 (PDT)
Received: from antares.. (1.8.8.f.e.b.b.b.5.6.9.e.c.8.5.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:58c:e965:bbbe:f881])
        by smtp.gmail.com with ESMTPSA id v20sm7871106wra.73.2021.09.24.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:56:19 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: prevent increasing bpf_jit_limit above max
Date:   Fri, 24 Sep 2021 10:55:41 +0100
Message-Id: <20210924095542.33697-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924095542.33697-1-lmb@cloudflare.com>
References: <20210924095542.33697-1-lmb@cloudflare.com>
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
index 4a93c12543ee..ef03ff34234d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1051,6 +1051,7 @@ extern int bpf_jit_enable;
 extern int bpf_jit_harden;
 extern int bpf_jit_kallsyms;
 extern long bpf_jit_limit;
+extern long bpf_jit_limit_max;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6fddc13fe67f..e844a2a4c99a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -524,6 +524,7 @@ int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
 int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
 int bpf_jit_harden   __read_mostly;
 long bpf_jit_limit   __read_mostly;
+long bpf_jit_limit_max __read_mostly;
 
 static void
 bpf_prog_ksym_set_addr(struct bpf_prog *prog)
@@ -817,7 +818,8 @@ u64 __weak bpf_jit_alloc_exec_limit(void)
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

