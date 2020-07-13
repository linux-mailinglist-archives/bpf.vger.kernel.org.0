Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9C21DF1A
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgGMRrg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 13:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbgGMRrV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jul 2020 13:47:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE09C08C5DD
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h19so18937930ljg.13
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AyMfG/HsKAqlEgMq6Li9Y2u77ypCGbN506NWO50QX3Q=;
        b=UbVbBF9JMEf2IYzaTLaA8hdc6cE25wp+3t7yNtDUTZdpBK6t70DZLbPHnYLPdhPlkQ
         igvwHgibT54icmNx/nmJe5wNlTBoHUJGUUVH7qHs6NqekxongxFne1hpNHXzrtqDo3Q7
         zaCuq9LHKSfNrGn57njCAO3he3gKmRJnObgmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AyMfG/HsKAqlEgMq6Li9Y2u77ypCGbN506NWO50QX3Q=;
        b=lrxkpaSKUhI68nWWcpXWcDbBxGOWL83FwBh1C9b3L1CqLdws6wDutrFNjDpic7FcgE
         QYHFIVWdYE1dNAXoTNk0LRIFSzLGrUdFdgmrQF4WaddkC/Ys2GdD0/nSl86UZlARv++m
         1tTPiUoxxd+0o4RYqCwCZZSTJVmqRemiaNH2eKUPXISe7+cqvgSvPLDg5r/sgJVyqyRO
         gFx3v3RfdlMCUdHkyB0F+n55TW4BApYM1Z1BmqM3FdjxUbuFlViC30tgm30NDp1Mqd1o
         83cfKtWdmVhco4SUdFpV1Rt8JRKcA0TRWdcFbP+A9YTmUar2fZ29u+D9dksvVQR5f+YN
         im4Q==
X-Gm-Message-State: AOAM530S713ss7ufAEkS81VMghCtZ/GKBdDATT60voYl6T9CSX8wL7aP
        TSbYi6rDOkGZ9fs9ubfB6qiMTA0Y7LhJvg==
X-Google-Smtp-Source: ABdhPJwQq0qg5FqzJIChrRpnHkyul5R+1XxHa1aghGXAgvsN05JN3+Ivn0/IlZixXaesnmc/lD1fMw==
X-Received: by 2002:a2e:8855:: with SMTP id z21mr386110ljj.325.1594662439641;
        Mon, 13 Jul 2020 10:47:19 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id a22sm4734030lfg.96.2020.07.13.10.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:47:19 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v4 13/16] tools/bpftool: Add name mappings for SK_LOOKUP prog and attach type
Date:   Mon, 13 Jul 2020 19:46:51 +0200
Message-Id: <20200713174654.642628-14-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713174654.642628-1-jakub@cloudflare.com>
References: <20200713174654.642628-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make bpftool show human-friendly identifiers for newly introduced program
and attach type, BPF_PROG_TYPE_SK_LOOKUP and BPF_SK_LOOKUP, respectively.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v3:
    - New patch in v3.

 tools/bpf/bpftool/common.c | 1 +
 tools/bpf/bpftool/prog.c   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

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

