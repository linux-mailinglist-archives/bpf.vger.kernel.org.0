Return-Path: <bpf+bounces-65850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8CB29931
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 07:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C99818875AE
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 05:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560327056F;
	Mon, 18 Aug 2025 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZqXXgw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A1626FA4E
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496546; cv=none; b=u89VLxOzFmN5bMF2iIlZFIf23BMFXLo2qO+VzI+HhDG+tF9Fw6tLnW8DnpHnpl1RfHJrCAR3I2F38ckPdWuTjcHlt1PBCUR2zwJ5Cbs0xeMUTYnX4rWCnn/dyq1AqYsBnwiGed18jnPqnLssm8XKb8/nODEP5JalSXxgzOGe0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496546; c=relaxed/simple;
	bh=zBn9hoS83uO/tZYMANGL09DuGhjyTg/MX86VjQ4MZ1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6irxQ3PUVvboloH3XPEL1PVpoLFfyX0LKhg/ekQwYrBz7ybXZl+YDhlhDVVD1Gq13IOa/VcfJPBJAK4ZBIx3G6Fieah6c4VhA6d1LzoXcsX1k48UyhNHaMP+QfTEfPF1j35Jg7SEBZy7NUcxiq7xyJhCl9Ny6wAumNQo5mXAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZqXXgw3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266cb393so3528438a91.0
        for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 22:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755496545; x=1756101345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WchRBPasEr6Tpz+n97umBRoFJbuD1ZXf104QzBiW28U=;
        b=bZqXXgw3ZZoYmzGuiInd0jvD/4KYu9BtupTqSrEldKF8Jy6dlKi89z9tOeVX77+2Pw
         nutRcWjtqijPQKdlsJmTao77YQU4vplvTT+Il7T5lnbuQDSfgIaEfHD0onzTLycC64r2
         UeiaTvQNP4FoFDH6cHTiPyf0+6Zd9lMzwzzKjoGKLdavGZxlFV6DyawAdVRti56E1sD3
         EYUJiQESc8kptUxadccXNvOAJQVBIACXNkFE+OGT0ZKpFqfaqnlxjd9IjzlECaBc8a9N
         oeN8H4+Wy72K1lCXYWsT4kN2hALD3RqL9vmnjZyWJfiN/l5+OvfmVGfRG60I77vJuyI0
         rxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496545; x=1756101345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WchRBPasEr6Tpz+n97umBRoFJbuD1ZXf104QzBiW28U=;
        b=RLt50j5tp8h+6is/So4086eTYb8i8vOzWUFQjG7mGm6mLij6KS25UrtulGBsKB413Z
         AOxXKZtmEGFNrWb+OYlBYBNFfOup+El+9B4O9HV5A07W1aScfcOe0S0vc1MCbeCO18Bt
         ClL28PH/5wJbuoGRQjK+/37bssrHSNEJk/O6dR1989gjtn6oN0/gQXRF7cBfA5b++jV6
         5iqqVN+q5b6wTkqvd5Mbbfrl2VKirKC8JTdhrXp7LkLnhvU90I55+hQ1eLkVdET5GQPX
         TVBrb/ukL2llorj7Kf1EBcY7VdFRv22UKDMJ4HAXzsnNgWzzvOPzwhwcB1eQerogLyJh
         woRw==
X-Gm-Message-State: AOJu0YxfBOfddQfUEWwkrzoJGFl9H95atRvR47DNfEM/ImWSbPrSd8eo
	hpgUvbmsjqfgHErZGq6rlbFWhB0iQWdEU50pBhsXE3d8VmmQd4WFeNIl
X-Gm-Gg: ASbGncuUPBa5rhdkaIFLQ9mzTROuEsqsqh32FezeNkSUEcci++OA1blRZOSf9dP6jre
	6IzSRT545cVT08u0L/IrJRWb91YeSGdq/huJyD7sUM9qndyZm1VfYuM1c6oQ6dW/U6i64qL1bhw
	RxUQRdz6ChT0bQDX/NQis4SQqx6b8tLkhKsJ/QuRfTDk1WHFpviQvMnG51p+sWiDhWmS0lWInKL
	xjYD3Pvk2rb2Sv7EaWAa+9bfULQbROKz2ZKyTJEjWd7SH3rDU+38k9c05D9jfVWadcyDaBKpmf7
	rcJEV1vj0Bf4rAA/Zefy1Y1MfVJvMVoO3qxmBWMqbXkMdSO7gXJBNQRf30OB5GP1YubDwfagSmA
	khLFjWBba5iNJYgEfl5FydWucl+NlNOMYmnCAOxPS/lVVFw==
X-Google-Smtp-Source: AGHT+IHxTn47ZmNwjEV+vkqmS7ZRcV1WEWwI3wyh0lkTmxGBypoYQR3vwEeiItFXX/ucwnse5ZBTuQ==
X-Received: by 2002:a17:90b:2748:b0:312:e279:9ccf with SMTP id 98e67ed59e1d1-32341e9bf9bmr15906029a91.5.1755496544751;
        Sun, 17 Aug 2025 22:55:44 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439961c9sm7003413a91.13.2025.08.17.22.55.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 17 Aug 2025 22:55:44 -0700 (PDT)
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
	rientjes@google.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v5 mm-new 3/5] mm: thp: add a new kfunc bpf_mm_get_task()
Date: Mon, 18 Aug 2025 13:55:08 +0800
Message-Id: <20250818055510.968-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250818055510.968-1-laoar.shao@gmail.com>
References: <20250818055510.968-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will utilize this new kfunc bpf_mm_get_task() to retrieve the
associated task_struct from the given @mm. The obtained task_struct must
be released by calling bpf_task_release() as a paired operation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/bpf_thp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
index bdcf6f6af99b..8ed1bf0d7f4d 100644
--- a/mm/bpf_thp.c
+++ b/mm/bpf_thp.c
@@ -205,11 +205,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
 #endif
 }
 
+/**
+ * bpf_mm_get_task - Get the task struct associated with a mm_struct.
+ * @mm: The mm_struct to query
+ *
+ * The obtained task_struct must be released by calling bpf_task_release().
+ *
+ * Return: The associated task_struct on success, or NULL on failure. Note that
+ * this function depends on CONFIG_MEMCG being enabled - it will always return
+ * NULL if CONFIG_MEMCG is not configured.
+ */
+__bpf_kfunc struct task_struct *bpf_mm_get_task(struct mm_struct *mm)
+{
+#ifdef CONFIG_MEMCG
+	struct task_struct *task;
+
+	if (!mm)
+		return NULL;
+	rcu_read_lock();
+	task = rcu_dereference(mm->owner);
+	if (!task)
+		goto out;
+	if (!refcount_inc_not_zero(&task->rcu_users))
+		goto out;
+
+	rcu_read_unlock();
+	return task;
+
+out:
+	rcu_read_unlock();
+#endif
+	return NULL;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_thp_ids)
 BTF_ID_FLAGS(func, bpf_mm_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_mm_get_task, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_thp_ids)
 
 static const struct btf_kfunc_id_set bpf_thp_set = {
-- 
2.47.3


