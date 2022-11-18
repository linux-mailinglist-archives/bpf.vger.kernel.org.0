Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D835262FD80
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 20:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiKRTAt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 14:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiKRTAa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 14:00:30 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B382B268
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:00:09 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q9so5737564pfg.5
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnVNMob24m9mgHfPtleTP0yfbbuXtLElRpSIJwbEj0s=;
        b=d7RT7grMVwf4OvOE8K5UtldSfszX39OjCZakthlLNrC69We6wTX6Udynuoc9059Qyr
         umjFZxWV9w3JDn+V9fF2LOOcbW+OUWlS6IStwXh2w/hxgGO36erEvJlgnCk3gWU4eWse
         A++bSRk/eeId5GDyYTvPUFuicaUznp3aXuCPbFhKWZ0SB35oTt0hX5UpnWYelWYwcvGu
         oa4gT77k5YoQ5jkYKRy6t2CfMWBuTrMzLWLC1txuZhHZMzw/YkGg3gwaua9QZRcxuAz+
         mXYRwX/VwrgyNowGBq61ZO5bUO4nT0DvLZyBQiIcmWNjkkdGjUFTspU2ZCAl0QkyYWKp
         oaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnVNMob24m9mgHfPtleTP0yfbbuXtLElRpSIJwbEj0s=;
        b=qN1BIJogzGIIff163k+izVlRIBi1QV7RODPvocjdWcOJgIlUIoCM+EkBlsjYYYTUw4
         14TGjWR8hLXhz5i6ekJdzsoqjqpnTVH6ovmjWaU9DiE6iyqrdcJkwKl2K8263scPMUev
         EXsVbVTlT4MBJFDCIV0P1P/bTgJqg7uGpXEpJmHEElfQkMPwKUFEvp/1en2bq/of0so1
         +MAocvSo2rMRZM1GEc0D5ZMWJrGUNB51bXK8bsvIp3WND2J5v7OHVftOWG0OhJTPi6C2
         QhrwMaY8Wd2rtLsf0WBBKuHx42J/jR4M6ACWVxX2wP9+yndhlDh1Tz83ejgPxpXP+nBX
         zQCQ==
X-Gm-Message-State: ANoB5pkQcX6cfC/12OcQ5wm237PM5DizPfu/ezFyvB7HfIiu0KwJhUJy
        ckcOe4RraFDbvVdQ6TexLSsgu3/AZuE=
X-Google-Smtp-Source: AA0mqf4WxbDKr+VHzX6B2SifYLDHSJB/VnotKjuJqStLwD3A4Qn94j/DlTvkJQvOfWKWdFM8BI/eTQ==
X-Received: by 2002:a63:2105:0:b0:476:e987:fcfd with SMTP id h5-20020a632105000000b00476e987fcfdmr7829120pgh.29.1668798007777;
        Fri, 18 Nov 2022 11:00:07 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id l125-20020a622583000000b0056baca45977sm3535110pfl.21.2022.11.18.11.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:00:07 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Skip spin lock failure test on s390x
Date:   Sat, 19 Nov 2022 00:29:38 +0530
Message-Id: <20221118185938.2139616-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118185938.2139616-1-memxor@gmail.com>
References: <20221118185938.2139616-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=memxor@gmail.com; h=from:subject; bh=NOuDm6z0AAenll3MGsNv6NfyBuJdubDOkWN+3DsfDtU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjd9WiLB6fpGrK1l3zQzh5GJJXKKLe4LGrb2dVV+Sp rHYQ6WiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3fVogAKCRBM4MiGSL8RyoAlD/ 9vqSYOr9bf2Os3TRWCls/EWSZudgjvoUYLaSpgjNvh+oNxnew4wVB9JBC52jbU1336LJewmUPSo3B9 GyzQ0dFNbYJfZ+OnY1Rsa0f+zECdPx2F7sQUSrPM+7iq7372d4sS5Ai2NRTP+VY1zKoPhj3QjOzLeV l93S0jBGX9Q0ZxvennsXjT7R6nm0mEe3Tpk746eX/mGKnYUxINJJT959o0MmtkV5G+sfixPkj7wxMC al+dvUuuMaVpdwc2Ls8+DJh9c9FzBMP6BrBQIOr+6RdzqpV/3kN30mdDLc/3PcXoc+Xy8MGLq6ciL8 M6IaE6Kb/VS+0tW6O6fOslw7xWxGWP2Pj/MULLpAMSgyGd4QkoJYLZOkZ+jNNaktpKNRKSEBsWCNU6 HeswKCw0NEBvxbv2UyOpdWANu+xcG3X4gIzEwUofTakH8dRTxtxR8+VIz+9yaTCFNF+Yu9hdkPnjdy 0oYewtNAV03QSnJSs4h4Op8oqy/+2XH1w/ha2RFYHoq4oDcQthsiZxmFgP0PVnj31xHzPsn0jae+O9 83SigT3frNWkSpP5y2xn6dZmCb0cx1XIeMsCrIwAenAi7evSDNOxvOGDvi3dFsEtYn3eai/bp+wnZP WQclPFEt5hZbHs8yeBf+5+3wnyMl7Iqf9cVc60VdjuIRH0SlKGQ6pIzXf7IA==
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

Instead of adding the whole test to DENYLIST.s390x, which also has
success test cases that should be run, just skip over failure test
cases in case the JIT does not support kfuncs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/spin_lock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index 72282e92a78a..d9270bd3d920 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -68,6 +68,12 @@ static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
 	if (!ASSERT_ERR(ret, "test_spin_lock_fail__load must fail"))
 		goto end;
 
+	/* Skip check if JIT does not support kfuncs */
+	if (strstr(log_buf, "JIT does not support calling kernel function")) {
+		test__skip();
+		goto end;
+	}
+
 	if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
 		fprintf(stderr, "Expected: %s\n", err_msg);
 		fprintf(stderr, "Verifier: %s\n", log_buf);
-- 
2.38.1

