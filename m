Return-Path: <bpf+bounces-41001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0288990E65
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773CB2838D8
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6CA2256C8;
	Fri,  4 Oct 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEwknbi6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5B1DF25A;
	Fri,  4 Oct 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066608; cv=none; b=AsX00zByIHPuHvqWM7d9KLRCVh5ANUcn8GJX/rqF+mlaNIAXNQv8t+1ndHxIKW0WMiOzqO9ae779y2H2vKkNvGM2C35cddm4fCoNiJ++kdzC8ziX74zVfat2SsIjHIUpMssAfXaYl43dRMMSLb6P61YvfBGQ17gZne+w+qQC92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066608; c=relaxed/simple;
	bh=+KaJrIRtLYyTg1NyKVAJTDMq3P9Oib12WipD/KF9iSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0s1GDZFo5M+/o1Tw93uZWgx50kHm66WKxXEk2K35DAhaN28YI8HrmrVfTShNGGoXbeWJNEa1Nyemihn7j7hjZ6I/gtxwtkIVs1ZvOb/pJ4WcbOPxJfz5rbFoHyboGGWs7UhP2EsuNfkfbTbpGH+6PxxJND7TR7Y0u0SqWPTALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEwknbi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D2FC4CEC6;
	Fri,  4 Oct 2024 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066608;
	bh=+KaJrIRtLYyTg1NyKVAJTDMq3P9Oib12WipD/KF9iSg=;
	h=From:To:Cc:Subject:Date:From;
	b=jEwknbi60kddwXGyEyqUhUs3DjDNRB7fhd3ia6beW6VvTYD8brq5mR7QBJOOg4QMb
	 xx4Tpw66Y9WmR9mygwR6Q/IDAcfI35HSroTouC/vbqwjpqZBcIPeiF1ZbdSxMHR11i
	 B5sNN9JsNA6lPnn1OSSDYqtym4YdTnIdqSXcB7EB5XTgiH8m12GNMkSAYnDhFYH4v4
	 GoS/B0VwtQHuYg0M4AckloEUD1J/ozI2zjMfUgzbROp8j59hzoU5Kn9a41uDBXZOUF
	 OU7Ocidx3fRm1L5azItU13u+fyxZOVyDg87QfO2J6cLpmcjouqCxS4/YuliTO+tpQy
	 cBMY3+LhIOjyQ==
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
Subject: [PATCH AUTOSEL 5.10 01/26] bpf: Check percpu map value size first
Date: Fri,  4 Oct 2024 14:29:27 -0400
Message-ID: <20241004183005.3675332-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 5102338129d5f..3d92e42c3895a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -74,6 +74,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 		 * access the elements.
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 72bc5f5752543..4c7cab79d90e5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -404,6 +404,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
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


