Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902604E9ECF
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 20:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiC1SS5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245169AbiC1SSw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 14:18:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DE6633B0
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 11:16:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e68c93bb30so124756627b3.18
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Me/7ozlD/ZpN60GWxY7vr2NpUMtv/HbFvHkjvcqVM5w=;
        b=e92QG3GhviC5BOH5Sj0NgXCkdeGdVwE9NmuRYiA0qa1DSRS1Tm+owdUQE4PEIMVmRw
         u0IBU+Na4SiLjWRtKRpP9dxnT7XAFyhlRmopj3TuADV7kbVz86A5kFVrBRdXlMq8j4CH
         ICuiwmCut5LTqrybH3I2Q1mQY+vtxfFeFWXyvVlcezB0+wggv4u8MeuXP73AtwKACrhp
         zK7iqGq5LUKJLhUn02vPW2a4LbTycH5EHtZO12MPZ1y0Rce1x6Vlj3Ja+1CPtpbi7iBL
         gSFFhgCvGcQQ30fqiuEzkJzq/0/E+9zaiFpFHSKpEegjnYTZ1rRdzbsEzSQ36eJSf2D2
         9gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Me/7ozlD/ZpN60GWxY7vr2NpUMtv/HbFvHkjvcqVM5w=;
        b=777VklRFUgT2YR7VONZnQHLK3yKOM47VcGmv/gsAND89FJh5YwO6mV0akrqYPt4OrF
         q0YXqcr2ARvcOn/xvx+8F5zIzXWGOJUhvcahkUmhywPQxg9O5UAfmKwOYs6ZQoEJHPeZ
         ifT11CqeQzPwR4d2z0ZE5nXypHi9PwpwjLfJqnC1zpM1jGsdGeCCycbXzefmm4Tb4glF
         Udfl1hYE2Ppr3ovrDSC71522KNDfjBGhHaDnXPClpvFaShbBvBoaH/tDz5tdL1J5Vqi3
         khKOgWZw9v6EM6TLk0iZpK4SEEL+cKne0WjUepjuZKBEh85mBhyV5QjX5y6FBOwFShZv
         xGZg==
X-Gm-Message-State: AOAM530eGD7JR52QSHCMwVatL9gR/R+vfL1z9PQXn5t2awP/9tTX1QGg
        l7a/SIo5SSqruAHpAwnRdL/2Gmk=
X-Google-Smtp-Source: ABdhPJyOv4M0ANoYtFUTlHXFDTqNWvdiiVDt5tHeJgSFrBy1e3QbU7A632UstS6XZNYZGVdc1ZKehZk=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:a900:e0f6:cf98:d8c8])
 (user=sdf job=sendgmr) by 2002:a05:6902:91e:b0:621:b123:de46 with SMTP id
 bu30-20020a056902091e00b00621b123de46mr24523858ybb.76.1648491418731; Mon, 28
 Mar 2022 11:16:58 -0700 (PDT)
Date:   Mon, 28 Mar 2022 11:16:42 -0700
In-Reply-To: <20220328181644.1748789-1-sdf@google.com>
Message-Id: <20220328181644.1748789-6-sdf@google.com>
Mime-Version: 1.0
References: <20220328181644.1748789-1-sdf@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH bpf-next 5/7] libbpf: add lsm_cgoup_sock type
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
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 809fe209cdcc..195c9f078726 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8666,6 +8666,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace/",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm/",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("lsm_cgroup/",	LSM, BPF_LSM_CGROUP, SEC_ATTACH_BTF),
 	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
@@ -9087,6 +9088,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*kind = BTF_KIND_TYPEDEF;
 		break;
 	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
 		*prefix = BTF_LSM_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
-- 
2.35.1.1021.g381101b075-goog

