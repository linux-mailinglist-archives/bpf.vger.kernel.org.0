Return-Path: <bpf+bounces-66165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40230B2F358
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744AD1CC4E79
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F472EE279;
	Thu, 21 Aug 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh8tueuh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D88285073;
	Thu, 21 Aug 2025 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767222; cv=none; b=jlA0+6PPK2MjV1FezMuO/mJ+nCVlxJqOpLDWPOJbR6kub0gtMp2leXg9AbHW2B7NKb7LP1k9I/fVIaTwnmnVBG19p6eUcW+baiAcIyPFbw3jygK3llrCQIVqyZ6SwBouCjaXujyjFfdJa+XfgpLwoC+L5/ofzFUFfUu+1Yup0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767222; c=relaxed/simple;
	bh=fhjRoedQgU3UpqJ/vxJWw+P3CekwicN1Qc+dzHfUufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWLAqSIvz6J7pmCEWWu5AFnehqZImPkIhyiil9UFPryfp/dYHBSurV6JnkvK3XCzJI8/MRxU8fitoXl6mn+kUMq62X8GeMuqJ8vlwZuMCWXuA4z2Nkl/guwkrrRGUj57zqUi5/Nt184vmc3GKiX2vDyJ/F0Ko8GQjhidL5+f7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh8tueuh; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76e2e613e90so603815b3a.0;
        Thu, 21 Aug 2025 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755767220; x=1756372020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5H/4foa1XV+6AOUTU8S+hYtTzGYqXPj/gnpmsQWpYc=;
        b=Nh8tueuhLrbkJFwOikavq1lcfq2THU3ddm/qpLYO3M/KxtOTlg+AC+pYVVEXsYivbp
         iMtYw7RMo4gcTyTapA8F7DKFtWXvEPdKNe7YYVx8Uy5Ui1hb3EsR0RvrJeSljJBFRjL3
         nAH6g/pdSXCynSSxZVP5EMGj77LfQKksxIVwRO8vsk6mVK6xZqkDLzFXGEBcVTfz1jP0
         1SudHmXAf0IwUPfH7+X5+KHZv0G7GVMyzg+xeLp0tV2qS5pswqwuVQsp4L5WFX8r/eO3
         XDOUVsWuSaywiabWiwHzJ+MfZZDuTxELoUmXrMleEMSZ5SjyC0FYYJxPL6vAYPbnv814
         0WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767220; x=1756372020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5H/4foa1XV+6AOUTU8S+hYtTzGYqXPj/gnpmsQWpYc=;
        b=Cy7IzdQT5OMfyb8LP2dIFvSmQnnBDoGo/c+bgvcIPBnwfeZelGMZo7lHZFUA04JWkg
         HOQMtDMSrAWdkA8w9YFii21YavHzNx/jPEyqAZTOeB1aK/xl2MUrIBloOy0l/oqXeOWd
         eiBdaDVN88mVtHGG6KVsLANOE6deMqWripKRZCvTeWH4XQ1bvvaUtOC125aV0PgUrKWD
         sDd+KAmX1I5iX5AGCc092HbHUhAvVyZ350gYe5eMTJpg9r9HJB7v1iLF2YscoAZBWf1/
         8GzngJ94J/Nv0PZf6XPT2ck2JdmPrMAkkGHCbAJvKw12aEzU9tjWGVDZhD64vX/XIyDp
         RLQw==
X-Forwarded-Encrypted: i=1; AJvYcCU16x/9Qhg/dd1FJXxkWXS+u4LqZYDIYqUSXo2x3iNvBkJ/VY+f7P/9uK4tNL4lWpjzlqg=@vger.kernel.org, AJvYcCUbnjJ6FakY8ymdMGv8pvt+GtZ3MdduSx7U9Vs8uHr+EHLhLO/KieZM8oK6UulNeN708F9S@vger.kernel.org, AJvYcCWkD74OkcU4cJcZJEe8y4W6oDu/wHWl0C5fPsGCvwwetYTePQEj/Q7cjoqWzLgrai7Fh/AkIPr99faXufTi@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAbmfgOdVzJIx8/9I07kCJA22BtuyymydrX3+VBGjTkIKWq0e
	lNEfXNm0lOdIuQiERYy686VQPp6HZYNRutP7yn/dfDvCCviqYh5xcih6
X-Gm-Gg: ASbGnctHeqj7w1yccpvZzXnkIqfjhsMBHOZu5rpajKSTtEqYfhapNDxVYgAxxUilsRq
	SwAUYkYzLaYkNn9HIyOWQlVaydEn38BNlOqYpZwWTklEbefzvr15s+f8kbBXizQy98WibUHpWo8
	7ZAA2FS99nK3iSxjxEGjAgaAx1x45908mD4Fom9S5I0/miyiPAZp46iee3IRhgs/uaeumVAcpdh
	S6leJnYLuB54hHhk/xSMOHoIPTqO+GXGK58dUMkE59/9Rc8X9/pjsLykT6gkj/c8BQ1ODgzQEEk
	zpFUdnShd9vcuO8PD1nuxYf/j2gL7Yq1aThxQA/g5HlHTJAHNi4qMi28zrWUdRrOobEb/Az8CWf
	5zp1Sqhn5+FIvqEdPgWUGZj8=
X-Google-Smtp-Source: AGHT+IGe40Ad65Vhn/3nzydrqmDL8HgKANG9G/saMkqzFmwS45QqlSxHnNhcDOi3+PI23Wqs6ssU4g==
X-Received: by 2002:a05:6a00:c90:b0:76e:885a:c3f1 with SMTP id d2e1a72fcca58-76ea3283b23mr2208384b3a.29.1755767220200;
        Thu, 21 Aug 2025 02:07:00 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76ea0c16351sm1708937b3a.14.2025.08.21.02.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:06:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/7] bpf: use rcu_read_lock_dont_migrate() for bpf_prog_run_array_cg()
Date: Thu, 21 Aug 2025 17:06:08 +0800
Message-ID: <20250821090609.42508-7-dongml2@chinatelecom.cn>
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
bpf_prog_run_array_cg to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/cgroup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 180b630279b9..9912c7b9a266 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -71,8 +71,7 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 	u32 func_ret;
 
 	run_ctx.retval = retval;
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 	array = rcu_dereference(cgrp->effective[atype]);
 	item = &array->items[0];
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
@@ -88,8 +87,7 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
-	rcu_read_unlock();
-	migrate_enable();
+	rcu_read_unlock_migrate();
 	return run_ctx.retval;
 }
 
-- 
2.50.1


