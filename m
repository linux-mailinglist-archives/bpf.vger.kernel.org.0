Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877D4522065
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346250AbiEJQCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347004AbiEJQBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 12:01:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABAC3DA61
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dk23so33857847ejb.8
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Rt7Hyn1FUO1D4PUurFy+HqT/fNYdDBCJqp18xPcopc=;
        b=NY4etXvrdr8OfGURWVUxQMQMLctLLLMCoqKA5LNVSfsEVv+HA1LyE7H4g2QKFSBzNj
         ltwo+uwfyfGCT8Gk1/BTzIbSASpYxkDSxuIESPpZjT3F6dqL7dSQKILe9l0rO6e3jGzC
         Wr9jVREoVLYEPOhWdUhb2k7DdSA7rHVRTr05ReFEpWLpwr5rgzR+22YnVrDk2PrLJP4x
         wR9i+DqPL6QekmrIk+VQ/97vWui3kV/iqYUMqwXTjbpdncu+B+KpBokhrSbouokvQI0d
         2stqzxuCOOCfveAL43tXTyND1n99uXCH7G9dmep6UeKLuHZ8AIQYhJTBhspcvbIyP13H
         ks/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Rt7Hyn1FUO1D4PUurFy+HqT/fNYdDBCJqp18xPcopc=;
        b=FUTca2PEjUBN/mT8X1KVQ2QHx1UcB8NHJVFPZb12lOZ+pG7Ah0MXyrLBXlEhOS0/fg
         3qj/MabNglFoj0DrXtbMtXEhXB9r6yJS/rVlbfwhDwRLbaJiaGVrWvsLkL63rIWwmin+
         3w/NXPaGSHNBT6FA7Ia/qxMcBtjyGTElqQK4M49tI4FQ7Dxd9mPsIDapTVDZZNb+Pa83
         mU69Y8EszgEdANEjN0hlkm3ZswVg/TIk71zyy/YrZGI3WczgYekNWMJPL6V/LUM3zRG6
         7t0snmijsfQH86thaeZOofJZI8NfrJbFLY4Mc7F2MyrQI7+NUKK4wnD89KVs7DcXnb7f
         +wYw==
X-Gm-Message-State: AOAM532JG20aQ+odBT8t8QzugEpYxnflwgmNiuKO3iTgRO3Iv9QeY24l
        3g/0ahhPRup0saOHrNdYfNJYNiS4wi/y3Q==
X-Google-Smtp-Source: ABdhPJydAzOLr4+2g3btTo65R8Fy3GZQJJk8bfQKtGHLpGtT3twP9dOkyfzWOGGEln45dODo64ZjWw==
X-Received: by 2002:a17:907:7d8f:b0:6f4:dc6f:1e2f with SMTP id oz15-20020a1709077d8f00b006f4dc6f1e2fmr20893769ejc.42.1652198022350;
        Tue, 10 May 2022 08:53:42 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-011-044.094.222.pools.vodafone-ip.de. [94.222.11.44])
        by smtp.gmail.com with ESMTPSA id s30-20020a508d1e000000b0042617ba63b0sm7806088eds.58.2022.05.10.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:53:41 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Fix result check for test_bpf_hash_map
Date:   Tue, 10 May 2022 17:52:31 +0200
Message-Id: <20220510155233.9815-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510155233.9815-1-9erthalion6@gmail.com>
References: <20220510155233.9815-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The original condition looks like a typo, verify the skeleton loading
result instead.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 2c403ddc8076..6943209b7457 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -629,8 +629,7 @@ static void test_bpf_hash_map(void)
 	skel->bss->in_test_mode = true;
 
 	err = bpf_iter_bpf_hash_map__load(skel);
-	if (CHECK(!skel, "bpf_iter_bpf_hash_map__load",
-		  "skeleton load failed\n"))
+	if (!ASSERT_OK(err, "bpf_iter_bpf_hash_map__load"))
 		goto out;
 
 	/* iterator with hashmap2 and hashmap3 should fail */
-- 
2.32.0

