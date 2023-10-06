Return-Path: <bpf+bounces-11581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD367BC1FE
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 00:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A1A1C20B0D
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB48450E8;
	Fri,  6 Oct 2023 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="AKPlk3eJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD494447F
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 22:07:09 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291DDBD
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=e9ZKgtPcpwhy4l51qnHu5WE1HG5Ac1wxXKJoZ81DVSg=; b=AKPlk3eJrP5cycG5z1Jx75OUrr
	mfZiEGLJj/tAXa9DB3OFp7HSx79CA69kBY13R65wb2gpmNryz2VDtvhV5zNviFqnI/M3oIRIHd0PX
	PG/A3AB+2BHe+IjgAeWQDcBzSS80mh+xxUdfYKdukhMrBFF5+EOGHsWWI7sO64W7z8gTXDcJdSu3H
	bL9lsxjbK9yaXjmRo/88necTMESAB1SJh5XeFQYIUjjXo9mE8qAZ00dRmPwuUFcQF7tABfALmXeJd
	Fuh/DkQ6VK8/Hc1apHVuXfh+5/spDRLUk9//qJ6vVYV7Ya8jLYTw9WOf6ok6060d+L9FyM8q9wNQH
	cTrf0+xA==;
Received: from 17.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qosyP-0001jt-DS; Sat, 07 Oct 2023 00:07:05 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: lmb@isovalent.com,
	martin.lau@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 2/7] bpf: Handle bpf_mprog_query with NULL entry
Date: Sat,  7 Oct 2023 00:06:50 +0200
Message-Id: <20231006220655.1653-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231006220655.1653-1-daniel@iogearbox.net>
References: <20231006220655.1653-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27053/Fri Oct  6 09:44:40 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Improve consistency for bpf_mprog_query() API and let the latter also handle
a NULL entry as can be the case for tcx. Instead of returning -ENOENT, we
copy a count of 0 and revision of 1 to user space, so that this can be fed
into a subsequent bpf_mprog_attach() call as expected_revision. A BPF self-
test as part of this series has been added to assert this case.

Suggested-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/mprog.c | 10 ++++++----
 kernel/bpf/tcx.c   |  8 +-------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index 007d98c799e2..1394168062e8 100644
--- a/kernel/bpf/mprog.c
+++ b/kernel/bpf/mprog.c
@@ -401,14 +401,16 @@ int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr __user *uattr,
 	struct bpf_mprog_cp *cp;
 	struct bpf_prog *prog;
 	const u32 flags = 0;
+	u32 id, count = 0;
+	u64 revision = 1;
 	int i, ret = 0;
-	u32 id, count;
-	u64 revision;
 
 	if (attr->query.query_flags || attr->query.attach_flags)
 		return -EINVAL;
-	revision = bpf_mprog_revision(entry);
-	count = bpf_mprog_total(entry);
+	if (entry) {
+		revision = bpf_mprog_revision(entry);
+		count = bpf_mprog_total(entry);
+	}
 	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
 		return -EFAULT;
 	if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 13f0b5dc8262..1338a13a8b64 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -123,7 +123,6 @@ int tcx_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 {
 	bool ingress = attr->query.attach_type == BPF_TCX_INGRESS;
 	struct net *net = current->nsproxy->net_ns;
-	struct bpf_mprog_entry *entry;
 	struct net_device *dev;
 	int ret;
 
@@ -133,12 +132,7 @@ int tcx_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 		ret = -ENODEV;
 		goto out;
 	}
-	entry = tcx_entry_fetch(dev, ingress);
-	if (!entry) {
-		ret = -ENOENT;
-		goto out;
-	}
-	ret = bpf_mprog_query(attr, uattr, entry);
+	ret = bpf_mprog_query(attr, uattr, tcx_entry_fetch(dev, ingress));
 out:
 	rtnl_unlock();
 	return ret;
-- 
2.34.1


