Return-Path: <bpf+bounces-68465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D54B58BCC
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 04:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403C3175B9D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 02:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992D22309B2;
	Tue, 16 Sep 2025 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLGXkptj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F151D54FA
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989306; cv=none; b=Ujy/zzFNmm9Lis5UE9K9pKTiJulLQKfYmWRITLQtZHtRlBViJ7+uyRmMdw5IdDBMr9ZCjr/tvoT0kcK1KUQbavfZ3/ZLVFJfyvf+GPA2gBOgeZodTclTKozhVutOlQhD8zVEK8VxTOeLjkzqWQ2WW14/ewLKaBxYT1S+JmRBolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989306; c=relaxed/simple;
	bh=4z8nUdzzxiTcMnLWJYmkeo+/fiRjUXV5ARK68QNvWRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E5PE+NY/icwsxokBrZnvmjZ/rJ4TVDhfJUw9Hnb6a9n2fcEizHKroK/5MM+FdVlOnjjtXgjtzLQAeelgAc1dM9zIo5+WjoH6wr24lwLf13Qug0CTorNeTuFgYFc4MAqpIztkHBK3bmTRg5WpMjimYDl+QrV6wZNI0/r2/dEh5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLGXkptj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-772301f8a4cso6229990b3a.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 19:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757989304; x=1758594104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xX3fr/WuQNiabPxcBLd8/BQm5Vptb58LpB7WQPRtiGI=;
        b=eLGXkptjqIsQVtH4Y2DlX+sNIh4Ymumd8G6JKx3nF4pyuGrEoVSff+dDaMvVqFBgvn
         R/qlihsug7jI3EGfVndN44KfwBH4U3PS2Vzb1MEVguYQ8qIdkMNTCotd39U8ET2biS7q
         YI2mUprQoiD+XMpB+K9AcsUjL1fQufZ3lqk1+rmP8VNRBoZlZQR6q9vClUGZ62NRoOJo
         F6887MzkwniaKpSe2R5bej9IphElEyUJ+mqAospXHylZ3ZVDiXHcm+n7311oom5DuRDD
         ToAd4McGwWNtDRUTantyONFOveFEnFC8WTNjRG9JhU0FhvvfWiUz1bFKcOVArxzj2gdR
         rZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757989304; x=1758594104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xX3fr/WuQNiabPxcBLd8/BQm5Vptb58LpB7WQPRtiGI=;
        b=cFnwNzFKN37h/GdTh9OVeuanFLDrimBASlzw69xYXYTbszHu6+iiLZTQWjm2RpBIEM
         y4x+aUDnph8LOCvhNZjTBJ5Y4oqDWacHOZKOFk17h4f0XL4BTRdE3MebXry55/qhev8C
         4agBWCWAmo1SR5yL5QZbiSlG36fZ4rNa6990ft9nvihbmGMg7VqzcuTvjJNACSgWao/q
         NZvaBXpLGMHRe7pXWtZzHWBlJzLGiR58lu0bnj6ght3CZHA8lVOcfdrG0CubA2LULOQF
         BwU/Iz1oCnOirIARLaUhwYqvKg0dWlsv+j4sBaACATCIaUP8erN8/Miu5oKfV6Yj8ko4
         S6Dg==
X-Gm-Message-State: AOJu0YxhkTELh+Q3enSdR+H2J/KPHtoR/taE/E8quxR7tIPUHYJ5CpvQ
	vugCWeSlm2MBiG9M98YX+zFqntBEVN90Acn2svFC6tYmVluPkBvDPVRzZ25oqA==
X-Gm-Gg: ASbGncupjtibW7TDw+f3Ejjc3ppju6hAcs+E+kSC7el84KzFUZBgXt2LDvRltlpQHA1
	FMRzpU/xC1FAv9i08yOt2oEn9s1QJE7yXO/SfaSgkOyDVtjHYep+bNRkxoXs0923ImtIZ/zP5V4
	0JkvK9/2YvPjXIIHg1vzynp/NvFuXEhjTZxXLIA/ovUvPQfNhN+Xp1SQjNiTcbZ9eeiB2ukxgJ/
	o7OOSEXWqFsIclNpWF/1ViMOxIbEtLWz8zFz1sCVT8lGuQG00Ai5jEBMTyESIElqnJF779qCStn
	N4OdnHz20SflbodKehaljwlpG/kO6e5oJ6/nAKNIjS0nLS3QCIQFGAT/C5X39Qqmpqxhq4T/foc
	UqqYysv3wxxz53s1xizPcFtTYf90aAPkaS6cKMK64r7LLegs7X2cXgOVKFx/Tn7g=
X-Google-Smtp-Source: AGHT+IFl+gbjr4gFVXeMzo3rGVhrYRIL/xECJJeVCPQ0DdA1aYJEJmoCpFjso/oSl6iVCXG5g9ZOnQ==
X-Received: by 2002:a05:6a00:180b:b0:776:4eba:de33 with SMTP id d2e1a72fcca58-7764ebae064mr12607469b3a.14.1757989303734;
        Mon, 15 Sep 2025 19:21:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47601sm14429232b3a.28.2025.09.15.19.21.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Sep 2025 19:21:43 -0700 (PDT)
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
Subject: [PATCH slab] slab: Disallow kprobes in ___slab_alloc()
Date: Mon, 15 Sep 2025 19:21:40 -0700
Message-Id: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Disallow kprobes in ___slab_alloc() to prevent reentrance:
kmalloc() -> ___slab_alloc() -> local_lock_irqsave() ->
kprobe -> bpf -> kmalloc_nolock().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index c995f3bec69d..922d47b10c2f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -45,7 +45,7 @@
 #include <kunit/test-bug.h>
 #include <linux/sort.h>
 #include <linux/irq_work.h>
-
+#include <linux/kprobes.h>
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
 
@@ -4697,6 +4697,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	goto load_freelist;
 }
+NOKPROBE_SYMBOL(___slab_alloc);
 
 /*
  * A wrapper for ___slab_alloc() for contexts where preemption is not yet
-- 
2.47.3


