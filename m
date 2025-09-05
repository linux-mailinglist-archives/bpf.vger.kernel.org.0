Return-Path: <bpf+bounces-67544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530BB45221
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F399F1C24010
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D54308F0E;
	Fri,  5 Sep 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dwjCrxb2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83E1FDE14
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062406; cv=none; b=A54ZIIeQQU4dKtx3dgoDF0ON9DarMoOvARp7FLV7OsxOrJEm33Um9blBHY5pL2rwbYsrKf6Dj/jSEELMZrhaErxLoe2KeWEmz3J+t4xhjOZi3EhV8Rr3bEdNZRctw4GARGsraVbufNfTmZtju49l4MExn6rsAw+Qw3C1b9SYI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062406; c=relaxed/simple;
	bh=Rd5E7VX8al1/yxlM1TCq3M2KFAf74BT5deQ9L5tNQys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzQD0HlXUxbOOlpGQP3fXL5DLcEBsx+f4izAK5jP0kuLijHifVbkqYBpImR0E7B6/TQ1+aFUA0j5kWTCDFDma0D4CM4InxG4NnpftPd+3F2jcWRzHaeJH5IStW6J2u2dEtY/ve3ffC4aHY9BNJf9HCKYrlsWigCxxMjI/wBEWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dwjCrxb2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so1272438f8f.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 01:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062402; x=1757667202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkkrYyhxJd0RflEiiebzkXK9jZInfTGc63Bh8fEciOA=;
        b=dwjCrxb2UpKIo4nyhaMr91Hyq6A4r/8LcvaiutyrF38BS0nhtsvy4xHh+mNhFxCU0R
         aIskeOm7XxRTZD85+aqbc7lsCJ2HKBFmNJ7RtMYaM9w3GlNCH0ZGlY5PqMyr12rgIDsi
         UVUIATAGgyhEPHwc3t77hGQpqw3Ii7+AuDoSclQgt95U1ytZXh8iFtuEvE7Z91hvqjZb
         56Pa2jXuD7JgmWpWkrening0pMjNeLliIOByXCyIFze4F2pYWhcY2bgmPdly0oseoGhW
         cy4pn4c4xsYoKskl+zcYglqcNerMakEQlrFFle7ESoRWt1zxvW00/3okobcxfkt/ymDA
         W8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062403; x=1757667203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkkrYyhxJd0RflEiiebzkXK9jZInfTGc63Bh8fEciOA=;
        b=tdQlDPAjAxskoZ67zQIOuv1424ZIdFCH17jnIMBsoeqMijdWiPPyyhHWbB7nrWjmAN
         4omJEvpwrdJmRy9iz8ahsDYLfwhvyLkJFNOpb5BfkwjHcKQ2+ZKur92zrDtbWYyl5OqZ
         9xcbHe3JpCdOw8Y08bDQOkJeqAi53hVsTomA363ei9iIbNmv2IReeIg1arKGfpDI2E+m
         vL0NdIQUJ+XBVygwBeTiqI34JtUU1YlGyXkv+badQM8ZeyC0hasHls6zyrEIkp8bM+1Q
         D27Iv5AnvJUKuYs7tlDuylSFzboYU5iGHJYcK+pgwWwGBMeTZ2rPkmiocnUaE/KBg3tG
         nD8g==
X-Forwarded-Encrypted: i=1; AJvYcCVZKSPb2Du1T74M5DDIuoM2eMjydIJDqI7mLe9hO5YLfCaszOlFgsC7GAhcG6MysEBjcr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Kfk9rNmFFs5N1joezrh8cA67YbMGKmCFBSH5N72BWhAe3+QM
	QF0WYPufMrZkcE9tnOG4PKbojtZ41NBGnUH2Qmc2C6zH+oM1o/n/LqsvaJ6Op7NMRIo=
X-Gm-Gg: ASbGncvVs0NbtYrDg23D4K7olWmVUzV8B/1+SuLhBKJ2MX64KX/xFg00z3lwlqqW4Og
	jmuzK6yh2OYrc4/Un7UswBdW71q+r+ietZ9m3n/g912SvkSRCNQ8IjrCfwg9xaUFEnkBVhB5ODS
	TWrCHCfyI09G9mr+ENUwUQWmzy0ClPDpwWjf7b1uQCmG9kHz+PcXxT2adnCXUrYc1RVW7y+U4mP
	Jk3PbQVsIGnDqfAnxaGpJtefc1gPWtGODU7z4Pl4cnl4t9hToDuD7yHCxk+waglHoF1duPzd2rC
	uZsQkHKS5aiArvL9EZ1AsQ6mjeEhhn2B5vX9H/EUVfScHVJKptyV3DUaj2C1Y6fJl+s8NKEHvHx
	R66EYJitE6PkaUlxsgKQ7eL4hwGI1gZyCOT8aHnFrVHKuuC6ZY+uUM9fFRA==
X-Google-Smtp-Source: AGHT+IG4QQ45lKCN+n0HyBk6qgrsjQ/B3l2iLMhuDOogHoANzxh7AVdJOxYPMBT0wed4ztKRtHT89A==
X-Received: by 2002:a05:6000:22ca:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3d1e06afa9fmr19056043f8f.53.1757062402553;
        Fri, 05 Sep 2025 01:53:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm18487293f8f.8.2025.09.05.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:53:22 -0700 (PDT)
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
Subject: [PATCH 3/3] bpf: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 10:53:09 +0200
Message-ID: <20250905085309.94596-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085309.94596-1-marco.crivellari@suse.com>
References: <20250905085309.94596-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/bpf/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b8699ec4d766..f3da9400c178 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -34,7 +34,8 @@ static struct workqueue_struct *cgroup_bpf_destroy_wq;
 
 static int __init cgroup_bpf_wq_init(void)
 {
-	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
+	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy",
+						WQ_PERCPU, 1);
 	if (!cgroup_bpf_destroy_wq)
 		panic("Failed to alloc workqueue for cgroup bpf destroy.\n");
 	return 0;
-- 
2.51.0


