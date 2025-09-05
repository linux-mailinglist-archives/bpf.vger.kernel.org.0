Return-Path: <bpf+bounces-67542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7349EB4521E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06B27B9F67
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1CD3002C4;
	Fri,  5 Sep 2025 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DB3iPdmH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248227EFFF
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062404; cv=none; b=AEI3lDmgTXldQ7bnefOKPpEXAWCCfQkDA0C9hXKZbLvRyATvJ6HPdKljqJt2OcBVmh3Lz7bUpD7VBUkhjU0Sqa/uYgyjIx89kapbt2Vs7encLcZQVEdA0+5Vhxt6xRIdRw5d6Y8vcGKEqZj6YqfNPPFm/P6kOmQfUhIsitq63e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062404; c=relaxed/simple;
	bh=W8rkeHMnAQiNL5TXCMpYhsBRaeqWZ11W2TssHN4Njy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLsPr+qapWGMrYKrbeawaqQGGyE1GpfV0PM1knCXuTsD5PE4tixmPt9/iU5jGr8P5FyBLMW3aKsUXkRmb3ofrrGgYsOykVJ/SAN8k2xAkIiKWQOfA9eJ54GmGS3x2aRx2V3iO/XsZfseWCqDL+vBMOmdFyyYgSm0Y0i4vJGoFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DB3iPdmH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so356796f8f.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062401; x=1757667201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4w4I2PhZfugEsf65zQr1izgzygfDr6Fh+OGDwdwPvE=;
        b=DB3iPdmHOX0Q4aknJT2NxZSTounG1VcaGuc4nPgvhgWCrbjGfUOEeW42Sz0VAiiEzi
         FGpyK/BvMvy9AIxRjeqWVqZm3N/E7tgABIYozGGeU2iLjxB3/+rGgWXZDa1VVR2T0ABK
         eLQA3pqzi3aZIkGPAdTvefZZ15BXrVOan6A1/jBXAhn+nuED0TavkA+D7rtd054c0CWC
         1ZNm29wYXA5KRS/4Nlg7hjFaNumx8pXrh5YFd8vD6Qtb5rx70W87lK7fQeU6Hx94nhcV
         BDe+vLIKyuJYErBOlBVil57XIg1xB23Hi5uypdJVcELJ2w96CREdVmDHCUGsQYVZiPkb
         Eh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062401; x=1757667201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4w4I2PhZfugEsf65zQr1izgzygfDr6Fh+OGDwdwPvE=;
        b=lhor3cWjWPzo4QgfGw6Ry/xE7R/NBHZLR4rDiaGkMjERchYQ3uNERG6eyfalGfIkWd
         p5BE9YiTKWJpMGjz8k1Wz5J0s+K52iUkNPo1+qwXufWYt8Jccbq8JvPcLXB0aE8fK1j3
         x/S3PvdcN9XO4Nn0pTPpFWZT/du3yzQ98pMwJmkcA2Q7AmQlMFyAGD3s/PYAPqpShwuP
         TfUL0ZeeJx73X9+xKcLDw03EvuRp8oZEoFAHpmA5D0tiBca71y+0CznBum9nf8u1ZYqO
         09tyB8QfR4cfhumDFahzbheWoWNofMknHAaL5YV7qxC/KyBAHq5CGZ2+C6hevi+OQlrs
         6WLw==
X-Forwarded-Encrypted: i=1; AJvYcCUpm+YfShpaxaAGdakrYNGiAAiv+iIiLqhkdox9ZKqzK/AGA8v4OETFJPXQS52r0XDnWQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0+WRifplTjQgzjZPdBhdtUkhqAo0v8q34Vl7/tWiU+igWZBu
	GiZ1vaViHUri/Zf180pAPQWlNXeG9iApR5KxKQV6VMJhqsx+BFgVBJiO1ycocBlRSNs=
X-Gm-Gg: ASbGncsE3FRddd6qYTYU6j/UUpPBonIqTjN9ZxylOMRmKi32xOcQeBIJRXu2khpFfIM
	7oBW8r/Mb4if0MSI4IR7AKMbA14DrHh4Pmpw3PffmtMWoLJ7oDW340AupG5DJUu4+YaSKAbPzj3
	bC17C8uuEbdGTKMYnB63QAxITv3yqoRbmN6y+Owrp2KShVIsU/d7jAoT2ovCnGFQUD4lKXWRQVe
	uYnif89DIFlytev5yxvkKmzaDqVW8GHk4X0lgycf81L5qhjqjsEbFCAlAJAcc0u0epmBsTmDAOJ
	182L8J1vcnqmYQRLKUWlzaQahjC6eC6Jdt/OwLAsGgv9W4N1A0mtt8WDERb+wnz1u2349yByCjW
	Hlaah79k1YUQY72nrmyKPmjGO6eJP7dXDDwsvuDNF1CGtL68=
X-Google-Smtp-Source: AGHT+IHAPBq7xU49RVmyZuNkgKs5XNvwffYebUDN+GlyR4iPM5n+1fyqz89q6Tvk6cvzJeZdECfdrg==
X-Received: by 2002:a05:6000:2dc3:b0:3dd:981d:43a5 with SMTP id ffacd0b85a97d-3dd981d44a3mr7575676f8f.47.1757062400876;
        Fri, 05 Sep 2025 01:53:20 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm18487293f8f.8.2025.09.05.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:53:20 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 1/3] bpf: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 10:53:07 +0200
Message-ID: <20250905085309.94596-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085309.94596-1-marco.crivellari@suse.com>
References: <20250905085309.94596-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/bpf/cgroup.c | 2 +-
 kernel/bpf/cpumap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a..b8699ec4d766 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -27,7 +27,7 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 /*
  * cgroup bpf destruction makes heavy use of work items and there can be a lot
  * of concurrent destructions.  Use a separate workqueue so that cgroup bpf
- * destruction work items don't end up filling up max_active of system_wq
+ * destruction work items don't end up filling up max_active of system_percpu_wq
  * which may lead to deadlock.
  */
 static struct workqueue_struct *cgroup_bpf_destroy_wq;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 67e8a2fc1a99..1ab8e6876618 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -551,7 +551,7 @@ static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
 	old_rcpu = unrcu_pointer(xchg(&cmap->cpu_map[key_cpu], RCU_INITIALIZER(rcpu)));
 	if (old_rcpu) {
 		INIT_RCU_WORK(&old_rcpu->free_work, __cpu_map_entry_free);
-		queue_rcu_work(system_wq, &old_rcpu->free_work);
+		queue_rcu_work(system_percpu_wq, &old_rcpu->free_work);
 	}
 }
 
-- 
2.51.0


