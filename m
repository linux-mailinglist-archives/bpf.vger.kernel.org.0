Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F55522633
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiEJVRG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiEJVRF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 17:17:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445250B32
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:17:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 204so246397pfx.3
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Od+8+5qrLv31b3bCTXJVc/Ru1OFN/Z502O/QlAcuMYk=;
        b=eMAP7MEx9C3MtP/5sLx2ZVJEbG7OvettP3G9nbhaJuN9CXV/tuogx1L5V1fnqTlkoh
         3WpgJ9lTtzc48PIZuvOEDj0OYqHKxVCczjsumTLRf+yq7JXWBhF1IkcgAjdB9z9cEXrc
         WYcYMIrt3GQnnBb2UC0visALB7ef18ZHO9T7JVPacjBZjnf1kAHydQRP/nTe0ZiGlPSU
         I5G+2o83WYHq9qKvrIHyPynfd3aQu/XpNKYGKIBAlonSkDgIcm4UYi4DuTkcFBBs1brU
         Kg4inyt9GyGY7CW7WiQVj4AJ7LFlJn2TxQT5YEYjl3/eNMinV4nkmZm0yTxA2cjWXSRw
         mkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Od+8+5qrLv31b3bCTXJVc/Ru1OFN/Z502O/QlAcuMYk=;
        b=uzBNftalvbwdkUnMdh156ZYo7v2YIkoYPqJkTaYKhBzXC+/NSTxCQQ0XJRnzvxYX9h
         MYbByzCqynKBqBlleQYcfoeY0Q0PO2oEFdxKqlRA9yE9/blYmNPcC6/drGFgmtmfsqaG
         N6fnGpnOPfKtO8h7QoKQUUPA+qeXwEHbhrODkX02mV9Irbh3IowClaONTCXekY4zOA8v
         QBdK1o84FnP2B7Mf9zOxOOFTk8fIIBoHxhah8uKvvGdKRNSB5pnkQwvtkfruQE40kSfW
         VTr/wGBEVzjaK0jQyP3wQkF+1tG+kvxSVPNEjXzjjRqxCc0rWfiOj3Fpa9lSmVQZ8QrV
         Qfxg==
X-Gm-Message-State: AOAM532EyfEqgig5/vkOgfh7fj60XMx0C350+SBcUTGVFevXh4vpxHDG
        54ZNo4I388wWv3jHLKRQz6GK0MzbMD0=
X-Google-Smtp-Source: ABdhPJzGytOBZ5Y+/liHcjzYW0KKr1pVukOhAT+mSrEVN5zNHbvr18MgRqEVEeW5eqj0OaoC16jdIQ==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr22396719pfm.3.1652217424145;
        Tue, 10 May 2022 14:17:04 -0700 (PDT)
Received: from localhost ([112.79.164.242])
        by smtp.gmail.com with ESMTPSA id lr10-20020a17090b4b8a00b001d2edf4b513sm110536pjb.56.2022.05.10.14.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 14:17:03 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 2/4] bpf: Prepare prog_test_struct kfuncs for runtime tests
Date:   Wed, 11 May 2022 02:47:25 +0530
Message-Id: <20220510211727.575686-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510211727.575686-1-memxor@gmail.com>
References: <20220510211727.575686-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4360; h=from:subject; bh=FlqxSsldJRXBIDPn2j3X1oEUW4HbrYyUJQq697bI0+g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBietZjO7rWrM0eccrUGh4dplZ8f5LrG8/mWNaheskD b5rcwSeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnrWYwAKCRBM4MiGSL8RyqPYD/ 9X1VqMi4xHtI3E+EGeFasQ5WQ5Sx2ORTVG00qWLqxPf1cKc8LRTjr76t1+N6NcWGaq9PyA6uvg0QTO zs1AZH9IgB/Lynht5jhW05Ex5m2gc/tQc68keMVMaKdCEwoJVwXRNFQawgSFAVsOhmCrAL8/L42Lta SI7tMFWSX8BiSkxLzEObBEk0rb2XN6NGZ0PzLLy2fmc8vSRdNj8J4Ap7BP7BWAJU1sg/Zp+TknSnNX IjBmWObu+ygkevKBJsnJg549MaWUKQvF/CDvVkUPHySOwHP06Hi7h1WSmvl5Tjw4rjEA3h/EnieVh6 5DjMfONbtJBulU+Un1TN7I8d71jkKk+lXUKPX1qI2jngEyUasieCM4pd8ih/aErmd0TcCS0T63h1K+ uXFi0WGQhpRr6eJjclHd9GVt4d9nEdoURWq4pREWR04Ne2D1Tjf8IeHxAWXKaTfSp1K806gQL8AgoC JTPQwqJb74ND8h0b9Kc+9f6bztWP6gGEwIL7syaavlaE4jv2MPD95GhLnsVsBBoV27Uda/Lg2Y3ZgZ 4Yk3MoDNK4bG/Zu6PpuxAbLyKfAuROqzXoX0OwAGhPYFx7YXG4qzE4D0WqSM83gOl3pNbKJ79/VD9T fXCFUeFrkIiZcXzHfGFaoKrDl5XjZ4qlwnDeI2f52ZhSoIupp0m1WxX5h7Hw==
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

To ensure reading the count to verify it remains stable, make
prog_test_ref_kfunc a per-CPU variable, so that inside a BPF program the
count can be read reliably based on number of acquisitions made. Then,
pairing them with releases and reading from the global per-CPU variable
will allow verifying whether release operations put the refcount.

We don't actually rely on preemption being disabled, but migration must
be disabled, as BPF program is the only context where these acquire and
release functions are called. As such, when an object is acquired on one
CPU, only that CPU should manipulate its refcount. Likewise, for
bpf_this_cpu_ptr, the returned pointer and acquired pointer must match,
so that refcount can actually be read and verified.

The kfunc calls for prog_test_member do not require runtime refcounting,
as they are only used for verifier selftests, not during runtime
execution. Hence, their implementation now has a WARN_ON_ONCE as it is
not meant to be reachable code at runtime. It is strictly used in tests
triggering failure cases in the verifier. bpf_kfunc_call_memb_release is
called from map free path, since prog_test_member is embedded in map
value for some verifier tests, so we skip WARN_ON_ONCE for it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c                            | 32 +++++++++++++------
 .../testing/selftests/bpf/verifier/map_kptr.c |  4 +--
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 7a1579c91432..16d489b03000 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -564,31 +564,39 @@ struct prog_test_ref_kfunc {
 	int b;
 	struct prog_test_member memb;
 	struct prog_test_ref_kfunc *next;
+	refcount_t cnt;
 };
 
-static struct prog_test_ref_kfunc prog_test_struct = {
+DEFINE_PER_CPU(struct prog_test_ref_kfunc, prog_test_struct) = {
 	.a = 42,
 	.b = 108,
-	.next = &prog_test_struct,
+	.cnt = REFCOUNT_INIT(1),
 };
 
 noinline struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
 {
-	/* randomly return NULL */
-	if (get_jiffies_64() % 2)
-		return NULL;
-	return &prog_test_struct;
+	struct prog_test_ref_kfunc *p;
+
+	p = this_cpu_ptr(&prog_test_struct);
+	p->next = p;
+	refcount_inc(&p->cnt);
+	return p;
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
@@ -597,12 +605,18 @@ noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
 
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

