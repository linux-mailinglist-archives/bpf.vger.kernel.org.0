Return-Path: <bpf+bounces-79061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF7AD253CD
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 16:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBA9130C598F
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637723AE71F;
	Thu, 15 Jan 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J22rIC9c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB03271F2
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489911; cv=none; b=F/ymgXQih08E/MuE9ANqr3A2QpkDax1BDRUQZ5bmiaX0FT2eDduti8q4RIlZ/lXdwg6zqZ1gma5YwwGQj3JS3PHHHr8dgWdxvSvjVNUYOnXQxYeLYr/0YXXEkCjXCrUkCWgi9ULsYYOOmMFhYSSZnRDTd8mrgL2wfjhfzzZAHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489911; c=relaxed/simple;
	bh=QeM0gcNthxtZOCy12/MtTB0YSYKs/bbcFgY3LIyn3AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozHXiqBm8PUe2XuHkw15oRfZh4JRiSwTvH0ayZjZM8UY1QBD//Ah8xw5LKqpzwm1SOPCbXtJCEdQIudOxLiSOLvEWzFmWky2SGTjOMDPBaqv1PJisqc4yIpqgfA45U0ZaZERcJM7N2tGO93UTRYviZOtjkhHgR3Z/nyb4lv+C2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J22rIC9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F5DC16AAE;
	Thu, 15 Jan 2026 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768489909;
	bh=QeM0gcNthxtZOCy12/MtTB0YSYKs/bbcFgY3LIyn3AA=;
	h=From:To:Cc:Subject:Date:From;
	b=J22rIC9csYtqwwtivcKbXiYLMbu7hgm7b3KRtyzmniG3GCTuOikTjgXAOJw+jztuR
	 No5bF+Gxm50Y8HRm+iDOgEMAoMvpnHsxOHV1AK5RS+Xv3VpQ+MBTgPKIBdS8K9K1Hz
	 /MZmg4RmAWngOAtoqsHXQq16bIm3NtuAP/g4d495eRoM81OEX5uAJcVjuV8rd8odHf
	 E29uNqa1AOsoyGPVcSyDAwWduAvS7KgIt/RHP2DeRkmBVdOfHzeFwRuqh6pCAw49gx
	 yKr5o93ZlX+02nl0jzwlNN75kKBGBoMxzbUfKLRUkUNJDPToCOfgePATxRqWztEV1U
	 MkWDq8Z2++B1A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/2] bpf: Fix linked register tracking
Date: Thu, 15 Jan 2026 07:11:39 -0800
Message-ID: <20260115151143.1344724-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the linked register tracking when multiple links from
the same register are created with a sync between the creation of these
links. The sync corrupts the id of the register and therefore the second
link is not created properly. See the patch description to understand
more.

The fix is to preserve the id while doing the sync similar to the off.

Puranjay Mohan (2):
  bpf: Preserve id of register in sync_linked_regs()
  selftests: bpf: Add test for multiple syncs from linked register

 kernel/bpf/verifier.c                         |  4 ++-
 .../bpf/progs/verifier_linked_scalars.c       | 33 +++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)


base-commit: 9a403a4aea32f1801a7f29b2385ec345d4faaf78
-- 
2.47.3


