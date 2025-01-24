Return-Path: <bpf+bounces-49706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57A0A1BD0D
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 20:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6533A378B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDB22248BF;
	Fri, 24 Jan 2025 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muZTTf1K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F314A630
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748565; cv=none; b=SwpLKLwNSSQRYA0t3Ys11/K80Mb9PF3F1ZKK9w7hXHHAEEg0FytaSrgI/S+Twid1I5LyFOKp20fEupWaf7Vd5A1fIvO8SV5iK/L5qaFuI0VRkcq/BJv3p+Ij256OiojJOblW3yD04AXr06kMyXiT8rC4tXOQeH5D7d4wq/1nnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748565; c=relaxed/simple;
	bh=8d6c8k45v44p1eYyeLf5XkFvPszIh5Uqun7ZTEHwJAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRxzstiHpNcAtI+xDm3W6CS2SY2QmPo0BuAnjyZGW7f45r/RY3f+C7PdkyhQVYsdKmXn4aTMgl60KwKG/dQdJVdjJo5zX6PXD9xo9+hNA+6tmupNx6L+Nf+zJjeD3AezMAM0TT9qg7+nCL0e0ia2O54HZ3GF61/TC8nPc0wlk6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muZTTf1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C17C4CED2;
	Fri, 24 Jan 2025 19:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748564;
	bh=8d6c8k45v44p1eYyeLf5XkFvPszIh5Uqun7ZTEHwJAs=;
	h=From:To:Cc:Subject:Date:From;
	b=muZTTf1K8aFmy9ED/NL66MCd4kn0ktUuXmSTM/+x38mYf6LUFFN2TzBa2yK1ePp2B
	 1aBSmhPZqrfxrQSinKWdorJwf0qA5+bh4LEuB0u76OsCrvykdbzF1szHIbY1MJskqp
	 G22TFOdNt7WcyRcIqK5gnD1xAUAiU/Y1Yal1o80umahUzbL/12uHDkOrp7lMnf81OQ
	 TC8yGMb4lFGO7EwHdPcRca/GBPMyuRw5aSnmrdspeoGqdTpwzoPT+Zo5JHVud7vgR0
	 sqEma2TP5q5OBZF0E21HEcwyHUAlW7utXJCfQSnNSNDgp/hl1NsRJBCY7SKZt/ce5V
	 m9VBW+gKAtaww==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
Subject: [PATCH bpf-next] bpf: avoid holding freeze_mutex during mmap operation
Date: Fri, 24 Jan 2025 11:56:00 -0800
Message-ID: <20250124195600.3220170-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
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

Note, instead of checking VM_MAYWRITE we check VM_WRITE before and after
mmaping, because we also have a logic that unsets VM_MAYWRITE
forcefully, if VM_WRITE is not set. So VM_MAYWRITE could be set early on
for read-only mmaping, but it won't be afterwards. VM_WRITE is
a consistent way to detect writable mmaping in our implementation.

  [0] https://lore.kernel.org/bpf/678dcbc9.050a0220.303755.0066.GAE@google.com/

Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
Reported-by: syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0daf098e3207..0d5b39e99770 100644
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
@@ -1070,13 +1075,14 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 		vm_flags_clear(vma, VM_MAYWRITE);
 
 	err = map->ops->map_mmap(map, vma);
-	if (err)
-		goto out;
+	if (err) {
+		if (vma->vm_flags & VM_WRITE) {
+			mutex_lock(&map->freeze_mutex);
+			bpf_map_write_active_dec(map);
+			mutex_unlock(&map->freeze_mutex);
+		}
+	}
 
-	if (vma->vm_flags & VM_MAYWRITE)
-		bpf_map_write_active_inc(map);
-out:
-	mutex_unlock(&map->freeze_mutex);
 	return err;
 }
 
-- 
2.43.5


