Return-Path: <bpf+bounces-67977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE13B50BB7
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E511C6432D
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F162D2571B8;
	Wed, 10 Sep 2025 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhpxOcd+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292EF347B4;
	Wed, 10 Sep 2025 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472355; cv=none; b=klklys55lv0b2Pn9/MX7fx3ODgmCjjAQ8TVbJTO4kANr9amXatoieUeAKb7f/gjiLY404/WZPIQ+y9iGy9ku9gAgN9rwzBCC6XSHPZmvU1Iw6v0TD+GVFeWA4pPD3ZivYpW0lMHrxT7uFW+GQdulKVoATEvmkR/GNQ6xQ9Rjg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472355; c=relaxed/simple;
	bh=QEBaGj0m3G/7iT7GkhGx1f5rNxC1F8HRbfooVl3+3bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QoNrMcdxtZX8Cc+HhuhYkKaIRcDjDPWrlbrKzSKhNFV+7L+f8QOuGqxSmgT0ZQS1SR+QOImqEk7G70Dkvu8jEY7sDAuGUEH9eDC8Isy9fbxvBYGPHh7HfhaMloG/TgDiACneMl21XTj60vTXL3kC0kW5Ww+tcAHs3W9EimDTMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhpxOcd+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so4079659a12.1;
        Tue, 09 Sep 2025 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472353; x=1758077153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhIj1wOvMISRgbxTNNRHlkhQqjrik/oerQtu1lBx7LA=;
        b=IhpxOcd+rSJDkdHx5saoanWs+Xg+ZMEfXKqhHGQJcSEWh4Yh+S8D4so+rkljte9pIU
         JGmimUoHkaMlQ6SUIN9kTKkaMHVamrEVLPi7xtG4lTTyTiz0zkVKu0gp9DsFv2chfV+E
         ws47qL8OIJhywfHdEndfhTojSBvy1bHQ4wbYJTCsFzb0sAnYdmmnwo7K4F/wqghI0Ip4
         zx+c2qrgOM9ewViEh20UW94DAi/cQyNY/2zUJ2KOy4IXDl7fiEwoSCFs6OuS4i2y+KEw
         kU2qCRnqxpR110lXcyYY9RmLPcQUQZXduCuB7fkaheRbTtzxSIMgDR6bqAub3Mb7s3FJ
         ECvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472353; x=1758077153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhIj1wOvMISRgbxTNNRHlkhQqjrik/oerQtu1lBx7LA=;
        b=oxA/RuI4ViV/jR/tOY5wNw5FaVWkatp3OT2DTq3Hm1z/pdQQx0XACn/SIJyrwc0r1o
         gkc4YMcMDGVDEBqBjghanmzcRg0PSU+rvdATqOYPe5WPRpkMBBqzSS8E+wJQWsKglNte
         jc1q8yQHKqWOC8KtP4Ou1eRj/zL/BjVGqjtiMZhkR3zdUsOs2vYqtbV37+qAVPrWPPpa
         Q8DUVXeR/D/YQHgVOsRGQQuR7Ks950ZZiKpZ8TF2KsLi/rA59hoZ7TJy2uXvftX3XPX1
         dwjTSuVQOSOhC7I7s1LMNcYonKcPewses0q3KQsIeQuho+5ATRKkHb++foZ1dTfpwc0D
         lCzA==
X-Forwarded-Encrypted: i=1; AJvYcCVmno2xli8DnoxHupkdkX4WbnZtzu0j6S+G1oeoTh6ENcWnocBYop71vwYJ4ED8mI5ZvlZOambvGb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWe6jw51dZDtBs27+OJVDxO53/ZcvdeqxaoZQ2GCihy6z6vRm0
	pl0P34A+G4F2kOvp4DiRqTT4ilZ/0+x8ViHArsG7UOxIDsR888LulerY
X-Gm-Gg: ASbGncsCFfzixCQoMcehAJhJqfVzCO97Us4aNt2mmml6FlWszBGy906CwQM4C51fm+F
	WU71E/6Rj5GdMQLv6OpJMndK9tkpZaJPJqbpJUNusAsPg9oPNPwV7Y/U3FpSAY4frahSmn9rdPv
	6DKratkmwe69CXJwfI2lwx8qy7nIMAU11IVLkZ+XfPI4fWNlc3n2hF2tZOCKZdaeZD5kAozKewX
	RNsw8w2Rwx9H0Wvsz89H9RJNJZQnxj2xY88xSc4m+LlM2rm8SuG1OAzx5ZkyQy8gkamR2cRRXLO
	e3NUYzjxUbEGC3Q87eLv4/LE2AzAKZLP24Y3abu5s4pJ0NB+h7N0iTmuQqQPXl+8zk32ypwV7Iq
	gKWOMDBAcnCICb2+GZmkmYJSOxEfOtUNAd7NeeHsRz+zUJPgBznZ4I8oO53tzuzAHywMr0Z8A7R
	gU6iy3hoLPV2an6g==
X-Google-Smtp-Source: AGHT+IHR3zVDA4dMic9DbEIss4WDN7ZHBL8jZ8Y/o9+OzUWibAnOWX1U/miaWRldO5YZrP6sorG0wg==
X-Received: by 2002:a17:90b:1b0b:b0:327:f216:4360 with SMTP id 98e67ed59e1d1-32d43f1789cmr17484208a91.8.1757472353463;
        Tue, 09 Sep 2025 19:45:53 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.45.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:45:53 -0700 (PDT)
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
	shakeel.butt@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 mm-new 05/10] bpf: mark mm->owner as __safe_rcu_or_null
Date: Wed, 10 Sep 2025 10:44:42 +0800
Message-Id: <20250910024447.64788-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250910024447.64788-1-laoar.shao@gmail.com>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
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


