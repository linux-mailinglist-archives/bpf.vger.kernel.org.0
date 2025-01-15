Return-Path: <bpf+bounces-48901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8D7A1172D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58953A529D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9AF22DFAD;
	Wed, 15 Jan 2025 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFzTrjLB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CA22DFB2
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907509; cv=none; b=bx6DNqaq1HlBAcvTe9AXvtCPfFdtM+JaTcwWdtn/NH87zmwL2okhnUTe3VxNI1RZw4UMiFF/2KnpQpNY0A5w2fie7GQBG86IuVP5MKijJCC2AseqXfOOibPnL6dYeOss2rP0Js44fpRqXYb20TuFQK3aDI3buNviXiwg0yP0JPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907509; c=relaxed/simple;
	bh=qpD82EOTiD0WuUW0ru5J3NdtZhJ8QpRSIPbqAuteWAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGgt03X1MirDaqGkhCDyc9j2XgBZsHLRuScgUAJ2aLCcWozhuTwcT9qpWYyd9okZpMG3RBddXgKJg8y6CdgFMxOy/XiC6xh9LeYMG09NP6nplmfsqqISj6ksy/3XDqSnyP28oEGwSi6OfeDMuKBVGrPATzZ7lKoHaT85ZR94yRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFzTrjLB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166651f752so139632555ad.3
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736907506; x=1737512306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YPnFtJFai+0xFpNHgKwg1vEFPjmUMGue3EQsxvwhos=;
        b=TFzTrjLBuQEQ5owZTLtDbMUNwoS28s1+pzALNeflUlVzOoGkaM4pMjf41ezpB2liR5
         A2B6umhAMJXfeAYBB78kKzYGfP8nQ7Urr/bjFoApPktRijQVLT/8GOvxM7oppE0854aC
         RYNgAFtNtuVltROXfncqrx3q4IwVRgwsheDjP7pv0QC8wWyqwQuovzQI8FfVEC4pe9nm
         t9vEob5YrnGV9nc7OtAR+m2l2ehVR1+Q3po0+vJO3CLdw29Dw7TKcOvRh1t3/W8CxrzD
         apGKBXAcUv0eSjZj3GQKEJpRHUP+cBxn3YGhy0/6jo1LLzyly6fyzuwdDxl/JJXqDjbl
         Eb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907506; x=1737512306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YPnFtJFai+0xFpNHgKwg1vEFPjmUMGue3EQsxvwhos=;
        b=VwQU6AGUUTzCZgRchiGACUt6XjCwVPEARZ2SzisVjiuWxkzhaCZi5lqG3qAykrYJTY
         rfw+Z4nrBMlQEKJa0i4dR6SDfIwbUSILmfVysLsGTUnJKBZ2B1fVJL7uUYzk+fpVa4Fd
         mib32Yz3KjalxGDvJUQzUm7TF2ZW4C4G5NqNOSn0swd/JU+UBf2SWA3/TaKNBQfyxoPf
         QlhjlwwOXzJ9F0KcQl3sFGKHwUl05VnTTPPQsrczrY6JmqN/kxisxFzcf9cvI+BYWqid
         RR+0/MEJYYHvd5K2Qm6e+Iq42w3x6ARXh77xgEpdHHpVNacJQ/Kx5jnYZ7Nq3lgSLOeQ
         yWLA==
X-Gm-Message-State: AOJu0Yz2QBtgemM9u3nrmbL+3yvNLnziUVBkVJETL1uTQSv7J+fXpkc5
	jRoQNnBjitIYS29TrO8QWpLVMaE4xku5+aVzoBu4jf4+Pd+0RtgMZjE2hQ==
X-Gm-Gg: ASbGnctivlw0LHjW5WH/Fe4lJ15fvZgXcmSTF/CMGD27CyI+a2q2763O+AQhAuAUO0B
	NJPzGoXvJZyLM1iwyBorB0tFFYP9GDwF4kONFk2mqSvt7NI8PPBfhUiFpBMSucONN9rBtque+hv
	lmsLjyne2b0atrzS88yG3m+fs6S9CbYvOxqmyfJBDBHtHysFLgSl1OqsnT5SvKosPqfpWG7tbcf
	MVnGsBnDXYf450WwxMppp54AVAHGPGEe9mYD/vRKn7sbyYFltdLGmPBufpaFzFRPjNoHYgFFaXI
	17zZgkpO
X-Google-Smtp-Source: AGHT+IHp8XYH01n8SuhXDCfKih1NoDPtrNmfatMAx4uMkp9I9uvhY2pzgjGZtQiUuw/WiH6P6RobmA==
X-Received: by 2002:a05:6a21:789a:b0:1e1:9bea:659e with SMTP id adf61e73a8af0-1e88d3612e6mr50844644637.35.1736907505893;
        Tue, 14 Jan 2025 18:18:25 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a5c3sm8349229b3a.62.2025.01.14.18.18.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:18:25 -0800 (PST)
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
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 7/7] bpf: Use try_alloc_pages() to allocate pages for bpf needs.
Date: Tue, 14 Jan 2025 18:17:46 -0800
Message-Id: <20250115021746.34691-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Use try_alloc_pages() and free_pages_nolock()

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0daf098e3207..8bcf48e31a5a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -582,14 +582,14 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 	old_memcg = set_active_memcg(memcg);
 #endif
 	for (i = 0; i < nr_pages; i++) {
-		pg = alloc_pages_node(nid, gfp | __GFP_ACCOUNT, 0);
+		pg = try_alloc_pages(nid, 0);
 
 		if (pg) {
 			pages[i] = pg;
 			continue;
 		}
 		for (j = 0; j < i; j++)
-			__free_page(pages[j]);
+			free_pages_nolock(pages[j], 0);
 		ret = -ENOMEM;
 		break;
 	}
-- 
2.43.5


