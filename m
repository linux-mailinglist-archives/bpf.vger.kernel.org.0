Return-Path: <bpf+bounces-57517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1503AAC71C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 15:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09224500BC9
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C1281378;
	Tue,  6 May 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFT8JOeS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14202278745;
	Tue,  6 May 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539853; cv=none; b=N9ZqtxD6UqmlBgFKVxD81yK6YsnoCVLA3vBfWTO5ymBPFK1RI6zabz1Ny135D9ZskRl5Yr0pFXiL7ETCgG6SVssU+fjpbsAt7NYnXY5Gxslqo962l0RKwNnO5PeDxXaxuoZnciuKkS51MI071ygE3pF9rIm8XVqLb8hIm70HhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539853; c=relaxed/simple;
	bh=dQIzmt892aYUR/afIpmllj9wf5bdv+cfXczV/w5bA/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHuut9aLc6WGwzgYqDGe9NMEbBTpwcKJoDi5Ii/JkxwZNWMmGUoWqpGxttubZ0NqUX7xouhbQh6lWGGdY8sIPM8V1YuYWQXqmm+hxWqCCwS9maXEcz2IMF0NhhzreAL2LbJU9WZz6jOaYRZUj6nRtJuDk0EfwbnIHCWJp3k1vzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFT8JOeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F267C4CEEB;
	Tue,  6 May 2025 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539852;
	bh=dQIzmt892aYUR/afIpmllj9wf5bdv+cfXczV/w5bA/M=;
	h=From:To:Cc:Subject:Date:From;
	b=iFT8JOeSq2v4eddsCJkyADredtuyzRbqePcblHlpI0oUipIpsfGLPWO4iWchB2tN9
	 Z+wBYCG/tBg7RP2zho/zV+QSIN967OCx37nnHi7koIt1IsaeXVpzxlcuwdS/Eg8Q2D
	 6xyPsIVknM4lpOfUgsFAWFFmm0d48QzFFaY/eTiUd71Z+phkFqQtUIjYOqCN/BvDr7
	 9rYv5VrCmvZyfkXvBOPsxdJZgS/LowUN9YoxKgW4hOzc65GbixuogFUnLrEU6YVwe/
	 U7tqOD31OhlF00NQZQv7HvZsmL3Vrd3U+ClS9NZ0f1wOUAfzOPJmxN6Ksy/JGazl26
	 T+QZVo95nFySQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 0/3] bpf: Retrieve ref_ctr_offset from uprobe perf link
Date: Tue,  6 May 2025 15:57:24 +0200
Message-ID: <20250506135727.3977467-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding ref_ctr_offset retrieval for uprobe perf link info.

thanks,
jirka


---
Jiri Olsa (3):
      bpf: Add support to retrieve ref_ctr_offset for uprobe perf link
      selftests/bpf: Add link info test for ref_ctr_offset retrieval
      bpftool: Display ref_ctr_offset for uprobe link info

 include/uapi/linux/bpf.h                                |  1 +
 kernel/bpf/syscall.c                                    |  5 +++--
 kernel/trace/trace_uprobe.c                             |  2 +-
 tools/bpf/bpftool/link.c                                |  3 +++
 tools/include/uapi/linux/bpf.h                          |  1 +
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 18 ++++++++++++++++--
 6 files changed, 25 insertions(+), 5 deletions(-)

