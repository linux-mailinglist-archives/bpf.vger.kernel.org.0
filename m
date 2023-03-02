Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23256A824B
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 13:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCBMey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 07:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCBMex (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 07:34:53 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF515C81
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 04:34:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso1598794wmi.4
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 04:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrezzsKX3CNQQh1aE1R/Oh3up/yQLahHBMvgdcVIB/M=;
        b=AALLbwxufAgi1qtXiuvonhy/sYJA3HoGvt25pwS8TrTVps+hst1+ocicdb+t5OvuPy
         wT2x0Pnl3uybxDiJF5n01gNFTyFV5Ddp2hSznvcjlhTA/1NTkKPlTBBryGoBToDhJ1Zx
         Ez9a+0ZTSFWCXu2jOfy31PeYy/VNtsgSdPyHpdgqrZt8hjuGLoXn+LHY/6x+JWoJia/j
         WBHShey5zPQYf4vDh2/6jPWGHQxvlapzyWZo+uezkgovkzuEoWXR0fa+m1ZRRA8/QwTj
         h88E2yulX5lLocRAhUerUeiKtk207gN81IsDzcnh6/P8fA0JR03DWil1DaNqGS2FvZ5u
         HzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrezzsKX3CNQQh1aE1R/Oh3up/yQLahHBMvgdcVIB/M=;
        b=M7O6S2zb72M8nIFcZQOr1eZlI04yzip7RlQXZ/S8p7Q8V3g2U5LAwrTWlIoWnQYEu0
         isOa1aq6B8s8mfCG2dTOlsDZ5Mc+3I//cJ7qukwOwPMSZVAUuF4Dvd2TnYqJZlHZot7x
         3npGb1glyzdPD3smwx60BysSX7+uVPMPO6+BaS7eUEKg0HLvgp4gqhVewphACY1uQR3F
         sC+ZXMu1br3AO4D1WV+V34AMwYzgfLuWIPcOD7UlM+mJt3blpE0nqHF7WyfdYTRABadq
         zFwr28LPUFCwLh+jEAnbCzkpm92UTr9DDAOfl0cV1V4VhV3SzL75IV7ufosT9KXICzL0
         q7mA==
X-Gm-Message-State: AO0yUKXH6wjdSmDCBi8y2ww67ZJQcmHym3tPVNP0UkHmVVECFjG1CMdR
        tgWAGD/p4kqmveKpWBzbMkiYTw==
X-Google-Smtp-Source: AK7set9911P/JcoyltopCJ0H3lCKo+BZQ5jwLQSudjBZx3m7H3U1K/WJCuJ88IPxd32N7KNrD1AJVg==
X-Received: by 2002:a05:600c:5252:b0:3ea:8ed9:8f03 with SMTP id fc18-20020a05600c525200b003ea8ed98f03mr7520533wmb.24.1677760490953;
        Thu, 02 Mar 2023 04:34:50 -0800 (PST)
Received: from tpx1.lan (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b002c706c754fesm15232575wrp.32.2023.03.02.04.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:34:50 -0800 (PST)
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
Subject: [PATCH] btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT, UNION, PTR
Date:   Thu,  2 Mar 2023 12:34:40 +0000
Message-Id: <20230302123440.1193507-1-lmb@isovalent.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index fa22ec79ac0e..91145298c238 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4579,6 +4579,7 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
 			return -EINVAL;
 		}
 
+		env->resolve_mode = RESOLVE_TBD;
 		if (!env_type_is_resolve_sink(env, var_type) &&
 		    !env_type_is_resolved(env, var_type_id)) {
 			env_stack_set_next_member(env, i + 1);
-- 
2.39.2

