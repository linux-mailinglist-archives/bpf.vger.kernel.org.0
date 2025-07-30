Return-Path: <bpf+bounces-64733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B880AB16580
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 19:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC3B1AA45DC
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8C2E03F5;
	Wed, 30 Jul 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="stBQ8HIk"
X-Original-To: bpf@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F924B26;
	Wed, 30 Jul 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896500; cv=none; b=peTjmLLorh27SWyKRJZdsWuaSzJuGUpikOeT64u8lSnNMI+gpWurda4rIstm8ZpIh6z9mxFnQv4GSYg2o+ifGj/t5cCQVJ+sUxuKiaUhcQVR6PjEhZhjMjHc7CONtiXNeRrn0Rw4lJt7dCJMyxqKMkwS57iu8KkpA8kt6GogHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896500; c=relaxed/simple;
	bh=Z9h8yAlhW1QxbhTulQAAnaHxjjRWDqpBTkb6se3G8bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZRdNDd6r8CBosGOvYi73AARIn99ONL+3nZomXwFb0+eh21RU+416Y72cb3wYXVjtEO3PbMb1Z6C9rXy/Dr0RoGXTslXsNdkPzlDhl5sFCuZBNYuIP4pAQFSjcOgd3HcXEDsxO4tatKV9BvAPS+W/lz4pslhIvaYLIGCWz/fFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=stBQ8HIk; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1753896498;
	bh=Z9h8yAlhW1QxbhTulQAAnaHxjjRWDqpBTkb6se3G8bY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=stBQ8HIkJbzWyXnyh6TQMO+nkMwWu/Hgp7I/w0mOk8oUoyLQY7gVRtzDnib2oc5Uy
	 Fau4PigeU4PMjZj2KT7u0HN8inwHfKeE7G6RiUbqS5dJs0D8Ah9WhK+KBA2oLp+6m/
	 UO50I9RW5p+haKS7CzQkwr+InqnzSl5UptMwOEls=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id DB9671C0251;
	Wed, 30 Jul 2025 13:28:17 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 1/3] bpf: make bpf_key an opaque type
Date: Wed, 30 Jul 2025 13:27:43 -0400
Message-ID: <20250730172745.8480-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730172745.8480-1-James.Bottomley@HansenPartnership.com>
References: <20250730172745.8480-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the only consumers of struct bpf_key are bpf scripts which call
the bpf kfuncs which take struct bpf_key, only the implementing
functions in bpf_trace.c should be reaching inside this structure.
Enforce this by making the structure opaque in the header with a body
that's only defined inside bpf_trace.c

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/bpf.h      | 5 +----
 kernel/trace/bpf_trace.c | 5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..34b2df7aaf3e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3656,10 +3656,7 @@ static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
 struct key;
 
 #ifdef CONFIG_KEYS
-struct bpf_key {
-	struct key *key;
-	bool has_ref;
-};
+struct bpf_key;
 #endif /* CONFIG_KEYS */
 
 static inline bool type_is_alloc(u32 type)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae6..e7bf00d1cd05 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1242,6 +1242,11 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 };
 
 #ifdef CONFIG_KEYS
+struct bpf_key {
+	struct key *key;
+	bool has_ref;
+};
+
 __bpf_kfunc_start_defs();
 
 /**
-- 
2.43.0


