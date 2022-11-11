Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FDC6261FB
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKKTdX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiKKTdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:23 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2890A78327
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:22 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id b62so5160468pgc.0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/wrTWjeoGJ5PcE2HVDewWAhvJm6XCc8VxMDXoI4aI8=;
        b=M3WyBvG5ePRNp2a+IfRSUn75h/jCLJMWEkqmDrYWf4YC1FKOKFHIqtj9RjUxC2plwO
         47jzHhoTp55kBi1k495w00idySrv6UOMdYnaQcJm7UaQ/g++5VbRUHd0MANMVYo/kmLj
         PMvgzjQVIU9Q1aiGGb1TIxNm52Qkh9bDhYbHSKc3GcZgT2SyAay/PzDl+oZ7s8M1zSJX
         06C9Nhi7joKGneWu28Jhh+41qOR8/kMuDprqzXc3XLe8sLzVfhOiybAeJh4zhZoywUtS
         WAhMP9S+TWqYcPRZmv4yi9LQbipHGNPGrqC++qlZWiQYcrnzNAoqTjQFQaJoWlFLRuRa
         mPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/wrTWjeoGJ5PcE2HVDewWAhvJm6XCc8VxMDXoI4aI8=;
        b=xj4alFVQd39b7VvT3JMv76vQ0i9IF0ynsrPeFj7OfT2MJqB8S2I3q2jxFReocQJlpq
         C3fBAAbKgT4scOAeW+vtMDUkr5Lcu1LdgrxJX89hqMsb+3eGQmyiOZN+08Kk+2XF0Lci
         9udXTXYsalZknjN8EcAKaljkx6g0SZlZ5vBhmFLUc89/BKRtaQ38btTEvTIFRTgXshhy
         S7qF83m8WctVjPMPfomY+zC/N1VkBp2WIoDkrLBQgdzp6CEp6kqLQvyhQNbNHlJXumE7
         A8HXuT43k5vaBciS75H2HzUUkV9COTxErUwejsi6RXwSgQ+fxvnTPzWNccazVdiFvW9s
         Mjjg==
X-Gm-Message-State: ANoB5pm3d/4fyYwjLh7JmTeKA1btxOCXGN2hZZL1HuOmArcFzn8sUS5P
        MGlIpBC87nBzkgtASiRqVXaCnR/QLjkC5g==
X-Google-Smtp-Source: AA0mqf7gEe2u9fvn5jnQSAJ8xOBSv9ycATrtV6ZoZejrUfqv8AYdlNijOb2gRcYBiq101+f0JBmTCA==
X-Received: by 2002:a63:6482:0:b0:45f:88b2:1763 with SMTP id y124-20020a636482000000b0045f88b21763mr2817586pgb.469.1668195201470;
        Fri, 11 Nov 2022 11:33:21 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id ij15-20020a170902ab4f00b00176b3d7db49sm2126499plb.0.2022.11.11.11.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:21 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 05/26] bpf: Rename RET_PTR_TO_ALLOC_MEM
Date:   Sat, 12 Nov 2022 01:02:03 +0530
Message-Id: <20221111193224.876706-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=memxor@gmail.com; h=from:subject; bh=0z92ryWA6XsveKbJHr6S6jTfA+C5JIJe/ym7BPLG/iY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqInHRkIjZt8mnhFlc+mlBlx/wckOGz9VYukDvsY WaIsVzOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iJwAKCRBM4MiGSL8RygLYD/ 907h9MF48dyj5DKVzSWd1lQcNQQCC5+g3Wx1+RyOP72ZDgEEjsRrwftNWxTMqa0zgPIDR1YRoNOR9y KS3+lCWVWLz1TMbUL3EqxT/A3hfUgh3ievkK7UaEmpi2pk6AnImsxsWuWR9+iPyd/boDSxqsjC5dnp Baik/5gOqmab7OVXndov6rpv8RqLD1mKesy1wkhAswUX7w29CcRAjVNdZR3juVPtAAqyblep1Gug5R Xc8bwZzpODAb0v4hB7I04y68nYp7GjRv6joxXHThpKvdWLVJyH/lfkwghBZ2xrBelZd0FVrNkIxPiD Vc9TZyK9HyggzcLj4UHeNEUxY582teCLdoQxQ+KY976brQnAkRkLQq0qk+8S3mPPT/nopzjyK/dyWF JXkWus/pZ8H+piw1eNE8v66ERalSsTGewrx04S4mfIXT6B+KEQVdroRXCUvvt+c9b8XCvqwf4lKxMc rsH+7jK/Fd7l3TGHEf+HY9iBW0+u+fJ250u52Gt7F5MaBpUtYv8ltpFWkFIBvGgPgw1kPNgNdkb6Eo QOJF83OMhHrgsM0/ujYWuWHi/OQpYNOX2AMNCpUryuKFfoicei16MaVeuGlt4B3Pn4mMbte4kqj9Uy 4wyVlOBBIlm4NzQt9U0PghSzbPbe+x7F7F02O91wDoVEB2KUK/1hfnUktSjA==
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

