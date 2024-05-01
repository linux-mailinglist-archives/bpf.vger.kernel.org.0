Return-Path: <bpf+bounces-28332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602708B8C7B
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923A02826E1
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9087B12FB07;
	Wed,  1 May 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIeImjya"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2112F58F;
	Wed,  1 May 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576404; cv=none; b=hfu4Iwco4hCaqIX7cgucq2wwEodUdIpc8DYgO+EhNfJqjvQEAotpHbR4AE9RLN5u/PjJrM3z288YvgDHGSwlNjZo6Ti7ulKF0IDQQZ8JHcFxYqLyVlx5YtCOtcKjc/uFKsgqJolp1b/IaFlp5CebPyLP7xvJww6FUOwipbAfRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576404; c=relaxed/simple;
	bh=T0vOlbDPkY4lzYVSLTE1Tc5ZfN9Ud9J22yFFkTIe4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWIDl0rnZHR6mUwXqAckz8p4JlXsDMW5KaYQqPJs2YlvLdlDxGMipjifJDUxObF9dD+Ur2ucA2KM7qU2I0QuGd77A5AvpKzjBdxHRYthv0biaCiwL7aF/zotuPo7gqwmqLVSMsxcs3L/LO1EnRxEDaGlXZr3BTdKBQ7vfB5P0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIeImjya; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso4672207b3a.1;
        Wed, 01 May 2024 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576402; x=1715181202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qieQpyGEZBe+Qd+fy2O5zG/b7fhUyu9y5FuGpG4tpc=;
        b=mIeImjyajka8NL+9yzX1Whm9wwo6HKGTNl1Vuy0V/wR4E72DfGnEhghRW1H6PUY8Wx
         NMeLMDg9dcZ19R7jlGY6BuqCoqlQU58ZiFePlevZnFh+6nl6iMfi+9c4INvjxw4h3L0Z
         PncTLWei8Qs6mcF0iwGTbYVZi7JhxNCXfJlI9fGd8UMsv9r6zxMe7k4Q6BBXb081SmC7
         OQNIRFks3InWTTSrZhNLgnMIS+3ycvO8WUFxmdaoWR59BIULFSRVy/47bLoIKCgaN08o
         trOr7iF4v7H+AJuRyL+DkEBmhxV02j5VSzxfuj+MVvp4GySlxcH629z6HGx3MGLe4KKt
         6Fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576402; x=1715181202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qieQpyGEZBe+Qd+fy2O5zG/b7fhUyu9y5FuGpG4tpc=;
        b=rLvMeVDnBO9JbTyHJo86/KgGe47jngyYbEdxraxk5YHYGDZ8Jn1dAsd4zFcNXZo1tR
         3AAolPtFU/XVyrg111l+rMC1x3qv4oXlXXHVg9qHDe7Xz3vQlS6lTepwX5EDKfcDKsSO
         obLOJb4gmqiFjhvtadGbrLp1Cd+Mz+xtrF+oP2g/4ImyHQOsNjvZsfRbNvasUvnPabRb
         +sVr6z+BwwXAf8tQGHABNAEJK+YL6m3G7cYSrUslf45EwwKOyO/nYqNm5y3T/7Cj+4yG
         2514rn2d/2pM+nyIdMH5PGgxLAiXdJew5dOUaFFX1X9U+aLt9xCj6gFaLu//faK11ZAk
         eGDg==
X-Forwarded-Encrypted: i=1; AJvYcCXUoo70p7VMmPKjg/yMlwM2kw1p3wARa3LGsNHbfDBuuBz6FHFs3tdgD25jDMlRT59wbtunwb1Y9x2RXX/Ll49mpu3k
X-Gm-Message-State: AOJu0YxiSbHA6NTlDICF16oGXar0U6P2HG7DBytLF6oM4LdW5K36anGW
	mofvoNfaSbauubykbuD3UPDPlJ94nuaR60Pf12UxOuM/DlrwZ8EO
X-Google-Smtp-Source: AGHT+IHv37lkeo3/D+fVKaomL4DntkCimAlT+DLuIwbrezc6NWegxTFORjHe3OaWs3sfgzOZxglhuQ==
X-Received: by 2002:a05:6a21:2706:b0:1ae:426a:b53b with SMTP id rm6-20020a056a21270600b001ae426ab53bmr3407281pzb.1.1714576401902;
        Wed, 01 May 2024 08:13:21 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id k124-20020a633d82000000b005f7d61ec8afsm20885424pga.91.2024.05.01.08.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/39] sched: Restructure sched_class order sanity checks in sched_init()
Date: Wed,  1 May 2024 05:09:37 -1000
Message-ID: <20240501151312.635565-3-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, sched_init() checks that the sched_class'es are in the expected
order by testing each adjacency which is a bit brittle and makes it
cumbersome to add optional sched_class'es. Instead, let's verify whether
they're in the expected order using sched_class_above() which is what
matters.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..c166c506244f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9924,12 +9924,12 @@ void __init sched_init(void)
 	int i;
 
 	/* Make sure the linker didn't screw up */
-	BUG_ON(&idle_sched_class != &fair_sched_class + 1 ||
-	       &fair_sched_class != &rt_sched_class + 1 ||
-	       &rt_sched_class   != &dl_sched_class + 1);
 #ifdef CONFIG_SMP
-	BUG_ON(&dl_sched_class != &stop_sched_class + 1);
+	BUG_ON(!sched_class_above(&stop_sched_class, &dl_sched_class));
 #endif
+	BUG_ON(!sched_class_above(&dl_sched_class, &rt_sched_class));
+	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
+	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
 
 	wait_bit_init();
 
-- 
2.44.0


