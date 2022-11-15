Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8D628DE3
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 01:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiKOAC5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 19:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiKOABt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 19:01:49 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E6F3F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:48 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id io19so11599506plb.8
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSaNQ/dcQ4x6jvSeP/uwsY/xIHDGGm96/RFbVHCGjvs=;
        b=qXb9bWVVXlymBEFkIrbQN0phea6tC7Ub1cfTMPNNoTXOeTX2QZXSviLcH5FVVEpQ4v
         JJaJukZkWswkREH7D7U6veGYeqKNfETMQLHlcW/p/b2y3bW07/Gr39uoQ5Gamhuebxxd
         7YSF8Spc4CxFbwCH9trDQim+/O8V2CXB1JV0zynkI218tyHGoc8kylF+xm7oFk9/97uU
         cYpHfW7JnN/qa3QTtyxUetnKISsSDQRK9L2cFiHDWzIaUalslw8Q7mIgZmVC7YDmC3om
         MJB6kyCHI3y076ipWOkUMKmwoNNTSoZKVMapXo+Ith5RyJC6aKiu3IPHcjZ00SltQjQZ
         qNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSaNQ/dcQ4x6jvSeP/uwsY/xIHDGGm96/RFbVHCGjvs=;
        b=VUfGYyV7laMtwjmTQ3S7X4bkOW1EehiXNrKUnzWlDAz5684A/MK0ss9NvK/OetQHQq
         tUs3g4ez9DVxY5kgGkFklaEa/r7WIKkRohwfDOw9zI+SyQ5FHb3WPkPubCmoP/Abqyzi
         eb7qik+tqkRCte7bKihxrJPEhYTkqaK23YXJdTcSBDFNmHiBsdejPlD0AXPZ7a8ystEa
         T5oFFDxolKhyFLAlgthft5tf1aMpG8yXS3q0hr6USg98nIASeQ8IarCwusGYPcPp9whz
         fgVlDJ8pxZVloSaPi7RmxVKMLpx9qxl67H6xxhJF1osensPyinEFNyUY5uw/2f+mC0Gs
         zbRg==
X-Gm-Message-State: ANoB5pn60Qh0HOetcqOocXVZaq5MWaXE6PppRWTBvavflHOfGLN/x8U2
        hBXhTXDP53gur8zxem4KSCUOBUFsipSTUw==
X-Google-Smtp-Source: AA0mqf42biwAiNCBQUU1zQ5pcY8AaeE80r3HCcPiGbm5Hy/9yCbYkwThYnOY0gpwMUDdI99UW4K8xw==
X-Received: by 2002:a17:90a:1b23:b0:218:725:c820 with SMTP id q32-20020a17090a1b2300b002180725c820mr15906688pjq.170.1668470507977;
        Mon, 14 Nov 2022 16:01:47 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id gn19-20020a17090ac79300b0020de216d0f7sm7165284pjb.18.2022.11.14.16.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:01:47 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 5/7] bpf: Move PTR_TO_STACK alignment check to process_dynptr_func
Date:   Tue, 15 Nov 2022 05:31:28 +0530
Message-Id: <20221115000130.1967465-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115000130.1967465-1-memxor@gmail.com>
References: <20221115000130.1967465-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=memxor@gmail.com; h=from:subject; bh=wwpedgumiY2D1BsQiE1DVI3mrdHRTA/QF170z6s3Esw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjctaCULBcQmHu62Xw8Stpoe7K7PEQNoT51ilLjHBn qqr7+OOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3LWggAKCRBM4MiGSL8RymS5D/ 9lqzTqKSYgno295pk1xNBxNHoaSRhaDKJo+hUR9gpHXSwCTMo/k160fRSJ0sK/cW1wGAOCQSlJdX1f Qg71UrA9mdZZJw3NY2LYBwzIkEZ/yIGzG5PK24dFvNB5E7Vj62/7QgRfC16ZmgfMHlm/LpZYOvkqCc z9TwWY2xHg9pqtkzQ905IawwcJTSyS/hUmK7M0/5dnHtxtF6QyVHRsk/G87DvM5ycpXci2zHzWajhX c1tOKCrw/Lww/5gASE5gb/AMUF+9QLFfCmekCwBs971Q6oBGjZB5sBQgnlkh0x0pbh7siYaJ8YCuI7 YmHj2QMS3Cn2FeTa+sirHiObldOIXypec10QQtJpmPniFBl/3ZjAy/n+xobUveApQiwni/PMKV/SkT 3zzNFsSekunkfx5bgrQoLn1KwV0gMwAbjI0y+AHD96noX6UB0ARy0LyMUTo7c6/YaN60SyG8nojCq9 SYH4pOZhEmQIezKh9xidLUqqkFo71QrqTOVGAiNzP7r7JCjhSsxvSDpkHQl7/6vLAnVESA5lwlX4g0 oWZb3lGT0L2MVs502IZHIFImPtoqf56kb7bTcSK7FSz3KLkMKYUv0HY6YZM3LVS3nuZm3o4lj7mWh6 +WkROD5nBZLBaUbH2fiHBgJvEwnranrxyXaKg+X7dzI2LNGrGPAlO3jYz3Ug==
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

After previous commit, we are minimizing helper specific assumptions
from check_func_arg_reg_off, making it generic, and offloading checks
for a specific argument type to their respective functions called after
check_func_arg_reg_off has been called.

This allows relying on a consistent set of guarantees after that call
and then relying on them in code that deals with registers for each
argument type later. This is in line with how process_spin_lock,
process_timer_func, process_kptr_func check reg->var_off to be constant.
The same reasoning is used here to move the alignment check into
process_dynptr_func. Note that it also needs to check for constant
var_off, and accumulate the constant var_off when computing the spi in
get_spi, but that fix will come in later changes.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 34e67d04579b..fd292f762d53 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5774,6 +5774,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 		return -EFAULT;
 	}
 
+	/* CONST_PTR_TO_DYNPTR already has fixed and var_off as 0 due to
+	 * check_func_arg_reg_off's logic. We only need to check offset
+	 * alignment for PTR_TO_STACK.
+	 */
+	if (reg->type == PTR_TO_STACK && (reg->off % BPF_REG_SIZE)) {
+		verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
+		return -EINVAL;
+	}
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
 	 *
@@ -6125,11 +6133,6 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	switch (type) {
 	/* Pointer types where both fixed and variable offset is explicitly allowed: */
 	case PTR_TO_STACK:
-		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
-			verbose(env, "cannot pass in dynptr at an offset\n");
-			return -EINVAL;
-		}
-		fallthrough;
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 	case PTR_TO_MAP_KEY:
-- 
2.38.1

