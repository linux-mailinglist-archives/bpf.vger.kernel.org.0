Return-Path: <bpf+bounces-41003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5268E990F02
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B55D28164C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7157D22EB4C;
	Fri,  4 Oct 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOD7V3bb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904A22EB41;
	Fri,  4 Oct 2024 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066713; cv=none; b=En+itzDhe8UqOPLmkHVXh6DBnpbfiMMRVk/48OfFwr0zy/7lUK5NdMdlMACJnEYBPbWOymfpimRUlKs85+ael6cQU6RFd8u10ceG/U3l08YuSPwX1Y3UhxeXyZVfvtl3Fxkws5r6XoEdk0JaacYVbVSjxlcyn/8EzcFay2vSbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066713; c=relaxed/simple;
	bh=Rr3AoRQwngiypIwfYwmhui+3i3zjNXnsVFugiXD9s80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEav7kgAExaxWvdRlDGxGiOJy/FgFPSHMapgKZbf6bOT1wb1n7iqkbvSKgV04zEBm0qpN+mXmvPfM2Z9kP1Axta6H2uZRQ9DzZ9Y0I/AN2u59vp0zxGMhRX3vU4/CxdfSSUH+LL0BqLcdmPg3cQpTCKmm9HVgFa4iuVJkjtek/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOD7V3bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760ECC4CEC6;
	Fri,  4 Oct 2024 18:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066712;
	bh=Rr3AoRQwngiypIwfYwmhui+3i3zjNXnsVFugiXD9s80=;
	h=From:To:Cc:Subject:Date:From;
	b=UOD7V3bbElwLRBmFI9se7iKJKdfAagtiCqHm9FDPTTJYy/UDsrj0qEZvZzjbxb4Vk
	 H5gkidoufSHFGH5kdIuvUqiPOQhvdZEgplvIu5ZZog8IAOGKJCBTzovdrjEheT5QLv
	 +Nixb2tBaloJW3bFAldliFyByMObY4NLRhzg3UjQMD88AQd4WbK+nCT9Lk/tBxX0Fr
	 KKTSknkKwvqQgPvSPjSXO57mHENphfVgP/wKCFuTpQGqHZlMCG7CHuNp6cBnfsjmuV
	 +y5FuwktwR0hPEQahD+kNctxq/4bqfpkHU8BtlhjwKm/bnvPmnhIwWsxm0lIvm/xm+
	 +Ui9h87IDBIvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tao Chen <chen.dylane@gmail.com>,
	Jinke Han <jinkehan@didiglobal.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/16] bpf: Check percpu map value size first
Date: Fri,  4 Oct 2024 14:31:28 -0400
Message-ID: <20241004183150.3676355-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
Content-Transfer-Encoding: 8bit

From: Tao Chen <chen.dylane@gmail.com>

[ Upstream commit 1d244784be6b01162b732a5a7d637dfc024c3203 ]

Percpu map is often used, but the map value size limit often ignored,
like issue: https://github.com/iovisor/bcc/issues/2519. Actually,
percpu map value size is bound by PCPU_MIN_UNIT_SIZE, so we
can check the value size whether it exceeds PCPU_MIN_UNIT_SIZE first,
like percpu map of local_storage. Maybe the error message seems clearer
compared with "cannot allocate memory".

Signed-off-by: Jinke Han <jinkehan@didiglobal.com>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240910144111.1464912-2-chen.dylane@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/arraymap.c | 3 +++
 kernel/bpf/hashtab.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 44f53c06629e2..03e244b11f5a0 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -71,6 +71,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 		 * access the elements.
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 16081d8384bfc..bca3287030460 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -291,6 +291,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 		 * kmalloc-able later in htab_map_update_elem()
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
-- 
2.43.0


