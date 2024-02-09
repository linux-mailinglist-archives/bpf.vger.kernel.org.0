Return-Path: <bpf+bounces-21587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA884EF85
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764381C2415D
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8E85240;
	Fri,  9 Feb 2024 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCGWXxs2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29F522A
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451587; cv=none; b=P6IWXxj0gNqOXQ181OAvSVIyyqaYo5OYLXajVm1dikbsBRQgpAeMjiXLstU0dsdR+166D2bptfmP0Ql9JgYjY5Tj8j9IDzer+Pl3Of6O7f4qkGN8qS3yLekCwDAGkf5eCMKiOxmxu4Gt5d//fa+1OSVw+MewsGqLbFIbeeFXClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451587; c=relaxed/simple;
	bh=bn15qwkFZKFzLTANvXpovH96/FTFHgiCfZDyaSbMCuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFZssHo8YQjHUomfZZRyw+dVmEIM7qH8q1NbSQAu+Kf0z+usxlcZ07KBBHIZZT8uenZTNYxIqQ299IFQAF1KbZYURtdDn8B42fbgnKafEtctNuHMRAC3lP3f4qemFoF+u9DwVJ0Fj8D2ru8NOvWLj8V0LbTDMTenJnEPu9KLnVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCGWXxs2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d918008b99so4059255ad.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451585; x=1708056385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BMTbGEmBryFuIGcZHloqpvwHOH0k2D5DfDjYGSWlIg=;
        b=hCGWXxs2cCfVNZFHVuFASbNjOAPKwslabewmp4BFUffofxGy/HMdaC2gMsW8NKqr7N
         YruWAFigjm4T10ssgPKVC3scHJud5+2Xz7H+pWCHk5bHbalsYAzcqlTYUYd1h1BUjhMH
         KDenid94/l15VLOsOlKWSjQCir1gr9/uLXn2EFK2eaDkIM03I4BAuFqEKz3v3RAhwqnO
         epPoqIS0NhF00fa+ICSYo55fC30cJQEVfDs7WGJv80x/1ZDvfVrPLE5PYKRv3Y0X3fJ7
         7jbe8wB2dXl9V4q1X6g7tXntqKHxi7UitCGllyiUQp2yzQPlOkff1ZFzKOZCM28v8DDx
         1GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451585; x=1708056385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BMTbGEmBryFuIGcZHloqpvwHOH0k2D5DfDjYGSWlIg=;
        b=BX4IjEIZFEg/2cplDd67Q3biOzcT6A1Cjz8Vbmu5uSOtAI4vntK3mky/9civhWLQQU
         b6+D/cBCu4gNkSzgKH2DEI4TJ+l5dc2DxvYCfBPXIexBDR7Z89W1ab9Xt5f9bSwzYtG1
         1onRj25VeodZNJOVXo2n6/w2SykfbZXcf5fLxbdZAw59/GCg0WDzngQEx2Li7FeOcXid
         TmzYzCLJXu8iLRTAnNIRsA9RuaJZjPH5QCSufrV/EuOr9AA3UTLvIgatPxbG9AjmQKHt
         PTy0V+usJJO1PUaGcd6A2cfDiBlpQfnkIWDD8epvCONBZ3ySnZ2s4dJm0faLtFWjLZz5
         yVOA==
X-Gm-Message-State: AOJu0YzC/Xh7VE45K4PAX+9ei47Fw8/VzjfL1JAMpw8y5uVBPb5FZzqS
	TqmReNOxjVGyMluAvuq3+F/ANMXfR18xq/JJJzwg3mtfL8lnvqE7FuhPjk/Q
X-Google-Smtp-Source: AGHT+IF5Mfq/bPHfBQYoGGtl+p8BmK45T13+kVLjl6HOkUeWFmPC1hzclwCAAHXTr58YrlBe4W+2VA==
X-Received: by 2002:a17:903:40ca:b0:1d9:5f11:d018 with SMTP id t10-20020a17090340ca00b001d95f11d018mr520921pld.1.1707451585566;
        Thu, 08 Feb 2024 20:06:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+VQojeGmZnI/6ZKbMA4QjC6Z7cs8p2E3pelD8tmw/+rxHsyJp+sHxsISw306bbIwagnzXrqksuerDCdyJyzHnkQ8d3DIm2mi1k1zoOdJMP/wTNoNNR5ir3f4CT7VEYkubNEGmEnkgZRPf9eGmcjXs9cZMp9inOKRZV5yXU3IAzhgmqi2+d2s8sfmHKBYfLJ0cTlhfgPzGfXc6HritoDUz+EJpKOETMg/w/f5tKSmrToubP2DeHNnK+Nb6neWYKAOjYI7Nbtm4Q637JP9enCDVLsNvdrPpk40p+0X64NQlSkbO6KUf1lMsM+50n70zWLAH4TkyqwOFm/a4C0sXyAEf8d77rzbEMPOXScNRvVSW7DsnXrjq3Q==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id ki11-20020a170903068b00b001d937bc5602sm544378plb.227.2024.02.08.20.06.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:25 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 03/20] bpf: Plumb get_unmapped_area() callback into bpf_map_ops
Date: Thu,  8 Feb 2024 20:05:51 -0800
Message-Id: <20240209040608.98927-4-alexei.starovoitov@gmail.com>
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

Subsequent patches introduce bpf_arena that imposes special alignment
requirements on address selection.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  |  3 +++
 kernel/bpf/syscall.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1ebbee1d648e..8b0dcb66eb33 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -139,6 +139,9 @@ struct bpf_map_ops {
 	int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma);
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
+	unsigned long (*map_get_unmapped_area)(struct file *filep, unsigned long addr,
+					       unsigned long len, unsigned long pgoff,
+					       unsigned long flags);
 
 	/* Functions called by bpf_local_storage maps */
 	int (*map_local_storage_charge)(struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b2750b79ac80..8dd9814a0e14 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -937,6 +937,17 @@ static __poll_t bpf_map_poll(struct file *filp, struct poll_table_struct *pts)
 	return EPOLLERR;
 }
 
+static unsigned long bpf_get_unmapped_area(struct file *filp, unsigned long addr,
+					   unsigned long len, unsigned long pgoff,
+					   unsigned long flags)
+{
+	struct bpf_map *map = filp->private_data;
+
+	if (map->ops->map_get_unmapped_area)
+		return map->ops->map_get_unmapped_area(filp, addr, len, pgoff, flags);
+	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+}
+
 const struct file_operations bpf_map_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= bpf_map_show_fdinfo,
@@ -946,6 +957,7 @@ const struct file_operations bpf_map_fops = {
 	.write		= bpf_dummy_write,
 	.mmap		= bpf_map_mmap,
 	.poll		= bpf_map_poll,
+	.get_unmapped_area = bpf_get_unmapped_area,
 };
 
 int bpf_map_new_fd(struct bpf_map *map, int flags)
-- 
2.34.1


