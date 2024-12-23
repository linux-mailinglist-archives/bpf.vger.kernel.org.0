Return-Path: <bpf+bounces-47545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1D9FAE09
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 12:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92027A1466
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C61A724C;
	Mon, 23 Dec 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptC7lakb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370A191478;
	Mon, 23 Dec 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955145; cv=none; b=ucCE19/yOnVpXCE6Mdx/+HY60xnvYyEJbae6rPueoCIhs/rpGoprFkKWXi+WMX3PUhjrlT5vqvTP8Holv5u5AH6io6W5kCcNR7VdEYsCF4CBO3KeZB1+whzOkfdQh+8pE7hsYwP5gw5xkKtGwTm8T1UOUTXfSrFzEJC346BjVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955145; c=relaxed/simple;
	bh=y2QDvB1CAEAYO3eCYF/2r2y/YiemHjkDfxMnNlTl2Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgHYJhUkSVt/JsYLCNJkrbzN1BkGbKVPRYJOI2phE2InFBi85lzV3eh7rK+G+/ExUmKb9wAvuNqj1s2hYGCx++kr/O9DCnzC7UEt3DtyAWjwH8WJhbmtM0BguwpsiCNuBwTBj0b6s4WS0ZoyL50H43g0DmoT0FxXbN9lWFg/XrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptC7lakb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F76C4CED3;
	Mon, 23 Dec 2024 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734955144;
	bh=y2QDvB1CAEAYO3eCYF/2r2y/YiemHjkDfxMnNlTl2Ek=;
	h=From:To:Cc:Subject:Date:From;
	b=ptC7lakbW/MAj1SQVByaAXdHLEMEdKw6WO6NejknTKGBeJ+ZG61aXmjzKfETNocun
	 U3hGWkEc7B5QIWqGNKuoVJLI/qR/l24kChpNwhiOxYfOtlSI/AUDG0hSMHdRjjhleK
	 SGLy/a3zLk1zWBWCC4kh3OFwxxNYU97i3BAL5Lqow2S2jMb0ocegezjJfR0g41v/AF
	 3yxDs0O1R/raqXdQGaJ1FHUNTuHlYiPYv5VHQ11gsp0U+Jiak7A/xsQl6S27Cc9OVf
	 UX0Wml5FqT8oS2at6Kvy/61f6rs9Y32/jFFmTLBoXK8XlebeNlQnDL526nDnhIuoVv
	 N4n5WjB4turgQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] bpf: Remove unused MT_ENTRY define
Date: Mon, 23 Dec 2024 12:59:01 +0100
Message-ID: <20241223115901.14207-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The range tree introduction removed the need for maple tree usage
but missed removing the MT_ENTRY defined value that was used to
mark maple tree allocated entries.

Remove the MT_ENTRY define.

Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---

Found it while looking at range tree code to possibly reuse it for
another project.

 kernel/bpf/arena.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 945a5680f6a5..f5f6b00a982e 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -257,8 +257,6 @@ static void arena_vm_close(struct vm_area_struct *vma)
 	kfree(vml);
 }
 
-#define MT_ENTRY ((void *)&arena_map_ops) /* unused. has to be valid pointer */
-
 static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 {
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
-- 
2.47.0


