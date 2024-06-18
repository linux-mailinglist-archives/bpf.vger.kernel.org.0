Return-Path: <bpf+bounces-32434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D390DE19
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D781F249C2
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9CD1779BB;
	Tue, 18 Jun 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPSjTYif"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E816CD01;
	Tue, 18 Jun 2024 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745668; cv=none; b=EX6KGIjDT5dPD69TZXhm9OQQlDwz+hqTWPsr729qnYWU+Kj8MpaYW8e9S/Tfk4XD3DOzLjOlo5blBT80XnIrjbdN38QJJDFErylb/NXxa92gtQ1c5rGI4IFk5PQeQbT3dbJNMd6W+YO/4Ukl59iqzwa23BR6B9OAFYmAg77mg4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745668; c=relaxed/simple;
	bh=qLwYvQl7JFFbbfwRKRAAONSYot3UCFeCV1vfQJFU0e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjiu/xqs/WkyB9/AL5xfX+k2rIUP4IHE7nv6Wz+wyGynesynrnPmWOZoqZT/eXqZ5kGauFrWrAoIUrmw95OBOD0sHPBZWEtGexbO01B5yRESx0bF4uvwn9LEVRCcCAPh4l/UITSpPqjwkobs7J9pwpmMR5b3i9VHV3cefxhy96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPSjTYif; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f65a3abd01so50496385ad.3;
        Tue, 18 Jun 2024 14:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745666; x=1719350466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHkOaPlPFrfKfV1Xh7TwT9eU+hdOUvbHUYtn2Xztbi8=;
        b=JPSjTYifQ9xQXzm32INhI2+whcP1vFNJynAvhD/ESFMftWLEhyvoMgeAyt/O3sweZT
         LiHfUcW+V+mY6G3DguHkdoQ0oaly6G+LAHvkBXujRvnuRHETd4rYcMap7cW0vGes8Pyi
         B94gYslRjbZoHCfPNqj1k5XZrRdn9AGIoSxGxroa6SdMPXZzPX0PT7aLsDdQWkOFSMmh
         dX2p5a0u9y729DxHJTyaMVWx3YcHDJlhhgqzRJl09gFAuOZwAiO8FdOVifJMik8vtFyh
         pUPh0kUeGnHbyvMh7HM4x+47W4SAintfFDFr9JTRgIWgxdDHjA2mD/cxEPcZn9pP0RTp
         MDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745666; x=1719350466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHkOaPlPFrfKfV1Xh7TwT9eU+hdOUvbHUYtn2Xztbi8=;
        b=uWL083donjFA+90kK8rWf27gDkOsfQH3iKlnbK4UcR0m34CjgT/rCAA/bl94R8Yt1r
         v6KWdqrQ0C+Co9Yl83fRt/5BqPDM33IMepbUS0jTHnZU9oDmF+FyRjgYYwSa6xujpv4T
         JiArl4TNpoI96YQa3mT9MxfEA1h+rZNdvppzUvzVmi0/eUxLQ9JObArfdoouJYKgv8VD
         GRXx9EVmArKmAiMy7JiO+VOBv/PJsDGIGO5b4m/W6fc70wbExLBNrt4Mx8CzkhqRtoxK
         RSaupgEw0cuJh0aV6cxSrcbnVCdsCECOINxND/wLmbx55QAObnKrpyAVH15/x5Drfjdc
         fn9g==
X-Forwarded-Encrypted: i=1; AJvYcCXLExYmVeQJe9rPWDgrdModi5r3RRNzvMl8toSowsRFn/3Qo/7/VT9QPELaHeprhiHrbNuNOufYkyNSxJY9R3+d7kZI
X-Gm-Message-State: AOJu0Yy4hKfVpnukrJ5UUka/nIqIpf3W7mX7KJJwtPpKoTRlDerG4XTZ
	19FMzUXqKVobrreKw6I76gCIjrNwg/2lD9vQk7qoF3KGZ4nLnZ0Z
X-Google-Smtp-Source: AGHT+IECnDBLhfb3KwrUnARw81yLEIJyfsSn9ELWUM4xI4vszwbecG4REoJiJ9Qtdk48uM9GhM+qEQ==
X-Received: by 2002:a17:903:8c3:b0:1f6:8014:5e29 with SMTP id d9443c01a7336-1f9aa4187cfmr10183675ad.40.1718745666585;
        Tue, 18 Jun 2024 14:21:06 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55decsm102341865ad.40.2024.06.18.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:06 -0700 (PDT)
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
Subject: [PATCH 01/30] sched: Restructure sched_class order sanity checks in sched_init()
Date: Tue, 18 Jun 2024 11:17:16 -1000
Message-ID: <20240618212056.2833381-2-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
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
index 0935f9d4bb7b..b4d4551bc7f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8164,12 +8164,12 @@ void __init sched_init(void)
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
2.45.2


