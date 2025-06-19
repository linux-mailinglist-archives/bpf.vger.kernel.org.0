Return-Path: <bpf+bounces-61032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D6ADFE4F
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7013C3B2A03
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 06:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06329248F4F;
	Thu, 19 Jun 2025 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mvBfgo58"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9D21B8F5;
	Thu, 19 Jun 2025 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750316256; cv=none; b=glaNWRmtKg2hjV0VdIfU92SMVPVZ9cleomMKDl2a6Ze+oS6wqnYK/WU0V23JnZN3vVJOxEaoe3Uh+418uF3U57KNHgOm7KDyyGSHUSPKq97XHXGkoOFNEHryG9nVlm3PqPLhwimYM5eFFORIAFmY1Hk6tt2/GsUkfsARjk/P9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750316256; c=relaxed/simple;
	bh=QJTn2F0Vi2smMsXBne9dl6Ncd2JRbrjvNoOWX32WxOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cr5EXkNuK/Vt21uQDahe+MYwsHg9bgxuJmyw+nTuMjcpSMWg1sq9V8yATBb3HcESgdtd8qBjWpORCR/DlSHe2ziSQ6LOc/jsylDjU7soIROdoZ5qGsuVBm934U9K9mgbQtVD90fG4IthV7CM3N3AP30iUIAoY4cPnA4Lh+nbYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mvBfgo58; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JO
	r6DQk02pP6jKtrUOGXaAcSW5MWXso0pj5iQwFNr+E=; b=mvBfgo582s3DM5kI5W
	YzWBTtzs6uP0qOjqU1DrNppFJLQJdopxrTOgp5DD5GVQFF7wpXZ14r6FhNieGHM5
	4YHnrkAOdEF1fxj0kgy140WWbCP4//r71DkENv1VFZ/yb2ejZWInn95NLbJLnjjn
	lGQdprDSsifzSu83w1e6ELJ3o=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBn7wbQtFNo_eumAQ--.31221S2;
	Thu, 19 Jun 2025 14:57:21 +0800 (CST)
From: chenyuan <chenyuan_fl@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	chenyuan <chenyuan@kylinos.cn>
Subject: [PATH v2] bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure
Date: Thu, 19 Jun 2025 14:57:13 +0800
Message-Id: <20250619065713.65824-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250619031037.39068-1-chenyuan_fl@163.com>
References: <20250619031037.39068-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn7wbQtFNo_eumAQ--.31221S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW5Xry7WryrCF1kGr1kuFg_yoW8try3pa
	y7Ga40yr15WFyru34kAa1rZFW3Cw1xGrs5Kr43J3y8uw15Xrn3uF1UKa4FvFs0gFyrWFy2
	yr1FkF9rXF1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pioa0DUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiJwBxvWhTsWdZMgAAst

From: chenyuan <chenyuan@kylinos.cn>

In function dump_xx_nlmsg(), when realloc() fails to allocate memory,
the original pointer to the buffer is overwritten with NULL. This causes
a memory leak because the previously allocated buffer becomes unreachable
without being freed.

Fix: 7900efc19214 ("tools/bpf: bpftool: improve output format for bpftool net")
Signed-off-by: chenyuan <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/net.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 64f958f437b0..1abedfe6f33f 100644
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
@@ -395,6 +396,7 @@ static int dump_class_qdisc_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 {
 	struct bpf_tcinfo_t *tcinfo = cookie;
 	struct tcmsg *info = msg;
+	struct tc_kind_handle *tmp;
 
 	if (tcinfo->is_qdisc) {
 		/* skip clsact qdisc */
@@ -406,11 +408,12 @@ static int dump_class_qdisc_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 	}
 
 	if (tcinfo->used_len == tcinfo->array_len) {
-		tcinfo->handle_array = realloc(tcinfo->handle_array,
+		tmp = realloc(tcinfo->handle_array,
 			(tcinfo->array_len + 16) * sizeof(struct tc_kind_handle));
-		if (!tcinfo->handle_array)
+		if (!tmp)
 			return -ENOMEM;
 
+		tcinfo->handle_array = tmp;
 		tcinfo->array_len += 16;
 	}
 	tcinfo->handle_array[tcinfo->used_len].handle = info->tcm_handle;
-- 
2.25.1


