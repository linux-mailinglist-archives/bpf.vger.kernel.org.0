Return-Path: <bpf+bounces-30125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759788CB237
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA261F22120
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69729414;
	Tue, 21 May 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kxELvDe4"
X-Original-To: bpf@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B146717556
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309199; cv=none; b=DFCNiGi9pJTg/FKRL1QUQREiDPv68xJ4eET3cxDXcCaBHLNLACF9mO57ZdC3309SxnguEh+NDSFNrsNscVW+sBMOQWpXD2wo35KZwpJAindoPcejjGP/oFPpc73V8I83Fl586bZ31e2QdQKlQFl8RpVYOqUUCKEgCUcC6WJRI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309199; c=relaxed/simple;
	bh=4pGAMx5urtSQ/dCyB9t6cN9tmkLhVjzBgpx40HlKF6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZD42Vk6jnrDB6dOX/j+CujBa1aSJsRAnw6y/3jAHJ6YU+Lh7oF3joJh9qIpEnzEz7ZPU3kub6SQdygUc+IYckFCiZ86hrQsK9pbuscU8FWJHODQ0B/uh9muoFezjqpgDBzF4FKD2RVmSCzGCQXveFMJheQ6d2h2PbBNZq1zF0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kxELvDe4; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=T2lAV
	QvwxpH/bjA1fpplqyRYDx8/s/Tkoi13ietImFg=; b=kxELvDe46+LMpAmf4e/QC
	P4BVCo2MEMXazye542lbJkSOZG7FsvP8qbE6lGVQKypAyNrU+vacfPOyUYfqfpSN
	ogvvb0DNmFMMeJT4qrrQKl9GI9wQP+iGFpJ9jx6sOaie04LzUf1oiHZnY2iAi2Uv
	/z8SAh8bxN1f7vatYwSvew=
Received: from localhost.localdomain (unknown [115.60.16.246])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wDX_2EAyUxm1naHFQ--.46551S2;
	Wed, 22 May 2024 00:17:08 +0800 (CST)
From: zhangying <yingzhang098@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	Ying Zhang <yingzhang098@163.com>
Subject: [PATCH bpf-next v2] bpf: Remove unused variable "prev_state"
Date: Tue, 21 May 2024 16:17:02 +0000
Message-ID: <20240521161702.4339-1-yingzhang098@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <yonghong.song@linux.dev>
References: <yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_2EAyUxm1naHFQ--.46551S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr15CF18tr1kWr1xWw4xXrb_yoWDJFg_tw
	1Fqr1xArZ5Gr10kF1F9w17Gas7Zr95Kw48WrWjq34jy3Z3tr1rZwsxZrnxWrWxXw1xuF9x
	J3s7XF1Ikr42yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRMmhtUUUUU==
X-CM-SenderInfo: p1lqw6pkdqwiizy6il2tof0z/xtbBhgXl0WWXvodD3AAAsj

From: Ying Zhang <yingzhang098@163.com>

The variable "prev_state" is not used for any actual operations

v2: Fix commit message and description.

Signed-off-by: Ying Zhang <yingzhang098@163.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 samples/bpf/cpustat_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/bpf/cpustat_kern.c b/samples/bpf/cpustat_kern.c
index 944f13fe1..7ec7143e2 100644
--- a/samples/bpf/cpustat_kern.c
+++ b/samples/bpf/cpustat_kern.c
@@ -211,7 +211,7 @@ int bpf_prog1(struct cpu_args *ctx)
 SEC("tracepoint/power/cpu_frequency")
 int bpf_prog2(struct cpu_args *ctx)
 {
-	u64 *pts, *cstate, *pstate, prev_state, cur_ts, delta;
+	u64 *pts, *cstate, *pstate, cur_ts, delta;
 	u32 key, cpu, pstate_idx;
 	u64 *val;
 
@@ -232,7 +232,6 @@ int bpf_prog2(struct cpu_args *ctx)
 	if (!cstate)
 		return 0;
 
-	prev_state = *pstate;
 	*pstate = ctx->state;
 
 	if (!*pts) {
-- 
2.43.0


