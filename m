Return-Path: <bpf+bounces-64665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29701B152CB
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469173AC9C8
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2712989A4;
	Tue, 29 Jul 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0Xn3/F5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136B251795;
	Tue, 29 Jul 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813563; cv=none; b=H/2JbfRMEIU8a8hRddVEzLQQvzC6xxeuMZgKs7oiY8Dtg0h3B8RMSWXbZ7X0yKRO4mpOJDmidnwMxxiFjUpjfoHVprtGfNuN0p7X3NK6Gpydn21oBvzIcJMI/BcnlC5iXAEBY4/6hNlyYDgnovtOsrlOKIsLVVugtmAyPqFWhKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813563; c=relaxed/simple;
	bh=UlL8oZQzeYpieEW9kR3O2tWXV0IGuasLKuUjGh/FzsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Osl3AQ0pABE7VRqFNTEX5DHZA/CHpQBwGt623qWKPERMrzvpig6N5TiPpGrvO32tiwxsbEbvzk0XVObtpOihpKuy6n7M7lXv8DCUMwX8Lr54AbV91SiHaq8Y4+3clA64H2Jrr7HOo3Jh+nyRGq1eH03DVDD8NaO44anQ3QMRH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0Xn3/F5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23fd91f2f8bso25617595ad.3;
        Tue, 29 Jul 2025 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813561; x=1754418361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=S0Xn3/F5fs4GoZVbaWLCYLFGgeA8N9zFjcwBoMCJ5IMHte9WgPftey22eLgtDs0Z+n
         g1hZflzS9W/nPXXLmODYvuDHsPXDp3xfZnVp6CchyB8LbYGVEYpPCUUgiCKniFO9Rotm
         qnqAm4IJTiu3BCzjTzEsyucIzjN4YHc5QzhxLiLiOpblYXViP2J+L1wUJH9qFUOvQs+o
         9l5cZ48nvu3Y12boK05rblrcxRYfEFcsmRE9LzRythJnXIgv5UHdH046sKu7DKxiLqLM
         9y4Z8Xwk4Gxf6OQoetvXBH8woHd/BcA5MwpENMlZxgHEd4KtWWJOQnFL95OsIYe762Ex
         JjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813561; x=1754418361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=hpNMM2sqEIl2eL2C8eHcB+gUiHu9gQ8QBg8UXJEAr9uWdUm/dRj4cF/j+I1cqxxAUA
         MDsfHfsA2KQ6Jakrvq3Fi1PKWE5z6mDk4p3Kefubqj17e23xo6XfnqV1WwflE0YTJxKG
         qI0FDwMYUvK3IFwBN7X8rm2PTgz8oUBYWb8JUPS3+ZExX+x9dh+4xWpp8SLzcvFmNlsG
         AEzA7SJjJ9wLAall5BQmtVy2hSqjHjxO2uxJ2yVl68wf9MzZt9gwPLgr6wQ8F+CVlOxu
         eya3XvSenlYCyEnYqoP5fbYRel3jkphKBTJg3/nXzJflqp2eouKK7rpZCPxGQUkpgDaP
         eaXw==
X-Gm-Message-State: AOJu0YwGVVxQoIOfZcyPQatfl12s9IKtoYgtHZ+XrkMmRrXWynOvStAq
	JCGcNHbvZbuyPxOG/9rwXnkw+1DIeJZpx7ZQ1pjaMAc85aUIejb7wtlbEcLoMA==
X-Gm-Gg: ASbGncvNSJZsZJY2qvhIiastXGa3Tu4QLMiNaXaBJBmaRTAlA2KjHc/j9Q+BNo0g8uQ
	qBRDEGXpOEn8wrI6xQdYqSC45cH9D67HrkYNc7Ma623uVH8GuOMH/koReU0B5LzM2b8V4SsmDli
	lucMSEIh4GvXRTUwipjv8ecGgNxCPiE8jxVXuuUZM/JjAgkbjSp2hKH60cxRRwAJ0CxNhAh+SXh
	7kosiuRASSzEoiw5x5ExNEt6Y2hpSgcQivGyDURAHTdBaykHUYk0M2TG6WVvre1YGCEGdOhNg9a
	yBM4PLYKnnZhs7xCwxbrtuRG32P+oLX19K0Ezl6qm4DyMvHrmmv4OvBmnMz8OhsD/urMv3gJYEa
	Iw+YKd7M1VTSa
X-Google-Smtp-Source: AGHT+IGxLnJ3N+Uc5maCdRJO8En1q/K26fItmSxdCDF5gRjJtMr5NB9Wx6WGV4ge0y4J3qrCsp1Txg==
X-Received: by 2002:a17:902:d506:b0:240:50ef:2f00 with SMTP id d9443c01a7336-24096ae6d51mr5315075ad.26.1753813560916;
        Tue, 29 Jul 2025 11:26:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24099d9317dsm1059865ad.39.2025.07.29.11.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:26:00 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	kpsingh@kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 09/11] selftests/bpf: Update task_local_storage/recursion test
Date: Tue, 29 Jul 2025 11:25:47 -0700
Message-ID: <20250729182550.185356-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729182550.185356-1-ameryhung@gmail.com>
References: <20250729182550.185356-1-ameryhung@gmail.com>
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


