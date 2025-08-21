Return-Path: <bpf+bounces-66164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ACEB2F356
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618A51C86751
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37902F1FD0;
	Thu, 21 Aug 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KreR87Pk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79852D3743;
	Thu, 21 Aug 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767216; cv=none; b=tp46+X27drdjKdtY8AEFU1sviHGZN6tHbRIe8nV67Y7qU9SJt9BMCgUwuMsY/ApGtMBrK5yxCKqd7K06S0W1Fs6WYWEB63+rnrdMrA1HdEIOtl0U+uAXGWopHapnMq6jm9G4a7ET7LEqn1Te97ibKCy+iJKWFYCzwv0ynx20ZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767216; c=relaxed/simple;
	bh=THRCv3ozIqTTxq6bSRfB2pdWOOnyKsRGYogE8fXxDkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAquyXcyNNjqrEl6Lp8YHEvrAfNmv1l6f2/R3Icft2erm1WIMofi5HPalrKR+JknehacGiWwQCtunNYe7yLaoPfuxjUWo0fbqHLJqZD63u1Eb2m1FwCEA76Slod1oj5AoLuWaq+thX1/wh4EdMV7TFEr37LvfjLofsUEJSqDT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KreR87Pk; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e2e614b84so809227b3a.0;
        Thu, 21 Aug 2025 02:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755767214; x=1756372014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bptfhu7onpt0MqrEIJlEVMcozR6INxKRYWqNZ+YESQ=;
        b=KreR87Pk/8Ik1Bu6Ox2657csl6HLtmbJiP8isLy8t0WmxN0HEwI10fiuAuLGRWCSnU
         ogrv2glUrXqfmulfrweLmgmjk0DTqkhKl5b7C83vD5GSlXAKs819JVJIVKBo7/QyQHEx
         Fl7FObv34ImKWFac0jhpdcKr8rzYHapQ1zm5cRTaBomKbdNPLQtKJV4LkgJ8LpXU8CND
         W2Q8Oirwqt5dWh+KkqKhd88EjAY8DiY8urU8BKI2EiIFI+YJkFcnIJmA6VSdo7UjwP01
         qjzOZFvwZT87eet6rjxxLtxxoUVXbhvGzZ+kwGC7Pdk84NCn5fPdtqguxf5k1rffE7pw
         enqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767214; x=1756372014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bptfhu7onpt0MqrEIJlEVMcozR6INxKRYWqNZ+YESQ=;
        b=CSbAwkrBOGEOqaZeBCnhRadUgRopc52C+E+zfT4dPtDSTK7Qcn0eqE/VFc/i6JOKau
         ENz6zeoDTExiMuMpq7a+idQeyDf1FNbdgsKIXuwYJRRlsyzrgrYWzEe4xGYWn8cFwDrL
         LFwUiBOUmJZA1fmhe/pqgzXVll3Ahs3EmNm9bq0jwlI8vxGsuWcX8VW8PRpbSSyk7O8t
         UlpsBD4hWaseSBadV12H4Oh03GJ/Y0HR3FqL2ZGS6ATpK5DBXGp71gk4iwTXU/YDFveD
         5P3Em65LzMhsuUzK7AvSwF+zykw68HWhhQySyX0HLYfXkqNextG4tBQ4EDdbablXGui5
         aHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz/rlguJ0IlJ497BbLINfFhwEcVYassGS1Cwwpo/jiMJmfdai9OOWjKo1uk5RSYHBHOPmy@vger.kernel.org, AJvYcCW4XnJlqttQM+Pp3TR3UDLfX6aTrMkt7DwlhPjmEdW2tCQyba+j6psbmpZalZSLnrwOSB0=@vger.kernel.org, AJvYcCXM5cO1LdFWHmcHlSbYo6yWaRDtu3pZGOgPHE3hnT0rFvKMbqmu3/4HHYsUQmQ44n/3Q+WXT2E6p8aJOLCt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4dOi4DnjQSXVvgKuMh3t/jNFD5jSu9tKg1gvVJmpLncvlczr3
	dTCgeFBpdj1j2HDZvgI42ZaeE8HTNS2HfUmEXbs1h/zPsgpjo82l/VbTrWhVh4tm
X-Gm-Gg: ASbGncvK7lNn9gsKbegsD/AFquLXzE/eT0q+/VRNiFtC81K8thm0THKS8ypNGgJ8okS
	NTM9rz+1m/B37niM0nWUt3NXsXCLFkYxpoU99/YF6dSK4Q0RKYb7yGdx4EVVqQDwZqLb/qSkD0J
	zQMTRTc9hnCRscnFpy+JxgHDnI4vJRqEMXABcqynwhKw13YQjT6nG1zCC193NXnYrG7ZCDiTaIh
	v4JPEwUowxRNSuPJQ8TPUQfAwlxIVld+nH7rFR/bkh89d4m8j3jPzSEilTLbYiqWmeGlbfE49VM
	ZrUa7N2kEiOgXR+4ZiXEQthePpJ/u05cXQ3SaqLu7GfTUTdV0vnACeCF8RDyIh7bkXglcaMXxd4
	su3GYHH2vlsBG+zasY93WLK8=
X-Google-Smtp-Source: AGHT+IHtehPLjKwQkbfI80ZsP1KmEWzAjUsow/SIdVqqBlEBCTQwPkmBZ6twbGxRWssp77QHtXhg5Q==
X-Received: by 2002:a05:6a00:1823:b0:749:93d:b098 with SMTP id d2e1a72fcca58-76ea326368dmr1707755b3a.22.1755767214033;
        Thu, 21 Aug 2025 02:06:54 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76ea0c16351sm1708937b3a.14.2025.08.21.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:06:53 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 5/7] bpf: use rcu_read_lock_dont_migrate() for bpf_task_storage_free()
Date: Thu, 21 Aug 2025 17:06:07 +0800
Message-ID: <20250821090609.42508-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821090609.42508-1-dongml2@chinatelecom.cn>
References: <20250821090609.42508-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
bpf_task_storage_free to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/bpf_task_storage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 1109475953c0..a1dc1bf0848a 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -70,8 +70,7 @@ void bpf_task_storage_free(struct task_struct *task)
 {
 	struct bpf_local_storage *local_storage;
 
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 
 	local_storage = rcu_dereference(task->bpf_storage);
 	if (!local_storage)
@@ -81,8 +80,7 @@ void bpf_task_storage_free(struct task_struct *task)
 	bpf_local_storage_destroy(local_storage);
 	bpf_task_storage_unlock();
 out:
-	rcu_read_unlock();
-	migrate_enable();
+	rcu_read_unlock_migrate();
 }
 
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
-- 
2.50.1


