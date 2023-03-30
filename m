Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF856D08B7
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 16:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjC3OwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjC3OwK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 10:52:10 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6C91FE8;
        Thu, 30 Mar 2023 07:52:09 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id o44so14203242qvo.4;
        Thu, 30 Mar 2023 07:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187928; x=1682779928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hN4YpD3U3sRZPulOttvL6oVrqEryb/pVBJ8w7pJKAg=;
        b=EXnDaT/dFZV4LQ+PtQX1xCezzJhjEcJwUwekjb4T1czTVuhXPdqe4vSK4KW2huj94p
         Wt7AHOKXHOFQfaVD3SVSHf1fuOFa04BrcSK6lOpeWmexQWPd3kQLFc2l1HDqsVOrWnNb
         /ct72PYixjUeQusyU2iuucWj4aOXv7pkLxYTj13mJNzdn+lXASD6f+B23hvI3ZNz5YbM
         oWP7eAp4QUufHQrc3pdf4Edbr7LsA5KtSQxs/MQ5EYlTga8DSKHUeEHHONrTHeUYJAH3
         uQ2H8MYz3GdKgc35oNpCo5jb60I3Pbd1H4BNSVAghM3PbPLDfrAlePaUp4tKU5DLHa5a
         hBUg==
X-Gm-Message-State: AAQBX9flgsZuhueeepe8w7Wf7QXmTEIJ8+WVtSHTL9xB9N/kBy5+anW1
        6FGa/V0/oryxztcX8uOd3jipAfyTL6aNx9CK
X-Google-Smtp-Source: AKy350bUImW3YQRiXc0ZivxPhjvV5wcP7dHaEwn3ZVeNgZicsadVYsu3ifvTiFEubWvYRRW3EUJdSA==
X-Received: by 2002:a05:6214:f22:b0:5df:5167:c420 with SMTP id iw2-20020a0562140f2200b005df5167c420mr11051724qvb.38.1680187928464;
        Thu, 30 Mar 2023 07:52:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d9ee])
        by smtp.gmail.com with ESMTPSA id dm4-20020ad44e24000000b005dd8b934569sm5530533qvb.1.2023.03.30.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:52:08 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add testcases for ptr_*_or_null_ in bpf_kptr_xchg
Date:   Thu, 30 Mar 2023 09:52:03 -0500
Message-Id: <20230330145203.80506-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230330145203.80506-1-void@manifault.com>
References: <20230330145203.80506-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The second argument of the bpf_kptr_xchg() helper function is
ARG_PTR_TO_BTF_ID_OR_NULL. A recent patch fixed a bug whereby the
verifier would fail with an internal error message if a program invoked
the helper with a PTR_TO_BTF_ID | PTR_MAYBE_NULL register. This testcase
adds some testcases to ensure that it fails gracefully moving forward.

Before the fix, these testcases would have failed an error resembling
the following:

; p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
99: (7b) *(u64 *)(r10 -16) = r7       ; frame1: ...
100: (bf) r1 = r10                    ; frame1: ...
101: (07) r1 += -16                   ; frame1: ...
; p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
102: (85) call bpf_kfunc_call_test_acquire#13908
; frame1: R0_w=ptr_or_null_prog_test_ref_kfunc...
; p = bpf_kptr_xchg(&v->ref_ptr, p);
103: (bf) r1 = r6                     ; frame1: ...
104: (bf) r2 = r0
; frame1: R0_w=ptr_or_null_prog_test_ref_kfunc...
105: (85) call bpf_kptr_xchg#194
verifier internal error: invalid PTR_TO_BTF_ID register for type match

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/progs/cpumask_failure.c     | 25 +++++++++++++++++++
 .../selftests/bpf/progs/map_kptr_fail.c       | 23 +++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index db4f94e72b61..a9bf6ea336cf 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -165,3 +165,28 @@ int BPF_PROG(test_global_mask_no_null_check, struct task_struct *task, u64 clone
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__failure __msg("Possibly NULL pointer passed to helper arg2")
+int BPF_PROG(test_global_mask_rcu_no_null_check, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *prev, *curr;
+
+	curr = bpf_cpumask_create();
+	if (!curr)
+		return 0;
+
+	prev = bpf_kptr_xchg(&global_mask, curr);
+	if (prev)
+		bpf_cpumask_release(prev);
+
+	bpf_rcu_read_lock();
+	curr = global_mask;
+	/* PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_RCU passed to bpf_kptr_xchg() */
+	prev = bpf_kptr_xchg(&global_mask, curr);
+	bpf_rcu_read_unlock();
+	if (prev)
+		bpf_cpumask_release(prev);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 08f9ec18c345..15bf3127dba3 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -20,6 +20,7 @@ struct array_map {
 } array_map SEC(".maps");
 
 extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
+extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 extern struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
 
@@ -442,4 +443,26 @@ int kptr_get_ref_state(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to helper arg2")
+int kptr_xchg_possibly_null(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 0;
+
+	p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+
+	/* PTR_TO_BTF_ID | PTR_MAYBE_NULL passed to bpf_kptr_xchg() */
+	p = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (p)
+		bpf_kfunc_call_test_release(p);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.39.0

