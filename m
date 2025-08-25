Return-Path: <bpf+bounces-66379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE543B333EB
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 04:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E2D3BD4B4
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5BC2367DF;
	Mon, 25 Aug 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K8hvfEvo"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AA321D3F6;
	Mon, 25 Aug 2025 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756088454; cv=none; b=cJfT1Hk2zTHVTB7DbRfnRxIV5PEH5e9mxKpmHcwMxJ0nVo1RJZ+RUmZ1s39rLB40kPamIdRUWBSgA62oOIghLKdHW9AqH+TJiRuhbRNo34bNR8iXUOiWOiLwdEKGQg1+iZ4c90cJ1Z+O2Pb3E4U7/u2wZPri3Ix2ZmCkTS6rFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756088454; c=relaxed/simple;
	bh=EQ/zcAckVWgbMbZQab4BvLqSIULf4GwdrgDeaUo913A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tdoWE4O5c1jWHCnAwLt9sY6DvErtWXN6aT7itfmcVD6Y0Aqf0/QpnWfD3HeQYAYwrJMyaDTc5On8UNnHGK1i+5aP5+wjgK6TDtjokUth3IOeXkB4VKNYBvH+DH/WMpSofGsaYUEnBp/y8boTPb1OkgIWFHsu4g9eIlZRbUp3roY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K8hvfEvo; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JW
	JSnQ3s8yELJiCYVUrKb89fO2yyCBW/15VLGtPgeZ4=; b=K8hvfEvobmCJnXVl4n
	1pIsnVN6i/CPUVshZ1OjPDCDysNJWsbeiyeKzmqY+buNEOC2qdFW4jYrOveIoeKk
	bzkR5abvmSWidPylVy7JEcVBxU1IhXuDaNHlMhtDVfxIwdYjKWNV3ZsZhSHMkjPF
	tIdB8fgd4tFS89jGC9zJ8N7C0=
Received: from 163.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnA_ZUyKto6PbuAQ--.6728S2;
	Mon, 25 Aug 2025 10:20:07 +0800 (CST)
From: chenyuan_fl@163.com
To: olsajiri@gmail.com
Cc: aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	chenyuan_fl@163.com,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	qmo@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v7 0/2] bpftool: Refactor config parsing and add CET symbol matching
Date: Mon, 25 Aug 2025 03:20:00 +0100
Message-Id: <20250825022002.13760-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <aKL4rB3x8Cd4uUvb@krava>
References: <aKL4rB3x8Cd4uUvb@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnA_ZUyKto6PbuAQ--.6728S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4rZw4rAF4xJw1fAFy5Arb_yoW8JFy3p3
	yfCrW3XryUXr13uanxGr48WrW5Grs7Wr48Xrn7G348Aw18Ar10yr1Igan7JasxJryaqF1U
	ZF1F9FyqgasrArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirWrJUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiJxutvWijkrqw7QABsT

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

Changed in PATCH v7:
* Display actual kprobe attachment addresses instead of symbol addresses

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


