Return-Path: <bpf+bounces-49646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92452A1AF37
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB8E3A46DF
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2860B1D7E35;
	Fri, 24 Jan 2025 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxagcC2w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3D1D7982
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691036; cv=none; b=Esyldn/YSPvWUnedESLeVfz+zjaUZBpnIaHTh1KhL24yO5rnlQx+/4W+ir+aZp8yTIrxCw3sJge7BYS93vOuJMI0ZfKnJYQzl7vz22qhlTzwafr2ao1t4CjRgvQB6kqTwSx9nGGRRH+1w0yhiS1YCpT2D0mfVD2F7622leRR3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691036; c=relaxed/simple;
	bh=PkbsL7XC8j5LBWMTJb1ZtearOWIvOtlSfq++Sl18MI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWzPkZcnYhhFuPAG7JSSgl+uT0bpzW++qkEPCD6AGLs0rZ6mW83rULjxP6nc4LmyuHDsU9ZyDW9iiib8iIVxv82VIPHS09GQm1uQEAi3ItsJyPvjOHepXLQG1ayG8HhYCGs8xgI1zS6EJd3Te/szZXCKOMScqzmJPJ8wOVFXkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxagcC2w; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21631789fcdso37739505ad.1
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737691034; x=1738295834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXCJ0gdG5EF9yWrbtRQyNOOIbBLtByDZRqzMTlbBC2I=;
        b=KxagcC2w9euR1H3y5MEnb+TAXiJT+j/PLy7Ra5vCemvy2DbRrzcCFwmNTxaMsZ26G5
         hrmdK3GNKW8vVm64XFsZS4AkCGrepzSRlsHfPw7iKACPb331PWTlpQR5QGuWyetmWpaq
         Gmyz+iXJ3yw5PBO8uhRoShNbeLI9vn6kCv/dy+eDjtDlKLTifWXVeK3ZG+l3/nPhqSnS
         egWNXzVrJyIpn8fcBWsJ82TK1B04yVnUjrkjhAy5Q1UFUm0nb1AiOpBMf5I8XkgGQ9IE
         uVqUlihRt+RpwNUq6gmaJsbT8xjZpDEVLPi0p3FQ38DDDoBX05yzgkq8vwMoM/PvZY5P
         cFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691034; x=1738295834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXCJ0gdG5EF9yWrbtRQyNOOIbBLtByDZRqzMTlbBC2I=;
        b=Iaj1K1twdjIBsjaDk+FZCL7XrGVsNlg9zSyHkXybeGGm6sOS9oQTRSsvBDOpsokjwS
         ZkJMCdyw0ga6GVasHR78xEMklX5OZO0dQ9yW7D/T7rcQsZ6DJmFNSVJ15oyzkzHl00g8
         IAfIvfzTwW3SxqleTIRRJb2uLVeFbYDRS7hqcD7CB3rPVtzepVTfVwzsVMtySUto+5op
         UTT1vP9z/WltC8J3BDU6JciLRzn7STGofrRYhJQ12rb+RqzQ9Vh4bp4jhk3nLng55tBd
         srkl8PZ4u5ZcC1W48LRyYURFQTrjSwj3TP5VcAxeP/Y3Q3F20WRq6yZCZ3ZaklvaUWUU
         lLIg==
X-Gm-Message-State: AOJu0YwnaVb1JFTPb0hZTQ1FP5fYnk1HkSly1i3zDwFdx4lWnn3K3Air
	j9bPnAcM1kaRufGYAOhD+OW28/EhTfLTz/I0iCvM/Y/a3wfofwFfd3lZ4w==
X-Gm-Gg: ASbGncskredptSn+t1cgh2JkrCv2eCpUbQsKGOlcNowwXbkHQB+fV93jWiGszWqinE1
	4X3GAAwZ5fr2WXFcmIbSUdQaNkayV0uW1YB5UjK7nSKiOjp5qvB88z+gcQwkm8LGP3/10muLpuh
	R6iljzHxjYGDMyJsTCyju0kLQ676uzGvXgtURwMABWjG5/6taM4vdNQTkwhi7r8ZEmERJGmJgs2
	ZFSTyUaP5gcLajcEzbw+AXHO2ZYAqw9IYusqEvlsBcPNY24ZD0Cc8JPQhqGMDb+piwVo1nYj4SD
	M6C7tyocb3oKuvaPSunWsGfLlvQeP1LfyzBCCLA=
X-Google-Smtp-Source: AGHT+IGfeaoENw63hXIHNaiPfBmvJhfA/W3E60RsZYSAmDLMCHiy5FG9LHtcRMUd/Av34DsSkZ4Ksg==
X-Received: by 2002:a05:6a21:9210:b0:1e1:a7a1:22a9 with SMTP id adf61e73a8af0-1eb76cf0566mr2444457637.16.1737691034346;
        Thu, 23 Jan 2025 19:57:14 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac495d5531bsm652054a12.47.2025.01.23.19.57.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 19:57:14 -0800 (PST)
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
Subject: [PATCH bpf-next v6 5/6] mm, bpf: Use memcg in try_alloc_pages().
Date: Thu, 23 Jan 2025 19:56:54 -0800
Message-Id: <20250124035655.78899-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
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


