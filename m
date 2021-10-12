Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2A42A6A0
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 16:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhJLOBw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 10:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbhJLOBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 10:01:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0557EC06161C
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 06:59:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t2so67307029wrb.8
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TJptnN4GzzzsUZvyAiZp6iIaMylBdItWw9O0Dv3HnA=;
        b=cEXX6Mwrzs0vcm+TK38bYcoPrMHAs0fVD4jmEKoOLPPaGOcW9Qr6Zup4q7Kga2P0X7
         QVnbk5vBa9BvvMXBXCaROYb02HihhCiVW9yB4XJ2PH8I0Rn7AwAjlGsKBNnGvS6LxHRH
         q6D1e7luYHHtp4LCyC5fDwreOAtgoseaEWeec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TJptnN4GzzzsUZvyAiZp6iIaMylBdItWw9O0Dv3HnA=;
        b=I9ZdU2xv3d/oSJoUaTOdpCErDD//LqwtSaOZawsK/lTEozWX+179TyZrTSgTh7DXhp
         fVuNX7Vfnb2r31KHPhwZlWCncQOmBslLuUI08f+zzY3jHQaGJJCNOnQMhhZTm2dGb8SK
         P++rJiClSmIJPC+GzmIITIy+8gQ/8nW2WlelIDKWdh3U0vvcS+8Lt9Zp54YDlo+KQ/Fk
         3JVepZy0SP9Q+HnnSmRyfTYTLOz2xqn76QLwI2QEd75Eo4jfGljUApMpnqPWhrFPAQV+
         Oi62AH2zMSEjR+r/R59MpTQ0XfMQ2SAJZ0VUVVTxKb+H8THlH9et9kkSOzK8g9K9/bf4
         Yj/g==
X-Gm-Message-State: AOAM531mncQc+dljH8zW+YRGKP56Wpgw8H5Uo3D/xn/MtKMZm4X1HBza
        aYz4hjeLt2LjOYh32f9eX0isDw==
X-Google-Smtp-Source: ABdhPJwuWlvoXE01sklUceayFwJNHshBmOnMKqtYiLDNpo/fCBYUw+NZfYsR4cYPv0+2ghqgOm2LLA==
X-Received: by 2002:adf:e0c1:: with SMTP id m1mr32554707wri.241.1634047187605;
        Tue, 12 Oct 2021 06:59:47 -0700 (PDT)
Received: from antares.. (d.5.b.3.f.b.d.4.c.0.9.7.6.8.3.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1386:790c:4dbf:3b5d])
        by smtp.gmail.com with ESMTPSA id o6sm14875894wri.49.2021.10.12.06.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:59:47 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     nicolas.dichtel@6wind.com, luke.r.nels@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2 4/4] bpf: export bpf_jit_current
Date:   Tue, 12 Oct 2021 14:59:35 +0100
Message-Id: <20211012135935.37054-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012135935.37054-1-lmb@cloudflare.com>
References: <20211012135935.37054-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Expose bpf_jit_current as a read only value via sysctl.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 Documentation/admin-guide/sysctl/net.rst |  6 ++++++
 include/linux/filter.h                   |  1 +
 kernel/bpf/core.c                        |  3 +--
 net/core/sysctl_net_core.c               | 24 ++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 4150f74c521a..524e7db8d53f 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -123,6 +123,12 @@ compiler in order to reject unprivileged JIT requests once it has
 been surpassed. bpf_jit_limit contains the value of the global limit
 in bytes.
 
+bpf_jit_current
+---------------
+
+The amount of JIT memory currently allocated, in bytes. JITing of
+unprivileged BPF is rejected if this value is above bpf_jit_limit.
+
 dev_weight
 ----------
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 8231a6a257f6..42c543a21cd8 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1051,6 +1051,7 @@ extern int bpf_jit_harden;
 extern int bpf_jit_kallsyms;
 extern long bpf_jit_limit;
 extern long bpf_jit_limit_max;
+extern atomic_long_t bpf_jit_current;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ab84b3816339..12aedab09222 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -526,6 +526,7 @@ int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
 int bpf_jit_harden   __read_mostly;
 long bpf_jit_limit   __read_mostly;
 long bpf_jit_limit_max __read_mostly;
+atomic_long_t bpf_jit_current __read_mostly;
 
 static void
 bpf_prog_ksym_set_addr(struct bpf_prog *prog)
@@ -801,8 +802,6 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 	return slot;
 }
 
-static atomic_long_t bpf_jit_current;
-
 /* Can be overridden by an arch's JIT compiler if it has a custom,
  * dedicated BPF backend memory area, or if neither of the two
  * below apply.
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5f88526ad61c..78603f561482 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/atomic.h>
 
 #include <net/ip.h>
 #include <net/sock.h>
@@ -307,6 +308,22 @@ proc_dolongvec_minmax_bpf_restricted(struct ctl_table *table, int write,
 
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
+
+static int proc_bpf_jit_current(struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
+{
+	long curr = atomic_long_read(&bpf_jit_current) << PAGE_SHIFT;
+	struct ctl_table ctl_entry = {
+		.data		= &curr,
+		.maxlen		= sizeof(long),
+	};
+
+
+	if (!capable(CAP_SYS_ADMIN) || write)
+		return -EPERM;
+
+	return proc_doulongvec_minmax(&ctl_entry, write, buffer, lenp, ppos);
+}
 #endif
 
 static struct ctl_table net_core_table[] = {
@@ -421,6 +438,13 @@ static struct ctl_table net_core_table[] = {
 		.extra1		= &long_one,
 		.extra2		= &bpf_jit_limit_max,
 	},
+	{
+		.procname	= "bpf_jit_current",
+		.data		= &bpf_jit_current,
+		.maxlen		= sizeof(long),
+		.mode		= 0400,
+		.proc_handler	= proc_bpf_jit_current,
+	},
 #endif
 	{
 		.procname	= "netdev_tstamp_prequeue",
-- 
2.30.2

