Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F8674A55
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjATDnp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjATDno (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:44 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDB4B1EED
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:43 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so7000492pjq.0
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs5n2Q1YRbL+FZCik99wIL5O/1FCJ2BZ9GlI4NG+zGU=;
        b=P34x8GqHVh8pFfUlaWPHhimoMq6YwoPxSuiGzssVnWeTvsM34NsS/J3OM8SnajTXcx
         N8TX2FbcSJ1XJRAUvaGLwedoBMsDLsWWC04ISJWQfqkIdzpK+lToHRTJbNOwzJ+nXD1a
         6mOHJCHmyg6DjV+dghhZ96l1c/MCY115XW0aUXkxfdFDQKXcU9pbr5r1re43gSHPZj+t
         YWDyjxbaT2gtEey8O9MLZGsXVnSUzZoysrdjJx9XpcyjLCYi+9tTjSiIpXPg6bR/40NO
         8LBwYgknbqs4OOiTAy1o7CubkJXNAuCvjniDYZEnS5zUMYwHqtRreCpgkV2w8uZN8zzl
         WnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs5n2Q1YRbL+FZCik99wIL5O/1FCJ2BZ9GlI4NG+zGU=;
        b=tdXO6SpZuNBJ1bz/oYfPwsPHjgpfhc6gPnVHIDsAEHz7+d4tGD4XbXbcomzZA++HGy
         16XUf+Yz/9D2U3UTgeHpGQS9ojpsAS2DG0YZBB6nv/yT+lC5TEgluqg2+h5WaOQk/KRe
         B0RioG1gkhxN0S4YbB8v0IFct0uJjdCNcL3VCwoXgLUcubCIHm00lHA6b4XF+SaDgoh0
         eJAjoHLjn9LrTK/nmDkte16hHHKEwRqAZwgfa6Q+Qx1a2eQ7uMsrgQ4xd+sVeaof9zUw
         WGYAsz6YZThJ7pv/GztpeVnL89kCN9ticcC58mz9OMjSArFIK1hSHTh6r/fijvcibzTE
         ti1A==
X-Gm-Message-State: AFqh2kquJ1ah8t95m/CoAkUkDFbMVZfI3LGWKlsaj1VHB9yhYnCbhZI1
        W/do7eZ/in1dV5UH0f8mdX22gN7rtVc=
X-Google-Smtp-Source: AMrXdXu8aw2PzXm4PvDz01i3ooGcOtIawpRtw3fCPvErZzlhxgmfIFHaDOO6h3L0sgNQQSVjd7PMsg==
X-Received: by 2002:a17:90a:ac0c:b0:227:1a22:d182 with SMTP id o12-20020a17090aac0c00b002271a22d182mr14393111pjq.42.1674186223108;
        Thu, 19 Jan 2023 19:43:43 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a284900b0022b787fb08dsm373551pjf.5.2023.01.19.19.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:42 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v3 08/12] selftests/bpf: convenience macro for use with 'asm volatile' blocks
Date:   Fri, 20 Jan 2023 09:13:10 +0530
Message-Id: <20230120034314.1921848-9-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120034314.1921848-1-memxor@gmail.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=memxor@gmail.com; h=from:subject; bh=SNRMXDcMW1zluX6a3W/WYa1RbpYDzrfdzhpCt6yThTA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg29s5JRMTd9QT6uBQgwWA2rgY8rE3jweRYNnMEY kA+RJ3KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvQAKCRBM4MiGSL8Ryo/cEA CSMbgc3oh000fQxhLDye890b83pM8LM2nZaFIjii5c26zP+HOSw5iX4mW2mZbL7zH/nnO3ioy0pZde 1cfxfr3VN898fcFWN6or8VgnHOK863VzDohossjXJhc9cCx8vs4BfLXfOsQa+xxTqAXU9D+fFwHzkw Ke5rbyKkeVKK3NsxBhMfehDDLa8LdJmKI7VItQliUm6qhj8G9Zs3AYg3cOljO4DrFh87ksxck4XRIa ZrOJWDBVTDf10yIrBE7+XwjG+9XqQMl+vjWN9I0uafPnPmRvfWficPIcKLjhRVvcYPvw2mPpMJgjqg 4Ix5cRVOaqZiXw/nlvMv2JkSEiInD/8uxPbK2pFfjn4IuKR2X6T4RxByo0yHcCn7WFOHsoom4TOfGp YlcBE1kl4PeG2JZxHvmSOJ9cXPWHFlvbgYoDexR4/TwNHGZyApEMiOIZ3U0OcIUChdC6JTrqoNoKlS 72P62Re8YBo6tV5lW81BNpNXVhw2Mb0tC/gPoxOXiDCfi0KyWhlcBakf9DHo8slqQrDNoGnhC7gaSe 8sbnjM1DZr1VG8fTHMDvzMcXt9jIiOd9f1F71GT+vCD2IOoNxdF1O/qKA6RtQByhqOYCFmpsqQtLKJ lymmtuME6RFa4ywsOSnteu6ZVkrzEw+/jcUF3g753eTC3FsUbP84PAUVUA9A==
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

