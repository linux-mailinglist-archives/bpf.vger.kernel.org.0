Return-Path: <bpf+bounces-30795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B18D2811
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EB91F2655F
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F213E035;
	Tue, 28 May 2024 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYNQRc2m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6D13D8A2;
	Tue, 28 May 2024 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935805; cv=none; b=ayshP10C34f85CiP7YXPsnF04ThhhFYVXrQmnZaVeSE6v3Tt+n0Yq2nWBmUMaaYQHwZ/0A6NUVMayQwy96ZSs6xJy1KdT5Hv311Elb3w2OygZ/jik3xnttNDvHtTrpxGGB6SMls6mNgvSMeIz4g4VtTszcmkBq5Y+Z+EJY2+tbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935805; c=relaxed/simple;
	bh=3gdE/E0U3clBk6Jp0GUhaEaCZOEY/6pMB88YdJtj9tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBVbwsTS3Rrvp0f+NfVqVlG/KdRfvEHXjaxhXl9v/7VU8vbfy8SPUcJZiRCi6emccQFCLIIQ9S6ToE1KeDWvKEFLIvFHh6sLXRHL7btidrQDXOvsazSfxMyEpFN/sMKC3FtkMQ8WqHf6vw2vgI/DV3gOMQYFmDoHEVY3dSS+m3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYNQRc2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577C2C32781;
	Tue, 28 May 2024 22:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716935804;
	bh=3gdE/E0U3clBk6Jp0GUhaEaCZOEY/6pMB88YdJtj9tQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oYNQRc2mUDbMRiEVX/3WzyEHrXI/IslbIEWbB1RRoCBpSx2gdnPi/VJat0le/vVuN
	 Aa/KVAEEIvsO8rkdgTRNP96XxAzv5QmYgWLTtnwDnDtn8fm5HbRPA76sWmgYHKBE3q
	 41Er7hgclneNsdv2BrRQTR8u1r7fYd+/jgCQ5pr9MN08TWkqXH0wFTamKprTq3bsDp
	 m3sdgY1vq+BwflauNKmazylhx+Pvi96jimE3Zs9Yx9KzPpBCYokXfRex/XMhgzN1+b
	 EJfZrjJWBjGRB5roZJbM920KTBkD9etHotvcLeZPhT42vSVT8ffyjSYIz7cML7BhCz
	 mPn+WyFF6sBZg==
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
Subject: [PATCH] bpf: Allocate bpf_event_entry with node info
Date: Tue, 28 May 2024 15:36:43 -0700
Message-ID: <20240528223643.1166776-1-namhyung@kernel.org>
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
 kernel/bpf/arraymap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index feabc0193852..3f7718c261d7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1194,10 +1194,15 @@ static struct bpf_event_entry *bpf_event_entry_gen(struct file *perf_file,
 						   struct file *map_file)
 {
 	struct bpf_event_entry *ee;
+	struct perf_event *event = perf_file->private_data;
+	int node = -1;
 
-	ee = kzalloc(sizeof(*ee), GFP_KERNEL);
+	if (event->cpu >= 0)
+		node = cpu_to_node(cpu);
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


