Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85E549A51
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241543AbiFMRoN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbiFMRns (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 13:43:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63F1632A3
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 06:16:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 15so5731644pfy.3
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8E8EW69SjJfLjRPxyFMXJUarXVVc6zvpFhOJ1im6tE=;
        b=ehpF0GC/kA/vqjTRYiELruBjwg4Z/4IdizdA3YJ16HOLokC7Vt62K578JRlZYBVjDc
         fVohQHqjIjiEARBJVaLtRWI/rA7rll0MduKdz2IPaWjV72WyBR7R3ft2jJ/FPLmRD8cu
         6V3WVrGbjseErdGGxV/AEDBemYRre2H+UZ7LjqPuCjHhsncPFBMsjCCf4n1qOW64bxj6
         rVI0BxXbmn4ZCrPcbl7y1kGRcZC5srG+RcygRB11mrbiRwijDahwXCXcf6eFR2YVLELC
         JbbVGisO/Y9Opi/zhNXRnEkx8DpuTFC/fTNoM9J3TrF4mwBi6KYP0f77AsqPFrVn10/K
         flWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8E8EW69SjJfLjRPxyFMXJUarXVVc6zvpFhOJ1im6tE=;
        b=6v6KjubWrB89v8FT728P/eP8YKt/8dqPgpttLtSKCwyRl3FxQwVxdeR5hfJ1nAtI5D
         ggh+vPoKtorvw3dTxARoae7qne9gvN9OvkbGQrdYNbJKJz1CV1v+Y+rhldwMkyaskFCN
         8E5psw6g98vMwKZx1n4hw7DUWqzy46dyDJ2a/xJ9sg6FqCXeQuPadPiffIDSCCGzA/FT
         VK9tOvwtdtyZpPL5Ch/AL4PL+C75Kb3k5RLyBf5sDQpmRoLSiitkm6Lprk+I8c+AN5+z
         h6sj/sHKhpVf+J+SdbvzjiybPWWAgkFEzChBeQWHKi49+o7+vBaMNqaB5u5GjPyoWPC+
         w0/Q==
X-Gm-Message-State: AOAM530OKa9b2mqq8dge515KGmgq7LQ+j3Xef8yhxPwDXj9FvFkrkgZf
        Qj2wkGJA/W0OQ+W6INwLrA==
X-Google-Smtp-Source: ABdhPJyHUxW9xYEC8N0h9QlFrid1OcatauSstYHA0RYMEjK0Kcw2DuJtLrWv+eru/EteY5c3eTOtug==
X-Received: by 2002:a63:4f05:0:b0:405:5463:2ea8 with SMTP id d5-20020a634f05000000b0040554632ea8mr6246778pgb.94.1655126200920;
        Mon, 13 Jun 2022 06:16:40 -0700 (PDT)
Received: from localhost ([163.125.33.113])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b001635a8f9dfdsm5088824plm.26.2022.06.13.06.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:16:40 -0700 (PDT)
From:   john <jwnhy0@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     bpf@vger.kernel.org, Hongyi Lu <jwnhy0@gmail.com>
Subject: [PATCH] bpf: fix spelling in bpf_verifier.h
Date:   Mon, 13 Jun 2022 21:16:33 +0000
Message-Id: <20220613211633.58647-1-jwnhy0@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hongyi Lu <jwnhy0@gmail.com>

6689139af (HEAD -> master) fix spelling in bpf_verifier.h
Spelling is no big deal, but it is still an improvement.
This is my first patch as a newbie. Hope I didn't cause much trouble.

Signed-off-by: Hongyi Lu <jwnhy0@gmail.com>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e8439f6cb..3930c963f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -299,7 +299,7 @@ struct bpf_verifier_state {
 	 * If is_state_visited() sees a state with branches > 0 it means
 	 * there is a loop. If such state is exactly equal to the current state
 	 * it's an infinite loop. Note states_equal() checks for states
-	 * equvalency, so two states being 'states_equal' does not mean
+	 * equivalency, so two states being 'states_equal' does not mean
 	 * infinite loop. The exact comparison is provided by
 	 * states_maybe_looping() function. It's a stronger pre-check and
 	 * much faster than states_equal().
-- 
2.35.1

