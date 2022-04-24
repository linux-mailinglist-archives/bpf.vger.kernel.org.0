Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B073C50D566
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiDXVwj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbiDXVwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C546C644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p12so1444575pfn.0
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rz5bIurls0xtUhIV87L2VXgJWuOFR5uNB2RSliytrA8=;
        b=p/dS7xSyOh2jzEpKE2JQCQyKpioYugp47DPb/0ovmburzcD7qzW1Pk2EDhSDzPFZVa
         cXHwTRWUx0XOroLpJvdYctZgYWUN+2QaQsawfJv1LBRyjDGVViIpIr6Vx9OEEkKpGksY
         JfA8ube1BpmroQEYUYFJkeeKHBQrMHx5RSHFxEtmvfW42QKYGEOuqxEXNFLXBfdQ2RFV
         r5fX0ygZFxRjW6Oo1agn2chimH2FM7LxGyQxoI3HzsfSRbd09HWPpa8cd4Kbkrh1kDQQ
         1z2+su5KZ9qLlcCL0scpufYh8nU2QkMnnmCTBp0V+4aS+dj1mrbLONUUDbzoGjyHNd2b
         beZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rz5bIurls0xtUhIV87L2VXgJWuOFR5uNB2RSliytrA8=;
        b=FHozBq2QYS+ekzuXsceF7F4VGrYiGgDa3sPxgpvB4Q+FvmqjI0hsa8RCOjJcl8/o+/
         mtJoZ1MGR3HxK0LZ9mxW5XiXSID84tzRK2kM/j+HchXuHkol5M+532vDzrO69Vgr72SL
         sbhfLepWjGNQuw20KDTFRvEyqvWPzYMdvh+BV9JG2Z5Y2TZGU4hiAUbQb8HNk4XOjQ+N
         l+QFvPdlIfSdA3wD21YwtEwQuNBQDDz2FE51A0LmM0DN2YH03hT6Bkxo1g8dYcxcLL1a
         u7AoSkxmo3DYhJX7gHXjTBLfr6y+CYmPUQep/PXUgyzn7oSq/pY6uUxDk9WhxFqyQUtV
         vrdw==
X-Gm-Message-State: AOAM533DWunli/+U8JQabtokXfDhoIatlIyZ20Cq4isHcrRZn8bAWW5Q
        nsCJgsQ4hqRB909bDGTZi7epyVjobQ8=
X-Google-Smtp-Source: ABdhPJwSSdFmqXbWO7ix/f9SD7G6NXSf0BtNqYAbGOKsEpIYnEQ3fBDyX8DpprU3WJLHzSUzVjpMIw==
X-Received: by 2002:a05:6a00:198c:b0:505:c18b:3184 with SMTP id d12-20020a056a00198c00b00505c18b3184mr15493719pfl.82.1650836972216;
        Sun, 24 Apr 2022 14:49:32 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090a8c9400b001cd4989fec4sm12548220pjo.16.2022.04.24.14.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:49:32 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 13/13] selftests/bpf: Add test for strict BTF type check
Date:   Mon, 25 Apr 2022 03:19:01 +0530
Message-Id: <20220424214901.2743946-14-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3809; h=from:subject; bh=KOuszMLHUcYTOqQidYO3FSNdHcvqpfFX3CSjPBqDbTA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTLekpYRdK/TVhCMvQnPg6k2ST+Hg19+8WIwiNw 073Re+mJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEywAKCRBM4MiGSL8RyraMD/ sFzQLiO5H0vV2vlzGd3M+/5Pr4CqSD6u0M5Qjht2tbDClO/XpMivuZA6BkAtk8p0SIw+JWpXM3UnKr WAADZgAD0M0qQGH3mijJkHKQCUZa6ArvH7YMO3h+maU4GXkegLC6+eOs1Kz97yFEfp5gQm/AnLR+2D uvIn1ieMDDn/9StnmmEEibpBfmRJeJ6kxny8Auu0ZEhJfpQVWuz/E+DOE9JApMjN08CrTxPSk+N0T3 2QTQP6NRmuAmiz/lUPMFsxw/o3T6jVdmISxG2T7gZPW37h7l+YQVGdDBxb1u6DVXqIyXRf9icqD2rK iT/vcjf7FmEeKFLi8UgrPuZGVJTaOQVXFJwJ8bTyf43emqHUczszuYz2vDbveDbcqBZxs3XLdzgwCd yWc8J51TUqglJUlLqTRsQJGtqiFg3raAyPT68rzx+OBmuVFBR0EdqMr5JqQwLFoTf4S228RD+L8yAN VmYAte5d9W/fi1zshUdE2N17/mdnRsrh8rSHAtvS/wcqsBZuOt4uLFVH5agnTveLyQAIyAJAAC6Gew YOfzXBj74rm7zIyi/j4LcGplFqJrJjLZgVkU4kclOh0D8h/YczG+HNPuc7INGkYAsTWTA6i1DVfHR6 H0M5YJ+P/4OjQw1Uv7CLqG1kmP0fx1TvKVUrplF/FzljQ+Il/jzpxHs8veMg==
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

Ensure that the edge case where first member type was matched
successfully even if it didn't match BTF type of register is caught and
rejected by the verifier.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c                           | 22 +++++++++++++++++++-
 tools/testing/selftests/bpf/verifier/calls.c | 20 ++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 29fe32821e7e..7a1579c91432 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -550,8 +550,13 @@ struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
 	return sk;
 }
 
+struct prog_test_member1 {
+	int a;
+};
+
 struct prog_test_member {
-	u64 c;
+	struct prog_test_member1 m;
+	int c;
 };
 
 struct prog_test_ref_kfunc {
@@ -576,6 +581,12 @@ bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
 	return &prog_test_struct;
 }
 
+noinline struct prog_test_member *
+bpf_kfunc_call_memb_acquire(void)
+{
+	return &prog_test_struct.memb;
+}
+
 noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
 }
@@ -584,6 +595,10 @@ noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
 {
 }
 
+noinline void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
+{
+}
+
 noinline struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b)
 {
@@ -673,8 +688,10 @@ BTF_ID(func, bpf_kfunc_call_test1)
 BTF_ID(func, bpf_kfunc_call_test2)
 BTF_ID(func, bpf_kfunc_call_test3)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
+BTF_ID(func, bpf_kfunc_call_memb_acquire)
 BTF_ID(func, bpf_kfunc_call_test_release)
 BTF_ID(func, bpf_kfunc_call_memb_release)
+BTF_ID(func, bpf_kfunc_call_memb1_release)
 BTF_ID(func, bpf_kfunc_call_test_kptr_get)
 BTF_ID(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID(func, bpf_kfunc_call_test_pass1)
@@ -689,16 +706,19 @@ BTF_SET_END(test_sk_check_kfunc_ids)
 
 BTF_SET_START(test_sk_acquire_kfunc_ids)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
+BTF_ID(func, bpf_kfunc_call_memb_acquire)
 BTF_ID(func, bpf_kfunc_call_test_kptr_get)
 BTF_SET_END(test_sk_acquire_kfunc_ids)
 
 BTF_SET_START(test_sk_release_kfunc_ids)
 BTF_ID(func, bpf_kfunc_call_test_release)
 BTF_ID(func, bpf_kfunc_call_memb_release)
+BTF_ID(func, bpf_kfunc_call_memb1_release)
 BTF_SET_END(test_sk_release_kfunc_ids)
 
 BTF_SET_START(test_sk_ret_null_kfunc_ids)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
+BTF_ID(func, bpf_kfunc_call_memb_acquire)
 BTF_ID(func, bpf_kfunc_call_test_kptr_get)
 BTF_SET_END(test_sk_ret_null_kfunc_ids)
 
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 2e03decb11b6..743ed34c1238 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -138,6 +138,26 @@
 		{ "bpf_kfunc_call_memb_release", 8 },
 	},
 },
+{
+	"calls: invalid kfunc call: don't match first member type when passed to release kfunc",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = REJECT,
+	.errstr = "kernel function bpf_kfunc_call_memb1_release args#0 expected pointer",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_memb_acquire", 1 },
+		{ "bpf_kfunc_call_memb1_release", 5 },
+	},
+},
 {
 	"calls: invalid kfunc call: PTR_TO_BTF_ID with negative offset",
 	.insns = {
-- 
2.35.1

