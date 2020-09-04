Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024D625D73A
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIDL2i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C651C0619C2
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so6369042wrp.8
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KaDl48Pga4QEbzcA0z5fJMx4Mo2Pt/XvOLNWfi7T27A=;
        b=BclZNy566ovAagP2odZPY0wMHOwiqUO5dP3BPTBIwcJ8axSeP+m5DlRyFSNG5n9Ncy
         iGoFgglP8Rg52SzdlR2wFqUC2WeGvq2N4NScgHB2brde3TM1yg77mNNktPguAz920y69
         Q8/kg2homlZPRww6CQ6nUiQyOHCWfDUZ0OXW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KaDl48Pga4QEbzcA0z5fJMx4Mo2Pt/XvOLNWfi7T27A=;
        b=XuXp6hlMTI+ls4leqr7WCMY7J2bPItKTRkpiQExoTNTUSm0AUtvtwHBkRboBPhTZZp
         FDmpbxEplTGLXXnZAaaYpfjpwkIjngs5LAcCSCw38V3/e2T6q9ndJU2QypbXD2xN0OeK
         LF/3waPT6Ag6ljjsdZsmX0/r/N3l+Vn1r1KQRXlGXS6w2EXKJVJMUtGvq/NxhF/xD7X7
         4qaOkoeHOVhwko58q8KUgw6h0KKF0noMleipuJsuI66cVX72biswbtuIaiiS2YKvNX7+
         GxfzhUoGQzKYF26mBgBO78MXJSSB9BYQM4ZkEGeaykNYBlBVLrO7fwY3xaSDXPNci9WO
         jvtg==
X-Gm-Message-State: AOAM530kCTSZy6el+nlXUpi7zDquXAevF8SXztYk3m5f7PXcySYo94+Z
        w6nns3DV3zjvscmR0q1MS0shIw==
X-Google-Smtp-Source: ABdhPJxcHsE2SFbxXWtbozn4SX6A2LJf/kFtMUYuhgZQk8aqbDWNcGPPNK17VEzVQDxLsfOgn67Txg==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr2815717wrx.350.1599218657081;
        Fri, 04 Sep 2020 04:24:17 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:16 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 04/11] bpf: check scalar or invalid register in check_helper_mem_access
Date:   Fri,  4 Sep 2020 12:23:54 +0100
Message-Id: <20200904112401.667645-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move the check for a NULL or zero register to check_helper_mem_access. This
makes check_stack_boundary easier to understand.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 509754c3aa7d..649bcfb4535e 100644
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

