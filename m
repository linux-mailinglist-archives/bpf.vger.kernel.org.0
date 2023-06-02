Return-Path: <bpf+bounces-1707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF87720548
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 17:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6EB28188B
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14F19BDE;
	Fri,  2 Jun 2023 15:01:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9219BA4
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 15:01:34 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0E41BF;
	Fri,  2 Jun 2023 08:01:32 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-75b1219506fso205423685a.1;
        Fri, 02 Jun 2023 08:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718092; x=1688310092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TGABugmQnE6LIWqoZGkKSicCR6YXrglbRXwLxPQ5E8=;
        b=HKEPr3NPtuFMBir9TshfNWmjvjMejPToOvCGIdHqVNG7y+aMv3MxPKE6npVwoSQhkq
         O011cDGwpRRwBVLwz/qBOpHA+tcNxuQR74rEmguCJjqZAtw4X0uOSweJ1XoOzDFhqIjx
         629QzXc+ZlUwJP9lFW7d5WT3XMNztZ3sSmYCn/0BvyTYwFOLiFPSVDa8zyuFeoE4qBjl
         de0VqcPqYhGzq4X7/x2DmA51vDubtQ/OhdC9id3YbDRvDKBN0R1kHD/M4pVt4EqAZzZx
         0jq1ir6R3sBninkjoo0IZ6JKYChTD2AVXcarGCv17LeW9HWk0gSS+RN344kSz1CcFndV
         5W4Q==
X-Gm-Message-State: AC+VfDy9v1OpglNH0r6zFO5eV0XiNVZttwcoD0Ok/6ehbGAyMIyiMJBH
	mT6FTkc10odMhP15WPfmwTsBibiFRdjnhfK6
X-Google-Smtp-Source: ACHHUZ5O1qWRb+mtRidMulQV7vXZYYAfPhS6h/tHT0va9SCDDC46jwbN1tZJz6l49qc8j2XyHGQjnA==
X-Received: by 2002:ad4:5aa6:0:b0:629:78ae:80f0 with SMTP id u6-20020ad45aa6000000b0062978ae80f0mr1646956qvg.8.1685718091566;
        Fri, 02 Jun 2023 08:01:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:1317])
        by smtp.gmail.com with ESMTPSA id mn14-20020a0562145ece00b006235e8fe94esm926945qvb.58.2023.06.02.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:01:31 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Teach verifier that trusted PTR_TO_BTF_ID pointers are non-NULL
Date: Fri,  2 Jun 2023 10:01:11 -0500
Message-Id: <20230602150112.1494194-1-void@manifault.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In reg_type_not_null(), we currently assume that a pointer may be NULL
if it has the PTR_MAYBE_NULL modifier, or if it doesn't belong to one of
several base type of pointers that are never NULL-able. For example,
PTR_TO_CTX, PTR_TO_MAP_VALUE, etc.

It turns out that in some cases, PTR_TO_BTF_ID can never be NULL as
well, though we currently don't specify it. For example, if you had the
following program:

SEC("tc")
long example_refcnt_fail(void *ctx)
{
	struct bpf_cpumask *mask1, *mask2;

	mask1 = bpf_cpumask_create();
	mask2 = bpf_cpumask_create();

        if (!mask1 || !mask2)
		goto error_release;

	bpf_cpumask_test_cpu(0, (const struct cpumask *)mask1);
	bpf_cpumask_test_cpu(0, (const struct cpumask *)mask2);

error_release:
	if (mask1)
		bpf_cpumask_release(mask1);
	if (mask2)
		bpf_cpumask_release(mask2);
	return ret;
}

The verifier will incorrectly fail to load the program, thinking
(unintuitively) that we have a possibly-unreleased reference if the mask
is NULL, because we (correctly) don't issue a bpf_cpumask_release() on
the NULL path.

The reason the verifier gets confused is due to the fact that we don't
explicitly tell the verifier that trusted PTR_TO_BTF_ID pointers can
never be NULL. Basically, if we successfully get past the if check
(meaning both pointers go from ptr_or_null_bpf_cpumask to
ptr_bpf_cpumask), the verifier will correctly assume that the references
need to be dropped on any possible branch that leads to program exit.
However, it will _incorrectly_ think that the ptr == NULL branch is
possible, and will erroneously detect it as a branch on which we failed
to drop the reference.

The solution is of course to teach the verifier that trusted
PTR_TO_BTF_ID pointers can never be NULL, so that it doesn't incorrectly
think it's possible for the reference to be present on the ptr == NULL
branch.

A follow-on patch will add a selftest that verifies this behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 086b2a14905b..63187ba223d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -197,6 +197,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
 static void specialize_kfunc(struct bpf_verifier_env *env,
 			     u32 func_id, u16 offset, unsigned long *addr);
+static bool is_trusted_reg(const struct bpf_reg_state *reg);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -439,8 +440,11 @@ static bool type_may_be_null(u32 type)
 	return type & PTR_MAYBE_NULL;
 }
 
-static bool reg_type_not_null(enum bpf_reg_type type)
+static bool reg_not_null(const struct bpf_reg_state *reg)
 {
+	enum bpf_reg_type type;
+
+	type = reg->type;
 	if (type_may_be_null(type))
 		return false;
 
@@ -450,6 +454,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 		type == PTR_TO_MAP_VALUE ||
 		type == PTR_TO_MAP_KEY ||
 		type == PTR_TO_SOCK_COMMON ||
+		(type == PTR_TO_BTF_ID && is_trusted_reg(reg)) ||
 		type == PTR_TO_MEM;
 }
 
@@ -13157,7 +13162,7 @@ static int is_branch_taken(struct bpf_reg_state *reg, u64 val, u8 opcode,
 			   bool is_jmp32)
 {
 	if (__is_pointer_value(false, reg)) {
-		if (!reg_type_not_null(reg->type))
+		if (!reg_not_null(reg))
 			return -1;
 
 		/* If pointer is valid tests against zero will fail so we can
-- 
2.40.1


