Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A7223973
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 12:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgGQKgS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 06:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgGQKgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 06:36:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841A7C08C5CE
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:36:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r19so11956448ljn.12
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eri9q6YTTJuTcDHCnqTQ8a4HARgJ3515jt9CHeDHUoQ=;
        b=aRfP1xdqjqlWmGbPARg7nbKtz8w2jRhfnEJ2769OvRF3mVJKVSt9U8RkZTxb5BCEHs
         PGmifqSiM3F6NG0dN7vKOB8Da18wL+ceaOhhXUfoAKFmZvs6exvetnvjusfs+7ivx23v
         OT//Vp5U/L+tpalwTxkl7mNThAVVEYZGnMTqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eri9q6YTTJuTcDHCnqTQ8a4HARgJ3515jt9CHeDHUoQ=;
        b=RfGmSsq7g94kdYqQ+uAA07xD7GvatXgGtxCtAM2QnmtcM/rAz/wAu0P3KtC2NaR/Iz
         A53KI4gtg3DMvdYIb83QnddU3ynT3D21/NYD6xG70ht5doxPbFzLLGor/ipHHGaOzUuA
         eqv0EGdIcH/I/12KyYqvcoojHBDdL7P3/Yk8O/x+jr7A8AO5nfgMM7LkWaT+RkchTwTt
         2LuUCL/UF6pk8IZZdMxisjIl2creSltdlrbY2FT4X9a3qQKN1b23rUOyndRE7268U7hs
         hzG5eKROJmzZYBHuqaWPJFZObzSnx3VFEvIVGnaGt+OzV0uXA2JLTMC1Jga8BqHlOj+0
         O7qA==
X-Gm-Message-State: AOAM532vTvPBdGhzwGosGN5dMSzdvpZ/hAWAqtuQnw7gVv3hOt8pnM+g
        Vb9s5+sLgLC49gHM8DWyJJVRXF6mzP+ehA==
X-Google-Smtp-Source: ABdhPJzAE0yA8Ogvtj+DgtKPwTkF9gZVzpjzcuW3we90NMwts5efYis+psAEeaAW43xqtskOZqlYWQ==
X-Received: by 2002:a2e:8357:: with SMTP id l23mr3921650ljh.290.1594982158657;
        Fri, 17 Jul 2020 03:35:58 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 11sm1568806ljw.69.2020.07.17.03.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:35:58 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v5 13/15] tools/bpftool: Add name mappings for SK_LOOKUP prog and attach type
Date:   Fri, 17 Jul 2020 12:35:34 +0200
Message-Id: <20200717103536.397595-14-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717103536.397595-1-jakub@cloudflare.com>
References: <20200717103536.397595-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make bpftool show human-friendly identifiers for newly introduced program
and attach type, BPF_PROG_TYPE_SK_LOOKUP and BPF_SK_LOOKUP, respectively.

Also, add the new prog type bash-completion, man page and help message.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v5:
    - Update prog type list in bash-completion and bpftool-prog man page. (Andrii)
    
    v3:
    - New patch in v3.

 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 2 +-
 tools/bpf/bpftool/bash-completion/bpftool        | 2 +-
 tools/bpf/bpftool/common.c                       | 1 +
 tools/bpf/bpftool/prog.c                         | 3 ++-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 412ea3d9bf7f..82e356b664e8 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -45,7 +45,7 @@ PROG COMMANDS
 |               **cgroup/getsockname4** | **cgroup/getsockname6** | **cgroup/sendmsg4** | **cgroup/sendmsg6** |
 |		**cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/sysctl** |
 |		**cgroup/getsockopt** | **cgroup/setsockopt** |
-|		**struct_ops** | **fentry** | **fexit** | **freplace**
+|		**struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
 |	}
 |       *ATTACH_TYPE* := {
 |		**msg_verdict** | **stream_verdict** | **stream_parser** | **flow_dissector**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 25b25aca1112..7b137264ea3a 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -479,7 +479,7 @@ _bpftool()
                                 cgroup/post_bind4 cgroup/post_bind6 \
                                 cgroup/sysctl cgroup/getsockopt \
                                 cgroup/setsockopt struct_ops \
-                                fentry fexit freplace" -- \
+                                fentry fexit freplace sk_lookup" -- \
                                                    "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 29f4e7611ae8..9b28c69dd8e4 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -64,6 +64,7 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
 	[BPF_TRACE_FEXIT]		= "fexit",
 	[BPF_MODIFY_RETURN]		= "mod_ret",
 	[BPF_LSM_MAC]			= "lsm_mac",
+	[BPF_SK_LOOKUP]			= "sk_lookup",
 };
 
 void p_err(const char *fmt, ...)
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 6863c57effd0..3e6ecc6332e2 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -59,6 +59,7 @@ const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_TRACING]			= "tracing",
 	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_PROG_TYPE_EXT]			= "ext",
+	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
 };
 
 const size_t prog_type_name_size = ARRAY_SIZE(prog_type_name);
@@ -1905,7 +1906,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup/getsockname4 | cgroup/getsockname6 | cgroup/sendmsg4 |\n"
 		"                 cgroup/sendmsg6 | cgroup/recvmsg4 | cgroup/recvmsg6 |\n"
 		"                 cgroup/getsockopt | cgroup/setsockopt |\n"
-		"                 struct_ops | fentry | fexit | freplace }\n"
+		"                 struct_ops | fentry | fexit | freplace | sk_lookup }\n"
 		"       ATTACH_TYPE := { msg_verdict | stream_verdict | stream_parser |\n"
 		"                        flow_dissector }\n"
 		"       METRIC := { cycles | instructions | l1d_loads | llc_misses }\n"
-- 
2.25.4

