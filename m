Return-Path: <bpf+bounces-30824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC688D2D9D
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 08:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFFE289F3B
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 06:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F261607A0;
	Wed, 29 May 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF9i2rk5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF924273DC;
	Wed, 29 May 2024 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965593; cv=none; b=BKAf0gTK+DQrDbP6FxaJ17FLbc9KsuoOQnF/FhNXt+cNHlw+5FAkWUbuHKBLBOFlno4s91YysTp481Aaqgk5ekoxv082vg8Xh2AMy/XfhXI34FiX8T3wrpiRwRya+MYdO15cZ/hOlMP5G4QNKKR2t/DsCDx/LWvZo3qsz4FMr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965593; c=relaxed/simple;
	bh=xbZlbav7dXHrx2F3xU5CD97U7cRldlN43gsuFjbcUtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thn45sWY+0FVUb/JBYwi8AyJsvn91dW5vFRvvHZDB846FeM/DdnE+sPdsoGsVaYGXU60Xp6g16ngs/px4kIZhYnNfG0YwSgFjB3HtMplTgk//4Bzgp77Up2rOakvKKCsPYC6O60bqfSf1nziLLLT7JRp4njckq1vBRZsE0qjbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF9i2rk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD57C2BD10;
	Wed, 29 May 2024 06:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716965592;
	bh=xbZlbav7dXHrx2F3xU5CD97U7cRldlN43gsuFjbcUtY=;
	h=From:To:Cc:Subject:Date:From;
	b=WF9i2rk5u5QpRo4zY2eI4DMJ+pgmfzFs74eUgo/KWWndVfkd3Kv7X2FMvG0SwuJiN
	 jtROgPPFpzG2ONLOefi49R3xMrRaR0ILp1ev9q7yc7i/M4wvbERDp3OeTdAps0wmyp
	 qzPzinWyFZ2ycPJxIk6AOH9gzlQYu3Fme+58v3ROPQefH/erz0BjnKxI8mmIs6xQVA
	 NSHvTp3jMG4Ep4i4+mcDH2gKI3viiuRx3iZFSN6jA07kM2xyDQWHO9Py4pjf00McxZ
	 5fX5micaCP07h0C8e9Jj5bQ3yCRo7bgTCEMu5Shu90wwfp4s661vrAptfhoJ8DAf8G
	 Y/7/k5Zc2tZ7Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org,
	Aleksei Shchekotikhin <alekseis@google.com>,
	Nilay Vaish <nilayvaish@google.com>
Subject: [PATCH v2] bpf: Allocate bpf_event_entry with node info
Date: Tue, 28 May 2024 23:53:11 -0700
Message-ID: <20240529065311.1218230-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that accessing perf_event map entry caused pretty high
LLC misses in get_map_perf_counter().  As reading perf_event is allowed
for the local CPU only, I think we can use the target CPU of the event
as hint for the allocation like in perf_event_alloc() so that the event
and the entry can be in the same node at least.

Reported-by: Aleksei Shchekotikhin <alekseis@google.com>
Reported-by: Nilay Vaish <nilayvaish@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) fix build errors

 kernel/bpf/arraymap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index feabc0193852..067f7cf27042 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1194,10 +1194,17 @@ static struct bpf_event_entry *bpf_event_entry_gen(struct file *perf_file,
 						   struct file *map_file)
 {
 	struct bpf_event_entry *ee;
+	struct perf_event *event = perf_file->private_data;
+	int node = -1;
 
-	ee = kzalloc(sizeof(*ee), GFP_KERNEL);
+#ifdef CONFIG_PERF_EVENTS
+	if (event->cpu >= 0)
+		node = cpu_to_node(event->cpu);
+#endif
+
+	ee = kzalloc_node(sizeof(*ee), GFP_KERNEL, node);
 	if (ee) {
-		ee->event = perf_file->private_data;
+		ee->event = event;
 		ee->perf_file = perf_file;
 		ee->map_file = map_file;
 	}
-- 
2.45.1.288.g0e0cd299f1-goog


