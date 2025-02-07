Return-Path: <bpf+bounces-50761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E9A2C2DC
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 13:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4277A78C8
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463371E00BF;
	Fri,  7 Feb 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iobJYFkg"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6678F33EC;
	Fri,  7 Feb 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738931997; cv=none; b=NWCdFQdbzem9zWooSl+hhgmLYJTxGskKjCjaWjiFCwHFazkNVgWNiKydvWw6r3cMf1qyyf0ZJXigmWOKayJ28fhU4GzPYcKxBP4/S2ALz+GLcKYP1sJvyBMlu3RGoxcdRBqfJk4QejkmxJ+sNwxyBQRE1yWNbKEty09+WMWhXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738931997; c=relaxed/simple;
	bh=YkNqB3/vX66PZMz2ewhg9EDtAy6lM2uLY6XS53/UtPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmqnsJF6CveZZPJ670aF/KwfBw6TmHqVnJWpmEISmUalK0Qtb7JmZIpSjfLMAi8AHojRe0EHbvhO+Hkx4Z4gPpdz98A8yzbEz3REjCLTMQhYOeQah92HdRbZksvQE2B6yG0q6TUHRqbDlvdvd/pA0yWSi53Zo3lm73TTSqrpbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iobJYFkg; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=ZuFNP
	INeM5l4Nzpanbza99JyclQ4OSvqzbxpIfy/qGE=; b=iobJYFkgR6NnrDNYXnk0z
	X+ixiGgNTIBUZGlAfIPiyJGZy6Wyv/lYP9nSY0g9fddz5dJiymuh5yfV3z5U3w1B
	nL0QQMaBs6vFwL2v5HMQd4BBXj1nSLwdsJz2uuvA7p9UwgJaNMbKcYKlA6qoczAq
	DFwv3ztT+7cbgFnuxV7vCU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBXz910_qVn3DJjKQ--.8274S2;
	Fri, 07 Feb 2025 20:37:10 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf-next v1 0/1] Using the right format specifiers for bpftool
Date: Fri,  7 Feb 2025 20:37:05 +0800
Message-ID: <20250207123706.727928-1-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXz910_qVn3DJjKQ--.8274S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFyUtr47CF17Kr1DtryxZrb_yoWDZrgEga
	97X3s5G3yYyFZ3tFWIgry5XrWktFWv93WkA390gwnxJ34rZFyUJF1kCrZxX3WrWayUuFy7
	tFZYgryrAa43ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREZqXPUUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWwzsp2el8FHWGAAAsx

Fixed some incorrect formatting specifiers that were exposed when I added
the "-Wformat" flag to the compiler options.

This patch doesn't include "-Wformat" in the Makefile for now, as I've
only addressed some obvious semantic issues with the compiler warnings.
There are still other warnings that need to be tackled.

For example, there's an ifindex that's sometimes defined as a signed type
and sometimes as an unsigned type, which makes formatting a real pain
- sometimes it needs %d and sometimes %u. This might require a more
fundamental fix from the variable definition side.

If the maintainer is okay with adding "-Wformat" to the
tools/bpf/bpftool/Makefile, please let us know, and we can follow up with
further fixes.

Jiayuan Chen (1):
  bpftool: Using the right format specifiers

 tools/bpf/bpftool/gen.c  | 12 ++++++------
 tools/bpf/bpftool/link.c | 14 +++++++-------
 tools/bpf/bpftool/main.c |  8 ++++----
 tools/bpf/bpftool/map.c  | 10 +++++-----
 4 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.43.5


