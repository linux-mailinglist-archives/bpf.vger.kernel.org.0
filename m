Return-Path: <bpf+bounces-45004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5E29CFC4B
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 02:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C58288877
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 01:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FF718C004;
	Sat, 16 Nov 2024 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWyMYmle"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1012913
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721745; cv=none; b=kQHkMAXMRLRxVuqA+WWZY7KM4K9AGgwxCEPnQ74fW23+hYhYNEoDVhU0AhxIB7h8brNue6RtYLWdGBDIgTG6LKBjhmAt4/uYCiU28/WzQi+3grucEOraIGpo3XAc5LrZvT3mfMNrfja5GXEfw/nrF/aH7FV34Ewo8e6qV9doEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721745; c=relaxed/simple;
	bh=lSwWfuCW9PE91B6KJS6oLIv5NXEAEObVlt6JhSndn6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrtE3iIvJp0T/8by8hjbtvPwm/buZEdVyVjyAFPpylnMb8b5ub605EtgJpfgV3qMIKdl5l8oNOkqlyWU8FoqHDTJ6PbqrhxByGzStU7b5yZr2y4+YnZYXo4zGBIgQ8+EQoG/DTWn9Rj6ebcYzrR8+GjlSDR/NiJPjdSWS9g8oR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWyMYmle; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so1050628a91.0
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 17:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731721742; x=1732326542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQx3r5mMfkKCKYgKnvoSO6BlBctlynKxVbPBT4K9QIk=;
        b=JWyMYmle/xeUM79OcHozHMIYISIB4plHjlvW3qvqy+sExkNunXiSJVO85GOfubA9+y
         VF+7Fi5jBSOQgAT9Wzb2/uuugDrXp3h2jn2C7YEeu1uhk7AdWVqZ53yEAwWv0EupxQO9
         Vi2H9LrYM4JsrNuPrCH5FqVaVb1pX3D/QWRWSTsZFid6w/zfEDe9ThCCEywE/TppFi0J
         4JCSEpvtObY6W/8jWyUUAYayfNlu4HsMPN1lQGipdv6AJsdn/xur39hD4eOLhGe6Ak7b
         xcptDMiQ+pZf3oJILZNp3kldk2zpAa3bZoEUoDBv6Or2EBCAIBlMlNQTmtVP2Gs751i5
         ms1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731721742; x=1732326542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQx3r5mMfkKCKYgKnvoSO6BlBctlynKxVbPBT4K9QIk=;
        b=OiJI6C8jPJwC7CNr5L+eOrDvrDQPiXEWWY+kCR1rQbX3/Lf3PN7e9szx999tTNBbu1
         vCy/Qyti88u1VSZxAOnYyK7gLBJqfxGkm+E0ZRbjGzL8EtqwrUK9NPobr3kqtdEzsHaE
         Ch87q+Wdv99daHT2O82VBztxRE+zomDHvQFuXz8CMgXbrk66EuwWsHSKf8MPTeX1zHol
         dI+UOhBQYFyfmJtnJGg9KevKK85eKQUecKvOiMbo/ix9vtcmLu/WV6uf3191LzGqY8R+
         rqvWMLVHTxaTmTXTVS1ay36+LoNqal/j4YJkRH4k95MoiZkhT6oJZwq99lYz/c9fgXve
         my8g==
X-Gm-Message-State: AOJu0YyctihWGIuzcCdkXaowMdwtiMVspFaIaoUuxAHwbDaEP/+5Fljx
	iYFiw2U8IqSSbhnU4RJBC0EPgAPLOP5ml3b7LHn5pOQJuZ52pouiUCHzsA==
X-Google-Smtp-Source: AGHT+IEgHpH9AjNO4IF0+21XofZgAxvjxp9bfZDCDBA88H84ASylOHL4q9vvZJ9MPtwKF8HTV/85lw==
X-Received: by 2002:a17:90b:48c4:b0:2e2:bd7a:71ea with SMTP id 98e67ed59e1d1-2ea154cf3c7mr6322465a91.8.1731721742130;
        Fri, 15 Nov 2024 17:49:02 -0800 (PST)
Received: from macbook-pro-49.lan ([2603:3023:16e:5000:1863:9460:a110:750b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea02495986sm3606970a91.15.2024.11.15.17.48.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Nov 2024 17:49:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] bpf: Use try_alloc_page() to allocate pages for bpf needs.
Date: Fri, 15 Nov 2024 17:48:54 -0800
Message-Id: <20241116014854.55141-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
References: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Incomplete patch.

If the __GFP_TRYLOCK approach is acceptable the support
for memcg charging and async page freeing will follow.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 58190ca724a2..26e6cffb2fe9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -581,12 +581,14 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 	old_memcg = set_active_memcg(memcg);
 #endif
 	for (i = 0; i < nr_pages; i++) {
-		pg = alloc_pages_node(nid, gfp | __GFP_ACCOUNT, 0);
+		/* TODO: add async memcg charge */
+		pg = try_alloc_page(nid);
 
 		if (pg) {
 			pages[i] = pg;
 			continue;
 		}
+		/* TODO: add async page free */
 		for (j = 0; j < i; j++)
 			__free_page(pages[j]);
 		ret = -ENOMEM;
-- 
2.43.5


