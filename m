Return-Path: <bpf+bounces-19798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00636831639
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 10:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CED1C24E7D
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E01F946;
	Thu, 18 Jan 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUS0rKZj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC91BDFD
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571664; cv=none; b=WIYkcJUW/Gh/vAlg2Ooi6HYYRLblf9PQLpFlZynULly8mmWqDy9WCVVuUWMDwLsguuuv2+vRmXR7mY5USmoVyRMIT7axZyoI/MvLXhAy7nY/8CCHS+L1Sc3/5284lO9u9dpmR3jHjE/exdQh7o+lhgiTjak48ZUH51FDum93FYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571664; c=relaxed/simple;
	bh=OeY5n7QMXI5GehqdfTle2FrYEYbzgiqZYUek7y007qQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=sbaX6b3RXUSrJ6lZMQvZQFB+x9ExsDLFMu7lEufP+nd/8AiS1X7qxfS+w4garwaJzhQRIvB8tHJsdFsUOwL5l75G1HmZ8U4ouCsMYlbM4Q1W4DVvqrINKwHR+cUWAW684MfcY1JKseXoJmiZksCfAhSYDhfZuZZkfI3L5NYtLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUS0rKZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5502C433F1;
	Thu, 18 Jan 2024 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705571663;
	bh=OeY5n7QMXI5GehqdfTle2FrYEYbzgiqZYUek7y007qQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LUS0rKZjvZJ0desEfj+Eo5BO1bKVKUEfJA97hnpF1Lpf/6QBcD3qPEP8k/GPlxT53
	 LjTUWCZCknvkeWgJAGD0lh2OVOzRrLtvm+xd8YA+/jMldIvoukA8OgNdW4aXIPueLB
	 2vJTW42WwA7z36qACsWDyKqBMABDVRpjQZIZsYMiCIt+0sWsITTu1qgU4XrMjeinOa
	 Ru4f4FIM53cazJOFWXwCKzXHAZf8DjdCwNWFYboosKY5VDJbzeGTKGOIjRVtkc9R22
	 0pBrjeaKmABkcUwuTEGl4MU4cZW8sBl0jfutl1A7yUmQYvsLYSlRJ8aAphUxx5ZYMZ
	 uU9S2xymq/xEA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/8] bpf: Add cookies retrieval for perf/kprobe multi links
Date: Thu, 18 Jan 2024 10:54:08 +0100
Message-ID: <20240118095416.989152-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset adds support to retrieve cookies from existing tracing
links that still did not support it plus changes to bpftool to display
them. It's leftover we discussed some time ago [1].

thanks,
jirka


[1] https://lore.kernel.org/bpf/CALOAHbAZ6=A9j3VFCLoAC_WhgQKU7injMf06=cM2sU4Hi4Sx+Q@mail.gmail.com/
---
Jiri Olsa (8):
      bpf: Add cookie to perf_event bpf_link_info records
      bpf: Store cookies in kprobe_multi bpf_link_info data
      bpftool: Fix wrong free call in do_show_link
      selftests/bpf: Add cookies check for kprobe_multi fill_link_info test
      selftests/bpf: Add cookies check for perf_event fill_link_info test
      selftests/bpf: Add fill_link_info test for perf event
      bpftool: Display cookie for perf event link probes
      bpftool: Display cookie for kprobe multi link

 include/uapi/linux/bpf.h                                |   5 +++++
 kernel/bpf/syscall.c                                    |   4 ++++
 kernel/trace/bpf_trace.c                                |  15 +++++++++++++
 tools/bpf/bpftool/link.c                                |  87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 tools/include/uapi/linux/bpf.h                          |   5 +++++
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 +++++
 7 files changed, 204 insertions(+), 32 deletions(-)

