Return-Path: <bpf+bounces-40488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C7398948B
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AB92811E3
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00C14D6EE;
	Sun, 29 Sep 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIsS4/iZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD43CF6A;
	Sun, 29 Sep 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727602278; cv=none; b=Dt8jbjN8H8K6w7THYGqZ8n47SalQv+PGdfN1svzpdBLlHE04ml76vlwEzbOQeBX7d7hHYvRwrsUf4jvURvQX5QWl2JlU3FT9Pg2BpJ9Od0F7qJpycCJpOwNl+qJ1xtC5wXVXT93aXcFHVE9F4aOspdWInwIb2Dw/342zIy6Pj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727602278; c=relaxed/simple;
	bh=1QtNEJ0qw4oxe75cbYLASOSc6BQCu8RhthtnE0JuaMY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X6x0arMvhkhR7WVwMYqr893nBzZNY55OIeBq3ic2BB/M0lCI68yXDU0e+SihpoXzJAWYBHb0jJ2bxz8S8DzQ4tJP+ae6km0SdWnphFpatUyVS4Y2LRZVUg0C1P0YOnW1yP2nTexcfvPMvLgxf5tT9I+FD6q8fUzX/7LbVp6hq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIsS4/iZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 546D1C4CEC5;
	Sun, 29 Sep 2024 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727602278;
	bh=1QtNEJ0qw4oxe75cbYLASOSc6BQCu8RhthtnE0JuaMY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OIsS4/iZbb5Ghg/C50bzPBIrfs1B8I1wZ6ckOxBS1qqheme3EhjbwzLPIm0SPobZs
	 XmnXg3e9dKCifQ8aIEf3dO8QRxp49TM82WQBVHFeMTlEVyMyamZmlSyMdINKP3LBdb
	 wMjqgIic+hRBHLBRYF6ymbqnHIV70l+DNWVeKUoOa0KFHBsRQVJgK3pRSUGtqFdp+Y
	 INBO21obICgubD3RjDWgqagVNOzYIvfOhWzZe/yEcUxSRoyoHsy8nF+IYBm41nf08V
	 5kb4HJqcbWrO9UEouzIo6/Y7KlM5TgC42mFGlulQbbGeWkElAYfrlUv0BxovsDjKP/
	 NMNqR6ahfXQIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D22CF6498;
	Sun, 29 Sep 2024 09:31:18 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Subject: [PATCH bpf-next v2 0/2] BPF static linker: fix failure when
 encountering duplicate extern functions
Date: Sun, 29 Sep 2024 17:31:13 +0800
Message-Id: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEe+WYC/4WNQQ6CMBBFr0Jm7Rg6ggor72FYUDqVidqSFgiGc
 HcrF3D58v9/f4XIQThCna0QeJYo3iWgQwZd37oHo5jEQDkVeUUVvkTrwaKZBuRl5ODQTq6LeL0
 oW+jWkCKCtB4CW1l28x1+C5fq0KSklzj68NkvZ7Xnf+2zwhyNVaXV5lxSqW992z1P4fj2DM22b
 V9G6MjTyQAAAA==
X-Change-ID: 20240929-libbpf-dup-extern-funcs-871f4bad2122
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=1QtNEJ0qw4oxe75cbYLASOSc6BQCu8RhthtnE0JuaMY=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGk/5VK0KvnlzI51P/H58F1/7ZFpV/9n54i6XN3ofbtCM
 OHs8e47HaUsDGJcDLJiiixbDv9RS9Dv3rSEe045zBxWJpAhDFycAjCRrl8M/zTP3o4yvbR+8ac3
 /CtOn3/lVNWcudR2E2vNwXPs/z0YBaMYGRZZzzLV3bX+ljeTmJB6XoGE5AqdxMfsCXlC+QrVvCq
 v2QA=
X-Developer-Key: i=i@hack3r.moe; a=openpgp;
 fpr=3A7A1F5A7257780C45A9A147E1487564916D3DF5
X-Endpoint-Received: by B4 Relay for i@hack3r.moe/default with auth_id=225
X-Original-From: Eric Long <i@hack3r.moe>
Reply-To: i@hack3r.moe

Currently, if `bpftool gen object` tries to link two objects that
contains the same extern function prototype, libbpf will try to get
their (non-existent) size by calling bpf__resolve_size like extern
variables and fail with:

	libbpf: global 'whatever': failed to resolve size of underlying type: -22

This should not be the case, and this series adds conditions to update
size only when the BTF kind is not function.

Fixes: a46349227cd8 ("libbpf: Add linker extern resolution support for functions and global variables")
Signed-off-by: Eric Long <i@hack3r.moe>
---
Changes in v2:
- Fix compile errors. Oops!
- Link to v1: https://lore.kernel.org/r/20240929-libbpf-dup-extern-funcs-v1-0-df15fbd6525b@hack3r.moe

---
Eric Long (2):
      libbpf: do not resolve size on duplicate FUNCs
      selftests/bpf: make sure linking objects with duplicate extern functions doesn't fail

 tools/lib/bpf/linker.c                             | 23 ++++++++++++----------
 tools/testing/selftests/bpf/Makefile               |  3 ++-
 .../selftests/bpf/prog_tests/dup_extern_funcs.c    |  9 +++++++++
 .../selftests/bpf/progs/dup_extern_funcs1.c        | 20 +++++++++++++++++++
 .../selftests/bpf/progs/dup_extern_funcs2.c        | 18 +++++++++++++++++
 5 files changed, 62 insertions(+), 11 deletions(-)
---
base-commit: 93eeaab4563cc7fc0309bc1c4d301139762bbd60
change-id: 20240929-libbpf-dup-extern-funcs-871f4bad2122

Best regards,
-- 
Eric Long <i@hack3r.moe>



