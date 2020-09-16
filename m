Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2835926C8B7
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgIPS4d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgIPRyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADACAC061788
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so3953011wmk.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Qf5LrUrrFDb7ZG/DC+Ibysm2jzcOs3sVRYjuHbV+04=;
        b=gcsXLtK2CLLricYdGQQrTG2/QyorwaXXvCFHPWJwmsmpqNRdexAc9QcrbMt9z0Qra/
         Ym4j5LDElNP+RkwCF5CRfkEJwbAFFvEKjyHl75IFC0Vb/lP/L11yioBY/qJ0XUYp+ote
         T7rj52Kx4BVTgr9HOJYJzB/C4dUEvWQFKlo8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Qf5LrUrrFDb7ZG/DC+Ibysm2jzcOs3sVRYjuHbV+04=;
        b=TxmcO4y/mIfePVM7Ax44BDdR3axwcINJthwt1TawZ5nTWaS4XLgk4MP3OmPuh7noQ5
         OhKSBXntIxcRgwnffZR5Fa0Gbr0fO0qARC1OB6HWipfLJmA8cCSd6Tx2335YCto92PlH
         lggUgTia6rXsLRgAlbKYFhZvGCWRScYZpTYcNwAMzciRziWLJbeaEqfprSYxMhcamYEf
         vLarsl7B8Fkr0GcHAO6GVkL+K6lN0LhgBjz2/zVdLkofCTOwIcM1Q2I0H+m/c9vli9Cx
         OR9weRQmrxK6eDwp9JafT40o7nPT1YUWSxE0ckrtqZo+oEMqkvDmAnqztpbJepj4wCVC
         P1Fw==
X-Gm-Message-State: AOAM532Hbsml0IieKkRvX6zzyPEjyF0dZi5yOT8wjwiz8UbBXIgab4y6
        dF5jZZgehRgaE00dsRqK3fdzd1O6Rb0X3g==
X-Google-Smtp-Source: ABdhPJyr+UlGu5TjPG/Eez8but8mH08awWsPpjzQx9tNb1AiE+oIGrmeO0mLO2WD68MoWVwzjFM1tw==
X-Received: by 2002:a1c:96:: with SMTP id 144mr6003155wma.84.1600278813380;
        Wed, 16 Sep 2020 10:53:33 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:32 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 02/11] bpf: check scalar or invalid register in check_helper_mem_access
Date:   Wed, 16 Sep 2020 18:52:46 +0100
Message-Id: <20200916175255.192040-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916175255.192040-1-lmb@cloudflare.com>
References: <20200916175255.192040-1-lmb@cloudflare.com>
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

