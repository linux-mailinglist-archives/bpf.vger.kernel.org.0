Return-Path: <bpf+bounces-64249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8EB109DF
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6771CE362B
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7BD2C1592;
	Thu, 24 Jul 2025 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBH9VhU+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A349126A1B8
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358582; cv=none; b=e7+0nvQVhzxxGks61S7skzQT96IabMwp9IOFbJnCSfeQMCZ5lMb8pYzMCymNzudEqCMNLcjCRb4Iuz2DO1cjkMXNJkTLTXwuaD3jldJrK0PkzC4oSFyrND1Ebv/8LOmVSoPQImxbYf1azHK86BANljljSrqvv0Bvm5e+jDxPtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358582; c=relaxed/simple;
	bh=t78Kqw4hWVinEOF9JVwB0tVBH+Qo3h/xm4jNhJ+Bfgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Tptd1xOjv5R7ZhXE4a+jOGZ2nJ2sVCNy0Vo8+Upq3kK0PdDHLOS9AVex8VZUBaXYnOSNrPr92L22/zHF/Ut+XDGIPhbvZAGym5cP2tMtUktIXpRklcdUuLkkaoDFGTtb/gbdcSr8lctDVdtrdkD2f/BDYyHJ4SoTDL3M0qOo3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBH9VhU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D230CC4CEED;
	Thu, 24 Jul 2025 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753358582;
	bh=t78Kqw4hWVinEOF9JVwB0tVBH+Qo3h/xm4jNhJ+Bfgw=;
	h=From:To:Subject:Date:From;
	b=jBH9VhU+Sbq5OKvNCyrVFkoF+L7A6juNosPnPWh6lzlTJ4/EiFvrLZb6VkRdjcSif
	 fvwxB5dyxLsDrnZ6d2IxkJCABIcmeHYHlFxuhmmnLDQhkAx9fnWNvSVI5+R7mkP8+l
	 MgGCCrtSDZ9fbGe5JhCiO/iJK1nJ+4FM/DfaZTi9DSuh6tpHWXWrNxhqzJ9PaTsG/s
	 93xVwFwSxvHh0pYxANbfZnK+AefguI2CUQw9y8xKZLbRv83lX5r72gHKhe4q5qScYv
	 eugw//eGRusSzny7K7ddB7/nnQuOm2zbr4X/kzWpwICG71DKYo13HTFOt3boRAIp/U
	 1fkNS8Yn1Gpow==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] bpf: Private stack support for arm64 JIT
Date: Thu, 24 Jul 2025 12:02:52 +0000
Message-ID: <20250724120257.7299-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v1->v2:
v1: https://lore.kernel.org/all/20250722173254.3879-1-puranjay@kernel.org/
- Divided the patch into 3 patches (Yonghong)
- Fixed a warning in what is now the second patch (kernel test robot)

This set enables private stack in the arm64 JIT. The Jited programs use
access the stack with the BPF FP (arm64 R25) and SP (arm64 SP). When
using the private stack, BPF FP (arm64 R25) is set to point at the top
of the private stack and SP is replaced with arm64 R27 and it points at
the bottom of private stack.

All relevant selftests are enabled in the 3rd patch and are passing for
arm64.

Note: This needs the fix in [1] to work properly.
[1] https://lore.kernel.org/all/20250722133410.54161-2-puranjay@kernel.org/

Puranjay Mohan (3):
  bpf: move bpf_jit_get_prog_name() to core.c
  bpf, arm64: JIT support for private stack
  selftests/bpf: enable private stack tests for arm64

 arch/arm64/net/bpf_jit_comp.c                 | 133 ++++++++++++++++--
 arch/x86/net/bpf_jit_comp.c                   |   9 +-
 include/linux/filter.h                        |   2 +
 kernel/bpf/core.c                             |   7 +
 .../bpf/progs/struct_ops_private_stack.c      |   2 +-
 .../bpf/progs/struct_ops_private_stack_fail.c |   2 +-
 .../progs/struct_ops_private_stack_recur.c    |   2 +-
 .../bpf/progs/verifier_private_stack.c        |  89 +++++++++++-
 8 files changed, 222 insertions(+), 24 deletions(-)

-- 
2.47.3


