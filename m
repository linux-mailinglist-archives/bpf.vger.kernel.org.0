Return-Path: <bpf+bounces-57388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7471AA9E86
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A868F17B086
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E12275113;
	Mon,  5 May 2025 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="i1VtwmnL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628D187332;
	Mon,  5 May 2025 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482380; cv=none; b=Ft/U2+a9v49eeMZo8AbpuM1wrugKQ0oSD61TwVRiTp+jokwPGB/PcJSMTay/zyt3lHK6sPF/RpK9W2FkDgFQODytKeOo7apVeJ63gvDZvr6zGA4jvE8CSYOHN3LPjJ+M99dKl22m4pAUaMZNu0DcuTX4BuJij7Ok2DTnVadsnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482380; c=relaxed/simple;
	bh=p2xEU8kJj4Nq4KhqwLGFMsBx3/btPiklo5yi6B7eOKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Optvj99HfaU/NOI8tX618WjqyUu+rmchKgbTMUJ37XnBSBQJGMkE/RIR0S0pjGtk7TzlrfsqVvdW3USypCzbrCGz8lAVQ/v9R3P2OMGfdBxexv6dFl144I2l6WHM98CpLAUq2nWBEn7+O/sX+HWqM/ZuI5+LvjKJhqRnnDZMyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=i1VtwmnL; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746482379; x=1778018379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uZa4XnC7N5rvwSXWDUdM+Gh157CJi2xhXR/N3zvSyBU=;
  b=i1VtwmnL3WyTZHc0/VaoJRGzC+w/ENFp6AiXwsov4lerS0Gp5NVW14r5
   E8gM1OIsNEUCjoreCQcLjLfPBacJTRjA963I31I38JYBXX+aSki4tOqdb
   dOn8mhJe9diHWoJlVOnLwkwx2rOHD94xoCfz+UnIv3pWGfYuvotjxpsH2
   sSoAWWWKUb3AFTyWRpu1lbIhX/AJX/bUxQgO6l4HzOaZzjSSych5oh9BM
   s6sXPgd6N103m9POlaKSQ3rGfqwZDLY8x6BdUNlfHD/iNdIAwM+28aMSA
   Tu+V1EftcxcNnv/4bweHI+gI4b0EtFdmNnmEC8MlH7uej/gYDeULOFuEy
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="197572439"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 21:59:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:20413]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id 7f39e0ad-c560-419a-b9f9-230905d6065f; Mon, 5 May 2025 21:59:36 +0000 (UTC)
X-Farcaster-Flow-ID: 7f39e0ad-c560-419a-b9f9-230905d6065f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 21:59:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 21:59:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=
	<mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	"Ondrej Mosnacek" <omosnace@redhat.com>, Casey Schaufler
	<casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: [PATCH v1 bpf-next 3/5] af_unix: Remove redundant scm->fp check in __scm_destroy().
Date: Mon, 5 May 2025 14:56:48 -0700
Message-ID: <20250505215802.48449-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505215802.48449-1-kuniyu@amazon.com>
References: <20250505215802.48449-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

__scm_destroy() is called from __scm_recv_common() or
scm_destroy(), and both of which check if scm->fp is NULL.

Let's remove the redundant scm->fp check in __scm_destroy().

While at it, we remove EXPORT_SYMBOL() for it and rename it
to scm_fp_destroy() to make the following patch clearer.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/scm.h |  5 +++--
 net/compat.c      |  2 +-
 net/core/scm.c    | 19 +++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 22bb49589fde..058688a16a63 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -53,7 +53,7 @@ struct scm_cookie {
 void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
 void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
 int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
-void __scm_destroy(struct scm_cookie *scm);
+void scm_fp_destroy(struct scm_cookie *scm);
 struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
 
 #ifdef CONFIG_SECURITY_NETWORK
@@ -84,8 +84,9 @@ static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
 static __inline__ void scm_destroy(struct scm_cookie *scm)
 {
 	scm_destroy_cred(scm);
+
 	if (scm->fp)
-		__scm_destroy(scm);
+		scm_fp_destroy(scm);
 }
 
 static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
diff --git a/net/compat.c b/net/compat.c
index 485db8ee9b28..6689a4f37bcf 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -326,7 +326,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 	 * All of the files that fit in the message have had their usage counts
 	 * incremented, so we just free the list.
 	 */
-	__scm_destroy(scm);
+	scm_fp_destroy(scm);
 }
 
 /* Argument list sizes for compat_sys_socketcall */
diff --git a/net/core/scm.c b/net/core/scm.c
index 733c0cbd393d..bef8d008f910 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -130,20 +130,19 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 	return num;
 }
 
-void __scm_destroy(struct scm_cookie *scm)
+void scm_fp_destroy(struct scm_cookie *scm)
 {
 	struct scm_fp_list *fpl = scm->fp;
 	int i;
 
-	if (fpl) {
-		scm->fp = NULL;
-		for (i=fpl->count-1; i>=0; i--)
-			fput(fpl->fp[i]);
-		free_uid(fpl->user);
-		kfree(fpl);
-	}
+	scm->fp = NULL;
+
+	for (i = fpl->count - 1; i >= 0; i--)
+		fput(fpl->fp[i]);
+
+	free_uid(fpl->user);
+	kfree(fpl);
 }
-EXPORT_SYMBOL(__scm_destroy);
 
 int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 {
@@ -375,7 +374,7 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 	 * All of the files that fit in the message have had their usage counts
 	 * incremented, so we just free the list.
 	 */
-	__scm_destroy(scm);
+	scm_fp_destroy(scm);
 }
 EXPORT_SYMBOL(scm_detach_fds);
 
-- 
2.49.0


