Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0D4F8ACE
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 02:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiDGWdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 18:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiDGWdc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 18:33:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534CB710E5
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 15:31:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso5246046ybs.20
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 15:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mVRkJUJrBQiO7+Bsu1whxLXMRGnF9n+72bMW+OHddAU=;
        b=AYjwe+v0XMLfY7jZx6LsnB0JoRBo9syomvIEP6T6T7OWTEZFTxlqrmEa9/6TFm5h7i
         zabbHObdPEb6fS1hkMI7leGwyZRoN4T08PSCgSb93MA9QjsP/bjh4b48xkt9F9k6IQMS
         4ELLZMwEOmuYk9QVCZJq3U3Ad/k0jn7hBwWNbzo8jiNOFm2BiVay0d6cygSuSkgLtMRy
         ixi89Oi+4FR7LWAK1qtZwmKxyBpeQ0KLUdF1G38prXwCjTOHcTk17X+egtDD26zxk34j
         eRWQxPllBs6NpIg+ZtqVK/FiQ4UfyYFXrifhI0MSgol0iRQ5X4aZWnZX0EgAUFbrflSr
         uZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mVRkJUJrBQiO7+Bsu1whxLXMRGnF9n+72bMW+OHddAU=;
        b=7J8O6mWd6u2YkyWMWMDbPdGDfImgIllA820YIObGooB4bwFHYBG1FlVB4XD8uzKly0
         DyutA8jhXWqVbMBgrIvIMdAnBSIPIyJTUb4yr+P8XIIoccZ8xHYl+pZ4taA/QQWmvunq
         EZPn5xFg+xf/8g5/zdppCXETGoYsWfZ4+6s6kuJ5JpWyfG4vkMCMCT+RyHdgpN40O+bA
         pxv17dtJ2SQt8483sNXswpnJBgTGe73PZsvVIkiR1c1K4HZcdLfkESamKHEQVS7GyhCm
         2OQ5OcdYJlT1nFqvO5RjjnmZ+Y9NgeciqhQutXC/Qq4WmHwQsr82RwMs9kL7wRZHsyke
         77Ww==
X-Gm-Message-State: AOAM532mR3eiJh4H5f2jhsbaEYyPpFky2azG0c3yVWv8ufPa6ZhN/1ea
        1m67a3yBovX8l5FNq5GEULvnr+0=
X-Google-Smtp-Source: ABdhPJyLcjvVx5y++Qk77NNgUekWaOkb7vEEtnXRpQB5N39ZlXk4gXG6cXCB+61m3OAeTRXg4xNSZLk=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:9e25:5910:c207:e29a])
 (user=sdf job=sendgmr) by 2002:a81:9852:0:b0:2eb:9b44:37fc with SMTP id
 p79-20020a819852000000b002eb9b4437fcmr13679573ywg.263.1649370687440; Thu, 07
 Apr 2022 15:31:27 -0700 (PDT)
Date:   Thu,  7 Apr 2022 15:31:10 -0700
In-Reply-To: <20220407223112.1204582-1-sdf@google.com>
Message-Id: <20220407223112.1204582-6-sdf@google.com>
Mime-Version: 1.0
References: <20220407223112.1204582-1-sdf@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH bpf-next v3 5/7] libbpf: add lsm_cgoup_sock type
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
index 0c1e06cf50b9..2b3bf6fa413a 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -67,6 +67,7 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
 	[BPF_TRACE_FEXIT]		= "fexit",
 	[BPF_MODIFY_RETURN]		= "mod_ret",
 	[BPF_LSM_MAC]			= "lsm_mac",
+	[BPF_LSM_CGROUP]		= "lsm_cgroup",
 	[BPF_SK_LOOKUP]			= "sk_lookup",
 	[BPF_TRACE_ITER]		= "trace_iter",
 	[BPF_XDP_DEVMAP]		= "xdp_devmap",
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 016ecdd1c3e1..789726df5fe8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8691,6 +8691,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace/",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm/",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("lsm_cgroup/",	LSM, BPF_LSM_CGROUP, SEC_ATTACH_BTF),
 	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
@@ -9112,6 +9113,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*kind = BTF_KIND_TYPEDEF;
 		break;
 	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
 		*prefix = BTF_LSM_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
-- 
2.35.1.1178.g4f1659d476-goog

