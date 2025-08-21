Return-Path: <bpf+bounces-66159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3185EB2F347
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B7324E5BE1
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F882D47E6;
	Thu, 21 Aug 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0UHY8Ie"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5652D3EC5;
	Thu, 21 Aug 2025 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767182; cv=none; b=aM7EY8hicg2RVkkSjI5PX4IdpTsmuP/PeWMeRN2WXuyH6uzB8HeCfv6XQsPgcJY0IJ8UVrUyOz44SnVISzR8jXvltkDEcxX5eEpjxjWCw6uZ4WiAEvUKz5lZFwr0TvVh8sTK1s1Nhk3YTum53rrFoUFx7J1G7UWc9kIWf3pSOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767182; c=relaxed/simple;
	bh=CWvDJIPKwSYAc3I/iU5AMVzam57FNsHXYwslc4ZapCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEqb4D4OE2YgDRcLehqFvzjZmd7aT4ZeWJtAkH08Rz1PPyFcPROmUsk3lqEMLhED6uZ9zCr8W+mj76iz0vT06UR7y8iQC8uOS5UQbt8htB0vjRiSiRCPQ+GpdKuERU0D2Ppo/6CFc2b4H0EOYLdfGem9BF/lGLBrTqnZEcQlaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0UHY8Ie; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b47174beb13so480972a12.2;
        Thu, 21 Aug 2025 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755767181; x=1756371981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XqMdeJJbrpD0AVCVJ79rjQ2osDfxBTgvdS90ysElm0o=;
        b=E0UHY8Ie32eLQ7arkYIenYz6GVAnXSSUVcB83TqUOJ3nt1zlLvXXTiy4sceW73jB9s
         yuU3+RE9wpyFvtZYVOHfA7Ig08F7Yy0eEeA1ObKiC5rXy/X42Tzn+u2nVn1dPRxeYKA4
         lPGgAp/+CCiFbG90Nb1o7Zk9mhIfJG1HYXxg5wuy6YyAJQ7TsrdMQ2KPmBs7JgOpI6+u
         ZeUdxrFbToLNKNh9gDhtOaoRzZeFXKl6H+K61oc/D1ZYiFbBbVyGKa5mfhUEmqWfn+vX
         sWcUC0pjp2XrHsVZwhaE5j4VtpO6qSqMoDukbu7swr3gTmuIEpoBl/REuFOBID0CqTVL
         LhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767181; x=1756371981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqMdeJJbrpD0AVCVJ79rjQ2osDfxBTgvdS90ysElm0o=;
        b=TO5Gv96UKxlsESfKwe+yAbXwDbR0h6z/bLOKQA1wm54mFEmrI7pdHACs6AJigvIp+B
         bBKag0mY1FiZ+NZycgnW8q+zOJbHP42bI+Crvqr7aGQNoQGR2ksH6o7YqEbXJM0q3eVN
         6F7X1j4RBYjnoUJqWUs8VthCc38XMdTLiqZJ41w2B+YK4w6yTZDOezanBgxcn8+OIIZX
         fGgjNGW2w2gUZ4o3Cvh8B2UIz3HHF4/ocdzx88yxyCGblz+klm8q/jLZv/ozSFS/32rY
         HJrMbjk9A+HYsyFOTJpsMfgVJ76TQ1J7eBFuo4RTrNUb+gHuwH5yzQSFwb+9QmcpoD83
         5FZw==
X-Forwarded-Encrypted: i=1; AJvYcCUnqfuXBv+QMx6hBc0qCbf32EC2obRzTqYZkCkAdbWJORus3YwAmDnECMLzr7ewJJOoBEW+@vger.kernel.org, AJvYcCVerA4WMZENqBMnPo/zHOkaROwu/uFSCbwHCYireZmaxATjAl14GgcdxPymJP7jbpsWFug8NSOKo1hC2bYL@vger.kernel.org, AJvYcCXCYM6MS9lkAupxrha5rTCuyEVDYZBx/J/+R5YsrVGBrYFdUEAdOQF97VNgYtBi6fTW1Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSJ3Sp+qhYSdNDY45GiHF9bLAf43MEpMfS/zeqAjZpQeruiUy
	PAUi7Ft0G8E8Kz/RTa9Q6ACt36SJxA6WMI8iPEgBKOnUvcTVPBYhXXwQ
X-Gm-Gg: ASbGncvQ4El96dgawv495Ylhj8CfeJCV1gc2p947+PorcB7Nzjt+ZglFiIz8hCoMJ0D
	duPnJIeZ+wz12X0/2Wa1X+BvnPrpKsPtIrV/PSODbhnVzubs0fW0le9j+ZX5uWwsB5rnb3wr3mT
	AhB/LQ2w1ptxw7iNQhgJGl6z3Ghks43R8Z+KhNZtLZM/S4FhSRnxxdDFbn/qhBwDqDi7axnN7Y2
	FScOtkwuxagDZqmpTbCHr3n+PTTABbIKVntYjAdiDGeR0lwa+slPJgZ0XkhbQCPeaDQfyTm8ghl
	C7aS8+0/HN6W92ROWUb5Zaxd7iNpCY7wp8UODgUcyUXYvXzGOlhbXZkkEUM9h545A20foqm4RIr
	YYvHqyLLHelWDpmu8d4N5gcA=
X-Google-Smtp-Source: AGHT+IEU/wyCIPTqv+83NxN65l3fl6dWH/C0mzpj+SCMnR4IGW9wGSGl3VEMsY/8yw0es3qIZu7Hlg==
X-Received: by 2002:a17:90b:5443:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-324ed1bef50mr2369697a91.22.1755767180600;
        Thu, 21 Aug 2025 02:06:20 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76ea0c16351sm1708937b3a.14.2025.08.21.02.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:06:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/7] bpf: introduce and use rcu_read_lock_dont_migrate
Date: Thu, 21 Aug 2025 17:06:02 +0800
Message-ID: <20250821090609.42508-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

migrate_disable() and rcu_read_lock() are used to together in many case in
bpf. However, when PREEMPT_RCU is not enabled, rcu_read_lock() will
disable preemption, which indicate migrate_disable(), so we don't need to
call it in this case.

In this series, we introduce rcu_read_lock_dont_migrate and
rcu_read_unlock_migrate, which will call migrate_disable and
migrate_enable only when PREEMPT_RCU enabled. And use
rcu_read_lock_dont_migrate in bpf subsystem.

Changes since V2:
* make rcu_read_lock_dont_migrate() more compatible by using IS_ENABLED()

Changes since V1:
* introduce rcu_read_lock_dont_migrate() instead of
  rcu_migrate_disable() + rcu_read_lock()

Menglong Dong (7):
  rcu: add rcu_read_lock_dont_migrate()
  bpf: use rcu_read_lock_dont_migrate() for bpf_cgrp_storage_free()
  bpf: use rcu_read_lock_dont_migrate() for bpf_inode_storage_free()
  bpf: use rcu_read_lock_dont_migrate() for bpf_iter_run_prog()
  bpf: use rcu_read_lock_dont_migrate() for bpf_task_storage_free()
  bpf: use rcu_read_lock_dont_migrate() for bpf_prog_run_array_cg()
  bpf: use rcu_read_lock_dont_migrate() for trampoline.c

 include/linux/rcupdate.h       | 14 ++++++++++++++
 kernel/bpf/bpf_cgrp_storage.c  |  6 ++----
 kernel/bpf/bpf_inode_storage.c |  6 ++----
 kernel/bpf/bpf_iter.c          |  6 ++----
 kernel/bpf/bpf_task_storage.c  |  6 ++----
 kernel/bpf/cgroup.c            |  6 ++----
 kernel/bpf/trampoline.c        | 18 ++++++------------
 7 files changed, 30 insertions(+), 32 deletions(-)

-- 
2.50.1


