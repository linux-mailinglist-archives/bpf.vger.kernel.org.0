Return-Path: <bpf+bounces-68462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2CB58B67
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 03:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBB84E07BA
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54AB199230;
	Tue, 16 Sep 2025 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ/fQhQ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF102DC76B
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987176; cv=none; b=MvLZYz/VMNwPaDwUb2+cb+fWGliFVvvxkWkcCvqvleGQkaTZ5iJbsz10sUNnT+BEb9jFCql77XOSvo/QVU/0/cuV+PqnetqQxq+r6VQGdjJYt8X6QIaP4rPge5dhmcH4Gel76HCbe7SoVLJJhOPEn9hmdg0k0mL30PK0D7f3Bcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987176; c=relaxed/simple;
	bh=hNu+Rns3AzhO57n02pw3qTeE8Zg7BS8JsBc+YPFA78A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=panGjPXiQbRZzBukZYOUDX/JQBGap1yNL0ow74pcB7O6kwWjbJf++1+w7luNSsZx6pA/FifXuU6S70L0p+xolxaRbDwEaFFVlFlxTbajmzTJInsLBS/Njm5DQ2etmLx7LyibWCzIM2VOIloBR9pR0uxYRdMb0P4uQRWxB0CUT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ/fQhQ2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77616dce48cso2585633b3a.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 18:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757987172; x=1758591972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UPA1toQr5uAUN1v43j1zuAajDVGqxLAPWCvchR38lKM=;
        b=EJ/fQhQ2K2ixqTHK450CG9xFLdMGHuR8FJgyaIyLBX0eQWGbYRKDr5bDvvYrMjtU9K
         NtU7bblu94SkmWa+vW3VN5085wZPpIexGJB7pZ+HMRc5WQMdTvKWv65e/LICq0E/4bqQ
         U8fS7U/DmsLpzn2tezQVD2T0NJ1vAgkjAFEfxA0GXLSxQ0+pJz4HPV+ZcikW995uV/GD
         0Rvoks+S+Kuwu110rcEdGUsHkpn07XStiYqGflt4DUsmP/BlxeSUGnARBCL9LN5h5i1y
         KujbrI8X7yDA9SZVa1n5hG42Zvh2ylHGapt2LT0fJHJYQ7xLvhgiHyUmeVp+uFd+pWoF
         yVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757987172; x=1758591972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPA1toQr5uAUN1v43j1zuAajDVGqxLAPWCvchR38lKM=;
        b=W4jtEYHwbsN7joD1aAO8Jd6elImxQ0UpGvwQ3GNES5Xw4NqYPmKDFvZKYDXxLxZbRV
         gTyqpsZj3RgQI+NkmXsnnCSldhJDap6TDn7JR95UgDy5rUNYUQ7VpRhZpNA4E0PsHH5e
         lPtSIKL+QKGhLeeekqLGM8KFgFA3FdIFvbRudiTRrafkD+i5yERq9bJ/k5jsSE7gyTqH
         oETWOUgOQvtpTX5U9RIcolENuJm+YBCE6ymkXJHeV3CRP+TkjDEwsGO0G6liukLyURGN
         6BECey6r2Ui2iq1vx0KjKC0ozCz+DZUN4StRXwgltRn5Go4Do1BeefVMHUJCG1+APA9K
         8i0Q==
X-Gm-Message-State: AOJu0YxtFvxxichDoco2XFBJEArZjAbb597cpHyoWOMtCruXB9zQOIjt
	XVd9h/MNVXsRcU/4AceYkm8Vw7QHohlxpAcXDYwFcVPaS4RYFmzOvBadBotcoQ==
X-Gm-Gg: ASbGncteY8T3vU5I/9iTxaMo6Mzl0UAZGJb6EfK1Q6TwkODIqh4hDXrCWa792iTbo/F
	5Iov/ld9sQJkqdqQvsKArVVPJeKOszBOu4X+WYHqWJU8fG5++8SMKfrEP/ED1H2+oaWUaLLWw9C
	PZ1q6jDcMb/npYjUA71M+Er042AO0G+crj6+HDzY6drBV3y7q5ocBqUYJJigcU/6uY53b9/Thjj
	T+M2DiVPZF2k9dZ7CJCliz1xABTVehFuDEt4rk+S4hD1wyULyoszcuH/8sOn5R9fKk644vCQeeq
	TOP/4yDrsZ4rmqBxWwPi2lKoLUDCHaZnAKNTmrtxD3vHFrr0516opzaYdgGViTwPeomnB+tfGIv
	vCvtof0OvRzfyQRCONegEbVVk8KCggwZmB16f9kwPuCxsa1QYcs+iMh6q2eLHyIU=
X-Google-Smtp-Source: AGHT+IER7qsmDirvUDqEQs1xBs7R9YKNdkm4YW+QWuf/8YIZY7n0KTnKwU0FcGZ00OJo4PN1/sUNaQ==
X-Received: by 2002:a05:6a20:2583:b0:24d:56d5:369e with SMTP id adf61e73a8af0-2602a593376mr19411514637.3.1757987171893;
        Mon, 15 Sep 2025 18:46:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36c78b5sm13253263a12.21.2025.09.15.18.46.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Sep 2025 18:46:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	hannes@cmpxchg.org
Subject: [PATCH slab] slab: Clarify comments regarding pfmemalloc and NUMA preferences
Date: Mon, 15 Sep 2025 18:46:09 -0700
Message-Id: <20250916014609.47273-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Clarify comments regarding pfmemalloc and NUMA preferences
when ___slab_alloc() operating in !allow_spin mode.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/slub.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 83983de948f3..c995f3bec69d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4456,9 +4456,17 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		/*
 		 * same as above but node_match() being false already
 		 * implies node != NUMA_NO_NODE.
-		 * Reentrant slub cannot take locks necessary to
-		 * deactivate_slab, hence ignore node preference.
-		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
+		 *
+		 * We don't strictly honor pfmemalloc and NUMA preferences
+		 * when !allow_spin because:
+		 *
+		 * 1. Most kmalloc() users allocate objects on the local node,
+		 *    so kmalloc_nolock() tries not to interfere with them by
+		 *    deactivating the cpu slab.
+		 *
+		 * 2. Deactivating due to NUMA or pfmemalloc mismatch may cause
+		 *    unnecessary slab allocations even when n->partial list
+		 *    is not empty.
 		 */
 		if (!node_isset(node, slab_nodes) ||
 		    !allow_spin) {
@@ -4547,11 +4555,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		slab = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, slab);
 
-		/*
-		 * Reentrant slub cannot take locks necessary for
-		 * __put_partials(), hence ignore node preference.
-		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
-		 */
 		if (likely(node_match(slab, node) &&
 			   pfmemalloc_match(slab, gfpflags)) ||
 		    !allow_spin) {
-- 
2.47.3


