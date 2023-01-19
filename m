Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F30672EB6
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjASCPN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjASCPM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:15:12 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF41D67957
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 207so416901pfv.5
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs5n2Q1YRbL+FZCik99wIL5O/1FCJ2BZ9GlI4NG+zGU=;
        b=mjMSvwhR2ScbCZYXnXAUjZGK1qJlIyEDnj7lqwj7v3B+QOnmXIN+zayMremFOUtwaC
         GZIZGNUNT6Aqx6kbIKxb+Q+iSlmVPVxgYMjYa2ee9rqyxMnLQ2ryBaV+UJ7FZ9xYl6+X
         FyuOCwOl4Ri3kqslfjpGEZBbjI3Pp/i27/UNvWZH9LS+bkrnOzG2mru6CIV7E4y5ksNW
         2BOdZf28mW8t4J+uQRLY/ge9EZMzrTnwy5oJ/22FL84xSrTlPsXTqE4pTiMO7sTsw8bN
         9Xc2n6LoAO3M7RlWaZ3KzI8PH1TAV/a3x3wyWyhgGE/eNV2d0uVwC9i8NRhQ3h0eDQTj
         I0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs5n2Q1YRbL+FZCik99wIL5O/1FCJ2BZ9GlI4NG+zGU=;
        b=r++eINsdy9d8WEpmhaRPsa/QZzm6PFfPWtCJ3Gx5ZNc0YoOEvmGIsA1VwoKzVLxpPT
         WNCEW5lhGHioLx51p5W2QtGDPcTXeOZtBpF3shgewx81NxHy/qsOhb6T/1/3sfDGAsmx
         JsCwmDwSjR1nl0ndEp9UXLGd2d1s/r9WUWlpoKBFx7n81P0Cto/YVtgbEnpDV/RjdAfI
         Tvef0HOBt86ECf+gVzvafmmzX5fhbhfJe8nazLMy2ds4hCk9Z3u4XsNd9p0lV+gmI3EG
         taOq7wTdDIrWSMgusCz3mxDU8d8BN6M3B6xOZz5hiK9lXGYctuL5ORRxfVDq2y9cvM8o
         Tb1g==
X-Gm-Message-State: AFqh2kqSDBNiY860HE5pCIml8X+HMz1rwvN7VGRwBNNipbmXpXJTc+WS
        ae5ePVQqgquPGYOQuD4PSDw/GCDBnq8=
X-Google-Smtp-Source: AMrXdXvsPWWQB2vMzyvrsaNPJY2kkrM8kjMIYAJ989piEdEZqYa83vu8kvaM+d4zQamiCeEzpbEp7A==
X-Received: by 2002:a05:6a00:1887:b0:589:d831:ad2a with SMTP id x7-20020a056a00188700b00589d831ad2amr13961885pfh.6.1674094510045;
        Wed, 18 Jan 2023 18:15:10 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id g1-20020a625201000000b0057a9b146592sm10236604pfb.186.2023.01.18.18.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:15:09 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 07/11] selftests/bpf: convenience macro for use with 'asm volatile' blocks
Date:   Thu, 19 Jan 2023 07:44:38 +0530
Message-Id: <20230119021442.1465269-8-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119021442.1465269-1-memxor@gmail.com>
References: <20230119021442.1465269-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=memxor@gmail.com; h=from:subject; bh=SNRMXDcMW1zluX6a3W/WYa1RbpYDzrfdzhpCt6yThTA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKc/s5JRMTd9QT6uBQgwWA2rgY8rE3jweRYNnMEY kA+RJ3KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inPwAKCRBM4MiGSL8Rys6gEA C8W8ec6FwZEt8GZk52E1sKpbKU0pKwotJDquwVvOcVPa4+47OxVQLPtAkhOi9C7AbMBDkFp7WTJHw0 Zf8JUBRUzkLdpqo1BjVGd1Pl4GkZUOPfxSiE4JpgIoTo15STFaTCLXdCp6jpnI+RuMTq+NoAFHE7cQ 4yK+OGL8J+3TraPxLtk+aGEpXYG9/mevn/9nfLHUQjVSuh6R2PsRU9pFHCJMf8WzLohaxZpOnfKSj5 u5+BlYEIyA1PH8qRLi3xfrL43beOQTRTlVzAjoUMglgrsQoVbA9AJTCcozCSVgyCQj064DyukIU+RV ag/FDbLR3QkX+tn+QwdaVdmwn7MGS+wXReTlHKOQkvJZ2NwPPhN3CI8WfMzjbwjFryhiewQyhd66uT fa9ArhVf8C80YNVOXFbYmspkzt/p3xqXGglPZWtW0w4thuwSFC2m5W211RCfrsbPB/U3bTe/qm0r+x XmFPR7dQw8jS7x13GN1o+uZoWt4f8Xvkgj2CTfb+dDbJLLrZyKj9wbe5w62sdbIfOk5KQCxoFnhdjg D+OL1JRrHItkGFsELPPPHN/smO93nBZ+OGrAb1oaaWzTwiMv1YSW7Mmu2aC1zv7yI/rrOvYem9IzGj hq2kqkV9FIb+iWvspQfp1BVlI2Vfln7Go3yaqbBTI2JWoheHmSof4noLi0xw==
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

From: Eduard Zingerman <eddyz87@gmail.com>

A set of macros useful for writing naked BPF functions using inline
assembly. E.g. as follows:

struct map_struct {
	...
} map SEC(".maps");

SEC(...)
__naked int foo_test(void)
{
	asm volatile(
		"r0 = 0;"
		"*(u64*)(r10 - 8) = r0;"
		"r1 = %[map] ll;"
		"r2 = r10;"
		"r2 += -8;"
		"call %[bpf_map_lookup_elem];"
		"r0 = 0;"
		"exit;"
		:
		: __imm(bpf_map_lookup_elem),
		  __imm_addr(map)
		: __clobber_all);
}

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
[ Kartikeya: Add acks, include __clobber_common from Andrii ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 4a01ea9113bf..2d7b89b447b2 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -7,6 +7,13 @@
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
 
+/* Convenience macro for use with 'asm volatile' blocks */
+#define __naked __attribute__((naked))
+#define __clobber_all "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "memory"
+#define __clobber_common "r0", "r1", "r2", "r3", "r4", "r5", "memory"
+#define __imm(name) [name]"i"(name)
+#define __imm_addr(name) [name]"i"(&name)
+
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__x64_"
-- 
2.39.1

