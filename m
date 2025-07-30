Return-Path: <bpf+bounces-64755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21BB16974
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16AA18C7F3A
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 23:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6895823BCEB;
	Wed, 30 Jul 2025 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pT+PmoF8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EB2264B0
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 23:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919264; cv=none; b=YKAxLvB3FQu7mRCp7/D5IrkDZZFQIFI0QnhqNhYhJzlUlavMyBccmwMgbuYRj1sgJvsEQiuVkBTR20ZaA8GS11Xqo+5BgsOwnAHXfh33Jkcl+kwUaRi1tCKmXKxg+N1oa6DNxRQkipn+Ad0NaWXSGTmUspAjBR8mxcev6QySCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919264; c=relaxed/simple;
	bh=MDrsAPi/6KYaY23TYNsTBKt/8NaTbyULeZdZgCep01U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDkQhHmfZr+lgdgwpnDPa8QxZHRiH/7S+0jl/qJSOE3EqQKx9UsboQsYAO15OR5jUQaQiEZ4JmRYctfqmSRyPe4RBnfeluNtVu5Ow3jET1WJx4+6Iqe3E6/LOfnDpXUroU8ib7NmQqUhqVqfiPH/CeUyuq0demhWceBRNRSNHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pT+PmoF8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=LlGBIfXbRqR8Orle/Qb0WRK8vIfzdoZNvBUL6/jJpMA=; b=pT+PmoF8xWorrUyUEbL271FGc1
	AdGeoKabcY8m7ADPdNpOWKLZLcRMqxj9+XspN1aQHXR1yUtdy4lazY8ajVlQ93e0Is5zvf9I9Ssyh
	9Mtt15s7WwuYWch5Yv/chrnyiJlfsXSwFuMxuE1fJlJsp1XieyItt0uIY1xt31la5ZO7g5pnXYnxe
	UDT+0NM9IumRckRdXOiIdRf5xfud7+U6TymWZDOGmEnfoJ2DGonP8YNeYervz0YNg27XUrQoyAhfq
	QH7k4G5DrJnMqZyYSNxTXnZ1rTPvDsLYXdQt36oLD9RbaSZFcJ1a2+PNoq2fpD0CmzMvNQhS+e/A1
	/mjqg18Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uhGWE-0008QI-08;
	Thu, 31 Jul 2025 01:47:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 1/4] bpf: Add cookie object to bpf maps
Date: Thu, 31 Jul 2025 01:47:30 +0200
Message-ID: <20250730234733.530041-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27717/Wed Jul 30 18:34:37 2025)

Add a cookie to BPF maps to uniquely identify BPF maps for the timespan
when the node is up. This is different to comparing a pointer or BPF map
id which could get rolled over and reused.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h  | 1 +
 kernel/bpf/syscall.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..308530c8326b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -310,6 +310,7 @@ struct bpf_map {
 	bool free_after_rcu_gp;
 	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
+	u64 cookie; /* write-once */
 };
 
 static inline const char *btf_field_type_name(enum btf_field_type type)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e63039817af3..7a814e98d5f5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -37,6 +37,7 @@
 #include <linux/trace_events.h>
 #include <linux/tracepoint.h>
 #include <linux/overflow.h>
+#include <linux/cookie.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -53,6 +54,7 @@
 #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
 
 DEFINE_PER_CPU(int, bpf_prog_active);
+DEFINE_COOKIE(bpf_map_cookie);
 static DEFINE_IDR(prog_idr);
 static DEFINE_SPINLOCK(prog_idr_lock);
 static DEFINE_IDR(map_idr);
@@ -1487,6 +1489,10 @@ static int map_create(union bpf_attr *attr, bool kernel)
 	if (err < 0)
 		goto free_map;
 
+	preempt_disable();
+	map->cookie = gen_cookie_next(&bpf_map_cookie);
+	preempt_enable();
+
 	atomic64_set(&map->refcnt, 1);
 	atomic64_set(&map->usercnt, 1);
 	mutex_init(&map->freeze_mutex);
-- 
2.43.0


