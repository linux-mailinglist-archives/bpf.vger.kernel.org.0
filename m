Return-Path: <bpf+bounces-51289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFBAA32DD2
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 18:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53631188636D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21825C6FE;
	Wed, 12 Feb 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVN3LoKu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D202586E6
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382453; cv=none; b=mpjakLTP1P2pGA557EBwPfBmWkadkenAuaOJ1G321/XQqV/o5TrlTikvlP4GNU66VQjWpjx8GLKm4SAbFtHPWvPotv13xrh+aLXfpNGeg/ibL2xj+VKvx+6KqR6aGZSFyAEO4D76fXCGbRxR850Di8VK0Q2MivF7EfaZ18iaKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382453; c=relaxed/simple;
	bh=PkbsL7XC8j5LBWMTJb1ZtearOWIvOtlSfq++Sl18MI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPM/voIXPgwfHL0uKFPERwqJPjma5dSz5964BsP9GwvnV4TzEpnGkk2IRTENquldKT/n2rOrSwSoBy//RqTCvq0SLy5MmdoL82ySG1WZNgEWTkH6XXw6LsfCBMZhUhZ648uqY+IaRfAq0zNVPKWtLD1oc+oldrbXHq07UCZNk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVN3LoKu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa2eb7eb45so1941478a91.1
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382451; x=1739987251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXCJ0gdG5EF9yWrbtRQyNOOIbBLtByDZRqzMTlbBC2I=;
        b=UVN3LoKuhI1MBlV33+dmZswMaxUufID29CAGnbMJQe2we1GUm3ZtEoi0f1Kl8xEvFc
         lC70bzlWNLtLXOJi0ahnWbRUgCo/v6yUAOyA6nTGpLiWA7isyCdCdjyPrVBbdHg1S4dp
         Jf4MVS8DJHwS5w3Wb3dMfkgb1JMMkZDqQQEgBTRhe39HJ4Hy7VPet1vbBuDx9dkj88kh
         6ZBYGVfZD1/JIoIPwJKS7VS3mooh2n/ae2kHpJPri4j4XLenY5IgPkorPnenlVtbmCZB
         XFftsraelJ189luxA205AinrYuKKV/FxlhB4shKZr226QEwORYg/yr9kDDqVLSeVEYmB
         9Cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382451; x=1739987251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXCJ0gdG5EF9yWrbtRQyNOOIbBLtByDZRqzMTlbBC2I=;
        b=Raf1ansOymjVQLSiTH7fnN4KnFF6YMdt9dHoPLpeQ+QreCBDcpATUwVBj85Ua5Zz5W
         v5feI5xaIaAaSgzCB/JukJJtk7qbvPdDv3PdbxzrlWgWAM76I4RxWTOIvuiHPLYmvqK/
         fsFACq2/ii+g0aq0dwv3ZhqtAwDi17noRgXnUK39BTQHFbWXXyVKLOik5ow2YHacHP8k
         mlXezVESQnD17sDUNLRcM9Hpwsiz1kWFfmuq6trGhVLVPd8cLdqRaBam78MJoiu2M3Zr
         TUiunci0RP7bOymiLHJyfCw82D1F05mdRahirA0Ta6QzJsw/uCPJA2sZjEHY9t6DsThE
         Flag==
X-Gm-Message-State: AOJu0Yy06z2epsWOyFrJ21gBRCG0fS0owuakrs6MDP+d0R8CKqJ6IY2B
	wctDD+oS4VbLx8aCiilsYhXnHgR2TUJLvf5qF+S+RxJQCWxqCVhcOXglcw==
X-Gm-Gg: ASbGnctXA74FvwnrOyB1xGFjccTpwpFmgaa1ym3axYtmZb8zQDQlmgS5BqkLqi44iN+
	c7fDx3pFumr/z12DR9acYaw8DcGKMJ9Pa8nr4mFvinAW+OSJGPf7H9FE6HpB/XyKQLwwMXa+G3U
	MsUiqMd/N6pkQTM3UmmdzmD+mMnW0VeAPFrYbAK9k++iULj98/2Ep9F/6inxB8pFpKR64b/Tgem
	NYFc+YP5RdmjCBmNLs3m9Jtt9CDwDCQCxX7XCLZerG5nYaA2K+D4zs/Sg+GfBVoHyz1vrOQNppP
	o8fLSoKsJz2HQR+ToKigMQKrHkOnha21c2XCzZ3cc6sO3w==
X-Google-Smtp-Source: AGHT+IGQQe2Ltprl1s0EVAQgrtpuMzau10NCDgeIlNPMnvs7s+Zh8a9Qe2IaEzLCOBtyjvHoHPP7WA==
X-Received: by 2002:a17:90b:38c6:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2fc0db48d32mr293200a91.15.1739382450483;
        Wed, 12 Feb 2025 09:47:30 -0800 (PST)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::4:c330])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9908835sm1805334a91.42.2025.02.12.09.47.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 09:47:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 5/6] mm, bpf: Use memcg in try_alloc_pages().
Date: Wed, 12 Feb 2025 09:47:04 -0800
Message-Id: <20250212174705.44492-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212174705.44492-1-alexei.starovoitov@gmail.com>
References: <20250212174705.44492-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Unconditionally use __GFP_ACCOUNT in try_alloc_pages().
The caller is responsible to setup memcg correctly.
All BPF memory accounting is memcg based.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fa750c46e0fc..931cedcda788 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7146,7 +7146,8 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 * specify it here to highlight that try_alloc_pages()
 	 * doesn't want to deplete reserves.
 	 */
-	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC;
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC
+			| __GFP_ACCOUNT;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
@@ -7190,6 +7191,11 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 
 	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
 
+	if (memcg_kmem_online() && page &&
+	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
+		free_pages_nolock(page, order);
+		page = NULL;
+	}
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
 	kmsan_alloc_page(page, order, alloc_gfp);
 	return page;
-- 
2.43.5


