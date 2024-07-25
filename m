Return-Path: <bpf+bounces-35594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF3593B9D0
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49922846E6
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332EC17F8;
	Thu, 25 Jul 2024 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wOFkrzkN"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5664428
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867589; cv=none; b=UcQX7olDvCQ941yNkXUQjByzwGTI+zHbpTqsnPDyk6F9AdfHFVhNROM9qF1gN6iBR8TgyFdulV9olMxDv+d0jAxzdMkBgHUaPkK3hJnoTEf5QGx0fTxwh8NjyWA9we+RMf+iUBFH83PB6nc7+cfmxuiIit6o5RFvWaho1rl5NeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867589; c=relaxed/simple;
	bh=I1+tLO9hH9aMFldVi/9mnByR7tCIwwxMye5ZhUIy3js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ck63eg0iHjEq+uuwWyGtdbPRwK4Mv0RMzxHVZx9h04Y9HFTmPNgLtFUFi/1O9V1ewCToUuUPJWYVWytejNPfz1JKwUnPAzPXUhDoNnafvqNkukG/avAPi1I/4q9l4DfEDVrtcPo/qZtGVhpOBW5yGw4p7/VWTb4R6PCX3nd6SFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wOFkrzkN; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721867584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O1SeRIEv3chCIzNSOIxJVIi7PUw02/5A9I5QgWDfSOY=;
	b=wOFkrzkNAAJ27KaSYuALbELP/MSdA4WoU+qEtKcDiqEuxN/YSPNXC3uxKkYB7uc7FEq3Lv
	wWcjam2nksonajh961rPuuf6NFgAzRXKirwq21+YQxA+4CbpmaNwdgJi9PxBUm5ITYsyB9
	JaakL1G04Hh5qLMmWxKyFuWIjrd1nkY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	wutengda@huaweicloud.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/2] bpf: Fix updating attached freplace prog to PROG_ARRAY map
Date: Thu, 25 Jul 2024 08:32:49 +0800
Message-ID: <20240725003251.37855-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit f7866c3587337731 ("bpf: Fix null pointer dereference in
resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed a NULL pointer panic, but
does not support my case[0] that I want to update attached freplace prog to
PROG_ARRAY map.

This patchset fixes it to support updating attached freplace prog to
PROG_ARRAY map.

[0] https://lore.kernel.org/bpf/20240602122421.50892-1-hffilwlqm@gmail.com/

RFC PATCH -> v1:
 * Respin the PATCH with updating its message.

Leon Hwang (2):
  bpf: Fix updating attached freplace prog to PROG_ARRAY map
  selftests/bpf: Add testcase for updating attached freplace prog to
    PROG_ARRAY map

 include/linux/bpf_verifier.h                  |  4 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 76 ++++++++++++++++++-
 .../selftests/bpf/progs/tailcall_freplace.c   | 33 ++++++++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 23 ++++++
 4 files changed, 133 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c

-- 
2.44.0


