Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D6678BF2
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 00:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjAWXWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 18:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjAWXWi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 18:22:38 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D27917CF7;
        Mon, 23 Jan 2023 15:22:37 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id g10so10453138qvo.6;
        Mon, 23 Jan 2023 15:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fb0Dqesrjqwtr/7go0R3yUjkHNdnkEwFdWq9cAVf5Uk=;
        b=DM68hg6h1fvo+mCt78/6PKBa0zRsAhHJzN1cbxTnrVDUoP838v7PDiUwJurObGK/+/
         qt71BfyO0kyUYQeViphQKllao3f+B1aOy/ScOCsCXwbsVZieUffI0fPC5WOnTw3y0DB/
         ANS8dLfMq5OtoAmAKJKDCWlsNqb3CMUBAbdBVa253xSm7bpSS5EEnKoxMcJtJsP2VlJc
         6pkqWCLbBwstmqMOL44M/6g4a3IsQOmHHVyHIHuLBBqgWP+I/Wo3fLjcrk5+Mf8eK22z
         /sfvTvPLU8y/08B+Sq9bzoanyy9kcBlzcWdE4+DBte58A9bqgfhJg7S9SkzhjGrqyWOI
         VSHg==
X-Gm-Message-State: AFqh2koS9GOChDbex0AHmoBHPP/YAutXl0cj6dCjAjJ0wfvPIwRzXZih
        qYLz+o5w8fsPD3V38rKekyMiLWlGmA0cYS53
X-Google-Smtp-Source: AMrXdXubemh4djbbzoZgJIvWWT8WgPwxtfEOEqtmvyOskFiLkaxse8tKaGpL+um5dSH8lu2YUkUPrQ==
X-Received: by 2002:ad4:4d4d:0:b0:532:1d4b:b93c with SMTP id m13-20020ad44d4d000000b005321d4bb93cmr61073908qvm.31.1674516155757;
        Mon, 23 Jan 2023 15:22:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a0a4a00b00706a452c074sm342086qka.104.2023.01.23.15.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:22:35 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next 1/3] bpf: Allow BPF_PROG_TYPE_STRUCT_OPS programs to be sleepable
Date:   Mon, 23 Jan 2023 17:22:26 -0600
Message-Id: <20230123232228.646563-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123232228.646563-1-void@manifault.com>
References: <20230123232228.646563-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF struct_ops programs currently cannot be marked as sleepable. This
need not be the case -- struct_ops programs could be sleepable, and e.g.
invoke kfuncs that export the KF_SLEEPABLE flag. So as to allow future
struct_ops programs to invoke such kfuncs, this patch updates the
verifier to allow struct_ops programs to be sleepable. A follow-on patch
will update the dummy_st_ops selftest suite to also validate sleepable
struct_ops behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ecf7fed7881c..6b8dcd542950 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17030,7 +17030,8 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		}
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
-	       prog->type == BPF_PROG_TYPE_KPROBE; /* only for uprobes */
+	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -17052,7 +17053,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and uprobe programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
 		return -EINVAL;
 	}
 
-- 
2.39.0

