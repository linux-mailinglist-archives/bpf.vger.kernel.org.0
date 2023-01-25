Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0167667B72E
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjAYQrq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjAYQrp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:47:45 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AEA10D7;
        Wed, 25 Jan 2023 08:47:43 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-4fd37a1551cso247167597b3.13;
        Wed, 25 Jan 2023 08:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXEvYhVDnMHXNpqr41k3IdTNthtzRVxr3+zGczCqXyE=;
        b=Vj3mRByIac6HCB6wepeCufmGmkpQgfJ8Ux/SDBiG7mf3mTYoqxZWIUw6OZ0s0Lhfdw
         1enWOm8xgxxejiYHxKyJ2lrfp2mrQ0cVM6LbsPJrEZVNVJNZGEvqJ4CoRVzKxu0We2TL
         qtqVh4yxeRVefvYO+8TAR3h11DrDrH4cLOxdaskojjaDBrtE+x1yko+PGZGoCeKeJ6Xq
         iBqW8AcyhGE9t0NhLEDv4Oku8mZUfpU1oyjqzbj0h176hjMeWYfYgDua6GIgr8kRbKMw
         lKMjp2yMCMX6npBqvjFd7zJJOz6Qr3IZ5lRI3Nu/d5UX2XebZHGoJ2+Vc7U17lzWdcR2
         YhjA==
X-Gm-Message-State: AFqh2krZjlPq0jPkjnL0wFBtSs4J0sYgEux3Ws+Wt0fJfyqCIk0ww3i3
        Olu2/XpY1czljoZZBASHCYWhVACWIezYbhgr
X-Google-Smtp-Source: AMrXdXsQABazh4tUBPXcOonJJXYR4Y77SU0UHvOs8sVwgi13soYGjLykaX0Cz8B/xhOJcn+Urs/Yaw==
X-Received: by 2002:a81:1353:0:b0:502:9f7e:3117 with SMTP id 80-20020a811353000000b005029f7e3117mr13066092ywt.10.1674665262446;
        Wed, 25 Jan 2023 08:47:42 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:113e])
        by smtp.gmail.com with ESMTPSA id q15-20020a05620a038f00b007090f7a4f2asm3769263qkm.82.2023.01.25.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:47:42 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v4 1/4] bpf: Allow BPF_PROG_TYPE_STRUCT_OPS programs to be sleepable
Date:   Wed, 25 Jan 2023 10:47:32 -0600
Message-Id: <20230125164735.785732-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125164735.785732-1-void@manifault.com>
References: <20230125164735.785732-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF struct_ops programs currently cannot be marked as sleepable. This
need not be the case -- struct_ops programs can be sleepable, and e.g.
invoke kfuncs that export the KF_SLEEPABLE flag. So as to allow future
struct_ops programs to invoke such kfuncs, this patch updates the
verifier to allow struct_ops programs to be sleepable. A follow-on patch
will add support to libbpf for specifying struct_ops.s as a sleepable
struct_ops program, and then another patch will add testcases to the
dummy_st_ops selftest suite which test sleepable struct_ops behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c                            | 5 +++--
 tools/testing/selftests/bpf/verifier/sleepable.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb38b01b738f..c8907df49f81 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17114,7 +17114,8 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		}
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
-	       prog->type == BPF_PROG_TYPE_KPROBE; /* only for uprobes */
+	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -17136,7 +17137,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and uprobe programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index bea0daef908a..1f0d2bdc673f 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -85,7 +85,7 @@
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
 	.result = REJECT,
-	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter and uprobe programs can be sleepable",
+	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },
-- 
2.39.0

