Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFCC69C148
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 16:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjBSPxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 10:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjBSPw7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 10:52:59 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595957ED4
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:58 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id eg19so3933234edb.0
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLBEn3jLcMOSmLSoNKVjC/08G00nx8V0vNuukGuHwCI=;
        b=HmxT8xbIuqoTvXfyLS9/1Q+qRwubsnGBNESzNRjFFAU1U2Hy4gBTgr7dUJSTdAqa58
         IXaiyaSpMAq3TDGKj5WrZed9sgStkEz4GPjChPdgD+MpS8qYFr6p4iiHwA44mcGuPp2B
         yNnIY1q1DqaQvDf+eGHbPgiA8VY76PJMMVvqp5XYAobSk0fuk+t/dgUGISYpQgSPzApO
         Zx8upATMP4FVQ49lVYD3JRE8X06Gc2+uKkhHD3WOqWoacP/hm9uAHCs+LiZgVv90Ph74
         jDKCXaApuUofG5jGVXZnHQghKxA/R7s4mscsg0RiJLUuPfcMo3O65DgtkBOTbm1S4L/t
         KAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLBEn3jLcMOSmLSoNKVjC/08G00nx8V0vNuukGuHwCI=;
        b=O70l1N+VsoKO7eYlii+EZjCrqqX6KYw91PxuynVYvSuv9q+6oiVT+1XjnmcRUeXPqb
         SqfqRxld1baf2nywTZWqqNxFWhEUCQRszCrSfTsjIeGFc3xhycFfMsrWODTMwxmuByCD
         fzbmYm/8PbKfOp+fpqRfeDSXNOaBZOKFOdmreIWbojdTIAM0VMYrDDYa3Rk76dH9ajeV
         STw9YI+rtnsfY3aBNmskfMuDvi8AtLdrM6t1GeAhXOElIYnZtm20YwHYvpgsi3H1G9xn
         EOz+kzCrK06Y2tYJFTuKLLnhklrUQGOMbLEY5BvYMscWSf+9FjZnQsNrQLcxw7Mu/0wd
         voPQ==
X-Gm-Message-State: AO0yUKVF+QvTgyMEhiUs13igTk4rJ33aezMfCTbDnxMBLLzjtH6Tk5fY
        cRwBDlMJQMXNtMdaY2DZTat0nuwbKJY7KA==
X-Google-Smtp-Source: AK7set/AyM50RWWGYYLNpB9sSNWuYQT8NxkWizARAkN7MvBh7gDsRech0AzElvskkDNurY6gIDk4fw==
X-Received: by 2002:a17:906:4dce:b0:8a4:e0a2:e77f with SMTP id f14-20020a1709064dce00b008a4e0a2e77fmr6887300ejw.34.1676821976457;
        Sun, 19 Feb 2023 07:52:56 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:8d0])
        by smtp.gmail.com with ESMTPSA id ay14-20020a170906d28e00b008d2d2d617ccsm104312ejb.17.2023.02.19.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 07:52:55 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 4/7] bpf: Remove unused MEM_ALLOC | PTR_TRUSTED checks
Date:   Sun, 19 Feb 2023 16:52:46 +0100
Message-Id: <20230219155249.1755998-5-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230219155249.1755998-1-memxor@gmail.com>
References: <20230219155249.1755998-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=memxor@gmail.com; h=from:subject; bh=sLl/ONgY3LjqhuNq2QP2UePimgBpCudu+JdJnC28uVc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj8kUePWgTTP1c6F+b6jgW9VwGoxjIc4mGmqcUALza J7YGkT6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/JFHgAKCRBM4MiGSL8RyoqtD/ 9DMLVZ87MIVQqXKQ/vgr9HlhM3QTWHYCwgnbXeKmXr9p7X3TBtAE0UW9Hwrmxro3mH6nohlGOLNW4G k8Lxyu35T5V2+oxfbdgUcKtS5vOibJuItIvJNd7QW7l9cz6/nH2c3iIsS6FyceVi5an3x4fTekxHC3 IH12/vmQ7Bly+f05m5KDQa/r3W1dj+8hylcQNu9eqQTFzNnB6RpiK4WomN8TdjOYj3pNtkClK8yZh4 Uxv3s2lLktG5S58PHd4IS34o967V1NbrIloE3G3MjXDw8beTZ/aTqUGjlV+ZIsBjkinTB1CnJ4t+5m VhHVVTRjPxvip+VMCp5R6w56DGUhJKv/ww2CB8HJbL/+b3diekNEeEyZhSTXCgIe9CpNPZcjIZlH8h WkjbGj7G+lQq3QpMJ7Pz5pjbLetiTxueEjY7Ro0fSAfgTPql7Qq8JCPNUfamjSuYrEfWNJkXTg325F HpHKRFPdLlVQx1eZ73togeRCX4ZMCE4IyVAD7qj0s2E+Qwkws/xHsncOxUoDCuF++bAVnYTe044GZo rKyqeLP/bZ6dDERzYPgFYJepOc13jMHZyOA3YkemrSsEls2Z6ikK/8ajtFKHCR8KyCEMZBLA+MNR5k D4G5Lm1EGLM1AA+wqMRn8NCsAaS9MnRSJo3h54lVjmGrae0hZ8i0Wan0zA7w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The plan is to supposedly tag everything with PTR_TRUSTED eventually,
however those changes should bring in their respective code, instead
of leaving it around right now. It is arguable whether PTR_TRUSTED is
required for all types, when it's only use case is making PTR_TO_BTF_ID
a bit stronger, while all other types are trusted by default.

Hence, just drop the two instances which do not occur in the verifier
for now to avoid reader confusion.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9a4e7efaf28f..6837657b46bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6651,7 +6651,6 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
-	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
@@ -9210,7 +9209,6 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 		ptr = reg->map_ptr;
 		break;
 	case PTR_TO_BTF_ID | MEM_ALLOC:
-	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 		ptr = reg->btf;
 		break;
 	default:
-- 
2.39.2

