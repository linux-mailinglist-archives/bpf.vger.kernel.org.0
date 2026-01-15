Return-Path: <bpf+bounces-79094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F15D274E7
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B60C316FE3C
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238653C1974;
	Thu, 15 Jan 2026 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4ykdKr0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600E3C008E
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498145; cv=none; b=U1tmcUKe1VhodUGjdcAqA6KnXGK12x5/XRXLsDsl/5VLDDhmUoFuxygvKURJ0YksED9DWFgr0j1glETcUFaO9d9RWyNN1r2/16ArMGKqEyOy//SpdC187r9Gue3lgf1yNd7wqZG4Hhpk82R3a3qxzFs8gI2kCRaLl53wfhAWTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498145; c=relaxed/simple;
	bh=kXIYufS4tBR7/9Rz8yuiI5bX9IGumrtzzuXUIzsGGoM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUAhKfVtnNM29YvtSBnHva7BfKiI71AVR29LTQL88CybGsLh2Wuhkqs1yngif/SbPnys+jU/lZkoYoP9gzKYoc69JudV3dM/tUgaYIlBFW5sa+bfQv2uLML6Id5Cb9r7ZB/mdKFk/xy+juY86Ls+KEqP/nWkmz3eVAOil4NbSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4ykdKr0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5rZ+ohXFNfCf+Ydyxx6F9YC5X8JnuneFdycbsszZyU=;
	b=R4ykdKr0ksExuY5jidO9wc8JmSWhY0h4ujijwLtXn4R28hwE5c3JGuR7ERebyHex+leXiU
	hJswQRfyKj3Rg2WNOZPsENMWCIIU9vDV1VNyGEuq+ktF/sS27IQWtbm3ZjeXH2Vyhd7Yya
	Sb4t63hMToGXBEwTbRZdA8x5DKBfcmM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-_cb9CclFOJWL4zKUMT6BVw-1; Thu,
 15 Jan 2026 12:29:01 -0500
X-MC-Unique: _cb9CclFOJWL4zKUMT6BVw-1
X-Mimecast-MFC-AGG-ID: _cb9CclFOJWL4zKUMT6BVw_1768498140
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03D1A18005AE;
	Thu, 15 Jan 2026 17:29:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74E6E18004D8;
	Thu, 15 Jan 2026 17:28:55 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 14/18] rtla/timerlat: Simplify RTLA_NO_BPF environment variable check
Date: Thu, 15 Jan 2026 13:31:57 -0300
Message-ID: <20260115163650.118910-15-wander@redhat.com>
In-Reply-To: <20260115163650.118910-1-wander@redhat.com>
References: <20260115163650.118910-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The code that checks the RTLA_NO_BPF environment variable calls
getenv() twice and uses strncmp() with a length of 2 to compare
against the single-character string "1". This is inefficient and
the comparison length is unnecessarily long.

Store the result of getenv() in a local variable to avoid the
redundant call, and replace strncmp() with strcmp() for the exact
match comparison. This follows the same pattern established in
recent commits that improved string comparison consistency
throughout the rtla codebase.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 84577daadd668..d7aeaad975386 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -28,12 +28,13 @@ int
 timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 {
 	int retval;
+	const char *const rtla_no_bpf = getenv("RTLA_NO_BPF");
 
 	/*
 	 * Try to enable BPF, unless disabled explicitly.
 	 * If BPF enablement fails, fall back to tracefs mode.
 	 */
-	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
+	if (rtla_no_bpf && strcmp(rtla_no_bpf, "1") == 0) {
 		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
 		params->mode = TRACING_MODE_TRACEFS;
 	} else if (!tep_find_event_by_name(tool->trace.tep, "osnoise", "timerlat_sample")) {
-- 
2.52.0


