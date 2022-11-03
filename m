Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53592617A08
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 10:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKCJey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 05:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCJev (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 05:34:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4602AD3
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 02:34:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f63so1192897pgc.2
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PqAFBiOS42xsITjoRr3FHC0NWlSrAxOw+pt6izNPrvk=;
        b=krPKlqMc8L/GDXZP15AMH6goEoFjKKk+CuGC+VtJTxr6XkJe7Ltzv4WHKAhwafy48s
         hUVVaquT4Szpyom2kSjASfxKu9Z9ZGHHNNfpXUdLboVZrUSpDdYVJ6WAHhn1nnb0r5hJ
         ukSN7FVS6UKnOOu+h8mz9WIGHreeTTRYoC/7gsz/hwJ88bzup7O/STGASCkSVJ2ncIXt
         QXAuAMfmJX0tx4j7e5ML044b2+fmBrKIdi1rMfQlran3L6XrlcFgXkbfhD+0nIuq7iS/
         lZee7vu/5oCd0417d56cQJlwlMQVlYn979U5/clO+eihjFi9geFzZgLryL5siQzOX4CM
         1CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqAFBiOS42xsITjoRr3FHC0NWlSrAxOw+pt6izNPrvk=;
        b=YRt+t4qvd/bHgjXuyVab1FKzf7L0fXDWD2fvihxWu02TdCzgxPXZMzAVeilqqYXN0d
         YPQuwaQp1GJEW/PD6/LegM/kkgb1c574Zlzp2eJPuY8wkgAd55eBuzCyQYgfiSyuRuxa
         wP57YVImIHXe/OX9Co1i1OiKnwB+bhce2i2vUgjVJB5FiTJ5z1GkMHZGpLdm2IiuKEQa
         yp0K2IQ7WuBUZkqj8qYZZyslTP4dbyfWvBJVfeV4L+vGxlC2E3qTDb3MrsJK0Dl1PenN
         7SRnH+wZ/SRUwt929a44UAXb1DpsKTgQUeiXmzl6xq/XL4YowXP0jTP/hhr6GPpnZt3p
         uSXA==
X-Gm-Message-State: ACrzQf176Me4Vk7VFYf8+bldNVJ2CbOo5dKFeRxmh/9BlHb1HAA4HYWn
        UcNtMCdS0GHZ+00UbEuFzlEitulEXk2j9IQY
X-Google-Smtp-Source: AMsMyM7ZxFc2+FfbH4t4ReLCFOnnVjyTx4/vZhkhF/QbxKeQwd5OUE105OazyVO7eoJlYP76bO7sMg==
X-Received: by 2002:aa7:9298:0:b0:56b:b6dc:988a with SMTP id j24-20020aa79298000000b0056bb6dc988amr29617876pfa.5.1667468089907;
        Thu, 03 Nov 2022 02:34:49 -0700 (PDT)
Received: from k1r0aKuee.localdomain ([20.255.2.235])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b0018668bee7cdsm177786plg.77.2022.11.03.02.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:34:49 -0700 (PDT)
From:   Youlin Li <liulin063@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, Youlin Li <liulin063@gmail.com>
Subject: [PATCH bpf 1/2 v2] bpf: Fix wrong reg type conversion in release_reference()
Date:   Thu,  3 Nov 2022 17:34:39 +0800
Message-Id: <20221103093440.3161-1-liulin063@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some helper functions will allocate memory. To avoid memory leaks, the
verifier requires the eBPF program to release these memories by calling
the corresponding helper functions.

When a resource is released, all pointer registers corresponding to the
resource should be invalidated. The verifier use release_references() to
do this job, by apply  __mark_reg_unknown() to each relevant register.

It will give these registers the type of SCALAR_VALUE. A register that
will contain a pointer value at runtime, but of type SCALAR_VALUE, which
may allow the unprivileged user to get a kernel pointer by storing this
register into a map.

Using __mark_reg_not_init() while NOT allow_ptr_leaks can mitigate this
problem.

Fixes: fd978bf7fd31 ("bpf: Add reference tracking to verifier")
Signed-off-by: Youlin Li <liulin063@gmail.com>
---
v1->v2: Use __mark_reg_not_init() only when !allow_ptr_leaks.

 kernel/bpf/verifier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9ab7188d8f68..1bb797bf9bbc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6618,8 +6618,12 @@ static int release_reference(struct bpf_verifier_env *env,
 		return err;
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-		if (reg->ref_obj_id == ref_obj_id)
-			__mark_reg_unknown(env, reg);
+		if (reg->ref_obj_id == ref_obj_id) {
+			if (!env->allow_ptr_leaks)
+				__mark_reg_not_init(env, reg);
+			else
+				__mark_reg_unknown(env, reg);
+		}
 	}));
 
 	return 0;
-- 
2.25.1

