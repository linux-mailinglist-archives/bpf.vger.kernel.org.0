Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125D167625D
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjAUAZY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjAUAZB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:25:01 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425DAAA5CD
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:26 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id i1so5186309pfk.3
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs5n2Q1YRbL+FZCik99wIL5O/1FCJ2BZ9GlI4NG+zGU=;
        b=quecMsS0/sgum1iU7XO+FkUnDIUSvEJwNZHSr5Cqyg0C3XH+VZhXABzpCQUo9pc/j/
         9wj+kvgbg9zh+jd+AYfGNiaBf8pQ2btOoZxP/GXQjSEtWtNz38N1Ay4MqFPQrKUkJQoh
         PNJ03BHEzdNcLIZJ2H7qiI0qU+rk6bWB9JXzoL+kWs0PzPrttgvheZ5nTGVCLJYjOF/N
         Y6SOXE7NzvyE4qklh7Io9NJ8oebVfSgBdugnVG7grAHfwBrrevnF+9E+UMJGk64E4WPw
         tp6j/BAf2uWgGn3BuSOs4MU03Mvorxz1HwNRsGO9VjumRXyJObMnPj8esETlXMQ2X7CY
         TKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs5n2Q1YRbL+FZCik99wIL5O/1FCJ2BZ9GlI4NG+zGU=;
        b=66swDRDt4vz6vgyciyauRCwaJc5GCQFJUAnChT48SvU4llxAyL7LGDvgnZw5hAwe86
         h8wuNG1tOhJ7YpElo/E3fXQzFaRMnb+IiJhlZDbsyz6DNJqu9Szb1tq+FP9WhUJ+A7ec
         qGtyKxTIxx7a+0/ggOwjLx6qzmn0F1VruSlG/4Gc8WjA4KVT4DCuHWl4Z3fPILLXhm50
         XAFaLEP2Urho666xXY9O7Duk/y2S5qJGl35YHyO2TUX2lSTadU2byWf4UKVwStUNs2SO
         Atw7fVVLT1VKzALaLO0BMWvZgzzglWOsKAcVwj6eBjp1ekpFK0Sk7d3uVrImf8ZHv2Ow
         WxYQ==
X-Gm-Message-State: AFqh2kobje5h5a+3e8f+/XkG/5Bz8/a31dy/WFIQ5F54Kt99qnBloX+K
        junPLKIqJV0KM1KOLZLQQvIK5UBkNVQ=
X-Google-Smtp-Source: AMrXdXvKwY1QBZgQEYlXaLVucOoVSzOAkuZzcElsMvXrXZil4zD/ThTDf5PxjS7Ubx07ky+XlgTCFQ==
X-Received: by 2002:aa7:880b:0:b0:58d:abd5:504a with SMTP id c11-20020aa7880b000000b0058dabd5504amr15658790pfo.31.1674260594221;
        Fri, 20 Jan 2023 16:23:14 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id m63-20020a625842000000b005775c52dbc4sm3011286pfb.167.2023.01.20.16.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:23:13 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 08/12] selftests/bpf: convenience macro for use with 'asm volatile' blocks
Date:   Sat, 21 Jan 2023 05:52:37 +0530
Message-Id: <20230121002241.2113993-9-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
References: <20230121002241.2113993-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=memxor@gmail.com; h=from:subject; bh=SNRMXDcMW1zluX6a3W/WYa1RbpYDzrfdzhpCt6yThTA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAks5JRMTd9QT6uBQgwWA2rgY8rE3jweRYNnMEY kA+RJ3KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swJAAKCRBM4MiGSL8RykP1EA CgtUWgZGiUO5Luilnr/T7cPGSXkCKQTfws7HQRMp9hZyPlOLfyRul3WDi9KjiRlvBwhvkYyuCSK5Wf tj8IQMKPlQHDhnedVp24GcymiBgizlrfMw/nQs9V13W+imV1h9ne/OVonZMs4KIeHxLDxHBUCtxbU9 wEubNbyik4Pr2fpE0FPYJbidEEgVwtoTSG0NknnDVwLTaLND7j0I32aJYN0hTLLUI7E2wQdvCOiAld qzaRhNp4ct/0938JbcU7S+z/OtBan7XX+siMaAIulKnwuTB9TSebYsv8CEx66z12A/rQ1jrqqYudZq fG7QaOfMa6Rll41Ei2H5zRa8ri8c0ZdLPhveP7Xz2zrx8/hq28GgGeohVeUeR3WXcXXHgKypas1cQo or+r57Hqjiv4I1h7Sp1PCysy9+HO/wrQgr5DcmxVlMCqtY67HMVltv7LJ906tEut8YYYgPPdREwcfm q7aSexttmeNfja9wNqYIgolRHhMaaAve4L6/RynQgqWYQJN/Ja6ydXXrYotehV6TrZhWD26T0SUKk9 PvucNz1sfEVUvtP0GV/7yuj5KgZfBRcmkp4XiMfOkb8KliY7dhjZu4AuDUypW2UjBJV6AsAeq64p72 Vmt2Oe8pm6dvZDo3F5zre7MQnU2ASm9r+y78gTWqST0rvSrI+P0o78TdIjEQ==
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

