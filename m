Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D55F25D73C
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgIDL2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CC9C0619C6
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so6393704wrm.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAW7ccSoKpXBNDJ+uJzqj1Q1GSSeJCNiacCC/Ro7bB0=;
        b=mkTfdlgko5wg5uZiJ0lV2YS/JwjYLs2HjjrxPsgFRNjpZZ/IAOWQzahNX4kyE1A1re
         NlQVx15axULO6RwdBs4L/arzhtgqDLc1WYoIOI7xr4JhytGjcKJkvN/QkkeJMvB499Fp
         rz1GyiSZF/Ws2V3Wx5azQAU0Jzz1Ywx89V9Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAW7ccSoKpXBNDJ+uJzqj1Q1GSSeJCNiacCC/Ro7bB0=;
        b=SE/vNRoLmjeU5ij5KMbAhEF4q7X5l4xGb7sbV4S2Z53d/AcdrPEcCxthuumdxUc3UW
         DMJltxE8SR87UgnhRRwHhqH8y7rNLcdNjXWmiUMDm5EQ0aU3C2MhKyyCzDoC3BFQsOCc
         laM7dtFdB0XGzh2+mw/jJZ8rsaMPwlOfB95umNFvYGBmQyQtQspFhNdqOtqKsDFhpp25
         m1hMJWeRmXqzyRNYFAyhWuWBX5lMdDxL4R11IPD8GoLZjZbdsKpVRHwame70KA1jGsZ6
         1XbKZfj66BDHW83bEU/rFdvT8DboJdxyh6gBN5Qe70SERaF9Mhm1A5XYlig+/ABDe36P
         ifkQ==
X-Gm-Message-State: AOAM531Hbeqg7GeNBZ0Jmnm7FL/TCiCHIuSO39OQ9kYTvgQvbPz4R6P6
        xqGU8YF4k5ft27XTgABSHX/okY3nyvbSvQ==
X-Google-Smtp-Source: ABdhPJwPXY1RC25RKYQh/t2x402qG4EJFgZn4IFEk6nZKs36cSd80P7gxAUap0WbjXNKdBEnfiIihQ==
X-Received: by 2002:adf:eece:: with SMTP id a14mr6880096wrp.330.1599218662203;
        Fri, 04 Sep 2020 04:24:22 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:21 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 08/11] bpf: set meta->raw_mode for pointers to memory closer to it's use
Date:   Fri,  4 Sep 2020 12:23:58 +0100
Message-Id: <20200904112401.667645-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
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
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ba710a702cae..734ae5af9db9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4027,7 +4027,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 type != PTR_TO_RDWR_BUF &&
 			 type != expected_type)
 			goto err_type;
-		meta->raw_mode = arg_type == ARG_PTR_TO_UNINIT_MEM;
 	} else if (arg_type_is_alloc_mem_ptr(arg_type)) {
 		expected_type = PTR_TO_MEM;
 		if (register_is_null(reg) &&
@@ -4120,6 +4119,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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

