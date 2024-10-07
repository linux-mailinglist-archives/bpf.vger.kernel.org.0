Return-Path: <bpf+bounces-41101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BAA992948
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D161C22D5A
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE9618B473;
	Mon,  7 Oct 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFPwZRZm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D71C6F47;
	Mon,  7 Oct 2024 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297287; cv=none; b=dtiAgI7iVKf3nuiskzRVNixtsxuxJvOvUR1zone4r6rGFF9Tu+1rtxutZBGNEt9hUmA5KZ+5hvdPbngJ0/4tisMToEb4Ups19OsMVKko9gsnd1Aoi+SvrVR12bqSUzedVb7MwK+fVxjRIpHGCFT5/gHNrm52auYm7WWQ+Ps2dSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297287; c=relaxed/simple;
	bh=1Z/b65UcsJmcQt7YX5f+bjsqJtDw9xKDU55kb5tf9TI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YxksIB9XfqnIVmFjyY0kKYdEiqzEnxXtBQcnWd6iIkKslcGa2P7z3xG8hhrCdG5NmU3WGZsZ4tUVZQzU2bynPalJG8nmeaLuOrP3NaOmpwIfAbkOUkReeJD8vfas5Rpy5HjRmQVt167SWBEBRwQSsBfUJPC87a7uJSFZYifHubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFPwZRZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C882C4CEC6;
	Mon,  7 Oct 2024 10:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728297286;
	bh=1Z/b65UcsJmcQt7YX5f+bjsqJtDw9xKDU55kb5tf9TI=;
	h=From:To:Subject:Date:From;
	b=bFPwZRZmADbUga6FKz94mVokC2Win9tqHAAU0HDZ3BK9UMXFphAi4ixaBEQDwAa3K
	 nxWTAEbBpJYGp0Z08qVKQ4Sc6lrxDrGl19O1DSp+eBKKej2Z4cuJcnUkXlPByJGhU2
	 DDJjzzQlbFczUIGZIFjbG9/lB8BukLFQdh0s1FoWjbiWhLib/uIpLm3ZMX4mU3DgJ/
	 7JEZVMWNdNx8zW4Kq2nZE+ceRNXgxBD4zhKX9RZR0TAMuFTBJ9CFiWGHaUczDQ3Wgo
	 /RxobnB4uLjm/3RtWqfk5TKi0Ob+ZRBqDVxQ3F5oaixL4XEQTuJsbaLsPXbqLMcaaf
	 XC8ZvumkhWt9Q==
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: [PATCH bpf-next v3 0/2] Implement mechanism to signal other threads
Date: Mon,  7 Oct 2024 10:34:24 +0000
Message-Id: <20241007103426.128923-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set implements a kfunc called bpf_send_signal_task() that is similar
to sigqueue() as it can send a signal along with a cookie to a thread or
thread group.

The send_signal selftest has been updated to also test this new kfunc under
all contexts.

Changes in v3:
v2: https://lore.kernel.org/all/20240926115328.105634-1-puranjay@kernel.org/
- make the cookie u64 instead of int.
- re use code from bpf_send_signal_common

Changes in v2:
v1: https://lore.kernel.org/bpf/20240724113944.75977-1-puranjay@kernel.org/
- Convert to a kfunc
- Add mechanism to send a cookie with the signal.

Puranjay Mohan (2):
  bpf: implement bpf_send_signal_task() kfunc
  selftests/bpf: Augment send_signal test with remote signaling

 kernel/bpf/helpers.c                          |   1 +
 kernel/trace/bpf_trace.c                      |  54 +++++--
 .../selftests/bpf/prog_tests/send_signal.c    | 133 +++++++++++++-----
 .../bpf/progs/test_send_signal_kern.c         |  35 ++++-
 4 files changed, 177 insertions(+), 46 deletions(-)

-- 
2.40.1


