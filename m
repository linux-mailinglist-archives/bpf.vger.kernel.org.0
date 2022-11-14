Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D9E628905
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiKNTQV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiKNTQP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:15 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E9127DD9
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:07 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id b62so11111194pgc.0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fB9+tUBSUn6plpY3tSPYq/bignEZhucGpbkfKAE7UY=;
        b=Kza5AoEymkyQo50hO/MCHqUYG70Waj6g2wOgI/hFaQm6x9vzSIElUtF5ifuwdlBtk5
         niKTFjNTWufvfm5jOQ7u67+pyHUeHvrCQ4NemsTPsQR+gFgrOoHrVYc6jWdKF5p/vEVz
         Cj9pIUDM6aRug8/7UVLy6zAvfT/RIZXCh83gamc/rVTPuXb2XihKGjblqWMQZhAMhTuZ
         dEHLewhauOLEPKDhVRKT//fogePcrVO5nDxPaAllm8bIbkjNsBd5Fxcci0XSxoOYFxU5
         kxe7gtlod6SSBK9w7wyLoqPt5t1RzKlRuDqcCjTXfCDf9X/QmXngbVQJpwePhYQM4GBI
         Zt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fB9+tUBSUn6plpY3tSPYq/bignEZhucGpbkfKAE7UY=;
        b=XzzDJAWXsbyGB89mqzTQMlwhMQedrPQ9cqK2qgOkpPFnuhVyd60/BPptPsg9Ccr1fJ
         3axk0rUNrVd4XXNEWAKBwyBU4jyXAKvX4onu2vfJkGnSiHt9X/kKEY9pJBTXWmeGi2Ti
         6Mz6Z2NCwz4IS/8V2RbVfOdlDS04QKHmOOJVyb4ObX7OVWzrUw1i/4qZ/j2xrC4u6jtU
         iWE0LQxkqc4XS4Lsct9BxeXimAEPx8sqRTw3OVzJQYXlM49sTdHhrrCkZ2MnxqhJm8xS
         wQ4gSTYpxOgjrWT2TW/ZtqtYPmVesd9bpMRIiGVSdDfX1PIUxq76xxDRo2asYElKLFuz
         rIWg==
X-Gm-Message-State: ANoB5pk4yoFJuC2Q1XylGajS6PX/qjfVqpFRfplLg9mWrvXozPHeCPoy
        uTJhxekV6VyRQG8MzvX19arSpP9dxjKAkA==
X-Google-Smtp-Source: AA0mqf714MrqqVJTwRvx5NODlSz+57AJIImZes5Ya8cVwh2712pwCKO/qbfl6s8YFc6FOQGaivr2gQ==
X-Received: by 2002:a63:31c9:0:b0:476:9115:663d with SMTP id x192-20020a6331c9000000b004769115663dmr3857972pgx.436.1668453366769;
        Mon, 14 Nov 2022 11:16:06 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b00186c41bd213sm7840008plk.177.2022.11.14.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:06 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 05/26] bpf: Rename RET_PTR_TO_ALLOC_MEM
Date:   Tue, 15 Nov 2022 00:45:26 +0530
Message-Id: <20221114191547.1694267-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=memxor@gmail.com; h=from:subject; bh=+megFhfdO04jt9azzJSUDOASFzsAIDIpP2m6YPhf6DY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPIGUJS+7S1RwKXDjDw/jz4/hn9oy/cpICq9Md0 8KQl2umJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyAAKCRBM4MiGSL8RymwYD/ 46g+8EqY/N4e6YqE3GQcWxIfntMwjL9xWIOqOwtDZ8YHoP2yK1Fq4m0LjDCXE6yiZENSXREkjXWFl/ WQq383VaAT+pBMnnttD1aDZ/P9MleKz+njfiXce4jL8iitO2JnNZLXz/zK6opfKDakUcLVIcOb2R6X 4XhDToNwHC4a6wMjU5hTltjrrs3xXe8bwCJboMnxGzl6mEcMTPUFnshSgxjXABtDCS1mzXitkl0bV1 jHAtsBvitousEre6/Omm5R2GgFiBxtddjrF15bYz9DpbiCHit0mktACzAHOZqWhFnOFC7EjM1TVF7m q06CT7EKVW6mPWDbOP1eQZihn3lDf7AUA8uBMufoCdqGoqEY1MVcd/fh9r8sz5EmqrUHaSE5XHxkdi eQCFrPGeoMyZVSArBt/0CsuNxxs0Y6q9jNlqWIQvmnxrijcRZN9K+pouvFpeIZ6gLb49AFNuCLE5Lm hGT+cI8Yp3/TgCfpG3BmB+R8tkPdyqZ/KotDwwaAG2NTb59tyb1YvcQ/40FoC+z4lB8h0lbUEwykQe ed9JRX6Z5hpKP5GKm6rWnQydS9ceFpX9XyQRxMMqKEKxchEXC5GDcGUGXPE0kJpfnm5GPoaOPobUZB cyrjZJt3GxftUUIj3onC2cjyhfpXAYJTlENLniGV4O6T2kN5M1Jv9HHJEI3Q==
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
index a50018e2d4a0..c88da7e3ca74 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7630,7 +7630,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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

