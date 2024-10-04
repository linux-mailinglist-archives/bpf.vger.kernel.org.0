Return-Path: <bpf+bounces-40997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA4990D8A
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA8B1C21017
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827051ADFE9;
	Fri,  4 Oct 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtUXRX9/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1620CCF6;
	Fri,  4 Oct 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066441; cv=none; b=mvm9A0JzNWcPRbJ4CbyokuxtJ/SW138U6jwNw/dcxCvFks6cdYAYaGFkgBw+XCA4lAl40Bde7+3v70/6kypHubPCWhYLuxlcdXS9dCNLLuOyb/abfwI5P2Tt4DcBBcKGg8ROFNuB3eX6u9epEYMMCeIpmb/cJ42H1KeYwOhhppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066441; c=relaxed/simple;
	bh=rmXlFXvX2i0g7iDDOufjOW+wE0Y8IqrZd8O5QGgACSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1VMTQPZd83D2twZH5G1tzDXB4xiIJbiWWYwzyV8si1wyBXiFYt8cV2lkLdpoEWSKAixAPrsFSnYRvc2WNjNvfPSNXQVxhS3B9JWPmrxwwsNi/Zp0vYWEw211TJp8vvWzDYe/iadrzn9A7y8RU+sH53u0k8LoVHOZxwXxPPji9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtUXRX9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E44C4CEC6;
	Fri,  4 Oct 2024 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066440;
	bh=rmXlFXvX2i0g7iDDOufjOW+wE0Y8IqrZd8O5QGgACSs=;
	h=From:To:Cc:Subject:Date:From;
	b=RtUXRX9/Al14XlSX6UwNdb5N/bId2bVGu128NhUARWDh3JXwPbwN77VZWO8qbqzZW
	 YJq4fekNV6RtHnRXi4hDrq27KltLWFYV2XOctqYFXBakMQEPzU+LgiW4JtyigWDi7+
	 xzJZ64SvYkLufOW+sZKqHbLnrtFbO3iwNgWNbLw6+3OHr7Yrh3G9hpIUcp2PlB643I
	 hFq0xZO4+vywZ6nalDfrVqJPYKSybdSfHqgSo2KHpns6PWtglPyACEvQmX9dvOM6fE
	 7I8X9o2exmmb9BqtBRDPGCyhhIoVAc+vea7UbIQhlkdaQFc6KYag2LdE48HxonBwEj
	 ayHYllRqXk5og==
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
Subject: [PATCH AUTOSEL 6.1 01/42] bpf: Check percpu map value size first
Date: Fri,  4 Oct 2024 14:26:12 -0400
Message-ID: <20241004182718.3673735-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index c04e69f34e4d5..50b9bf57a4e3e 100644
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
index 0c74cc9012d5c..dae9ed02a75be 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -455,6 +455,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
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


