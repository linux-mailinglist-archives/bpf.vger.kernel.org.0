Return-Path: <bpf+bounces-3491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE21D73ECD3
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D749280DFF
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1A01548D;
	Mon, 26 Jun 2023 21:25:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2B15482
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:25:28 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831B6BD
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 14:25:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ff7b4feefso36790657b3.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687814726; x=1690406726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBq5r9rUXv4nLbCqvM8Gbq0XZla6rgmx2guuqNDvDxs=;
        b=FAll9s8NMTKhe17Mk72o7POiz4QqhtXgUSpGruW1Dn76uHONfbUHloDiz4n4kqKqAH
         Ezncd+G2RQw2OIcrRewFb6zQhDujwmwD3rGwcOZwx7Uw49KgA1KZM6uh+d6FBIg6eUJ7
         /j8bc5rjlujlBKd5My3gSL/Ma5syCP+vdad0D61dme33+s92eL59eGVDiwNbQyc6itg4
         l+l3/Vi0RsLpbJwc0QGPBguql2jtigfHBKRPUY+sZWbJDLBFBO6zVp2gV2KqmmmuX/3j
         coE538RhuoTNoIN6F8Z4bO079RS+RohLav+oC+Qdxuv89SyNCSnnk+NdPPLW9qiyXVei
         aFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687814726; x=1690406726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBq5r9rUXv4nLbCqvM8Gbq0XZla6rgmx2guuqNDvDxs=;
        b=fICZNA1dAyQEAqgVq31Fof+20u0JD8foG1gSXitbFikrkscG16l0J9jbioSFHsM/UI
         wqogt8CEyxbmT4wJs3XjrK0P9LPUDeKj8HqfJXNLJaDmsdS+Pb2oESJb8uPJrdlUuqu8
         FfHP4AXNh+ND/EcTWEm7qMCRfOQqokVRzDT35ZPCaARdtWAMj+yg6eg/rU962Y2WLCFx
         YoR6QT6WQD16TB6j1PQjU7LJez43vXfIeaofYVX+cR1gf/qeSAVnv3Dx5IQTRMdDXbq3
         +tDGeA5JiNijDsWKbUCi7iUAat+22icM0sgG/wpOnJioLsitPwJwj57zmv0Cf9ygTm6T
         Z3cg==
X-Gm-Message-State: AC+VfDwq2uGcZ/LAZ8565ai/icALZWw5fNSGtYio53gFNBGS3tmE9209
	DOaZSwYa1OrZdCz+0bWU1/brlZ3Tlpwl4OQCnlr24IgDNbnfNAC7ghL0U+f6/orRWDPOCRl132E
	qiFpJhQaqn8n3hG7JiEprqYYQXlBIRRbiAA0XpEjNG1HTDQk/uw==
X-Google-Smtp-Source: ACHHUZ6E10i5NQ3GU4Efj/d9wv/9wsYU/vInwA5UotSzNr0MlyvYG6oT6v345I9YzYTsz/tOrRQ/xzA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:bd11:0:b0:54f:b56a:cd0f with SMTP id
 b17-20020a81bd11000000b0054fb56acd0fmr13275370ywi.3.1687814726409; Mon, 26
 Jun 2023 14:25:26 -0700 (PDT)
Date: Mon, 26 Jun 2023 14:25:22 -0700
In-Reply-To: <20230626212522.2414485-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230626212522.2414485-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230626212522.2414485-2-sdf@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test to exercise typedef walking
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new bpf_fentry_test_sinfo with skb_shared_info argument
and try to access frags.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c                            |  4 ++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_typedef.c    | 23 +++++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_typedef.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2321bd2f9964..63b11f7a5392 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -555,6 +555,10 @@ __bpf_kfunc u32 bpf_fentry_test9(u32 *a)
 	return *a;
 }
 
+void noinline bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
+{
+}
+
 __bpf_kfunc int bpf_modify_return_test(int a, int *b)
 {
 	*b += 1;
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 070a13833c3f..c375e59ff28d 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -58,6 +58,7 @@
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subreg.skel.h"
+#include "verifier_typedef.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_unpriv.skel.h"
 #include "verifier_unpriv_perf.skel.h"
@@ -159,6 +160,7 @@ void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
+void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
 void test_verifier_unpriv_perf(void)          { RUN(verifier_unpriv_perf); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_typedef.c b/tools/testing/selftests/bpf/progs/verifier_typedef.c
new file mode 100644
index 000000000000..08481cfaac4b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_typedef.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("fentry/bpf_fentry_test_sinfo")
+__description("typedef: resolve")
+__success __retval(0)
+__naked void resolve_typedef(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 +0);				\
+	r2 = *(u64 *)(r1 +%[frags_offs]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(frags_offs,
+		      offsetof(struct skb_shared_info, frags))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.41.0.162.gfafddb0af9-goog


