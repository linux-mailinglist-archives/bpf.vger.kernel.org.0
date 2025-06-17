Return-Path: <bpf+bounces-60813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6687DADCD34
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 15:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2CA3A47F0
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82628C03B;
	Tue, 17 Jun 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VlH7XHGh"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49462E7166;
	Tue, 17 Jun 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166710; cv=none; b=PPIV95ouBg0xaRLvDXllZXxLwgNol1gt/vY6SgYp62SNPrkIcRUoonNV7kGo9wM7eZqgY676gG+8h3W2HFuxz5cp9d+fjbXunoG6CjHsPIOxreKZ8TH57r1Uy4d/HfKzdNOBjrsSBGMU2H2MXnUjv1tl8MwEL/enzTMmKqrjAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166710; c=relaxed/simple;
	bh=RmrrBUhQK/F0CR0LTZYtJ33BjAy7vBJTZYBL3luAHGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+lgremawxQl5B4gsJDLALrzd0sboHuj9nUJZ00yHMx/x6MQT1quAHx4Ld/cBuNedQg4IpmJMfw7t2zWqRaxanWo6Ntb8srjnkeE2ZAfw3erGPvv7HeTUrc1WjgougtpfjIW7l202e+6NBr3ZGqOCR/JPGHSPQ7dPZiOWb2RMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VlH7XHGh; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lm
	pbemX3u8079iJRrn/7u7HJzynrGfcLLZNVkf7/pEk=; b=VlH7XHGhIZJoG2XeeV
	Qv7gR9lnDdsUNLetlA/CnUdRLwiixlcHU0OLcBPMlLEy+96Gs+yXIAE0qjz9CGex
	ZtKf9NneNPVIKM/2Qeio+ABjBBmNTqkDxyuDvf24TagO+xyLHDbUmhhJzx2RkKNe
	8j96htyuFZmw8q8/Cz/kPph+Q=
Received: from 192.168.0.118 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBHOcKbbFFog+8sAA--.6914S2;
	Tue, 17 Jun 2025 21:24:45 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: qmo@kernel.org,
	ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	chenyuan_fl@163.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH v2] bpftool: Fix JSON writer resource leak in version command
Date: Tue, 17 Jun 2025 09:24:42 -0400
Message-ID: <20250617132442.9998-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBHOcKbbFFog+8sAA--.6914S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr47GrWDGr4rAryDAr1xuFg_yoWDZwcEgr
	srXr4kXrWrKrWxJw40k398urW0yayxGw4DGr17tF13JF18trsxJr1DC39Iyas8uFWUGrna
	yFs3AryfGa13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNzuAUUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiJwFvvWhRZDzGuAAAsr

From: Yuan Chen <chenyuan@kylinos.cn>

When using `bpftool --version -j/-p`, the JSON writer object
created in do_version() was not properly destroyed after use.
This caused a memory leak each time the version command was
executed with JSON output.

Fix: 004b45c0e51a (tools: bpftool: provide JSON output for all possible commands)
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
Suggested-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index cd5963cb6058..2b7f2bd3a7db 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -534,9 +534,9 @@ int main(int argc, char **argv)
 		usage();
 
 	if (version_requested)
-		return do_version(argc, argv);
-
-	ret = cmd_select(commands, argc, argv, do_help);
+		ret = do_version(argc, argv);
+	else
+		ret = cmd_select(commands, argc, argv, do_help);
 
 	if (json_output)
 		jsonw_destroy(&json_wtr);
-- 
2.44.0


