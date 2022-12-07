Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE69646282
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLGUlx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLGUlw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:41:52 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9079630558
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:41:51 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r18so17392140pgr.12
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxrWU7NnT6vHGsB7NFeIFzMUup1ImOCgJhxtDl+Rl34=;
        b=BUnZfdp4BvMWFVrBCcxMUBFNYqiMBgikhBDxNv2IYjZJ5wXOtScnUAQ/TQ8Eg3ZmbL
         tM5LMeokB6BIbKtEzxn5a57YpdZbqfmjhjQJ4OflMxRKImo/dyTMMiTQ131T/q/4NRAG
         UtLsMX+rJK6+GB+o15e8Ibr7i4eqo+BOGVlhiwteqSS0KuR4Q+nYCZDDZfOECilxf8sn
         0PRpgfvO3PEMHRSVEPlKEEt/OxIeM5HHHEKr5KCGaRmeG1wQBFAUUzH+rMh78EV0cL4P
         xHFIZaPlf10jLoq2Hc4Dj/OkTzwMi4CeM9q/sY7ge5zj6nBIyydngStU0zi0eiQhAKhy
         jvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxrWU7NnT6vHGsB7NFeIFzMUup1ImOCgJhxtDl+Rl34=;
        b=xvUxYuhz0K6YhMHI7Ek0dv5bgKakWhfEPhqn9tuFoK3Joj0KOLUbSkjUKK4mUPlDYZ
         mVcQwVIq/O0Nq7zmgfVOsM9y73/2ninz8DgHj8z3T6bem023w4RMCttR5588wVqEkJGp
         iwaA6CYsaX3+NVlisUqdi3iY3V3fmOf03Y2d82bxSATuQGe7H5X+SR7/t2av9VYUGxIk
         5COI+uwxB9Cm/4DpaoRvIaBMzbqm0FUPqEn8HuTnGECQK0JxwYsT3NW6HMAEc46L9FUS
         dDK1lpfjOxASaRnRJ+haFYabfvs5DuXQJcrazKSLrMpfznpsV8WjAIxgdWeY9ZME0fK+
         EANA==
X-Gm-Message-State: ANoB5pnIss55DgeGveb0s/5EegLWXgLPzwfQ27X7Q071khtENUuhQ3+d
        T5d7KzIK9fgVRh5Ii4yP8AsQS/Dqy20ivA7D
X-Google-Smtp-Source: AA0mqf5jI0nzsKW6jAg8a5XymN2pRcRp1pQBhCsCpvDyJ5ucFqmgQrCMQJ4hP/wbGQ3gUqPXw1j3vw==
X-Received: by 2002:a63:de14:0:b0:477:4a61:eb99 with SMTP id f20-20020a63de14000000b004774a61eb99mr75566516pgg.48.1670445710952;
        Wed, 07 Dec 2022 12:41:50 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id t184-20020a6281c1000000b00577adb71f92sm135711pfd.219.2022.12.07.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:41:50 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 2/7] bpf: Propagate errors from process_* checks in check_func_arg
Date:   Thu,  8 Dec 2022 02:11:36 +0530
Message-Id: <20221207204141.308952-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207204141.308952-1-memxor@gmail.com>
References: <20221207204141.308952-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=memxor@gmail.com; h=from:subject; bh=gmdyq/+tBMx3WETs8zPL/dlheSlesIH0Ru/dgcZYGJ8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjkPOoGOqNPniWr+Y3uHGnPyVtWIFGcvgDLXD0T+7n hF5VOF2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY5DzqAAKCRBM4MiGSL8Ryi8kEA CKKaQTj1bJCh62C2pJtz19rxnmyYJa2et18eNx0WVzXOWqFKgmBU1XHXNzI/7pFGU1QIKiTwqm30oK +WrguC7QvRGqFKHVWBuTC49Rom8yZ2dMCI67aTg6Ce+J5T7AvHf3ZbpNZESKwYd1MtuUjj7i9bWs3H CdMFbPf7NRL0SU+Kvrf6hjcuUEh0AfdQ0aorxfQ+pbgcqLb2C0djz3gs3qAhvredxKTXhwAGbkfjDf 6VHRhA5aquX37Du9jvj5o5PQTsoSy28zB9r4aE+RgJnBctYJeww9rqi7t6Xne5gCiKFiKMneFM5h2C vhR+PE3F+Z/dKOzS7icZkQdJ3nOXh0mcY6nE6G+Q3mFx7m6/k+sGP/R1J2csLHN+SdIoWfCBBISRcG PBYJ0ryvxoomB5rIzEALZC19RYBpyXKR+D9EGj9MHqpdDEuP5JzqDvWihpTQGNYPzoEoU1Isqf0FBT mwVuZW/+e7keq+CDIPVLY0QdYmL+BwyBmOdMTRLhH+4/Sze461F0OBW+DKu1+yCFvtiQ53AUATZdQz q+8HWtM+vI7/zhlioJZQcF/7rVLB5q/z/r2MFgYxGHiuPK3c7avCU0CqOL3gENFI2I4A8G+BK2N4l7 ESXEERLGkYdjISlMWd6Sr0AjzKtqLU66VJLhWDLLb66X1qgWJIhy81jpphKw==
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

Currently, we simply ignore the errors in process_spin_lock,
process_timer_func, process_kptr_func, process_dynptr_func. Instead,
bubble up the error by storing and checking err variable.

Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 882181b14cf1..1af449c20a10 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6412,19 +6412,22 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		break;
 	case ARG_PTR_TO_SPIN_LOCK:
 		if (meta->func_id == BPF_FUNC_spin_lock) {
-			if (process_spin_lock(env, regno, true))
-				return -EACCES;
+			err = process_spin_lock(env, regno, true);
+			if (err)
+				return err;
 		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
-			if (process_spin_lock(env, regno, false))
-				return -EACCES;
+			err = process_spin_lock(env, regno, false);
+			if (err)
+				return err;
 		} else {
 			verbose(env, "verifier internal error\n");
 			return -EFAULT;
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		if (process_timer_func(env, regno, meta))
-			return -EACCES;
+		err = process_timer_func(env, regno, meta);
+		if (err)
+			return err;
 		break;
 	case ARG_PTR_TO_FUNC:
 		meta->subprogno = reg->subprogno;
@@ -6447,8 +6450,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_mem_size_reg(env, reg, regno, true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		if (process_dynptr_func(env, regno, arg_type, meta))
-			return -EACCES;
+		err = process_dynptr_func(env, regno, arg_type, meta);
+		if (err)
+			return err;
 		break;
 	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
 		if (!tnum_is_const(reg->var_off)) {
@@ -6515,8 +6519,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		break;
 	}
 	case ARG_PTR_TO_KPTR:
-		if (process_kptr_func(env, regno, meta))
-			return -EACCES;
+		err = process_kptr_func(env, regno, meta);
+		if (err)
+			return err;
 		break;
 	}
 
-- 
2.38.1

