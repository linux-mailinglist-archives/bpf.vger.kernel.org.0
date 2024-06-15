Return-Path: <bpf+bounces-32233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA23A90998C
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 20:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EDD1C20EBC
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06EC52F6D;
	Sat, 15 Jun 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu4XlaYD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D63EA72
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718475582; cv=none; b=HG4mDJfFhQs5utqPa5CoPcccwVtmdPMXh7NhruoAjyQRWjgAHqrvifHasvjtXrFNxw663l036lCbQJoIt/xzO6Z5GgPIhPx1At/kHtmG+AU1coSIWeL1baoOAGqbjRifSCF/FVRz3MY1H2GEwuMKHQXZdRM2+AizU0YM0iYqRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718475582; c=relaxed/simple;
	bh=wFOUVdx1pCB3iom2SaT7T4wCcr4aqxoiczWM0H85/jY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6i14LAOQTylou7ofrgwzah/VFJjAfkDwa05c8YM1jrNgx1K098SSYPX4aCC2dVFGIMh5tLctyncDXnoAWepopzdt4Sz7WcnXWgm26TEVpBE9vexuY52dUYfYtoB50jqeXCzJA8QaN3/+BL5bTKrjjm9VJJASl1pib1uAkl5Fzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu4XlaYD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c31144881eso2663207a91.1
        for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718475579; x=1719080379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWpAk33PWd5HFXGMgvwLTOZBIsbCgp+2E+b3xU1uTFY=;
        b=Mu4XlaYDJVkgz+Bay+TpGhAzqIuP/q4D3TGyowsi/5rFQSs/OXIICcA0/yH5LEmhEf
         lyWK9uq0rYrdjhf9GAb1DgYaH8eeQIid8EGAMVvA1psBG03WyUh6SR5oXjKGN6nSXJn0
         qJHNFgEHGtyQ7Ca7Ro3L9Pg7hX/PYhKJIwx34XvvDk/si2huISvcZAGGtyfGZrw71mQl
         bdCuqpTXdP47wTGzPtV/imarPlMl19s7dJ1JjKQHaQMobKsNXWOn+rLRTGkGnxUPgQ4m
         pqeJ1lk4PHdRmILHCyMYqdMpnLT59o0k1Zq3zEyc3CorkN+EckSvtp72kTMQmWPloif6
         +C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718475579; x=1719080379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWpAk33PWd5HFXGMgvwLTOZBIsbCgp+2E+b3xU1uTFY=;
        b=JN2Z1FUjPBz/xNKb8AmjrxoyRjMnXCGmfiBEHUSBPfhVAsVODuKaDmboz35uo5PmhH
         MAgS/jAiE8XiE/rHaxFayHCettUJkPI5XRCZTHGyvmx04Er2XqBYwxeThtFUDxvCBPLs
         Hcdnp8DIsLoyJl12fE3n5XQRd7DsJely+1zCuLw47dqAGRuIes8mLB4Rso1arPMTbg1J
         lKsVRUhESThRX3WBluZLM4WGjXpQoCiQqvzIYGigfU5E1fCgisxkcoaUr3Wr8mS+U8OB
         4T2U/J86FS4gl1Jqs23hXE49M6/ZgrmjpynYRTdfz4QkZ4jvOIueF68J59ZUqGkCfpFr
         F3Rg==
X-Gm-Message-State: AOJu0YyG+6dLxeeJ7eIQPE2W4Vw1jEVAZTAsGDeKmPXicyz5D1RQubAI
	Gu/ChqWxkzp5FHlcbJooTBm3/uNgnsz/NTGEHRkiIqnw/62aKXyVgv330w==
X-Google-Smtp-Source: AGHT+IHQMxnXdsAEJt9jNunZnb6cWCVm/mODvfhhaY1V8/sVXaYgL93AtmL5wSfGl44gSEl4oFVBBA==
X-Received: by 2002:a17:902:ecc3:b0:1f7:1a9:bf0c with SMTP id d9443c01a7336-1f8629ff2c7mr68364595ad.52.1718475579236;
        Sat, 15 Jun 2024 11:19:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e56199sm52850655ad.6.2024.06.15.11.19.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Jun 2024 11:19:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	pengfei.xu@intel.com,
	kernel-team@fb.com
Subject: [PATCH bpf] bpf: Fix remap of arena.
Date: Sat, 15 Jun 2024 11:19:35 -0700
Message-Id: <20240615181935.76049-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The bpf arena logic didn't account for mremap operation. Add a refcnt for
multiple mmap events to prevent use-after-free in arena_vm_close.

Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Closes: https://lore.kernel.org/bpf/Zmuw29IhgyPNKnIM@xpf.sh.intel.com/
Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 583ee4fe48ef..f31fcaf7ee8e 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -48,6 +48,7 @@ struct bpf_arena {
 	struct maple_tree mt;
 	struct list_head vma_list;
 	struct mutex lock;
+	atomic_t mmap_count;
 };
 
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
@@ -227,12 +228,22 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 	return 0;
 }
 
+static void arena_vm_open(struct vm_area_struct *vma)
+{
+	struct bpf_map *map = vma->vm_file->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	atomic_inc(&arena->mmap_count);
+}
+
 static void arena_vm_close(struct vm_area_struct *vma)
 {
 	struct bpf_map *map = vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct vma_list *vml;
 
+	if (!atomic_dec_and_test(&arena->mmap_count))
+		return;
 	guard(mutex)(&arena->lock);
 	vml = vma->vm_private_data;
 	list_del(&vml->head);
@@ -287,6 +298,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 }
 
 static const struct vm_operations_struct arena_vm_ops = {
+	.open		= arena_vm_open,
 	.close		= arena_vm_close,
 	.fault          = arena_vm_fault,
 };
@@ -361,6 +373,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 	 */
 	vm_flags_set(vma, VM_DONTEXPAND);
 	vma->vm_ops = &arena_vm_ops;
+	atomic_set(&arena->mmap_count, 1);
 	return 0;
 }
 
-- 
2.43.0


