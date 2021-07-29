Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3EC3DA90B
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 18:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhG2Q3r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhG2Q3r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 12:29:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B76C0613C1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:29:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u15so4116282wmj.1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fxYw/ylEj22cC7InNHQELULjqy2+Kkq83C6UEzqw70g=;
        b=Esp9AzssJdnrUo2lJ98L3mZwSflaKA9+GzSA5N1HDn3lUzsytWc1qUZc99/Q/ARG/C
         8q3Esih4UonxmNckiIPjOrkAIsgqp4Z3zT5KFGWpp1xnOFjwRaE2UwebHp4wGykUfH7L
         QqBzauet7VpqQs+ZFhmx0q4Y1jqaP1JDvkYVQ0KXxeM1suAiNFEd87f+MLSauSUebQ3M
         XXka0q8buTBXTvvcb+OcWw03WU1m43VapIRpITHbRHByWS+33rO+/ObF9pr6LfcLfqe6
         z1fj39g3niGS3Tv6yEqRhe4TuJ5lwn4hk/NJd1HRHHtopBmzVEIFJqlprmk4PCWNRztN
         cOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fxYw/ylEj22cC7InNHQELULjqy2+Kkq83C6UEzqw70g=;
        b=mTYENpYfwujA3hR1YkvYTLTVqsA3i/YTz0OSOCsMPs9Nqy8qDROGtpE+2mbfznxRTx
         dWi99UH44kZQ3aa3vgi/xfzyYKMqOyx5WJIcCcTtUt8NBL0ypYt+s4q6M4RZVZxqnfAV
         vVyC6KViRT4Dp1N0yKZCh5CZIjfXSjjtx+5I/nrRi4OufK5wuXgiDlmpZxfyaj2sMgT2
         AxQOgcEnMeUK1Vf50Qp1eFnF7wDDLjgw8Zlvn7S8gyB8uP7Ngx1N2qoMNlWceC+6pym3
         eTvofJLLdbZqWAgE2HjAsb9SKM+LsF7E7OItcJfQkXN1OdEIplfghMWEJcDT9HA2N+QN
         NThQ==
X-Gm-Message-State: AOAM531t5MQYrHNuW/iaFS0SgUDDaMOTS/zRyRRl1qJTEtIqWtYhxeIU
        Cl96ZyeP3PMglXLxZE9SyVBySg==
X-Google-Smtp-Source: ABdhPJxdF9IjMYJWjGZIbHYANnmnmBprwDPabDsXpYz2ja0vGyyuznCy2aK+dBBfJrPZG8/FXaa88A==
X-Received: by 2002:a05:600c:d3:: with SMTP id u19mr15471559wmm.186.1627576182416;
        Thu, 29 Jul 2021 09:29:42 -0700 (PDT)
Received: from localhost.localdomain ([149.86.75.13])
        by smtp.gmail.com with ESMTPSA id 140sm3859331wmb.43.2021.07.29.09.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:29:41 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 3/7] tools: bpftool: complete and synchronise attach or map types
Date:   Thu, 29 Jul 2021 17:29:28 +0100
Message-Id: <20210729162932.30365-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729162932.30365-1-quentin@isovalent.com>
References: <20210729162932.30365-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update bpftool's list of attach type names to tell it about the latest
attach types, or the "ringbuf" map. Also update the documentation, help
messages, and bash completion when relevant.

These missing items were reported by the newly added Python script used
to help maintain consistency in bpftool.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 .../bpftool/Documentation/bpftool-prog.rst    |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  5 +-
 tools/bpf/bpftool/common.c                    | 76 ++++++++++---------
 tools/bpf/bpftool/prog.c                      |  4 +-
 4 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index fe1b38e7e887..abf5f4cd7d3e 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -48,7 +48,7 @@ PROG COMMANDS
 |		**struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
 |	}
 |       *ATTACH_TYPE* := {
-|		**msg_verdict** | **stream_verdict** | **stream_parser** | **flow_dissector**
+|		**msg_verdict** | **skb_verdict** | **stream_verdict** | **stream_parser** | **flow_dissector**
 |	}
 |	*METRICs* := {
 |		**cycles** | **instructions** | **l1d_loads** | **llc_misses**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index b2e33a2d8524..69d018474537 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -405,7 +405,8 @@ _bpftool()
                             ;;
                         5)
                             local BPFTOOL_PROG_ATTACH_TYPES='msg_verdict \
-                                stream_verdict stream_parser flow_dissector'
+                                skb_verdict stream_verdict stream_parser \
+                                flow_dissector'
                             COMPREPLY=( $( compgen -W \
                                 "$BPFTOOL_PROG_ATTACH_TYPES" -- "$cur" ) )
                             return 0
@@ -708,7 +709,7 @@ _bpftool()
                                 hash_of_maps devmap devmap_hash sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
                                 percpu_cgroup_storage queue stack sk_storage \
-                                struct_ops inode_storage task_storage'
+                                struct_ops inode_storage task_storage ringbuf'
                             COMPREPLY=( $( compgen -W \
                                 "$BPFTOOL_MAP_CREATE_TYPES" -- "$cur" ) )
                             return 0
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 1828bba19020..b47797cac64f 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -31,42 +31,48 @@
 #endif
 
 const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
-	[BPF_CGROUP_INET_INGRESS]	= "ingress",
-	[BPF_CGROUP_INET_EGRESS]	= "egress",
-	[BPF_CGROUP_INET_SOCK_CREATE]	= "sock_create",
-	[BPF_CGROUP_INET_SOCK_RELEASE]	= "sock_release",
-	[BPF_CGROUP_SOCK_OPS]		= "sock_ops",
-	[BPF_CGROUP_DEVICE]		= "device",
-	[BPF_CGROUP_INET4_BIND]		= "bind4",
-	[BPF_CGROUP_INET6_BIND]		= "bind6",
-	[BPF_CGROUP_INET4_CONNECT]	= "connect4",
-	[BPF_CGROUP_INET6_CONNECT]	= "connect6",
-	[BPF_CGROUP_INET4_POST_BIND]	= "post_bind4",
-	[BPF_CGROUP_INET6_POST_BIND]	= "post_bind6",
-	[BPF_CGROUP_INET4_GETPEERNAME]	= "getpeername4",
-	[BPF_CGROUP_INET6_GETPEERNAME]	= "getpeername6",
-	[BPF_CGROUP_INET4_GETSOCKNAME]	= "getsockname4",
-	[BPF_CGROUP_INET6_GETSOCKNAME]	= "getsockname6",
-	[BPF_CGROUP_UDP4_SENDMSG]	= "sendmsg4",
-	[BPF_CGROUP_UDP6_SENDMSG]	= "sendmsg6",
-	[BPF_CGROUP_SYSCTL]		= "sysctl",
-	[BPF_CGROUP_UDP4_RECVMSG]	= "recvmsg4",
-	[BPF_CGROUP_UDP6_RECVMSG]	= "recvmsg6",
-	[BPF_CGROUP_GETSOCKOPT]		= "getsockopt",
-	[BPF_CGROUP_SETSOCKOPT]		= "setsockopt",
+	[BPF_CGROUP_INET_INGRESS]		= "ingress",
+	[BPF_CGROUP_INET_EGRESS]		= "egress",
+	[BPF_CGROUP_INET_SOCK_CREATE]		= "sock_create",
+	[BPF_CGROUP_INET_SOCK_RELEASE]		= "sock_release",
+	[BPF_CGROUP_SOCK_OPS]			= "sock_ops",
+	[BPF_CGROUP_DEVICE]			= "device",
+	[BPF_CGROUP_INET4_BIND]			= "bind4",
+	[BPF_CGROUP_INET6_BIND]			= "bind6",
+	[BPF_CGROUP_INET4_CONNECT]		= "connect4",
+	[BPF_CGROUP_INET6_CONNECT]		= "connect6",
+	[BPF_CGROUP_INET4_POST_BIND]		= "post_bind4",
+	[BPF_CGROUP_INET6_POST_BIND]		= "post_bind6",
+	[BPF_CGROUP_INET4_GETPEERNAME]		= "getpeername4",
+	[BPF_CGROUP_INET6_GETPEERNAME]		= "getpeername6",
+	[BPF_CGROUP_INET4_GETSOCKNAME]		= "getsockname4",
+	[BPF_CGROUP_INET6_GETSOCKNAME]		= "getsockname6",
+	[BPF_CGROUP_UDP4_SENDMSG]		= "sendmsg4",
+	[BPF_CGROUP_UDP6_SENDMSG]		= "sendmsg6",
+	[BPF_CGROUP_SYSCTL]			= "sysctl",
+	[BPF_CGROUP_UDP4_RECVMSG]		= "recvmsg4",
+	[BPF_CGROUP_UDP6_RECVMSG]		= "recvmsg6",
+	[BPF_CGROUP_GETSOCKOPT]			= "getsockopt",
+	[BPF_CGROUP_SETSOCKOPT]			= "setsockopt",
 
-	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
-	[BPF_SK_SKB_STREAM_VERDICT]	= "sk_skb_stream_verdict",
-	[BPF_SK_SKB_VERDICT]		= "sk_skb_verdict",
-	[BPF_SK_MSG_VERDICT]		= "sk_msg_verdict",
-	[BPF_LIRC_MODE2]		= "lirc_mode2",
-	[BPF_FLOW_DISSECTOR]		= "flow_dissector",
-	[BPF_TRACE_RAW_TP]		= "raw_tp",
-	[BPF_TRACE_FENTRY]		= "fentry",
-	[BPF_TRACE_FEXIT]		= "fexit",
-	[BPF_MODIFY_RETURN]		= "mod_ret",
-	[BPF_LSM_MAC]			= "lsm_mac",
-	[BPF_SK_LOOKUP]			= "sk_lookup",
+	[BPF_SK_SKB_STREAM_PARSER]		= "sk_skb_stream_parser",
+	[BPF_SK_SKB_STREAM_VERDICT]		= "sk_skb_stream_verdict",
+	[BPF_SK_SKB_VERDICT]			= "sk_skb_verdict",
+	[BPF_SK_MSG_VERDICT]			= "sk_msg_verdict",
+	[BPF_LIRC_MODE2]			= "lirc_mode2",
+	[BPF_FLOW_DISSECTOR]			= "flow_dissector",
+	[BPF_TRACE_RAW_TP]			= "raw_tp",
+	[BPF_TRACE_FENTRY]			= "fentry",
+	[BPF_TRACE_FEXIT]			= "fexit",
+	[BPF_MODIFY_RETURN]			= "mod_ret",
+	[BPF_LSM_MAC]				= "lsm_mac",
+	[BPF_SK_LOOKUP]				= "sk_lookup",
+	[BPF_TRACE_ITER]			= "trace_iter",
+	[BPF_XDP_DEVMAP]			= "xdp_devmap",
+	[BPF_XDP_CPUMAP]			= "xdp_cpumap",
+	[BPF_XDP]				= "xdp",
+	[BPF_SK_REUSEPORT_SELECT]		= "sk_skb_reuseport_select",
+	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	= "sk_skb_reuseport_select_or_migrate",
 };
 
 void p_err(const char *fmt, ...)
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index cc48726740ad..1ee87225543b 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2245,8 +2245,8 @@ static int do_help(int argc, char **argv)
 		"                 cgroup/sendmsg6 | cgroup/recvmsg4 | cgroup/recvmsg6 |\n"
 		"                 cgroup/getsockopt | cgroup/setsockopt | cgroup/sock_release |\n"
 		"                 struct_ops | fentry | fexit | freplace | sk_lookup }\n"
-		"       ATTACH_TYPE := { msg_verdict | stream_verdict | stream_parser |\n"
-		"                        flow_dissector }\n"
+		"       ATTACH_TYPE := { msg_verdict | skb_verdict | stream_verdict |\n"
+		"                        stream_parser | flow_dissector }\n"
 		"       METRIC := { cycles | instructions | l1d_loads | llc_misses | itlb_misses | dtlb_misses }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
-- 
2.30.2

