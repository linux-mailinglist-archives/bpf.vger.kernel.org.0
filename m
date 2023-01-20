Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11D674DAD
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjATHEe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjATHEe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:34 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195911659
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:32 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id c6so4588614pls.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjuxCRFRYw9wjpCtAG75vdMCkmNxJZQw7fQxwyidGTs=;
        b=lNhqDH3VpR66ivmIRjRVaUyTZ7UbJVf4xGwfH+EfeAoEmJHgJepscRzis2T6zi/V95
         2hgkFQHjlaMxGriJpaGM3i5K4ko7j2AonndnodjijbXdHzmqA6IVPur+4PfCdlr1F2Ng
         59YWMVmyW9H0wn7s1rFKq6QATCrwmXiIjLz4rs2im60Ku35jccTNujFxphMTfUp5esKi
         YNmUPLvhgmwTDpjDO/iRph2z3yDMaXPehQby9aPi1mQhTcb9DXJDBQSUmOmWt3bhng8T
         It8IlLqQzvAhUqfp142KFKhzAS/kaMo36oaQpTZTlHaHLKZt82BHfUglMABgrUd9Kgw2
         Uw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjuxCRFRYw9wjpCtAG75vdMCkmNxJZQw7fQxwyidGTs=;
        b=z+ueeLnl5xuL2BJHmxXgUXMWvBHb61takgHu8AawKIaZWv50RAS9/+AJaY4tLBh8e8
         gw4nW+C/b+9J/IPA6MK1AgskHx8PGRREqH/WP8lr6ilVtEUpyEglofRbO+pe3RDK1OMr
         74qz++XrhTAifV0vzWBc/jaPqV9pUqy4OkSBoNt+INdIbkLSUgHNrMxX4HcdrJ5NaFZW
         KLXFy/23laXwFAd058Dt9ekOKLIYekGZt1gRaR19sWvNcim8EtX+lzxe48lHQW+MPynz
         NcMDN0vJtDTv/muEyF7WFaGj+AmHSB8tL65RhI4+uxLvb2/hLgdPaxojO4uiFqUzMjS8
         UoBg==
X-Gm-Message-State: AFqh2krQSzjpSz1QCJjH9SKSvX71wopChSWwCRaziRseh9CNoD6tK+1j
        rmgM8P2XnJefdreWUKtMN/AqwqB17E8=
X-Google-Smtp-Source: AMrXdXt8UOvGMcbmx4T2sV5pvAx989xZk5KdwQ8c5EDEJYEpvvpmRA/mkrd3ceIowBOBAvLirPVMXw==
X-Received: by 2002:a17:902:f708:b0:189:c4a9:c5e8 with SMTP id h8-20020a170902f70800b00189c4a9c5e8mr15749750plo.45.1674198272060;
        Thu, 19 Jan 2023 23:04:32 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903028300b001886ff822ffsm2742638plr.186.2023.01.19.23.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:04:31 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 09/12] selftests/bpf: Add dynptr pruning tests
Date:   Fri, 20 Jan 2023 12:33:52 +0530
Message-Id: <20230120070355.1983560-10-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120070355.1983560-1-memxor@gmail.com>
References: <20230120070355.1983560-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4291; i=memxor@gmail.com; h=from:subject; bh=KOeUuf38swlcblzdJeZUFs0p+ftuZYTeMeza4RnQIH4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzLYF+eUnuacr+8EXLHi1Ln5LCgo7dSC6XL0jKR Zsw+QEeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8ywAKCRBM4MiGSL8RyrkGEA CHqvPg2zQBvDGw9ffYTjQhkNXCmYtjSW+HDyqJhp2j96dht14hJe0TkbSedFTrPfnTzp79NCw+qfDf PABGC0w/ec++6Lwt/i6Hg9Bms7/AxI/QXfHjvaHZqWIS+DGc+VzUMkkhv8AXzcvMKPxLSVy/ihWWPS 3YFFRMfaKJlRbWg+z60Rmo6M5TsnJ8KwXPcTI2kFr4qiJ5Ni0I20EmXG6a+ahj82YrBC1rPHRDENtt IpljnJRm2SpaH+rCziwTnIPgs3Q6w5A0PMLvdbBafFHAxmbdFOktwbGr9/XekGb81OQtWlpFmBMK7p VA34wSn6fgimFnWhsvqPT4IQ7SmQrrM8hcWNeDylecqq0oU/DMqetwh8ResOONbWHtdymsk2S6rzCo ZsTtpWyVAjZlr7T0w9X1eZ/H2BRG7thsb5DcQGi/FXcSCb++ILwO/lFFA+kdXgY9Z2n404r7OCPTJJ 84Zk0y5tDpgXPx26pSqWa8GvxhVdl53bQ72rbbJEw9R7B3salnbeixWSnvFCOb35Do1bJ494+VXuGC CMIW2ZY7BZpnxuIGw9pP9Lx2ymcCB283nFkkc2gnxFEnIJCVrqyDve3SW4JeW4pYACHxMePT39VEUX phtfzbtFsu9XitKjIus3dogeQrh9IuZ16I0rPWLcUzW8EI+UWGi1fVg2IJbQ==
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

