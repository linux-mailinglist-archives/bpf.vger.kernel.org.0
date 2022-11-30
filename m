Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E46F63D093
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiK3I1L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiK3I0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:26:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD36711A8;
        Wed, 30 Nov 2022 00:24:42 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k7so15935302pll.6;
        Wed, 30 Nov 2022 00:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCwWDY7A5zziFJP94Jv5F0FRo6+xcm6X2sOasxBuB3o=;
        b=EC4pL5gGWBRqUVIAXv7YYhncHn3GjLY4MOa5M8M9RrHHrbGakKN7ObFNYwwe69u4RO
         +9mVtohnknVMahSlffehR69/gCG9Rv5qIZakZe/uQMm7pqSRdXy2Q8rDwBOs3wWSryWf
         3QbVkTYOciPUHFFu3XlwyfssWIYVFuD6NQeSLv+32PapLcos7GjAzpxtRwn1+dUbzMeH
         5PcSOXE7IPrVfGZ3Uap8IW7oh4p+2HO+9DgH/3MaxzCX0jGyS4CpstzSdr+SQb650d/J
         g4oi7jNXGX6FF3ZBSowF8AoeUiMtrKOWg1wvBFHGlFH1Jlxohw4277rUrXEw2XX3lO/9
         +WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCwWDY7A5zziFJP94Jv5F0FRo6+xcm6X2sOasxBuB3o=;
        b=I3zC3SPBeYUjRFAEzMVa5Fgg/ii4/yu61UMmbEe+SiyIVQwC5sY4YDOpFke0sj6jkg
         CdtYJOFX7iQKvgN8LmC//n0zOVyS/Zy2PJdlHIHLmdZeCwnWxk4CIxJu7YeVdDnncPEI
         cD9yI5diBXPYjy2KTK7jcKHh/VrA1JC9CjHALebrlnz1YmXmSogswyLfirxtgcogBE5s
         JOOAXfmZXhjlIbVBu6qERk4dXTELZfuJjHs0ti9pX/qfJj0d3ll+MZ5eIOaIh/+XSHVx
         po+YtOKSx6xTHfWR0ySpkKko1DqKNYpEO9C3hSXjPm/hmWJODigwv3nbQXg4GLhANRIt
         GgGg==
X-Gm-Message-State: ANoB5plXbAR56boL2yzrfZiViqCfcs38t9Ll1LklWhNIgnEImiau1Cre
        31WuhCfRNOn1IKiITrK9BDg=
X-Google-Smtp-Source: AA0mqf4MaKQiWtHhjv1W3oXmBFdXCEHg7OTn3mFDTQXZtH4K4ikGQNetNRAHaHZxV+1Zft84MtFxwQ==
X-Received: by 2002:a17:902:b68d:b0:189:ab77:d07 with SMTP id c13-20020a170902b68d00b00189ab770d07mr1017940pls.53.1669796681405;
        Wed, 30 Nov 2022 00:24:41 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id mp4-20020a17090b190400b002192f87474fsm683580pjb.37.2022.11.30.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH 30/31] BPF: [TEMPORARY] Nerf BTF scalar value check
Date:   Tue, 29 Nov 2022 22:23:12 -1000
Message-Id: <20221130082313.3241517-31-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

THIS IS A TEMPORARY WORKAROUND. WILL BE DROPPED.

This is needed for scx_example_atropos for now. This won't be needed once we
have generic BPF bitmask / cpumask helpers.

NOT_SIGNED_OFF
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Dave Marchevsky <davemarchevsky@meta.com>
---
 kernel/bpf/btf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5579ff3a5b54..1dc5a6e5e530 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6400,11 +6400,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 						return ret;
 				}
 			}
-
+#warning "btf argument scalar test nerfed"
+			/*
 			if (reg->type == SCALAR_VALUE)
 				continue;
 			bpf_log(log, "R%d is not a scalar\n", regno);
 			return -EINVAL;
+			*/
+			continue;
 		}
 
 		if (!btf_type_is_ptr(t)) {
-- 
2.38.1

