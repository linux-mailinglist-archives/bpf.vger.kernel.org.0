Return-Path: <bpf+bounces-61025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A9ADFBA1
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 05:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541083B4B69
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F5237713;
	Thu, 19 Jun 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kgDW3oXF"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F124A3C;
	Thu, 19 Jun 2025 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750302671; cv=none; b=IUh4AZgSGEwykL7o4oua66OT7N3qb/ww287ni8soAS+5S+ZtfS0LNfuBOjO0AJ0IMeP5OgwMZjNTwksmNQcvxpHaE8k4g2o8nArpYUL0mU1VoBgNsYopVvekMhZhS/jHdEkHQlux5PYGx7nUA9YSRr1WqeslG1xcYbbIcVfLdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750302671; c=relaxed/simple;
	bh=51oZ/IZDB7F4eTcBwvlqPOac0I3Sr1Bdpv7wS8vzbPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SS8Acomn9XyxmvNIHzKMjsRflrVF5Dl0m0Rnh+N5wcEn09HHkmnw1prZVnBqu+4qMPH5HSvGcE+KULs4IjjAgk7CuVSP+fiONqUN3aGXdzgg1D/4IwTwwmIf3vGWMtNKtm65QQt/A1K0FnC9uyrM5jvSuqf7OgnWUKkgeaB7AA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kgDW3oXF; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ST
	RjQteFUZoF2HoMiQkIsJ7Znz080VPaSrZB64TS8oQ=; b=kgDW3oXF2c5Wd110nD
	3F0z2jzbW8mqoBs9me8T0ojmZxZaJkZfDvdfxLi+1B1rNEhDq0OsP6Ug6etyVi65
	z0J70DWpOlQaC3i56e7ryJqRJXYxbWipbS2JqESY0ei9ztOZJBmCJVO9t056lmlu
	ZPRM0+rPLAgJsIRFD/xcCZ5ew=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3P6K0f1NowTSLAQ--.64025S2;
	Thu, 19 Jun 2025 11:10:44 +0800 (CST)
From: chenyuan <chenyuan_fl@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	chenyuan <chenyuan@kylinos.cn>
Subject: [PATCH] bpftool: Fix memory leak in dump_link_nlmsg on realloc failure
Date: Thu, 19 Jun 2025 11:10:37 +0800
Message-Id: <20250619031037.39068-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P6K0f1NowTSLAQ--.64025S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW5Xry7Wr4kJF1rAw13urg_yoW8Gw13pa
	4UGa40vr15Wryru3s7Aa15ZFW3C3WxJrs5GF47A34ruryrXrsrZr18KFyFvanIgFn5XFy2
	yr1Y9a17XF1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pio5d_UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiJxpxvWhTfSNNUwAAsK

From: chenyuan <chenyuan@kylinos.cn>

In function dump_link_nlmsg(), when realloc() fails to allocate memory,
the original pointer to the buffer is overwritten with NULL. This causes
a memory leak because the previously allocated buffer becomes unreachable
without being freed.

Fix: 7900efc19214 ("tools/bpf: bpftool: improve output format for bpftool net")
Signed-off-by: chenyuan <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 64f958f437b0..e00637b85e56 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -366,17 +366,18 @@ static int dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 {
 	struct bpf_netdev_t *netinfo = cookie;
 	struct ifinfomsg *ifinfo = msg;
+	struct ip_devname_ifindex *tmp;
 
 	if (netinfo->filter_idx > 0 && netinfo->filter_idx != ifinfo->ifi_index)
 		return 0;
 
 	if (netinfo->used_len == netinfo->array_len) {
-		netinfo->devices = realloc(netinfo->devices,
-			(netinfo->array_len + 16) *
+		tmp = realloc(netinfo->devices, (netinfo->array_len + 16) *
 			sizeof(struct ip_devname_ifindex));
-		if (!netinfo->devices)
+		if (!tmp)
 			return -ENOMEM;
 
+		netinfo->devices = tmp;
 		netinfo->array_len += 16;
 	}
 	netinfo->devices[netinfo->used_len].ifindex = ifinfo->ifi_index;
-- 
2.25.1


