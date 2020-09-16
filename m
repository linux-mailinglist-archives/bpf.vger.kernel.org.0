Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6C26C692
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgIPRzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgIPRy2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B907C061354
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so7815190wrp.8
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1qkwm2krC1me1PC4GrW1m2JsGuP3YU0jl8TIW9fAOc=;
        b=EvZjtcF5t9KfxoHpTp3/wdTsk3ZMOjh7p9qN/veftr+Ni3O15/CbXpFop9yJ6o8yx/
         EXp9SilZiBo7tFfUjey157gZhL2XTHUXXVZ6vZ+QSrEvnu1RWkVzWZ24T3mti7px840w
         SHgX3A+ujQVNPmo9gpgzR102+0q3P8kTLTnfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1qkwm2krC1me1PC4GrW1m2JsGuP3YU0jl8TIW9fAOc=;
        b=GdfRxR6UTL1OgjcEhUJQrrD97Nwpeb50lIWGKro3s4ZW6C7v67Dh439hlri7cLLUWz
         Pvg0Xa5jo/BfuSegKAJ1PzK3GW2ACW1V4fK0GXjufa/P4CcohIxSiU32SNjTc7qYYw2/
         KgLKg6tsqFAkPr60jMb9/1KNks8+aCMlnATolL998nrbA+P7BM52/dB0EBQnIP9OMy2L
         CHp7GmwnEEVeLVXGPAh32CfEHrvp405O6PmF3/vzhK0GUb6NrpsPIjgD78di2Z3X3KKk
         8Jjd+IKjKRib8Y5ZPoGff5Qco2chlXnx+YBkwRGZw6lmM7rpISl+BWub3ushT2bIf+st
         VsKA==
X-Gm-Message-State: AOAM532mk0AU1DdoC/LMSC4BpMmNazAMFcVnNTanTLOiqcC1eGIwr5LA
        6kSciJ930rowUnumYszX/dzhPA==
X-Google-Smtp-Source: ABdhPJwP0sqWUn4BIu+k6PUnUvP7LBxD9dG61Ohxf88TnJXnQiqqZSMfTR+MknTwd1p3ATDcT8xNMg==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr28577228wro.121.1600278823719;
        Wed, 16 Sep 2020 10:53:43 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:43 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 09/11] bpf: check ARG_PTR_TO_SPINLOCK register type in check_func_arg
Date:   Wed, 16 Sep 2020 18:52:53 +0100
Message-Id: <20200916175255.192040-10-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916175255.192040-1-lmb@cloudflare.com>
References: <20200916175255.192040-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move the check for PTR_TO_MAP_VALUE to check_func_arg, where all other
checking is done as well. Move the invocation of process_spin_lock away
from the register type checking, to allow a future refactoring.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e09eedb30117..eefc8256df1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3781,10 +3781,6 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
 
-	if (reg->type != PTR_TO_MAP_VALUE) {
-		verbose(env, "R%d is not a pointer to map_value\n", regno);
-		return -EINVAL;
-	}
 	if (!is_const) {
 		verbose(env,
 			"R%d doesn't have constant offset. bpf_spin_lock has to be at the constant offset\n",
@@ -3993,16 +3989,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (type != expected_type)
 			goto err_type;
 	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
-		if (meta->func_id == BPF_FUNC_spin_lock) {
-			if (process_spin_lock(env, regno, true))
-				return -EACCES;
-		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
-			if (process_spin_lock(env, regno, false))
-				return -EACCES;
-		} else {
-			verbose(env, "verifier internal error\n");
-			return -EFAULT;
-		}
+		expected_type = PTR_TO_MAP_VALUE;
+		if (type != expected_type)
+			goto err_type;
 	} else if (arg_type_is_mem_ptr(arg_type)) {
 		expected_type = PTR_TO_STACK;
 		/* One exception here. In case function allows for NULL to be
@@ -4108,6 +4097,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
+	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
+		if (meta->func_id == BPF_FUNC_spin_lock) {
+			if (process_spin_lock(env, regno, true))
+				return -EACCES;
+		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
+			if (process_spin_lock(env, regno, false))
+				return -EACCES;
+		} else {
+			verbose(env, "verifier internal error\n");
+			return -EFAULT;
+		}
 	} else if (arg_type_is_mem_ptr(arg_type)) {
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
-- 
2.25.1

