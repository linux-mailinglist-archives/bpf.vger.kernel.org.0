Return-Path: <bpf+bounces-55665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 118ADA847FD
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A884E0A66
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F131E883E;
	Thu, 10 Apr 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I281slPa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A31E5711
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299109; cv=none; b=dNujk2h2/kOxRHi+h1GApKGQh558mGvyHKxrWqijTknOGuOOFelAohEOZf9vqU4hhWmZKi7/18c8AnAFUcf8rp8tmrPBuKbtsBA/2PGBDS2UanZoaIkTl6laToXsuQAuYwMVRfGyFGTkxALz53OSXnonN1pNoeaVIeHwqhlYMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299109; c=relaxed/simple;
	bh=PMs4rk/Tqsirb7Pbos5AdTMXb+cE8EHw15I2J+YtdYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5bp7Ey/mAdHnbjNPjzXYFP9M5jo8y4yTrO7l9LPFsUAzGTB+Xn+rJREHHAMRHyyiqLQSv58OLYQ2DSGR5PiHIKIvaX+XEZ3dlXsyuqkVFRFCMzEx9N+ttoXMknCUlq5aS7+A+5nF82cjF4xNAtjxRsQ80wxNRjygxzsRIXdDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I281slPa; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so8066635e9.0
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744299106; x=1744903906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJuWJh7Em0gsPfnccn0OcI1FF2lD8GoEmE7F08ShsRU=;
        b=I281slParzwErYjCZCaPXGgDJHXc3kCaeUFsnwTV0G+h3Pun2z+ueVe2Qbf6JPiCUc
         p6D9DiMcHpcBCtDznL9yAUh7A01Q3QCQJukYx61OSeomOx1egkZRiVy9RO27bGoPxBPQ
         QaZtnTLSso+COxLnWyzylpEbA6fFip0O24Xz1OAXQ/7Nmj8GmVFJkt0Q/xdfUx9qatRT
         tiby6+gHlg6qkerecStz+UIjqv7wFZiZTqjLDRyvrqtWQfIr4aETcYNtmKKpzyGl6pcP
         +mySApYnA8W0hP/mAdQfWgYUk2OeAdDXhlC7lvZhtFWdXHEbXtD35j6LIAaaZhFntWTI
         xonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744299106; x=1744903906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJuWJh7Em0gsPfnccn0OcI1FF2lD8GoEmE7F08ShsRU=;
        b=SWfLKkRtgK6dDznxJNC2OrIubqfAD0BIb3+kDVS7R10yHF/lfAJXJa9eMkJobZzhxT
         8q8THA/fQzqo8pbVX+u1Bk/IAfJpLzj4iLkoKF60WA2l8z0XBkle0qPTERK4Z2/cFvgr
         iP5b6Fuckyj9WDZ+USsKw0cwc6XEo9qOuU6eY5Bf6NtCYIDGGzmdOpAgxrhWo2qkOnsU
         UbJgLWUYSaCoomUKENfSaEt5kvGhvxQTqbgXy7XCQDSrLYcMPGyv13tPNy3C/Lhc7Ejk
         7ISEURmiFh2N13Mi2FBiQwFyaK0BKNj+ibIEXCro+u2UAIJzqFeEz0xPltBFkfzFvkFC
         Oqiw==
X-Gm-Message-State: AOJu0Yx0LMR0EV/2zjXAI1yj3Sp8BvxJtk2kpQl0oqWRmBRHS6mW1oxO
	o8cnjjfoAKd5U3A4TY63F6ep6cNyxf5WmLDTh8B9ltRXH+xrHO+sOkI4s733htM=
X-Gm-Gg: ASbGncv+bkAQgpPlir7cKRc6eY5GV5UnJ00Z6VsucMvQ4l7AY86zagPOXQyXPPPRKDj
	ziNOcVRCJE08eFlMi89xQF2XyoY+P6iG9sKLbJUYFARJkega9tIuXw331N6LHlfPKAtgsL9/TR5
	Eh4LxE6/DrGDx7hu+ZGbYwt2PhcO0HlD0QvrhMgECerq7sxfDYPqmOwcM16bWNgj7gtY/Iyp4cO
	d569CjNHerteL69qhg5waUWkD0YA0lREcTRZRIdOlcE/+M978WAwYcSwzM6AiaYLJbnhW/0YgQu
	yFgfdQuyAOweti2bhqzWi0p/DZw=
X-Google-Smtp-Source: AGHT+IFFBYI+7lz+KAKXB+wn4nKFNzR5Gr4ZNfxE9nr2GMTbCge5tZcaiaev6pDGapFvrTbDO5IAzQ==
X-Received: by 2002:a05:600c:154c:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-43f2d7bc1a3mr29445735e9.11.1744299103977;
        Thu, 10 Apr 2025 08:31:43 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ecf30sm58758485e9.1.2025.04.10.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 08:31:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com,
	syzbot+252bc5c744d0bba917e1@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] bpf: Convert queue_stack_maps.c to rqspinlock
Date: Thu, 10 Apr 2025 08:31:42 -0700
Message-ID: <20250410153142.2064340-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3970; h=from:subject; bh=XwReuk8KitiwSUv0J7Gi6WLqcG5HRiT1aL6I4XU4vZQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn9+Q2SbGWdog5+PieuS88pBivKMTPvghiekYnvsTg 6q/vAm+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/fkNgAKCRBM4MiGSL8RyjtWD/ 9C+Joc1tw5ubTBqI8L84wpka3kH5IcnwGjBumDJlscNMDCIrQf0uEnfVlR/+5+dAIUsR3rv8cIXnUh WfzSUyMco4wNG1A2r4JEw8jboBy3mlsbP7li2ebrbCxxwfnCKdLw+NHYocetQJdcAohFS7KbJ9Lw2J bhLPQVKoafqS0U88Uq0jIUqOZ7C543OfjyNekVQKN9TMvVq6vxKN6R8Lb2FREytH4a0D9718M+Q7oM jdQX51CuMRLjZ1ZD3FedUP7gxfKwAlUCWM/RUbDl8k/6lXuk1l+sN+9MAGF3YnBzUHTiRNd36l/3wc oJRCFHxWfUTpoKtjLfTklgAYOefqKQPBRWttbAmz1ml4eNXL3Sm1LLD3O0NRMzWXcE+fr9ncaB6sKa im7BCWHwMZYKsEitIityI86GUm6Nr0Cgv5QuRavTjX9o+/lHKrfxBT3klBn0TrkfjOb1zujNx0nKrU SDqoISVeihOVtr4Xt8Wmvto3TITcIv5W2IDn/fD2e3mlq2Vtisaohk2zOhUkQGxt+/JVT2JLzw9X0g yWqO9M8sjbxBINvE0ZLrI1MrW9hom0wl6aGpzNlfTwjNtzR2guOkKA+w0aBktOJoIU02A2PHaLuItB x7MSNShlmokfV73jCHEEGd4c0lQvlK9bvrBWQl1mHDQZu2L8qpgDahZ6CoNw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Replace all usage of raw_spinlock_t in queue_stack_maps.c with
rqspinlock. This is a map type with a set of open syzbot reports
reproducing possible deadlocks. Prior attempt to fix the issues
was at [0], but was dropped in favor of this approach.

Make sure we return the -EBUSY error in case of possible deadlocks or
timeouts, just to make sure user space or BPF programs relying on the
error code to detect problems do not break.

With these changes, the map should be safe to access in any context,
including NMIs.

  [0]: https://lore.kernel.org/all/20240429165658.1305969-1-sidchintamaneni@gmail.com

Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000004c3fc90615f37756@google.com
Reported-by: syzbot+252bc5c744d0bba917e1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000c80abd0616517df9@google.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/queue_stack_maps.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index d869f51ea93a..9a5f94371e50 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -9,13 +9,14 @@
 #include <linux/slab.h>
 #include <linux/btf_ids.h>
 #include "percpu_freelist.h"
+#include <asm/rqspinlock.h>

 #define QUEUE_STACK_CREATE_FLAG_MASK \
 	(BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)

 struct bpf_queue_stack {
 	struct bpf_map map;
-	raw_spinlock_t lock;
+	rqspinlock_t lock;
 	u32 head, tail;
 	u32 size; /* max_entries + 1 */

@@ -78,7 +79,7 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)

 	qs->size = size;

-	raw_spin_lock_init(&qs->lock);
+	raw_res_spin_lock_init(&qs->lock);

 	return &qs->map;
 }
@@ -98,12 +99,8 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	int err = 0;
 	void *ptr;

-	if (in_nmi()) {
-		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
-			return -EBUSY;
-	} else {
-		raw_spin_lock_irqsave(&qs->lock, flags);
-	}
+	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
+		return -EBUSY;

 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -120,7 +117,7 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	}

 out:
-	raw_spin_unlock_irqrestore(&qs->lock, flags);
+	raw_res_spin_unlock_irqrestore(&qs->lock, flags);
 	return err;
 }

@@ -133,12 +130,8 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 	void *ptr;
 	u32 index;

-	if (in_nmi()) {
-		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
-			return -EBUSY;
-	} else {
-		raw_spin_lock_irqsave(&qs->lock, flags);
-	}
+	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
+		return -EBUSY;

 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -157,7 +150,7 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 		qs->head = index;

 out:
-	raw_spin_unlock_irqrestore(&qs->lock, flags);
+	raw_res_spin_unlock_irqrestore(&qs->lock, flags);
 	return err;
 }

@@ -203,12 +196,8 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
 	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
 		return -EINVAL;

-	if (in_nmi()) {
-		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))
-			return -EBUSY;
-	} else {
-		raw_spin_lock_irqsave(&qs->lock, irq_flags);
-	}
+	if (raw_res_spin_lock_irqsave(&qs->lock, irq_flags))
+		return -EBUSY;

 	if (queue_stack_map_is_full(qs)) {
 		if (!replace) {
@@ -227,7 +216,7 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
 		qs->head = 0;

 out:
-	raw_spin_unlock_irqrestore(&qs->lock, irq_flags);
+	raw_res_spin_unlock_irqrestore(&qs->lock, irq_flags);
 	return err;
 }

--
2.47.1


