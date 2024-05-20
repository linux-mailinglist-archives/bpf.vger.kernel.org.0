Return-Path: <bpf+bounces-30063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D38CA533
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5227CB22356
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F44C3D0;
	Mon, 20 May 2024 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWoln1em"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6591847
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248843; cv=none; b=BcaWHsPTVa7nU5DD/L4nCcjHK/uZJ7FuT2+yoDmh662RaRcjyCExyrzAva6HGbj/q5AMFsPAqoDbQB/F02Y/XgniMg+8navueyIg60iSyAl/TPdsFHKZK7eu+7tyiqmoGVMgrOUbKT9PT/ox0Z5Pyef8cbh8csx35GYCwu3SOls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248843; c=relaxed/simple;
	bh=efqNQL5MJWmI3QYbHIpybM1u1sNTpySCgQB2p86Wv/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dud1kKIQ28/vAaXge992Z3r7fGIMWptchlqfC6FaxPghwa+IQk1vjW1BLKGNl6uFLDqhIk0GV5e6clIv4GLK9bsGvNIKsK2oLPsyPr9DxIYTL2vyVR4GU+e7RPFsMazB8mmfAfq8KOERZzIEpTOe2x/aeQ4GD4+9tvq7/bDm98Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWoln1em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8A7C2BD10;
	Mon, 20 May 2024 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716248843;
	bh=efqNQL5MJWmI3QYbHIpybM1u1sNTpySCgQB2p86Wv/w=;
	h=From:To:Cc:Subject:Date:From;
	b=oWoln1emoFkoFi5QYF75y4NEY4GUz3PetFifI+VqA4GCa52al521QuquyyT0XjM0t
	 /r21sBESBe7kalD6X10esqx2R2/LsCABt308gqCSVn6Pi/a85amMCypwy93GXf6MkC
	 XP7gsy2p52ljtguAarqo2aO2b7G8c2egDePqIcPY3lcHea8ldxy7jpRaOvh23iUvYN
	 fXvUZ7KWTel8xW1pfx4CwfSnqCUEKNe1pZhLxUXvFwfQPLaq3DXpMqTXZB9g+IijZR
	 wBtF9da/c+QeYZ1Xv5TuNrsxoxG+6EdoNEoWMBiI4cWQyc005M5K6eF1LVXe7dw76l
	 Ea9y/OuskjLHA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 0/5] Fix BPF multi-uprobe PID filtering logic
Date: Mon, 20 May 2024 16:47:15 -0700
Message-ID: <20240520234720.1748918-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It turns out that current implementation of multi-uprobe PID filtering logic
is broken. It filters by thread, while the promise is filtering by process.
Patch #1 fixes the logic trivially. The rest is testing and mitigations that
are necessary for libbpf to not break users of USDT programs.

Andrii Nakryiko (5):
  bpf: fix multi-uprobe PID filtering logic
  bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe
    attach logic
  libbpf: detect broken PID filtering logic for multi-uprobe
  selftests/bpf: extend multi-uprobe tests with child thread case
  selftests/bpf: extend multi-uprobe tests with USDTs

 kernel/trace/bpf_trace.c                      |  10 +-
 tools/lib/bpf/features.c                      |  31 ++++-
 .../bpf/prog_tests/uprobe_multi_test.c        | 131 ++++++++++++++++--
 .../selftests/bpf/progs/uprobe_multi.c        |  50 ++++++-
 4 files changed, 203 insertions(+), 19 deletions(-)

-- 
2.43.0


