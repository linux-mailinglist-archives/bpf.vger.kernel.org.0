Return-Path: <bpf+bounces-58368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835ABAB91DF
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F22E50455B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878C28BA98;
	Thu, 15 May 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQh6mxHc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C521E5B68;
	Thu, 15 May 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345340; cv=none; b=ngITEB+XLvUsFUVmxmoKnANn5AiTIOCxP8LkgxypWYo8dyX7IMqmE4Jch5qYVwccNXJ83VoXHhhRvj5nZ3wOSvsOrVPp1DpFakcESd7L1kUE7uRJHFwtl/3VDJghHu28k6nkBZhOwt1sfHY2yhwnvL3XlHc9NtiLdZYE8Icmx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345340; c=relaxed/simple;
	bh=z9irnXGnBvQrp/d6U5i09UQ0eP4PPoB4jFvCw3GG5Eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5IgTQiLjaQkikyREpJ/i/T4wB/Ug7js1fRf1YOxuKYllvE8loY0to1bMfzV7Js5iTbfXgd0Uz2Ki6kkZpgL91guJ0bcpQHRNpygdMZH8dfsUBDKBcVAnhwFQbW7/RPYTFtx1lNg6rDLB1ye9Ryb6VLrnVyz6bxU49U3hTrk+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQh6mxHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F700C4CEF0;
	Thu, 15 May 2025 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747345340;
	bh=z9irnXGnBvQrp/d6U5i09UQ0eP4PPoB4jFvCw3GG5Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQh6mxHcqeXKhPT1dyh1SA70xwHpyVoZt0LW0sfH4nslVfzHj/5A0ecGaTQhmgEla
	 8xvFiuw+WqpvQIXI9o28bXFhgG/pkytvThEZdHBX6/bnkodzWVfW4Ym9V7Wco2UNAQ
	 9XKQ6aq7c16cv1dYri1r/LD7Rc5//T7ewhaT6hofazb2L18p1NO0JIdRU8xEQQ7qLg
	 VghxvS44eolPCz95bUMzFRStPDNGu6SfqAgXxrlIQk/sV+3zH52l3hxgVH1ukMh396
	 rhw1uKT1VVCNewzyT9tSYSr9nlgvimQCmZKqj/MqmnYVroWg9xp2zmdH8XSnmYwOwf
	 EwxX30bzsVCQQ==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-mm@kvack.org,
	Erhard Furtner <erhard_f@mailbox.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] mm: vmalloc: Actually use the in-place vrealloc region
Date: Thu, 15 May 2025 14:42:15 -0700
Message-Id: <20250515214217.619685-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515214020.work.519-kees@kernel.org>
References: <20250515214020.work.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=kees@kernel.org; h=from:subject; bh=z9irnXGnBvQrp/d6U5i09UQ0eP4PPoB4jFvCw3GG5Eo=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlq8dun79rx688HA96MI6Yvt5nG6022C/q6d2GEvJvK2 yPs8woDOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACbSrsvI8Dq8eW+R9P5/5V8k 5h7rmm2nfaLoUmRj2+Ldpn88GBI/KDD8D+ozsv6UVmDQuj7qyrqO7+93/bh8/7FV53W974kRTqw MfAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The refactoring to not build a new vmalloc region only actually worked
when shrinking. Actually return the resized area when it grows. Ugh.

Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Closes: https://lore.kernel.org/all/20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Tested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Fixes: a0309faf1cb0 ("mm: vmalloc: support more granular vrealloc() sizing")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: <linux-mm@kvack.org>
---
 mm/vmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2d7511654831..74bd00fd734d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4111,6 +4111,7 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 		if (want_init_on_alloc(flags))
 			memset((void *)p + old_size, 0, size - old_size);
 		vm->requested_size = size;
+		return (void *)p;
 	}
 
 	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
-- 
2.34.1


