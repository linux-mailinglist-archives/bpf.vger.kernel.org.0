Return-Path: <bpf+bounces-75081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FA0C6F77C
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 15:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56F0E4F7A0E
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477A035E544;
	Wed, 19 Nov 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="155PsOUG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124134DB60
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562946; cv=none; b=MnOcnzI5fm79GfDz9YeWI94f9RoKDZWeZ0dc/SCWIjTRASeb+czwTz8jp2WEQJk749f0epWYLnBXN6GvcQfO4SFg9rTlEkDlIs2kS2FPwoSG3nyQi891OIdewizByIc6EgH9CFfB3k8vydigeKgbK4gCb54WracjlYzKUy2ODbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562946; c=relaxed/simple;
	bh=RQqYkhNNMbaHjVyeHV4QVyzP+3apTNL1Zk0lVatokJo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oqrTldLAxM+IMrPjjCJLekjq1BURANqJJ4Db5smfRBvICnnJcSxMEZb9+nz4MrAr1R8CtP1fB12GCewU5D69A4Vklx0JOdAroo59fjaP2ja6kf5PXDnDaopmHSQINcFECJlJqK9vYL6sFQEgVQJZkx4p8vClAZrnTdtXpVSHJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=155PsOUG; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b735efd650fso860350766b.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 06:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763562943; x=1764167743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yTfRQaTfHYSXNqEIANbonMXYRm5Ku1evZ1vL5iJvb6A=;
        b=155PsOUGduGOzGdja1/iBRpMUb+e9neqcDTw8T6KwgbuP805iB+go6+zXgLuSJBNdv
         nFWWyVihgn04ECCgVnJE383XOYvDn6szyyJto90GgEYToUtDqQCF5tbBRajiJN7avnGh
         uLCy58cxFhtm83Fv6V71mqjCI0GdX9S0F2DvJBfyj5wILMre3i4Ey4g00pf45qksl8Ib
         pWsMFD6/g5YG4NIDqPImaa1QhySR6wH8bh1EGNb7+wRPWmFSOsWDzK5+jd0W8a691SUp
         fOHXrs/z2222HF6APv7D652h1Up0sj7YhfNXxPY8WEE/lw8XK2gNMmGvCI/5xTkeGk5i
         tIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562943; x=1764167743;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTfRQaTfHYSXNqEIANbonMXYRm5Ku1evZ1vL5iJvb6A=;
        b=q0+UavhuCVqlsiCFJsjEJbTpiXUjZV7DtLJ/zeJctRPeotrjQturqaDkkTUfa4R0Es
         ezgHX+aK7OiT5He1G6Yu98FbzlMgZhanyiTBnC/0pO4n8vTKGmdy/nwufR+z56wxZcQ6
         AUxLKDH1onVywOQT+g/V1U01NDbX3ot4P6h6mtGgG7V7z+BuP/HYyi22vd0XFkiEa7ls
         1luyeKe2lgL1jBl5cwB5sbD8F5eIPI2i/htCzwpijUvdfdrTK8PnCQS5B6zopbp1SavS
         Oga/zescv3CSSP3YiTxMaVss3q8+If7kuFrLHxTxj4VB/stm3X8XGMSedbiaBtdrQaLu
         qZGg==
X-Gm-Message-State: AOJu0Yy4UPsXn2KJDFamiyIGL42IxfFZevwB54xbi+VvZG7RNJh8MoTZ
	KM4mceHwogKCN+KmXCAvGAAVFbjK6epND+9DpVl8+45eMCyeT3afCxJGBljfwdRMp2VBQAH6a8v
	F9I9nLyE15F48Jq8hOdtevLucvQDJmUHLrJZgGPJrvMiZQ0yJ9/shXfLCp4w17PvFw/8LKVCRYp
	s7EOYptYt4z3dbMGBo+SOKVFxzvm8k2sqs68cLJcrbQrKgk2I6g9wzl8npRn561c7xNcgV8g==
X-Google-Smtp-Source: AGHT+IEwUbqK3pNN2+DIBnFXL+SHVn4gMP5GHjx2x3Nz8KTMifgCSn+kEjCgAYtFPy9vVb/GsSOiOiGiYRJQj6HMJ1Mj
X-Received: from ejcsf16.prod.google.com ([2002:a17:907:8a90:b0:b73:7aca:ecc6])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7310:b0:b76:3b3f:60e9 with SMTP id a640c23a62f3a-b763b3f6461mr279135566b.45.1763562943136;
 Wed, 19 Nov 2025 06:35:43 -0800 (PST)
Date: Wed, 19 Nov 2025 14:35:40 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251119143540.2911424-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] selftests/bpf: improve reliability of test_perf_branches_no_hw()
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, test_perf_branches_no_hw() relies on the busy loop within
test_perf_branches_common() being slow enough to allow at least one
perf event sample tick to occur before starting to tear down the
backing perf event BPF program. With a relatively small fixed
iteration count of 1,000,000, this is not guaranteed on modern fast
CPUs, resulting in the test run to subsequently fail with the
following:

bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
Successfully loaded bpf_testmod.ko.
test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
test_perf_branches_common:PASS:attach_perf_event 0 nsec
test_perf_branches_common:PASS:set_affinity 0 nsec
check_good_sample:PASS:output not valid 0 nsec
check_good_sample:PASS:read_branches_size 0 nsec
check_good_sample:PASS:read_branches_stack 0 nsec
check_good_sample:PASS:read_branches_stack 0 nsec
check_good_sample:PASS:read_branches_global 0 nsec
check_good_sample:PASS:read_branches_global 0 nsec
check_good_sample:PASS:read_branches_size 0 nsec
test_perf_branches_no_hw:PASS:perf_event_open 0 nsec
test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
test_perf_branches_common:PASS:attach_perf_event 0 nsec
test_perf_branches_common:PASS:set_affinity 0 nsec
check_bad_sample:FAIL:output not valid no valid sample from prog
Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
Successfully unloaded bpf_testmod.ko.

On a modern CPU (i.e. one with a 3.5 GHz clock rate), executing 1
million increments of a volatile integer can take significantly less
than 1 millisecond. If the spin loop and detachment of the perf event
BPF program elapses before the first 1 ms sampling interval elapses,
the perf event will never end up firing. Fix this by bumping the loop
iteration counter a little within test_perf_branches_common(), along
with ensuring adding another loop termination condition which is
directly influenced by the backing perf event BPF program
executing. Notably, a concious decision was made to not adjust the
sample_freq value as that is just not a reliable way to go about
fixing the problem. It effectively still leaves the race window open.

Fixes: 67306f84ca78c ("selftests/bpf: Add bpf_read_branch_records() selftest")
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/perf_branches.c     | 16 ++++++++++++++--
 .../selftests/bpf/progs/test_perf_branches.c     |  3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
index bc24f83339d6..1d51ec5f171a 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -15,6 +15,10 @@ static void check_good_sample(struct test_perf_branches *skel)
 	int pbe_size = sizeof(struct perf_branch_entry);
 	int duration = 0;
 
+	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
+		  "checked sample validity before prog run"))
+		return;
+
 	if (CHECK(!skel->bss->valid, "output not valid",
 		 "no valid sample from prog"))
 		return;
@@ -45,6 +49,10 @@ static void check_bad_sample(struct test_perf_branches *skel)
 	int written_stack = skel->bss->written_stack_out;
 	int duration = 0;
 
+	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
+		  "checked sample validity before prog run"))
+		return;
+
 	if (CHECK(!skel->bss->valid, "output not valid",
 		 "no valid sample from prog"))
 		return;
@@ -83,8 +91,12 @@ static void test_perf_branches_common(int perf_fd,
 	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
 	if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
 		goto out_destroy;
-	/* spin the loop for a while (random high number) */
-	for (i = 0; i < 1000000; ++i)
+
+	/* Spin the loop for a while by using a high iteration count, and by
+	 * checking whether the specific run count marker has been explicitly
+	 * incremented at least once by the backing perf_event BPF program.
+	 */
+	for (i = 0; i < 100000000 && !*(volatile int *)&skel->bss->run_cnt; ++i)
 		++j;
 
 	test_perf_branches__detach(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
index a1ccc831c882..05ac9410cd68 100644
--- a/tools/testing/selftests/bpf/progs/test_perf_branches.c
+++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
@@ -8,6 +8,7 @@
 #include <bpf/bpf_tracing.h>
 
 int valid = 0;
+int run_cnt = 0;
 int required_size_out = 0;
 int written_stack_out = 0;
 int written_global_out = 0;
@@ -24,6 +25,8 @@ int perf_branches(void *ctx)
 	__u64 entries[4 * 3] = {0};
 	int required_size, written_stack, written_global;
 
+	++run_cnt;
+
 	/* write to stack */
 	written_stack = bpf_read_branch_records(ctx, entries, sizeof(entries), 0);
 	/* ignore spurious events */
-- 
2.52.0.rc2.455.g230fcf2819-goog


