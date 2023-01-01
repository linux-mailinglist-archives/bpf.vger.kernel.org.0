Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F9165A94B
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 09:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjAAIeX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 03:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAAIeW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 03:34:22 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45D662DB
        for <bpf@vger.kernel.org>; Sun,  1 Jan 2023 00:34:21 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v23so26954858pju.3
        for <bpf@vger.kernel.org>; Sun, 01 Jan 2023 00:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkER6R3nU+Ytefc0BYVC8Qo73Hz+RmjIOdmzqSommN0=;
        b=aVXZFrXR02jvb8yFiaA14lG0A9vd1KE1mNmV34huTC9MvLIWHq2VkfkZDGZ4b5w8dv
         kvjferWpxWMjTTGUJWlUYXfKcoMMYW1Nn9Z47+3dQX4x/8ELspSRKQM3nJRroww0DEo/
         dkt0gEKbiE0VvOpZD88+pj2AE4EKY00qFWvMQY7e8AxjMOwIpTCXmQgU8Xju5WYdDWA8
         ACcL6HTZbMAw9yWIJw3+ZMdS+fAIjMwRtOsNpfD7LW5JeM01MURmhBYlC9SreDCqnJH0
         g2rSR2U0eBpSeUT2kQEBUGZ/P1h2grWi4zFGxcnEMKDx+PW/M1NxUoplGo4pdUdQFrwF
         2yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkER6R3nU+Ytefc0BYVC8Qo73Hz+RmjIOdmzqSommN0=;
        b=1sYz86QC5P5mRFNMgtDgV8aX8e0iIkY08KDpqfovZ6z/zYba3v7bRQAbyXlmb4Chcr
         YlJJBuYn/M3r1oskLe9pM3QM0tPR8/1hvZ2OVnUcDO53eArvDxj4cz0GgQKEJ07ipw36
         M4vhTSMnBekDmkmven8axmJMzUDW97+XfQAlCMdGzRRxoMysxvOzkEsHGBRKxrfw1Rpr
         185WtbvZNnVLprdQeqe7ZcEO+r7LFVPMCoEdoUxFHk6ALYSyruHhFI4tF/059LxyyqNG
         OC0VxItNoxN/r6Zl2ud3mOf0o4ODinXRlnAJpIknOW6LCecuU/oK8+uuKcAivCJnTvUx
         lbSg==
X-Gm-Message-State: AFqh2koUe41KoYuZIJwUkvtBu81765/wwodLu//RdrUQEvDkc9BpIkAG
        LzK8EqKOfR3n+FDUgmNsRloBIQxOWZ3RY6Fm
X-Google-Smtp-Source: AMrXdXtq+AX0VUkVsuODCCFpPuBJwxx5hMEk08eUlkJ8sH+G9GqcYoVgeirZbx6sjUipIPpYRKe03Q==
X-Received: by 2002:a17:903:40c8:b0:189:ab82:53f5 with SMTP id t8-20020a17090340c800b00189ab8253f5mr30458954pld.40.1672562060981;
        Sun, 01 Jan 2023 00:34:20 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902714600b00189c62eac37sm13159883plm.32.2023.01.01.00.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 00:34:20 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 4/8] bpf: Allow reinitializing unreferenced dynptr stack slots
Date:   Sun,  1 Jan 2023 14:03:58 +0530
Message-Id: <20230101083403.332783-5-memxor@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101083403.332783-1-memxor@gmail.com>
References: <20230101083403.332783-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; i=memxor@gmail.com; h=from:subject; bh=p9tJlATdM5FakqCpJKa6NnaquVsvZRS9oFRwkCo7zlg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjsUV0Pj5El18NahWcUEIYLgaLO0npnAZeh4llskj/ TG2jWaGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY7FFdAAKCRBM4MiGSL8RyvFXD/ 9tmzENivKcTiw5ZebT5O1AQj8CA8alzKcz58cgdT/nAJLMUDLIgqa4oGxKs4U0CWP80pBaO/9jeeVk 4Hdapzshz3xWSl26Nq6C2wBH2bLoRBdfMi6B93yGQGWVpK6/Wdh4Pw3E7R8oOrO5xxSWyu4ygmsDHd 3YMjD+qfJgAQGI0p1I0rNwli10HAp/f/YJ2LtKW0J6e8PQlXxSE2RhNTkmDk4JJRCmYeB9HcJ0vngG yqoVlbbFHHaKYcXeq2asSKFuWRABlPPzwwNr6O0tCyc/tHe8otP923JPONbcrzqiE7ecHf0MzU8t/9 0LvvTzW4MVT17WDgoocCQzAeYK+4RMG7nm4c4Yy9hUkqxyL1zLyPQ0Qj4qkvi2+Mjb/P+4rnW31P/X HDcRhJ6xLhFl5nm6i/0iA9z7KVV3fp8ZT4QUCAPWpvB6eqELZoB0rY2osr2XFH5FlViX4noOF0sWIG qK/iqqtIGV/CZxhrA+C4xtp4K9z0jgKKQwamhOiV+px1THTBPAlZC66bbOaVzN81mxrZcd9znvCnFQ 1Tvsfyp4WPUUYwRzf/15BXkfSVDjCGsz3rMVMBbuvk2N9KFvvHaLJio7FR7c0TDl6thLYPXNcg46A5 b67gwQyXyGP/LhqVW48Lbft7Npw2XR7ZK2iWqIXeDrGcwCf1uTfYOFx6hxLw==
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

Consider a program like below:

void prog(void)
{
	{
		struct bpf_dynptr ptr;
		bpf_dynptr_from_mem(...);
	}
	...
	{
		struct bpf_dynptr ptr;
		bpf_dynptr_from_mem(...);
	}
}

Here, the C compiler based on lifetime rules in the C standard would be
well within in its rights to share stack storage for dynptr 'ptr' as
their lifetimes do not overlap in the two distinct scopes. Currently,
such an example would be rejected by the verifier, but this is too
strict. Instead, we should allow reinitializing over dynptr stack slots
and forget information about the old dynptr object.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b985d90505cc..e85e8c4be00d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -786,6 +786,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
 
+	destroy_stack_slots_dynptr(env, state, spi);
+	destroy_stack_slots_dynptr(env, state, spi - 1);
+
 	for (i = 0; i < BPF_REG_SIZE; i++) {
 		state->stack[spi].slot_type[i] = STACK_DYNPTR;
 		state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
@@ -901,7 +904,7 @@ static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, i;
+	int spi;
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
@@ -914,12 +917,11 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return true;
 
-	for (i = 0; i < BPF_REG_SIZE; i++) {
-		if (state->stack[spi].slot_type[i] == STACK_DYNPTR ||
-		    state->stack[spi - 1].slot_type[i] == STACK_DYNPTR)
-			return false;
-	}
-
+	/* We allow overwriting existing STACK_DYNPTR slots, see
+	 * mark_stack_slots_dynptr which calls destroy_stack_slots_dynptr to
+	 * ensure dynptr objects at the slots we are touching are completely
+	 * destructed before we reinitialize them for a new one.
+	 */
 	return true;
 }
 
-- 
2.39.0

