Return-Path: <bpf+bounces-26130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1567A89B54B
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 03:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E71B20BF2
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 01:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07FB10FF;
	Mon,  8 Apr 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk8iyvka"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525A7F8;
	Mon,  8 Apr 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540202; cv=none; b=Yt6ncnv0K/hpYkoPeF6TvjCibIDyvVdHMk58a74u/qyJJRDytLghoVJQFmqmxRTWW2juoS1WobDpBsH2zH3pnm9hvPrY0Rk4Wzl3gbcOi3vVr6CRNPC4iWStIRz+1XrHvR4Bqwh/NpJh57G73OVR2MdvMNgMaQqXTVyr/uPQN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540202; c=relaxed/simple;
	bh=IHq4y9EX7UnQSbnemSt2T8xjhTbkd0hzM6rsmw8kpXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T9cHoibr9aHLzSGYi/K95B3PS0uBJ2iNszgBS0eJKQlAnfpoRRBFfiaxcptuoWitnPMNHIlxz5ELy1bmNou45oenqMPbFg4yPWRQ8Ayn/mWd9n8tBFDwRDqm/dcMtOrS4UUj6ND8PrsMYxPnIsgapfqk92j8MZ5HKFtBZY/Z4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk8iyvka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB55AC433F1;
	Mon,  8 Apr 2024 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540201;
	bh=IHq4y9EX7UnQSbnemSt2T8xjhTbkd0hzM6rsmw8kpXo=;
	h=From:To:Cc:Subject:Date:From;
	b=mk8iyvkai74Mhr07KQrNahS1T7G0XCpRzYAKehkWlGy9OwDfhT24+DfyGFVGJvh2J
	 Pyxx5gEWCb1DxO3Z6F55yuriTkGyWEQnU+IbdffLgk73Fc2aOZaqQ4CP33ONbRAAfJ
	 rHQFsA8XJS5ZbAHABhSB+eVd1SqlRqqkHNYyK76JYYPyBu0SY/PvVHbxPXla14T/fS
	 1bV5UvfR7QiY68fQZV8HxYnpbBj/HHhPm/vEZBySLNpY4FxzTLMdPmt1eMl8rROP2a
	 MdGwlhN9yVR7PYxbjKH6XxpMMUmP+mFeR0/Hb8Q+z/519F+zB4ZnJkG+UDsEQfykCx
	 6E/BrzcvW8xLA==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v3 0/2] Add F_SETFL for fcntl
Date: Mon,  8 Apr 2024 09:36:28 +0800
Message-Id: <cover.1712539403.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two fixes for test_sockmap:

Patch 1, v3 of "selftests/bpf: Add F_SETFL for fcntl":
- detect nonblock flag automaticly, then test_sockmap can run in both
block and nonblock modes.
- use continue instead of again in v2.

Patch 2, fix for umount cgroup2 error.

Geliang Tang (2):
  selftests/bpf: Add F_SETFL for fcntl in test_sockmap
  selftests/bpf: Fix umount cgroup2 error in test_sockmap

 tools/testing/selftests/bpf/test_sockmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.40.1


