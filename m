Return-Path: <bpf+bounces-70002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACCEBAB9D3
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 08:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A64B1925C6D
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D328504D;
	Tue, 30 Sep 2025 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YANox5pF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA82280A51
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211987; cv=none; b=CG50OFV3VdQ12AjkCEkfB8iMwpNgB53BbAKoUwmxhV1byaPNNGcps1aZsBuoqzM7t0MyWDHUFEK/wyRIYgKxyt8fAWwFkywk7qpKZ36jUp/finCiE86CIqyIMkW3yuh7pj0QAcuJt9cLr2XzQItnucsZxdL+ATWw5VfqG3gpj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211987; c=relaxed/simple;
	bh=CXI0qMvWqpeePDr4xBG9e2uqemr9IpjeVUqDleKN93I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8auq5jjwHviiyPzyIOs48L456qVcVVFvt7KbAMTSObxHrZCYkXwv5i6TptMVO+DiRHH/HqfMENOKV5BGWHDYJCioMWfHExADTmkPxDfPmm8rk6iVWs/YuqmxlTWnnZGcR55XeXKOVC8LOfQ+r+SpX8PCoyGEeY4TWAXxO7mui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YANox5pF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27ee41e0798so68605215ad.1
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 22:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211985; x=1759816785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOprrquoKlbkEreJojZ4KykFg8G0TswcVk79ghRz+Tk=;
        b=YANox5pFVE12qunKaUXxgelNvQtoVWW5gGIgclT/DLZg5Ns2oBahLhxY/5yLiw/H0e
         lXd+/IqPr//ONCHLNyAKFPbHGUUyI/HsQsoxSIB0mA3OO47s3UqZwezuiV/ytRpnC2uQ
         Vdku5T0A14xpECf6eAvpZvelQTqwnOTeIbZrSu/RiAtV5YywLH2HkawiDbGGa7HFIog/
         MkmaAl8au+dfBBg09OoMUsxenMKlzZHS9BFRa78/U0iq90M6s7il8odJGI4OU0Z8WkN7
         XEINGVkw3Bj3GSp/CYk0gSWfaVQEGXMhPExSEhCgMi9iz5ScGjiiXE13gWYHRkt2UoJX
         KZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211985; x=1759816785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOprrquoKlbkEreJojZ4KykFg8G0TswcVk79ghRz+Tk=;
        b=h252HokOYKfOGUsHYeoHtgRkZESsDdzlz2ZyzHInR4fO42PglYi29+xrBA4hu6xbI9
         ace9Tce/Uy3/1ApjieBvZw2T6vOUaAwGgdniJm0Dzlx+oZc5yTg+5mpr9UrjuYrMQyr4
         pjH2cAYsW/wwkGqAR80DorQe1Ug4MaEJ7rh1zq0mKe9o4IfSOIj9PGDeMTweoiXMvC05
         6yB5q6/2yHiIxU8dVhjUODx9FSsrw+SmyjuvRh9hKTKIPhOWR2lydqlXdEqI6xzBtqUt
         vXgaOztSt/XpsoMWBNbLwL6r+2R0yJFbBGT9H2qlVlh7vDaDtgoe60ln2fTkxgx37jWo
         MpbA==
X-Gm-Message-State: AOJu0Yw7Vuyg0vUOhBVszmLZtkhDOFC8ALqEdBRs/oFYK2JYm+idTC49
	px1UPmooyat3t7Q/cgtshY8Ba1B+C6Uhu9j7wZka5zOA98K93mWubgmt
X-Gm-Gg: ASbGncv7/GRFrBJQCcZyXnyor7iBx9WQwvNNGZh2Y22kidcKnE8qJooz5kosmuJWZ5b
	AO8l5Ef43FTqaYUbx9hMVFVRGfYXNgFdV2yCFHnmBD4pO/UG+imTCk8cOXf0wpXfUIXMVrpI8WY
	5i0Jl6lEF8zawd0QiY1+hVnO3i9mQQ1d2iy7dIRH97Pp5Wn9ATTqj78aYs6spO7jEpq++N0SfmY
	euXxa8mEUQeCP2s8B9kvk3oLXMGZyYZgEJLbqM/K9Wcypo8Z0X0VibIggfuxxIPTIgzuZUK4MFX
	4pA14fUBzz0erLPpGhcURKWs5Nlr6j46ERBgsNhzUIOXHwb65zxp/uQF6qlobm1PD+tnjLXd0LL
	6nvJUI5boCZlHJl1eHmClAR99Zv5KSRCrWQvFjJOZSjcCPjSUq/1X1q3DSFWuDmEj5G4VbooMWK
	pjmY1WMMq1kMdLmK5GxDVITHYD0pL6RaEYL/Linw==
X-Google-Smtp-Source: AGHT+IHaVympRvUhy+mNwqzkCqg8GQH0WHYHPq1npnx2or9ONNHwBhPtVzKfVWrGEP9ED65uKj4qEQ==
X-Received: by 2002:a17:903:b83:b0:265:47:a7bd with SMTP id d9443c01a7336-27ed49b802bmr208932635ad.4.1759211985356;
        Mon, 29 Sep 2025 22:59:45 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.22.59.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:59:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 06/11] bpf: mark mm->owner as __safe_rcu_or_null
Date: Tue, 30 Sep 2025 13:58:21 +0800
Message-Id: <20250930055826.9810-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. The
owner can be NULL. With this change, BPF helpers can safely access
mm->owner to retrieve the associated task from the mm. We can then make
policy decision based on the task attribute.

The typical use case is as follows,

  bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted field
  @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
  if (!@owner)
      goto out;

  /* Do something based on the task attribute */

out:
  bpf_rcu_read_unlock();

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..d400e18ee31e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7123,6 +7123,9 @@ BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state) {
 /* RCU trusted: these fields are trusted in RCU CS and can be NULL */
 BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
 	struct file __rcu *exe_file;
+#ifdef CONFIG_MEMCG
+	struct task_struct __rcu *owner;
+#endif
 };
 
 /* skb->sk, req->sk are not RCU protected, but we mark them as such
-- 
2.47.3


