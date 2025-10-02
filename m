Return-Path: <bpf+bounces-70199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74711BB4648
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5581F4E1479
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85622F74E;
	Thu,  2 Oct 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="goGf1lTG"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B321348
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420158; cv=none; b=I43k8M8Jf9lt13MP0uKPcPYixKZxvB23GsqDeJLpQFztGJfJ3qg4Vf3RPVkcEAx38CCXVjvSCbaQ1TrJ1OWS2ZytTuFrQXPk2lKYjxMJnCYEgy+Uo7Yj6NAbVHtwQ3tKGEGjKGMwAVrxMQj/icp+k/KMJGPC+TWK6sCiAxvXn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420158; c=relaxed/simple;
	bh=oJ1XreLqVXi6JUSuK8wCo+so4l5JpYrQFt3TD5T36vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNzsBh/zYdXe4rkcVDomfv80FY7Bk2CyLv2Vy9jyf7ptjvBSor1iF1aDJ3PvGLYeBxpShKrHUU+D7l09/B09U+c4+JH371Zw2TyPyHJkQuFNl5gK3moVCMtJpezHqQro8Ypx/oH3NvCMGuI0PnLJXU507Zv4bQ4vyn0yGTJBtG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=goGf1lTG; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759420153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cq/ixvEwa1M7q3331DlGTSSLtBLpFmeJlg7Rcs7SewY=;
	b=goGf1lTGobUQXrSsHqU77h9DAAnvLkNByBtIxSv2h5fRQ4i09y7HPhQHio+/44ppAqcopf
	v1QWIpz4KANPG982+m2rT6DlLFiukQKFrPadOOx0dwD0CCn/nFKn/ldodRaRaOMDQbImK1
	Wm+r5GG7nIcitT7C1A3a6lszF5pyEtQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v3 00/10] bpf: Extend bpf syscall with common attributes support
Date: Thu,  2 Oct 2025 23:48:31 +0800
Message-ID: <20251002154841.99348-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This proposal builds upon the discussion in
"[PATCH bpf-next v4 0/4] bpf: Improve error reporting for freplace attachment failure"[1].

This patch set introduces support for *common attributes* in the 'bpf()'
syscall, providing a unified mechanism for passing shared metadata across
all BPF commands.

The initial set of common attributes includes:

1. 'log_buf': User-provided buffer for storing log output.
2. 'log_size': Size of the provided log buffer.
3. 'log_level': Verbosity level for logging.
4. 'log_true_size': The size of log reported by kernel.

With this extension, the 'bpf()' syscall will be able to return meaningful
error messages (e.g., failures of creating map), improving debuggability
and user experience.

Changes:
RFC v2 -> RFC v3:
* Rename probe_sys_bpf_extended to probe_sys_bpf_ext.
* Refactor reporting 'log_true_size' for prog_load.
* Refactor reporting 'btf_log_true_size' for btf_load.
* Add warnings for internal bugs in map_create.
* Check log_true_size in test cases.
* Address comment from Alexei:
  * Change kvzalloc/kvfree to kzalloc/kfree.
* Address comments from Andrii:
  * Move BPF_COMMON_ATTRS to 'enum bpf_cmd' alongside brief comment.
  * Add bpf_check_uarg_tail_zero() for extra checks.
  * Rename sys_bpf_extended to sys_bpf_ext.
  * Rename sys_bpf_fd_extended to sys_bpf_ext_fd.
  * Probe the new feature using NULL and -EFAULT.
  * Move probe_sys_bpf_ext to libbpf_internal.h and drop LIBBPF_API.
  * Return -EUERS when log attrs are conflict between bpf_attr and
    bpf_common_attr.
  * Avoid touching bpf_vlog_init().
  * Update the reason messages in map_create.
  * Finalize the log using __cleanup().
  * Report log size to users.
  * Change type of log_buf from '__u64' to 'const char *' and cast type
    using ptr_to_u64() in bpf_map_create().
  * Do not return -EOPNOTSUPP when kernel doesn't support this feature
    in bpf_map_create().
  * Add log_level support for map creation for consistency.
* Address comment from Eduard:
  * Use common_attrs->log_level instead of BPF_LOG_FIXED.

RFC v1 -> RFC v2:
* Fix build error reported by test bot.
* Address comments from Alexei:
  * Drop new uapi for freplace.
  * Add common attributes support for prog_load and btf_load.
  * Add common attributes support for map_create.

Links:
[1] https://lore.kernel.org/bpf/20250224153352.64689-1-leon.hwang@linux.dev/

Leon Hwang (10):
  bpf: Extend bpf syscall with common attributes support
  libbpf: Add support for extended bpf syscall
  bpf: Refactor reporting log_true_size for prog_load
  bpf: Add common attr support for prog_load
  bpf: Refactor reporting btf_log_true_size for btf_load
  bpf: Add common attr support for btf_load
  bpf: Add warnings for internal bugs in map_create
  bpf: Add common attr support for map_create
  libbpf: Add common attr support for map_create
  selftests/bpf: Add cases to test map create failure log

 include/linux/bpf.h                           |   2 +-
 include/linux/btf.h                           |   2 +-
 include/linux/syscalls.h                      |   3 +-
 include/uapi/linux/bpf.h                      |   8 +
 kernel/bpf/btf.c                              |  25 +-
 kernel/bpf/syscall.c                          | 250 ++++++++++++++++--
 kernel/bpf/verifier.c                         |  12 +-
 tools/include/uapi/linux/bpf.h                |   8 +
 tools/lib/bpf/bpf.c                           |  50 +++-
 tools/lib/bpf/bpf.h                           |   9 +-
 tools/lib/bpf/features.c                      |   8 +
 tools/lib/bpf/libbpf_internal.h               |   3 +
 .../selftests/bpf/prog_tests/map_init.c       | 140 ++++++++++
 13 files changed, 461 insertions(+), 59 deletions(-)

--
2.51.0


