Return-Path: <bpf+bounces-36732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5183394C751
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1991C227DE
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 23:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A415F32E;
	Thu,  8 Aug 2024 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6Iu4VWH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1211474A5
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159357; cv=none; b=JEBWigtiEisdTvnG+oZk3n1i0rUq9mv2jl+U7rES/mHU114WlV8hE05HSEyeBX5r/FKpmn8HnXWgh7hyt0vOMLG30GpM3qifay3A1Ak2qur68iFQ6fm5m+YLrHIJwF7iaZbU1W/pfPFw/BQxCchiP9pq24IQd4uR28YmDU3tgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159357; c=relaxed/simple;
	bh=Y8oLTg6tx84sxK6SdF0GXcrXCNz6nZ277c+pymvxaIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlVBn3BNqKXK7GbsnMyTFRRMxKlX+ju3/u4maK38y6qEOjW+yVuc9OgwYcXOmmRsm9SUTr6jpg9eOjPTtVPJmu5xRJ0WvGh4qIG4B6wXn1YLKUN7+n9gMcSzVpXBQlDXtwfByg8nCYSr/LrmmT2A8e9Df5hgkdxMQhqZfHiw0Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6Iu4VWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CAFC32782;
	Thu,  8 Aug 2024 23:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723159356;
	bh=Y8oLTg6tx84sxK6SdF0GXcrXCNz6nZ277c+pymvxaIA=;
	h=From:To:Cc:Subject:Date:From;
	b=K6Iu4VWHAOzYrlbmcmenvkenlHDaSksFxDxqke8olypIXrfQX3eSDuLItKrkXL3mK
	 3mVcPSzKOy09zMT2jrbQjZ2K1uHPMQ6YXrPCYqcKV0uPuDqVuflO+cX/sSU4JhfZHB
	 eVfCZ2DlGEOy/7QUX0VcqmIWK42t37a4Hlgj6EWio0BF/Mxm2dHsWquH+i+R1XqkIl
	 09heb7TrvN8ddbxUaZrsKGl2OU5uoDQMztFs4sRRSeC7xnsT83LRKyfGIPosbneXif
	 lfiU1/Np5r8DBSKPITTG+hIDXIpZinlHyH+1h/hub+h+I35FeeQPESWWs5qk+jlau4
	 5UB2feSloY3lg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: tj@kernel.org,
	void@manifault.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 0/3] Support passing BPF iterator to kfuncs
Date: Thu,  8 Aug 2024 16:22:27 -0700
Message-ID: <20240808232230.2848712-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for passing BPF iterator state to any kfunc. Such kfunc has to
declare such argument with valid `struct bpf_iter_<type> *` type and should
use "__iter" suffix in argument name, following the established suffix-based
convention. We add a simple test/demo iterator getter in bpf_testmod.

Andrii Nakryiko (3):
  bpf: extract iterator argument type and name validation logic
  bpf: allow passing struct bpf_iter_<type> as kfunc arguments
  selftests/bpf: test passing iterator to a kfunc

 include/linux/btf.h                           |  5 ++
 kernel/bpf/btf.c                              | 50 +++++++++++++------
 kernel/bpf/verifier.c                         | 35 +++++++++----
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 16 ++++--
 .../selftests/bpf/progs/iters_testmod_seq.c   | 50 +++++++++++++++++++
 5 files changed, 127 insertions(+), 29 deletions(-)

-- 
2.43.5


