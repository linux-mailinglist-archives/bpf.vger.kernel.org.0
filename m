Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05872633F8
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgIIRMs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbgIIRMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DD7C061755
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so3037232wmi.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVaRhPtTCKYUd1OR8smKPYRzI8O1WrnlDxYpWuDwWzQ=;
        b=RLjfnxTxfOfsy+HTBA4nT9yHVKEfZOcoBiZK4n7PkkhGhhNnsvHicDVo8NOuk+2mM2
         NxUaPw3sDTl1E/7Lrw0CAUn7pdNw7Y8t0W/fAg02d79JcOVUh8HS1hJK28HXgeELy7zy
         EIlkFkoWEOCEeVpykeDBJuk4TJbJUXYDm4Ghw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVaRhPtTCKYUd1OR8smKPYRzI8O1WrnlDxYpWuDwWzQ=;
        b=L3JFpHiy5dk0v0tJa6AoBS54QQgOcsgWbMAOdFQNPxsRCixPXyag5MwfKP10eIVI7p
         yU+uzVWdkZwCPxUv1wxlFpdQFWSykZ5XCb3rU0hXQQksClRYe9Qbvr4maSrah4rD11tK
         ZJvg3hj/5iAt7iBv6jNvJE0M3nML+/C68bZEArpekWRvcLQimzNZuW6/OH1ZXpe67VCB
         tds0uAG49jOtHk+N1LaiSdXWFksqv7Gpa13K6N8RhoXD8F/B/QlZ6aoQhEFwUXnB2Ot+
         6snZciBUKECiW7k611L+eWheJsXwgNu+KO/mthVbBDLXHb91J8EH3w7dHspGLfhscbPw
         JC/w==
X-Gm-Message-State: AOAM532WIOnADaz0VFCD/6/jdtro+W/iwq4ZixaGkrugh3JPxl783APz
        ebD6i1szhLbjsrIeLEQqlE0K0s+63WcU6Q==
X-Google-Smtp-Source: ABdhPJzjRq4a7dLdbm4S/P4haPQeOwzErGL5/RiUYvBf2OzdvUBDfbUYggY8tt5VmMOvncpax8/qWA==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr4225831wml.184.1599671527736;
        Wed, 09 Sep 2020 10:12:07 -0700 (PDT)
Received: from antares.lan (1.3.0.0.8.d.4.4.b.b.8.a.1.4.5.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:e541:a8bb:44d8:31])
        by smtp.gmail.com with ESMTPSA id g131sm3746743wmf.25.2020.09.09.10.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:06 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 05/11] bpf: make BTF pointer type checking generic
Date:   Wed,  9 Sep 2020 18:11:49 +0100
Message-Id: <20200909171155.256601-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909171155.256601-1-lmb@cloudflare.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
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
---
 kernel/bpf/verifier.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7182c6e3eada..b949e0afef8a 100644
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

