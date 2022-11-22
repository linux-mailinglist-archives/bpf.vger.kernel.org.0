Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9B633F8A
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 15:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiKVOyv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 09:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiKVOxr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 09:53:47 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9753131EFD;
        Tue, 22 Nov 2022 06:53:08 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id df6so8004112qvb.0;
        Tue, 22 Nov 2022 06:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb/yuqONdDj2N+Rq15f0dZqgCjwngdlnAQHxxom73jM=;
        b=3Iujq7N3C1dcnDlzjI9OwzCP+Ck14p7wOYogFeWEtK1Sj7lWsXdAiJ7ppfKyJCHn+B
         OBbgJ0dHaM5vVFTJwCyDrQf/J8DxeoF0nvu8LQhXT/ohp1aiKuFot0glDr/cnldZDKSD
         m9uyZxhFvVg1XELQx8WryY7s4JE82cob91WXDBpOq0+brzAYflRQ4ui/BW+dxbltfEsY
         iWwRJHscug+vbUJb7lXb1kwkivrkkP0CiiJDfaXH9M88q4jjKELeWIa0kyqNc2k5I1vn
         ba6ZKREc8NJ89am4NSRk8zvYDLliy5FQGWeMC9n3cdlS7p2aMhlYeJDlg/4cHZ4CF4c2
         gxNQ==
X-Gm-Message-State: ANoB5pnWygXLpgnLa+JPGGQItHtbas46LhT/DusO3YIQ+o3RrZ6n3cX7
        Weo1eH6zuy80aDJZuM6/I1DYMueppZQDKfJV
X-Google-Smtp-Source: AA0mqf643EYZyzUb5WDk7tX0koWXVyNxU31Xsvo3i67H8IETCSOEUuAwEeLr6uUADQAxN6xNZVJB7g==
X-Received: by 2002:a0c:ef01:0:b0:4bb:d6bc:be1c with SMTP id t1-20020a0cef01000000b004bbd6bcbe1cmr4047071qvr.82.1669128787277;
        Tue, 22 Nov 2022 06:53:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:3170])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a298d00b006eee3a09ff3sm10337092qkp.69.2022.11.22.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:53:06 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add selftests for bpf_task_from_pid()
Date:   Tue, 22 Nov 2022 08:53:00 -0600
Message-Id: <20221122145300.251210-3-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122145300.251210-1-void@manifault.com>
References: <20221122145300.251210-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add some selftest testcases that validate the expected behavior of the
bpf_task_from_pid() kfunc that was added in the prior patch.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/task_kfunc.c     |  4 +
 .../selftests/bpf/progs/task_kfunc_common.h   |  1 +
 .../selftests/bpf/progs/task_kfunc_failure.c  | 13 ++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 73 +++++++++++++++++++
 4 files changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index 4994fe6092cc..ffd8ef4303c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -78,6 +78,9 @@ static const char * const success_tests[] = {
 	"test_task_xchg_release",
 	"test_task_get_release",
 	"test_task_current_acquire_release",
+	"test_task_from_pid_arg",
+	"test_task_from_pid_current",
+	"test_task_from_pid_invalid",
 };
 
 static struct {
@@ -99,6 +102,7 @@ static struct {
 	{"task_kfunc_release_fp", "arg#0 pointer type STRUCT task_struct must point"},
 	{"task_kfunc_release_null", "arg#0 is ptr_or_null_ expected ptr_ or socket"},
 	{"task_kfunc_release_unacquired", "release kernel function bpf_task_release expects"},
+	{"task_kfunc_from_pid_no_null_check", "arg#0 is ptr_or_null_ expected ptr_ or socket"},
 };
 
 static void verify_fail(const char *prog_name, const char *expected_err_msg)
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
index 160d6dde00be..c0ffd171743e 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -23,6 +23,7 @@ struct hash_map {
 struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
 struct task_struct *bpf_task_kptr_get(struct task_struct **pp) __ksym;
 void bpf_task_release(struct task_struct *p) __ksym;
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
 
 static inline struct __tasks_kfunc_map_value *tasks_kfunc_map_value_lookup(struct task_struct *p)
 {
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 93e934ddfcb6..e310473190d5 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -258,3 +258,16 @@ int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	acquired = bpf_task_from_pid(task->pid);
+
+	/* Releasing bpf_task_from_pid() lookup without a NULL check. */
+	bpf_task_release(acquired);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index be4534b5ba2e..60c7ead41cfc 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -147,3 +147,76 @@ int BPF_PROG(test_task_current_acquire_release, struct task_struct *task, u64 cl
 
 	return 0;
 }
+
+static void lookup_compare_pid(const struct task_struct *p)
+{
+	struct task_struct *acquired;
+
+	acquired = bpf_task_from_pid(p->pid);
+	if (!acquired) {
+		err = 1;
+		return;
+	}
+
+	if (acquired->pid != p->pid)
+		err = 2;
+	bpf_task_release(acquired);
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_from_pid_arg, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	lookup_compare_pid(task);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_from_pid_current, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *current, *acquired;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	lookup_compare_pid(bpf_get_current_task_btf());
+	return 0;
+}
+
+static int is_pid_lookup_valid(s32 pid)
+{
+	struct task_struct *acquired;
+
+	acquired = bpf_task_from_pid(pid);
+	if (acquired) {
+		bpf_task_release(acquired);
+		return 1;
+	}
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_from_pid_invalid, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	if (is_pid_lookup_valid(-1)) {
+		err = 1;
+		return 0;
+	}
+
+	if (is_pid_lookup_valid(0xcafef00d)) {
+		err = 2;
+		return 0;
+	}
+
+	return 0;
+}
-- 
2.38.1

