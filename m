Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54078620358
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiKGXKM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiKGXKL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:11 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849311FCD6
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:10 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id b11so12135344pjp.2
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/wrTWjeoGJ5PcE2HVDewWAhvJm6XCc8VxMDXoI4aI8=;
        b=TKY/6ZiMWSVXINrDrMw+1bKv2OGBLjM2cf0VZTcokKASpFTd/uE6BU1GqD4klC0J40
         WCtTgeShKo9gi6gLE6TZOe+d0GNLgTXtIHkrOnuzBF+KulX+yn3itfn8g3JKu59un67v
         LXiZDSbCnVr3GDHSzO2erAIpX9o0AsT46KEGgiVXr672vV8OVFdkQE1DOpVnb41US4Fb
         rv5XRAKiKnXyCX0X+29oZKTfXoc7SVc3DzHN1tAHoxpSHk8y7QrwQY8rFWqaL3lsZtlM
         pnDAZ9uAAepMDMOGsKNPCYAszfuf1r4CC33Ql667J2hOQU1hGp6BYXPRINpv1R8hOeOx
         /Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/wrTWjeoGJ5PcE2HVDewWAhvJm6XCc8VxMDXoI4aI8=;
        b=Z9TJKtvmfZzAaPQDZj1LlpQFsPTNbbIocVJg80tjQD6h6mSxvHeuwu1LqyNNlo9rIu
         7yfRRvf/nU/Kaduvq4Edtvwi5Yf7Qxqob6CjalwBlY7oWf+3FI7me+WQVDckGWuggycW
         z5qEiKMSYGn4QGfAmBaw45UoM7Q8t84/mLV3rjzDbubX5gd5fsJLkgJOibVMxHBfWHzT
         sxWyJeSkVkIgvUlG4lW6FKEIeCtKHRQwmGHjCE59uAaJG4iWRQoslQNNddj2NBAfjoKZ
         AoMvp5CnmTM6sdRwtotFVcT63ikx+eZK+rU8W+fkBEg0PvCf7ywiq2pG8KsqpTXIJvKx
         C5zA==
X-Gm-Message-State: ACrzQf26tvzbeyRXu/FgQPwweme+1xY1XtFtzt7bFgwapBWBNO7pIJoN
        FTKyxCXRkqzv1E2fG8oSYItDdYua0EwDfg==
X-Google-Smtp-Source: AMsMyM4GLxlyFuVh0IH6aoemCUBE94p6EaCWpxxl1qI2c+CLy0WMuwUOK+s0u/iJ1SXa8l4XA8ROgw==
X-Received: by 2002:a17:902:8f91:b0:187:4acf:861c with SMTP id z17-20020a1709028f9100b001874acf861cmr30434687plo.166.1667862609831;
        Mon, 07 Nov 2022 15:10:09 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id a24-20020a170902b59800b001788ccecbf5sm5471761pls.31.2022.11.07.15.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:09 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 04/25] bpf: Rename RET_PTR_TO_ALLOC_MEM
Date:   Tue,  8 Nov 2022 04:39:29 +0530
Message-Id: <20221107230950.7117-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=memxor@gmail.com; h=from:subject; bh=0z92ryWA6XsveKbJHr6S6jTfA+C5JIJe/ym7BPLG/iY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+1HRkIjZt8mnhFlc+mlBlx/wckOGz9VYukDvsY WaIsVzOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtQAKCRBM4MiGSL8Ryjm1EA CH2llLPGUpEU3ExJsOC1bTJEvvwWnWfZJTaAyhRMKKu9J4WcMmqJPlWodC3tjNdzFHddyQ5235oimJ uFsc32qpbEum+6+5kTV7NpHMLlXgJLj7U+oH6wWdJieC1MnvW6R2NsPkfUiVKU6MyBZqG2kjWJMLfU wNcJ5Amz9TaRE01VQ3zCZ+VWM7zM/pZRj+a4iLgGTarQuzMpW6qwlB13dmIVei3ggPsNhsq6FsDP1c m52+F3bBQMfP9nUoD3wdAzYpip8riiBeqC1uIok0dWLNPnLW9AqDZb61gpjV7llioXbn6yAwnf8dFB pgt2voZKFRhZpJlCG5Dp3qqwKRDHfpVgG1XMNLZx//9fXR4ppP1LM9a6AJ3xTcwN3LczK1kVldZAXU BRU6cqi06+PshXW9tF0UBywnD47vgywzTV3afHbgsAtCfCY/CVnI3LKJsj1uPt5rMQfoXf+wFt+Wo4 /C0n73z4DXkOHB1lhht3MR2IxjBLXq6gRlLstNbgd5+HYc8O2g3pTEc1Tv8jxb5it0SxmCanAMJ0Ci LRbzzn4gm3wc62Yg1TUbs+K1KTLjnYxRUAD4TGKeVXdsmkcSTY+Ke+HYAIWJf0bVEp8ijv5nt1YHAS tiIRfaU9KhnL1cM3tKxAX6sC20E3EpchuEmm59BUjX436e3nPVaVfF/t7nOw==
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

Currently, the verifier has two return types, RET_PTR_TO_ALLOC_MEM, and
RET_PTR_TO_ALLOC_MEM_OR_NULL, however the former is confusingly named to
imply that it carries MEM_ALLOC, while only the latter does. This causes
confusion during code review leading to conclusions like that the return
value of RET_PTR_TO_DYNPTR_MEM_OR_NULL (which is RET_PTR_TO_ALLOC_MEM |
PTR_MAYBE_NULL) may be consumable by bpf_ringbuf_{submit,commit}.

Rename it to make it clear MEM_ALLOC needs to be tacked on top of
RET_PTR_TO_MEM.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   | 6 +++---
 kernel/bpf/verifier.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05f98e9e5c48..2fe3ec620d54 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -607,7 +607,7 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCKET,		/* returns a pointer to a socket */
 	RET_PTR_TO_TCP_SOCK,		/* returns a pointer to a tcp_sock */
 	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
-	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated memory */
+	RET_PTR_TO_MEM,			/* returns a pointer to memory */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
 	__BPF_RET_TYPE_MAX,
@@ -617,8 +617,8 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
 	RET_PTR_TO_TCP_SOCK_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
-	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_ALLOC_MEM,
-	RET_PTR_TO_DYNPTR_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
+	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_MEM,
+	RET_PTR_TO_DYNPTR_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0374f03d1f56..2407e3b179ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7621,7 +7621,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
 		break;
-	case RET_PTR_TO_ALLOC_MEM:
+	case RET_PTR_TO_MEM:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
 		regs[BPF_REG_0].mem_size = meta.mem_size;
-- 
2.38.1

