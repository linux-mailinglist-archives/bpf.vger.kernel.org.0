Return-Path: <bpf+bounces-71635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD4BF8E1E
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69789461F54
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C93283CB0;
	Tue, 21 Oct 2025 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocfK0hXj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB769281509;
	Tue, 21 Oct 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080636; cv=none; b=GnsEStrF/+ZfTmjLGpuf3Z6SgJrdy/nRmGItBkd4obHWxDIlwB0YiZRdGl9139+4b5wbQEUlPYxFnC29leIr3LEBhLKjZD53jm4Ru6YxFSTY78Pd4KzTgS9eOTucauABfx1G6BVOLlGj99AzKY4xPNG1CL7NbX8EpF0+02JWUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080636; c=relaxed/simple;
	bh=O/A7sYgHxed/PR88y0jCJjO8EnadjGl4dzz0Uf2M5O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kb8fcanwy5A3TCWHCCofzCnN/oG/OqlPV8ubUEfFC4svvvOycLdCZ3ahqiuSf/XL3Dz+47+vyX/hWa2JRVgatHspLlHcVDZTWxQIodwGI6mRaPwLKnFa25HgBbRC208rCus+s4ko/clT1x0nclOzPlO3dZcQSCwJoPMrSPbOtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocfK0hXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526C6C4CEF1;
	Tue, 21 Oct 2025 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761080635;
	bh=O/A7sYgHxed/PR88y0jCJjO8EnadjGl4dzz0Uf2M5O4=;
	h=From:To:Cc:Subject:Date:From;
	b=ocfK0hXj6fnRtTi4m0BzgELTuLmEDPQD2mkRBtswTG/EcEnnw1vPqk6EojHMj6mHp
	 aujQMR58ayKAqH/BgcurQwFK3x2AGW+qaowWEPa/k2uSEm3QGDjqWlFoJWjZhiExpx
	 62gFEoZn7qRAOepqLby8txg+uslHXoAox0Hk++1NUI3H5I/TiW4ap9P7lRtrzomrWq
	 qU71UeMqkh05V82R0XuoKD/5gDTfIHdUgAwOhoUdVt5Vh/HptYPkiTOt9hjaWj/sW4
	 IwjmGG2A8e97HSppGmVT68CoVhKQrDDEMqzbWACDyITKAFWsfV03HwXlEBkD2H5Uu5
	 FDKCq3BYkQNTg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCHSET sched_ext/for-6.19] sched_ext: Fix SCX_KICK_WAIT reliability
Date: Tue, 21 Oct 2025 11:03:52 -1000
Message-ID: <20251021210354.89570-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_KICK_WAIT is used to synchronously wait for a target CPU to complete a
reschedule, which is needed for implementing operations like core scheduling.
This broke when scx_next_task_picked() was replaced with switch_class() in
commit b999e365c298, because the sequence counter increment that SCX_KICK_WAIT
depends on was no longer reliably called.

This patchset fixes the regression by moving the sequence counter update to
put_prev_task_scx() and refining the semantics to work correctly with the
updated scheduler structure. The first patch adds a prerequisite check to
skip kicking CPUs running higher sched classes, which SCX has no control over.

Based on sched_ext/for-6.19 (2dbbdeda77a6).

 0001 sched_ext: Don't kick CPUs running higher classes
 0002 sched_ext: Fix SCX_KICK_WAIT to work reliably

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-fix-kick_wait

 kernel/sched/ext.c          | 42 ++++++++++++++++++++++++++----------------
 kernel/sched/ext_internal.h |  6 ++++--
 2 files changed, 30 insertions(+), 18 deletions(-)
--
tejun

