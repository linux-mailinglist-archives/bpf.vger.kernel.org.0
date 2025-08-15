Return-Path: <bpf+bounces-65704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6118B2765C
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 04:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D8B68845A
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 02:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3329D295;
	Fri, 15 Aug 2025 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D6pOjUpy"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1806F291C2D;
	Fri, 15 Aug 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755226388; cv=none; b=Y0sujmuw0PCe/U1gWoLbbIVVDYNsRTY6CkuXyHaBEj683xB1MulRzZao4thEN9YEfH78GeM7+IOjk+UzL03O6UnbREeQu7R/4OcWGlxR17Nq8ce8mAY56M6ovS8pLMIGStfDOGT0Hoy2wKA4mAan4dEBtivAwVrHyy/zaJUKOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755226388; c=relaxed/simple;
	bh=cYsqzs3qX3wxW+O4L3b0NqzjTIcBQ3hmDgTEFL3X5O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9v/xGZa4SkobqUx4h3XRPFuzFFTv6QCihV8mrjjesxeXdtkLW/D2Z503HGJJVf5bcpgNoXQ5c2D+y3zk5aHhf3BTSlajr2aMkdCWBU5hktX4txcjz0kcGMhVm4AqmhQZQiqzwgYQ9pp7heFoCub1cyEGzEKFs1AIqJn3RSF1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D6pOjUpy; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ym
	Rv4TV2o/bv+U5rpjO6rT1EikbirYbtJyHM2uyELHo=; b=D6pOjUpyQM+zl2yO/v
	aISYSQR/eHhHwThDqpD7kKdOAvt4oDKjqIlak7etC5mmsiogF2yookILwVw8MIcf
	ArZD5aSbmF8wQ0qEfh77tma1VWSFwNW0NITEV3SFlkokYaQajFwctSr8b1zhAozC
	S4tBH7zOh7huG7TTYtuX1vQoU=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBnIl_toJ5oqDUKCA--.29342S2;
	Fri, 15 Aug 2025 10:52:31 +0800 (CST)
From: chenyuan_fl@163.com
To: yonghong.song@linux.dev,
	olsajiri@gmail.com
Cc: aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	qmo@kernel.org
Subject: [PATCH 0/2] bpftool: Refactor config parsing and add CET symbol matching
Date: Fri, 15 Aug 2025 03:52:25 +0100
Message-Id: <20250815025227.6204-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <74709a08-4536-4c5a-8140-12d8b42e97c0@linux.dev>
References: <74709a08-4536-4c5a-8140-12d8b42e97c0@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnIl_toJ5oqDUKCA--.29342S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1UCF1UCw13CryxZrWkZwb_yoWktFgEgF
	WxXFyYqr15AFySkayxGr4rWryxGa1rGrW5Ja10qr4ftrsrJwsrJFsYka1qva4YqFy3Ar13
	A393ZwnYv3W7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8373DUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbBSQSlvWiX9VwW2wABsP

From: Yuan CHen <chenyuan@kylinos.cn>

1. **Refactor kernel config parsing**  
   - Moves duplicate config file handling from feature.c to common.c  
   - Keeps all existing functionality while enabling code reuse  

2. **Add CET-aware symbol matching**  
   - Adjusts kprobe hook detection for x86_64 CET (endbr32/64 prefixes)  
   - Matches symbols at both original and CET-adjusted addresses  

Changed in PATCH v4:
* Refactor repeated code into a function.
* Add detection for the x86 architecture.

Changed int PATH v5:
* Remove detection for the x86 architecture.

Changed in PATCH v6:
* Add new helper patch (1/2) to refactor kernel config reading
* Use the new read_kernel_config() in CET symbol matching (2/2) to check CONFIG_X86_KERNEL_IBT

Yuan Chen (2):
  bpftool: Refactor kernel config reading into common helper
  bpftool: Add CET-aware symbol matching for x86_64 architectures

 tools/bpf/bpftool/common.c  | 93 +++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/feature.c | 86 ++--------------------------------
 tools/bpf/bpftool/link.c    | 38 ++++++++++++++-
 tools/bpf/bpftool/main.h    |  9 ++++
 4 files changed, 142 insertions(+), 84 deletions(-)

-- 
2.39.5


