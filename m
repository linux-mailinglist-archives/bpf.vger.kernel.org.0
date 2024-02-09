Return-Path: <bpf+bounces-21604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274FF84EF98
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E8B1F23718
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7E538A;
	Fri,  9 Feb 2024 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXj6CYRh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5E5224
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451660; cv=none; b=XI2Tgn4AjmIZZXOK4RYHQfF4HLpgi22RbXv8O29AByxL9IvYYmwV9OaPIMzLGZDZacCvce1a5obdgyzRghsu4Xwk+Qn19ZoIYQ6a2EYAMfFy0ki76MYSZdD6RigV9E7DMYflZPLAuxOiD6N/ku9cwTiIe8j/H071jlKYEOaH8Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451660; c=relaxed/simple;
	bh=UVrTPwmI3HDH2ra8Q148lMPrZTmq/PMqMLLRSQkg6qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWJaHljX44T+8gdJjVEDKEDkrSn6MiduCSaGPuKy9PHPDWxvfYlU/XqlOWYH/WTOtB7uCs19Gu9OEUWKP1BKZLK3YCuqJqfEtnz+/zhJ2DqU9XOyhiaYz7L8EPTkuvh+newlplah0+QodfccmAg+zBEEkK4IWEV1KdroV9xnmXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXj6CYRh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93edfa76dso4388935ad.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451657; x=1708056457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ll3cFrEr9hbCQcocHDOoHYlUKQul/zqkLdXGSoHE9U=;
        b=QXj6CYRhRseVncUdXaHkxG9QnyzAbZoiYtRdlULyRI7Vd1KQYd2af8/qnBKoo160Pk
         bkTDMIgQQhNqE97Vw1g7Me0PWaipmtMb3iI56P9DYxJP78GwvUtKsXVFMd65NMLudvh+
         gsUX3iwXaioHKa4QyyqXTdLNPtpbTC3GDaf9F001zzlBI8ey+cuinZ90Q5W5gIQHuY+b
         6bN70sTth6KSy98a72OH9WjOTmzWx4SNlkKmtPMxvbj272pqtQu1Ll8yNaHY+HEvncXN
         s2xbjnZdFsdkKVp5mz9kSZjGF+ogpDfPdtU3Ei/SwgQyHWJY3TpyiNQuy+5ObaSrDsRp
         HTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451657; x=1708056457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ll3cFrEr9hbCQcocHDOoHYlUKQul/zqkLdXGSoHE9U=;
        b=cUA+ucg+o1AKnUKuHmca6qIs3o3Fj26Oc6j+SBvyF8+I+xSmI+I2ACYdBwUVGAaJ7j
         X09El+TxHmC3DNl6IyLLASVG01mABJBkZDQZAbFRHz64rxUEEMzXw0skYu6CGGVCSy6n
         MHmB3Wywnqo/UmCCYRVKwPdYxvdhU+i+Y/HVMjTMnpKNqa6pnbE9Daun8NjSZWgC5oAK
         6B3K/vTE0XSJ/1nEB8kjUphVp0C89FA2ABS3ZwrCumvUa+2i/4JufvB0mb2SD/ZViJyo
         WD2GoNQAlA88cCrcdGaD4G06bKXWB39cw6c7UszTr83nhkXdLzWGNq7thvb7nGke/oai
         HssA==
X-Gm-Message-State: AOJu0YwgZicvQXKjuLVY0feu6e9hmvnNpzZ657DMDhPfW69Uuz+91/Bj
	VVTufQ4q2N7d85/GFmQZr15Sz0mrjvO7436P3rTat1kcOsRO055zBTm5u0qy
X-Google-Smtp-Source: AGHT+IGkOiYtxyH9h4Hxmx0HmJv/rugkioUJ3yihq6NNOSDK+ZXse18c8Q3zRElKlWdCYTq+E6Xxsw==
X-Received: by 2002:a17:903:2a90:b0:1d6:f185:f13b with SMTP id lv16-20020a1709032a9000b001d6f185f13bmr618327plb.17.1707451657685;
        Thu, 08 Feb 2024 20:07:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDiS092+UkDyF4aEZPoblkWtOoQh1U8TGTdcCSduROIhOu+T04/eDIqGY6NzkwsOOzzZi0ztZBRPjETZoAFTsBxT2B3gdn7EYY0CrHwnxfASTjykvyk4yUPd99WN1zKGqA6dczojNPrJ0u4cqZeHkVclQfcV0afn+ij1NLT26mTYwX8tDsBlFcO3vI1tfpczHFjzQ5zEfAj3sIJaM7Ybtr2QS+kHiCwRn1K+R9vmundeWwOcBO4F+N9D7ITsVvn4Z59MKMI8lC9bdSbwy4VqUhhg30uZJOtPtrVLHLhwPbV64heLkaKzgW5Tk+DG2lHuTnYn9hyuJbcl0Hv6xLbiFvHOEwp1ebFpnSWQc32i3o5DeLAiU5HQ==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902d04400b001d9fcd344afsm541162pll.222.2024.02.08.20.07.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:07:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 20/20] selftests/bpf: Convert simple page_frag allocator to per-cpu.
Date: Thu,  8 Feb 2024 20:06:08 -0800
Message-Id: <20240209040608.98927-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Convert simple page_frag allocator to per-cpu page_frag to further stress test
a combination of __arena global and static variables and alloc/free from arena.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/bpf_arena_alloc.h | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_alloc.h b/tools/testing/selftests/bpf/bpf_arena_alloc.h
index 0f4cb399b4c7..c27678299e0c 100644
--- a/tools/testing/selftests/bpf/bpf_arena_alloc.h
+++ b/tools/testing/selftests/bpf/bpf_arena_alloc.h
@@ -10,14 +10,19 @@
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
 #endif
 
-void __arena *cur_page;
-int cur_offset;
+#ifdef __BPF__
+#define NR_CPUS (sizeof(struct cpumask) * 8)
+
+static void __arena * __arena page_frag_cur_page[NR_CPUS];
+static int __arena page_frag_cur_offset[NR_CPUS];
 
 /* Simple page_frag allocator */
 static inline void __arena* bpf_alloc(unsigned int size)
 {
 	__u64 __arena *obj_cnt;
-	void __arena *page = cur_page;
+	__u32 cpu = bpf_get_smp_processor_id();
+	void __arena *page = page_frag_cur_page[cpu];
+	int __arena *cur_offset = &page_frag_cur_offset[cpu];
 	int offset;
 
 	size = round_up(size, 8);
@@ -29,8 +34,8 @@ static inline void __arena* bpf_alloc(unsigned int size)
 		if (!page)
 			return NULL;
 		cast_kern(page);
-		cur_page = page;
-		cur_offset = PAGE_SIZE - 8;
+		page_frag_cur_page[cpu] = page;
+		*cur_offset = PAGE_SIZE - 8;
 		obj_cnt = page + PAGE_SIZE - 8;
 		*obj_cnt = 0;
 	} else {
@@ -38,12 +43,12 @@ static inline void __arena* bpf_alloc(unsigned int size)
 		obj_cnt = page + PAGE_SIZE - 8;
 	}
 
-	offset = cur_offset - size;
+	offset = *cur_offset - size;
 	if (offset < 0)
 		goto refill;
 
 	(*obj_cnt)++;
-	cur_offset = offset;
+	*cur_offset = offset;
 	return page + offset;
 }
 
@@ -56,3 +61,7 @@ static inline void bpf_free(void __arena *addr)
 	if (--(*obj_cnt) == 0)
 		bpf_arena_free_pages(&arena, addr, 1);
 }
+#else
+static inline void __arena* bpf_alloc(unsigned int size) { return NULL; }
+static inline void bpf_free(void __arena *addr) {}
+#endif
-- 
2.34.1


