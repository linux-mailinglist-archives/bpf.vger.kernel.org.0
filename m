Return-Path: <bpf+bounces-40992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90AF990CDC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17DD1C22951
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6E9220815;
	Fri,  4 Oct 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6ME5qsp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187D22168B;
	Fri,  4 Oct 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066308; cv=none; b=YDbsmtrrK0xyItoeszvS/LJkhTzkGNH4YbdfIxaCsgYpcCWLPTGVpcDAV4ts9GxB2iTBOSCXFjNDih3vs9ylsvxx757RpljcSt4y10m4ax0CmP8xNXk4OVuq8fuuXTTKupf0gbCWfvZ5uSi19QfyjZyHvdLlUTTfwYvEaYPmxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066308; c=relaxed/simple;
	bh=YGhJowkgtj2CP4dGZpTyvteGPvmXyB/f3dpcr3jOGzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQO13oBWCk4o8uQEKVDP46Z9H0DGFGBSYP52eMmb19CaiwxbwadYjvegkHWJjwpkvtO9GfuMzgRpkizKj9BvBT2m7xW8EiBNtYuch3UKDEUwtgNby8ub5BvyIdV7w4/iL1A5vUWTYgrWgnPQJxl58IYCkbYEr3K2GvADkHKecsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6ME5qsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D9AC4CEC6;
	Fri,  4 Oct 2024 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066307;
	bh=YGhJowkgtj2CP4dGZpTyvteGPvmXyB/f3dpcr3jOGzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6ME5qspzcKLn7lRO8dlUuKs5SiNr2vzcgRpJkfci7qvPDQyq8HTTUQcvIYos0jI7
	 T7Ysa1zAPL/IIQg4+IqA2I+lY0zgSds/SAh4iqFS2neFKROmxb+4BydSZItkZYUNh8
	 B7VpNm3d1Xw8LISHfwreTy8uDaXqeYJDYMX+uJQiFDskxWWtvrMlZVXWy6UdQaoCOC
	 hoLC8xQsXcanyfnxvWlpiQiBDezDoie9yI6UuBqvaegtUwS5UjRArBG8FtZi+pe+K0
	 IyP2/B/ECv3HH+5fz0U2/q6m0My/9un6cBHN5RAN6XkcLSkMGyd8ML+kWOKE7FCqMU
	 D7YTgsr6hMo+Q==
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
Subject: [PATCH AUTOSEL 6.6 02/58] bpf: Check percpu map value size first
Date: Fri,  4 Oct 2024 14:23:35 -0400
Message-ID: <20241004182503.3672477-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index c9843dde69081..1811efcfbd6e3 100644
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
index 85cd17ca38290..7c64ad4f3732b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -458,6 +458,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
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


