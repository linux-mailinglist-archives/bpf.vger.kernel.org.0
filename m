Return-Path: <bpf+bounces-64518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A67B13D05
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C0188F5DD
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6226CE39;
	Mon, 28 Jul 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sG9k7a57"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED526CE2E
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712682; cv=none; b=UiU9d8XyWScNLc5ZSPc1HwXrGEd664VmIp6obS0NbWdNco/c62cxM7dsUkDWsq/ssLx1vOAY9fxHor/hz7pU1rBBFvSc+Ghk+wY++8mw8teGTHVX0iF+M7Ha0GL2pcK1p/2CyBYpwRcE0Fv1EsTRnu0MQic7bmVjVt/zQPbOBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712682; c=relaxed/simple;
	bh=rsB+CDMuMHxnnv5pphBkln7FnrHs2hhJH9UNqi/vYlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBcFq6s6UIm+Sf5JI5hwtXxsdEqFGU3Y4p9VwQ9L1sjaWdFJ7vdnMEzyJkicoeetxN/EslObQkcU4O5AdL45y19Z7+isPDrqmZkh9LFzx031XsZVoNyxjWOXe5juDgnTqFYOqIjVeBGsaOOsoE1BldJKivswyfQfxy1Qn7jTlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sG9k7a57; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753712677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QPiM/QhSx+glHiddBkbYNHkB7padNNwqam/AbgHmLtI=;
	b=sG9k7a57flcKuQh5nbdJavXaxBGfhDv/wwplVfuJZjqLNQuJnafgiJyRy6m68W+CNoeVcD
	8NPXZ4wMA9IuP1Yf7t0oZp/LDJlRWh1ynstUjtWM+dTBnRrdLpBoI/DZdFOuZbLJZdn6qJ
	hzYU8+Cn/knu0mfNmt3izOLpmyfzlC8=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 0/5] bpf: Extend bpf syscall with common attributes support
Date: Mon, 28 Jul 2025 22:23:41 +0800
Message-ID: <20250728142346.95681-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This proposal builds upon the discussion in
"[PATCH bpf-next v4 0/4] bpf: Improve error reporting for freplace attachment failure"[1],
and is also relevant to ongoing efforts such as tracing multi-link attach
failures[2].

This patch set introduces support for *common attributes* in the 'bpf()'
syscall, providing a unified mechanism for passing shared metadata across
all BPF commands.

The initial set of common attributes includes:

1. 'log_buf': User-provided buffer for storing log output.
2. 'log_size': Size of the provided log buffer.
3. 'log_level': Verbosity level for logging.

With this extension, the 'bpf()' syscall will be able to return meaningful
error messages (e.g., when a 'freplace' program fails to attach),
improving debuggability and user experience.

Links:
[1] https://lore.kernel.org/bpf/20250224153352.64689-1-leon.hwang@linux.dev/
[2] https://lore.kernel.org/bpf/20250703121521.1874196-1-dongml2@chinatelecom.cn/

Leon Hwang (5):
  bpf: Extend bpf syscall with common attributes support
  libbpf: Add support for extended bpf syscall
  bpf: Report freplace attach failure reason via extended syscall
  libbpf: Capture error message on freplace attach failure
  selftests/bpf: Add case to test freplace attach failure log

 include/uapi/linux/bpf.h                      |  7 +++
 kernel/bpf/syscall.c                          | 58 +++++++++++++++----
 tools/include/uapi/linux/bpf.h                |  7 +++
 tools/lib/bpf/bpf.c                           | 58 ++++++++++++++++++-
 tools/lib/bpf/bpf.h                           |  3 +
 tools/lib/bpf/features.c                      |  8 +++
 tools/lib/bpf/libbpf.c                        | 18 ++++--
 tools/lib/bpf/libbpf.h                        |  4 ++
 tools/lib/bpf/libbpf.map                      |  3 +
 tools/lib/bpf/libbpf_internal.h               |  2 +
 .../bpf/prog_tests/tracing_failure.c          | 43 ++++++++++++++
 11 files changed, 193 insertions(+), 18 deletions(-)

--
2.50.1


