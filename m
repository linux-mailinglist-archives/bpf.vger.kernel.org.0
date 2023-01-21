Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79244676258
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjAUAZX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjAUAZB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:25:01 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF85990B1A
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:25 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so3566620pji.3
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjuxCRFRYw9wjpCtAG75vdMCkmNxJZQw7fQxwyidGTs=;
        b=bzDvN8UTAN6LmOoKIyHeVF3b4v3z1nAvL+9aGA37ezFQ5cahrFN6fO2UOAjvW1EgA3
         Akd5NpJ0QEsZ8PAIcT7GvZYVQXJI8H8eNkmbyZmVobgJPrSePU+/IFdB+NGv0ElqmMnq
         LfkP7lcSRtW7Zi/kWLSi/ASZSCzMoc8kHrDiriXb27nh+MXkv9Z9sFp27E19CVQDt3tZ
         feIbVi0jybh33Uam24EQ2ka3Yj9wjgEDz/wPGuscJkGKs4s6JXantOrEL9P8MINGiOaZ
         1ZjKUgcHyFo+iMms+LyGDEkcNLBjtsXXb0TkonCtowUulQ8K9/ZMFATZsIV4mPGmA2Iw
         a07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjuxCRFRYw9wjpCtAG75vdMCkmNxJZQw7fQxwyidGTs=;
        b=wqy0G1xDLpIzLRS5TOqXnJc6WTieDnOgcfXXKVRFMbx4Qc4TnWZJRl/Ty0bUqb7fuG
         7wO1rFvL+mU5ieIWWom8VEngLnKQEq3ULLwbfFgDGAEyoW7R/ZFYf35S5vbaniIAuNxS
         QFXpU2Cy6Uv2Vu8jTaS2tVFT4B4Lb7umF8Q3Lkh8VSNqjzwsjYGUZ1gw+uAUpKvwfgnx
         AWgPKnYc1Ra+f3jExbZhk6XwwIWRIyoMICAD73CkOfCSHPzaTfjJam+UWPwn+psQdXex
         C+ZlN5BYf+GQmHyGuhM3DOqz+BewRSIROe1YjdBbf9jTb+ATOmmuOlczyp5fLTSI8FwX
         obkw==
X-Gm-Message-State: AFqh2kqyBhS7WEgDwKqaQmviRBfJIqZQzKvaxEsmqqKsVeZ6t6Z8oh56
        vNmxaMAXMyz46mqmlQIIaHfHQLP8p4g=
X-Google-Smtp-Source: AMrXdXuoP4tWJRCjDDnzHP3wvep9Q/GJ9NuvjVnY66FPSm6Fpq7Y6VNtmlpN3PZds3g9xBNjQ4LIMw==
X-Received: by 2002:a05:6a21:6daa:b0:b5:bc9b:36e4 with SMTP id wl42-20020a056a216daa00b000b5bc9b36e4mr21193580pzb.13.1674260597246;
        Fri, 20 Jan 2023 16:23:17 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id d2-20020aa797a2000000b005895f9657ebsm21818621pfq.70.2023.01.20.16.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:23:16 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 09/12] selftests/bpf: Add dynptr pruning tests
Date:   Sat, 21 Jan 2023 05:52:38 +0530
Message-Id: <20230121002241.2113993-10-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
References: <20230121002241.2113993-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4291; i=memxor@gmail.com; h=from:subject; bh=KOeUuf38swlcblzdJeZUFs0p+ftuZYTeMeza4RnQIH4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAkYF+eUnuacr+8EXLHi1Ln5LCgo7dSC6XL0jKR Zsw+QEeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swJAAKCRBM4MiGSL8Rytw+EA C4V8XOEkDXC6UZ9/aMoySLuaZjfLGCwsgv590+hGBO2ZOsKKwQpuurDSHHBdI+g64RdIAFJ0EOjblj jSjxJEMuksGVFTC98gvFsh7tqne5fedHV0UimbGyPcTbZpbEqffyQw3xHOxf/wjNtcHHvAavJv7NIF hzYkImiuyFCgFzyt4W6856tq4Vq2jDEQ47YNCin7FI/2zyAy3z5htkAuObbtzwG5NbpFMGZ8MtNmEP Z+KZnqUTjk3FCj2tVr51KJyakkFVJKoUDuFgOUsnnnxNOQ3JCM7yjwgQzK16HXx3lcSmEZB+TW2e2o bj3NvBGHnZnWjsZiSRd1xZ9tftV7Jy2x7Oj5o+uEBXB4fXpGn3jegLlONyUGt5v8hn0vEnKTlsNQ+y Dwx99qrDPxIR6GAQbciv1Air3PNJaPwhZ1oCzy7a02+oLuD4HKavFAuvLLUdxXzC5w8AziO9rg9y/S 24JJTSWMIbeFqpxvYia6/auMs72F/jfFGwEEmCCTuCZ9M87lNSrPcuFfpft8aOFMOfctpJiyy5bsCJ HC6+D0mEo1jke5jpF6+bxhTfMg5GcOath119zFSRamkBLnKnlydRxbjYLHYXlJNJNoYLeA9nn8Hjw6 Y60J3o7UuyRmIQ3CN26eTJjgq1H4yQ2RwjYD1FKf+n6ckL0DwZ9ro3Jub5PQ==
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
index e43000c63c66..f1e047877279 100644
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
+		"r9 = 0xeB9F;				\
+		 r6 = %[ringbuf] ll;			\
+		 r1 = r6;				\
+		 r2 = 8;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -16;				\
+		 call %[bpf_ringbuf_reserve_dynptr];	\
+		 if r0 == 0 goto pjmp1;			\
+		 goto pjmp2;				\
+	pjmp1:						\
+		 *(u64 *)(r10 - 16) = r9;		\
+	pjmp2:						\
+		 r1 = r10;				\
+		 r1 += -16;				\
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
+
+SEC("?tc")
+__success __msg("12: safe") __log_level(2)
+int dynptr_pruning_stacksafe(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r9 = 0xeB9F;				\
+		 r6 = %[ringbuf] ll;			\
+		 r1 = r6;				\
+		 r2 = 8;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -16;				\
+		 call %[bpf_ringbuf_reserve_dynptr];	\
+		 if r0 == 0 goto stjmp1;		\
+		 goto stjmp2;				\
+	stjmp1:						\
+		 r9 = r9;				\
+	stjmp2:						\
+		 r1 = r10;				\
+		 r1 += -16;				\
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
+
+SEC("?tc")
+__failure __msg("cannot overwrite referenced dynptr") __log_level(2)
+int dynptr_pruning_type_confusion(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r6 = %[array_map4] ll;			\
+		 r7 = %[ringbuf] ll;			\
+		 r1 = r6;				\
+		 r2 = r10;				\
+		 r2 += -8;				\
+		 r9 = 0;				\
+		 *(u64 *)(r2 + 0) = r9;			\
+		 r3 = r10;				\
+		 r3 += -24;				\
+		 r9 = 0xeB9FeB9F;			\
+		 *(u64 *)(r10 - 16) = r9;		\
+		 *(u64 *)(r10 - 24) = r9;		\
+		 r9 = 0;				\
+		 r4 = 0;				\
+		 r8 = r2;				\
+		 call %[bpf_map_update_elem];		\
+		 r1 = r6;				\
+		 r2 = r8;				\
+		 call %[bpf_map_lookup_elem];		\
+		 if r0 != 0 goto tjmp1;			\
+		 exit;					\
+	tjmp1:						\
+		 r8 = r0;				\
+		 r1 = r7;				\
+		 r2 = 8;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -16;				\
+		 r0 = *(u64 *)(r0 + 0);			\
+		 call %[bpf_ringbuf_reserve_dynptr];	\
+		 if r0 == 0 goto tjmp2;			\
+		 r8 = r8;				\
+		 r8 = r8;				\
+		 r8 = r8;				\
+		 r8 = r8;				\
+		 r8 = r8;				\
+		 r8 = r8;				\
+		 r8 = r8;				\
+		 goto tjmp3;				\
+	tjmp2:						\
+		 *(u64 *)(r10 - 8) = r9;		\
+		 *(u64 *)(r10 - 16) = r9;		\
+		 r1 = r8;				\
+		 r1 += 8;				\
+		 r2 = 0;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -16;				\
+		 call %[bpf_dynptr_from_mem];		\
+	tjmp3:						\
+		 r1 = r10;				\
+		 r1 += -16;				\
+		 r2 = 0;				\
+		 call %[bpf_ringbuf_discard_dynptr];	"
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

