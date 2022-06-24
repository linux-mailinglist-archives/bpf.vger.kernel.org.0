Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2864558D1B
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 04:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiFXCHB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 22:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiFXCHA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 22:07:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6F14E39B
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 19:06:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mf9so1909719ejb.0
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 19:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQxo/i4GDt77rrZJAoqxfktgu0J5YHFi01SrMJiqmd8=;
        b=P1ftTp3RkTalEVf+1Cb3z7yp1nIYEFTfUMdXak+3um57hXuhrUDxBI9d2OeVIRmvtD
         SumwsKtrRgd8PUsXN2e8yWzf9GzUU9MqZj3vdUitwXvXfjM9BgHSIIgtlCCIPJgOKJlx
         2D5Kjsk2RR4JTYsfWGMFEP3TZ8GivUXEmZhLc+amSyr92vsu9ojgO+zQf8sZBVEHf+xW
         URJyAb2SocWAiHCuwOTJfe6CgJKn6nH7WpX4Ik5seR/ap30uuXzGUOPQphHRrleIO0Cb
         tGjinn73NsohcRTNXcaS5pumAy0GoAfX4vtlKbKqdrD0wPZIYiz6L9/juQVBIUnFnaRL
         EaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQxo/i4GDt77rrZJAoqxfktgu0J5YHFi01SrMJiqmd8=;
        b=DsgoKEwPKilZmB0IieW14txe1ZxlShM7rKwzYbsOMhv9iCDh2TNF6N4t/54WgN7qXv
         xJuPvahDGgUu2y0dgV1gmGnPOaZ1Yyh4Z7ZFOZFCEtNuwcZJTqCO+vx0y6Es5GxVEGub
         wUvWZocA42ghOOPBqlSYGZOSSgsVpSfjtBcEXLZMPqAFhLlz4cdf0M0Ibfn+MiCZ8nu7
         ZA56SMbiO5Ert6xLKawQtrwcuEousUexMD8NjhgyXRwtuqxLJCZaDNaXnF+xUvUbZEk5
         fuBTJ5S4JDr7LhJqna/leXosVV1ZS7Gjx7tRQxNqAEf53G82uNG6g6uCVXwvwq1v15pQ
         ZQhQ==
X-Gm-Message-State: AJIora/LZ0Vus/kWOmeQpoFGlTxY6MyaVspV7PXt7d9O97I6EGLKVlxH
        /DkVhU1DOhAWY9v9eO0xW3u6cSLNMgxR65Rm
X-Google-Smtp-Source: AGRyM1t+9ByIhHNLemIguUoS7ggtmoswKRVsnQZQpkmqz1w1m3TF0EBcnqMvy/J+rQF1hRwmUKAkaA==
X-Received: by 2002:a17:907:94c6:b0:71b:85e4:a153 with SMTP id dn6-20020a17090794c600b0071b85e4a153mr11262073ejc.123.1656036416889;
        Thu, 23 Jun 2022 19:06:56 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id h10-20020a50ed8a000000b00435728cd12fsm856595edr.18.2022.06.23.19.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 19:06:56 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, dan.carpenter@oracle.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: fix for use after free bug in inline_bpf_loop
Date:   Fri, 24 Jun 2022 05:06:12 +0300
Message-Id: <20220624020613.548108-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624020613.548108-1-eddyz87@gmail.com>
References: <20220624020613.548108-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As reported by Dan Carpenter, the following statements in
inline_bpf_loop() might cause to the use after free bug:

	struct bpf_prog *new_prog;
        // ...
	new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
        // ...
	env->prog->insnsi[call_insn_offset].imm = callback_offset;

The bpf_patch_insn_data() might free the memory used by env->prog.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a20d7736a5b2..24601d6b501a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14417,7 +14417,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	/* Note: insn_buf[12] is an offset of BPF_CALL_REL instruction */
 	call_insn_offset = position + 12;
 	callback_offset = callback_start - call_insn_offset - 1;
-	env->prog->insnsi[call_insn_offset].imm = callback_offset;
+	new_prog->insnsi[call_insn_offset].imm = callback_offset;
 
 	return new_prog;
 }
-- 
2.25.1

