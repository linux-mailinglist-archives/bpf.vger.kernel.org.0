Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67830674DAC
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjATHEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjATHEc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:32 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1702C66CC0
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:29 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id z4-20020a17090a170400b00226d331390cso4023514pjd.5
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs5n2Q1YRbL+FZCik99wIL5O/1FCJ2BZ9GlI4NG+zGU=;
        b=nRR5tKBXlw+xafwDMdwemdBfma1IBjjJ/NzIRyU1T0DUZ409MW7mMJTsJUasFM7JG7
         6EjEHGUlGcbJDuIP+MsksyD1FOUm8FUwzUjE/Qh1Nd/xnplHTzjPoEpQ3Nqkcgq4Mcqh
         5w2ovOubfPyr8+t1JUlQCqM2SPr36ALOnhgMI58+O9LWyM0yprMtwVRhpaHJHosh71CD
         hvC3srqGU7jyqMEg0AxAt3vlV+rkqZY0H/FnfXVnpfdvAMWeLCwqGeC14wrOdvLrN53+
         y36ppkxX3s/KG/mBPJRzsmvjLqbTXRespppS6OXw6mWIVcYPDjQ/O7wG3m7q/yviBTX+
         ZvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs5n2Q1YRbL+FZCik99wIL5O/1FCJ2BZ9GlI4NG+zGU=;
        b=wKGCyJYn2xtS5Sg1Dr3wSAInAFG/IUt6uozxLRqUz6ZB3c3fPyeGJekvc+YSMnBmem
         BbvGnJaFs3fPDRDg3BvzX5a087xEQxq0iebvxcOXPZHO7pRDr84tSbWMhVhOor/OdJRC
         IjIglQ1+i++4LczVDV3IXvTCdTEv4aliE4umGu1EiXmqlshu9OJXHt9rv2p56slybDXx
         K5+Nm1WFgur2RFG1wcgqRChEzSWaci10aU4oLIFoUHV/Mq2mwLlAvzN/SMfUAanj4LkO
         uIm2ELxJS5qUjGAiM5mW4DWq0aQkMHgW92MwNSPYGi8OfTS7LGocqjifBMM0wHjz90jB
         fUAw==
X-Gm-Message-State: AFqh2kqf3GyFgznAqwBoPiQzzwwHq71ckH5ck/Qg5EXwCwkiuQ0JdfWi
        bP37fNOK03ixSshPSg1Xf38DYjCTZTo=
X-Google-Smtp-Source: AMrXdXu79TbOC7iHL9lGwXqyWhrcPBYe5/paLAkMsuBP6B6+UJwYxeLMof/f5szLGmRKRUurHP0XJA==
X-Received: by 2002:a17:903:1c6:b0:195:e590:c7c6 with SMTP id e6-20020a17090301c600b00195e590c7c6mr1364477plh.22.1674198268290;
        Thu, 19 Jan 2023 23:04:28 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b00172cb8b97a8sm12487522plh.5.2023.01.19.23.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:04:27 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v4 08/12] selftests/bpf: convenience macro for use with 'asm volatile' blocks
Date:   Fri, 20 Jan 2023 12:33:51 +0530
Message-Id: <20230120070355.1983560-9-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120070355.1983560-1-memxor@gmail.com>
References: <20230120070355.1983560-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=memxor@gmail.com; h=from:subject; bh=SNRMXDcMW1zluX6a3W/WYa1RbpYDzrfdzhpCt6yThTA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzLs5JRMTd9QT6uBQgwWA2rgY8rE3jweRYNnMEY kA+RJ3KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8ywAKCRBM4MiGSL8RyhcAD/ 48GFDqIMM3+H6w3L6v0biyh5kVkqymLHEJd962rUtTS/9oe5Fsv+cMVK4GA10HWyHNKZhJIso0cFK1 AKRZKA55RkHf429kzvOIfjt7iNMTNxOud45tbPnQNI/B+rOR3e5xIKLVS5ctDzNrbjbAw8l/Q1ISCH TuxWg3VZIlZNtcKB9pWxu8RlmcakIVEZqvbtS1JIbi/YPaAQDMVEYTsi+httVQq3skwdoS87D7KWe1 9Gid2vWgQ16NNKw6BN1X3Xiy1J+dSlf6qFqzmFzdJ+RfZBjLX90s6uTMWvziE5Oqn2Ahk564BeOgWf /fVb9ismDG+M+JKRktunXfTZtPomzYRoV7JKbZvVvzAh9v2Gu0ELKJW+Ypot4gU5RUotT/Kr4ZbzlL JcfaM4BIk5Ilcvt65c+tAOaRPXGtDkcCYMZTyvL83cBmp+/ymmCrrdYo1DByGEO6cdJxnVIxw+weUL naBmkxqIQ/kG1E2DJSziN/Ofqa6mZzAeF+6R6fUhQapWTZ3tqoSGa8QugLrFNIfICPs0w+PJGTM7Nw esaafTA7IaX3q/HCDIMhvFxiuAX8kk2B4g4RjhURX7/5Bj/Mzq8NqbUp9aDfIUKn3GA9tSnuiEI5+x Qov8J3NoZLfwLiyC+/q2XReOe8AqjQPVavoAQx5l1vyxtLoWUu28dDUD3lbQ==
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

