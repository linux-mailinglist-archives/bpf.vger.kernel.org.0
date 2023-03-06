Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000406ABE0B
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 12:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCFLVt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 06:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCFLVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 06:21:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230142410B
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 03:21:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g3so8410514wri.6
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 03:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678101704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBCO1ODrSOtxrm7KI3FciI/Fd2EO5bZOq9SR2Pr2KQs=;
        b=BHYFzYZCBN/WwySXcXoOsvWDvZuykM3KJj49UVHX585BEhnVT6uFntD7YDYyg9OEzV
         SkaDKGPp9C4dR2uHh+bK/oO7bVHG5hkzbLkWVNGwume7IyiF7OkmB3dj/CZ3mBdt40cp
         nhq2gi/vmqHsFceeJpQi57UdAUw376YLxhVPyVCDv20ycgH0cfOxK8WlUh8/YmZ/Yh9Y
         nGt8v/JM+glzwW9MAiqxe6BiTnBlD2FSMoFxXkSiZGd9BO6ighR+B+qwPWlZrDaXK5im
         DgokeZxMgKJtBHT8+IrjwqBzRNuM1y/6pIpC6tTrCFaJjp/Sn168hi887SDBfFAzsGxK
         HmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678101704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBCO1ODrSOtxrm7KI3FciI/Fd2EO5bZOq9SR2Pr2KQs=;
        b=aaFKrJnD0b5CYAHZu3ITQm4a/Z7Lv8DV+tl0/zJo1ZoI85joxBlrQ2uNcgEvArDk5P
         SvvAovTa5uqnsbV8lM1M+qPFj19cklX5mAqsTP2UbRYATEk3Uxn+AX0lhfNutcOsGaTq
         1ilYJCx0QxU1EogegZ5qmkPj+JqYyRXdYM0vluPH0GzKFIL0L2isBAWVK7GlFP6bzoDF
         Wh7FBtj57eM3enKtB7nwpcE589PL/jFzHXdSBEIErkgaVgyx+feYjTEhCsUmAel7A7qo
         Qc1MnZnD3Kjm2O4y438yRGLUGm5yGG8q1HonhPYQ32eO8IzZJvb8IjAidHdOWMDHE08Z
         PQJQ==
X-Gm-Message-State: AO0yUKVDy9P9L4nBhNA4J/r/W0Z23lIeDLBuvB9Kx0qb8PWDnoJX5cae
        y/GwEcJUK2DNzubMVs/8+damEw==
X-Google-Smtp-Source: AK7set8mXG3+3H8+RgzvRZ5+qigNreyqYeglB2EGN54BzTZcMhoZWLZOtmy7YS41mGMFjVfX7yCwow==
X-Received: by 2002:a05:6000:1373:b0:2cc:4ed1:f84f with SMTP id q19-20020a056000137300b002cc4ed1f84fmr6132117wrz.53.1678101704623;
        Mon, 06 Mar 2023 03:21:44 -0800 (PST)
Received: from tpx1.lan (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id j4-20020adfff84000000b002cda9aa1dc1sm9604854wrr.111.2023.03.06.03.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 03:21:44 -0800 (PST)
From:   Lorenz Bauer <lorenz.bauer@isovalent.com>
X-Google-Original-From: Lorenz Bauer <lmb@isovalent.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Lorenz Bauer <lmb@isovalent.com>, Martin KaFai Lau <kafai@fb.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 1/2] btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT, UNION, PTR
Date:   Mon,  6 Mar 2023 11:21:37 +0000
Message-Id: <20230306112138.155352-2-lmb@isovalent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306112138.155352-1-lmb@isovalent.com>
References: <20230306112138.155352-1-lmb@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_datasec_resolve contains a bug that causes the following BTF
to fail loading:

    [1] DATASEC a size=2 vlen=2
        type_id=4 offset=0 size=1
        type_id=7 offset=1 size=1
    [2] INT (anon) size=1 bits_offset=0 nr_bits=8 encoding=(none)
    [3] PTR (anon) type_id=2
    [4] VAR a type_id=3 linkage=0
    [5] INT (anon) size=1 bits_offset=0 nr_bits=8 encoding=(none)
    [6] TYPEDEF td type_id=5
    [7] VAR b type_id=6 linkage=0

This error message is printed during btf_check_all_types:

    [1] DATASEC a size=2 vlen=2
        type_id=7 offset=1 size=1 Invalid type

By tracing btf_*_resolve we can pinpoint the problem:

    btf_datasec_resolve(depth: 1, type_id: 1, mode: RESOLVE_TBD) = 0
        btf_var_resolve(depth: 2, type_id: 4, mode: RESOLVE_TBD) = 0
            btf_ptr_resolve(depth: 3, type_id: 3, mode: RESOLVE_PTR) = 0
        btf_var_resolve(depth: 2, type_id: 4, mode: RESOLVE_PTR) = 0
    btf_datasec_resolve(depth: 1, type_id: 1, mode: RESOLVE_PTR) = -22

The last invocation of btf_datasec_resolve should invoke btf_var_resolve
by means of env_stack_push, instead it returns EINVAL. The reason is that
env_stack_push is never executed for the second VAR.

    if (!env_type_is_resolve_sink(env, var_type) &&
        !env_type_is_resolved(env, var_type_id)) {
        env_stack_set_next_member(env, i + 1);
        return env_stack_push(env, var_type, var_type_id);
    }

env_type_is_resolve_sink() changes its behaviour based on resolve_mode.
For RESOLVE_PTR, we can simplify the if condition to the following:

    (btf_type_is_modifier() || btf_type_is_ptr) && !env_type_is_resolved()

Since we're dealing with a VAR the clause evaluates to false. This is
not sufficient to trigger the bug however. The log output and EINVAL
are only generated if btf_type_id_size() fails.

    if (!btf_type_id_size(btf, &type_id, &type_size)) {
        btf_verifier_log_vsi(env, v->t, vsi, "Invalid type");
        return -EINVAL;
    }

Most types are sized, so for example a VAR referring to an INT is not a
problem. The bug is only triggered if a VAR points at a modifier. Since
we skipped btf_var_resolve that modifier was also never resolved, which
means that btf_resolved_type_id returns 0 aka VOID for the modifier.
This in turn causes btf_type_id_size to return NULL, triggering EINVAL.

To summarise, the following conditions are necessary:

- VAR pointing at PTR, STRUCT, UNION or ARRAY
- Followed by a VAR pointing at TYPEDEF, VOLATILE, CONST, RESTRICT or
  TYPE_TAG

The fix is to reset resolve_mode to RESOLVE_TBD before attempting to
resolve a VAR from a DATASEC.

Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fa22ec79ac0e..73780748404c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4569,6 +4569,7 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
 	struct btf *btf = env->btf;
 	u16 i;
 
+	env->resolve_mode = RESOLVE_TBD;
 	for_each_vsi_from(i, v->next_member, v->t, vsi) {
 		u32 var_type_id = vsi->type, type_id, type_size = 0;
 		const struct btf_type *var_type = btf_type_by_id(env->btf,
-- 
2.39.2

