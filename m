Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1C59EF17
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiHWW0h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiHWW0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:11 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B535883E4
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:26:04 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l3-20020a170902f68300b00172e52e5297so4790608plg.2
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=ndEEJnf1me6hyMiGchqzGx0+EOi7AKTvVcdH7irBtGE=;
        b=bE/6QzAjRsWJQ4nE2ZmUTewNbkTaI5Y8zFZ1TlJRR0PdOhsYyf7QllH/CgoQJ1JW9W
         ooLt2JKMCu7gH0wNPVHBkN2SXxQeHAMIganCcskhpHPxGfHmtqgT2nDcOxqvNkM6sgiA
         7/EEArERSkIPnK3Ec0Fsi512cP9Gz/1e38n0RQ7Y0ZqvvXpR5P301ucuxHbg7U8aV49Z
         QVxkFseUwqYj4Xd/T98dYXMnoM559pQGlLnT6WG/hUZqoPtgGx3rNG15Z2/sLFEdoqwZ
         JmTSJtjDFEgRBGQzLkK8Bb9zX8ngnS3OFSvO7MCyjZ1P3lZJPTGycdVOiPRIKcHcqB+d
         Ef+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ndEEJnf1me6hyMiGchqzGx0+EOi7AKTvVcdH7irBtGE=;
        b=43bJ+YVOC6DYwIDGs8FMynlUejBjYz32QBVc6IfqppkOcoinqnguerGZLDcc1vx4Lk
         0edkaC6uzAD8z1bcie5HNfMPf0WYhO/SuOFL6qtcpi/Myn2jEgXnsbg6AbBPHR4LRAmy
         aJUadQ5wLYtvTb+02NgMCJuUaJkrYVQg5j+w+QTD4BqUep7IO1iQ5Se2v/Zzr+LItp/o
         ZBAL+3/IiIHj70cFhD8jaUahGMgNXYYw7ZIMXQRAAw8SxFmHAsTUuyzZVe0YF/kZ1yzD
         8liPaPWxOIPf0PuUl1yU8AiAD9YFfS/02tXtkOVhGu49+I8ZAbAvS4wRzz4QJ36LUmCM
         DqZw==
X-Gm-Message-State: ACgBeo3jy3bDz4A+ybAESv5X1maDJomh452tU7OxPzxotenjx5LsKJLO
        BL5u8Hla9ARS34u07ZA+VWmKhY6hUK78D4tNiP/iXMex+YkdDwL1eByPbZKAnZ+DpKgRxmxjQuO
        s48L0gwewES/6IBfLte8iFfvM8UEzeSI02rElowLoW/vR39QMBQ==
X-Google-Smtp-Source: AA6agR4y7prmA2Vfbg17RlPwJFTGrip2YPEotn/GB9iFYPQgMmNrVhgTi8ERiXJ73fmLMSYMdVXQB3I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:a14:b0:1fa:bc6e:e5e8 with SMTP id
 gg20-20020a17090b0a1400b001fabc6ee5e8mr103150pjb.1.1661293562444; Tue, 23 Aug
 2022 15:26:02 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:25:53 -0700
In-Reply-To: <20220823222555.523590-1-sdf@google.com>
Message-Id: <20220823222555.523590-4-sdf@google.com>
Mime-Version: 1.0
References: <20220823222555.523590-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v5 3/5] bpf: expose bpf_strtol and bpf_strtoul to all
 program types
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

bpf_strncmp is already exposed everywhere. The motivation is to keep
those helpers in kernel/bpf/helpers.c. Otherwise it's tempting to move
them under kernel/bpf/cgroup.c because they are currently only used
by sysctl prog types.

Suggested-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c  | 4 ----
 kernel/bpf/helpers.c | 6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 0bf2d70adfdb..121b5a5edb64 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2132,10 +2132,6 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return func_proto;
 
 	switch (func_id) {
-	case BPF_FUNC_strtol:
-		return &bpf_strtol_proto;
-	case BPF_FUNC_strtoul:
-		return &bpf_strtoul_proto;
 	case BPF_FUNC_sysctl_get_name:
 		return &bpf_sysctl_get_name_proto;
 	case BPF_FUNC_sysctl_get_current_value:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6439a877c18b..2f4709378740 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -427,6 +427,7 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
 };
+#endif /* CONFIG_CGROUPS */
 
 #define BPF_STRTOX_BASE_MASK 0x1F
 
@@ -555,7 +556,6 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
 };
-#endif
 
 BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
 {
@@ -1619,6 +1619,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
+	case BPF_FUNC_strtol:
+		return &bpf_strtol_proto;
+	case BPF_FUNC_strtoul:
+		return &bpf_strtoul_proto;
 	case BPF_FUNC_dynptr_from_mem:
 		return &bpf_dynptr_from_mem_proto;
 	case BPF_FUNC_dynptr_read:
-- 
2.37.1.595.g718a3a8f04-goog

