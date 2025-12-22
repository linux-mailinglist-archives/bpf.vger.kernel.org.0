Return-Path: <bpf+bounces-77291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1FCD629D
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 14:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D2F3026516
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F952C21EA;
	Mon, 22 Dec 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fuho+ybR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8B28690
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410392; cv=none; b=q73MUHhiDMpnejoW92HOMB9v2HZgz005u2gDOz6oFlbp269PxFma0pN9e+EAUO0UFC6m6m1wgJxLu4fr/rOeUXXwnQ3ZpWVx+fVexAPq/azhUTD2nB8vtpH20HIy8LXRIy//OFvSibMf0CjVwU83mSaS1Aq/RcFCt3heGGnq/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410392; c=relaxed/simple;
	bh=/iTAz4zPG+gEMI+u8h1ivV2phbGqoylUnMMvXYZAMA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/qUk9JAefey3K2bhN3hL4CVGdPZHJD+YO9VFlvohOwAr6DLcZN7WpAFdoPj4ns1gucGFtUcXP8+Me392dwd+S8wCFF4EFDuN8Z6HVNJNyuAb+hgaMPwgLpclkfkHB1k5pRw6RylPb8EMOPbun7MQwVuGMOsR57WCYJ5r3+Kirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fuho+ybR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF3EC4CEF1;
	Mon, 22 Dec 2025 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766410391;
	bh=/iTAz4zPG+gEMI+u8h1ivV2phbGqoylUnMMvXYZAMA8=;
	h=From:To:Cc:Subject:Date:From;
	b=Fuho+ybRp63ZGLkM2AAfk3iZ2a9b6TlNy5gJTTnXAmpmT23+2y5w4HupSRBeYI/16
	 ecrjcpl9dFTvinQZW5T8NrdYGfBER7GqAUx8M1L1xvbsvzNn/OdijyNYFt47f98QOu
	 sjr1Mm2iEFnfuH4iNVOUvX7WtP9pYmeHxHUN9o8IGiYEfy78e9AQJAUT0HJ7DsoM5M
	 CNX3C2a2abirbjINaMo5c7GES25ZrMU5Yp4xbTanuYa4lw3LltjF6ngIwK8uOZIw6n
	 2A+DynasC1RsA4Xn2eOFgeQwJ8e89WeKpZdcbh9S9tgrZSN65X90RJUfsRjFW9lfwY
	 Rs1L5v+TZxUBw==
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Allow calling kfuncs from raw_tp programs
Date: Mon, 22 Dec 2025 05:32:44 -0800
Message-ID: <20251222133250.1890587-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V1: https://lore.kernel.org/all/20251218145514.339819-1-puranjay@kernel.org/
Changes in V1->V2:
- Update selftests to allow success for raw_tp programs calling kfuncs.

This set enables calling kfuncs from raw_tp programs.

Puranjay Mohan (2):
  bpf: allow calling kfuncs from raw_tp programs
  selftests: bpf: fix tests with raw_tp calling kfuncs

 kernel/bpf/btf.c                                            | 1 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c             | 2 +-
 .../testing/selftests/bpf/progs/verifier_kfunc_prog_types.c | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)


base-commit: f785a31395d9cafb8b2c42c7358fad72a6463142
-- 
2.47.3


