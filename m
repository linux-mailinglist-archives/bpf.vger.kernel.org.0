Return-Path: <bpf+bounces-74793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E0C660EE
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6864A35D9C8
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D330BF70;
	Mon, 17 Nov 2025 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUZzIs//"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FE283FCF
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409903; cv=none; b=Ln9WebG7JQvXenEu/QP7xW9lZl5tTitDe3cagLSvljHNY5G15V6FzpoOYmdLyImQgXrkYiZ2wwdoeTdKv91tyi1uDvjfWB8CB6li/gx+0QdXlLWiGK0uOUs+hows4msviCPGsNkRqOe/vYvlUuZ7HxGkyKVDb27DpMgYsMumQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409903; c=relaxed/simple;
	bh=cLYJI8Tthujbbiv/8gLZscsd3VwQ1TxzrfqJ565Kxhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBAxT1d0zmUskOKt1A2HiQugsye+nKsUwUyRpdbROJ+OuGH8/dzsBAMe1VPgy9jW0Wrvy2VrGFcJOXySDZ1Tn7J8JyvmfQ654GoYttCdUQx8zY+C+mkMCUB3qrAUtX0LSWbsQ9tzXfnOXwqyaj0lU6N30S7ce0hUs1dSJimllLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUZzIs//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34D0C113D0;
	Mon, 17 Nov 2025 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763409901;
	bh=cLYJI8Tthujbbiv/8gLZscsd3VwQ1TxzrfqJ565Kxhk=;
	h=From:To:Cc:Subject:Date:From;
	b=OUZzIs//Td1TFZvTYmbRMXZfSl7c1mwSE1DH9yrbnhXU1KF+KfP1EdEmwgeT1/XIR
	 XwZsZ7FyK6xhAM6hGvDtfU4qneUSIO31lW/7FfCggUFfOV5+x04AynY6fkCVoRG3ma
	 3CARhNXD2VSZXjqv8XnqpKr5sNRIDmMwTmp0ZR5L4wkon4veGl8EQF2LkGnEVLQ5jl
	 2yXzt1IMWzGkGu5ZB8r1XRVhqqEjfdpNF88a95QR/u/UkODczuShk1fiyeBBz6xzV6
	 OS6aHnSZz62XqhqP/eT6yS5/vJwQfM28nGuXHM2RLw1aiT8Gee0Bung9iDQ0puJuBN
	 Io6z7wNcdhrDw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 0/2] bpf: Nested rcu critical sections
Date: Mon, 17 Nov 2025 20:04:08 +0000
Message-ID: <20251117200411.25563-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/bpf/20250916113622.19540-1-puranjay@kernel.org/
Changes in v1->v2:
- Move the addition of new tests to a separate patch (Alexei)
- Avoid incrementing active_rcu_locks at two places (Eduard)

Support nested rcu critical sections by making the boolean flag
active_rcu_lock a counter and use it to manage rcu critical section
state. bpf_rcu_read_lock() increments this counter and
bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
happens when active_rcu_locks drops to 0.

Puranjay Mohan (2):
  bpf: support nested rcu critical sections
  selftests: bpf: Add tests for unbalanced rcu_read_lock

 include/linux/bpf_verifier.h                  |  2 +-
 kernel/bpf/verifier.c                         | 47 +++++++++----------
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  4 +-
 .../selftests/bpf/progs/rcu_read_lock.c       | 40 ++++++++++++++++
 4 files changed, 66 insertions(+), 27 deletions(-)

-- 
2.47.1


