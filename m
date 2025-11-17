Return-Path: <bpf+bounces-74777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6CDC65D18
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4792229698
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C2337BB2;
	Mon, 17 Nov 2025 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNAUCwSQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99532E681
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405642; cv=none; b=ZGbkDAt3b6IXZZ0tZgLHcNNaykSNgwjtf1RwE3885NKdMkZxFaoHaMVgPGxkRqCxbrPjiYWcuG4D2zc5+tnUqW9pKEEsihC32bIIkGAM5XJVssHI+JB//3G2KzgsWmWuAduE0sMwQrekJiUrK4qvBdkt1o0IujO7Y2ELyZxcG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405642; c=relaxed/simple;
	bh=hrNHIG/nbISC8tMC+2r0pssn+cNsSvKBP5Y974zuY80=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CwSjZZYW56ZuqIwiC4e7/poq68bkmqqRf1cJBFRqzqgUKVEPd6DnGyBvhG4Z+0Teu69gn69QsUWdT5KEjz5bN6TMT5xnmZHdrC21jpmjsvTLfOjZj5gdm1bCi7mUSqgvX4F3U1unGN5a1VHxUnZNS3FcCxQGSOZc6Z6qKGjzHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNAUCwSQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UnUlTPtVR2MQD7gqFLugI5+DVwDLcxMsEM0+o58ybm4=;
	b=VNAUCwSQd+2qVZpnfI9odQOms+N8G/RZwQvMjjPIPAVW9idtyyV8SwXCd9dslGxbOUT+1i
	S5VRB3MNbH8ITqyOUEWYyvQ0bs7yO1Bdx5jlxXeeITYaQeYS8ikUePBAquRJ8CiVPgIGJJ
	Xpu/lCNHTBgYEqh9HAZWraBJRXR/JUw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-Cj-7FV4sOh-wiHweRnJHkw-1; Mon,
 17 Nov 2025 13:53:55 -0500
X-MC-Unique: Cj-7FV4sOh-wiHweRnJHkw-1
X-Mimecast-MFC-AGG-ID: Cj-7FV4sOh-wiHweRnJHkw_1763405634
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C83D1956059;
	Mon, 17 Nov 2025 18:53:54 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08B1B180049F;
	Mon, 17 Nov 2025 18:53:48 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH 0/13] rtla: Code robustness and maintainability improvements
Date: Mon, 17 Nov 2025 15:41:07 -0300
Message-ID: <20251117184409.42831-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patch series enhances the robustness and maintainability of the
RTLA (Real-Time Linux Analysis) tool through systematic improvements
to error handling, code clarity, and consistency.

The changes strengthen defensive programming practices throughout the
codebase by improving input validation and memory management. Several
new helper functions and macros are introduced to reduce code duplication
and provide safer, more readable alternatives to common operations. The
series also consolidates duplicate logic across modules and adopts
standard conventions where appropriate.

These improvements make the code more resilient and easier to maintain
while preserving existing functionality and behavior.

Wander Lairson Costa (13):
  rtla: Check for memory allocation failures
  rtla: Use strdup() to simplify code
  rtla: Introduce for_each_action() helper
  rtla: Replace atoi() with a robust strtoi()
  rtla: Simplify argument parsing
  rtla: Use strncmp_static() in more places
  rtla: Introduce timerlat_restart() helper
  rtla: Use standard exit codes for result enum
  rtla: Exit if trace output action fails
  rtla: Remove redundant memset after calloc
  rtla: Replace magic number with MAX_PATH
  rtla: Remove unused headers
  rtla: Fix inconsistent state in actions_add_* functions

 tools/tracing/rtla/src/actions.c       | 91 ++++++++++++++++++--------
 tools/tracing/rtla/src/actions.h       |  7 +-
 tools/tracing/rtla/src/osnoise.c       |  6 +-
 tools/tracing/rtla/src/osnoise_hist.c  |  1 -
 tools/tracing/rtla/src/timerlat.c      | 36 +++++++++-
 tools/tracing/rtla/src/timerlat.h      |  9 +++
 tools/tracing/rtla/src/timerlat_hist.c | 32 +++++----
 tools/tracing/rtla/src/timerlat_top.c  | 27 ++++----
 tools/tracing/rtla/src/timerlat_u.c    |  4 +-
 tools/tracing/rtla/src/trace.c         | 23 ++++---
 tools/tracing/rtla/src/utils.c         | 48 +++++++++++---
 tools/tracing/rtla/src/utils.h         | 23 +++++--
 12 files changed, 220 insertions(+), 87 deletions(-)

-- 
2.51.1


