Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C0959C92F
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 21:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiHVTpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbiHVTpV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 15:45:21 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941BC51402
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id s5-20020a17090a2f0500b001fab8938907so6559586pjd.7
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=f9dXo4pPEYAsqiB3B/JOwW0BtYtEYxazCMt2x77C0C4=;
        b=camsaNCfzU+P4EUJ2n2f1eqmQuVEIUu7m3YWlUpqO9x43ifk4INEL+HIFIGS8dKg+Q
         29z2OxfMxQ4+MA64vGgWYjhiw/03MYHmNvlqXpN0MmuYoWp+S1/zpAqCBF+32Vm1/ZCy
         Y69RMRcf89fyaOWyMJ/eiqGflXNWQg2h228/KcTKi2QODH6hWpZV0ab8nDEGJ9wXCIHM
         bKZu1HE7PBqrVnn1TfOVjZw5wBupb3yCxCk1neGFCm+IgoO24dKo8d11l/OZxfwIF5+S
         DHiXcv+fDDUrMIdirxYpV4uv4y8v8EwfR1tVG2WzoiZLEirioLimDhCDWlfq+G+EVR5r
         4YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=f9dXo4pPEYAsqiB3B/JOwW0BtYtEYxazCMt2x77C0C4=;
        b=Hwen16grIlQIKAr9mNRug+6jfRtke7ALTjvVbTfRrf2FOM/UE9JuVpSGITEPt3R1JW
         Ka9vxxmlnr18m1pkvJRTMoKaozk23f+4x8g49PpAX7FNVGLP6N6hop5z+goSJBp5HiV1
         IMXC3ChVIKYdgR6MxBoVN3TJhTc8ViVeB1yYkdK8aMmUw505BGBn7spa8IzBdFVUWRek
         xYs2xxx/mV7/xfLwdySSEo6GsgK/ymmCeal3Xo8RkV6hiQtrBvqtsPLR/O4khUeUau+O
         2MsDTrJsK1Ih6p9GQC8RpzxgqMINkx/ja9oN+jtudwVkCGwnkf9MI4/4DMco9zXs882u
         3H6Q==
X-Gm-Message-State: ACgBeo37Pvsci9dNtgqcXzgGb+DGxQ+VTtKjApPzVRSZt3O9u36KGMJM
        QNhUHSTxpON/2/PZCJxAQS/QMPNywTDzjYkaMdVHD2DhIRfQux2WGG2j7goBU0L6RS/1aRnHQub
        oTgjmC77LqXsWVqdPjkEdJ4QjAvBc3lmd/U46dkLplT3dksIlgA==
X-Google-Smtp-Source: AA6agR694aqzZxZQ/Zl2e9qW17SLIz6OHWuw+uDCpPEWsRJ1D0w1G0N3sxO4daQ1P12Yi4XsHg9IRYE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:850:b0:536:341b:99b7 with SMTP id
 q16-20020a056a00085000b00536341b99b7mr15055298pfk.47.1661197519986; Mon, 22
 Aug 2022 12:45:19 -0700 (PDT)
Date:   Mon, 22 Aug 2022 12:45:11 -0700
In-Reply-To: <20220822194513.2655481-1-sdf@google.com>
Message-Id: <20220822194513.2655481-4-sdf@google.com>
Mime-Version: 1.0
References: <20220822194513.2655481-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v4 3/5] bpf: expose bpf_strtol and bpf_strtoul to all
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
 kernel/bpf/helpers.c | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 7561688cf42a..4301abe214c7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2133,10 +2133,6 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index dd20e2dc6ea6..2f4709378740 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
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

