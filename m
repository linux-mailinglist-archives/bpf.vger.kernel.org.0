Return-Path: <bpf+bounces-59305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D9AC815D
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA761C04771
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F422F776;
	Thu, 29 May 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pNpNeaqA"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37F2D023
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538044; cv=none; b=ricK2jypCQNu5BGjfDzJOjBOaOptHcwSWiKg/e/b09cwvsdKbuVkQ14TmfQClGoZ47/9NZFzjuTlavRUUVA9m3N8Tv5M9ahopchhlCqkt62nA3TG4zqWOUzg/V4fH1Yh/xoyPpszaGHWBrR3k+zAWKhUaKOfFNMh9Kx7IHYwA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538044; c=relaxed/simple;
	bh=ftAe5S1eBobAmiDczo+Rhs7i2N623ddySoduRd79TKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IjEqeLHE05ruP71nbWEgFY4li8GyOQjqixsbfsINbJXYOR+a2W/LyTNK6d6xJ8UWyUvtnFC2lNukSu+Xw4VFqgovxa6Zu2U8Sd/d7XOY9GGHVj61/sxbw0dCEZfJps0WyRRwRILn3Fo6SaO0OGPjHWr6eKYYxGU4Ovl3WRgwZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pNpNeaqA; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748538037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nF4/5klNQRph936DO2AGV4d8MR28RC5kMXGHw5XVWBg=;
	b=pNpNeaqA+Ns1ESM3752Og0tIpBwWLItP8IUUPJTKfuRHXTehtWmWkj5QadGbFi7dqx0s7f
	3pxw2Ey41Ex6ecCEIpDXpH+0qWDl5WSvP2vz/gOaKMgehp4sDHDO+LNYhyQWBIF9PBYHFj
	ZreUd+qIE3i9x+SkgruEaOVF2PlmfLo=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	qmo@kernel.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next  1/3] bpf: Add cookie to raw_tp bpf_link_info
Date: Fri, 30 May 2025 00:57:57 +0800
Message-Id: <20250529165759.2536245-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

After commit 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint
(raw_tp, tp_btf) programs"), we can show the cookie in bpf_link_info
like kprobe etc.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/uapi/linux/bpf.h       | 1 +
 kernel/bpf/syscall.c           | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 07ee73cdf9..7d0ad5c2b6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6644,6 +6644,7 @@ struct bpf_link_info {
 		struct {
 			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
 			__u32 tp_name_len;     /* in/out: tp_name buffer len */
+			__u64 cookie;
 		} raw_tracepoint;
 		struct {
 			__u32 attach_type;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8..1c3dbe44ac 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3687,6 +3687,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 		return -EINVAL;
 
 	info->raw_tracepoint.tp_name_len = tp_len + 1;
+	info->raw_tracepoint.cookie = raw_tp_link->cookie;
 
 	if (!ubuf)
 		return 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 07ee73cdf9..7d0ad5c2b6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6644,6 +6644,7 @@ struct bpf_link_info {
 		struct {
 			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
 			__u32 tp_name_len;     /* in/out: tp_name buffer len */
+			__u64 cookie;
 		} raw_tracepoint;
 		struct {
 			__u32 attach_type;
-- 
2.43.0


