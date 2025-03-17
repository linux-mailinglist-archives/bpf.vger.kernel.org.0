Return-Path: <bpf+bounces-54210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD6A656C3
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 16:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA58188ECC8
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221B1A3147;
	Mon, 17 Mar 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YF24cflZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AE18C933
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226754; cv=none; b=qZIshmyiYj3ZE8kIyT53Rmxb/NIkD4vd5hKjCMQtf1ouz3L9qmrz86Sh7PSGxapGNYf1ubNQoZ1M2jR69wTwD2ZOcCKPNwTt6Bwg1mMe+ixf2X4X1lS84X2itHRHVnQ0PAQMeXjYKsp4hj6+d3ADCWE25ZK3OPQWvfxLNLpZn4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226754; c=relaxed/simple;
	bh=dUfQ96pcjbRz1+/lt2Zy1k/1dLu56V4jXKxvVQyuiOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TLM8+/Sqvl3hso25D8cXFO6mxZrbHl+8QIMd9RCFtZwS/qLIppOZ6lBCDgC2Hhoi04Tk44TieDHakvZYYz68k/6qUfS3SyNhOfpse5EZN9L3QLiCTQzFEUfR4F9A1s5uQB6hboTvxU/OifvVTNxeE3yFiuJ5wyGA3u+r2vrVWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YF24cflZ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742226739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RkKSxDUbBmd7YpUH6TyrziTFRfsGpiWyoLKpjKRDRpw=;
	b=YF24cflZJipA3SARqd2ek+f0zq1pNmk8GFP1qLE1KL+XVvuNoVR1l+nX+xqRilXU1zakXg
	KrpHWCSkarOMtL4ztI2rPoKIK6IqbInRDdcFxRht9G2qEnekLLwMAjqt+IjB9BqSqr/ioi
	2egij2u1En08Ar3cP6ukRXqoGhZqLvQ=
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
	haoluo@google.com,
	jolsa@kernel.org,
	brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: Define bpf_token_show_fdinfo with CONFIG_PROC_FS
Date: Mon, 17 Mar 2025 23:51:47 +0800
Message-Id: <20250317155147.2933972-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Protect bpf_token_show_fdinfo with CONFIG_PROC_FS check, otherwise
it will compile error if CONFIG_PROC_FS is not set.

Fixes: 35f96de04127 ("bpf: Introduce BPF token object")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/token.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 26057aa13..4396eefde 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -105,7 +105,9 @@ static const struct inode_operations bpf_token_iops = { };
 
 static const struct file_operations bpf_token_fops = {
 	.release	= bpf_token_release,
+#ifdef CONFIG_PROC_FS
 	.show_fdinfo	= bpf_token_show_fdinfo,
+#endif
 };
 
 int bpf_token_create(union bpf_attr *attr)
-- 
2.43.0


