Return-Path: <bpf+bounces-51750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26B3A387FB
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 16:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B218846DC
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D2224B09;
	Mon, 17 Feb 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ux2j9wn2"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDE224B03
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807042; cv=none; b=PyjhEa1YJlYHdFWsFVZDPUNLacOfXBnrj2R4okTX8XrYi5Aw2IRxi0yeZMflMrIkluM+DvjIP8EzADrIGt67CuuL3YU7kWM464GiEycoELbe9kFomexMq/BiG14Qyvp+Pxg9UtEJwInosqRr7eEIdkA3E1ZHue2lK9lgOBkKUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807042; c=relaxed/simple;
	bh=/JQ6MZFU8AqBTRcXXT4fE1prOcdk5CjlORnl30Nvov0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IvKrpfpX4EzGrglIsoVbHtjbqFaqjFmFtnvP53ziu/wWjSqhfuqfdkOfryFrr8qyZ2PFMb62UkHpYxMplGIPjnlgCmF0KspVy0wMyGSiTy23rU0Xw0fypZGIGqhiiklvlxy/LgIim1m7eIvEfkWCg30hy4i2BRMcy1+lc9dUrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ux2j9wn2; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739807038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pMr47hGOHYpvf3KREIOyYQWV8YG9CAh8U5ptMK2m+Js=;
	b=Ux2j9wn2STVUboQXBiuuKted8ZIFf+QWiiVVQcuXOVlE6345vOA7rHu2qvjTtktNXXfxa6
	MX3wsaL3BDKMWstYjGloVQ9slaSzGb8THbLIoyV00iaPO7C0xo13wAg8itFeDbUb58QI4u
	DsvFjlyxSPal6agQi2vQAIar82bleZo=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	me@manjusaka.me,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 0/4] bpf: Improve error reporting for freplace attachment failure
Date: Mon, 17 Feb 2025 23:43:14 +0800
Message-ID: <20250217154318.76145-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series improves error reporting for BPF_LINK_CREATE when
attaching freplace programs. Inspired by the discussion in
"[PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog method to
output failure logs to kernel"[0], this series enhances that freplace
attachment failure returns meaningful logs to userspace, aiding debugging.

For example, when attempting to attach a freplace program to a static
function:

libbpf: prog 'new_test_pkt_access': failed to attach to freplace: -EINVAL
libbpf: prog 'new_test_pkt_access': attach log: subprog_tail() is not a global function

Patch breakdown:
1. bpf, verifier: Add missing newline of bpf_log in bpf_check_attach_target
    * Add the missing newline in
      bpf_log(log, "Target program bound device mismatch").
2. bpf: Report log of freplace attach failure
    * Extends BPF_LINK_CREATE to report detailed error logs.
3. bpf, libbpf: Capture log of freplace attach failure
    * Modifies libbpf to capture and print attachment logs.
4. selftests/bpf: Add a test case for freplace attachment failure logging
    * Introduces a selftest to validate error reporting.

Links:
[0] https://lore.kernel.org/bpf/CAEf4BzbbyojuFSS7xQ3+jZb=dHzOaZfMbtT+WnypW2LPwOUwRw@mail.gmail.com/

Changes:
v2: https://lore.kernel.org/bpf/20240725051511.57112-1-me@manjusaka.me/
v2 -> v3:
  * Address comment from Andrii:
    * Report back the reason for declining freplace attachment instead of
      logging in dmesg.

Leon Hwang (4):
  bpf, verifier: Add missing newline of bpf_log in
    bpf_check_attach_target
  bpf: Improve error reporting for freplace attachment failure
  bpf, libbpf: Capture and log freplace attachment failure
  selftests/bpf: Add test case for freplace attachment failure logging

 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/syscall.c                          | 51 ++++++++++++++++---
 kernel/bpf/verifier.c                         |  2 +-
 tools/include/uapi/linux/bpf.h                |  2 +
 tools/lib/bpf/bpf.c                           |  6 ++-
 tools/lib/bpf/bpf.h                           |  2 +
 tools/lib/bpf/libbpf.c                        | 14 ++++-
 .../bpf/prog_tests/tracing_link_attach_log.c  | 42 +++++++++++++++
 8 files changed, 109 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c

-- 
2.47.1


