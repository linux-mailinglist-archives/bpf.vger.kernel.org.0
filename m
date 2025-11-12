Return-Path: <bpf+bounces-74323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C46C540AA
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 20:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 440333470B0
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2134DCF2;
	Wed, 12 Nov 2025 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVshVBD+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22D34D4F2
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973929; cv=none; b=Ik7/5tD3duIDSqvKEChBzIoj6NmRJ9yvts4eEwQu+9HlYqYb8w97IofLqq8jx8fPTQJdjQSGBgujO+LLGCvkW5VCVBZYZqqGu2AmB/mgZVszZhMQD2XAUBowPCiWS5iFLjqXXstiraGebxsCKA7rxNmao5GAWWRrOitVKOjtnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973929; c=relaxed/simple;
	bh=nN2xdyMdxFwpjMYxAIENipm0YmxDg71Krkxhb9aKY4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8o82J4ts7U+5fl/VEv40Xrbkq5b1wvpTnreY6fUckCX4gKkcgp+4ilp/VLn1ICqu4iMKe0rlPvReMSO9wY9OWK9lM+EAj3HiUg4d7QlRCQonCXyy8UbJSj3sDwGejTrKQ6zuZ8h4kMXOMC8K6rywwJeaIMbmRRVSXzYIlTeMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVshVBD+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3436a328bbbso1506737a91.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 10:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973927; x=1763578727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I7Klz6oAgGe3SSsI7DSFPvLctg25agoEpI/CIFVteM=;
        b=ZVshVBD+H7nQZbmin4+TWKQ25Ec8t8VPG2t9u5h/4+svhvojw/5egcqDlKKU6j1Hk3
         HDFXEaxNj+7puIGW70+jhmyb6F1UFbHTqSYANOj3hTxMmE6EkfGvD8vk7Tw+vgpwpFis
         Q5wgQin+KJTMJAod/CbY37Df4MhbbF68YyKj0MkKV8lj7uuxU9jopaQ5gchPRysjlmrd
         SKJ51BnrJuMZLsw9sJPz2qTyc0BbvHfkE1VR77Uv1vmDTntfpdKf4xsJjINWCnvwEXog
         1frmystghLhelG2oUMe8btewmCH2QwOpfYcSSd1UqaDXKeuBGY/HjybqKCgCTX0YG4fP
         JxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973927; x=1763578727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1I7Klz6oAgGe3SSsI7DSFPvLctg25agoEpI/CIFVteM=;
        b=tXXzVL0oYkR6iYGdwoFyQAsZiBgklV/INpwcXu6jjXFohIafSrzD4ar8BS3EvRTPyz
         lYkoJKEHupOc/bSaym4gQKPzyaHTs9+8csyxn6+3P1vtMR9ceozHxm3b8NWNLoN+Mami
         qMDGvCkajTztxBeQhLM5ZH7z326sXsdaEkiMTXlk6LHHa7H+2A/6rcngFI8/LE2JWVKf
         AeXC8u/y+cC2UBokhyCi8cUb6oJM8z0TBZSM5JPgfbyxgWlCrt96eq5xJfBUk9vZkPEQ
         uYj6+yzCZ9w//JGVbSNcycWaP3CSbyKqYLXdsz0nj/ZWWC4k28qi9fVuScSE9HhVyqRI
         ya4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaPL3ZO75ktgYgWCF9hpeWlv0rWVaeCNoLm8wt04SilTkkLScuyZSODKXbNrC0XuvI5g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcgbtU2kIRdToQHhMBLPAQQ5bnH3VWlcCh86XKBSpFRHC7vj/
	doSyhzdBfj1dQt7l4+f51D3dYeSUogk4B/j/GYcTTLALXcFDV0NLrs0G
X-Gm-Gg: ASbGncstLJwdhO04hXJ6OuYhyLGLOsc2j8kGTnCWJQ0rj3Y4NmaVwZ0GFA4wCuOtRuu
	uoXXRIwg9UEWht/Mz4GHds89U0aBhwCuIA4OYpX07mwliaSKqEwqfeWKt0vlMk/xN61RavRkwcX
	ziox730NiXBlKBXfVHjq8VtV+M1CH1jvPiZKiME0BvF6HqmgAdRJwkyr0tGlcmxDABNTDYrJLdJ
	ihWWp77oX1suOHOLqfTDunx16uZ2lgeGkID6hedCsrjqUwXCiTubcIQQerovfEXy/hxasVczW8d
	spyBY3f0mZ0lx760L0GALNjCWYFvsMRWycR/tCzXQnK0Yd2cBuDqIgZ7Kq87crEVgxpKJc51/rH
	BLhoQLt3L/pLz76QjcgAlkA4C/kVAIJZw9TWWbMXaiB7tupedEdzn1ML2/dCNLgytbshS8sKO0y
	J62GI4VUKazeWiCGaCbnvsDbaTKGXHQs0N
X-Google-Smtp-Source: AGHT+IEXSRKPlnUmANkCKnv2Ry+gqRz/FWfvHlbIj2RgqDD993fXyqdwaPS9bBtM9eHGXaWe2sWATQ==
X-Received: by 2002:a17:90b:590b:b0:343:7714:4cad with SMTP id 98e67ed59e1d1-343dddeefbfmr4942912a91.5.1762973927256;
        Wed, 12 Nov 2025 10:58:47 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm3491565a91.1.2025.11.12.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:58:46 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
Date: Wed, 12 Nov 2025 10:58:33 -0800
Message-ID: <20251112185834.32487-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112185834.32487-1-vishal.moola@gmail.com>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only caller, vb_alloc(), passes GFP_KERNEL into new_vmap_block()
which is a subset of GFP_RECLAIM_MASK. Since there's no reason to use
this mask here, remove it.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6a3ee36d77c5..49e0b68768d7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2699,8 +2699,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 	node = numa_node_id();
 
-	vb = kmalloc_node(sizeof(struct vmap_block),
-			gfp_mask & GFP_RECLAIM_MASK, node);
+	vb = kmalloc_node(sizeof(struct vmap_block), gfp_mask, node);
 	if (unlikely(!vb))
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.1


