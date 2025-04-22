Return-Path: <bpf+bounces-56411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2EDA96D5A
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE78E17CB09
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5827CCF3;
	Tue, 22 Apr 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvPc9hDC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052684C85;
	Tue, 22 Apr 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329661; cv=none; b=pbDeGSSCBUnEGKXQQgmaGpw7i2WotgstLoL9y+cJqe0LkqAFacOXK0m14fL2ZCZBay/fvzVICTHhY3X9dT9FEd1Al655SAV9vMasmeV/2gpO25NKI8VZtl5YukjWkJ0N+dnQUpFKmTTh+oxAAPl07P7Adz9M4oq3R/y1PnJlu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329661; c=relaxed/simple;
	bh=kDo4HRvvA558Eov+TuiccC+GY9aXbLYZP8MmS1f1QcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C0p3E8yiL4H/zAdogyBkuNF6htUvM1TqBswSrj0zqb6ap521AR3AxrcM0FBnEEDKxX+xOzzVIUH+vN2hYteDDroxWfLGbhqIagqgH8gA5M+9Su2ncwc9TG00JWorM4B+HqBfBGNJhBN1FQqy/nTY0wXpVqEzLx6rXSZfigVKYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvPc9hDC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301317939a0so692544a91.2;
        Tue, 22 Apr 2025 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745329659; x=1745934459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpufMGO9Eqf6bR83oPmEFAFsbu9LRNEFz1I7COzMFeM=;
        b=YvPc9hDCzm//awY17rmlxLps0UvDHc6HeZpItngBXKzo2OL/jxPhY/0UfXgTwHEJDS
         zLpBkPHuvl+Fl7sSPvZfy5IONKIkvMUTbi84l5HhW1GJkblClSRwQGTmZEFF+e497E09
         MIhJdApB0t8or5R88aMirdS4twV8jdKJMRMSbLmdZl/4jMbmjiPVTSLFK0YnuF9Uk47u
         ovTm6SsSPlmHsJnvRAJ2C7a6icyA42TiJeJh96D83E/TNm+Z5A0at+7Eu1SyE8Vqc8JT
         GsoOnzuyUEGI87JWdJsWxH2skXZrOy2iYPQkXyF6Zaw2qWL1CgciZG2gt2zpzZ1mWUNa
         c12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329659; x=1745934459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpufMGO9Eqf6bR83oPmEFAFsbu9LRNEFz1I7COzMFeM=;
        b=m2V0ClaMFjx6olAlWrZ2kGd23+JqdPhioFadgEsa45zczbhharnm84Mx8KB4rrpPTf
         gYHQpxHkcIKLk4N5wpCFH0yD1SkER5SNlNkeRXHNPfzDB5SeJqSumpNdYGy81b4sKl8F
         V7/+knVXVmdYbMb4sJO9xGajCx8zqra+ntNVSKUC9bVGcvhDpioYfFFEjN0DCXk5evGG
         aywEPPyMAGKx/sjZ0gcWWDEQGtYB5kFUl6rPSGlN9EjXnLUGqM5XNO25yPipizEutcan
         1Ig3gAWQCn6ypolb3D76t27+A9E7AWqZeJnPWzjTvlNzOaMWQJKfY+HRdc4zL1HS49AG
         y0GA==
X-Forwarded-Encrypted: i=1; AJvYcCWYXlti4yQ1NUANVcQy8iANUvqsVg7Rpux7rispZBIYyRMVx/SVh0yfcalYCO//bAeUSdFA+xnMrVuCsMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIA/SG2c7X5gXqjtGStGXau551y3nq8Hj2m0msKLKifWzk0mx
	Uw0qo9nSjCBfLXxRjoQK2OoSs6bZf7ehRapk4aPfS5iSiUCkBJkyxsD7XptLBD4=
X-Gm-Gg: ASbGncsSXLjvDTpEKUVIu7bx3gCizd3u1UMbzkIY6cgYs55XYGrxq6DBAIQ1JJq6GO7
	om/KwrEP85JoKAZRli+7ZC7n/u56WMGz5qpyuJoqBlXfp8+EhOYjosYba3f2j29wv+YK3hWKjp7
	agy0Yhc11SOFBIA63Bj/N2cfStMrtiM+Mi9f02icq04zUwR7YmrWcAza2aLh8fpguwlfwpxGPb5
	Y31hK2pPgbrtuJUAg6ewVoJyvMlz/3PZltcit6jcL8NeT3iQZIEcR149lGwnFYBzoaY0PhHgIUY
	UriPFnW2ZcLmU05vtYZY+27lQPYzoM2CSjm41zzkkOKXkqFWLpcMy9dIBU/SW28=
X-Google-Smtp-Source: AGHT+IERpLlhSwaO5nZq8Gw4Gty+WPbaQff7djZpLBz85L/dQ/SkciYvXABq8QRnCmaICpmS1/hDTw==
X-Received: by 2002:a17:90b:1b44:b0:2fe:b972:a2c3 with SMTP id 98e67ed59e1d1-3087ba5ea96mr8687983a91.0.1745329658872;
        Tue, 22 Apr 2025 06:47:38 -0700 (PDT)
Received: from MGG23TF6W0.corp.ebay.com ([202.76.247.146])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3087e05b2bbsm8695214a91.42.2025.04.22.06.47.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Apr 2025 06:47:38 -0700 (PDT)
From: Jianlin Lv <iecedge@gmail.com>
X-Google-Original-From: Jianlin Lv <jianlv@ebay.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	iecedge@gmail.com,
	jianlv@ebay.com
Subject: [RFC PATCH  bpf-next 0/2] Eliminate IRQ Time from BPF Program Running Duration
Date: Tue, 22 Apr 2025 21:47:25 +0800
Message-Id: <cover.1745250534.git.iecedge@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianlin Lv <iecedge@gmail.com>

Motivation:
===========
This proposal aims to enhance the __bpf_prog_run function by eliminating
IRQ time from the BPF program running duration. When a BPF program is
attached to a kernel function running in user context, any interrupts that
occur can lead to the BPF program's execution duration including the time
spent in interrupt handling. This results in an observed increase in CPU
usage attributed to eBPF.

Design:
=======
The elimination of IRQ time is built upon enabling 
CONFIG_IRQ_TIME_ACCOUNTING. Before a BPF program runs in user context,
call irq_time_read to record current total IRQ time for the CPU. After the
BPF program execution, call irq_time_read again to record the total IRQ
time. The difference between these two readings gives the IRQ handling
time for this BPF call. Then subtract the IRQ handling time from the
total BPF processing duration.

Currently, the irq_time_read function is defined as static, preventing its
use by other modules. This proposal suggests exporting irq_time_read for
use by the BPF module.

TODOs:
======
- Support elimination of IRQ time for BPF trampoline.
- Add selftests to validate the functionality.

this mail is mainly to get feedback on the design and implementation
approach. TODO item will be added in subsequent updates once we gather
input on the proposal.

Jianlin Lv (2):
  Enhance BPF execution timing by excluding IRQ time
  Export irq_time_read for BPF module usage

 include/linux/filter.h | 24 ++++++++++++++++++++++--
 include/linux/sched.h  |  4 ++++
 kernel/sched/core.c    | 22 ++++++++++++++++++++++
 kernel/sched/sched.h   | 19 -------------------
 4 files changed, 48 insertions(+), 21 deletions(-)

-- 
2.34.1


