Return-Path: <bpf+bounces-55380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A7AA7D2C1
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 05:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BBE16AD8A
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 03:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1064221DBA;
	Mon,  7 Apr 2025 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="czGodIH4"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984622AF12
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 03:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743998307; cv=none; b=R2RvDicdF9TnDClxE7E88MpSCUiuOrUJ/VxCE4km05FeF3HioOP4VxxRoxgWnuRKH0dPmQM2SjV3FJ3P1EWHq+mrqMqdJqG0Tm7HZfCT+pP6lF3WCBdLqlINVHpryK+NvQ1Ac/NxexYOxRbJ36xoA99VKJM06QlHniIhNFtq0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743998307; c=relaxed/simple;
	bh=KHlz4rXnqQ+ecI/CPSK09l1Xo/uUS/AZmlEWjL33yxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VFHKybAsDRc5jAJE3Rx4Fyn2uZU5y41nf1FiUz+2JmDOz2rXB7uAJWfiMryCYvSAF0uR9SJS+0Rkma4FQvwsOAWR+NnmyhotN54sB5cITsI/ut14jsJVSQ6TtvS2efVGXhw/z7AlJXhxJhpYat7KCn8qqfNZhkingyAzhIL34+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=czGodIH4; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743998302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dsPS1ukzaRmmzRZaoJiWc+UdrLWIkrWTXCj5BDKYrtM=;
	b=czGodIH4P9ibT2cB4kOInm6jCe9DSn+W6ApATCSeTJUJiumLGtsJjqMZ9k3NXathJv0YFh
	z0PdHNU4m+cYTP7X4iQ8Fj4e2UtXvOvFTdXD9Y305xLCC8SGiTrlZNO0Y8uwwC/RvinoCT
	6+o7BPyczyS1DZ2GZc+VTgsTvsB+ASw=
From: Tao Chen <chen.dylane@linux.dev>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	laoar.shao@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 1/2] bpf: Check link_create parameter for multi_kprobe
Date: Mon,  7 Apr 2025 11:57:51 +0800
Message-Id: <20250407035752.1108927-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The flags in link_create no used in multi_kprobe, return -EINVAL if
they assigned, keep it same as other link attach apis. Perhaps due to
their usage habits, users may set the target_fd to -1. Therefore, no
check is carried out here, and it is kept consistent with the multi_uprobe.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

Change list:
- v1 -> v2:
    - remove target_fd check suggested by jiri.
- v1:
    https://lore.kernel.org/bpf/20250331094745.336010-1-chen.dylane@linux.dev/

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 13bef2462..5cd0af80f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2992,6 +2992,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	/* no support for 32bit archs yet */
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
+	/*
+	 * Perhaps due to their usage habits, users may set the target_fd to -1. Therefore,
+	 * no check is carried out here, and it is kept consistent with the multi_uprobe.
+	 */
+	if (attr->link_create.flags)
+		return -EINVAL;
 
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
-- 
2.43.0


