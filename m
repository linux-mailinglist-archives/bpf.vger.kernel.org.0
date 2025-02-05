Return-Path: <bpf+bounces-50552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7FA299C8
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1D0161CDB
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DA91FF1BA;
	Wed,  5 Feb 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Oqt7Tz6t"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A841DB34C
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782577; cv=none; b=a9AXIxMiDcuCqJsfIwGB6x3clY6gNs/hrenWMUps6uPGb88Ve2psJeqJK8YE5CQnmXLuG1NtT2Y6SYI6+myKezf523KpU3VtBbUzzUgxQoH9GHCcG7Q7xAPB0dmi2e7AharngVtEA/hE+tqd5ujsrCS1PZbdyDbu8g/kn55FV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782577; c=relaxed/simple;
	bh=ySzX8WrGAmHq3W9ob/huBNn4id3klyC6gLb4iNC3I0w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qwbxgvBR2rmUuv301BzIOFSwgJUXC70Ue6kyrSS9bMrQSdX9Fh8RNwMeDZ44z/A5z5Jgde7ZBABylL691HtDItHflbr8UD0boxxZSMFBgdlFS70wFveQAsV2Jv7izdyt0FqXTstqUb5nkevWvPHyTcSbPMEOQ72jYjXasTWWyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Oqt7Tz6t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id A632120BCAF2;
	Wed,  5 Feb 2025 11:09:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A632120BCAF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738782575;
	bh=F0i6OFDziXhy1yR8ZuTe3oX0X4Szq9C8hwDtQ8dTKYE=;
	h=From:To:Subject:Date:From;
	b=Oqt7Tz6tUoggyBaeX8EleHGJqLe2doLtKoKTWVTkJTSO/Wm0FOLHSqWBZ1qNO6qsU
	 2YopRt1HpTh5wOpSufHHB2sAex/hGdmRBdPnAAfk35K+ja922UzahbRf8196KKBDwY
	 vb7641d8lnoHuQwMTmLvrhiDum7nWyRSwdE3NzYw=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org,
	kapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	xiyou.wangcong@gmail.com,
	bboscaccy@linux.microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH 0/1] libbpf: Convert ELF notes into read-only maps
Date: Wed,  5 Feb 2025 11:06:32 -0800
Message-ID: <20250205190918.2288389-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While attempting to implement a bpf-based gatekeeper program as was
described
https://lore.kernel.org/all/20250109214617.485144-1-bboscaccy@linux.microsoft.com/T/#mb10f3112df1a66c725df9d6035c5a68c72a0eb8d
we noticed that relying on IMA and fs-verity signatures alone was
insufficient. A user with sufficient privileges could ptrace, ld
preload or poke at memory in some other way while using a signed
lskel, leaving the signature intact, allowing them to load whatever
they wished into the kernel effectively circumventing the
gatekeeper. That may be considered insecure in some scenarios.

Here we propose a very simple method of allowing metadata to be stored
in skeletons or dynamic libbpf-based loaders, by simply treating note
sections as read-only maps that are visible to the gatekeeper
program. Gatekeeper programs can then iterate the fd_array and see if
there are any relevant maps that they wish to consult. No changes to
the kernel-proper are required for this, and this should help
facilitate the implementation and design of secure bpf-based
gatekeepers, while keeping with the overall philosophy of bpf and not
enforcing any obtusive abstractions upon anyone.

Blaise Boscaccy (1):
  libbpf: Convert ELF notes into read-only maps

 tools/bpf/bpftool/gen.c | 4 ++--
 tools/lib/bpf/libbpf.c  | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.48.1


