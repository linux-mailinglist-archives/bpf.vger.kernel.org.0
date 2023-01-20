Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C959674A57
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjATDnw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjATDnv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:51 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8198AB1EE1
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:50 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id z13so4236489plg.6
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sytj1Iu5muU2N5JZ8RxnQi4JbWwNtRBWbJ3V6flnO1k=;
        b=hu0+4C1MybmHcHcSqC7OfbLBaOACi2t7yX2iEUq0yRUqaqkBNjUuWzyyS7zcG0Lwj0
         0i5JMExdHsxbf26hat8ty09aBUAAi6Tw5WNXc2TBydF8hbL0BtsHQAMsmRu6TOJ+k6IW
         ogxiplWTiRZLeDgJFi2yvbGYcNjQ90q9vVqt++BPB/hSd7JEIw/PvsGjS1jxr/a29cEF
         3KGrTUcahUMNhXNGjgidHB1R2CVwja84qV1HWwuER4oWFWe6+1TOUl3bUO+cvzIeDkSC
         fQbRirzL7XMh6xH1zxWd+IbHJSZXJ6OlhgzYrGgd3zFzfolEndsa9+xjs3WoUUM9rfgh
         RKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sytj1Iu5muU2N5JZ8RxnQi4JbWwNtRBWbJ3V6flnO1k=;
        b=06wu1uteA3CGndLmwY4aBhiKdsrUkkpU4gaogYuiYu9Lfsij8Jvr6onDotDoODRk2e
         c3C6/kh9IIv4inhLjJadm5yGgNmKp3UZOidtDw4EfLx4vHlssFx+m+BytMAbZZ+eLKAJ
         7rPPVa6KVInJavMDZPXTfcH8LD+AHv081OfABkNpuj6/a3X3KeTmytgBpKYD3CZWoann
         py7zYkiDyEdsxoykaARSej9sK4zbTOMtaDMKs+vd1s9IbcddEDVsiWJaLm8orE338sZ/
         l7sbC8Sb19cxc+qbRUM0eXR9wM82jD8vYUDdYIEuOrcO+fC1yYqDb+MDWjVrexDvLwKg
         TmhA==
X-Gm-Message-State: AFqh2krnbkqcUccKZLP28hOwfkn5UIMnZn9XH9+Dqa3rRW9nriouSntF
        rbkUCyIRDouLCRKHGyLLXOo7MZSCXuE=
X-Google-Smtp-Source: AMrXdXvnfGTmGEZDDXDRn0JrGCK7EAXlybssxdCqXuFtE7i2C9tbyVg+9WT6QP3pCnE2OorXiVuymQ==
X-Received: by 2002:a17:902:c3c5:b0:194:41aa:2131 with SMTP id j5-20020a170902c3c500b0019441aa2131mr33138919plj.25.1674186229798;
        Thu, 19 Jan 2023 19:43:49 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903028f00b00190c6518e30sm25906039plr.243.2023.01.19.19.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:49 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 10/12] selftests/bpf: Add dynptr var_off tests
Date:   Fri, 20 Jan 2023 09:13:12 +0530
Message-Id: <20230120034314.1921848-11-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120034314.1921848-1-memxor@gmail.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=memxor@gmail.com; h=from:subject; bh=ew9dT3h+i10P/6ZuvC/eNJnDhWbTKKMoZzJ3kbQWv5c=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg29fUSlp1ePbkU97nWvsvmf7MN9MKVsrwPP8lRU jhkjSJ6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvQAKCRBM4MiGSL8RygUkD/ 9WEwr667b6kGH+Tn6Vy5+2pCqO16A82aGWgScdSGuVmWPVYAX1YnwtfWefKH5i93OJB9MUM18MILpd SWu7WAf799FcbXHg0yLT4f6JXtAILUGD/sx1BqmU95oINtrDChIDqORDHl0FLT6RiOkC42ay2SvFz9 4ENb9QvFhr4fHx1PXcEWP7C/0mtSe7fodyW9TVpOnHmn7ow6sMCfIjOE4+gToJseLrd0vlUCDZfeWc qDDyrB33ZwaGorfjPa7w5lQOZENKRV+ApYyPRj762MbqU+gkwwok1LrCJd+w+qwfx2HBJ44evRoeHg j9vLdyRWui34vrb+A/h78A/be3CIsPCHX4pED6MiasF+tCYQPppTbMlf9cMnX9ZZEvUBA2b/Who4kQ qrxKVD9WZyTboOkxT390xAvf/v9F9sfd9IKUULSCYmTuv1qoL+l+D7wcW1+UzUkb6DjB+AZ+TRE5fo n4nolyE/QkvbkH47dFuI51H5cRaNv6daHmdGl3KwG5lJRdLNXF1Gx3I3Euz19t7vpXyY821y88XeW5 6wLy8Qnv192mKoHFmCg6tJFJRlAjV15PBA/mUJ9GScFOArKbFUqsjRL5oqudP5AN0hNkFth0cpkakZ l9ieEaoS4T3PKWhuqONVctUPeuP5Tan05KAdk/FaAHY+l3xXaK37J8Xo3zeg==
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

Ensure that variable offset is handled correctly, and verifier takes
both fixed and variable part into account. Also ensures that only
constant var_off is allowed.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 8f7b239b8503..9477c238af57 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -794,3 +794,43 @@ int dynptr_pruning_type_confusion(struct __sk_buff *ctx)
 	);
 	return 0;
 }
+
+SEC("?tc")
+__failure __msg("dynptr has to be at a constant offset") __log_level(2)
+int dynptr_var_off_overwrite(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r9 = 16;"
+		"*(u32 *)(r10 - 4) = r9;"
+		"r8 = *(u32 *)(r10 - 4);"
+		"if r8 >= 0 goto vjmp1;"
+		"r0 = 1;"
+		"exit;"
+	"vjmp1:"
+		"if r8 <= 16 goto vjmp2;"
+		"r0 = 1;"
+		"exit;"
+	"vjmp2:"
+		"r8 &= 16;"
+		"r1 = %[ringbuf] ll;"
+		"r2 = 8;"
+		"r3 = 0;"
+		"r4 = r10;"
+		"r4 += -32;"
+		"r4 += r8;"
+		"call %[bpf_ringbuf_reserve_dynptr];"
+		"r9 = 0xeB9F;"
+		"*(u64 *)(r10 - 16) = r9;"
+		"r1 = r10;"
+		"r1 += -32;"
+		"r1 += r8;"
+		"r2 = 0;"
+		"call %[bpf_ringbuf_discard_dynptr];"
+		:
+		: __imm(bpf_ringbuf_reserve_dynptr),
+		  __imm(bpf_ringbuf_discard_dynptr),
+		  __imm_addr(ringbuf)
+		: __clobber_all
+	);
+	return 0;
+}
-- 
2.39.1

