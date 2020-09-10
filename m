Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1952653FA
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgIJVmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbgIJM5o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:57:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1BC061786
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so5720063wmm.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Qf5LrUrrFDb7ZG/DC+Ibysm2jzcOs3sVRYjuHbV+04=;
        b=zHu+eWNx/MrhQlbGhY4gfjeMybiVLJn5nJLLj74EQbN8VnUULwlTm2K6/SQhgpMCYF
         iC5E4meHLjzzb/oVwwcLfXcnFQ062Ze5cV+WvNRpr8Xt1GYvbYHynKYqeiNcdTcGbXE5
         +jGopRMk+UYR+VICcK0vvws7nKC/DUtmjNx6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Qf5LrUrrFDb7ZG/DC+Ibysm2jzcOs3sVRYjuHbV+04=;
        b=dNKZT1TsouGdSwXKcZnoUdNCbojry/TaS0+qe/eQDI1EiOU2LngAizggWUhK+V2UVV
         uVRYd0PVEw780WR/t3Z/hPygZWpul8lQjWypil/4ePP1rHDdBxaay6EUveeIp02BE+pN
         PYJSDNangycjip+zayPdG/xMfof8ET08Cx8/f7UhmZHcjIzRyKxntV30/lFtylhF8dzY
         tGjvWdEFZsTbnlvLjg+Us5/PnMoGXnreMffSGklEseUlNoEKirqKUJM6ZVekfyDb3YsY
         aZlxzgiqZCkZY2jzvVwl3LKU5bCvecLJ4nQ94szP0+6Ttoy1RjJioYpFzGPF33xUjVBY
         L+oA==
X-Gm-Message-State: AOAM532Viv0GCYjY67wnmE/WXPEA3cGeyynDosxzjFKcLUvnAjszhAY+
        zyB3wOxk5wvvkXvaWffsQieHvD1+9Am/nw==
X-Google-Smtp-Source: ABdhPJyNpea3nZkbaRdG2nmhm5LSz+x3O5b5Wf8R1ExON/7WtRorzya/hKuLHKD+JPSN8mEu/KpZ4w==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr8117760wma.81.1599742643166;
        Thu, 10 Sep 2020 05:57:23 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:22 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 02/11] bpf: check scalar or invalid register in check_helper_mem_access
Date:   Thu, 10 Sep 2020 13:56:22 +0100
Message-Id: <20200910125631.225188-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
References: <20200910125631.225188-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move the check for a NULL or zero register to check_helper_mem_access. This
makes check_stack_boundary easier to understand.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 814bc6c1ad16..c997f81c500b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3594,18 +3594,6 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
 	struct bpf_func_state *state = func(env, reg);
 	int err, min_off, max_off, i, j, slot, spi;
 
-	if (reg->type != PTR_TO_STACK) {
-		/* Allow zero-byte read from NULL, regardless of pointer type */
-		if (zero_size_allowed && access_size == 0 &&
-		    register_is_null(reg))
-			return 0;
-
-		verbose(env, "R%d type=%s expected=%s\n", regno,
-			reg_type_str[reg->type],
-			reg_type_str[PTR_TO_STACK]);
-		return -EACCES;
-	}
-
 	if (tnum_is_const(reg->var_off)) {
 		min_off = max_off = reg->var_off.value + reg->off;
 		err = __check_stack_boundary(env, regno, min_off, access_size,
@@ -3750,9 +3738,19 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 					   access_size, zero_size_allowed,
 					   "rdwr",
 					   &env->prog->aux->max_rdwr_access);
-	default: /* scalar_value|ptr_to_stack or invalid ptr */
+	case PTR_TO_STACK:
 		return check_stack_boundary(env, regno, access_size,
 					    zero_size_allowed, meta);
+	default: /* scalar_value or invalid ptr */
+		/* Allow zero-byte read from NULL, regardless of pointer type */
+		if (zero_size_allowed && access_size == 0 &&
+		    register_is_null(reg))
+			return 0;
+
+		verbose(env, "R%d type=%s expected=%s\n", regno,
+			reg_type_str[reg->type],
+			reg_type_str[PTR_TO_STACK]);
+		return -EACCES;
 	}
 }
 
-- 
2.25.1

