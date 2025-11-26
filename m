Return-Path: <bpf+bounces-75615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419EC8C2FA
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 23:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DDAB4E53A4
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 22:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D63446CA;
	Wed, 26 Nov 2025 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqY/6+CA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11619343D66
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195456; cv=none; b=pqijd2jBzgr/GZ8PIkF92HlzMQ+HSffqyiGEHrD+yJFvszzhOoZ1AqCv5d8zhN6ysr+m9xjrITV9HbrscQ4JOjtY7kLHqfgK4jbWlq+E4xlifp4w9ik81kOh2QNN6WBo4KTS4awMg1n4tT4O1T8vETKdqzHAPliODe/d5JOKsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195456; c=relaxed/simple;
	bh=WQcm0EHsw6PYPITVbaCdvvynX9VHge/XcXBmVFGe0zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZvbNwooutEA7j6HGZZqcSZBMTDgFYpqulDf20lRRTmN7p0ThiBhXl15lCj6xJNIhxlHMK5ibtmA82XSYtyQ+j2hsnJ34lbDloji8zhEpz0Z+svapL37eBrjO9U2g1k3Roer9rWxdWTQ9jl/Gq5Ps8xSq7tRGt7B/8YySyfj3alA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqY/6+CA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc0de474d4eso644769a12.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 14:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764195454; x=1764800254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zt/vrs22IFRNV23j1sT0XTLeik6zpTMCFKyG7xgZ91A=;
        b=PqY/6+CAnpy12IwsGyQKGgcLJytH6cmOKqNp9oSJtcWLknjb4w93p1kwv19YxXFj4c
         w+CwgbZaBRE3huLJkPluEdMkOAuVm+CUFLMGG9U0ZwJpRpvU+7wC+HelP6q6i/BiTiWa
         sUre1XTS7JPAyDE5cLhoi/dBoy4W6eN7K2V2Q8jaPx10exbZ3jKhfTGScizo1rOHf1Fy
         qAsN5L6SLBp+tZhNByOmosj/RLUlvGEb97Sk+VjbyySv0PLpHdPWc5ApRM1flGizMSGT
         4r9QkGUhH5JRWhwLvNSCF2Ti956xsmJFnnoCRpSCQsvnaiWzlTsq8/Ng8B3zyx52RPrl
         tkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195454; x=1764800254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zt/vrs22IFRNV23j1sT0XTLeik6zpTMCFKyG7xgZ91A=;
        b=uhoadSoc4+YP66lOqKeeL+7iGS9vhmlqdGfn9Ap/h+Z0eaatYsfiiVd3w352Exy+Xz
         segsrlLUhw8lgp3/8O4dyj/ort1F89pxoWVLSQ7Pc9DSuQrVNziZkRw9M+6mDUWwSXTF
         mWxu7gFOAQWf4M/pYar6Au/pnKKwmQEp1vL1mXfYDOm5GvEvMdTgme5I5YKfjSBCsb5S
         t99R6z3Hazg5QWUzgode3dQog8SEu54Yxy1tBdPvhW5t/SFy7B4B9m3/XcdimwrH9OSH
         7CD8Yvq8c37UzHlz7SrdZN9hepXz+qxBxAJ8VMZcnJDVcofr7oDgERImZGCTFsGHJZ2u
         BepQ==
X-Gm-Message-State: AOJu0YwOQrafjV52sMVNRtaLKJJGhSMRU8ya1b7m8jSW4L1bQXwu6RD6
	nmXUlSKlMewQ9vgWQH42hM5ql3hlGRL33MPfdBrjiNR5cHpNerUo7RJUvQVZeIBMhVCUR36GQVP
	XukN1p1g+RamGErVdSVbynz1ZuY/srnNz2dKUiqbgnUeGMeCWkYayLz/MmkH7Spe6HSqiBoceSJ
	zhv2sKSmiJgpwXGyvzmF8MmRN/vl/l6szWDx8amvbbNmRgshs0RzkvNiFOKXF24UE5
X-Google-Smtp-Source: AGHT+IFIz71LhfTwWHL1z2gigA7hdTT4BwNN3sP1QkyaP0YT8yLO1AIMoS4BZJ/uN8VXCBLMXckv46l8r9Qy1fLWBAo=
X-Received: from dlf18.prod.google.com ([2002:a05:7022:412:b0:119:c6ec:cc42])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6ba8:b0:11b:9386:7ece with SMTP id a92af1059eb24-11cbba58e14mr5798079c88.43.1764195453875;
 Wed, 26 Nov 2025 14:17:33 -0800 (PST)
Date: Wed, 26 Nov 2025 22:17:27 +0000
In-Reply-To: <20251126221724.897221-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126221724.897221-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=samitolvanen@google.com;
 h=from:subject; bh=WQcm0EHsw6PYPITVbaCdvvynX9VHge/XcXBmVFGe0zc=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJnqNaUG053rjder3zVjlW4vPdJ5pHaVQ9Pt/iLtuP7Jx
 qn65Uc6SlkYxLgYZMUUWVq+rt66+7tT6qvPRRIwc1iZQIYwcHEKwETU7zEybJns+mHy4+zTJ+U+
 OG/aWnFd7Z5i07HzfjyvPNob+T6ZeDEydPQdDLx5/ObLqx/6jrd8Ktfcb88me3iO/qma+TP2s3B GMAIA
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126221724.897221-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v4 2/4] bpf: net_sched: Use the correct destructor
 kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI enabled, the kernel strictly enforces that indirect
function calls use a function pointer type that matches the
target function. As bpf_kfree_skb() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 net/sched/bpf_qdisc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..e9bea9890777 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -202,6 +202,12 @@ __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+__bpf_kfunc void bpf_kfree_skb_dtor(void *skb)
+{
+	bpf_kfree_skb(skb);
+}
+CFI_NOSEAL(bpf_kfree_skb_dtor);
+
 /* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
  * @skb: The skb whose reference to be released and dropped.
  * @to_free_list: The list of skbs to be dropped.
@@ -449,7 +455,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
-BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb_dtor)
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-- 
2.52.0.487.g5c8c507ade-goog


