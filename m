Return-Path: <bpf+bounces-74787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7891DC65D77
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD3A735F2BC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4B83376AC;
	Mon, 17 Nov 2025 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrCsJzTs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C033554D
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405805; cv=none; b=kcdRXIn4GMGN894cDqRhzj1+egbY9pBAUnQyPmTIGhNwAZBglkrP3dj7aM4gfB1Z2VYO29hItpJ0Z05/UqR9h615oiM+/qDdMzn+oXnhdjRv9I2Q4z1+QxHaeWJSTScaLnLe1fWGmSGtKGGVssHgDy6kHYPt3q/2Fcr+4mrU4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405805; c=relaxed/simple;
	bh=TGCoCAcq2y7OxivunBKMIbeWuNFR98CZQ62cm5S07F4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2v+vmsUeFtJ1MW3ctSrn1gkzXjKNxULGg+fN4rV1hpaNigy0KaGzDIAi+6xJuOnTfUiXI2jCYUQ+nvmOqkck8yGBvBl1znD0zXkTVnkzGmQAIWdtlmi/J7pTi4vsxwmTjGIEXzzXfwTG3UObqsaA4AYBPvi5zEQy1cS3IvGgKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrCsJzTs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aE5DbYVi2HZztUMg23QDXtKPFVnuO/XlPsKz1PiYi4=;
	b=YrCsJzTsgsn6dDyrJEnIpyQFULHNjN7Cpud62iFY2mcv9vQAyt3AJtUnG9opsaMqpZaxvB
	km3W7ZG525iZCEZFBj3Hs+GNRXtye4PkPmVo7nehVBRiE4y4iPCuYzIWq/sdElbQdw2Yql
	lQy+99ikQsjvMnszEws6VzBtZNw1++Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-gB1xQUfCP9WI-rotCyQuxA-1; Mon,
 17 Nov 2025 13:56:39 -0500
X-MC-Unique: gB1xQUfCP9WI-rotCyQuxA-1
X-Mimecast-MFC-AGG-ID: gB1xQUfCP9WI-rotCyQuxA_1763405798
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C0371956096;
	Mon, 17 Nov 2025 18:56:38 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4173B180049F;
	Mon, 17 Nov 2025 18:56:33 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [rtla 10/13] rtla: Remove redundant memset after calloc
Date: Mon, 17 Nov 2025 15:41:17 -0300
Message-ID: <20251117184409.42831-11-wander@redhat.com>
In-Reply-To: <20251117184409.42831-1-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
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
index 2a01ece78454c..2d153d5efdea2 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -21,8 +21,6 @@ actions_init(struct actions *self)
 	self->len = 0;
 	self->continue_flag = false;
 
-	memset(&self->present, 0, sizeof(self->present));
-
 	/* This has to be set by the user */
 	self->trace_output_inst = NULL;
 	return 0;
-- 
2.51.1


