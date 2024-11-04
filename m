Return-Path: <bpf+bounces-43913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146D9BBC6B
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463A8282A0A
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA911C4A33;
	Mon,  4 Nov 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLD8ot17"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14D1C9EBF;
	Mon,  4 Nov 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742789; cv=none; b=s+DyyPt1KApAHe1XRD5OWpcEb/QxaYlZkJzWc2THNOey0aeFUTpgm1GfbaC535vf7SNkLfQlAJkEM5xGTSRUzDlP+iV5B2Y7PRQUPxyHDjR+pvms375wVMYj2Cj6PeuDDG0s2cKlYjwHtDmuxIcgLkvkV3tXDhcbMoQ/k7vvOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742789; c=relaxed/simple;
	bh=KQEqSw56QpMY+tU0npJBHNqknEbzOsbTrBlfS7wAUuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ednIFvdmG4n0Xe1XldA44qJwcwt1SX47hR3LUYdJTPPvCD6wPEADsn7JNwALXWzIgY6QVO2wmeJx1ZzhZ9jokyuvP0VPRkhoddA6KV6aOUYq3GAiQ/OwmHEB66rocoeVJjtjvOXD0re64XFPSshRxG9uDRZrdQJPUn3ElL8rsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLD8ot17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B388C4CECE;
	Mon,  4 Nov 2024 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730742788;
	bh=KQEqSw56QpMY+tU0npJBHNqknEbzOsbTrBlfS7wAUuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLD8ot17015udoeLae05V37MdRB1frEjAqt5xB9tLDcRqHugeLaeEWzYzcB4g1ZiL
	 bPHZUQxN7zgT4dgsJXplgsvAIDLroIi/7tBbmWiBJgCzURW7fgbXHORAltSE6JHg9x
	 7it6n0D+sI14nKJwRHGUA0kwEoUqauOkZTOBBZN7Wsh5012jVngb+Ecxm7reRdkUi1
	 ikHwJcmeTf/8mR4j7RdJ951Fw/cb5lBi9iC9nipq0jTWqjHJtnxv+cYBLmBgKGfoDC
	 I83Q5YxonFSefUv8f69W2nLhXyZzwUIGTB1wmxeBc3CS+aqa2DJjjJIReQUw/PC6Fv
	 cu/QurP715w8Q==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH stable 5.15] lib/buildid: Fix build ID parsing logic
Date: Mon,  4 Nov 2024 18:52:53 +0100
Message-ID: <20241104175256.2327164-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104175256.2327164-1-jolsa@kernel.org>
References: <20241104175256.2327164-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parse_build_id_buf does not account Elf32_Nhdr header size
when getting the build id data pointer and returns wrong build
id data as result.

This is problem only stable trees that merged 8fa2b6817a95 fix,
the upstream build id code was refactored and returns proper
build id.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 8fa2b6817a95 ("lib/buildid: harden build ID parsing logic")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 lib/buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e41fb0ee405f..cc5da016b235 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -40,7 +40,7 @@ static int parse_build_id_buf(unsigned char *build_id,
 		    name_sz == note_name_sz &&
 		    memcmp(nhdr + 1, note_name, note_name_sz) == 0 &&
 		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
-			data = note_start + note_off + ALIGN(note_name_sz, 4);
+			data = note_start + note_off + sizeof(Elf32_Nhdr) + ALIGN(note_name_sz, 4);
 			memcpy(build_id, data, desc_sz);
 			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
 			if (size)
-- 
2.47.0


