Return-Path: <bpf+bounces-50011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F152A21607
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 02:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899CA165569
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D291187858;
	Wed, 29 Jan 2025 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvirOu6D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340D183CCA
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738113772; cv=none; b=f+48DPVI0qwfEA5JXnI13uBexIo27kyepgpv3rbMj99wHqlhSGS+n7ZEf8Jf3h+ro/ry1GMAqqGia3IkpgGEXtbsdqa0RAKEV4P5+eDcKxthz7DaeQxTCE5h8OHbeS5ptc8S2h2E2gAjCCqPzzSJ5Em+X7LfWSJrRJ/1nZM09xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738113772; c=relaxed/simple;
	bh=YFw/CP8ZCFxv8pLZkGBxjacWiclt/UvsHm6PlXotCck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWVBJHAgbbnhVEs92HkGV770AyqveyPKcaSVb309e2G9Nn7dYj+71ZCdU+DM+T/rknpMjtjwwLiOL9sxj1gd3fXjjimrVx+7LU8PRvNUsA4bo9ZYmYV1btzEwLeMRJ+OuKrSANe7hIzBbXTGfzeRThGAtPXGud4zxOLcFxDAhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvirOu6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C876EC4CED3;
	Wed, 29 Jan 2025 01:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738113772;
	bh=YFw/CP8ZCFxv8pLZkGBxjacWiclt/UvsHm6PlXotCck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LvirOu6D03GozhnHPLYz3D9u8NrRJb7blmxEAY3NuV+XMf/wU8Qq6KhfBudqGeq1v
	 ZYvdevd+YBxb7EGgya/yJhpTRz5UTyNJfCNEMnaWXyNYBKOSgE2IF815nJPvxFPU2O
	 yfNKikQhUP8ldnvtbW5QrPdcHY98+O4Qk0Ss/I9yx9GF8X9K0bPIhIU3AI7vgsNA73
	 m2H/o4Tb+ZmDYuuDT6pYzUYR8WGZZB7PtrBCFVsu5Tf+theWJy6+QiPeSfSFoaOQ4f
	 vTqHYX3gEgGlfAG4wgBGB/+lhUQ4SwIc1Y4vfeSZ6YowBZE9t2OLev9ANl6eRy46I4
	 qQnP8i2Z6yzXQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Jann Horn <jannh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
Subject: [PATCH v2 bpf-next 2/2] bpf: avoid holding freeze_mutex during mmap operation
Date: Tue, 28 Jan 2025 17:22:46 -0800
Message-ID: <20250129012246.1515826-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250129012246.1515826-1-andrii@kernel.org>
References: <20250129012246.1515826-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use map->freeze_mutex to prevent races between map_freeze() and
memory mapping BPF map contents with writable permissions. The way we
naively do this means we'll hold freeze_mutex for entire duration of all
the mm and VMA manipulations, which is completely unnecessary. This can
potentially also lead to deadlocks, as reported by syzbot in [0].

So, instead, hold freeze_mutex only during writeability checks, bump
(proactively) "write active" count for the map, unlock the mutex and
proceed with mmap logic. And only if something went wrong during mmap
logic, then undo that "write active" counter increment.

  [0] https://lore.kernel.org/bpf/678dcbc9.050a0220.303755.0066.GAE@google.com/

Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
Reported-by: syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9bec3dce421f..14d6e99459d3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1035,7 +1035,7 @@ static const struct vm_operations_struct bpf_map_default_vmops = {
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct bpf_map *map = filp->private_data;
-	int err;
+	int err = 0;
 
 	if (!map->ops->map_mmap || !IS_ERR_OR_NULL(map->record))
 		return -ENOTSUPP;
@@ -1059,7 +1059,12 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 			err = -EACCES;
 			goto out;
 		}
+		bpf_map_write_active_inc(map);
 	}
+out:
+	mutex_unlock(&map->freeze_mutex);
+	if (err)
+		return err;
 
 	/* set default open/close callbacks */
 	vma->vm_ops = &bpf_map_default_vmops;
@@ -1076,13 +1081,11 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 		vm_flags_clear(vma, VM_MAYWRITE);
 
 	err = map->ops->map_mmap(map, vma);
-	if (err)
-		goto out;
+	if (err) {
+		if (vma->vm_flags & VM_WRITE)
+			bpf_map_write_active_dec(map);
+	}
 
-	if (vma->vm_flags & VM_WRITE)
-		bpf_map_write_active_inc(map);
-out:
-	mutex_unlock(&map->freeze_mutex);
 	return err;
 }
 
-- 
2.43.5


