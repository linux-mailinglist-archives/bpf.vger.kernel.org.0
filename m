Return-Path: <bpf+bounces-19886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B54A0832846
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E85B22843
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173C4C60C;
	Fri, 19 Jan 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1vFuRd9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E74C605
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662314; cv=none; b=u7pDvmTedg1nrDqZ7/zHmc5yMKuKIXOYqkdlBDczaPX/9a8jquOFpwc4R9suVLpBY4vxbTQYWE6AS9KY6XCtMRLOSBIWsjdjnUCs/0A/B+OMggYGPEO/0FNKe5aA0pea1mzZvPVuG8u+LwPULAMWPJDZXWGesTj275xhCY9Q1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662314; c=relaxed/simple;
	bh=ImOrnBKzadU1QDBO1C7qcTQJ+wZLPBzqkI10S4/DgLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbYAugyUtJhbaFaFf8tp2TySRNMGwKj4awHzURgPlc7agse3YIZwDFiCQ+H2HG2mry0o85vsC2lKbeK5UChOs7r2iSDOAtiX7sk0I0zApIXgZRo4oiFN6aNU5egQmhqwB5L0+Of5Hs5f2GdD8ld/fQK4fesp4NT3kg/N/yi/dKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1vFuRd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81663C433C7;
	Fri, 19 Jan 2024 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705662313;
	bh=ImOrnBKzadU1QDBO1C7qcTQJ+wZLPBzqkI10S4/DgLY=;
	h=From:To:Cc:Subject:Date:From;
	b=m1vFuRd9DZVmUri7KY4Eb3jurbF3IeRNeMQZ4s64UgJM2Ko5B3L5tZCdOu6C++jhH
	 rgWhFg/bLJS/6vR79npUYoMX4f43vkgB1n7tesd9HgSHoFiKx6bH8cvASOXu8t8Jn7
	 x6FyChzAVQIXrwxcf5ZOM2SAm5Tsx5WP283vjpb8GDRoy+he7Cx+JuJqtkbAXVds8Y
	 fgLv5wTEFL1T4gQaektIib3Uq2T65XdQDDJosfFG4t7MsYnhV1xWrNbdD1ji/qkwQ5
	 1y3ErEr4XsAxvzUDWTzH3+OH8QUMYgSRXsB4DFX3kGvhUt32SCSIgpbExj5t2dJS8u
	 tg734k0aNN9UA==
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
Subject: [PATCHv2 bpf-next 0/8] bpf: Add cookies retrieval for perf/kprobe multi links
Date: Fri, 19 Jan 2024 12:04:57 +0100
Message-ID: <20240119110505.400573-1-jolsa@kernel.org>
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

v2 changes:
 - added review/ack tags
 - fixed memory leak [Quentin]
 - align the uapi fields properly [Yafang Shao]


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

 include/uapi/linux/bpf.h                                |   7 ++++++
 kernel/bpf/syscall.c                                    |   4 ++++
 kernel/trace/bpf_trace.c                                |  15 +++++++++++++
 tools/bpf/bpftool/link.c                                |  94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 tools/include/uapi/linux/bpf.h                          |   7 ++++++
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 +++++
 7 files changed, 214 insertions(+), 33 deletions(-)

