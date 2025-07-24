Return-Path: <bpf+bounces-64275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E89B10DC2
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76576AE0B9B
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD282DFF13;
	Thu, 24 Jul 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="swNLlbMG"
X-Original-To: bpf@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452471991DD;
	Thu, 24 Jul 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367842; cv=none; b=rXp3cGikRgV/mOu1piLL9pMdkUxDFi2yRSZpB6iVIEC5vuP19kHpNzb83pUCbKhC9c2KJ4x7nplf+kJ+tJyQzmP5ngJVhGH2VLPKArHXfvSxXdNMnUogpPvvT501SB5FtFxSOx7jSa5I6DSz+FOipD/xuvPvv09r3NntY5XET5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367842; c=relaxed/simple;
	bh=Z9h8yAlhW1QxbhTulQAAnaHxjjRWDqpBTkb6se3G8bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMT5KRxlS6uBuf8ty05tSKZvHS8rjediONsA5TAKT3L2Jtkc2m2T4r9iCHlsK4I+HiCM0VoYhdQ7bYMqw89e22OD39b2bmpp3uUPZCZZRsAGm+VA1gbg9tAWHb1U0ApArp2ETqCZZYSQIvVNnmwIeJCJpB0+tDrdM4Vityw0oDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=swNLlbMG; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1753367837;
	bh=Z9h8yAlhW1QxbhTulQAAnaHxjjRWDqpBTkb6se3G8bY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=swNLlbMGxEWLkX7wuIW3meVxfxjDBZeXp2Hu6zbhXvjqeZFsFfwNad7hE2vBoSsmm
	 9wUvve0zxy5HHuuCOGN/REnc6hr1dc5hx0orOHMfNSdQHgpCYEe9grC0kb/sqs1WoY
	 AvEpgKGcBa9mtco1UHv1zwiJmalQilK27csdxCuo=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 1EC481C035A;
	Thu, 24 Jul 2025 10:37:17 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/3] bpf: make bpf_key an opaque type
Date: Thu, 24 Jul 2025 10:34:26 -0400
Message-ID: <20250724143428.4416-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724143428.4416-1-James.Bottomley@HansenPartnership.com>
References: <20250724143428.4416-1-James.Bottomley@HansenPartnership.com>
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


