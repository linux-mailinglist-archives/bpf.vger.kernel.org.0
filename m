Return-Path: <bpf+bounces-35827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496193E4E7
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 13:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B721C2127F
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 11:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEB38397;
	Sun, 28 Jul 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bXA3Iiol"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21252C6BB
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722167228; cv=none; b=nNCwofutD9WpsIi1QrVuGVCNMKJinhv/vpl4Q/ZuUozueTMIxX7JFp2s8n6tHsCFnYAKQxBC6LobVPzhfnHndXo+D2Ewr9HXNsxMwUnL1zy0rL2R2YJOqMVqxHjAApTrq0qk1zj/BNZcAh/jkq9Jc2kOPSgOg5B8ATNBbPPj9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722167228; c=relaxed/simple;
	bh=KQmps06cwdchemPlKgqeCwaK2UdaoDeC5dTRxOWSH8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oMmteL41IuxAG7nKUGDIrObv7EdYw6ohjEHFrn6M6ka2+VIYFQWU9Ej4NBlEFVbPl38h/gujkGEnPnKRkeFPim5ip8xw/iKGg2BqcGO1tcHVe4n8ejOK/ut7NQD1Fv7vCwiXqonD9jbCAo/Bkr5TNwptl9e0NiRK6njqIh4MDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bXA3Iiol; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722167223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m8LVquQOCbrzih3ZE6kWCM/rkd+8cGo0UTsOakRmMK4=;
	b=bXA3Iioltn6smT7ULUDvRVJzD7zMoysO9iYY7CKHLLNVtJmECTnHRQGyIT//BbUSggVjJT
	5a+PBi1Do3vtlCrmId1NXoYYzKuC4xfkMtRRKCB6u01AXrd+vcaXHfDbHcH1la5J5L6vbp
	ozL8nsPLxiASwdMIsuwQ3n+7HYY1Rrk=
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
Subject: [PATCH bpf-next v3 0/2] bpf: Fix updating attached freplace prog to prog_array map
Date: Sun, 28 Jul 2024 19:46:10 +0800
Message-ID: <20240728114612.48486-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
fixed a NULL pointer dereference panic, but didn't fix the issue that
fails to update attached freplace prog to prog_array map.

This patch fixes the issue.

v2 -> v3:
 * Address comments from Yonghong:
   * Use 12 alphanums for commit ID.
   * Keep commit subject in the same line.
   * Remove some unnecessary empty lines.

v1 -> v2:
 * Address comments from Yonghong:
   * Check then return prog->aux->saved_dst_prog_type.
   * Remove ASSERT_GE() that checks prog_fd and map_fd.
   * Remove #include "bpf_legacy.h".
   * Fix some code style issues.

RFC PATCH -> v1:
 * Respin the PATCH with updated message.

Leon Hwang (2):
  bpf: Fix updating attached freplace prog to prog_array map
  selftests/bpf: Add testcase for updating attached freplace prog to
    prog_array map

 include/linux/bpf_verifier.h                  |  4 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 65 ++++++++++++++++++-
 .../selftests/bpf/progs/tailcall_freplace.c   | 23 +++++++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 22 +++++++
 4 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c

-- 
2.44.0


