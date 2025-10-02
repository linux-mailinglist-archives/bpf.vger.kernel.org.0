Return-Path: <bpf+bounces-70256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61755BB5940
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2573B353D
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4212D2C21D8;
	Thu,  2 Oct 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNrNal9J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634722BDC0C
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445650; cv=none; b=M+gmjAbJMpTSUOGupoQe/hwPA/HDucRIOcSvJxn0ejtuvV9njKAoP62Nvxu95f1HWUba/l0KgonhBi+YKPutnMVU2IrNVIO4qTM1K1jd4c2ppzsSsPpztDUM0kQo3ti06SMWSsCH0K+JhkTtx+vanorCB6WF/PNNQkHcexy1ouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445650; c=relaxed/simple;
	bh=UlL8oZQzeYpieEW9kR3O2tWXV0IGuasLKuUjGh/FzsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJCYTLHwZP9X7ZTO3RHxhoJNeoS5PtXUL3BrdJzyEuOd/uQtLlmNhcQJvxWu5RPmY3PR+BlK9odvc05fzkCSOEI8LBq9tbW118knP2nyFw5Qs9V7+tfDbDa/JneAcNjgWmO2QMTaOMjQKI2L3I7pgnUZNcAjfkUO0QeXrrSlPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNrNal9J; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so1972988a91.3
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445646; x=1760050446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=YNrNal9Ju9ATureZYzDx3Sexu3LUlhyA0W7YFG4TnMdDwwLR7tcOfKX9uL/GRaoQpu
         JFdxRobLgz0CWX6ztG4nmqSAesQnoBKvduF4ju9DzXEiii5sh2+Bz0+u2MxjyIQB5x0t
         fQNYTSmdW7Pk9cyGB7BpeWN2vf4F9digtEjQwitlGqbX49fkIyw7ijRNxCW7RfZly/AD
         gFXRt3AU5386p4M8ChkPtSz3bqTWDe2wioMfZqsv/zqb5pzcOuJPX2PEtqmpBGTZWEcq
         I91lHdgsLBDdmSlRgEK8qaAPlyAs5DcxxQ5LYcURkgvK2+vJebbVMSuLGrgFDnLevI0+
         umVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445646; x=1760050446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=ADPHFFFU38ERf68gUd1Acc77hpNiaPyzCkbTUKKAAX3HUJKOXSB/vsPz/hCKB7iLWn
         zzz8+vxyq8M4TYZiQli2TZVUYtTPA5ZBmUGnyb7wgn/Sp4gcvCS1xdofzwXzG4udTbJ/
         g0t7PAzbkRWC7G/beXP8k2xwysvrnnUL64ZPrBNytIveiAAHA46rCCrE5nKplsbYbv8I
         MXrmeJKPWbUnQK3dWmD9UkNA4GyokQuG3TKVZIDu9JXIksDnzhUq2dJo10iBtJFobbjD
         tAKxEjCHMsljbP8Lo4j/6tM+rXL1FXgvOpjuPCTtN1vX14f+dsOQ77BJpiS2LkW6iHPk
         AsRA==
X-Gm-Message-State: AOJu0Yz4og2McC+O+JWI71WSQP0Zdr1/gKWIdI/hVV5Q+cayUamn3eF6
	sUJpt3Tul997geDnpZWvyQ7VhgboUKlfbJrrd6ohPiareffLxf9ghrHr2OiSFQ==
X-Gm-Gg: ASbGncuAb5Ey60TMd8S01DjvLHCaHt/i4JFopEnwzEUqAvVYZOlyptZ4xDTJJd3nV7n
	e6yMitUQgKHxHcVOadlzwXXZ1CHdO0fpXFFtGQ506waEbTIS0W1rf/EnjRcKszF/28GBSWRFe1P
	TM7rfC4nyTKpvWp+N2lpcdrufof9Ws8GZtAtv/fPAIrl1BewZMwwAwSmaJgk5DoM02cpEsI/QCS
	fyWu2UhEV//KGjbwv7rQBARxc+cRi5sqtr9+I71vHHLJOEF3mtbxJZTVyRunBksqX/+t6aMw6rX
	Rz43KFfXSKYMCBoKTLQtui4V7czVIr4e42yxJCgDqWkH8c9U+xqhQZsxJNvXbf6D0KUswk98kfG
	bKgBi05hGFmuPndQhWAoOl0869S5v1rYd77Op
X-Google-Smtp-Source: AGHT+IEKeUuXSLlxs+Qufc+5AAUWNAynyNDsdfEa+1mqdHlgXLN7b6nKdczjDpQ9nbzGbzdCFnGOHg==
X-Received: by 2002:a17:90b:1d05:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-339c27ba121mr922785a91.32.1759445646582;
        Thu, 02 Oct 2025 15:54:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm128017a91.11.2025.10.02.15.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 10/12] selftests/bpf: Update task_local_storage/recursion test
Date: Thu,  2 Oct 2025 15:53:49 -0700
Message-ID: <20251002225356.1505480-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the expected result of the selftest as recursion of task local
storage syscall and helpers have been relaxed. Now that the percpu
counter is removed, task local storage helpers, bpf_task_storage_get()
and bpf_task_storage_delete() can now run on the same CPU at the same
time unless they cause deadlock.

Note that since there is no percpu counter preventing recursion in
task local storage helpers, bpf_trampoline now catches the recursion
of on_update as reported by recursion_misses.

on_enter: tp_btf/sys_enter
on_update: fentry/bpf_local_storage_update

           Old behavior                         New behavior
           ____________                         ____________
on_enter                             on_enter
  bpf_task_storage_get(&map_a)         bpf_task_storage_get(&map_a)
    bpf_task_storage_trylock succeed     bpf_local_storage_update(&map_a)
    bpf_local_storage_update(&map_a)

    on_update                            on_update
      bpf_task_storage_get(&map_a)         bpf_task_storage_get(&map_a)
        bpf_task_storage_trylock fail        on_update::misses++ (1)
        return NULL                        create and return map_a::ptr

                                           map_a::ptr += 1 (1)

                                           bpf_task_storage_delete(&map_a)
                                             return 0

      bpf_task_storage_get(&map_b)         bpf_task_storage_get(&map_b)
        bpf_task_storage_trylock fail        on_update::misses++ (2)
        return NULL                        create and return map_b::ptr

                                           map_b::ptr += 1 (1)

    create and return map_a::ptr         create and return map_a::ptr
  map_a::ptr = 200                     map_a::ptr = 200

  bpf_task_storage_get(&map_b)         bpf_task_storage_get(&map_b)
    bpf_task_storage_trylock succeed     lockless lookup succeed
    bpf_local_storage_update(&map_b)     return map_b::ptr

    on_update
      bpf_task_storage_get(&map_a)
        bpf_task_storage_trylock fail
        lockless lookup succeed
        return map_a::ptr

      map_a::ptr += 1 (201)

      bpf_task_storage_delete(&map_a)
        bpf_task_storage_trylock fail
        return -EBUSY
      nr_del_errs++ (1)

      bpf_task_storage_get(&map_b)
        bpf_task_storage_trylock fail
        return NULL

    create and return ptr

  map_b::ptr = 100

Expected result:

map_a::ptr = 201                          map_a::ptr = 200
map_b::ptr = 100                          map_b::ptr = 1
nr_del_err = 1                            nr_del_err = 0
on_update::recursion_misses = 0           on_update::recursion_misses = 2
On_enter::recursion_misses = 0            on_enter::recursion_misses = 0

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/task_local_storage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 42e822ea352f..559727b05e08 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -117,19 +117,19 @@ static void test_recursion(void)
 	map_fd = bpf_map__fd(skel->maps.map_a);
 	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
 	ASSERT_OK(err, "lookup map_a");
-	ASSERT_EQ(value, 201, "map_a value");
-	ASSERT_EQ(skel->bss->nr_del_errs, 1, "bpf_task_storage_delete busy");
+	ASSERT_EQ(value, 200, "map_a value");
+	ASSERT_EQ(skel->bss->nr_del_errs, 0, "bpf_task_storage_delete busy");
 
 	map_fd = bpf_map__fd(skel->maps.map_b);
 	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
 	ASSERT_OK(err, "lookup map_b");
-	ASSERT_EQ(value, 100, "map_b value");
+	ASSERT_EQ(value, 1, "map_b value");
 
 	prog_fd = bpf_program__fd(skel->progs.on_update);
 	memset(&info, 0, sizeof(info));
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	ASSERT_OK(err, "get prog info");
-	ASSERT_EQ(info.recursion_misses, 0, "on_update prog recursion");
+	ASSERT_EQ(info.recursion_misses, 2, "on_update prog recursion");
 
 	prog_fd = bpf_program__fd(skel->progs.on_enter);
 	memset(&info, 0, sizeof(info));
-- 
2.47.3


