Return-Path: <bpf+bounces-66940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD875B3B306
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 08:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D1F7BA1E1
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171F822B584;
	Fri, 29 Aug 2025 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f2cRPdd7"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBBF2248B8;
	Fri, 29 Aug 2025 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447921; cv=none; b=gq7q3itRTdig4mK7MNsLXyQMLQt6U29D5WlJ3bacBtMBCCWWGoEEiYuFxz3hdl7BqvSAGsMT4QBzJ5P1lFq4R4MfskvyrXvk4RfTWOJ3pcwIL1pY7C2pL3GNhJMsWwCr3WSKHn8gaGuQmpdW7VYQ8BMZzXMB0lq93jxrMK6oJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447921; c=relaxed/simple;
	bh=EQ/zcAckVWgbMbZQab4BvLqSIULf4GwdrgDeaUo913A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XbHbufVK7s2/RXRGjbJ971v51yxtRi/GzKqnRc7EvJ3kXIByNRIM6yTqeu2a0zFcHeccZqw4lzRV+G/jQRlQh3XET2/jeudnNvWoghAn2vcWd3Yf3xdryEZ3dqlOFeonf4ck54S/7570SDLlnV5lQbfnynyVjDRURRAaaWVUgyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f2cRPdd7; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JW
	JSnQ3s8yELJiCYVUrKb89fO2yyCBW/15VLGtPgeZ4=; b=f2cRPdd723qSuT6ak7
	bWotvCXwTZ+Tnjaqs9SJLXDStlhvACg0juppw+1jynEr/GDhVyHqkuOR8rwqlqun
	Ls2ljSUlMfnwTQuDEkwfvx0eHRtpNplA3rU8IluRq0XAs4NsOqGgjiZJMuEP3wMk
	rVM7m7146YKaBSxoLvtotNRf4=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3vTZ9RLFoGWmGEg--.4740S2;
	Fri, 29 Aug 2025 14:11:10 +0800 (CST)
From: chenyuan_fl@163.com
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	olsajiri@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan@kylinos.cn
Subject: [PATCH v8 0/2] bpftool: Refactor config parsing and add CET symbol matching
Date: Fri, 29 Aug 2025 07:11:05 +0100
Message-Id: <20250829061107.23905-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vTZ9RLFoGWmGEg--.4740S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4rZw4rAF4xJw1fAFy5Arb_yoW8JFy3p3
	yfCrW3XryUXr13uanxGr48WrW5Grs7Wr48Xrn7G348Aw18Ar10yr1Igan7JasxJryaqF1U
	ZF1F9FyqgasrArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn189UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiUQ+4vWixPtyECAAAss

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


