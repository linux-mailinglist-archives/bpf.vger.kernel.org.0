Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79C226C8B6
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 20:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgIPS4d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgIPRyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194B3C061797
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so3953224wmk.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ReOPTCTBI89zUNcN9aZJisi4S7TTo39X4bWkAmOczYk=;
        b=RV9EKpiLbn6C4KxJBNU70Il3xaMZsz9KZuaVMIEk2/B7VfJnVT8E0W4DfVdrlRRrFw
         VkCq+XCWora9JdxGatwTczm8b84VHYfuMl4TrUS8fed/QqH6Irj5Dcx0cJuMJmviD6Aq
         pctKhA2nzsMRcorQ0iWf8FIEhYF8x8c3SYkY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ReOPTCTBI89zUNcN9aZJisi4S7TTo39X4bWkAmOczYk=;
        b=McWSwnTmmQ2WdrB554Ur5gB16qdECIQs77xECFux9SkEqzp7ifkXcHtyj5/mkOqmii
         HhbzOTznYJv7NiBIXPIOLqWaGUv1V4tlTJlKiFvprLVeSmiDnSJ9AMZRS+tNgzuzpeyw
         u3XMhC8uEc4xGAvxo8phtzktw19Fon8+qngtqh7NZzVbnsqPISdvpEiPwgsQeHzhknfK
         CzuqgDBSAs7jS2lJ98LkjeUIH1xa9sMpO0HwxkAKhvBqApKM738DYXrmzDJeubThhqE3
         ZCVALvAbLgOPsUY/zdfQ+rhNC6nW+iQp1ys0aLjcAWb9P84s9ASiw/xMZHF7Z6194CBc
         uIUQ==
X-Gm-Message-State: AOAM5324NRlM2eDpchb1y4k49v8hlVigywCCREoq9ro7Uk/9IqPT/7qU
        7st2vmVBOVgUt5BYXh8JuiWljw==
X-Google-Smtp-Source: ABdhPJyzAW6tORL1vwSLNEiMgKt6TQSwaprk34c5lMFIl+9CgUzqi42MgqHQXhEWVLiLmgWvTFTltg==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr6110454wmh.181.1600278817740;
        Wed, 16 Sep 2020 10:53:37 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:36 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 05/11] bpf: make BTF pointer type checking generic
Date:   Wed, 16 Sep 2020 18:52:49 +0100
Message-Id: <20200916175255.192040-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916175255.192040-1-lmb@cloudflare.com>
References: <20200916175255.192040-1-lmb@cloudflare.com>
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
index 9f95d6d55c5f..99c0d7adcb1e 100644
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
-			verbose(env, "R%d is of type %s but %s is expected\n",
-				regno, kernel_type_name(reg->btf_id), kernel_type_name(*btf_id));
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
+			verbose(env, "R%d is of type %s but %s is expected\n",
+				regno, kernel_type_name(reg->btf_id), kernel_type_name(*btf_id));
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

