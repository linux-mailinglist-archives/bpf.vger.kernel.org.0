Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3522026544D
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgIJVmt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbgIJM7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:59:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7C6C06179B
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so6576975wrm.9
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKonlNQ1iYdWj5mOaVBreXTvnDX7AaHqrtHE4Wi4d/Q=;
        b=pvBib/+aSfLBjNO49aqTDIl4ugGLX4HcvLj6NrZhOEspBOU80Vg82yYCxFtQ3TDQuA
         +7RY8QgRILU6tlHPc7jyxv44Tw4PputrsfZ9vw4FHVW8JrPP6aaggJoiL3/v5qqXJD6W
         SzvF55cT/30TzMGRzbhA6264yt2JwY3LTyU+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKonlNQ1iYdWj5mOaVBreXTvnDX7AaHqrtHE4Wi4d/Q=;
        b=shwcUcsBZXh3GEd433bwgtXP5IWaoe2KdGWqCXQ9f6pieie8l0y8woMxbExNW4Tmvn
         7wTpu/qEZhCthcSm1GFCXfLPP+lG3Ou+KJR8+zXLmeO35w2LlF1YKF15rEYn30EEKsB6
         H8gFj08MLhQGa+w8n+O1mMHMJBtinjSHFlNdbUUEP8Y40yJS9hIf5NDnORqqHMwFcxo/
         p5nZkM1UdhnaCo94StlOzJQjBaH7krXK0LUQVvVouKZbWTl1Ya7TBylKygpKSIfmFIxf
         cyzBi4wWrhHMwoiDacsLenesKKqr6EdQ99mOVP6ruTgEAxk4Oqt91vVcazgl7u93zLxz
         F+Zw==
X-Gm-Message-State: AOAM531StH767sTUQYliC24G/5it378vorSLywIx9tN6qyLwWr90Qwot
        UUc1WAri+U3VC9p7n66oRVD/Sw==
X-Google-Smtp-Source: ABdhPJzxjxtCnqiwcotk2XkmX93L33OAeKdZwScpA86kQ4mSyNRk3HfP3FeOl9GxMnMXWYBg13d34Q==
X-Received: by 2002:adf:f508:: with SMTP id q8mr8428350wro.233.1599742652923;
        Thu, 10 Sep 2020 05:57:32 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:32 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 08/11] bpf: set meta->raw_mode for pointers close to use
Date:   Thu, 10 Sep 2020 13:56:28 +0100
Message-Id: <20200910125631.225188-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
References: <20200910125631.225188-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If we encounter a pointer to memory, we set meta->raw_mode depending
on the type of memory we point at. What isn't obvious is that this
information is only used when the next memory size argument is
encountered.

Move the assignment closer to where it's used, and add a comment that
explains what is going on.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b11f1ec31078..c3527a32ec51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4020,7 +4020,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 type != PTR_TO_RDWR_BUF &&
 			 type != expected_type)
 			goto err_type;
-		meta->raw_mode = arg_type == ARG_PTR_TO_UNINIT_MEM;
 	} else if (arg_type_is_alloc_mem_ptr(arg_type)) {
 		expected_type = PTR_TO_MEM;
 		if (register_is_null(reg) &&
@@ -4109,6 +4108,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
+	} else if (arg_type_is_mem_ptr(arg_type)) {
+		/* The access to this pointer is only checked when we hit the
+		 * next is_mem_size argument below.
+		 */
+		meta->raw_mode = (arg_type == ARG_PTR_TO_UNINIT_MEM);
 	} else if (arg_type_is_mem_size(arg_type)) {
 		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
 
-- 
2.25.1

