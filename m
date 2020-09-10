Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04CB264680
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIJNCk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 09:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbgIJM7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:59:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B612C061798
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so6576674wrm.9
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RlWJGRa9DpFGaj3TT2sEIGRr/SyL9uJljt69t6gbXwo=;
        b=m7Wla8RzbcEGwGoViLXaQoT9upqgPPsVY34uZVJTutDe60+mzYPGnUuvP68QHEB64A
         L+Hf2rgakMG25QjuhwbU2hpuNpdYYudRLW/vFjxOE4LQLO8bKYhkOSc7kBNH+QOmsJ9m
         TiADuZLlAIk+Ig+VGRJit89grDrdv2qiS3FKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RlWJGRa9DpFGaj3TT2sEIGRr/SyL9uJljt69t6gbXwo=;
        b=aFgh5O3tTl2EzNIWlD4SPkk+34VccdSEQ3ZHwrno7tzDJJTH84ahBx1vPrS/lq7c1E
         HVJWMi4aMRrwMeHAUw7QMfrfsgxYM09rAJcsx8I9/rzZHs/n5HsNrh3MOgTR58JhAYrw
         sX8KzqKblOqrxIZUrEkdCa0BgvPARPLMYfmPyFpGK+4yPtvE/FX18pAZ2lnvZwCaZHsX
         ZOB9eMOm4J8FExvqMcMYLKyP5s3A/M34Gve8CtX4TulixgLHow0lnFF3NKon/xL9bcJj
         8QMo8ZknkQMBWlt8bB71xh/WIC5Jvd8gRn0DZzX6I4P3XxKQ7x3JVFfZg5t4IrES5GFA
         MqMg==
X-Gm-Message-State: AOAM5329qYm9Yb1J+cP+eRy1KxpctootG2r1fy1eboEla0LXo7Z3b4Ec
        xejDfkjQ6/ou52Wq73TeNRSdtA==
X-Google-Smtp-Source: ABdhPJzIy+TBBion1Fe43hlW1FLqsc26xK9TePNzE0p1DX7m2PUJXiX+H3ioPZpgQf9+Fuv5H0qk1w==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr9103653wrw.308.1599742647882;
        Thu, 10 Sep 2020 05:57:27 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:26 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 05/11] bpf: make BTF pointer type checking generic
Date:   Thu, 10 Sep 2020 13:56:25 +0100
Message-Id: <20200910125631.225188-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
References: <20200910125631.225188-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Perform BTF type checks if the register we're working on contains a BTF
pointer, rather than if the argument is for a BTF pointer. This is easier
to understand, and allows removing the code from the arg_type checking
section of the function.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fadd41ad3a4f..850d40667182 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4001,27 +4001,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				goto err_type;
 		}
 	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
-		const u32 *btf_id = fn->arg_btf_id[arg];
-
 		expected_type = PTR_TO_BTF_ID;
 		if (type != expected_type)
 			goto err_type;
-
-		if (!btf_id) {
-			verbose(env, "verifier internal error: missing BTF ID\n");
-			return -EFAULT;
-		}
-
-		if (!btf_struct_ids_match(&env->log, reg->off, reg->btf_id, *btf_id)) {
-			verbose(env, "R%d has incompatible type %s\n", regno,
-				kernel_type_name(reg->btf_id));
-			return -EACCES;
-		}
-		if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
-			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
-				regno);
-			return -EACCES;
-		}
 	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
 		if (meta->func_id == BPF_FUNC_spin_lock) {
 			if (process_spin_lock(env, regno, true))
@@ -4076,6 +4058,26 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return -EFAULT;
 	}
 
+	if (type == PTR_TO_BTF_ID) {
+		const u32 *btf_id = fn->arg_btf_id[arg];
+
+		if (!btf_id) {
+			verbose(env, "verifier internal error: missing BTF ID\n");
+			return -EFAULT;
+		}
+
+		if (!btf_struct_ids_match(&env->log, reg->off, reg->btf_id, *btf_id)) {
+			verbose(env, "R%d has incompatible type %s\n", regno,
+				kernel_type_name(reg->btf_id));
+			return -EACCES;
+		}
+		if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
+			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
+				regno);
+			return -EACCES;
+		}
+	}
+
 	if (arg_type == ARG_CONST_MAP_PTR) {
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
 		meta->map_ptr = reg->map_ptr;
-- 
2.25.1

