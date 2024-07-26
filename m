Return-Path: <bpf+bounces-35736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA993D65A
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D63FB23F92
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462817BB2F;
	Fri, 26 Jul 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jQT3afoa"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E16AAD
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008486; cv=none; b=hfhyeJHgd7phzZ/Mk7+9okwhgA5AbdfUz+F7OuXsyc1owvZBlRugIJcqZbe7WpcqcblTP3Hye8T3Uyr6Mp0B7hHh/wdc2ILU0aJCm++3PPlwWFjX+/u1PhfGeteyZBC076/xKAOYI9akzkumCEZr5CDF8/CLA0uy7lGxZ82FfO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008486; c=relaxed/simple;
	bh=gSbLjibENgyrJGdvZjwGmOyHGJsRSxjKRAGPR1OT6sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=isANXpSI7r7vy7u8DFiZ32wlJhfPs61RIeUaxC9X6JbXlR0zryaYIofWxDyVsF1S21s9ptj6HK/pj9V7wldQE8g/yCDpFl/YKbq/SVWT1Wq3NkuQyyXBAY8QDyyrMgQtZO22Q0/zqYnRfqjZy0rIIh6FhtKKec577m7weODgVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jQT3afoa; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722008480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9oEnV7tIaRAVFebigBybdLGf+dpBcf6Bj6JY0bVp51E=;
	b=jQT3afoaLgivvbh+0iFfLZfftviWNYXhHL7ubCv10GnzMcyAyNoXnqJt5agiKC4iTLd+B1
	C9whZwPGnqeVima2A2YSiFoi1XDyMyUL345qIJsbOef2fUfYbMdCQtqsz78uYBDrMuKZMt
	LjsPMpKIabtAOOAUNUcsj1qI/y/E8bM=
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
Subject: [PATCH bpf-next v2 0/2] bpf: Fix updating attached freplace prog to prog_array map
Date: Fri, 26 Jul 2024 23:39:50 +0800
Message-ID: <20240726153952.76914-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit f7866c3587337731 ("bpf: Fix null pointer dereference in
resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed a NULL pointer
dereference panic, but didn't fix the issue that fails to update attached
freplace prog to prog_array map.

This patch fixes the issue.

v1 -> v2:
 * Address comments from Yonghong:
   * Check then return prog->aux->saved_dst_prog_type.
   * Remove ASSERT_GE() that checks prog_fd and map_fd.
   * Remove #include "bpf_legacy.h".
   * Fix some code style issues.

RFC PATCH -> v1:
 * Respin the PATCH with updated message.

Links:
[0] https://lore.kernel.org/bpf/20240602122421.50892-1-hffilwlqm@gmail.com/

Leon Hwang (2):
  bpf: Fix updating attached freplace prog to prog_array map
  selftests/bpf: Add testcase for updating attached freplace prog to
    prog_array map

 include/linux/bpf_verifier.h                  |  4 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 65 ++++++++++++++++++-
 .../selftests/bpf/progs/tailcall_freplace.c   | 25 +++++++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 21 ++++++
 4 files changed, 112 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c

-- 
2.44.0


