Return-Path: <bpf+bounces-2048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A517F7271DD
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 00:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D161C20F62
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F593B3F5;
	Wed,  7 Jun 2023 22:40:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E1D3B3ED
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 22:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF84C433D2;
	Wed,  7 Jun 2023 22:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686177648;
	bh=KX3SaanREGkNTpSF/jqGKXmVXPeN/JDPOuWgairP2iM=;
	h=From:To:Cc:Subject:Date:From;
	b=c8ZNw31tsXvTcDePRZJju5r9Fo10wPfsrE2+JpmdbHtVnnY2nO7iK0xSTuJtNYAxu
	 l07w/jiCedc5q59d94yhgOdcLtR5Fjv3hyiJdH4O+OV6E33OM9pSN4pw9mFntCQLNP
	 tGL4qBBB6D8YQyZ2NDj4HhbnXl+doHgxP/b3H5TFdP35PgqLbHDz7PGu1fT/0Yokcx
	 Ty32s7Y781WfuQA6Hd+exJCtsGmVzECO5ZY1b3hO34vBQjjxTtaVyz598/MMkyf7IC
	 eBtLuTz0EcMyCo6ZuruvTdB2yYrGWKeqSbdibAL99nOy5XaxCAQZSC8ggff/j1sU9/
	 /rRRleRlyPkIw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next] selftests/bpf: Add missing prototypes for several test kfuncs
Date: Wed,  7 Jun 2023 15:40:46 -0700
Message-Id: <20230607224046.236510-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding missing prototypes for several kfuncs that are used by
test_verifier tests. We don't really need kfunc prototypes for
these tests, but adding them to silence 'make W=1' build and
to have all test kfuncs declarations in bpf_testmod_kfunc.h.

Also moving __diag_pop for -Wmissing-prototypes to cover also
bpf_testmod_test_write and bpf_testmod_test_read and adding
bpf_fentry_shadow_test in there as well. All of them need to
be exported, but there's no need for declarations.

Fixes: 65eb006d85a2 ("bpf: Move kernel test kfuncs to bpf_testmod")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306051319.EihCQZPs-lkp@intel.com/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c      | 16 ++++++++--------
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h          |  7 +++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cf216041876c..aaf6ef1201c7 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -191,8 +191,6 @@ noinline int bpf_testmod_fentry_test3(char a, int b, u64 c)
 	return a + b + c;
 }
 
-__diag_pop();
-
 int bpf_testmod_fentry_ok;
 
 noinline ssize_t
@@ -273,6 +271,14 @@ bpf_testmod_test_write(struct file *file, struct kobject *kobj,
 EXPORT_SYMBOL(bpf_testmod_test_write);
 ALLOW_ERROR_INJECTION(bpf_testmod_test_write, ERRNO);
 
+noinline int bpf_fentry_shadow_test(int a)
+{
+	return a + 2;
+}
+EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
+
+__diag_pop();
+
 static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 	.attr = { .name = "bpf_testmod", .mode = 0666, },
 	.read = bpf_testmod_test_read,
@@ -462,12 +468,6 @@ static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
 	.set   = &bpf_testmod_check_kfunc_ids,
 };
 
-noinline int bpf_fentry_shadow_test(int a)
-{
-	return a + 2;
-}
-EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
-
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index 9693c626646b..87b89b842c33 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -97,4 +97,11 @@ void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
 void bpf_kfunc_call_test_destructive(void) __ksym;
 
+void bpf_kfunc_call_test_offset(struct prog_test_ref_kfunc *p);
+struct prog_test_member * bpf_kfunc_call_memb_acquire(void);
+void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p);
+void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p);
+void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p);
+void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
+void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.40.1


