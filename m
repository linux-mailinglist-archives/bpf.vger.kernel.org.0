Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5D646285
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLGUmE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLGUmD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:42:03 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC6430558
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:42:02 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h33so17402183pgm.9
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kwACFs/56Sr1TbaQVBLjvh3U0y1UG0rc5mW2Tqi41s=;
        b=BeSC+nLCtrw1dUP40A3A9r6Fl2460eBMLkd8OUWIRpnK7O8khsVaNImGdCgjDJVhne
         a3TcWPB2d9sVo1YInFls/XXPX8BaymsXfAuBcVWq7w135k7wKF8Xph7jAAk4PiFUrUQ1
         Ho11Ww3NS+ri3PwimBPF7EWMorAkZ1dXRyX1TNCWyp1GgMiOAavBfGlO+xc0keI303mN
         4sWPyMCTxCg18kia55DnqhHB9R9z9NkaNFAcbT2kCKArt4gBYvN3DniL4mApeteitgj4
         a45CmZdUs591cOLjR/O5/xAdAK0P918FhOY+DwO8XTlUoHu2Jq4k50g6ppoUKU0vvVAd
         7zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kwACFs/56Sr1TbaQVBLjvh3U0y1UG0rc5mW2Tqi41s=;
        b=1LLH2NZDH+TAqPegJFC419sW48Dlplx/XVZeokHMNIJUC1nXZLD9J4JC2aSIYUKwXD
         mhyro6TsrazZB865u74FAY0Ax73MjpBpeHgE2FDTKCL2wquFpCs2C/C1DApC9OdpszzD
         y5otSb5W5O0YOs0UgF6cfoKKILxbNEXkdyzX/xZwYA2CpaB8kTty1CS9YsIrpRRsWxAJ
         13eiL90OKAqywu6ZJHVQQbKHt/8nzJpv+95nKM4JfHBbsboUOWmhF0+lrq/DiGBeIaUE
         3c15N/cej+ojKypY6BnGNmynxtRAQrC+i+DscJgk5CTX6psiPYjYaZxN7UAlk6wjqey0
         8LHg==
X-Gm-Message-State: ANoB5pmqlZBFM3shjlb1bK178pRmO973SbRVfgHJlh5bNy1kPHP6Mbxn
        rDH/D8n5aL/ymOGpdsKXJlIcV1SPbtWrJiTC
X-Google-Smtp-Source: AA0mqf4nyCuJK5KZ8/I0q50Y9QUNVyck7fXFYEqvK+dsLODr5gdwmPE+VUHZXPtByPQiB415/m4zKA==
X-Received: by 2002:a63:1f09:0:b0:478:fd9b:b6c8 with SMTP id f9-20020a631f09000000b00478fd9bb6c8mr2376041pgf.509.1670445721938;
        Wed, 07 Dec 2022 12:42:01 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id c23-20020a170902b69700b0018958a913a2sm14930923pls.223.2022.12.07.12.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:42:01 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 5/7] bpf: Move PTR_TO_STACK alignment check to process_dynptr_func
Date:   Thu,  8 Dec 2022 02:11:39 +0530
Message-Id: <20221207204141.308952-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207204141.308952-1-memxor@gmail.com>
References: <20221207204141.308952-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=memxor@gmail.com; h=from:subject; bh=u4A5lAfb9eBYzsDtC/pHkdFQ7LgH+0ur5obBt+XfFRs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjkPOpD2ObU5oQ6Bs51Io7RP4XAjcmRoaYLK3bGIu0 aqxYdJyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY5DzqQAKCRBM4MiGSL8RytlBEA Czv/71sdhwlgNzz+atyE+a1ZkfW3j4wkjOjzqXht5d7xIl/+1qxMdfljCnO5emmh2jQTR/UFVbHVLF /+9gcOGVmb/hNdMnfCn4KstAx0UH+DhmSPYR0S16prSmgJ8UzmCK0lvdht3ghviYuddxowJXpu5S4G aDUjpyhPKYVOg0AFEYVKJnSdlFnwAUZNImkrIu2W6WlGrhDcnyrC/G4ZPZso3MpVAt+wbble/YNl8e yNEOux91AdJ+0jIifuIgsX2I6MAVn0GELn95AO96Nz5yJTuckokLMOeFIKCmWvPPiRblWQ6rCNfXN3 LyZ8HPbY+sbMYPGoHvfAzTKqghT7cxw8PzE+KLTrIP1/FC7SSrhf9sKexhLKnfBdt0l+Uhbvea+N2Q dyuh46/M5SGyTQlAXjL5bUTv2H2xL7RSD78E6+ZWbrqyfPCwsr3IZeOGyMPVbBnJK5gDhAfLErlteH PabBIqxrsGdmgVcGxfP4JRkUoJdKQwM/Ig0J7PChO9cylAK/JP+BkNcW6VTjE8vn/OYEVQ+gcmOQnE W2FO1nR7aXTLpWQXnUJiVWJnPcAgVYPVCQVmA8zm5cDXPls0iO+SWFdX8aoith8aUn12DWLhYCOZIk VdDDquTIn4Jhpc3cK8ZOaVw135USIubScw5iK/hzzthybJeW6Loa1oI5gBBg==
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

Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cadcf0233326..e10a21cd21a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5932,6 +5932,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
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
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
 	 *		 constructing a mutable bpf_dynptr object.
 	 *
@@ -6302,11 +6310,6 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
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

