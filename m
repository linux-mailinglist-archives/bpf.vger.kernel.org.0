Return-Path: <bpf+bounces-59236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3190AC7613
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC57AFE69
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA42472BB;
	Thu, 29 May 2025 03:11:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A3244686;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488270; cv=none; b=BoA6pKKMot2o2T1bu+1R75JNudqbhf8+L04DgOfYb+zje8vhmrAO1Xsv0Su2UviqA56K0L9Y15MOo/3jOplNYlzRBvcGuDlus966oNva9mVr2kjp1+82pwMpjKDlo5/rMRKs7rQDC3w3Ajpx5IiWc6iYHstY5WNh0pYzBXaqPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488270; c=relaxed/simple;
	bh=SDe1VEQrwVcvHP/Is4Ib5Ed6DMUS2sAGUcUuJZ4BOfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aH/IoS2X5O/w9hFteFPAFxWAb/RjX8b8c9VD/oDrwvshAeZ21faLuVc4JJIa6Ce+PMyUdXtEAsjSqnMT3Nj6y6sjIhUh1MKyRnbgBWQTVUHTV94YztdI3fbwCT93pXGVuBtV8rAYAjoun9/nC4q6un9ZVyrjtM0DAebAp6h5I78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-14-6837d042823b
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [RFC v3 08/18] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Date: Thu, 29 May 2025 12:10:37 +0900
Message-Id: <20250529031047.7587-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG++/8z9lxuTpNsaPd2CIKKzNTez+UWZGcPhX0QagPNdrBM5yX
	ZnkJCjVDHHnBsstasMp7wXSKm+El59CZUV5QVlqWMa0sJaemzTCn9O3H8zzv78tLEzI7DqLV
	iZd5baJSo6AkWPLT9/HeYz0HhVB9bgAYTM8peDafDhWfrCQYqhsQzCwMicFt76Tg6eM5Agxv
	czDMmv4Q4OoYFcNI+RiGplwLAaOFDgryczwEZFsrRdDTUEDCnT9lBFgyP4mh/4WBgo/Pl0gY
	s+Vj6NJXYRgpiIYOYwDMdf9AYDdZRDB36xEFt/uMFHzJGUHQ1z6K4WFWAQJTi5MEz7yBipZz
	9VXvRFyj/oOYM5qvcHWVwZzO2Udw5uo8ijNPF4u54cEminPc92Cu0eoWcfk3Jinul+s95qZa
	BijOVD+AuddGu5hzm7eeZs5KDql4jTqV1+6LuiAR5vX3ULJNmm5pqxNloqq1OuRDs0w4+3ug
	ntAheoXftNDemGJ2sk7nAuFlf2Y/6x7txDokoQlmkmRdBo/IW/gxGnbcMER6GTM72Ard3ZVc
	uuwpmbotWvVvY5/VvFwR+TAR7N261Y1sefNA10Z5pSwzK2YnulrJ1YNAtq3SiYuQ1IjWVCOZ
	OjE1QanWhIcIGYnq9JCLSQlmtPzb8muL56xouueMDTE0UvhKHeigICOVqSkZCTbE0oTCX5p9
	JFKQSVXKjKu8Num89oqGT7GhTTRWbJSGzaWpZEyc8jIfz/PJvPZ/K6J9gjJR7ImwV0Eei3yf
	o/ROILkh10/ePFzqHJcevRRHzVpxq2Ii9FhzkdB3OKCg5uvYevJL4eDk994WrUpwbwmtzSo7
	NfMkGMuXsOtmltDblhbz+cTf2PjN148fCC+rzRP0kUslEbL+PXGt69ojTy5uJ5d2dU8FfjDG
	DMfsFhdPfyuOUuAUQbk/mNCmKP8BVYvX3tcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG/e/8d3acro5L6mAfjIEIgpbk5SdFmn3oUCFFH4IMcuWpLeeF
	TU0jw8sgW6mlZmnHmog6LzFR8ZZZzuUFpURZzDQVS5O8X1NnlBp9e3jfh/fLSxHSMuxCKaNi
	OXWUXCUjxVgccizNM7jPX3Ek6yUFvLGKhMr1BCgbaxQCX1GPYGVjSATL5k4SiovWCOA/aTGs
	GjcJmOgYF8Fo6SSGlvsNBIxndZGQobURkNpoEEB7YbcQ+uozhZC7WUJAQ/KYCAaaeRJGqv4I
	YdKUgaG7oBzDaGYQdOj3w1rPDAKzsUEAa48KScjp15PwTTuKoL99HMOLlEwExlarEGzrPBkk
	Y+vKBwVsU8FXEauviWNrDR6sztpPsDUVD0i2ZilbxA5/biHZruc2zDY1LgvYjLQ5kl2c+ILZ
	+VYLyRZPLQhYY50Fs716s+i802Xx8XBOpYzn1IdPhIkV6wXPUIxJktDQVitIRuUOOkRRDO3D
	fGyldMieIml3xmrdIHbYmfZmlsc7sQ6JKYKeEzITvE2wU+yjVcwPfki4w5h2Y8p0ebu5ZHvn
	6XzOLjO0K1NZ/X53yJ72ZfJq/znSbSdf10Y+RmI9sqtAzsqo+Ei5UuXrpYlQJEYpE7yuR0fW
	oO37SpO2njSilYHTJkRTSOYo6UL+CqlQHq9JjDQhhiJkzpLUQD+FVBIuT7zDqaOvquNUnMaE
	DlJYdkBy5hIXJqVvymO5CI6L4dT/WwFl75KMil5bIm7x2MmgH7S5LhRfcXsXPHMR/V48FGfn
	Ua233N2bdPZNs+KD98MS82oKHxQQeq91T/4vP9+lmdtTyqLvIym9AYXDP9WmUG+sTXd29xyR
	R89uDV0oUgf7ZI/lZs+5BxZMT56ynpxOd7SVzHr0HNW+Omcw3LBIHUKuvcU5VTKsUci9PQi1
	Rv4XffZxV7oCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_release_page_dma() is for releasing netmem, not
struct page, rename it to __page_pool_release_netmem_dma() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4368beda1e08..0a5e008df744 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -674,8 +674,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 	netmem_set_pp(netmem, NULL);
 }
 
-static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
-							 netmem_ref netmem)
+static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
+							   netmem_ref netmem)
 {
 	struct page *old, *page = netmem_to_page(netmem);
 	unsigned long id;
@@ -722,7 +722,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
-		__page_pool_release_page_dma(pool, netmem);
+		__page_pool_release_netmem_dma(pool, netmem);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -1140,7 +1140,7 @@ static void page_pool_scrub(struct page_pool *pool)
 		}
 
 		xa_for_each(&pool->dma_mapped, id, ptr)
-			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+			__page_pool_release_netmem_dma(pool, page_to_netmem((struct page *)ptr));
 	}
 
 	/* No more consumers should exist, but producers could still
-- 
2.17.1


