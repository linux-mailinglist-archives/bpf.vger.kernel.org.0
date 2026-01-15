Return-Path: <bpf+bounces-79080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA24D26ACD
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A2E431DAF6F
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ADB3BFE31;
	Thu, 15 Jan 2026 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ih9RXDl4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC43BFE24
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497871; cv=none; b=BlMjo2OrsNGoJik3hyv1z9Zxy91C3Ay8+dvOnPnya2dvzA0NIHL5gp1S89Cu3qlVNsTk+msJQpTT2uQP9BrV0Nvwz4MfTSt/F7hMiKKOc/viV5fiLRP6SgGqY1Jy4Q1SM4F5JRDyrIxZbc3dkMDkoZ8GauPQ4ebMgvEWz9wARhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497871; c=relaxed/simple;
	bh=Bz+uG4ihYQgEbIcTlcnwXM6JGhAeN8JAQN4W01UVPoQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LDs1M0WXkYRwgn3fOoqusnLVSrtw8zDq2npjquNDP019Tbz45hDpEK+oTJUZUF1TWVxOnyc5ZGt7U6DcExRqnLIxn63jFOexA3QxXJg9KkpqC9OdVRnFFhV3sbKVq8QppV8xaaZRw4prWPEIcu7VAvUchB2HhaDjVw2XA7CsLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ih9RXDl4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768497868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ky4jWFgRwxpQvr+7HoCz9wwn+msKjIUHbJOJftuI5ig=;
	b=ih9RXDl4VzjEnPexoMoFsQyOoDGC+jBeA8qHXZNG+4fWhQkCrKC6rhhIn/Z0OXaumRqnRE
	kxaLhVv38bQAXc+ev1uOckIEZI7EKPy8/En6+Lhw8XrJZD0CatxveKA7gvRbH7P0MNscju
	M+FqpkxNj0NiCGSh010HuPj+Vvdj1Jc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-TypY81JGNUy5PN7vlKHELw-1; Thu,
 15 Jan 2026 12:24:25 -0500
X-MC-Unique: TypY81JGNUy5PN7vlKHELw-1
X-Mimecast-MFC-AGG-ID: TypY81JGNUy5PN7vlKHELw_1768497864
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0E27195608A;
	Thu, 15 Jan 2026 17:24:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D53E1800285;
	Thu, 15 Jan 2026 17:24:18 +0000 (UTC)
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
Subject: [PATCH v3 00/18] rtla: Robustness and code quality improvements
Date: Thu, 15 Jan 2026 13:31:43 -0300
Message-ID: <20260115163650.118910-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series addresses multiple issues in the rtla codebase related to
error handling, string manipulation safety, and code maintainability.
The changes improve the tool's reliability and bring the code more in
line with kernel coding practices.

The series can be broadly divided into three categories:

Bug fixes address several correctness issues: a resource leak where
opendir() was not paired with closedir() on success paths, I/O loops
that failed to handle EINTR and partial writes correctly, a missing
bounds check when indexing the softirq_name array with kernel-provided
data, improper handling of pthread_create() failures, and a loop
condition that checked a pointer instead of the character it points to.

String handling improvements replace unsafe patterns throughout the
codebase. The strncpy() function is replaced with a new strscpy()
implementation that guarantees NUL-termination and provides truncation
detection. A str_has_prefix() helper replaces verbose strncmp/strlen
patterns for prefix matching. String comparisons are tightened to use
exact matching where appropriate, preventing silent acceptance of
malformed input like "100nsx" being parsed as "100ns".

Code quality improvements reduce duplication and improve readability.
A common_threshold_handler() consolidates repeated threshold action
logic. The extract_arg() macro simplifies key=value parsing. Magic
numbers are replaced with named constants (MAX_PATH, ARRAY_SIZE), and
redundant strlen() calls are cached in local variables.

All changes have been tested with the existing rtla test suite.

Changes:

v3:
- Address v2 feedback:
  - Rename common_restart() to common_threshold_handler() to better
    reflect its purpose (Tomas Glozar).
  - Implement a proper strscpy() for safer string handling instead of
    manual buffer sizing (Steven Rostedt).
  - Remove restart_result enum in favor of simpler, direct return
    values (Tomas Glozar).
- Add several new bug fixes, including a softirq vector bounds check,
  pthread_create() failure handling, robust I/O handling for
  EINTR/partial writes, and a resource leak fix.
- Introduce str_has_prefix() helper to replace verbose strncmp/strlen
  patterns.
- Tighten string parsing to enforce exact matching and reject invalid
  suffixes (e.g., "100nsx").
- Drop patches already merged via RTLA v6.20 pull request.

v2:
- exit on memory allocation failure
- remove redundant strlen() calls
- fix possible race on condition on stop_tracing variable access
- ensure null termination on read() calls
- fix checkpatch reports
- make extract_args() an inline function
- add the usage of common_restart() in more places

Wander Lairson Costa (18):
  rtla: Exit on memory allocation failures during initialization
  rtla: Use strdup() to simplify code
  rtla: Simplify argument parsing
  rtla: Introduce common_threshold_handler() helper
  rtla: Replace magic number with MAX_PATH
  rtla: Simplify code by caching string lengths
  rtla: Add strscpy() and replace strncpy() calls
  rtla/timerlat: Add bounds check for softirq vector
  rtla: Handle pthread_create() failure properly
  rtla: Add str_has_prefix() helper function
  rtla: Use str_has_prefix() for prefix checks
  rtla: Enforce exact match for time unit suffixes
  rtla: Use str_has_prefix() for option prefix check
  rtla/timerlat: Simplify RTLA_NO_BPF environment variable check
  rtla/trace: Fix write loop in trace_event_save_hist()
  rtla/trace: Fix I/O handling in save_trace_to_file()
  rtla/utils: Fix resource leak in set_comm_sched_attr()
  rtla/utils: Fix loop condition in PID validation

 tools/tracing/rtla/src/actions.c       | 103 ++++++++++++++----------
 tools/tracing/rtla/src/actions.h       |   8 +-
 tools/tracing/rtla/src/common.c        |  65 +++++++++++-----
 tools/tracing/rtla/src/common.h        |  18 +++++
 tools/tracing/rtla/src/osnoise.c       |  28 +++----
 tools/tracing/rtla/src/osnoise_hist.c  |  22 ++----
 tools/tracing/rtla/src/osnoise_top.c   |  22 ++----
 tools/tracing/rtla/src/timerlat.c      |   5 +-
 tools/tracing/rtla/src/timerlat_aa.c   |  10 +--
 tools/tracing/rtla/src/timerlat_hist.c |  41 ++++------
 tools/tracing/rtla/src/timerlat_top.c  |  54 ++++++-------
 tools/tracing/rtla/src/timerlat_u.c    |   4 +-
 tools/tracing/rtla/src/trace.c         | 101 +++++++++++++-----------
 tools/tracing/rtla/src/trace.h         |   4 +-
 tools/tracing/rtla/src/utils.c         | 104 ++++++++++++++++++++-----
 tools/tracing/rtla/src/utils.h         |  31 +++++++-
 16 files changed, 374 insertions(+), 246 deletions(-)

-- 
2.52.0


