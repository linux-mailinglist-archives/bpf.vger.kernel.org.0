Return-Path: <bpf+bounces-13052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C87D3F8E
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 20:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0818B20DCB
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07349219EE;
	Mon, 23 Oct 2023 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Qe05ygXP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69911E536
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 18:50:32 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFC5B7
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ldb/NgMXobJ5unjqhGryQstjIG8Ij4txzKYuMm9IX3Q=; b=Qe05ygXP9L+ch9M0t7PR2Rjugf
	ohtlVh3f/FAe4oTodYPdDI/+d/nFSMJMUBP+uIjSqOjAhEBkoV52HRW+N/2SfMUGxC/KOkWm3Icao
	lX4hekz5m90UgFZ+sd2mJgMJeip1B4LgQOkLB/xDCKTmg89QrMyKOS+ZIKw7aTWM1F1MB77+VDtCr
	ZuDqDsMxh22SsnjiPOIDBsZaTUQadGWnUrg9YiW5A4SBZl2YBeZ95MlF4JlLvgZZADanO0DXfO573
	0CqBkgvY1jDwXdpNP8nap0xwSOyFvefLDwwj+QDM00XPAEXSuJ/+mynPHxZQR0R752r1Sr7K8/Qwd
	GOibSXbQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qv00S-0008CE-Ju; Mon, 23 Oct 2023 20:50:29 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf, tcx: Get rid of tcx_link_const
Date: Mon, 23 Oct 2023 20:50:15 +0200
Message-Id: <20231023185015.21152-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27070/Mon Oct 23 09:53:01 2023)

Small clean up to get rid of the extra tcx_link_const() and only retain
the tcx_link().

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/net/tcx.h | 7 +------
 kernel/bpf/tcx.c  | 4 ++--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/net/tcx.h b/include/net/tcx.h
index 264f147953ba..04be9377785d 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -38,16 +38,11 @@ static inline struct tcx_entry *tcx_entry(struct bpf_mprog_entry *entry)
 	return container_of(bundle, struct tcx_entry, bundle);
 }
 
-static inline struct tcx_link *tcx_link(struct bpf_link *link)
+static inline struct tcx_link *tcx_link(const struct bpf_link *link)
 {
 	return container_of(link, struct tcx_link, link);
 }
 
-static inline const struct tcx_link *tcx_link_const(const struct bpf_link *link)
-{
-	return tcx_link((struct bpf_link *)link);
-}
-
 void tcx_inc(void);
 void tcx_dec(void);
 
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 1338a13a8b64..2e4885e7781f 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -250,7 +250,7 @@ static void tcx_link_dealloc(struct bpf_link *link)
 
 static void tcx_link_fdinfo(const struct bpf_link *link, struct seq_file *seq)
 {
-	const struct tcx_link *tcx = tcx_link_const(link);
+	const struct tcx_link *tcx = tcx_link(link);
 	u32 ifindex = 0;
 
 	rtnl_lock();
@@ -267,7 +267,7 @@ static void tcx_link_fdinfo(const struct bpf_link *link, struct seq_file *seq)
 static int tcx_link_fill_info(const struct bpf_link *link,
 			      struct bpf_link_info *info)
 {
-	const struct tcx_link *tcx = tcx_link_const(link);
+	const struct tcx_link *tcx = tcx_link(link);
 	u32 ifindex = 0;
 
 	rtnl_lock();
-- 
2.34.1


