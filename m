Return-Path: <bpf+bounces-26681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0088A37C2
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D71D1F241F3
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3615216A;
	Fri, 12 Apr 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibshkohD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782B14F112;
	Fri, 12 Apr 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956592; cv=none; b=qK/AgXtq9uX7u75Yp48cDQLtEaxRHD6TAmYzkUJwRCjfBDB8xroCtK5H2Sy/JP+XRR8x/9pEHD+2rDV3Wj4+u3hZg9/sKwhjY4XoRW35NMNXL3mAgSK2whqlm+JOhBJvLjitt3P+SbVMl20Dr6cHvdRv+PU3BxRIgUuXSomB59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956592; c=relaxed/simple;
	bh=JXjQeIPnvToaq4XBL3VYo8qBVMZF3R3DIiw5BmWaoJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgxDwrhjmstcQ+e3aX2bL0kUQPz7ER1vk7o7LKsyhz5H8/+QkDHgXPyGxBTibo77hLv7DEATKm3/vCzl2pOjUVSU/6975s4v3Wh+Td6BxjCCaQDNQzt4y9GDM7UflbXIVG7DwgM3Wo+JzTlYTt/0XPmiIpnaFji6koQEA0hf7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibshkohD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADC1C3277B;
	Fri, 12 Apr 2024 21:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956591;
	bh=JXjQeIPnvToaq4XBL3VYo8qBVMZF3R3DIiw5BmWaoJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibshkohDLlblMfDzXXQ6kerdUrdOIWJkejyZHfGn4lrNeFhnEvZaok/0kKEPC/4Fi
	 eDLMUdZsK0DSII3UDjKoLlhVjEZwUJPz6Ufvq4hlutxySZ5+Z1tDy6c0NlLB+MO4Q3
	 cxj/dDYxDTZpj8flRZKD1JvHK+vX3OVHJcNl3ycfeBbWE2WN91FxEBLGpZ73hGUA4F
	 8v5Q1jxa95k5kyOOKmS79q2MC88dkP9bnvHmCOlUu6u2QEM6P+3yxfPb8bG1dS5x4t
	 4FmnGmF634U93pdZVtCYzqQzxPWssXjTCLWwCKyx8mi0cNOTnzyXtiduzXpmiujK7X
	 AQ6f9VqjDV3nA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 08/12] core: Add cus__remove(), counterpart of cus__add()
Date: Fri, 12 Apr 2024 18:16:00 -0300
Message-ID: <20240412211604.789632-9-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412211604.789632-1-acme@kernel.org>
References: <20240412211604.789632-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll switch to adding the 'struct cu' instance to the 'struct cus' list
early, under the lock, to keep the order from the original DWARF file
and then LSK_KEEPIT will just leave it there while LSK_DELETE will first
remove it from the cus list, under cus lock, to then call cu__delete().

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 13 +++++++++++++
 dwarves.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/dwarves.c b/dwarves.c
index 654a8085e9252a21..3cd300db97973ce4 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -479,6 +479,19 @@ uint32_t cus__nr_entries(const struct cus *cus)
 	return cus->nr_entries;
 }
 
+void __cus__remove(struct cus *cus, struct cu *cu)
+{
+	cus->nr_entries--;
+	list_del_init(&cu->node);
+}
+
+void cus__remove(struct cus *cus, struct cu *cu)
+{
+	cus__lock(cus);
+	__cus__remove(cus, cu);
+	cus__unlock(cus);
+}
+
 void __cus__add(struct cus *cus, struct cu *cu)
 {
 	cus->nr_entries++;
diff --git a/dwarves.h b/dwarves.h
index 42b00bc1341e66cb..9dc9cb4b074b5d33 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -173,6 +173,10 @@ int cus__load_dir(struct cus *cus, struct conf_load *conf,
 		  const int recursive);
 void __cus__add(struct cus *cus, struct cu *cu);
 void cus__add(struct cus *cus, struct cu *cu);
+
+void __cus__remove(struct cus *cus, struct cu *cu);
+void cus__remove(struct cus *cus, struct cu *cu);
+
 void cus__print_error_msg(const char *progname, const struct cus *cus,
 			  const char *filename, const int err);
 struct cu *cus__find_pair(struct cus *cus, const char *name);
-- 
2.44.0


