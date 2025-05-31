Return-Path: <bpf+bounces-59409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D0AC9A47
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC113A5464
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 09:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547B5239567;
	Sat, 31 May 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qQR7MIIZ"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB9FEED7
	for <bpf@vger.kernel.org>; Sat, 31 May 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685090; cv=none; b=fop/7JaTLcs/cdiEQ7kTAb7CieSqTj+lQC59P/WAZO0Zf/7FWGt1kcX71RKhPKwx2fvPwhYprkST3ajmsgLws7hVTufE2Z/TKgxCJt1cxw0qHLLiDBQXGw3rAnoQlUx/3ayBoWeKhMXUvNBJNcc6nGjIeFs268I5wTJSCi35p0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685090; c=relaxed/simple;
	bh=ZM5aGRQ3UciKbLqXO7MT168nvz9xv1xezNpZuKTWxRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AY3+7BHIv7dzLJzhzwUj6nJM7Y9uzAS1qxoBl65WGtFinywSgkKkcr2Panzfex79GepAsD69fw9APXn9SJR5LDLEHmWjyZ5z/dE421HzKcc0B6IE565KH9p93qEwW/BD232D03CA/6k+DXK8KuwDKpsr5ckbwk2XmP/YJf0u+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qQR7MIIZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z4
	r1mK3SkpfiGoMHV+/ckDyJt8w9ct6oxMc6V4Coc7c=; b=qQR7MIIZkDZUIpo4Bm
	qedR34glee/AFYc54YPYekudpsNAfuJvOT0kXTTTRUnl9LVvFQtnZ0BD3MQX5hFz
	FT9lS+jtODoPUMJ4Mi0IOIEVuhobJApvd+GQBYrneYDiWd6Ig3HF4J9gedC3a2kX
	bWHw/rc/eTa9Jq0+HMaRDOfhI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDX42IP0TpoKfOWBQ--.3412S2;
	Sat, 31 May 2025 17:51:12 +0800 (CST)
From: Jiawei Zhao <Phoenix500526@163.com>
To: andrii@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH] libbpf: correct some typos and syntax issues in usdt doc
Date: Sat, 31 May 2025 17:51:11 +0800
Message-Id: <20250531095111.57824-1-Phoenix500526@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDX42IP0TpoKfOWBQ--.3412S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFy5Xw4kKw4ktF13KrWxJFb_yoW5ArWkpF
	Zagw1UCr18XFW8Ar4DZ3y8JrWfta1DGF45Gw48X342vwsxW3Z7KrnagF4akFy7Crs3Ja4f
	ZF42qrW7GFWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U67K3UUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiTwheiGg6zkUtbQABsJ

Fix some incorrect words, such as "and" -> "an", "it's" -> "its"
Fix some grammar issues, such as removing redundant "will",
  "would complicated" -> "would complicate".

Signed-off-by: Jiawei Zhao <Phoenix500526@163.com>
---
 tools/lib/bpf/usdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 4e4a52742b01..3373b9d45ac4 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -59,7 +59,7 @@
  *
  * STAP_PROBE3(my_usdt_provider, my_usdt_probe_name, 123, x, &y);
  *
- * USDT is identified by it's <provider-name>:<probe-name> pair of names. Each
+ * USDT is identified by its <provider-name>:<probe-name> pair of names. Each
  * individual USDT has a fixed number of arguments (3 in the above example)
  * and specifies values of each argument as if it was a function call.
  *
@@ -81,7 +81,7 @@
  * NOP instruction that kernel can replace with an interrupt instruction to
  * trigger instrumentation code (BPF program for all that we care about).
  *
- * Semaphore above is and optional feature. It records an address of a 2-byte
+ * Semaphore above is an optional feature. It records an address of a 2-byte
  * refcount variable (normally in '.probes' ELF section) used for signaling if
  * there is anything that is attached to USDT. This is useful for user
  * applications if, for example, they need to prepare some arguments that are
@@ -121,7 +121,7 @@
  * a uprobe BPF program (which for kernel, at least currently, is just a kprobe
  * program, so BPF_PROG_TYPE_KPROBE program type). With the only difference
  * that uprobe is usually attached at the function entry, while USDT will
- * normally will be somewhere inside the function. But it should always be
+ * normally be somewhere inside the function. But it should always be
  * pointing to NOP instruction, which makes such uprobes the fastest uprobe
  * kind.
  *
@@ -151,7 +151,7 @@
  * libbpf sets to spec ID during attach time, or, if kernel is too old to
  * support BPF cookie, through IP-to-spec-ID map that libbpf maintains in such
  * case. The latter means that some modes of operation can't be supported
- * without BPF cookie. Such mode is attaching to shared library "generically",
+ * without BPF cookie. Such a mode is attaching to shared library "generically",
  * without specifying target process. In such case, it's impossible to
  * calculate absolute IP addresses for IP-to-spec-ID map, and thus such mode
  * is not supported without BPF cookie support.
@@ -185,7 +185,7 @@
  * as even if USDT spec string is the same, USDT cookie value can be
  * different. It was deemed excessive to try to deduplicate across independent
  * USDT attachments by taking into account USDT spec string *and* USDT cookie
- * value, which would complicated spec ID accounting significantly for little
+ * value, which would complicate spec ID accounting significantly for little
  * gain.
  */
 
-- 
2.39.5 (Apple Git-154)


