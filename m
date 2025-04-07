Return-Path: <bpf+bounces-55381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498BA7D2C2
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 05:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FC8188DC8E
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 03:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9338A221F18;
	Mon,  7 Apr 2025 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CHgVBwLN"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3E221F07
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743998311; cv=none; b=mmTDRAVIbaLU3kMKlj7rc5HFfVmFU21MElZETSmzQMbHTL279llfcjkYQTemFVkBhM/XNDSCR0ibw6fUz17qbsCfM/9K6OA74VlANGB9WUFyB7BmPoPkHCL84DI/6vEotXfjsEIkhwNjLT8J8fwgRmSdoYVM+ubE5BVX/3gmvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743998311; c=relaxed/simple;
	bh=BIlbZF3iV+QVpyMykufAeNj4wkuzozgFPne1hrPZnSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrUj63enviIgFwEOF27QcBDstGmpx7nPKyiSQ44KrWvjom0XPS7NCJWra5p/29vPiYeR+mMpYA/M0ZlkH2a63VLOUhkktD6A3oJMmFp4TIrkKCSxJKCZndN6fMuon+rtj+nTT9TpGGGseKFJ57XL4McwnykFz9V9V+fjVBp5D8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CHgVBwLN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743998307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9Ar0FtEi34Mw+74zltwC/KGO/CzF9ZVivgvMAlfxGQ=;
	b=CHgVBwLNlMR6r7Y6PxEBInONVSz9QcamkCq9i4rz6RZLoEepPPmJZh+NpsnLwd+U7wZlZV
	2lS0dwoW/OXOw+CB/UA5I+S46YkZCiaR31dvDs5MyYec/HZVB2+xX0s6lEUAt+mosWlU5D
	1v0/KIL6aBXNWh+zXylUdR+7nOIoXB8=
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
Subject: [PATCH bpf-next v2 2/2] bpf: Check link_create parameter for multi_uprobe
Date: Mon,  7 Apr 2025 11:57:52 +0800
Message-Id: <20250407035752.1108927-2-chen.dylane@linux.dev>
In-Reply-To: <20250407035752.1108927-1-chen.dylane@linux.dev>
References: <20250407035752.1108927-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The flags in link_create no used in multi_uprobe, return -EINVAL if
they assigned, keep it same as other link attach apis. And the target_fd
sometimes will be initialized -1 such as probe_uprobe_multi_link in libbpf,
so do not check it at the current stage suggested by jiri.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5cd0af80f..0f4085e8d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3387,6 +3387,13 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	/* no support for 32bit archs yet */
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
+	/*
+	 * The target_fd sometimes will be initialized -1 such as
+	 * probe_uprobe_multi_link in libbpf, so do not check it at the
+	 * current stage suggested by jiri.
+	 */
+	if (attr->link_create.flags)
+		return -EINVAL;
 
 	if (!is_uprobe_multi(prog))
 		return -EINVAL;
-- 
2.43.0


