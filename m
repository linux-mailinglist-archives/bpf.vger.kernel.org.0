Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F289D523DCC
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347111AbiEKTqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347107AbiEKTqa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 15:46:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF2220F0
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c9so2891115plh.2
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkAI7EBC2WFITWcPxHieF1XhuP13EXPy5ATL0i97aVM=;
        b=q8EzR5ibFC1Nabm7LCDpE3CiV5hcJVXcs2B+cbLetami1IYisnCEfc5YBYXcgqHVMk
         edV+KF3MQgusqdYx4K23QsXsqA1j6sq7gkzKQkufZ4Sdh3qKl0i9vo7YH1F/QWXhQ3O+
         tWYxeEb8l7tQU9b3bFOAkI2CBD5LjFqp41WIKo4Oj0mBAcU5eSLH/24It0hu4UUdd7K8
         Amf2AYhNHJcfq1DLCzTkbOv0dEdyje5KRyb7guXeTMF1UjWDCVNFEFzv15p6rIeGT2+c
         t9iBqqLxFjRxKaVaaZSoKo4TDjmmt2DS59s/4McmqVTA3M7tmdgPka8H8eKHDh1voP2I
         IS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkAI7EBC2WFITWcPxHieF1XhuP13EXPy5ATL0i97aVM=;
        b=UP1/6uOjyJ1ZHA+0MViQliqn1ivvtpG8fzvY0z3AwK2km+KDPVIs275ZAy/A1mCfPg
         0tRbD0m4Lb0Jc1WbAQHC1jWltPDkN68N61g4eX5vj03EpepP3H7FJw/9AjKg/74AYE5q
         zQO9ev23Uamgr6mOlMVYSEBnpxHeTX5sUgNc1+6fpRTEaDHZbd7TDBwELT88YY6qo22u
         LpZsnVtrz+C9NGC/Fmcn8awurT4tniy/iKEVV4D/AQlgnl7bzfj5f9bx6gGxlnAd2d9K
         E63z2AI8b43prCfSkPmw+i6O31qkYZ8ZZcAvyQ2c78yfaexeXIaIKG/SXw5eCbyjvV1a
         94Ew==
X-Gm-Message-State: AOAM530AwT/6qep9l4Eu8BDtZpiG1fOd8tqrr4BzXWQLsXF939aEcyGQ
        1kVyc+B/14DGMVa3Fa5FXYZ7YpH8F3g=
X-Google-Smtp-Source: ABdhPJzf23RIKSYEzzi4O8W80GJcrdwLEkyIWFTICoDSfhH1ZH/mtn4/whonp3LdrhO8/ksCY7Kr6Q==
X-Received: by 2002:a17:90b:17c4:b0:1de:c92c:ad91 with SMTP id me4-20020a17090b17c400b001dec92cad91mr4060169pjb.169.1652298388435;
        Wed, 11 May 2022 12:46:28 -0700 (PDT)
Received: from localhost ([112.79.166.171])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b0015eaa9797e8sm2304610plh.172.2022.05.11.12.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:46:27 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 2/4] bpf: Prepare prog_test_struct kfuncs for runtime tests
Date:   Thu, 12 May 2022 01:16:52 +0530
Message-Id: <20220511194654.765705-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511194654.765705-1-memxor@gmail.com>
References: <20220511194654.765705-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3436; h=from:subject; bh=jbz+FLFLpa3p/Ez5ZgnAplp3wiPvNSvHkiTqHm5YhzU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBifBG6JOuaS/taEP8Xb6bIBDiB6DQr2X0Xd8sTm71o +mgslMuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnwRugAKCRBM4MiGSL8RyuMUD/ 9OKWJED7y2OZgsBHT/WjUmKlre5PFqxZuHj8hWdTWlrHPFJjpggrCQVXqRu3q7omYqFaIn57RwbRXt kuYAeByWIYMcDpYKPKo/ACBqal8nWjV/86xSWPk86jGLmclz/4Io3e1G89xQzrUQRMylNkH36vARh0 WfczCHTAV9NN6JkNuWjo7msnb09LBnIvjsIoN3gzh6x9gQPco7ztrOtZhK6/A7Y5kgNq5d3tpopXtL mGkHkGTC/0b1+AmKMY3O2scGq8EXh/bzmf2LDGKzvSH+9NljcXaqUKBAMHOW9okcnXXh3Ix27yVvYH +1lnvMiu77QO1ZdLzmGjL/SQ5ZROGLlMEhC5uNz5TKoseVpht/SadEAOZ0+QliCn0elfq4upIKHfjF CVwZsuzColD6qg/OkTYaoix0eP0qEhlueaOAs4FA/rAB+zg8w2NLGEFmM+yBeFUSd1+p16UNKnNZBc c/7LWAG1GlwQF8He427StT7rzx/XleTdr69OvB7CT9lRBrnxs52/Y/mOQVZz9aQOAtDHoGRN5LHRih OMJ8z8Ax82rzouldpH49Fau6n7Spc2EYWkdykstvdN2lyd3scmBDEkVLUVOdVPBe5j+yIVUlDj27gE qEXMnsnqbb6V5Fsw6G90rtzDxJi9Bu/NiEkkYMurkXianO+guOlYfFSdr/xg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In an effort to actually test the refcounting logic at runtime, add a
refcount_t member to prog_test_ref_kfunc and use it in selftests to
verify and test the whole logic more exhaustively.

The kfunc calls for prog_test_member do not require runtime refcounting,
as they are only used for verifier selftests, not during runtime
execution. Hence, their implementation now has a WARN_ON_ONCE as it is
not meant to be reachable code at runtime. It is strictly used in tests
triggering failure cases in the verifier. bpf_kfunc_call_memb_release is
called from map free path, since prog_test_member is embedded in map
value for some verifier tests, so we skip WARN_ON_ONCE for it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c                            | 23 ++++++++++++++-----
 .../testing/selftests/bpf/verifier/map_kptr.c |  4 ++--
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 7a1579c91432..4d08cca771c7 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -564,31 +564,36 @@ struct prog_test_ref_kfunc {
 	int b;
 	struct prog_test_member memb;
 	struct prog_test_ref_kfunc *next;
+	refcount_t cnt;
 };
 
 static struct prog_test_ref_kfunc prog_test_struct = {
 	.a = 42,
 	.b = 108,
 	.next = &prog_test_struct,
+	.cnt = REFCOUNT_INIT(1),
 };
 
 noinline struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
 {
-	/* randomly return NULL */
-	if (get_jiffies_64() % 2)
-		return NULL;
+	refcount_inc(&prog_test_struct.cnt);
 	return &prog_test_struct;
 }
 
 noinline struct prog_test_member *
 bpf_kfunc_call_memb_acquire(void)
 {
-	return &prog_test_struct.memb;
+	WARN_ON_ONCE(1);
+	return NULL;
 }
 
 noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
+	if (!p)
+		return;
+
+	refcount_dec(&p->cnt);
 }
 
 noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
@@ -597,12 +602,18 @@ noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
 
 noinline void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
 {
+	WARN_ON_ONCE(1);
 }
 
 noinline struct prog_test_ref_kfunc *
-bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b)
+bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b)
 {
-	return &prog_test_struct;
+	struct prog_test_ref_kfunc *p = READ_ONCE(*pp);
+
+	if (!p)
+		return NULL;
+	refcount_inc(&p->cnt);
+	return p;
 }
 
 struct prog_test_pass1 {
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index 9113834640e6..6914904344c0 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -212,13 +212,13 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 24),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 32),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr = { 1 },
 	.result = REJECT,
-	.errstr = "access beyond struct prog_test_ref_kfunc at off 24 size 8",
+	.errstr = "access beyond struct prog_test_ref_kfunc at off 32 size 8",
 },
 {
 	"map_kptr: unref: inherit PTR_UNTRUSTED on struct walk",
-- 
2.35.1

