Return-Path: <bpf+bounces-70206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFEBB465D
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFFC19E4098
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2372233D88;
	Thu,  2 Oct 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DR81636T"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256E22FAFD
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420176; cv=none; b=Xlwrb8dI1IWCeuqj6dDCgjII9qOc4POBVGI1a9cCn+UgzfnTZe55c1hxfBp0ES1JyYdTGmdDO1THMk1ndAMoHdV70Y+uKZmYoSiJO8tH5Ka4JI0faLrMIbX8PWoqIagOsDztERY3wGvp/ivQh/C371rg9EO1UeiXh5x98/LLobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420176; c=relaxed/simple;
	bh=hCr8X0Ok7RXUkzLlh4GkF5eDVg7WavYflnMuKXszYWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmkXNa1sJHh89DZgfeQAmzGHBKepSbxpTDGUBEzmG4rNiLYy2KDTBT47tZTPOPXQ4LMOF+iuZ5p0o7mJZ5qYGljasjY8a5uFqCaHtaKWNEYkKEaGI+9T4zhA0j1gbgmX5RvBG9SUf2uC63dG7Aj69MIljegY/Xa6dO2FUiGVg+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DR81636T; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759420170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y266V2uHU5C30cIsNNl7z6bhIIBdcl2BSvWXuWs5nXw=;
	b=DR81636TNupTdktNuOFDOEgI9uFgz9GWXsgeKrH2UMHk1ER5rO40f2Hj0NnyLNlQ9IbxpW
	P+qxaw3P2VbG9XEcQS1oYMbUb9V4HRVcOLki2fzOWPoz2oM/OUnypUB0K8/Bj1MjJAh/Z6
	/stJdQCPldc7/m+DnTND+3hWtqHwydU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v3 07/10] bpf: Add warnings for internal bugs in map_create
Date: Thu,  2 Oct 2025 23:48:38 +0800
Message-ID: <20251002154841.99348-8-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-1-leon.hwang@linux.dev>
References: <20251002154841.99348-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In next commit, it will report users the reason of -EINVAL in
map_create.

However, as for the check of '!ops' and '!ops->map_mem_usage', it
shouldn't report the reason as they would be internal bugs.

Instead, add WARN_ON_ONCE to them. Then, it is able to check dmesg to get
the error details.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fc1b5c8c5e82f..49db250a2f5da 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1406,7 +1406,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 		return -EINVAL;
 	map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
 	ops = bpf_map_types[map_type];
-	if (!ops)
+	if (WARN_ON_ONCE(!ops))
 		return -EINVAL;
 
 	if (ops->map_alloc_check) {
@@ -1416,7 +1416,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	}
 	if (attr->map_ifindex)
 		ops = &bpf_map_offload_ops;
-	if (!ops->map_mem_usage)
+	if (WARN_ON_ONCE(!ops->map_mem_usage))
 		return -EINVAL;
 
 	if (token_flag) {
-- 
2.51.0


