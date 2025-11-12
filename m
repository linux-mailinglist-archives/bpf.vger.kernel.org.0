Return-Path: <bpf+bounces-74322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6706BC540A0
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8002F34609C
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C72334D931;
	Wed, 12 Nov 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWjUaMe2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC934C9BE
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973928; cv=none; b=nfLZO4K/NRHe/cl+k3q95+SgxzpUDHGra1RfMbZxhMYJMJidQHm6nlCl8b21W6hoC5VjZdVmNP6h3EEG3lJIbqceyG8Ig8N8ZSBfhEBvpLNU0SqELDHOSJWk2Ett7dG1suuSbHU5tXkftFucoDRb06RG253ZbJoV+aWk4qSWfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973928; c=relaxed/simple;
	bh=qsNdbwfqE6guWk73y8bMN7Nv80rnoFe+JZvWLXyQBdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0H5mILAspBp2gD9Qi/yZUhNzHgs01DH/UEqeZhecq1ztVi0mvsr16pm6BJulljMcL3pPRo4JEdZia9TxtPkKI67FXsMzkNf0gss4I7art6Q+LdrJB5sId3nnTmP0Oz6dMsbPcfEAFcoODN+7n+FlM6KFwdO1Xu4V7HxBAylFDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWjUaMe2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso1024492a91.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973926; x=1763578726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3WsKjgbP+KqyauiXgVNPCy7vp9KyRxhPHjuMUUOEgo=;
        b=iWjUaMe2L2h1IY1l1pCs3BsNJZvQmefuL5Q+VEO9w0OrtMtbf42W8fQZePqxQLWjo6
         h5/lRzo/Axbif78RF3EOXko20luQAH93nkn890X1brI9cqzqKIC8qOZn5EEL8AU0pvXH
         /Ftc3vX6X3W7uQX3TJy0gJQawjsjsBqvZB8xlleOKu4N0sBtNHBAUGmDsyPQYA1eyrP6
         gnZxPxWSAn4m19CEzZYjSwns7LfefEDGYK3O94bt1ACwGR7HNT5uePRrdqk/hT9U1LwX
         d45SZGwgmybByMqJL3H0e1QV5I/yvUJhYH9JlfkdUkaZxYry24Zu1093GvMzLOC/gxIW
         2ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973926; x=1763578726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z3WsKjgbP+KqyauiXgVNPCy7vp9KyRxhPHjuMUUOEgo=;
        b=B2A39k3D/rVsLalne16Lbkutg7wA35qFGQQaoVxahzVolBEkUdGHnmB81xnOtZdP0T
         Po+wAImZATTs2yg9Xnp524XBsPI3fMbSInGzbTsho+VtgY/5SxPszywkPybp/xMa0qGo
         crEHZ7sEXih90LTXg/fojsXI39gL00djAOIPw/hTEy66igutYrsEIFjp8gakxgxxrbRd
         6oORBbGKa5NZZHLRmNmn3dJCe3E1d2uvFuStkbwzk1NS4eLJHq4c66opchCjmgXg4DXe
         wjwfAqaTHY3lfQL8Zbs2xcgCw+GdQaPmgj5nbvgWn+A1VgDN1IKZA1eLpcLNnFcK0ez8
         WfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwvT/TUFz8d0F+w42H1QVfsLqg4Lf14vnck5RbORLcYeKjn8Pk1rPRnns2OTuYE+zP5GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYU5Wb5JkKPRgoEDzv3+FXg/0lHamA4J+AC5wV0PjYtzUAzsXe
	O44wygrW2w3dbbXNllqKCORiAnbE9c3IeoM92WtaE9u5EIIGMbbx8f58LlLQz88x
X-Gm-Gg: ASbGncuf1IruDHQ5N7qbNm4cfQA1vJIBbEgHXJS0l5vb05dxw6sGpeYf9E+qt65jaha
	DDPIkPSuzTWdr85jijfsuHZ+7HgGGxzvoKbO8Nir0zZjCeyw+4frF+4wqR5jF2uWbIHAdMfkEIv
	QR2u75ou0oopKJUN4/TKauDUZ0wTgF2VBQB7vqkVsetVDrnRSLLOlfRKcJ36s6banr3CO/mwa4z
	+gRFl6hGNEYk5EB7yKwCphw9BmPC1Sp0oofHEtfcyYepYZljkYG3PtAbJvIuvmV2YwYHMtGKdZN
	wTsfjFnMrZ4Ns93ZZJBB68eypq5EfnhZeyJS4kt+nBgQCpnKpEwftrNsaCMM+4E9mzE6AtLMBpM
	GUgnNZY3A0sGGM7Z70xGlQL7k5U19HPrHp/tDubR5Wkrv7+sljaAMRAPMX965WAXZymHvbfmHOg
	VwRtCGOwOQOhb7Ti617gPgfP1hI9EQyxMd
X-Google-Smtp-Source: AGHT+IEx8zgd76NJsV1NswRAalmGvg4jw92jAb5hKFRpnzCjVrgOWDoh6LdvYOwY3ymtnsLGhg2L3w==
X-Received: by 2002:a17:90b:4b12:b0:33b:6650:57c3 with SMTP id 98e67ed59e1d1-343ddec59b1mr4825254a91.21.1762973925965;
        Wed, 12 Nov 2025 10:58:45 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm3491565a91.1.2025.11.12.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:58:45 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
Date: Wed, 12 Nov 2025 10:58:32 -0800
Message-ID: <20251112185834.32487-4-vishal.moola@gmail.com>
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

Now that we have already checked for unsupported flags, we can use the
helper function to set the necessary gfp flags for the large order
allocation optimization.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c0876ccf3447..6a3ee36d77c5 100644
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


