Return-Path: <bpf+bounces-34497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0DF92DE93
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 04:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268531F2110F
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 02:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0274D524;
	Thu, 11 Jul 2024 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdj4SV6d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57FF4F5;
	Thu, 11 Jul 2024 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720666390; cv=none; b=hORKxLsEjvoDfsu64UysBJDqwDspF0hz60JKU2Pg8k8583HwhxhtIGA9mWfidl695TRDl86E3uYOeLuhDbjCOwc7EddxUW6x1oN1GZi/u7CRwF33UD2x4V4+RbDFYLxrFZfguJ/PdHMbV7NRIA8VKT/F+EelPJkvoQnZNIHBnrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720666390; c=relaxed/simple;
	bh=r44fSjzV6vWT/nJWR3G/J3gjn/yh3TGuQwpgHd6S62Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5N07R6q4r9BZEg+XzPk6pLg6sQmC7TRHg29brcPpwjtD4Fz4jojEJbp2qjs+4wt+gWJ/pt6vYI/1JS7l8ko3yh6g2EFOlLtKaM6TRYH6HpsY2/wk+LuDCAoB66yuHDDJNwY0bP/FNN4dIUxHJCJInlFTEdFK20qsSF0qxkaUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdj4SV6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B3CC32781;
	Thu, 11 Jul 2024 02:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720666389;
	bh=r44fSjzV6vWT/nJWR3G/J3gjn/yh3TGuQwpgHd6S62Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Fdj4SV6dNy/1bqBKdWjbnS1FDR7ZKdgo4XfRHwjKzyTyKqbGvWVgluEVPmg0dzky+
	 x7XlhCo2Og7r7mVdqW3ld0FFQMt6AkrGKhelGKCHqUqIJPzJF/IsdUT9Zb9VnUZWnP
	 9WqpVdjEmvfYl+J3EOHoKoII5hrKepKrKGeXUmh0qRfEMWoWcc4TxodIKA4LP08Eo7
	 1q7GNTNv7pcQa0vzMau2DsEj2StPSbJuNn8KqpgTPOCmGRJXZWNsuRcOC7gCHmDd6v
	 5Hpkg2zywZtutkGtL2hxbt3LixbH8sT2MxQRwddgVUx3da4NJNYlJ9yaWnsSakP3Rr
	 FN8Pwxl6a5DiA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/5] use network helpers, part 9
Date: Thu, 11 Jul 2024 10:52:47 +0800
Message-ID: <cover.1720664658.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This is the 9th part of series "use network helpers" all BPF selftests
wide.

Patches 1-2 update network helpers interfaces suggested by Martin.
Patch 3 adds a new helper connect_to_addr_str() as Martin suggested
instead of adding connect_fd_to_addr_str().
Patch 4 uses this newly added helper in make_client().
Patch 5 uses make_client() in sk_lookup and drop make_socket().

Geliang Tang (5):
  selftests/bpf: Drop type of connect_to_fd_opts
  selftests/bpf: Drop must_fail from network_helper_opts
  selftests/bpf: Add connect_to_addr_str helper
  selftests/bpf: Use connect_to_addr_str in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c | 67 +++++++--------
 tools/testing/selftests/bpf/network_helpers.h |  5 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    | 10 +--
 .../selftests/bpf/prog_tests/sk_lookup.c      | 84 ++++---------------
 5 files changed, 53 insertions(+), 115 deletions(-)

-- 
2.43.0


