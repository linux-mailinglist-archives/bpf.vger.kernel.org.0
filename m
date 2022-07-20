Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB94957AF9B
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 05:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiGTDt6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 23:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiGTDt6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 23:49:58 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A116B77B
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 20:49:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 134-20020a63018c000000b0040cf04213a1so7890721pgb.6
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 20:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eql3hxcSPHbX0kkNLXf/ft6hlPIR/C9QxOm8XfjBVDs=;
        b=FbDUEZ/7O+c/1l/qp7g/diwnSYRbW9w0pKR9Rayh6uxx6oApYvnlCnwb5E5o9n9ksZ
         0nka8xoMrCBG+NUYFnCsP/zJqtcAhoi6Ah0Qp/UwsNptADm8KR53kjKUm86Es/5cDZ5f
         ZxQaK/Lpw16pOEMJitLW7zS+MWSKncrr4cYC444ibyt0jCfPxisOAXSUGE3Ih8vMDCi7
         nNGI0zDVhYYSTIFXXyPKIL98+hIQSV+fHhDJvAioX8QrISWCg2O9x3PLmrjmagULMolj
         rbhunOtxfKfWHe2ACSQe8ooxBmTHjmY2llLaqySuMqEvkkRGHWpZcn2XxrUEWjVoMJom
         Tjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eql3hxcSPHbX0kkNLXf/ft6hlPIR/C9QxOm8XfjBVDs=;
        b=sz3/+aUT3AQVZrDrKd2TrHqAJSSxXtiFeLFhgrrBUArpz07wZAXAHgN1PJtjyv7Mj7
         zE1F0UBXR+H9iR6nhwfy+JmVHzk5KfB+sHyIoRJRx22XwXqSwhxr2msjoPLCSHrdnvIS
         e1gmJvy0ZYWnpxNJ5XZ2SZEFWVzXvwwa2532F45Ve/wwGEl9eljEm9aklQMTp07d+gCk
         L1bOgKf8kJACwBqOCRGgnxplAZ4ixGuIgewAEQKeKbxDgmnpFsCSspLTd9q+jP8hPIOJ
         iCM+axi1zSrkJd+GUz6Gf81gRe7QISwxQnpCRpX7J3fRPwup6LIWXUDPagQAe8HTa4eX
         EVYw==
X-Gm-Message-State: AJIora9OL7FpQNOnVQfAqH2d+yxQHUXImkeKUqiCMDmWo1ocvfaENUdF
        GBDQkFtMpHpBKLZt9jWwXxdI3cgfPWgwFzZVToR9BJ4CcMMyfk7EHxbHIw+Y3kfNkYzGUU0oi2g
        jsSiqfOQ9MXOWTurzbo4oMqMtxQsk16GvduluVemXnV0N3Yr1Vg==
X-Google-Smtp-Source: AGRyM1vD1KdDTADYP2UXuzmVabcsYrrGxvc1iN7KOYpWmPxqWBnLNKLEgZGr3mtssAxdtymc7qWvp/U=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:10e:b0:1f1:f3b0:9304 with SMTP id
 p14-20020a17090b010e00b001f1f3b09304mr342667pjz.1.1658288996213; Tue, 19 Jul
 2022 20:49:56 -0700 (PDT)
Date:   Tue, 19 Jul 2022 20:49:54 -0700
Message-Id: <20220720034954.3032878-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH bpf-next] bpf: fix bpf_shim_tramp_link_release ifdef guards
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

They were updated in kernel/bpf/trampoline.c to fix another build
issue. We should to do the same for include/linux/bpf.h header.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 3908fcddc65d ("bpf: fix lsm_cgroup build errors on esoteric configs")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a5bf00649995..0ff033afe0ad 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1256,7 +1256,6 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 #endif
 int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 				    int cgroup_atype);
-void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
 #else
 static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
 {
@@ -1285,6 +1284,11 @@ static inline int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 {
 	return -EOPNOTSUPP;
 }
+#endif
+
+#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
+void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
+#else
 static inline void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
 {
 }
-- 
2.37.0.170.g444d1eabd0-goog

