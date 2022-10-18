Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB47602DB1
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 15:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiJRN7o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 09:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJRN7l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 09:59:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B742D75E
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z20so13883951plb.10
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHeaOKnzGoZgXbP3flsb1cpZRfmFWpFjAC5Iww6rckA=;
        b=P1XV9l8XAEp+7/zbKAF6Le9iEnoNimZFdixJfwS7oGJnXqWt3oSPw2N7MF5lrvb6Gr
         TIKHA2cUriprV/d+fJNx7Q5W8gwOnzqjrzXojneM3qyRRtpMP1uIiCt22Tf635xyZ9hK
         A3jYa4x0Nj+E3arGGfjHYBrwwipUH9sMK2Zrc+jB9Jo6kJ9/Dy01e+Y2OeJKpof98oW/
         ET2VU4bmbDZiUQQI77gETKFchCczMY6JIUvpeZxQ4WGFjg21hB1MO0I1tZ9G3nS6Agba
         8T+QV0XLZqiCr9XDan2eRtshsol6F1Dr8EhN7xMnntAnago9JnleCvi3MXyQA54ft74/
         SfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHeaOKnzGoZgXbP3flsb1cpZRfmFWpFjAC5Iww6rckA=;
        b=y/1591Fsljq4Z59r6wljhemSR8f1STWadNSS0L7R4aqfrwVQJeBydmWx+hbIPzOG9i
         APORKeVmh+DkpuSU+aQDytbkNb11G+tF6cN1HtIsRYuqdyMseSdlsja7Hf8Ms+akYUQf
         hLBdRJaGzSRFgV8Ds1S9+b+y6UlvQnMHA5MMQS3buLqFWutm7xzy1TkY0JBK329sOwo6
         5vxcUAJesblmVig3jvmJYusLxVcmmlbZbmzxE2muHAKWJqLa/t7m50BMFn2V9LbUWBp1
         VYpfaOCTB93ONqREh1k5MpA4TEOqPUOWcpR3mwGIMWhAaaVZZLBlrXP4FwCXe7nxtSx+
         AtLA==
X-Gm-Message-State: ACrzQf2HBGAo25ksK2CFDmqclJeTWXHVRVCbE3oeZAa30DcWTtBMXIS4
        9RzuxrqnNxuWqbraKHcDFTfodSDeB8qDJA==
X-Google-Smtp-Source: AMsMyM4y2WiI7JJdi1uyUH63clJUi6hIaSNX9ma5LFCSDubqN64p1tkAt/6glPCIJNtS71hXFMM43w==
X-Received: by 2002:a17:90a:4983:b0:20a:9509:8347 with SMTP id d3-20020a17090a498300b0020a95098347mr39285481pjh.101.1666101578707;
        Tue, 18 Oct 2022 06:59:38 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id v8-20020a654608000000b0044046aec036sm8001750pgq.81.2022.10.18.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:38 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 03/13] bpf: Rename confusingly named RET_PTR_TO_ALLOC_MEM
Date:   Tue, 18 Oct 2022 19:29:10 +0530
Message-Id: <20221018135920.726360-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=memxor@gmail.com; h=from:subject; bh=le0Ej6FdJB+3fi73W83TfWykvTTpArlDPioaZJRU8tQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEirKpN5wM8xfd6FPqOxy/B3+aOx+ViiEdORfDh rmYgw5aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8RyoFVD/ 9UdZe3ZQ04reRW+/HQ0T4Y02EtjrXzipKYwnjJ537Z8rmz04jEHyMlfc6EdkEqwpd967GFvYZNyynu Vj60K67lBdy2AbdWpBMsJPlNzwT5eO2Xyi9Ql88kxQsRPo/GtteTzpNq5Qs1c1p/IzB2SG6qw7yLXH CtKcKtLiXUXjHByBjgemujL27ca4VG1cAcGD1rKtSW8d0NLFfOmB9aOqNyCY6s7vQFo1oaoAxR7GUJ f3gvDp3gXdrHYFifwD2gD6C4ykA1IMrnMwtF0i3HzltSjP+7tEASOdV5MiOa2JII+7n0o+xjI3jade kswz+G3hOAKBS9GZSAE/lUBGjvm378kyOUn1NJd1dxO9YiGypYwUhUCiwF/W81rXn6ifmfCOTub8MO J3EU43NJ9JoZiNhbG3J1WebR478E8fvlDhuJj+VTDlo7BGeKy6/IwI9XZh1G3A7moYGHB2RpPIr63X SAa9vsWLhn1XGz+gNaMMAkHc+ClXWSo7h0f7IpBbfhbxiW66yJ5sWGzS+L+iWWUEwtDfUZwvnSp0NV rIK+ZmqQQDMlrTZCAX9wniPKOmjQRXvQMdcWtdiyM5wIUM0hcv8HGDm5kY8AZbfrW5BamOvMs5il0D 1ZjJakC7kPP5xWy2fbBx23F4smeL8ErCZNDP6WBdsZ60V7R+b0xY17BTmx7g==
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
index 13c6ff2de540..834276ba56c9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -538,7 +538,7 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCKET,		/* returns a pointer to a socket */
 	RET_PTR_TO_TCP_SOCK,		/* returns a pointer to a tcp_sock */
 	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
-	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated memory */
+	RET_PTR_TO_MEM,			/* returns a pointer to dynamically allocated memory */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
 	__BPF_RET_TYPE_MAX,
@@ -548,8 +548,8 @@ enum bpf_return_type {
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
index 87d9cccd1623..a49b95c1af1b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7612,7 +7612,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
 		break;
-	case RET_PTR_TO_ALLOC_MEM:
+	case RET_PTR_TO_MEM:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
 		regs[BPF_REG_0].mem_size = meta.mem_size;
-- 
2.38.0

