Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B73211235
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 19:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgGARxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 13:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgGARxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 13:53:19 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCF5C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 10:53:19 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 124so9306158qko.8
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VB/KSdoSleNPyuddI4RHZwpZo8dMr4vfXtKSdI4JDW8=;
        b=UfhtwlfrE3cJUVoe4WVJG0157tIrGS4kww4M+vCDEfR+MCtIiF4OHtsu8K6QHxFgSL
         H0UHxeRL8rCoT0xjdG6BeSd9Vzya6G5s6MvHiwqdFlGdqTCJaXXJeUrqNTHrlVNwFpaR
         A/ANM+yVtI8e/dEMoZKYYul4ntUXW8V2/F3LhRlIYDNn0RqTajLdXN0eMWaTagt9HVCl
         hPG3cFJQIU2bTRi3IzGl4NTUH9f4NgKrXrfdnIIG/RuFR9rCo/VuMGRcXIqsQ6GT+ndI
         hQVRM0DybGmWejTnFp3mJO8RGffIZPtnhuFSu3QvgYT4djdjGnsgFSyEwHF1fOuWUomu
         wvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VB/KSdoSleNPyuddI4RHZwpZo8dMr4vfXtKSdI4JDW8=;
        b=P5YumYuCDi4JKN9+jyWfJbMJZzPCG5xeT8SQWcax57uy1fDcZS5AoLnDadC80iP/6h
         vOejSGdt1ZlyIYeXIRSGqg0Fg1GTiepAffXRmsJVVi9Rs0SwJ5/wpIaHHU6fEWjS1vWn
         rdID7irIPIix/TYJ05MnNDjwb0xFE609avjgJjECnvrKGB3YpIMLcUAu7mXryl5DKwyW
         5QMokov9AO3/gU53ddRFqfJhNgxs2JggRzyLRSjclu5l6oFmJfMFkTsiF7oKlkCd1UwS
         1nLYL8UpcPXQu56wCeG1DBBB89Q/sNU/NO+yBZD20P9VXduWvtsAhvcrmkixghOIPKva
         u73A==
X-Gm-Message-State: AOAM533A34/1h3fOTPZMNtwsEwQsoKV+9oJ5fCfOC0AnnXXhDmaTOQwH
        42g7oq9FDrsABFG/zdMxWch/aNpWe6E=
X-Google-Smtp-Source: ABdhPJxm18w/p7T2L9JtqSka8bQFpLWO3xGu8H/hkbHEGAGRPd+DV26F5Q8a2oWlPOlxvzXa0T/+KtOVVFo=
X-Received: by 2002:a0c:8b4a:: with SMTP id d10mr26091444qvc.31.1593625998237;
 Wed, 01 Jul 2020 10:53:18 -0700 (PDT)
Date:   Wed,  1 Jul 2020 10:53:15 -0700
Message-Id: <20200701175315.1161242-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next v2] selftests/bpf: Switch test_vmlinux to use hrtimer_range_start_ns.
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     sdf@google.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test_vmlinux test uses hrtimer_nanosleep as hook to test tracing
programs. But in a kernel built by clang, which performs more aggresive
inlining, that function gets inlined into its caller SyS_nanosleep.
Therefore, even though fentry and kprobe do hook on the function,
they aren't triggered by the call to nanosleep in the test.

A possible fix is switching to use a function that is less likely to
be inlined, such as hrtimer_range_start_ns. The EXPORT_SYMBOL functions
shouldn't be inlined based on the description of [1], therefore safe
to use for this test. Also the arguments of this function include the
duration of sleep, therefore suitable for test verification.

[1] af3b56289be1 time: don't inline EXPORT_SYMBOL functions

Tested:
 In a clang build kernel, before this change, the test fails:

 test_vmlinux:PASS:skel_open 0 nsec
 test_vmlinux:PASS:skel_attach 0 nsec
 test_vmlinux:PASS:tp 0 nsec
 test_vmlinux:PASS:raw_tp 0 nsec
 test_vmlinux:PASS:tp_btf 0 nsec
 test_vmlinux:FAIL:kprobe not called
 test_vmlinux:FAIL:fentry not called

 After switching to hrtimer_range_start_ns, the test passes:

 test_vmlinux:PASS:skel_open 0 nsec
 test_vmlinux:PASS:skel_attach 0 nsec
 test_vmlinux:PASS:tp 0 nsec
 test_vmlinux:PASS:raw_tp 0 nsec
 test_vmlinux:PASS:tp_btf 0 nsec
 test_vmlinux:PASS:kprobe 0 nsec
 test_vmlinux:PASS:fentry 0 nsec

Signed-off-by: Hao Luo <haoluo@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 Changelog since v1:
 - More accurate commit messages

 tools/testing/selftests/bpf/progs/test_vmlinux.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/testing/selftests/bpf/progs/test_vmlinux.c
index 5611b564d3b1..29fa09d6a6c6 100644
--- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
+++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
@@ -63,20 +63,20 @@ int BPF_PROG(handle__tp_btf, struct pt_regs *regs, long id)
 	return 0;
 }
 
-SEC("kprobe/hrtimer_nanosleep")
-int BPF_KPROBE(handle__kprobe,
-	       ktime_t rqtp, enum hrtimer_mode mode, clockid_t clockid)
+SEC("kprobe/hrtimer_start_range_ns")
+int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
+	       const enum hrtimer_mode mode)
 {
-	if (rqtp == MY_TV_NSEC)
+	if (tim == MY_TV_NSEC)
 		kprobe_called = true;
 	return 0;
 }
 
-SEC("fentry/hrtimer_nanosleep")
-int BPF_PROG(handle__fentry,
-	     ktime_t rqtp, enum hrtimer_mode mode, clockid_t clockid)
+SEC("fentry/hrtimer_start_range_ns")
+int BPF_PROG(handle__fentry, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
+	     const enum hrtimer_mode mode)
 {
-	if (rqtp == MY_TV_NSEC)
+	if (tim == MY_TV_NSEC)
 		fentry_called = true;
 	return 0;
 }
-- 
2.27.0.212.ge8ba1cc988-goog

