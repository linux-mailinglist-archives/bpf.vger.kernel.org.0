Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435EE5E5E15
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiIVJCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 05:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIVJCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 05:02:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F4B56FA;
        Thu, 22 Sep 2022 02:02:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x1so8186678plv.5;
        Thu, 22 Sep 2022 02:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=xn6RlTr8ckVr4zPO2iPMNxIoIGe5/ZMVzrDWiMBmZdg=;
        b=GnprJfwNna0lfdMeJ0jRLIGPXbGUv2oq1aYAPDC1mJkAxHC8scqlcYof+dutSc3dT+
         vOryTBvO68zWikU/4yrAzSykTlvt+W16QJ7yHFYZUCpwrth25//yZGZpdW4+Gs5vaEq7
         zqzWZxB8kT8rmWpDzeSK4CXGYr6tpWinuY0B8JFqWKPT/62A1KKl9m7va++TbVkOnc2i
         Odwtk6pTZJUvN3eWEEIZIqAibNfgDW+or+foItFPd/bDy4h9YvwvZ2kRIn/Sn4Y2Cany
         A4pDc9r4oHjOYkmn1G4giHpW121cKHBbHANexg3HbkDENREWsgGtqz43ITcDQDvsKUOi
         j5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xn6RlTr8ckVr4zPO2iPMNxIoIGe5/ZMVzrDWiMBmZdg=;
        b=Tg8J0cVQOv7MMMTOGwTTxkV1WTCtci4V8dqAKSAwtw8fPvFPJhmXlOgVncMoZ2gQ/g
         dD1Ij3S0DuqAlBEMZslsQjKZynIO4YauV2o5bZAk00pPm/VBBERISO+FJww24BtvJm6M
         o3/yqsINP0N6+H3OosRXtI7qwsBydHwUTQQpOcaSdDusgz3Zuwq3pT6GC+Ch/sx8Rqwb
         tePn9KptVf798pVcCNJg4AmnUrFV5Ka/w0xi3pIbRlN9yN83CNrpBIU2AAaOCBP18vYU
         mca+5fdue4+tB0I275iTZqFrD9EL7N1ZmcyxG+sl9KbvIqDltTUm4GnfEJgpwlCPlgqf
         bKRA==
X-Gm-Message-State: ACrzQf0I0PvV8z+ZVZ2rx5PqN5IFrhbnDm5tcKfhdBmUXdzXRG6QS2Dv
        FKaFkRiM2hVmiX+gM9+ULg8=
X-Google-Smtp-Source: AMsMyM40PP8Kig8AK7nTNLvxKkAeNPV3uh9pkfvxxyXtl2E0LnYNA6ERi9duf5pRQYtlF1sYnUU3Jw==
X-Received: by 2002:a17:90b:1e44:b0:202:b347:2daf with SMTP id pi4-20020a17090b1e4400b00202b3472dafmr14332472pjb.34.1663837360662;
        Thu, 22 Sep 2022 02:02:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v16-20020a634650000000b00434760ee36asm3287589pgk.16.2022.09.22.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:02:39 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linu-next] samples/bpf: use absolute path for dd
Date:   Thu, 22 Sep 2022 09:02:31 +0000
Message-Id: <20220922090231.236152-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Xu Panda <xu.panda@zte.com.cn>

Not using absolute path when invoking dd can lead to serious security
issues.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 samples/bpf/trace_event_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/trace_event_user.c b/samples/bpf/trace_event_user.c
index 9664749bf618..d841918accc9 100644
--- a/samples/bpf/trace_event_user.c
+++ b/samples/bpf/trace_event_user.c
@@ -126,7 +126,7 @@ static void print_stacks(void)

 static inline int generate_load(void)
 {
-       if (system("dd if=/dev/zero of=/dev/null count=5000k status=none") < 0) {
+       if (system("/usr/bin/dd if=/dev/zero of=/dev/null count=5000k status=none") < 0) {
                printf("failed to generate some load with dd: %s\n", strerror(errno));
                return -1;
        }
-- 
2.15.2
