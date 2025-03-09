Return-Path: <bpf+bounces-53697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E6DA58912
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834BD3AC34D
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 23:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1A72144AE;
	Sun,  9 Mar 2025 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="MxSMC4KQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D522171F
	for <bpf@vger.kernel.org>; Sun,  9 Mar 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561490; cv=none; b=b3yZcleyGMcY1fPDb2+0+NDBouSkC2+5/uzlDrGIvNH6DRHDRf5QAGXJ0Uhx6ajfwJkd+uXw7uKD1MhkesupJCIFySr8Ed19l7NqnDcL4+FiqTdXALU1mtoRSw7NbD1slYeraXfIzO9z7KvmLpUHLJmbFVNCZkNtaCoYltHYNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561490; c=relaxed/simple;
	bh=peZFyluVZ0FiCpPVp7oBf4L9njPh6ZalQqDBglITmlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7CSA5FBagw+yoCqHQv/VNjCWLlqbeo09C0aMxtUAHX5Ho1faL6ln1z8Q3fCTYnds+tNvuECiK0fX4G+Lr2oSq8FL1QLZT8QcwNwS50xkrT5Vrpms2pZ0lGky2tqbaRzWoMIiV7cAxDsAr+ie8+1b18c/5LV9va7imwR7EhYCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=MxSMC4KQ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f254b875so29502456d6.1
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741561487; x=1742166287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czcOPZEF092tMsnwanSBIUc+3/AcuIu7IIhDWv1aDyw=;
        b=MxSMC4KQfkou4GY18PUOl+ZW5l+koV2Yr/ZbPZh1Krez0dM3l8HRAa//VHk/qNxif6
         HT+USzDCE+vCpFUS+OJAw6JiWGWTDxtiMbBzWs9/r7j18NsCDKyizxyIDUK/BIFC2Bst
         BTGwg5h454IaXl++P/Gv4lFyAyLDbb5n22I2X7FfE9wCobIQXxDrN0io9XZ6zmzqZaVx
         JCAIMmQ3pf0pOyTk1T28Q4jWvgUnNWRukaQda+OilXz4b2pqmfwdAguWxvR9oGMBt9Wt
         eGDSgRYoS0x4oGIasjO9Cr0v9Zvh7cbIbRQ2uZ3JlV+7tiTycLVit0wcooUMWvejXBjO
         v9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561487; x=1742166287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czcOPZEF092tMsnwanSBIUc+3/AcuIu7IIhDWv1aDyw=;
        b=pg8bBbWnNESCT1HH6o5QFRYyEbhsw4kJOXTD9X11ws1gezrOOvHxW4vcj9YDoqb41d
         mSTwb1S1nmUZNNmXdgPOfNEl8pJ/FgfUliL4yFaeBzwc29JJWvwvrFLqGQwZky2TUgVh
         fFeuZddKn5//H8YMTdcbbMj1Saa+A0v+QzaeRZhR89q6zsciOSBTMO5cvGrGRiTH2BIb
         6WyBzK+X5Tv8GyWzwV7fm+MGY8swSzb1p29QjkYz5jbZuOqRKynyGLEbCBbzKcV+r75J
         EygkpdC4zYvyN44A3x4adxiOBDc1kRJkeNXOrhSTi+VcofR4QqGUpT36ruyjdMJyPG9C
         UG6A==
X-Gm-Message-State: AOJu0YzGFDQzyh0fXudbkpNH4d1hcw844pAZPHBy6bhOeKW/pYSfgn9n
	zhKr+SIgfAPftfNBiuHRgVRSDumj2hW6g7cqH8LFkmefNq2FfcsAT+eQ9Ie7QaPglG6GcJLByRt
	8SUwfqA==
X-Gm-Gg: ASbGncuJJB60O+RTMwKFvi2SERURbJK3DVIGZBNiQ6WJrGt4FNGd2MHo69K0JJFOYvs
	ZaP6Ow/lLzHt22IiOo7VugusEiFuj6Bl/FbYvsJ6ncAVFpI5+tc+h1+xCgwhMCS3UnPFLx+x3sB
	+BnEjVVYEEOh8vIkNkpAyVtEG44fSZ5/HYs5/PWLr5d+OkgIqBPmKdtcYIWE9AnlakWoE4QMPY9
	+DKTO7pLNHw3vK7W9bf/xLN9nEvtycxCIJaReNqry0XH+7yx4G29ElLiO7eO5B8fvHMzU7WMDKP
	VQd/PTsTbPmbP5EGAaYdteE6eWfZ5Pp16S0ic4c9mQ7iyo7jMrdR
X-Google-Smtp-Source: AGHT+IHOoG45dIMNZfTKZLNOUnE+tQbfiTXxjICd8143B6o3doEZTBLG4rhVr1gXFS5TmGWBkWmm/w==
X-Received: by 2002:a05:6214:20cf:b0:6e8:fe16:4d45 with SMTP id 6a1803df08f44-6e90069852cmr154721296d6.41.1741561487279;
        Sun, 09 Mar 2025 16:04:47 -0700 (PDT)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e9146790casm14378406d6.55.2025.03.09.16.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 16:04:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v7 4/4] selftests: bpf: fix duplicate selftests in cpumask_success.
Date: Sun,  9 Mar 2025 19:04:27 -0400
Message-ID: <20250309230427.26603-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309230427.26603-1-emil@etsalapatis.com>
References: <20250309230427.26603-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF cpumask selftests are currently run twice in
test_progs/cpumask.c, once by traversing cpumask_success_testcases, and
once by invoking RUN_TESTS(cpumask_success). Remove the invocation of
RUN_TESTS to properly run the selftests only once.

Now that the tests are run only through cpumask_success_testscases, add
to it the missing test_refcount_null_tracking testcase. Also remove the
__success annotation from it, since it is now loaded and invoked by the
runner.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/prog_tests/cpumask.c    | 2 +-
 tools/testing/selftests/bpf/progs/cpumask_success.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index 9b09beba988b..6c45330a5ca3 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -25,6 +25,7 @@ static const char * const cpumask_success_testcases[] = {
 	"test_global_mask_nested_deep_rcu",
 	"test_global_mask_nested_deep_array_rcu",
 	"test_cpumask_weight",
+	"test_refcount_null_tracking",
 	"test_populate_reject_small_mask",
 	"test_populate_reject_unaligned",
 	"test_populate",
@@ -81,6 +82,5 @@ void test_cpumask(void)
 		verify_success(cpumask_success_testcases[i]);
 	}
 
-	RUN_TESTS(cpumask_success);
 	RUN_TESTS(cpumask_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 91a5357769a8..0e04c31b91c0 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -749,7 +749,6 @@ int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
-__success
 int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *mask1, *mask2;
-- 
2.47.1


