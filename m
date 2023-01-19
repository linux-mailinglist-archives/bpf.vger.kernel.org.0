Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63746747B0
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjASX7O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjASX7J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 18:59:09 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709CA1035;
        Thu, 19 Jan 2023 15:58:40 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id fd15so2965476qtb.9;
        Thu, 19 Jan 2023 15:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKRCUj81pWlsxIqG+fTGHbDswY+2SyibM6bwK5XjFU8=;
        b=wRKjSN/jcyKsYZtCDV1pJ9PBeVtdjVN7g3Mw/KXdk+DWXx72Y47lzrxMQwPW1Yndy8
         7ztn4k3FZ45pzZotGWN529uXCQzqrW8GT4/77nhCZ5ZALdlheKhozsrEHxlmj2lr07k2
         koCirbVV/nTBwAQd5yUa6CBadtwqZPGG/LT8K6kGhBbI7zn8N3lxu1HZJrGrBajmqKEa
         QC6A7xo4aazZ6V+bsXS39Wwv0CRIm22Oyy5f7XF6hWKkJ3CrYpo/H8CSLnpuGSQ0PyUa
         aRV3l7ia53sS4wlTPvPwKxrdukKurdaQmzhSaA5MUkWmObYSrpLbL2Kv7MXS/eame76H
         jcWw==
X-Gm-Message-State: AFqh2koly2aqm8rfcV3CntHXhbypUri9yBUs/1QqNEvBeMPwgefXkl+k
        jj/fLtj3ALVtUJM8ADuUZPseOQN7mPUTfvdc
X-Google-Smtp-Source: AMrXdXs1i8IGhDIz+uFCQpo4fb2V2J4MHMOiE07BziVIJy8A/qbgLnfBrxVuM+yGZ77dBPHAXzehYg==
X-Received: by 2002:ac8:5ed2:0:b0:3b6:313a:f461 with SMTP id s18-20020ac85ed2000000b003b6313af461mr16016812qtx.65.1674172718895;
        Thu, 19 Jan 2023 15:58:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id fz18-20020a05622a5a9200b003b643951117sm4030384qtb.38.2023.01.19.15.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:38 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 3/8] bpf: Disallow NULL PTR_TO_MEM for trusted kfuncs
Date:   Thu, 19 Jan 2023 17:58:28 -0600
Message-Id: <20230119235833.2948341-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235833.2948341-1-void@manifault.com>
References: <20230119235833.2948341-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

KF_TRUSTED_ARGS kfuncs currently have a subtle and insidious bug in
validating pointers to scalars. Say that you have a kfunc like the
following, which takes an array as the first argument:

bool bpf_cpumask_empty(const struct cpumask *cpumask)
{
	return cpumask_empty(cpumask);
}

...
BTF_ID_FLAGS(func, bpf_cpumask_empty, KF_TRUSTED_ARGS)
...

If a BPF program were to invoke the kfunc with a NULL argument, it would
crash the kernel. The reason is that struct cpumask is defined as a
bitmap, which is itself defined as an array, and is accessed as a memory
address memory by bitmap operations. So when the verifier analyzes the
register, it interprets it as a pointer to a scalar struct, which is an
array of size 8. check_mem_reg() then sees that the register is NULL,
and returns 0, and the kfunc crashes when it passes it down to the
cpumask wrappers.

To fix this, this patch adds a check for KF_ARG_PTR_TO_MEM which
verifies that the register doesn't contain a NULL pointer if the kfunc
is KF_TRUSTED_ARGS.

This may or may not be desired behavior. Some kfuncs may want to
allow callers to pass NULL-able pointers. An alternative would be adding
a KF_NOT_NULL flag and leaving KF_TRUSTED_ARGS alone, though given that
a kfunc is saying it wants to "trust" an argument, it seems reasonable
to prevent NULL.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9fa101420046..28ccb92ebe65 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9092,6 +9092,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
 				return -EINVAL;
 			}
+			if (is_kfunc_trusted_args(meta) && register_is_null(reg)) {
+				verbose(env, "NULL pointer passed to trusted arg%d\n", i);
+				return -EACCES;
+			}
+
 			ret = check_mem_reg(env, reg, regno, type_size);
 			if (ret < 0)
 				return ret;
-- 
2.39.0

