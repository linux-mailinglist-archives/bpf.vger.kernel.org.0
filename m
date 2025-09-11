Return-Path: <bpf+bounces-68163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC2AB5395D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18EC5A1312
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B393277A7;
	Thu, 11 Sep 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rZLCeYHN"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6324E4BD
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608422; cv=none; b=As20r23WfZ8L+RWPfh7uh8UKyYgxPgpbQCPS7PeZyORI0rdacdYzwzkNmP7JqWzFPsGf3n+S1lOwixOj9q7zn5OmqOE63yGEvyxZEq3eQIN0Am/C+ydvc2EJzhzK5UG2HihAUVnskod9P+NbTI1rOT4QK1ryK+DVgpdOJzb0/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608422; c=relaxed/simple;
	bh=hld816mspjFZyaw+lLe3MO5JhJCKFGXf8DMDMgOO9d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZ5G3rd2d3+t85alQQbY6kBbpmkLahHkSk/f1CP9537H5GP6d9yaz6S4m/vGP+a+l/An0p5O3oi/w5HHQ+wzBdQIZfb+TRo9q3pPKSQ65YUc7dyMEKFeXo5JU1NfVSUBSp42r/TRc7E2AQeeaCL3Qcq4PS4Ra/D+/ro45QO/olI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rZLCeYHN; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757608416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ew6NFTiJzzarNqTiniDND4hHrdgrezaJj+IqTfHOdFY=;
	b=rZLCeYHNnY89CIGJ5H+eGzwiKRfFyyhiGLtzqoaZAk9mw0WbfPbpp4JWtJFStqgrgRUGfN
	Cx6Kv3Wbr3uzTJQNvwWXH7AKflshaKvbJvdOQFcYS+t5Mz1bgk1o5+NtQP5zELhgLt0T8T
	mTc52Pfs/B2bP5Qd4lZl9jiisLPFNwA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v2 0/6] bpf: Extend bpf syscall with common attributes support
Date: Fri, 12 Sep 2025 00:33:22 +0800
Message-ID: <20250911163328.93490-1-leon.hwang@linux.dev>
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
error messages (e.g., failures of creating map), improving debuggability
and user experience.

Changes:
RFC v1 -> RFC v2:
* Fix build error reported by test bot.
* Address comments from Alexei:
  * Drop new uapi for freplace.
  * Add common attributes support for prog_load and btf_load.
  * Add common attributes support for map_create.

Links:
[1] https://lore.kernel.org/bpf/20250224153352.64689-1-leon.hwang@linux.dev/
[2] https://lore.kernel.org/bpf/20250703121521.1874196-1-dongml2@chinatelecom.cn/

Leon Hwang (6):
  bpf: Extend bpf syscall with common attributes support
  libbpf: Add support for extended bpf syscall
  bpf: Add common attr support for prog_load and btf_load
  bpf: Add common attr support for map_create
  libbpf: Add common attr support for map_create
  selftests/bpf: Add cases to test map create failure log

 include/linux/bpf.h                           |   3 +-
 include/linux/bpf_verifier.h                  |   2 +-
 include/linux/btf.h                           |   3 +-
 include/linux/syscalls.h                      |   3 +-
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/btf.c                              |  12 +-
 kernel/bpf/log.c                              |  23 +++-
 kernel/bpf/syscall.c                          | 115 ++++++++++++----
 kernel/bpf/verifier.c                         |   8 +-
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  61 ++++++++-
 tools/lib/bpf/bpf.h                           |   6 +-
 tools/lib/bpf/features.c                      |   8 ++
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/prog_tests/map_init.c       | 124 ++++++++++++++++++
 16 files changed, 341 insertions(+), 45 deletions(-)

--
2.50.1


