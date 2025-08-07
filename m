Return-Path: <bpf+bounces-65181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99326B1D104
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 04:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787DA188A029
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 02:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546A1A704B;
	Thu,  7 Aug 2025 02:48:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96B79EA;
	Thu,  7 Aug 2025 02:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534932; cv=none; b=urG6rgvu8HhzQ7f3PqNTCx4K5Z0TDy5vM7z1jQ6NtfddxQzkTGP7iV99JhsmHWhV1BxGdx5+hXqVLJZKev4gc3AkhYUCzQW1W1xSAE4tED1OmC0ilgkLQmTt5aDMaLCpGy/ku5MEYj3BYlDWkSPrqTbtX5aIgxDgWCK25+400rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534932; c=relaxed/simple;
	bh=VUt8Jc33Tq024p6jV2/CkCuqg6EK8ygao2cRjBx5J4k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jxJr1v7wxdrgxA4HaTgvnmcmoLjPKbTyhH7Xj5apJHFTE+S5RyxLZcx6NtMz2nDCLagCvjlNdoeZEHi07Hs3eLyYwUeDm3vsqIrwuA1xaJ3MScF4iRzxicgImkyzgiObVIC5mDvsrPTOa6WHOX8RMlB/BepkwK7NhnLVzOdcJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>, Fushuai Wang
	<wangfushuai@baidu.com>
Subject: [PATCH bpf] bpf: Use cpumask_next_wrap() in get_next_cpu()
Date: Thu, 7 Aug 2025 10:48:00 +0800
Message-ID: <20250807024800.39491-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the manual sequence of cpumask_next() and cpumask_first()
with a single call to cpumask_next_wrap() in get_next_cpu().

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 kernel/bpf/bpf_lru_list.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 2d6e1c98d8ad..34881f4da8ae 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -21,10 +21,7 @@
 
 static int get_next_cpu(int cpu)
 {
-	cpu = cpumask_next(cpu, cpu_possible_mask);
-	if (cpu >= nr_cpu_ids)
-		cpu = cpumask_first(cpu_possible_mask);
-	return cpu;
+	return cpumask_next_wrap(cpu, cpu_possible_mask);
 }
 
 /* Local list helpers */
-- 
2.36.1


