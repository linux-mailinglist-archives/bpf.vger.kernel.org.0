Return-Path: <bpf+bounces-74770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CACC6591E
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 865234F1EE3
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8329D268;
	Mon, 17 Nov 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGbVYjqM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E53128BA
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401057; cv=none; b=m0RyfZWpYX1eceoUrqg61tm1TYNYNxiixkvkU6j3qfik8J5QCueUx4KoMGmNz6qMCIz1UY9muTU3AB7MTroyiFMCqYQJrymA56SZCsKR11QLGz4M2bFDi/33czu25+QBMqpfO+AMOyXBc/ezmc4RhuxVgvsrXwR/HnsgDXdlMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401057; c=relaxed/simple;
	bh=o9NW+01xLYwYRcVC5p6OC10u2K7VJOzoZHMQHdDze2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuBth2otwy6GwVCbt1YbNn44Zon1CRKZh0QtbZW06qkXkEPWgRpVGQGNwyeGnDgWb1Xje7uCH6vAs167b4p0Vo60iOmiLyK6UcsDAFbV2tgY9kJdrKQiAOtLi/jtqi9PP05pMFfI9sWMSHRno3S/njQbORnVOsQvtaBN8K9SBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGbVYjqM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-298144fb9bcso48538165ad.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763401055; x=1764005855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12BdLtJLTrdqnKL3Gi8pF5N6lQu3vbDUSG772a4HvjU=;
        b=CGbVYjqM+WEnkL2W5v+zcmGFWvzx+QGrRi+4y1F2ruxPDD3sripUbc7/WfxyvllcxO
         wUX54Iu0TPqcTZlXrIbnLJiKFXRBObgETIH5hpKAIET9HRdOq+0n4PuS0tXkhKS7t/JF
         TJw+4n8pLx5Qx/6fQ3HMdr/NytAPiyHc9PhQZekD6qSxHtgxOEVIyhJJLAfxAGz+c/s0
         yKdswQ7JTbCjHHI13ZHghCUrK0gTAyHrvl8DVpDzWybS2DJPCvcphum8IrTVStrmDAvW
         N+ZFtMO74YUOMjpOWomwCuQo0wAkUbcqp71uvAXP2Wxu4+Cxloxy+tuDJezKxP20vdAy
         9qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401055; x=1764005855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=12BdLtJLTrdqnKL3Gi8pF5N6lQu3vbDUSG772a4HvjU=;
        b=s6vzcKssSte+Z991W/GTwZjXh1+ksj8Zv6vGOCzsdVuovwAExxBPw5jof4awj7oTwt
         01h7tVFXB7+MJT4mksldBkqplx2mfmASYzBsy1iF+SuY0vaAZcXr/uOGkY+jEszJrTFI
         9SEXpCwX+s9ByWBQ/LS1CjGnpZ//N0eqeULS9p/G2JWew8kbHMDSSVsdm/FVfqFMSSWr
         CL6eVVkE0feIVjLDdeZDZmw+6lLUNjbAIa1+Tmg5W7ck1fmRWyqQJlzF+DsD8ADwnSHb
         r9cU5QDX51NC+BI2n03GKopSriTkINLC+OQi29lbFfVfquIxWLxHMwrv38bXm4OWDsgE
         rtLw==
X-Forwarded-Encrypted: i=1; AJvYcCVoIg5i1xitgUqs9YCl+JgT/nTErWYtbAKL8PbbKUnwrXfV50AMtxXcSkMtaDxKZpZV+CI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Mv8wgEu3pIlEVgAmz7MQVZSTZAAlJ0Kg4kJZm1afhz8flnCO
	dJq+By78ZVYOmSJDmyjl0l0VUhZwfY0++MFueyPDdoWv37qNjwQ6Cf8P
X-Gm-Gg: ASbGncstXAKa+VQFTZbBercOJjNVhAPPosqCehFU64WRG7LVyV+Xa9EhWOPWfR9TwtY
	mDIfygk7SfG9P4fXl4JX/5himRXj4tfnYXkYRBmjxkJMgo1R+F9JU/qSdPp4dqV3b3yxa8a93eU
	Y/1JsgDHkIK29EDSfuQULKkB/5R9K7CgWUlHscmdrEJmYUN+F+5oJtNNXrPRvRIpPtZfRX3GNkI
	aaf0jUeIz/8n0A8bJVU7nIkhAHdMVIP/ej3t3maVQt8NJPaEx5ttGSZOtWmaVT65XSzZvq7XI0a
	fFJnSqyqrsk5aKaxBIXgxHGC35PE6pr7aZ34D6MQ/Ck2n6zRydsyfSJiEGt0MZ3crYBSjdrphrm
	63ukBSdcRb4J37uIm9AAWq3I9I1Dhy7Wf8r/V2xDYXlqo94wYomR5//URBHCNID5hkBCVXw/nwC
	SvXvsZ7t+SDrhauHkxxvhRlR3SMcl2v8xlziqQH1EhM1NRmnmgMxnA6Q==
X-Google-Smtp-Source: AGHT+IERmnZJtAvVp6CfmHrtZRut00Fpcg8ERzAMpZpi3llOcyyTNaSlwGTA3HsU91J4Nl3wu2zbpQ==
X-Received: by 2002:a05:7022:7a6:b0:119:e56b:98b3 with SMTP id a92af1059eb24-11b411ffe86mr5432668c88.26.1763401054591;
        Mon, 17 Nov 2025 09:37:34 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11bf23d6967sm17190077c88.3.2025.11.17.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:37:33 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
Date: Mon, 17 Nov 2025 09:35:29 -0800
Message-ID: <20251117173530.43293-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117173530.43293-1-vishal.moola@gmail.com>
References: <20251117173530.43293-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have already checked for unsupported flags, we can use the
helper function to set the necessary gfp flags for the large order
allocation optimization.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0929f4f53ffe..d343db806170 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3634,10 +3634,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	unsigned int max_attempt_order = MAX_PAGE_ORDER;
 	struct page *page;
 	int i;
-	gfp_t large_gfp = (gfp &
-		~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL | __GFP_COMP))
-		| __GFP_NOWARN;
 	unsigned int large_order = ilog2(nr_remaining);
+	gfp_t large_gfp = vmalloc_gfp_adjust(gfp, large_order) & ~__GFP_DIRECT_RECLAIM;
 
 	large_order = min(max_attempt_order, large_order);
 
-- 
2.51.1


