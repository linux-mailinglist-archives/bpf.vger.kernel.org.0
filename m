Return-Path: <bpf+bounces-77022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B53BCCD14E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 503DF303B7F7
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827E3064B3;
	Thu, 18 Dec 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D63I45tA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263030F542
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080610; cv=none; b=rB0/5xWKtS+1W4C3te++ljI8mXzJlXbqAhYsokKdmJOlmoSYubtYF1ZAI4irN/wAPnbQeFYUVvC2e8j63r6IUvBRxDZF+UHqYUivwGVzY4oZUwDfilHtHVwOEzFAMI4SPvbMYvdkjD+yHqodbuk8ls/rJFFm6X9xzCgd2qyx2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080610; c=relaxed/simple;
	bh=UlL8oZQzeYpieEW9kR3O2tWXV0IGuasLKuUjGh/FzsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2Sxp5AJjsQMuEeAzaHWPhDRCgKpwoDj4Z5j6ABcd/jRg1x7jH9Y+7Ynp4YEPJssFpaVj8HGidhpv5G4OkiNVLoCPU5atoUSCd0xIWgj8HpiUXJ+hZLzaFH37X7BKN/tpMV9hz84YlfwlY+rWTy5n/LK32YtjMj081hIJPqafCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D63I45tA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so1123523b3a.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080606; x=1766685406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=D63I45tA4bT5yYOWk5wSjiYYJ1OGdl8kmxwmtRvLfGxJ2ZhzgzzJWsZfPIQ2JMdrTI
         A9setnU/iCmr+L+F2bDxEGpvx+hM79YtkE1gi9FrGonhy1eTpi3eUoWv/8XJyQrtDlXy
         yefnh/8M4fBINVBwygAJqYnVZOT2krkaK5G3p8FfxgBZDwVXl9MdGpBYeH8sFMRqVG8E
         RfBlRrzG9wpaRKjQ+V6jFq8CDXFP7pfXvyU1mW9XMjiip4tq8Cb97ehDnish6qUdh6qK
         fvGOKep+A/ziTsSp1+XSYfMJxhKYtjpTwXiSRm1IR6Sqm6gWhCbD2ss66ejbYrfZoaGL
         RF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080606; x=1766685406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=dfwerdM/bJ1nyhK1BTJTnVxsvewrEK8W3ScJ4eKjYYOUmd5YbpNPcuyUDQseS9gjmE
         Zxt50u8c4+w+UBbcHVsVo1QgBmwSW0ajgEVUxwuREH+TgYz+rP8ztTR5WavwTwOx85I6
         7EqDz+IS7sU5JQjuizqeYm5qgGrfth799pF/gQv+yf8EEObLMw07iaDayg6ID7bcmesi
         V7SBN6KAkoOomLTXRcONnbu7xDQN9uA9cuJx7dlybTKOyuGLj1p+lsGYrWwyqRZrHrA/
         wcuUHi5HC9sMPEPyGJRATpOG758EoaxqH6bFQna1vMZyq88cDORG1EMJq3zc/pSlJB/X
         8boA==
X-Gm-Message-State: AOJu0YwcoeR9iuAx5lEJnUnIv3lyzh/o9SMkOL0H7r68mD+m3Y5kkF0K
	xT/o/i5mZ/Hxs8Ar5+U/ZlYgNDBdfM0yg3FUj0I48GWTHLJFg4gGqAls23D1Dw==
X-Gm-Gg: AY/fxX6NopjpzE4J4Qyeh0ozULN8fZKwhbExpWA+KTurZ7PPgVzUU0GM7H+qoYdw5n+
	JGCkKkuQqosL7NgWALn7vHlj0eD2Njw8HTs5CPT9OlQWMSkKl0UpipCx5Zm6ROYtQ3EgXdGXlSl
	5rblnW6cQswoydhhVmpKxBXNrVFeERIoflP9nyXF14WRQbdEriM+Jm8vzNNhvwoyurN/WRL7MQL
	uJNL5U/B4nu+6WU3B/R1vWmF3pmTIxJHI6gLXRtCCWrClVCg1XdSYpwQQEoUf2dThqXDJMk7yhI
	8IoyyfaX+v/Qrdeonp7xjG3YaKB/nDnVr0Wh028V+bA6J05GR5gLQKdNDta38dNrCdvCWGdTmFX
	de3WenjU3zBv3VyRAWEoIy8SKdWgB+jH32L9sYQcb2G+SfikFbQ4nPz/LV8dZUO5b5Kfs1psYBl
	bvDOrTp++dpMuz/g==
X-Google-Smtp-Source: AGHT+IFTjgtlkDemqs+dvOOYONaKwxLhvWtwwwt8fpXlE/n84Z/q6ibHl4EdBIp+ZHOUGGm4YV2QIA==
X-Received: by 2002:a05:6a00:6caa:b0:7e8:450c:61c2 with SMTP id d2e1a72fcca58-7ff66679603mr157608b3a.50.1766080605765;
        Thu, 18 Dec 2025 09:56:45 -0800 (PST)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe14365443sm3227030b3a.50.2025.12.18.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:45 -0800 (PST)
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
Subject: [PATCH bpf-next v3 13/16] selftests/bpf: Update task_local_storage/recursion test
Date: Thu, 18 Dec 2025 09:56:23 -0800
Message-ID: <20251218175628.1460321-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
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


