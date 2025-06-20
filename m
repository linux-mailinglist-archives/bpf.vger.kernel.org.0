Return-Path: <bpf+bounces-61136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D7CAE10AA
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 03:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA0587AD35B
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68CA4437A;
	Fri, 20 Jun 2025 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T/gj0YRk"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFB15A8;
	Fri, 20 Jun 2025 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382543; cv=none; b=HMyPXRslIbx4EMcicEpF59HVh9XZZipNBQAoPGw0FvsmYwbybpprYyrLHi6Ko6Reyh54/1nVVBHzYGnd9wcqltUejFqXIViFwpUQIycv6Ii5LgYZEZpjECaciXrn5RdTRJbjoSLCn7jQ9vvaD9lkdDB4G1xRtSdBlD0zh4duZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382543; c=relaxed/simple;
	bh=ye518mZO0ATTHA/VKZIRuQMgvXIzdamAefhJTThYFY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=po95gUSak1YT7s+O7ALc3YOJFIREDKz+auTYr2EDz25YhsD2OLl4Qk3dvFBdIr00wsqSyLAr0VxO9l9aOym6B2OSxnrAYY0ljLvI+97s4aNnIUQenttV5c8CpHnidPZg9pSE4UZM1JF7MvD8E6UQNCO14B/ifZKdbax7GUgok0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T/gj0YRk; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gN
	gSoBAGHb087xh7RdKgFmbAjPkYpRZ93PeMkFlrG0g=; b=T/gj0YRk22RsRzVtpL
	YsJqnEIYeTMwxXRjbWuL4C+NRnv0lyhELprwTs3fWy65I3zHlFOEHEtfQzd+KdOI
	QzQdLWbHfdOalK9K/0/4Zdz4CsIXOIk2Gc8q8n46OSkGWXuajkY6dWlIE7CBnQ9i
	tn2HTfkDVK8HYsm7azocHYG80=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3nvKut1Row0BIAg--.43572S2;
	Fri, 20 Jun 2025 09:21:51 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: ast@kernel.org,
	qmo@qmon.net,
	alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH v3] bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure
Date: Fri, 20 Jun 2025 09:21:33 +0800
Message-Id: <20250620012133.14819-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAADnVQLy0_FsjRLt2n9R0Rs90VvLQYbkSiji6usaoB_bf4+tYg@mail.gmail.com>
References: <CAADnVQLy0_FsjRLt2n9R0Rs90VvLQYbkSiji6usaoB_bf4+tYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3nvKut1Row0BIAg--.43572S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW5Xry7WF18XFWrJr1UKFg_yoW8tFy3pa
	y7Ga40yr15WF1ru34kAa1rZFW3Cw1xKrs5Gr43G3y8Cw15Wrn3uF18KFyFvFs0gFyrWFy2
	yr1FkF9rXF1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEb18DUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiJxdyvWhUsxR6vgAAsg

From: Yuan Chen <chenyuan@kylinos.cn>

In function dump_xx_nlmsg(), when realloc() fails to allocate memory,
the original pointer to the buffer is overwritten with NULL. This causes
a memory leak because the previously allocated buffer becomes unreachable
without being freed.

Fixes: 7900efc19214 ("tools/bpf: bpftool: improve output format for bpftool net")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/net.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 64f958f437b0..cfc6f944f7c3 100644
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
-			sizeof(struct ip_devname_ifindex));
-		if (!netinfo->devices)
+		tmp = realloc(netinfo->devices,
+			(netinfo->array_len + 16) * sizeof(struct ip_devname_ifindex));
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


