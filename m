Return-Path: <bpf+bounces-45420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DFE9D559E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8926C2850C6
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 22:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5F1DDC1F;
	Thu, 21 Nov 2024 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4rDrL6d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89B1DBB19
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229163; cv=none; b=npGGUuFB1K/bed+AgeCPwMqCpyQvQEO9sRfI727SXIM51viQpmZz+xjqucfFJS7trKFLAohqBA3Xi78W6X9cnf8ZEgF7rrB3ZAMDrfgFKH1ufPrO9q61hF0IrYybB3oUoVc1ANuWblxsHOLJsqTO4T5G9mo+bbKg8Pq+CDVsLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229163; c=relaxed/simple;
	bh=jYv6Zc78xqN8B8De71eoNEacAUWSUbDyzp7M/V4RFJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrD58m3j+cPvsKISGmtTwYPrF5Omhs/Zj0TFLDf83G54n7LCg+bflfL9kjIRavIcND8zv0xVmspyJoCG9vmPNjJa+nV1WYeQZ5Vnwv0b+n7F4tl6WxhzQd89jogOb21soHYOkCbgroUGbnNanJAgFz2umj3JyZHPfT9ZjTOSxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4rDrL6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5945EC4CECC;
	Thu, 21 Nov 2024 22:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732229161;
	bh=jYv6Zc78xqN8B8De71eoNEacAUWSUbDyzp7M/V4RFJU=;
	h=From:To:Cc:Subject:Date:From;
	b=S4rDrL6d0ZxdAgqnILYqdQuI3WX2GOxPGguurwMg1nMJ6aZPyHbgccZaUg9PDtVUz
	 Wcz1VevTPkzbkzxzGkhhUPqLDu4CLFOIF/trsi0EQHGmv24Iwi3XOSWmBfvb2LO3WX
	 2+yzRjaWiQS3FtzP5/utIge/kuZNXn71E72ZasFJ5yDqxM1QowQMF0nJBtfIo2lmHO
	 JBdq3cVfO7XUPUjHjCCu8gf6gosKdcuQzi67C0oDn7AEVQTIjdNRErPoPs4ylzlzBg
	 T5aY4ifLCqYuE2t0esjnF6woVvwIfgRXfuUQkJsThFMqzKzQvkZczsZiNslsVR6qMy
	 Vo7AvFpsmcfaA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: don't adjust USDT semaphore address if .stapsdt.base addr is missing
Date: Thu, 21 Nov 2024 14:45:58 -0800
Message-ID: <20241121224558.796110-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

USDT ELF note optionally can record an offset of .stapsdt.base, which is
used to make adjustments to USDT target attach address. Currently,
libbpf will do this address adjustment unconditionally if it finds
.stapsdt.base ELF section in target binary. But there is a corner case
where .stapsdt.base ELF section is present, but specific USDT note
doesn't reference it. In such case, libbpf will basically just add base
address and end up with absolutely incorrect USDT target address.

This adjustment has to be done only if both .stapsdt.sema section is
present and USDT note is recording a reference to it.

Fixes: 74cc6311cec9 ("libbpf: Add USDT notes parsing and resolution logic")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/usdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 5f085736c6c4..4e4a52742b01 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -661,7 +661,7 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 		 *   [0] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
 		 */
 		usdt_abs_ip = note.loc_addr;
-		if (base_addr)
+		if (base_addr && note.base_addr)
 			usdt_abs_ip += base_addr - note.base_addr;
 
 		/* When attaching uprobes (which is what USDTs basically are)
-- 
2.43.5


