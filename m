Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB38672EB7
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjASCPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjASCPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:15:15 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6CE67963
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:14 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id k13so1024849plg.0
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdqLo4rY5bkeLnW4X1l29ghb6NgQBmCacIQ+rxEheYc=;
        b=dok/BadNTNm9fXrnw7SNFA9Dv4ejY0vObUYih3iASI2bW51VULuAMEeYy9wFyAKhOI
         EBgMb7zU/zycrccAy4Q8EINq5XklZHRu5y68NgjS30H1HKnphbA2Im+sD86eB3w5SlLR
         1YNwjCZqjIhChtsB02ukZeAfWjk2jFkCqnkfpyV8oVoQ560dWD9xL2cHOjwyIXbHRw4b
         96J3dwubeSzoamg5J1nHjShWaS//DIj2X6ZdoQ9PSB9DSzyMfcS3gi+fKV3j14zJ+fQP
         6mcaKmQ4QA3Pg/aTIy2QG5QP9MO+MM5VEWC3+pojFuvi4X7xAdfogpviI4bpfIlZgKlQ
         0jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdqLo4rY5bkeLnW4X1l29ghb6NgQBmCacIQ+rxEheYc=;
        b=Wgw8CHN38p3NCs3gBvZBozcIjIJUTR0gOzKfb19OHptPVkLw4Y74JWGXlJzcsiQD9f
         YWLP7X6FeRDTJSuyCpp9rWbPCD1x65xV73Pa2SpHem8eN259a9+CpeWI6MCzc/9KvyPK
         jzM8tLMntFxCk6UyV0LkDhzF+aPjDq8gGT0wQN5ror/F9tax8hE7yzNFAXylLP4b4q6q
         W76SCUDjz0rMxZR7VpO9mqGKbIVPzhIZzJ5Vs2BDyOeAvTqEiVix5ETJbR4WaJrGpaXK
         v3wnjcjfas0ttSvT2QjP95OwWyK48a4eChRp+g961sUoS/ZVMWfUq46j/bFI376Lu7uk
         gQ3Q==
X-Gm-Message-State: AFqh2koIN/8r3N8ptL3gH8uVIi0zsZXAe5Y96eKN83tTd4Mii5J5kFA8
        5NdVpsknbfpGeoTGBWpG+VeDoTxx07w=
X-Google-Smtp-Source: AMrXdXuTMnY0vK+tvyRnVj2P1u1LWbK3kliz5ijJ042Q3giY93vZ6tzxYt1R4RrP6UzbzVQ68ABYKA==
X-Received: by 2002:a17:902:cf10:b0:194:5fc9:f55a with SMTP id i16-20020a170902cf1000b001945fc9f55amr11119133plg.35.1674094513465;
        Wed, 18 Jan 2023 18:15:13 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b00189c4b8ca21sm11374816pll.18.2023.01.18.18.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:15:13 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 08/11] selftests/bpf: Add dynptr pruning tests
Date:   Thu, 19 Jan 2023 07:44:39 +0530
Message-Id: <20230119021442.1465269-9-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119021442.1465269-1-memxor@gmail.com>
References: <20230119021442.1465269-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3977; i=memxor@gmail.com; h=from:subject; bh=Zf15ND1/1Wx5PKaPTNXdGmm4XAJT04+4c//QsnYsQfQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKdAM9vh8THvr/BQXXOpoAmNXvgBLZ77BnM0NPs6 NlisX9mJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inQAAKCRBM4MiGSL8RynSHEA Ci9/6dnXo2rzhqpq6ughP+X7VIZIkwYleL0CWVoxgYYyEsT0rlUztmAOx/2g6VVCeUbVNeyryj5UI3 g/G3NT/ra1U9AQ4Gaiq3SWuQEnfaZYtXQe1Vt0OsEb3YRolDxsIRjlHygM8nFfEcTkVFkw4KGzvVRJ DYFlbwG/tDWG19SYSJhR2Dc/2hODk+zoXieTIOiNiz4CjA+qoCt6AnACpMZ+s+q+PrCXDcTjGGwJzf eLh+6DPFkP/3ko670VkBNJTjhoABi5wOk1PzQjTChym8Jg6gUWqdE1rsBmz7pABz8ellJwCM/UfnjS wr3ORR1llShie6AcX/CkmUujx2eGyfCz+2uSqShTtWSb1RCW5URYVCOqwCIwrwd4+YhiWQzCy8U/Yw IKdvZY9jOcuaDidFarMA4kZkm1jUbqOPf7F8vjOqUXjTScobe17h0SOHWkKKtSgWNRGs9CnSBj4Roh RWtEDSBsXSvYnlCuT5X1RalnLN9fGa/yekTnyKaJdlGZLMUYW2jBiDKFgC3ghZwEk0WJYmkxoZeOK3 hC3UvnlG3Y8Y3zjkjZzxg2Cq3EDJLNNspb4EY6s8r206HvjL82SV1ZwE2NP9khEe6QUg2JthctUu9+ dN9cl0OF0DdnIpS8LAnBxjLmEAFyml1LELqVbMLQBjaubwubeZE4f1Rf1vKg==
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

Add verifier tests that verify the new pruning behavior for STACK_DYNPTR
slots, and ensure that state equivalence takes into account changes to
the old and current verifier state correctly. Also ensure that the
stacksafe changes are actually enabling pruning in case states are
equivalent from pruning PoV.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 9dc3f23a8270..023b3c36bc78 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -35,6 +35,13 @@ struct {
 	__type(value, __u32);
 } array_map3 SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} array_map4 SEC(".maps");
+
 struct sample {
 	int pid;
 	long value;
@@ -653,3 +660,137 @@ int dynptr_from_mem_invalid_api(void *ctx)
 
 	return 0;
 }
+
+SEC("?tc")
+__failure __msg("cannot overwrite referenced dynptr") __log_level(2)
+int dynptr_pruning_overwrite(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r9 = 0xeB9F;"
+		"r6 = %[ringbuf] ll;"
+		"r1 = r6;"
+		"r2 = 8;"
+		"r3 = 0;"
+		"r4 = r10;"
+		"r4 += -16;"
+		"call %[bpf_ringbuf_reserve_dynptr];"
+		"if r0 == 0 goto pjmp1;"
+		"goto pjmp2;"
+	"pjmp1:"
+		"*(u64 *)(r10 - 16) = r9;"
+	"pjmp2:"
+		"r1 = r10;"
+		"r1 += -16;"
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
+
+SEC("?tc")
+__success __msg("12: safe") __log_level(2)
+int dynptr_pruning_stacksafe(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r9 = 0xeB9F;"
+		"r6 = %[ringbuf] ll;"
+		"r1 = r6;"
+		"r2 = 8;"
+		"r3 = 0;"
+		"r4 = r10;"
+		"r4 += -16;"
+		"call %[bpf_ringbuf_reserve_dynptr];"
+		"if r0 == 0 goto stjmp1;"
+		"goto stjmp2;"
+	"stjmp1:"
+		"r9 = r9;"
+	"stjmp2:"
+		"r1 = r10;"
+		"r1 += -16;"
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
+
+SEC("?tc")
+__failure __msg("cannot overwrite referenced dynptr") __log_level(2)
+int dynptr_pruning_type_confusion(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r6 = %[array_map4] ll;"
+		"r7 = %[ringbuf] ll;"
+		"r1 = r6;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"r9 = 0;"
+		"*(u64 *)(r2 + 0) = r9;"
+		"r3 = r10;"
+		"r3 += -24;"
+		"r9 = 0xeB9FeB9F;"
+		"*(u64 *)(r10 - 16) = r9;"
+		"*(u64 *)(r10 - 24) = r9;"
+		"r9 = 0;"
+		"r4 = 0;"
+		"r8 = r2;"
+		"call %[bpf_map_update_elem];"
+		"r1 = r6;"
+		"r2 = r8;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 != 0 goto tjmp1;"
+		"exit;"
+	"tjmp1:"
+		"r8 = r0;"
+		"r1 = r7;"
+		"r2 = 8;"
+		"r3 = 0;"
+		"r4 = r10;"
+		"r4 += -16;"
+		"r0 = *(u64 *)(r0 + 0);"
+		"call %[bpf_ringbuf_reserve_dynptr];"
+		"if r0 == 0 goto tjmp2;"
+		"r8 = r8;"
+		"r8 = r8;"
+		"r8 = r8;"
+		"r8 = r8;"
+		"r8 = r8;"
+		"r8 = r8;"
+		"r8 = r8;"
+		"goto tjmp3;"
+	"tjmp2:"
+		"*(u64 *)(r10 - 8) = r9;"
+		"*(u64 *)(r10 - 16) = r9;"
+		"r1 = r8;"
+		"r1 += 8;"
+		"r2 = 0;"
+		"r3 = 0;"
+		"r4 = r10;"
+		"r4 += -16;"
+		"call %[bpf_dynptr_from_mem];"
+	"tjmp3:"
+		"r1 = r10;"
+		"r1 += -16;"
+		"r2 = 0;"
+		"call %[bpf_ringbuf_discard_dynptr];"
+		:
+		: __imm(bpf_map_update_elem),
+		  __imm(bpf_map_lookup_elem),
+		  __imm(bpf_ringbuf_reserve_dynptr),
+		  __imm(bpf_dynptr_from_mem),
+		  __imm(bpf_ringbuf_discard_dynptr),
+		  __imm_addr(array_map4),
+		  __imm_addr(ringbuf)
+		: __clobber_all
+	);
+	return 0;
+}
-- 
2.39.1

