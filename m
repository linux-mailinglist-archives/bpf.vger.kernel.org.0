Return-Path: <bpf+bounces-20778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB5842E92
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 22:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D78B286330
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589C762DE;
	Tue, 30 Jan 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIus7uUo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A7762CE
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649629; cv=none; b=JAmC54pIzqhxrU1Q3jmBc0gtAssGf2Drzxj8ecfZ/+O1o2ezN77Lj7CA4s7nSrxM+Sz7HO4CIbv48pkA+sH8DjOp6Utu9rTAw0LAbmK8oJGC3HjQl2gBF8zAZzhsouVxxUyP9A59lSF2qlw0LQF4NVSHiVgDk8FeSW1cHXJtKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649629; c=relaxed/simple;
	bh=G2V3F4nQ2iQDrpGMmK2biF7uXsatc6gpImLKSgLCUrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NU3rHXt+bl66+sX/ZK8ooXVQ+/kToPMLibohtUxrEnwBHskYCC0Inv3JR83Sd7+tKsQNXINMscK+jzR1M5vYvKwRwOOene6N1xgEFQOLq04AU54Nz6rAtNGdZnv0ylsrnqSTcX19kD/gslkZCcjx9bPG9t+ftx1T6CbKMXB3gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIus7uUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDDBC433C7;
	Tue, 30 Jan 2024 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706649628;
	bh=G2V3F4nQ2iQDrpGMmK2biF7uXsatc6gpImLKSgLCUrQ=;
	h=From:To:Cc:Subject:Date:From;
	b=rIus7uUoEx4SojaYn96xGsmyFdBCaXA5ClVx1kYQiklp0A9ue1KEtBDMbFlbk81Ot
	 g780J54zJLQLG3EhvFS8TOGOTJDjC8GJLKVtGM/7ag0S4Cn8zPXb1whHO7YSRQkrEU
	 ozLhB+ydPmf9KA5ZmTLbANvKaBuNxs4hC5M8r610el8f4Y77bg4JNUrJsNRprYJxN+
	 NKgiBbOrntC5Xuow0J/PC26bhwKU4l++KbPfbeWUCTeV5NnrYVYO65oZ1piqVRV+Jd
	 4NXP7EnhbeiHTiOxBClKkKQttX2gCGuz79CVdwPiRKIkt6QDuYH2eRujTqVGTde5sM
	 GzJ9rE/0ZeXCg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/2] libbpf: add bpf_core_cast() helper
Date: Tue, 30 Jan 2024 13:20:21 -0800
Message-Id: <20240130212023.183765-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_core_cast(<ptr>, <type>) macro wrapper around bpf_rdonly_cast() kfunc
to make it easier to use this functionality in BPF code. See patch #2 for
BPF selftests conversions demonstrating improvements in code succinctness.

Andrii Nakryiko (2):
  libbpf: add bpf_core_cast() macro
  selftests/bpf: convert bpf_rdonly_cast() uses to bpf_core_cast() macro

 tools/lib/bpf/bpf_core_read.h                       | 13 +++++++++++++
 tools/testing/selftests/bpf/bpf_kfuncs.h            |  2 +-
 .../testing/selftests/bpf/progs/connect_unix_prog.c |  3 +--
 .../selftests/bpf/progs/getpeername_unix_prog.c     |  3 +--
 .../selftests/bpf/progs/getsockname_unix_prog.c     |  3 +--
 .../testing/selftests/bpf/progs/recvmsg_unix_prog.c |  3 +--
 .../testing/selftests/bpf/progs/sendmsg_unix_prog.c |  3 +--
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c  |  4 +---
 tools/testing/selftests/bpf/progs/sock_iter_batch.c |  4 ++--
 tools/testing/selftests/bpf/progs/type_cast.c       | 13 +++++--------
 10 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.34.1


