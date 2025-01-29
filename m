Return-Path: <bpf+bounces-50010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B6A21606
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 02:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE9A18871F9
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76771779B8;
	Wed, 29 Jan 2025 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riA7oMLX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AE54F8C
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738113769; cv=none; b=n5FtVXZj/sVJ3YR7jyAUCdKCg9h684HZ2GvOlCstpTYl04PV9YFkv6doMbOSETmnPb2dvfhFvGRT34HbAzVOUT49RDi2Wl2CmoMzeUkrT9zyEopmRf4OWcz4H7zI1DBmuoUpQvhvtOaLpBCuNZeOydlxoebf4IlNnuuhnQS3TYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738113769; c=relaxed/simple;
	bh=itbQ4Q5jCUJZaZ+d12+jhxntdnHyPlXIkx3W71JYGoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAUkp49SAaPizQbk4qGr12JKOM/xW5p5CHhH6jNN1KXqgrcAgk0JsNMJvF7EwISnDlwsukvxRX9xhqsqNz6V4jSAzaxwOLOa8ImNZV1tEaIkcSI5rH7/hSHOgvB5CpByn47u/i9qinHgMXQE5i/gdM7nmbj1b2zdp4ijdippfj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riA7oMLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E348C4CED3;
	Wed, 29 Jan 2025 01:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738113768;
	bh=itbQ4Q5jCUJZaZ+d12+jhxntdnHyPlXIkx3W71JYGoI=;
	h=From:To:Cc:Subject:Date:From;
	b=riA7oMLXjh83loJuI4tQXv3vvytWSOPper9/w92g7QDRWqDpT+mhecKhS1rslS3iC
	 CPj5idaiUrOm9Thu5LE00T1yie2kA9mT1H/BCwfmb1De8jUBvvpPv9hhbnjLfN0dnK
	 U1uPMiNz30ZE4xSUpnY8AThrLyXXtPsMLmM85QhYxe6Bujk6g27zXYbfzDJfi6XQ3c
	 65Kb4FfWUynHxzEtIf2bzhRezwF8RqpCuWN2TlwfSsk7f7gzVGre2P4tCtl8zh2Fbi
	 mu3rcGh3lKBd38rDU76Lc9caEp+4v2bD+rGH0rD6hDDwDJqJgh0DaGvpkKf5vx9tWM
	 EjdQqnRj14G+w==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Jann Horn <jannh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v2 bpf-next 1/2] bpf: unify VM_WRITE vs VM_MAYWRITE use in BPF map mmaping logic
Date: Tue, 28 Jan 2025 17:22:45 -0800
Message-ID: <20250129012246.1515826-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/bpf/ringbuf.c |  4 ----
 kernel/bpf/syscall.c | 10 ++++++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index e1cfe890e0be..1499d8caa9a3 100644
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
index 0daf098e3207..9bec3dce421f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1065,15 +1065,21 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
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
2.43.5


