Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538C22653FD
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgIJVmv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbgIJM7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:59:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ACDC06179E
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so6615571wrv.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=flGDgBYbK1yfojWNgagEbTBwme1bGxX/ilfadwkiCwU=;
        b=g0euGQe+KgH8lkPvkd3vLBuwY7uWegqB3VAz3tfQJvzoh11D1bU2gG3/SFpxZIT6cM
         Un8tvg/qu2HR3NwXYRdjfl9vja1hvyIRCVg743Vl9AUWwT2dVBerVoUjYLY8DGf+Rgdb
         ajzWygQlDIm3Zza9cuHAycNWTJU8YK5Sf4JAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=flGDgBYbK1yfojWNgagEbTBwme1bGxX/ilfadwkiCwU=;
        b=rzTqcfJYKA70PkItnF+MZioLvnDfxaFDWf7wrcw83GBR2dnJJtpz0WPKFtA0Mk7vF1
         nJL5W8MUvVX6jveQFTqzReser+YekOzUwnM1Vcd5csheBKFn2Lddp6Pb6GAoOkYTY/WF
         PJKvxjEyTNpLhTz65S1+8eaVCfVDsytd9QcwkrYFcRP+8IAtpLQBUd25VCW4Shg9JrJ5
         XwHbAtN0PQaIfDKauw4YFWOlbgkivhbMVZy2PP4q1ppNFcwPmamxbMfqr1wKYTf8+7tv
         A53H5a8FmJVfXmmC86Qf0z+fZQFt30jULPxam/IFEmeO69An9ngVoRUzv00VAVmgv5RC
         xOOg==
X-Gm-Message-State: AOAM530syCDMFN1PwfZX6328C80SoGivmcnPjxFCnlzry30Kc8LzgM5R
        vVQYoiDRDUhwCZmtn2+5HHeElg==
X-Google-Smtp-Source: ABdhPJyPtafSgydO6fwVzky9UiNQsDsLlK1MvcNMIhNlMqIPpxntYf1WHKYGOOFBFMM6Hu6AU9xctw==
X-Received: by 2002:adf:e385:: with SMTP id e5mr8664327wrm.129.1599742654607;
        Thu, 10 Sep 2020 05:57:34 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:33 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 09/11] bpf: check ARG_PTR_TO_SPINLOCK register type in check_func_arg
Date:   Thu, 10 Sep 2020 13:56:29 +0100
Message-Id: <20200910125631.225188-10-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
References: <20200910125631.225188-1-lmb@cloudflare.com>
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
index c3527a32ec51..b228467cf837 100644
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

