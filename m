Return-Path: <bpf+bounces-52328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4540EA41C45
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 12:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779257A7F6F
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CC125A2DD;
	Mon, 24 Feb 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUxBLeKh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8925A2C8;
	Mon, 24 Feb 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395804; cv=none; b=ShljNAqkDHNz0vCXpyyHUzlMXG1zjk1uuEoxx+NG93Kz/drzH8qHSLe8JwO1I9ft7xLj3pPq+xGKKKZlfGEZHWAnDVdAEGM8URlxWJ88h1c7/Y/qYZ1qXz6uLJv9TgaNtF+CfcF+T7fZ8DPeTw+qdrjHlY5eICzRxm1jPiR+oK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395804; c=relaxed/simple;
	bh=LlSWaAGYCaTlk36Xi8pt25xIFM4xhjUNlUS7X7eKqv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPM3cL2l0tFcHd2vaIZetDX0GA45UvcVocMompK9dzJDP673VCDIjCYHdCVfoSi0tf2Ws+m9R9zJ14D6id4gvehvmfok5YkIVAy0MgIwJq1HCapgaIdSJREtdtaOn9o09fcV90JBxHBGWTZ0I6eXJFunhrIWVHWGQP0a5JBi3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUxBLeKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D00FC4CED6;
	Mon, 24 Feb 2025 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395803;
	bh=LlSWaAGYCaTlk36Xi8pt25xIFM4xhjUNlUS7X7eKqv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUxBLeKhvh8zFbbKnqpXpc9vBgeDd0s2xdDs6OI1Y8hyNS5PysP9TNORXoWenar/d
	 EleI6aNWZ98FpGsGUjTU+6W6o+dP3EkidpSTnKNboHsRKeKuwTwsT/DSFgxflGLWzE
	 c8tZIU+zCK+qjdvf9C1/NdNUkqJ6jP1yF2+U4MCBXurkT/gvtR0htq+Bv6ytDYObPR
	 GJEYsvI/6h7mGDa10dptTQowBP0Iz2TvWVOZUJC3aELDsy1jPBTHPGoVbZOdWYloMh
	 K+fWuQnYwkrFi3eC/JrxU7FkaYr7PXxL/ztoJfJjCnQ40+IhZnZewGHz/Ce3FcKwGR
	 NDbvsUINdK2Yg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Jann Horn <jannh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 02/32] bpf: unify VM_WRITE vs VM_MAYWRITE use in BPF map mmaping logic
Date: Mon, 24 Feb 2025 06:16:08 -0500
Message-Id: <20250224111638.2212832-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 98671a0fd1f14e4a518ee06b19037c20014900eb ]

For all BPF maps we ensure that VM_MAYWRITE is cleared when
memory-mapping BPF map contents as initially read-only VMA. This is
because in some cases BPF verifier relies on the underlying data to not
be modified afterwards by user space, so once something is mapped
read-only, it shouldn't be re-mmap'ed as read-write.

As such, it's not necessary to check VM_MAYWRITE in bpf_map_mmap() and
map->ops->map_mmap() callbacks: VM_WRITE should be consistently set for
read-write mappings, and if VM_WRITE is not set, there is no way for
user space to upgrade read-only mapping to read-write one.

This patch cleans up this VM_WRITE vs VM_MAYWRITE handling within
bpf_map_mmap(), which is an entry point for any BPF map mmap()-ing
logic. We also drop unnecessary sanitization of VM_MAYWRITE in BPF
ringbuf's map_mmap() callback implementation, as it is already performed
by common code in bpf_map_mmap().

Note, though, that in bpf_map_mmap_{open,close}() callbacks we can't
drop VM_MAYWRITE use, because it's possible (and is outside of
subsystem's control) to have initially read-write memory mapping, which
is subsequently dropped to read-only by user space through mprotect().
In such case, from BPF verifier POV it's read-write data throughout the
lifetime of BPF map, and is counted as "active writer".

But its VMAs will start out as VM_WRITE|VM_MAYWRITE, then mprotect() can
change it to just VM_MAYWRITE (and no VM_WRITE), so when its finally
munmap()'ed and bpf_map_mmap_close() is called, vm_flags will be just
VM_MAYWRITE, but we still need to decrement active writer count with
bpf_map_write_active_dec() as it's still considered to be a read-write
mapping by the rest of BPF subsystem.

Similar reasoning applies to bpf_map_mmap_open(), which is called
whenever mmap(), munmap(), and/or mprotect() forces mm subsystem to
split original VMA into multiple discontiguous VMAs.

Memory-mapping handling is a bit tricky, yes.

Cc: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250129012246.1515826-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/ringbuf.c |  4 ----
 kernel/bpf/syscall.c | 10 ++++++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index e1cfe890e0be6..1499d8caa9a35 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -268,8 +268,6 @@ static int ringbuf_map_mmap_kern(struct bpf_map *map, struct vm_area_struct *vma
 		/* allow writable mapping for the consumer_pos only */
 		if (vma->vm_pgoff != 0 || vma->vm_end - vma->vm_start != PAGE_SIZE)
 			return -EPERM;
-	} else {
-		vm_flags_clear(vma, VM_MAYWRITE);
 	}
 	/* remap_vmalloc_range() checks size and offset constraints */
 	return remap_vmalloc_range(vma, rb_map->rb,
@@ -289,8 +287,6 @@ static int ringbuf_map_mmap_user(struct bpf_map *map, struct vm_area_struct *vma
 			 * position, and the ring buffer data itself.
 			 */
 			return -EPERM;
-	} else {
-		vm_flags_clear(vma, VM_MAYWRITE);
 	}
 	/* remap_vmalloc_range() checks size and offset constraints */
 	return remap_vmalloc_range(vma, rb_map->rb, vma->vm_pgoff + RINGBUF_PGOFF);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5684e8ce132d5..60417b79639e5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1061,15 +1061,21 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 	vma->vm_ops = &bpf_map_default_vmops;
 	vma->vm_private_data = map;
 	vm_flags_clear(vma, VM_MAYEXEC);
+	/* If mapping is read-only, then disallow potentially re-mapping with
+	 * PROT_WRITE by dropping VM_MAYWRITE flag. This VM_MAYWRITE clearing
+	 * means that as far as BPF map's memory-mapped VMAs are concerned,
+	 * VM_WRITE and VM_MAYWRITE and equivalent, if one of them is set,
+	 * both should be set, so we can forget about VM_MAYWRITE and always
+	 * check just VM_WRITE
+	 */
 	if (!(vma->vm_flags & VM_WRITE))
-		/* disallow re-mapping with PROT_WRITE */
 		vm_flags_clear(vma, VM_MAYWRITE);
 
 	err = map->ops->map_mmap(map, vma);
 	if (err)
 		goto out;
 
-	if (vma->vm_flags & VM_MAYWRITE)
+	if (vma->vm_flags & VM_WRITE)
 		bpf_map_write_active_inc(map);
 out:
 	mutex_unlock(&map->freeze_mutex);
-- 
2.39.5


