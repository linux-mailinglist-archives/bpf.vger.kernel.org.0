Return-Path: <bpf+bounces-21202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B308284939E
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 06:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C6B1C226E5
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 05:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E98BE48;
	Mon,  5 Feb 2024 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY/h711c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD7BA2B
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112614; cv=none; b=HcLicEEONxI/kKnJ1aUmgIMdZEdw0DIH44vyalITt210bUQFXm1fC8RSaJ7hQ/UIpeRxmPDbBaQ3CGy9o6ObS3nYluIIyJmU90oRHZ8kQGWckWes0SIc9y15U4GcTeE+UnP+ap1vhVUO0zRKSrqAI8gQtOFsyk1uuPERxeShSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112614; c=relaxed/simple;
	bh=uPolwFOWZrLSR7ucnZw/wszGGQLzlNk8nHmYIWHlCOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W38pBWzVXNw7Q7sV8IxPjQ/8gA9F6cdg5ArplXZmo0o2fmY0+neUoQT8Ku8Zqd8akNGJZImhmG/J1F/7TvmRNrJb3eDhpW7+x+qnzyEWJVvHNw+9jODXxwOyQSsBvvabDXD58EixApGfW4QCFfgvns/7daHGflSYZCPkQsJyeJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY/h711c; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so2500037a12.2
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 21:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707112611; x=1707717411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdhiqsY5bgO5ntSsFoFWqk97+TR+0qV2jK0xfkBgUyA=;
        b=dY/h711cxbFMEBaeCUJg5hUDcestYijhTzAFhLnpl02m2xNzEDuttviz+6w54N6QB1
         uFdPlbSRSUaMPhGPKOsZFKYgTRADSoT76td3A5cIWjfbRmQESL9h6EIpqPw8JV6LRUwN
         37o4A52GjhggbDLNBvTurBGWZ5dNEkjW2lXgEbuuKvmjKExqntiTutPZPnu/Gy3lEWjM
         HcRDGE/kOCIaDnNLF0qLZ4Mgs3Am95mCnmLA0/+kfxg/jmePW51njss6HP7BbR+QPHpA
         uzJW7/yEpprwyzXkJpOSVEdVSlf8JH43mBX1oNgdSGhvEVcCgZHciEiy1W7bB6dmmHr9
         wufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707112611; x=1707717411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdhiqsY5bgO5ntSsFoFWqk97+TR+0qV2jK0xfkBgUyA=;
        b=hg4DxgpIFkGQ+j65ihrLitTjHR90ExD6u4JByp7iLQW/Olfhat3GxdSH8ok58eFmcU
         SL2DNbIL1eFkbaEY/BApQtZRZi6yFcQyDo4XtlAhaKjn1eFOBDw8IPkVpoC71GVQjBCU
         kmadFYfAfaJRQbWwMOac/UyxxlUr+IsqojTPirhrM1G46NS6vrsYdQ0+OY0ALO6vonx0
         m7+0HTTLX1ByoGBkp35BQgmc126HQ2zUk+SyV5efF1SmI3mnZtxprWy9Z636Mw1tjhWW
         R0LECKAV41EskVyEVf+cJHk+fbELjDptPofZT+6mMFYGwOmBkgtpdC7oyA+WPEWklarL
         XHZA==
X-Gm-Message-State: AOJu0Yxtg3JG1bWa1Dn/CXDKy1wVwL8cZ2Dc0h0+wgNC903vaDJH0o/P
	8/O1LePY65m0XS06qwY5U6WnSd1ItSpaY9ROfarf91fWH/MGuzgwXP261Y6HZRU=
X-Google-Smtp-Source: AGHT+IFhYAZ/DNJz8hyDy112/NYb77iK8VZWHecgf0dsx3KCUiixzBAoWpb5aR+KQESEUHMI/rCfHQ==
X-Received: by 2002:aa7:d804:0:b0:55d:3d64:3ba6 with SMTP id v4-20020aa7d804000000b0055d3d643ba6mr4222322edq.29.1707112611063;
        Sun, 04 Feb 2024 21:56:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWtqcVSAiz86Clts7jC0UT78pnwUwRG3wWlhshYExK/5YMBr3Vp6g7kLs/eF1bi2ZdNakblnW64j1P0+vYKxeIZyMFBGqHAsjOvBc04gq6Imim7ItDq7/K2w871NVdfIJgEFyS8hL4H1u25q5DRJzXFYTgWY2GWT/3QwAP6MiGf0YcOkm3uYA2fim57akOqV+hUyZ68bokWhWpH9LITiTX4p6k8zuQSwX6dJ9j2qRgcBzxcDQgDjRQ=
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ek23-20020a056402371700b0055ff9299f71sm3099676edb.46.2024.02.04.21.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 21:56:50 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for RCU lock transfer between subprogs
Date: Mon,  5 Feb 2024 05:56:46 +0000
Message-Id: <20240205055646.1112186-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205055646.1112186-1-memxor@gmail.com>
References: <20240205055646.1112186-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4617; i=memxor@gmail.com; h=from:subject; bh=uPolwFOWZrLSR7ucnZw/wszGGQLzlNk8nHmYIWHlCOk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlwHiNS70kPLLBLij5xB/QsDpmavWdRD2HnmtRE /IM8yJuTb6JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZcB4jQAKCRBM4MiGSL8R ygcwD/oCAcrr3bDu4DeZimVd7PCbTsXafwyh88g/tCVu3itx24m3rCCh8VDA2GoZoa1CPU678M1 keS3TrejyQY7WbyBKFSH9zl0GsHsD47W4Iw+Pc7Rie/N918aMrhy8XAPxKoRDuOCTBYFV+X4C3q j5fUWo1gIxhKDCN4/F8mslxvnEmQjkJBa0HiKkH86FieebFyRT3gFLZOOae5YHUWCr2p80QPJE3 WfTyMP4zOz7yv9NBffCphhx/07y+EG6dqMnI8JQM2jFya8StVhlvBh0rqv/wBT4tB6BVK0h3ISi xPmKrb4UIGAbn6HAIS9lMveg89MYRt6hgM2uq0xYNIZytr/MdkKDW5ly0thTnKe/shNOcjlIFBJ P5gW3tS2sKeJl+hNZEvATxGlNLKmQnduvlP+mibvRkhA9domAG7DVaV9XWmR05TwuqdilB7WSnz rZQSRtNu58HQ5vbIkezsG8PuNt0dNqQHpEFsZhwTNIBsh9+K9xECXzKFLoJ8/VVXXU3ZHm3quxS 8oBZqP78vLFtq1Mi35LfqSKDfvWrwank02Dv4TyvrgYrU+lIIXOEWqIjRDT4tGqRx8S0JC2KEga 0fvsRf+wMvR3+rodC4bUTodahbmuB/YEbqy2NTlB/t4gqRiNYWIaYM8CpmlXyto1ODqzsrLa3HR EegHBIh2ibgjeJA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests covering the following cases:
- A static or global subprog called from within a RCU read section works
- A static subprog taking an RCU read lock which is released in caller works
- A static subprog releasing the caller's RCU read lock works

Global subprogs that leave the lock in an imbalanced state will not
work, as they are verified separately, so ensure those cases fail as
well.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |   6 +
 .../selftests/bpf/progs/rcu_read_lock.c       | 120 ++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index 3f1f58d3a729..a1f7e7378a64 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -29,6 +29,10 @@ static void test_success(void)
 	bpf_program__set_autoload(skel->progs.non_sleepable_1, true);
 	bpf_program__set_autoload(skel->progs.non_sleepable_2, true);
 	bpf_program__set_autoload(skel->progs.task_trusted_non_rcuptr, true);
+	bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog, true);
+	bpf_program__set_autoload(skel->progs.rcu_read_lock_global_subprog, true);
+	bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_lock, true);
+	bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog_unlock, true);
 	err = rcu_read_lock__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
 		goto out;
@@ -75,6 +79,8 @@ static const char * const inproper_region_tests[] = {
 	"inproper_sleepable_helper",
 	"inproper_sleepable_kfunc",
 	"nested_rcu_region",
+	"rcu_read_lock_global_subprog_lock",
+	"rcu_read_lock_global_subprog_unlock",
 };
 
 static void test_inproper_region(void)
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index 14fb01437fb8..ab3a532b7dd6 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -319,3 +319,123 @@ int cross_rcu_region(void *ctx)
 	bpf_rcu_read_unlock();
 	return 0;
 }
+
+__noinline
+static int static_subprog(void *ctx)
+{
+	volatile int ret = 0;
+
+	if (bpf_get_prandom_u32())
+		return ret + 42;
+	return ret + bpf_get_prandom_u32();
+}
+
+__noinline
+int global_subprog(u64 a)
+{
+	volatile int ret = a;
+
+	return ret + static_subprog(NULL);
+}
+
+__noinline
+static int static_subprog_lock(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	if (bpf_get_prandom_u32())
+		return ret + 42;
+	return ret + bpf_get_prandom_u32();
+}
+
+__noinline
+int global_subprog_lock(u64 a)
+{
+	volatile int ret = a;
+
+	return ret + static_subprog_lock(NULL);
+}
+
+__noinline
+static int static_subprog_unlock(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_unlock();
+	if (bpf_get_prandom_u32())
+		return ret + 42;
+	return ret + bpf_get_prandom_u32();
+}
+
+__noinline
+int global_subprog_unlock(u64 a)
+{
+	volatile int ret = a;
+
+	return ret + static_subprog_unlock(NULL);
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_subprog(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	if (bpf_get_prandom_u32())
+		ret += static_subprog(ctx);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_global_subprog(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	if (bpf_get_prandom_u32())
+		ret += global_subprog(ret);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_subprog_lock(void *ctx)
+{
+	volatile int ret = 0;
+
+	ret += static_subprog_lock(ctx);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_global_subprog_lock(void *ctx)
+{
+	volatile int ret = 0;
+
+	ret += global_subprog_lock(ret);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_subprog_unlock(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	ret += static_subprog_unlock(ctx);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int rcu_read_lock_global_subprog_unlock(void *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_rcu_read_lock();
+	ret += global_subprog_unlock(ret);
+	return 0;
+}
-- 
2.40.1


