Return-Path: <bpf+bounces-41251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B19947A4
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 13:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C971C24A59
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560791D61B5;
	Tue,  8 Oct 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpCkgrxW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F4176FA7;
	Tue,  8 Oct 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388193; cv=none; b=rBFHQ5BitMAFqrBbjRFossPatZi/AWvEkk16+ubPUDU+rCtxMr/3HQ4koPlHvzPqMXYhJfnDFJ410zhqvpMU3f9kZKX0N6mPzeivK4UKTdIwQKCr9kbE+lz/xAeFZZosC7izmNUEao/NX1+hoTGDAcbQg/xOdI/leWAivD3Bw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388193; c=relaxed/simple;
	bh=iGDe2ejC273W/b7Fx+jlcrlAtupspEtxmXufPT8YOdk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qLJ+DL9y5bSOfW9oJp9OsypNt/qVeiZxrDQW9L2pDB0O19uE/nuPKT7EU4Z7E0WH2PiV1qekZV8jtaeJ9vQu5vGx0p6OZkduAGArZAPPnTS3NaEZAoa1sdUS+VjnewJA2C13SBvfoYgDRLBGlf802jH7U4/FMvC3GluFzSEz498=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpCkgrxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52015C4CEC7;
	Tue,  8 Oct 2024 11:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728388193;
	bh=iGDe2ejC273W/b7Fx+jlcrlAtupspEtxmXufPT8YOdk=;
	h=From:To:Subject:Date:From;
	b=CpCkgrxW4yfsnx1U8XbIOizPJ+1TSW3CxWkvrXqWx5YeeCDEJ5yvftnDnhKDrRgq1
	 dXwy2sbBnWiLAfN/BgCtGc3fOaDDCaknTH7qxEWd7+0SYSrOS2Eg0Sa5F/ZvU7tmAC
	 1hKLhIlBOvW2+ZCnVTPTDEIHw49iPqURiQQc+G5XONtpFme9Ek8L+4mEEM9nWkP0O/
	 SeK5nuZJecq3HO/FQcInyD2Q7TqfmKCjE69eOq7/JT4lMlHR0WHEAqnFLsetrZJV6O
	 nALhUVjW3w1NUWvisZrGpmY0ZVo0qsd9+kGiLd8nZwFTO2Iloj0EFyKqlkNvFqx52T
	 wNbZg5Vsb637g==
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
Subject: [PATCH bpf-next v4 0/2] Implement mechanism to signal other threads
Date: Tue,  8 Oct 2024 11:49:38 +0000
Message-Id: <20241008114940.44305-1-puranjay@kernel.org>
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

Changes in v4:
v3: https://lore.kernel.org/all/20241007103426.128923-1-puranjay@kernel.org/
- Fix the selftest to make it work for big-endian archs.
- Fix a build warning on 32-bit archs.
- Some style changes and code refactors suggested by Andrii

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
 kernel/trace/bpf_trace.c                      |  52 +++++--
 .../selftests/bpf/prog_tests/send_signal.c    | 133 +++++++++++++-----
 .../bpf/progs/test_send_signal_kern.c         |  35 ++++-
 4 files changed, 175 insertions(+), 46 deletions(-)

-- 
2.40.1


