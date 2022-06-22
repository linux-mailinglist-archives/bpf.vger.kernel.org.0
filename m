Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913285550C0
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376601AbiFVQEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 12:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376607AbiFVQEL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 12:04:11 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64F34BA1
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 09:04:03 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id bm2-20020a056a00320200b0052531ca7c1cso3128020pfb.15
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LTElPRlk6nNIs/oP/so8PYC11Pmr5ka01hOAoud8yoI=;
        b=kn2A+P7PT5PCBToVNThfA8rDEpqsLZVaT89w9PryWGHLkaotEPvuMWZ8H8JP2wqXij
         eJXPlBjYdfzHp0djPG/J0Ah8PVFzqwu0n60NUeTqk4aNox7LX12uAq2Yck6PJDVsSO5/
         2gcMn9mLInnZ5LMGKNkfRe8q0rcdGyP8SYJKkBnA3u/cdNNa1ElhJg/CJ98rC2zwTLA/
         80VQA3QLGeW53FVMhHEkD4FkVEOWooQBTtpPS+DDaeyJ4pis7HYf5WL9bj9XCATdEtwP
         2+yJHsO6KAJLMhLL6k6StyF1sB8EznzO0sogybNuDY6k4ZldbWd/FAyZDkmoue36p1kI
         MzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LTElPRlk6nNIs/oP/so8PYC11Pmr5ka01hOAoud8yoI=;
        b=FTujwcC7+gqtXrDHgmnvenKOdxRVMzrcSumqNvULZzT1cObxG12UuUxJgQE5/47R48
         i3K+1gBqzM8kC9z+Zbzo6wl1UsFL1q9Qqc+I0beZLbKQ8So7gQskUE8bhFlEAUQboI6g
         qww+oZ4/XLng/0/zIVI4xcfFBz1i/6XSSjPmHMZyj1/I5AX/WqL8I137qkiOF8Qs27tm
         IWRy0czXnKfLDMkRgTSsKs1AcKoUVcp8T0j24B/Pt9HbXlibUvHJ0Z1sh9uFAe3fMFYb
         Yku8fgt4bXx4S4VBSVoDPzGg1C3pg6n7c4srtpe0cqogwyyHI30pohBZ+iPU65uc8lMj
         VJOw==
X-Gm-Message-State: AJIora/gCGklFTsOAKlPxuXiT4SKtkhHixM6wUUV2AB1qhhmIAIsdNxi
        3QHYgON8c1MDVRhEVFc9p0cPfZM=
X-Google-Smtp-Source: AGRyM1tUx24uJKeLuebO7WdcPwgZUAkRt5C+q0MAhncbutaWCHjJ9BCbtLRsWBdGE6WBcbr/qLav33E=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:814c:0:b0:51b:b3ee:6be2 with SMTP id
 d12-20020aa7814c000000b0051bb3ee6be2mr35866254pfn.3.1655913843117; Wed, 22
 Jun 2022 09:04:03 -0700 (PDT)
Date:   Wed, 22 Jun 2022 09:03:43 -0700
In-Reply-To: <20220622160346.967594-1-sdf@google.com>
Message-Id: <20220622160346.967594-9-sdf@google.com>
Mime-Version: 1.0
References: <20220622160346.967594-1-sdf@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH bpf-next v10 08/11] libbpf: add lsm_cgoup_sock type
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49e359cd34df..8de7628a199b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -107,6 +107,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_FEXIT]		= "trace_fexit",
 	[BPF_MODIFY_RETURN]		= "modify_return",
 	[BPF_LSM_MAC]			= "lsm_mac",
+	[BPF_LSM_CGROUP]		= "lsm_cgroup",
 	[BPF_SK_LOOKUP]			= "sk_lookup",
 	[BPF_TRACE_ITER]		= "trace_iter",
 	[BPF_XDP_DEVMAP]		= "xdp_devmap",
@@ -9203,6 +9204,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("lsm_cgroup+",		LSM, BPF_LSM_CGROUP, SEC_ATTACH_BTF),
 	SEC_DEF("iter+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("iter.s+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
@@ -9656,6 +9658,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*kind = BTF_KIND_TYPEDEF;
 		break;
 	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
 		*prefix = BTF_LSM_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
-- 
2.37.0.rc0.104.g0611611a94-goog

