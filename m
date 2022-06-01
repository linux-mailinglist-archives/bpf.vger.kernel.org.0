Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E853AD69
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 21:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiFATnz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiFATnu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 15:43:50 -0400
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185101CAC08
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 12:42:28 -0700 (PDT)
Received: by mail-pf1-f202.google.com with SMTP id x21-20020a056a000bd500b005188ce4a068so1559051pfu.17
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UWMxiNyOlwtIdc3KQ0mHBpB/pAdWJlzdFsAZun7WkFE=;
        b=ifCfxZYqhDp1dPmwYPbtNaJASUd6PIp2vtBOnukFkDAxUdp0lRXEwulPEGZ/3mwfBL
         Wm80f4co2PZFiJv85JKL6oOupKLfcr14hjpoj1/KwPsCHi7BYGyC2L4kNkXNbIt1ONmd
         89NUBTFr+mtIvHVqfOdxoVVs5hVUUUx+gOs7f6Zojbs2mI2b9uVq1wfpz41BjiVEVX4I
         3Ur15yCLlUuOCp+aa4jf804n1w29DjfVd/+TJMJG7gOFbWRCrAqpVK7K+o++GAzzzh7U
         Um28h/p4dHMLHExl8pPtNUJ4hvgAv7cwHnVQziU5+/UFIzJjT/zqvDPTOQOo3js95t7X
         r0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UWMxiNyOlwtIdc3KQ0mHBpB/pAdWJlzdFsAZun7WkFE=;
        b=HwHRtZ1FQIzG63TJapNaOcxgECb0lAB5sZWrqbV+dBZmpKlVRATSz+TnY5qh/tT27D
         C4JB7v1xFm8+zxWBlMbmxZ8Aved/mCVBd/vWX5nDHfEt0QzZ/8sDbiHHjR4JVdP+KJmu
         OalTa6nYkSlaDHyuRTeVnIW6y2NQxAhGlsKvwBWMD8lDsS3JtEsK9GMUU1FdAtz7YftJ
         HSrG9FZ6NnHOGTOCoW6s0EAh8wGUTK1EDHrfTr+aFmdEhZQFeUYBbgc5t/Xka2XL+f4X
         +91AqkRefMsQb0mAfdIqJ2U+L+2CQOFaXTa4pjOEUTNHwNoI3+uodyvb5tzBZi/nfTgL
         rXwA==
X-Gm-Message-State: AOAM530awb+ZOG3UrfOGrOaq4QZku1Cc+2V1IzqnK8zEHU43CCYxf1aA
        8O12tMvfqMkxrHlBjlBBYhhao+Q=
X-Google-Smtp-Source: ABdhPJzNOi+ea50i2kSCcq9jcTne2sIbjuCUrl4O7DF7+LSX66rgt7ZVN7MztbXRtM7NM/JnvnWKToc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8094:0:b0:505:b544:d1ca with SMTP id
 v20-20020aa78094000000b00505b544d1camr1024439pff.26.1654110152115; Wed, 01
 Jun 2022 12:02:32 -0700 (PDT)
Date:   Wed,  1 Jun 2022 12:02:14 -0700
In-Reply-To: <20220601190218.2494963-1-sdf@google.com>
Message-Id: <20220601190218.2494963-8-sdf@google.com>
Mime-Version: 1.0
References: <20220601190218.2494963-1-sdf@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH bpf-next v8 07/11] libbpf: add lsm_cgoup_sock type
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

lsm_cgroup/ is the prefix for BPF_LSM_CGROUP.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5afe4cbd684f..a4209a1ad02f 100644
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
@@ -9157,6 +9158,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("lsm_cgroup+",		LSM, BPF_LSM_CGROUP, SEC_ATTACH_BTF),
 	SEC_DEF("iter+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("iter.s+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
@@ -9610,6 +9612,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*kind = BTF_KIND_TYPEDEF;
 		break;
 	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
 		*prefix = BTF_LSM_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
-- 
2.36.1.255.ge46751e96f-goog

