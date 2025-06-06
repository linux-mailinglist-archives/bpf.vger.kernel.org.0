Return-Path: <bpf+bounces-59893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D33AD071B
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D44817BD9F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1328A405;
	Fri,  6 Jun 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IQtIM2Mm"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942928A722
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229139; cv=none; b=eAWqIbQ42uc9nW5xwWU5LzdkC2HN0jUgrpx3XcTyBmpQ5N01V5v1mxerxv5bijmkDDwIS4ss7lmcDkyvZSShNjnJyLtkPFkTWhMePZ98lQSVSJTOSymv+qtzk+FxhtKAtpXQscmXiSx8DHC1wUqsCRESrY68IgSS7npc8R9/R+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229139; c=relaxed/simple;
	bh=QdgLJMOMQ3C5/az7U6XNwcXiJQNcg3TaCEczq+kWiDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXU7+s7ZDEaYHAbo72xK9aNbtL7Pu2uxnXSUyqApHv7SmWLkk6rmYbhe/wuEl2tfSeXGu9zMeMVXhMupFxUuJO+cQmgeO3vVjLzKu2uQnWtWhEw4qzifTtE/8sgaJBq8kH1VzcrUKS1VLwHp+ay1++AmiyG9a8XA6L7jMb95OQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IQtIM2Mm; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749229135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oodcg3fHwfb1DAQxufb8e9G/tet+E5AN4YrJwROWPF8=;
	b=IQtIM2MmsxZpgSdn1hx797RkOIBlsvmOjicGMCJLSZ3bvvtJ9QFn3dpfBUjgPm/Rn5g1JQ
	GNGk9mBoytcCL/HoKt55kTsFEj69vB0PncfxAlGimYnewTSGyeXLiFFAtT/Xg7B5fjdVQT
	mZTYkyfW3gAZHP5mor75TjEsEJsY1ZM=
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
Subject: [PATCH bpf-next  4/5] bpf: Add cookie in fdinfo for tracing
Date: Sat,  7 Jun 2025 00:58:17 +0800
Message-Id: <20250606165818.3394397-4-chen.dylane@linux.dev>
In-Reply-To: <20250606165818.3394397-1-chen.dylane@linux.dev>
References: <20250606165818.3394397-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add cookie in fdinfo for tracing, the info as follows:

link_type:	tracing
link_id:	6
prog_tag:	9dfdf8ef453843bf
prog_id:	35
attach_type:	25
target_obj_id:	1
target_btf_id:	60355
cookie:	9007199254740992

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4c0ac083518..d6eba1339ad 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3403,10 +3403,12 @@ static void bpf_tracing_link_show_fdinfo(const struct bpf_link *link,
 	seq_printf(seq,
 		   "attach_type:\t%d\n"
 		   "target_obj_id:\t%u\n"
-		   "target_btf_id:\t%u\n",
+		   "target_btf_id:\t%u\n"
+		   "cookie:\t%llu\n",
 		   tr_link->attach_type,
 		   target_obj_id,
-		   target_btf_id);
+		   target_btf_id,
+		   tr_link->link.cookie);
 }
 
 static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
-- 
2.43.0


