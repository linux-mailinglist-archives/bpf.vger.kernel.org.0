Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1B55EB3B
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiF1Rnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiF1Rnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:43:31 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA02646F
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z5-20020a170903018500b0016a561649abso7306175plg.12
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wnCeMiEyW9LikwbsLYPvrjUiGVfxF7rll4Rc+w+MEw0=;
        b=M9/zyntcRBFOfXzRgPjVx7Dk5M0Jk4hDS7KA8jtMBqp2NTd7OA+I+1DDhtEPFwRmUI
         sUvkXWY1Zei0HSXVgy45oQUsAFLZ0tT7z5H0v3PLMvN/+RhSvO5/nQgf8VQxILH5Rl0A
         AYMa9yuj9XgBbhSm2kj+G7PYm9NwBqtbjXewiWslh1o+PNerIi3Dp/KtFf8aDooBAHfO
         QZwD0Te8jWeS8YVr0zAqxJLTA2qwS8Sco1smadftEyUh7zpQnvLuJ0xJ8S+VmbyF/dgW
         7UhTqp11vJXe6qYy3Lm6Fun60RCSIpiOS+e/QT9e29+UB28NUKJwcCjJzcD8Wmk4Og2R
         hdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wnCeMiEyW9LikwbsLYPvrjUiGVfxF7rll4Rc+w+MEw0=;
        b=MtCEYrjPXrmRkKCpogxIGO3IUGvkWst6HcBL7eiko0ECA/cDwHPUfNeI59JUDaZE4C
         +pG7mZAuUeZAHNziyMdun9Rpc1FwdGDbeVQi1sEWWgsBLhEBxbd73EeSRbtjOR4gLqm8
         SWrwNOblpvBxX7weXxo3sCwLXKrvvdBVCM9A5ihFXOkB7oNLv3vqWeLgr5a36ZIQuOHF
         EwIBkqsHc+yamy7YuYnzdc1iHALYc+EiGlPn7OPv5ehtojRwl9qSQvJrfVCiPPDv2NEE
         hVdyPwbuX6vOIMtdF8mBQ5+QLS3NBUzN7CglAf8mdG5QhMOU77yfNRg12DraC7a21j2F
         8dWw==
X-Gm-Message-State: AJIora/VfI9r5zwqhgevY2DC6LPcdlW2zZN6zZUEuNsKHhWIb+49vEhk
        HeXE8mmg9+v6QswUwXp64F9V1CFsYE9ucOuncyEIS9jYQt/TNxQG2WWgxB/QEtrY3vu6f3x41O4
        zdWCIt3wjG3MDsroFojz/P+i59wcmvQIdEhOkZdDIOSiFjIRcUw==
X-Google-Smtp-Source: AGRyM1uz083ticxEIfAivrO3I06yuQHAm1HAaPAeOtitavBwALuZwnhJdPpkYW4K2MKJyhxBxjhccEo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:9f81:0:b0:525:5124:1966 with SMTP id
 z1-20020aa79f81000000b0052551241966mr5903285pfr.63.1656438209510; Tue, 28 Jun
 2022 10:43:29 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:43:11 -0700
In-Reply-To: <20220628174314.1216643-1-sdf@google.com>
Message-Id: <20220628174314.1216643-9-sdf@google.com>
Mime-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v11 08/11] libbpf: add lsm_cgoup_sock type
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
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

Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 335467ece75f..df442601100d 100644
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
@@ -9133,6 +9134,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("lsm_cgroup+",		LSM, BPF_LSM_CGROUP, SEC_ATTACH_BTF),
 	SEC_DEF("iter+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("iter.s+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
@@ -9586,6 +9588,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*kind = BTF_KIND_TYPEDEF;
 		break;
 	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
 		*prefix = BTF_LSM_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
-- 
2.37.0.rc0.161.g10f37bed90-goog

