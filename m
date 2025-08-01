Return-Path: <bpf+bounces-64883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F0FB18181
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3387D1C819B7
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE1239E91;
	Fri,  1 Aug 2025 12:16:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95182F5E;
	Fri,  1 Aug 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050584; cv=none; b=bncAylxJaihiI6op610GJWau+kNeJtGfl1bWwfq2wIpyB7AInWk07LM9qMvayRxrTbh5zwMRDnjKbiqD32xUp1CuFxYYgJSqt3vSMu7+BwhfIb3JEsqhX1mYSEOi2a+stTo0phxwWyAYsHxYsRfchsT8TY5GgbnVbaotnWihjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050584; c=relaxed/simple;
	bh=6TkzO5IMfH9XS263uhqkmrlysg/E4l0LLEMK3msA0Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQpfbbtd6ru6Wvtm3BEKp5UXh8IJUKqGlub6iqPpvoHUoRrJ5zkA+AF7g5UEsi81mVWYJyN9K8OsqG4gIRHUr1i2wrFnCdAwrjVVEnvSv74MmtGODWPhOHog9Y6nH9WUOxXaWC3DuFSA1feeoFUuPGWYba47+leyD8FS3nXIzIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next] bpf: Add LINK_DETACH for iter and perf links
Date: Fri,  1 Aug 2025 14:10:53 +0200
Message-ID: <20250801121053.7495-1-dev@der-flo.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

73b11c2a introduced LINK_DETACH and implemented it for some link types,
like xdp, netns and others.

This patch implements LINK_DETACH for perf and iter links, re-using
existing link release handling code.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/bpf/bpf_iter.c | 7 +++++++
 kernel/bpf/syscall.c  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 0cbcae727079..823dad09735d 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -397,6 +397,12 @@ static void bpf_iter_link_release(struct bpf_link *link)
 		iter_link->tinfo->reg_info->detach_target(&iter_link->aux);
 }
 
+static int bpf_iter_link_detach(struct bpf_link *link)
+{
+	bpf_iter_link_release(link);
+	return 0;
+}
+
 static void bpf_iter_link_dealloc(struct bpf_link *link)
 {
 	struct bpf_iter_link *iter_link =
@@ -490,6 +496,7 @@ static int bpf_iter_link_fill_link_info(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_iter_link_lops = {
 	.release = bpf_iter_link_release,
+	.detach = bpf_iter_link_detach,
 	.dealloc = bpf_iter_link_dealloc,
 	.update_prog = bpf_iter_link_replace,
 	.show_fdinfo = bpf_iter_link_show_fdinfo,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e63039817af3..e89694f6874a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3733,6 +3733,12 @@ static void bpf_perf_link_release(struct bpf_link *link)
 	fput(perf_link->perf_file);
 }
 
+static int bpf_perf_link_detach(struct bpf_link *link)
+{
+	bpf_perf_link_release(link);
+	return 0;
+}
+
 static void bpf_perf_link_dealloc(struct bpf_link *link)
 {
 	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
@@ -4027,6 +4033,7 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
+	.detach = bpf_perf_link_detach,
 	.dealloc = bpf_perf_link_dealloc,
 	.fill_link_info = bpf_perf_link_fill_link_info,
 	.show_fdinfo = bpf_perf_link_show_fdinfo,
-- 
2.50.1


