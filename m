Return-Path: <bpf+bounces-77949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C92CF8BF4
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 15:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1551304DAED
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B659342169;
	Tue,  6 Jan 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wjc2A8tM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279A341ADF
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707008; cv=none; b=duEIFV3GV8xDKJnTtEslTeO2MK13/CO3ciz3xMtX/lQcen6UO5lpOuKGlO7Wc1w8mt3KH047leQ+S/+efFt5RkiRm0lB5D9HBQbgAzeewoRlI5ECjKNZJHOQYmBhcKRsUftQipyTp5pV1HZOdv8376iteotypN+CfhlvlEnTWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707008; c=relaxed/simple;
	bh=32UhQmIuVg7RFlQt1JWZY3VmEmTIMShoXJksn4Mgi48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b46yGmhP3/I4/XTCPcZM3U6FteVh+pj6qNhBybF5YME36lluzzLBZh8gx/L4gvq/MOWoWGGNUU0AFG1nznq9ZHKFxkrnfJhFiABxMeEMghiQ5HbNDUZieQ12zvyze4/QFqaAyldZERY2Ui5zNzHQ0m0Hdxnfzmvg2+oAQZzT4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wjc2A8tM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLArHPeP1sDYwq27BLpCMkE5lpVuL1KHGveKa/KTPcs=;
	b=Wjc2A8tMZKcH+O2fARNOJMK3Z15c093lxWgmJERSOB+WXBixWzKsLr7dkwXXtbUsHtdwQe
	Sj4OhRlsdoVPqbgBjKSllmAUyVxW2xkOodN0o5UrkbZdsqtHfD5ey+X6yIyRC9vp84iJFe
	VUsrKDf/D/QlcfdUSSnNgygQFbxUUbo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-UZ2tysFYMMG8f5pf0ytBog-1; Tue,
 06 Jan 2026 08:43:25 -0500
X-MC-Unique: UZ2tysFYMMG8f5pf0ytBog-1
X-Mimecast-MFC-AGG-ID: UZ2tysFYMMG8f5pf0ytBog_1767707004
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D678019560A1;
	Tue,  6 Jan 2026 13:43:23 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 427151800666;
	Tue,  6 Jan 2026 13:43:19 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 09/18] rtla: Remove redundant memset after calloc
Date: Tue,  6 Jan 2026 08:49:45 -0300
Message-ID: <20260106133655.249887-10-wander@redhat.com>
In-Reply-To: <20260106133655.249887-1-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The actions struct is allocated using calloc, which already returns
zeroed memory. The subsequent memset call to zero the 'present' member
is therefore redundant.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index b50bf9f9adf28..00bbc94dec1bd 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -19,8 +19,6 @@ actions_init(struct actions *self)
 	self->len = 0;
 	self->continue_flag = false;
 
-	memset(&self->present, 0, sizeof(self->present));
-
 	/* This has to be set by the user */
 	self->trace_output_inst = NULL;
 }
-- 
2.52.0


