Return-Path: <bpf+bounces-56096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A7A9124D
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 06:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF2F7A8D28
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 04:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6811DE2AD;
	Thu, 17 Apr 2025 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOzLwVlR"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF561C3F30
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865104; cv=none; b=FcwxOe/HfqIvfuuPM0BPfcCA6Tmk+OpqAgA1xKEuJLvS2yaLbgkjPoe3trFB+MM0GvorUuiaLabicFabqrrQNilmVx2R+bfOxMt0uAhGYFsfx6RwRWvTcH6EP0J09pNlDS28wJnLz/H7gKXUv7fj1krsoWYAWi+DduhCcjY7mSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865104; c=relaxed/simple;
	bh=0PMY4l/wFczYU1d7PI1I0urv7tK+z2QT8dmsl71xo3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FznLqIigRRgfdysu7WzU9td/NxZYlQ3k51WUN2fSWjY3G19nr32Dq/oaVNn6SR/itLcstTdtcCIRmbBPco72bWeaHu1/moToJ07cFVuO43ueJlPpQGzwuh0ua+fxPfwiHQ5ljUYEKRfGlx2KazzKeiaUgHVFdVPRTGzUGOUDlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EOzLwVlR; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744865098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HQ4FE60Enno8JDHPmAHA3MKfKxpHCsP6n7uWb1Ep5QU=;
	b=EOzLwVlR0gGZlOztt7gLKWnzSOzWSALlq2oEv6+Y/D68lILeEjgXp6ILLdHxtJTWHD5rLD
	xIaR+gN/fT1kNxIs0X/TTumxo/vQAl/yqys/r77Hb9UjN/NuwTnWXofgFLWCYDxhIe4Slb
	TMgcFkeBbvrgyCQR70SSOYiV8Bvr2jE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: andrii@kernel.org,
	martin.lau@linux.dev,
	bpf@vger.kernel.org
Cc: alexis.lothore@bootlin.com,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 0/2] bpf: Fix panic in bpf_get_local_storage
Date: Thu, 17 Apr 2025 12:40:13 +0800
Message-ID: <20250417044041.252874-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The selftest I provided can reproduce a panic:
'./test_progs -a cgroup_storage_update'

When we attach a program to cgroup and if prog->aux->cgroup_storage
exists, which means the cgroup_storage map is used in the program, we
will then allocate storage by bpf_cgroup_storages_alloc() and assign it
to pl->storage.

At the end, pl->storage will be assigned to
cgrp->bpf.effective[atype]->cgroup_storage by xxx_effective_progs().

But when we attach a program without the cgroup_storage map being used
(prog->aux->cgroup_storage is empty), the cgroup_storage in struct
bpf_prog_array_item is empty.

Then, if we use BPF_LINK_UPDATE to replace the old program with a new one
that uses the cgroup_storage map, we miss the cgroup_storage being
initialized.

This causes a panic when accessing storage in bpf_get_local_storage.

Jiayuan Chen (2):
  bpf: Create cgroup storage if needed when updating link
  selftests/bpf: Add link update test for cgroup_storage

 kernel/bpf/cgroup.c                           | 24 +++++++---
 .../selftests/bpf/prog_tests/cgroup_storage.c | 45 +++++++++++++++++++
 .../selftests/bpf/progs/cgroup_storage.c      |  6 +++
 3 files changed, 70 insertions(+), 5 deletions(-)

-- 
2.47.1


