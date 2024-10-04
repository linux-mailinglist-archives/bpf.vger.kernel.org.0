Return-Path: <bpf+bounces-41002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60520990EBF
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234FA2829FE
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C0F22AD13;
	Fri,  4 Oct 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClZpxn7B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851822AD08;
	Fri,  4 Oct 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066667; cv=none; b=of8u2HHlnrS5n6ugek7NX1LOPuf6EUk4t6TU1WhfqM8fE906YWI4BjDikYSDoWTrJaF54ZuLTgEjCMcpU/LSsX2uWn/OFumjCE+VULRJh65D45yia/Npr/D4i4dU7c4cJcSImUnfVhs1x34d61sOFRBRwP5Cc7ayTkMFHa7Yhws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066667; c=relaxed/simple;
	bh=2GiZ3O48rveT/hHn+zcXPzbx0SldDS0Y/LX2/NzGneU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpgLcqLS6bscMKOTDwUd6SYdoYRzSwuy+PCK73q6QIKTOnXvAMfavUik17Lqiir7jzyn+MtK5RQSqoMEjXf+oNP/mFmbPEe4X1QOLzZUm8EHh+wzHAjJc+vGRgaW5IrcYI7FkEKMOs9f/frWBdefT/e1hSGu3Tvm2HlnM6TIkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClZpxn7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A70C4CEC6;
	Fri,  4 Oct 2024 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066667;
	bh=2GiZ3O48rveT/hHn+zcXPzbx0SldDS0Y/LX2/NzGneU=;
	h=From:To:Cc:Subject:Date:From;
	b=ClZpxn7B7juoa+F+8gHiyEMYk+iAEB0PV66I+8KwEFK0JpEGOTwRcdlgVKFfj7hpP
	 rIrYL7wXVEns3NFZIf9w4x3SWeCGSpcE5NTb7Lbwk40jYIUOJ4oOjRJHkCH6tePFWX
	 rdyde6m+V6c8Rx2k6H9+2L0sT5Dq+E/+2JxnJntdCxRTegdf7V796Bw090y8cvaxzC
	 EaMhf5dLF7LXaTUfEtATAgNAzlbm6lXojy1McVNS8ogcVOaOhU6xYhhyy7YbMRvhRC
	 opy1zcT6AVAE2ug2xkkRTD77Pvczvkdqb+xjOMNhxAv5NfjaQ57sLIYwYKoQmlsLA2
	 H9U9ENmgluFrw==
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
Subject: [PATCH AUTOSEL 5.4 01/21] bpf: Check percpu map value size first
Date: Fri,  4 Oct 2024 14:30:36 -0400
Message-ID: <20241004183105.3675901-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 81ed9b79f4019..af90c4498e80e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -64,6 +64,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 		 * access the elements.
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 34c4f709b1ede..0d14a2a11463a 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -288,6 +288,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
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


