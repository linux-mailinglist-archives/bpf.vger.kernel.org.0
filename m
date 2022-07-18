Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A1D577BE9
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 08:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiGRGwo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiGRGwo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 02:52:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E013CEA;
        Sun, 17 Jul 2022 23:52:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso11729267pjh.1;
        Sun, 17 Jul 2022 23:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iu4eZkSUg9htDp8O1YLYQnfgTwR8YljHuFYC1Yxzk9E=;
        b=QzJCh9JDGMisPXu/LXl0+eezRxA9jPyoxxOc7VbWhdKWfuhgbYJ2DU2niOooCwf+iY
         0JaU4qHBJi5ltuvFD3O/EqqJfP2bQ5uWSFiAfgbFW5HbB1Vg1RCvPXfeX6hjRGnAWoVQ
         nYMzFhM8v7aIY6Rn4SBkXcwB4K43ctqsJj5weILHrT6ChcmXUS3VphMsJZ6xRJu47Wtc
         NxyVMb/SPbQWwnlmECIuiWrS4MIRQZ9S3RM3NHESq0EMjZtF10ZS4z9DlN86IXsn3zns
         n3+wKvzfmN42w1A9rDQU0euaeSiEROXm42JrY42wdHZVJgmFkgEjYMbxVyEp+idaZ5oz
         RMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iu4eZkSUg9htDp8O1YLYQnfgTwR8YljHuFYC1Yxzk9E=;
        b=Wj3N9tglBFCINPpLnSwWrVaHwb+pSPupaRtt7LX3m3inhmJMsKsVH0kqIQ+3lWJvdn
         VW04wawBtkJRNWVAdTTZLT8GFHr4BS8ldnXwUMsM7siziJfTYffj4HoRLbuVOqm8MRDn
         9263tIy0tRvWBBLCPNCwh5aZwUIj7MvyXK3B+y9te0VYQoFWnVzY0XdOeE4nqTUsD8lX
         5/P4TQnIBR0MtHyQdCemVnk1ehSJ4U2cL2ns1DVM30DXHwjKB93/595+Mlh7ZcmamyBZ
         AHNaMWfxDosm5eepKnH9QIaAInzijYJ1/VG1TOy7fKSv6Qzc4sjffdctw4c90Kz6UZnq
         vbQA==
X-Gm-Message-State: AJIora9M84y8eps1kfNs0NAdje4ffdOfOIzKMzLbwFFGOqSdwJ4Y5/Ro
        jKZizmT93ONSk6cD9L3L51E=
X-Google-Smtp-Source: AGRyM1vQlDS5XDp3UnzR+fWjt2qwDzXq1bgCCBK/kWbxKF1filBoq8V2cf3Jb8N4cdxq+moRVR0PWg==
X-Received: by 2002:a17:902:d4c2:b0:16b:ffc5:9705 with SMTP id o2-20020a170902d4c200b0016bffc59705mr26574882plg.142.1658127163114;
        Sun, 17 Jul 2022 23:52:43 -0700 (PDT)
Received: from Kk1r0a.localdomain ([110.187.198.47])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b0016bf8048bd2sm8597911plg.175.2022.07.17.23.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 23:52:42 -0700 (PDT)
From:   Kuee K1r0a <liulin063@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuee K1r0a <liulin063@gmail.com>
Subject: [PATCH] bpf: Fix typo in comments in verifier
Date:   Mon, 18 Jul 2022 14:52:31 +0800
Message-Id: <20220718065231.26852-1-liulin063@gmail.com>
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

Replace 'then' with 'than'.

Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
Signed-off-by: Kuee K1r0a <liulin063@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0efbac0fd126..4da1a7c7657a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1167,7 +1167,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		return -ENOMEM;
 	dst_state->jmp_history_cnt = src->jmp_history_cnt;
 
-	/* if dst has more stack frames then src frame, free them */
+	/* if dst has more stack frames than src frame, free them */
 	for (i = src->curframe + 1; i <= dst_state->curframe; i++) {
 		free_func_state(dst_state->frame[i]);
 		dst_state->frame[i] = NULL;
-- 
2.25.1

