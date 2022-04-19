Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB12C5079B2
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357506AbiDSTEk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 15:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357521AbiDSTEF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 15:04:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E2F3F335
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:01:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ebf1d99068so155357847b3.9
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1wpu/2fkzFB2CurskyJE/udheO6ocUD/juFoWBoHGfs=;
        b=L0B6qy4XlHlzjvNZuBbG99U68yulDvo3DmypVNXmIbO8Q9u4+j6H8YZmv5QVjXyvZk
         xXktsumOCK791goWNLPmhOxiW68BdT74lrZHifpN8DgWCJPCZ5g1KadrCicKiHYvFg22
         HJsGJKn6sp1EuK9eX0cwjTi5Y7W0yaBCI/cueKSksrntQlVj5wmf+YL1sAiltPXm14vs
         5Vk5xQBQ/VFOWBt39xdNjet2CC8lnBGak9IuJqtyGIVVNYnLOovD4qCOyRpCPM+Z4db5
         1tak+R148ULPdoszZ2Ap5rsydx+pLwBU9Y+40/e1uU1Ck1wAI599+W4O6Q3R28er2bmp
         XDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1wpu/2fkzFB2CurskyJE/udheO6ocUD/juFoWBoHGfs=;
        b=IDV84747cXqmHVJqQsXTAlolvxWRo8y4CEJY8g6bGvnhsh0q3/g+d38F3dvJePP4P5
         gOSUEXN4oa3YYO3M2zE2zL+rfaZPficQGj16WgQqThkbNn9CQi8O5PzEkpoHxUtHVK2m
         A3kCqLoFV0HbCLifQUo9k0Sxb90jk13o3ZfEadygdwQ2c6rPuHncDAdR0+B2xP5tsp9a
         if3j7Sf0aBuY6ZfiN8t2Zjbhbomzi7sAoksnN3P855OQNqWcvFjWUNMsuTAsx9bR90O7
         DDfmc+Box5aCMBFl7SD/gBZ4ixf6WhSDWFtfs3fMd2lrg2ZnEWlX8DFcfEedOl6oXleh
         cA8Q==
X-Gm-Message-State: AOAM530cIO2gI6sZpcGQ36Kp0lYFDoQnWolXOXPA/J/Zp8f4roh3CTxr
        eCQXtLQgmikv5KmzOawRLc5z9Ww=
X-Google-Smtp-Source: ABdhPJy9hXq9TKBr14UfXWfwK0mGlf1WPZ8JY8b+9XS0w+xrW3JZk/QpC4osoPYSelSXjEVA54xGVIA=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:37f:6746:8e66:a291])
 (user=sdf job=sendgmr) by 2002:a05:690c:30f:b0:2ef:414c:a3ab with SMTP id
 bg15-20020a05690c030f00b002ef414ca3abmr17363204ywb.0.1650394872082; Tue, 19
 Apr 2022 12:01:12 -0700 (PDT)
Date:   Tue, 19 Apr 2022 12:00:51 -0700
In-Reply-To: <20220419190053.3395240-1-sdf@google.com>
Message-Id: <20220419190053.3395240-7-sdf@google.com>
Mime-Version: 1.0
References: <20220419190053.3395240-1-sdf@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH bpf-next v5 6/8] libbpf: add lsm_cgoup_sock type
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

lsm_cgroup/ is the prefix for BPF_LSM_CGROUP.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/common.c | 1 +
 tools/lib/bpf/libbpf.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index c740142c24d8..a7a913784c47 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -66,6 +66,7 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
 	[BPF_TRACE_FEXIT]		= "fexit",
 	[BPF_MODIFY_RETURN]		= "mod_ret",
 	[BPF_LSM_MAC]			= "lsm_mac",
+	[BPF_LSM_CGROUP]		= "lsm_cgroup",
 	[BPF_SK_LOOKUP]			= "sk_lookup",
 	[BPF_TRACE_ITER]		= "trace_iter",
 	[BPF_XDP_DEVMAP]		= "xdp_devmap",
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bf4f7ac54ebf..912cfa13814d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8701,6 +8701,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace/",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm/",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("lsm_cgroup/",	LSM, BPF_LSM_CGROUP, SEC_ATTACH_BTF),
 	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
@@ -9122,6 +9123,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*kind = BTF_KIND_TYPEDEF;
 		break;
 	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
 		*prefix = BTF_LSM_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
-- 
2.36.0.rc0.470.gd361397f0d-goog

