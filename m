Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A577F674DAE
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjATHEh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjATHEg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:36 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C1660CB1
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:36 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id c6so4588724pls.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqKHgLPVOuLzH7ZCR7QAiED+nBVGYayNRgcRrmJ2ARk=;
        b=g+55hz6CKQlVjap1KIwT0fHrCka2aXGuekfL0aqagViDozBRRoFuWcffjARfzMURBE
         WqnZliHVk7QFLO+r2lo8MPMtkQp6cakW263c71iLfX0L1O8Ocms7m0FZDNC38Xg0tLMR
         Rkq5TXSPJc0iseyp+DedGxK14gxFpaig/0UgLZKfgsav/uxmPq8tebSCPxiEB86CG0Au
         TUNjonLOADuA5YxQV1hKSG8zkUB9qX46OfNbR2H3ue8QSbI4q3kPn7Kf+rjBJ0MXGKMs
         al3V13Ktia16FwXge5oap/BMgcZ0SzrtZFw7XyvEWTTqOD4/6qxY2/oV4cBoOAxYAuX9
         i7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqKHgLPVOuLzH7ZCR7QAiED+nBVGYayNRgcRrmJ2ARk=;
        b=GipSUqos5sIa9JyJQ1mF7zdr6G5oVcCw0vNQ5iG2Sso3rpoTTmLoAik3dBpKIKznoS
         6XPtbZ3u+Qa8hoRPwwpKq8EIiiXTDj5Exy6KoxlER3G/xLP7mcs5b8zEWUs/Mh993r6L
         IO0uMeYJGkHCnu+FUzQKYGEMiRJ3T8Gj9g1KlqXYVM4boVro/GuF3rN9rIVZ5igc/jsL
         hieKq0Y/PjMFdeyj7NdPxzG7GyD5UEqizhiqDMNirZ/Nnn6MU4aGk4yj+orlKvBAcNj5
         muuUAHZlOWK+CH6nsPZHzHsulz0dKDZzPt7TIEahy1b97L5xHYscCwMPbuA3F23tLRT7
         gJTQ==
X-Gm-Message-State: AFqh2krPVlfzoxPR0XO6hfUGBqJYoz+85xGRHKwVmSfuXoOw2QrX24+c
        66RubTVhyT3xp16Apf9mogLv74IfLXE=
X-Google-Smtp-Source: AMrXdXuxQ5mUFHDzgyGAKN+14gpTZD9GE/HqGdGwPjGtMP5Mk7TgdlRhkAyaXBH7cak7VEhYll23gA==
X-Received: by 2002:a17:902:b213:b0:194:5c63:3638 with SMTP id t19-20020a170902b21300b001945c633638mr13569307plr.61.1674198275450;
        Thu, 19 Jan 2023 23:04:35 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090311ce00b00189c536c72asm26287873plh.148.2023.01.19.23.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:04:35 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 10/12] selftests/bpf: Add dynptr var_off tests
Date:   Fri, 20 Jan 2023 12:33:53 +0530
Message-Id: <20230120070355.1983560-11-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120070355.1983560-1-memxor@gmail.com>
References: <20230120070355.1983560-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=memxor@gmail.com; h=from:subject; bh=35zrMYiHjIev+NoG4HbRoMpjPSoBEo4hvE45xRAMx28=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzMPR7d9Dz+Hqxsm4lJqmrpIOh2VEe9eLixVhUX WICorMeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8zAAKCRBM4MiGSL8Ryjr+D/ 42KWDPofMYcKxqPqlCxCe8QQnbsTlaUo928JgYm3TwLoZeW1U9u3/WKzLrmdrGH3RuwRtIukca8+W+ 0gSVHuh/tvImI2mWhwwofN4ItJpq+1grSNC9/sSjhl34RIgDl4F+T241/A7fTwqusASfRTWoC1T/Jj szU/NuwdT66x3Qevyrr+ZmEWTMW6nw9zB1GakEs81AEUXSsnczraWH0F2vH/gB4b0ur+ygCxowtO03 bE/DlMFpzYU4RomLTfI+G8Vj1ms1Fmslfgl9Wu/cxWiMOzWjjVYnKNLgWtHpLhVZK0aS4satRLKqpk POdRiAwhDu8bMaQZztWHaPcaG26KhJuF/nLr/rrF4Z3cc4eojD/3/FfHExHW4bR+8PqsylCi719LqK 99AQFtsfainAmaKavoSpC8UBX4v4HvdbeWkIFueJQU5ywqTMuAhF2+us2PbeVTYN4UoRa8ntbpDyf8 36cboYg65k4PK5FCbHMSBBCslv4VlHYvcH9mG8dHfS9Hn5dTsaYAAHT90aGNv/9BoRalO15FZWqW4k RLsv1Gm+P8sWXCUq7mD2c+qXwNx6E6KQMT4V8FS61dMFGv/+8r/caDhuJ+WO+H43ShXKgOwYR+er5h ZhNo7oIm7bZrIpirpjYkiPzX7x7dpcwg8uFO/37vc/H5xSdpXAsm2ekLByqw==
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
index f1e047877279..2d899f2bebb0 100644
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
+		"r9 = 16;				\
+		 *(u32 *)(r10 - 4) = r9;		\
+		 r8 = *(u32 *)(r10 - 4);		\
+		 if r8 >= 0 goto vjmp1;			\
+		 r0 = 1;				\
+		 exit;					\
+	vjmp1:						\
+		 if r8 <= 16 goto vjmp2;		\
+		 r0 = 1;				\
+		 exit;					\
+	vjmp2:						\
+		 r8 &= 16;				\
+		 r1 = %[ringbuf] ll;			\
+		 r2 = 8;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -32;				\
+		 r4 += r8;				\
+		 call %[bpf_ringbuf_reserve_dynptr];	\
+		 r9 = 0xeB9F;				\
+		 *(u64 *)(r10 - 16) = r9;		\
+		 r1 = r10;				\
+		 r1 += -32;				\
+		 r1 += r8;				\
+		 r2 = 0;				\
+		 call %[bpf_ringbuf_discard_dynptr];	"
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

