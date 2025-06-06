Return-Path: <bpf+bounces-59894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FEEAD071D
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3327AA4DD
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF328AAFC;
	Fri,  6 Jun 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pMcwHXVo"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890B28A1C6;
	Fri,  6 Jun 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229144; cv=none; b=i2MPeILpZCy8KPSZN0RVsrk97CqF7RaoUOSQYPOBFlz4s/DdaIFUQW6a5xt/8kJ08ykT5gwORDPYFAyxDkc7zAUcSXvLbH1+UyUIqsQrWXX6C9XFXRxlEg21Ab9HIl+Jz0GbKkoVJVu/CC7YWp8p0m3w1WQQupXocaHWKI5AgLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229144; c=relaxed/simple;
	bh=nyvr1Ps7hfsjB59J+PLls5tm0y5DvhYk5tNGwvjSVIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2SavXR/SviyI9twRcXY1xKDdg793xZQhbf1fujqz415NEnyfVr+MhFRu3AH0xQHmkeE7alHs4hPkH1DBUHQwfr22DSuYmD6jkEQAJBXFVg3NPjgVLDlPWOZ/oxVdp83zHFMkc81SZ5cDDhvgYQqrSR8jEQa5aVj48zhHegGFxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pMcwHXVo; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749229140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4W6nyxaAuTdUb1jq+F6lNxI7paZc1KWXJrcEaRmIK6k=;
	b=pMcwHXVoXVPwn9p7Tk0AGT8HutswanrjzBIkr0iTl7ZvbqbD590n9vnBjVcK/3k+B/bonI
	3zAuj4cIlaXQfTV8p3PkOJjGH2l/Z4tDLSwUK28wfbQK8c5eUOhgwsrLoppWISjsgiYdYD
	aWDUpM3I2dIkOsPZcp6egNibMxgpz3Q=
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
Subject: [PATCH bpf-next  5/5] bpf: Add cookie in fdinfo for raw_tp
Date: Sat,  7 Jun 2025 00:58:18 +0800
Message-Id: <20250606165818.3394397-5-chen.dylane@linux.dev>
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

Add cookie in fdinfo for raw_tp, the info as follows:

link_type:	raw_tracepoint
link_id:	31
prog_tag:	9dfdf8ef453843bf
prog_id:	32
tp_name:	sys_enter
cookie:	23925373020405760

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d6eba1339ad..51ba1a7aa43 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3654,8 +3654,10 @@ static void bpf_raw_tp_link_show_fdinfo(const struct bpf_link *link,
 		container_of(link, struct bpf_raw_tp_link, link);
 
 	seq_printf(seq,
-		   "tp_name:\t%s\n",
-		   raw_tp_link->btp->tp->name);
+		   "tp_name:\t%s\n"
+		   "cookie:\t%llu\n",
+		   raw_tp_link->btp->tp->name,
+		   raw_tp_link->cookie);
 }
 
 static int bpf_copy_to_user(char __user *ubuf, const char *buf, u32 ulen,
-- 
2.43.0


