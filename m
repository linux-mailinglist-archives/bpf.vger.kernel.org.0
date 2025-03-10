Return-Path: <bpf+bounces-53724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F45A594B3
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 13:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6CB1668EF
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2AC225785;
	Mon, 10 Mar 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaJRGp9V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF401C07D9
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610424; cv=none; b=tDg6wxNK8by3ulIeT6OGUDKpbUYiJH71ww51fbyviZI+jO4B3Q+w1XektvJRH7McPe8Owti8mhKAgz9AaZlS5hT2voyNkmzYneaEe8zoeyDV7jcTbebeHbTTfzeF3HzqOKaeg4gvgWIccuxukDd16XCFb5fyY75VfyKvetuaiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610424; c=relaxed/simple;
	bh=DfR2nmZuPJJLJ6A34exQEFxgj2rmK5c5sJ01JhYUloI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dg6Tst6kf7cRGyL7e74oe0GAz/A2Y9ongLCHd6ZvjGsNarv7QwYQzAo9Myiq4Nqe6WB1VK63krCBHeqU2w+PjAeflB/RyPakxhqSeosquxHtQMUlwii+GmcRx+Q9DdgOjzH13QOg6H5mfKJEAaVxn7QlZAKOibTb+ssdsXCyP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaJRGp9V; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39140bd6317so1067135f8f.1
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741610420; x=1742215220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hI2gC1jTrp0m8ZNlswu4ynEMVyG0y5Arx1GBXG1HMb8=;
        b=ZaJRGp9VicS2o4jLjkXnwg8nDCYnn3gzl0DFscWdmUVq25zzR77a4VlEHTi2YwcuRm
         WMnmL+19yVmyuU7HLKS5sALG3oOogD5uQuq300f5PlPEedvHHvxCaG5CvJmgjTRyeZV4
         ROZ1NtBY+oCwNx8Fga1KPxcIQ/DjsSsP1oStHSV3zqhp+qe4CUr7miisncvmR0dfw464
         O5kyt1zeTo7HsVtR0CnjxRx9XCSc03XNVkPsxtSSNDCzA0qohmSGQHp9lEE6XoEKfztF
         LGEPxHCQ6O+dFtXbT0QTGmOMS3aZa3uqym4AE20vJpYqmwdRyctNbi1o4JeTLevFNxy7
         b7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610420; x=1742215220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hI2gC1jTrp0m8ZNlswu4ynEMVyG0y5Arx1GBXG1HMb8=;
        b=AXEyC3UgQyg8kB/9TTtH1OQeqneet8ViAJMfdId3hLmegUfparzrqe5UEWHnYsTOZ2
         nDZho5Bm0d3wIcpQWAsiutw7A6BpfFOTWQhFeD5OC2gZEWSAW7JnnxIpIiV3DV2BgYIC
         thgcjhGtw5D02oxl8KykRLPKETdoo0WFmtq59EY5ZCrb419OjgbI3r5ES0Gh9gvwz/ra
         hG5ki55Q4AUacnlF4wUpSl0oVQXiehOM9qiPdWNbCnCkWnDJpDFJ4Wob3gofbWf0mPVF
         Zu+xxlmbpTXUjAKfn/+F71gUT8BD55ZJtnwggXwnPltZhECFT8bZivHSlKBSV5ZPHqTE
         d7YA==
X-Gm-Message-State: AOJu0Yyjy6xv8WRKLwLs3oNKANR9DF/Vw6EU+IQzz1E9rrXtJR7FPDpe
	7HAZDR+BEJfcwMyDfgOTex3A1XPs0kUuEuPLlk+9Ad4GIGWWuZM4Kl3trgEODuw=
X-Gm-Gg: ASbGncvxh7qMnCQ8IChaPAH2IklwW2F4YSXi2U11KmuGpjLECX6woCTU34Lg0Q1A3Gj
	OPPEiQUtRJICF7WhRgZl4WCxpdOm4pnWYtFMfcDKlnC01EpZuGcDlXimHNxlvuo1+dDqLZP+SV7
	9kEhmrWNJer9MnrPjVGrruaKJfX0YVCnd05MEzlsxaRW+ZgBGoDh46RqozguigR//q/92D0N01+
	la5kxIARbMQninFvIXFL2HFujLn/ah9uPWf2jG+lIKo8gT3iyRD5wv+hl8SJUddPy6Fdu27J+OA
	Us0S2Zch0mcEh/dL/K9h1dJWS6zeULHEncsx943KkoJ8XDbyOeeckw==
X-Google-Smtp-Source: AGHT+IEH6NhHAgJ7mAgUXoXqb8wh/XTGHPhBAK6GgtU8DmQnz0GU37HtxF2yuIdrxQDQYwsv9p+RaA==
X-Received: by 2002:a5d:6482:0:b0:38f:3e39:20ae with SMTP id ffacd0b85a97d-39132dc580amr10340592f8f.43.1741610420056;
        Mon, 10 Mar 2025 05:40:20 -0700 (PDT)
Received: from localhost.localdomain ([31.217.44.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01952dsm14543759f8f.45.2025.03.10.05.40.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Mar 2025 05:40:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	vbabka@suse.cz,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next] mm: Fix the flipped condition in gfpflags_allow_spinning()
Date: Mon, 10 Mar 2025 13:40:17 +0100
Message-Id: <20250310124017.187-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlastimil Babka <vbabka@suse.cz>

The function gfpflags_allow_spinning() has a bug that makes it return
the opposite result than intended. This could contribute to deadlocks as
usage profilerates, for now it was noticed as a performance regression
due to try_charge_memcg() not refilling memcg stock when it could. Fix
the flipped condition.

Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503101254.cfd454df-lkp@intel.com
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ceb226c2e25c..c9fa6309c903 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -55,7 +55,7 @@ static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
 	 * regular page allocator doesn't fully support this
 	 * allocation mode.
 	 */
-	return !(gfp_flags & __GFP_RECLAIM);
+	return !!(gfp_flags & __GFP_RECLAIM);
 }
 
 #ifdef CONFIG_HIGHMEM
-- 
2.43.5


