Return-Path: <bpf+bounces-40978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA29990AE9
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF0281A00
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744BB1E2835;
	Fri,  4 Oct 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRZEExbX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85751E2821;
	Fri,  4 Oct 2024 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065917; cv=none; b=EA8NwbBwhxZa62vMDONJiUuLd3WcZBZEJKa5WULVwf6IzZcyi9nITaY4h/pWWEM4dlcOCcec1MYczphRMV93mmm99uS0YfcDCuXw6N67jBoeJOPy96Me70XOr6437PZV5ukEVUeVq39jS8qOB4obrfNjROfw3S2WgnonDRCbO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065917; c=relaxed/simple;
	bh=2dcUHEIvHPbVZga8LmuLs8DePeOpAodEcPC+MLiJ/5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F68Cj8zi5llamtLAqkKGjdo2bCFE/PdYPr9207nsKMg/AdLQWimIova5s8wPS1T2UBevL2Lg3zxc1dee5j4dtF7qFg1ODWrpngpBnmfT1vpkYszyhP5T1g5AXLKLKdkpyjolbjzPtK7HeyYMl4UKFgBTKjZaxe1y+wGTFhnyvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRZEExbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD67CC4CED0;
	Fri,  4 Oct 2024 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065916;
	bh=2dcUHEIvHPbVZga8LmuLs8DePeOpAodEcPC+MLiJ/5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRZEExbXEfOGacJ1TDK7lTDHJPMIGP7PbEveoy1os7qiZakFARSKrDXxA5m4JkfUm
	 C8P332736TeXLndzqhSGQNYZlJMArmfVrJfjYz/gKU8jbajb3brbpYYI9ALNX2ZICj
	 koOY6YvI7UvceDzgg1MYDDL9HSJENQeCPzdWLNNxsiDKTR5xzYQKxjtVD8G3S+XWOw
	 f7yqyvs7dUBvL/dB9jRzAkY+iGhtXrVF5pTzHc9rrYzG1fLj70sD8IhB+6fjU0IAme
	 Zj7Pix30S5Qtwvy982ejF0GAyCASkWQBTTQJEV5sxnkYY2siHFgaq5A9rYrv2N97FE
	 MJBpdBE5BZb4w==
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
Subject: [PATCH AUTOSEL 6.11 04/76] bpf: Check percpu map value size first
Date: Fri,  4 Oct 2024 14:16:21 -0400
Message-ID: <20241004181828.3669209-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index feabc01938525..a5c6f8aa49015 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -73,6 +73,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 	/* avoid overflow on round_up(map->value_size) */
 	if (attr->value_size > INT_MAX)
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 06115f8728e89..bcb74ac880cb5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -462,6 +462,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
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


