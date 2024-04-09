Return-Path: <bpf+bounces-26246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47F89D1DD
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED251C224EC
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 05:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1001A54BCB;
	Tue,  9 Apr 2024 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioKQUYED"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D09433C8;
	Tue,  9 Apr 2024 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712639934; cv=none; b=jKc8+iAOiT9TP4VxGTuloFgt6QThWyXT+h8hkkFmFA2p5g0d1YgCYWb5eUyFniLn7Ka38XLm06blVNDHikWaQWRZAF2byw/ZrCJsQGq5fUagRQ1XS9cdazGrycjj+A4FSDGWW2bvXEI0bWLRibYgWuwNDe3X4S3/G/S2B2nGlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712639934; c=relaxed/simple;
	bh=6/dzvN4J+Vk3rImc0gzHNDe/O0tVOGkHtlgYrEY/fhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YVCrEfPs9xI5uEJq3/e4j2orTLl5QqvBIc6ZGbU5sFWRClbT6ecgOwLH6jg/nQqjtXDfCpKu4XsR4xSWApHzljOh+B3VejBrPJZJvqwo2GCp2Zgy5CzKzjePBc27p1v+DZjbYNS43S7gdX41pJfqz/nsEm3U1TAvM8M5rzMn7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioKQUYED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5D1C433F1;
	Tue,  9 Apr 2024 05:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712639934;
	bh=6/dzvN4J+Vk3rImc0gzHNDe/O0tVOGkHtlgYrEY/fhw=;
	h=From:To:Cc:Subject:Date:From;
	b=ioKQUYEDbDDT4PdCB3H2aNKJGJKje03qLi6hhArV2ROrYNEfpBcj2+ymWJdPFpAGJ
	 Ka7oM0AKY8LUXBVepZyHtFJNmSA216EGG80DeJc70mjVArxB/EeiwMxUyBH+GcFWxh
	 GBqo9VEJRy+3f2zYVzQT5Bw7/Kum2qaxsxwOtyzlCyoHjxMY1bk8IC0zqfA4wvCqfs
	 GIdU/CDmAEqs1dz4H7WK4TrFxksoRT6rzHLvHGmq2318Ok5nLCDu/22jelBOnE7NdR
	 o0IA8gYjvgRuVP/92SpYzXVwPO8Rzn3VHgkJGiuyub6MquK5uyy75Z0HvDemzVU/H4
	 6mYUn68ljqYhA==
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
Subject: [PATCH bpf v4 0/2] Two fixes for test_sockmap
Date: Tue,  9 Apr 2024 13:18:38 +0800
Message-Id: <cover.1712639568.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - address Martin's comments for v3. (thanks.)
 - add Yonghong's "Acked-by" tags. (thanks.)
 - update subject-prefix from "bpf-next" to "bpf".

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


