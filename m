Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894D9674A56
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjATDnt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjATDns (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:48 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64518B1EE5
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:47 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id b6so3176854pgi.7
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAhJW0jKH/4jx6iQxNZeszIBjJ7usu3mlK3zqEkOoME=;
        b=izWWC0EX8elf1xqHHjX/rMwZ48HNzhUrL+tksIqqBcEUn1lMXRUWkDsYG/Vh4Wu4yF
         uCYUUm4EUGbUzfGBSffxNAwJuVbkYd62X22aoUJwghYRz9SRsR4EBhyRoZKcetRUvCLv
         /RY41JegjGWg9dQrX1kScevkPFP15x9IgEpxmYaV+IHognDHIjKqWB+QJdyfD9RWRt1d
         QINahIsYZ3Lcomvt1DZHisKUHGZ0RdzuIkSTnrKbW1XToUOb3+MQjoQ9SCt3YKibH68c
         znnxOkQL4hLmeXFBGw8YGUSewRelwfEKPDzFuLVcSdNnpe+1tpkQ8lLvdCCLwgpUC402
         zyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAhJW0jKH/4jx6iQxNZeszIBjJ7usu3mlK3zqEkOoME=;
        b=p+fzdszX4yLnzDW0nwUvorqaXja+4kFaroLlEhprCDL8relgaO5XLC3iJsVdt5yl4c
         sizvYPcVVZjTacqJYif9RTPXyJQ3MlqdKe0jmW2aeddw7xdR9o5wfbCP33+w71UeULS/
         Er4rkpgzuRPSYZVmVRwi1o2CzvhbBTgHLh3mlTxtQs6TLOhkquq7tydXC74WovitOIJ8
         bTykEAIwlcX/PKsDm4YwLaWXP+YezzV8qufjqnAtrQDgMUQJpgaSd50ZrM2lFxIhkO5j
         oONPqCHsiWMv7Bzmn2azjiMEfyH6gRR4PudKNKquB5HAFyS+2uPS/cQS7lAoi2tdow5d
         /gQQ==
X-Gm-Message-State: AFqh2krwvXq9ru2rfNGn93R7p4VDhJGI826FHm9rmpDj0PihPWDBc2lU
        muJfKvU/7HarOOTSc9ZCEtAEkbHG//A=
X-Google-Smtp-Source: AMrXdXua4dz87qOsTkpGZEplHVRhE2Kf0rI6/geAp6i29yohOIGzEEiIwpi8GghmJfVnzYO0GYjdog==
X-Received: by 2002:aa7:8006:0:b0:58b:cacd:2d12 with SMTP id j6-20020aa78006000000b0058bcacd2d12mr12972768pfi.28.1674186226683;
        Thu, 19 Jan 2023 19:43:46 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79ad5000000b00580c8a15d13sm16442303pfp.11.2023.01.19.19.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:46 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 09/12] selftests/bpf: Add dynptr pruning tests
Date:   Fri, 20 Jan 2023 09:13:11 +0530
Message-Id: <20230120034314.1921848-10-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120034314.1921848-1-memxor@gmail.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3977; i=memxor@gmail.com; h=from:subject; bh=8XInI5egSU1iq6glPmT9oxgPqOpmV7u1yWWICXdA/Zs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg29r80p+sB+pDh7sMlZEJcoWFpJecuJjto4oRfH 6JcsCNOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvQAKCRBM4MiGSL8RykRmD/ 9xfDoll38+IV+5IkkRgYkh7vuPW2CvuHIFg5u3MahBwRgbwCdbMxUARxIprZCDF8cXZLiCfMvqsriU Wd6Hnx0Hvg/zkLbIoLfShDOITx9T9gD8ddhjvfm3acV85fEyWBJhYjsweVUGKSGbruQ5tCDy7Prcku khbzao556T5FP4CGbPZr1HTW1dLhHdkyqhnaMyycVZEbizv/oIdosLuG7jAqDNPnLHWd2HYVtQBDd2 1JUOOlLf03W/p+BrnVoZss8ZZc5TA9SQQ18sCFzrU9/fSZZAbeW2X2yU/m2QlHzMrmLTJgxOy+/4PZ HUK3rWsA1WWjhNk2NXLW9BIh5ioFbKrGCAGJVYFOPo7uVSSPHCR3QCrBsqsv5D2+dluwGnCl7KQoKD 5uOQIAhnuTxX4ETaUlbuWV/wawJ9NtQyMZfbP8AvWuaSvPuZBbZnqxtjHuNXy4kKNgtvXmVxqlC5Kc 07K2klcGAaAsybHRl2zgEFShJjYayB+w9dc57jGUKcN4uf6kA1g4C77FXN5Nj+OqUKJHuJMZNWl4FE POgiRdsay+uDyLHZ7S2OsSWyag5sTBKnaf/gonWPNU5AqAHHt2w1ZCKaQWoZsVaGulEHgyRfJMrMuC iy7qYMaKvZDtfdBykimZgxeaRhy/x4BvywRbkhH85TMva7Oy5jwjys3bRI0A==
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
index e43000c63c66..8f7b239b8503 100644
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

