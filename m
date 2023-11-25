Return-Path: <bpf+bounces-15842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA37F8DF3
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038AD1C20B00
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FB2F859;
	Sat, 25 Nov 2023 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSHPiwbz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622B28E03
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 19:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB3C433C7;
	Sat, 25 Nov 2023 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700940696;
	bh=lAmhvTMN4x46XnzKqzOmEHk7avh6GSgrgew1cc5WKbo=;
	h=From:To:Cc:Subject:Date:From;
	b=dSHPiwbzkkbwyGx3RgjRK4Xj250tHPZP0vRn4+LUp0PsJchbDbpLxE0/5bpq1M9KC
	 baZlj46gR06TJXqSJYIpqgE/w7heGlRT7Jh3i+e7HysDVrS6LzmRRNaQ0e+2cJZCQB
	 8oXjKQvwS9+/V6jxp62Vo0EziGO7XPuETXZNgRieYXTLwjEYIUNOizlDpbvycvebBs
	 uk+kGF9cw13IchMLC4mxtxDKFviDkgUJjZU3tdfYZQfJ8XyTK6QZFDU+xjHd548TLC
	 6+HWcbO3hHVKA4UQBlbeAipKPMDY02aMU1k1sQIXH87PodrMeLoLGhdlZuvlyfmCxj
	 /Tybnuaz9DOXw==
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv4 bpf-next 0/6] bpf: Add link_info support for uprobe multi link
Date: Sat, 25 Nov 2023 20:31:24 +0100
Message-ID: <20231125193130.834322-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset adds support to get bpf_link_info details for
uprobe_multi links and adding support for bpftool link to
display them.

v4 changes:
  - move flags field up in bpf_uprobe_multi_link [Andrii]
  - include zero terminating byte in path_size [Andrii]
  - return d_path error directly [Yonghong]
  - use SEC(".probes") for semaphores [Yonghong]
  - fix ref_ctr_offsets leak in test [Yonghong]
  - other smaller fixes [Yonghong]

thanks,
jirka


---
Jiri Olsa (6):
      libbpf: Add st_type argument to elf_resolve_syms_offsets function
      bpf: Store ref_ctr_offsets values in bpf_uprobe array
      bpf: Add link_info support for uprobe multi link
      selftests/bpf: Use bpf_link__destroy in fill_link_info tests
      selftests/bpf: Add link_info test for uprobe_multi link
      bpftool: Add support to display uprobe_multi links

 include/uapi/linux/bpf.h                                   |  10 ++++
 kernel/trace/bpf_trace.c                                   |  86 ++++++++++++++++++++++++++++-----
 tools/bpf/bpftool/link.c                                   | 105 +++++++++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h                             |  10 ++++
 tools/lib/bpf/elf.c                                        |   5 +-
 tools/lib/bpf/libbpf.c                                     |   2 +-
 tools/lib/bpf/libbpf_internal.h                            |   3 +-
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c    | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c |   2 +-
 tools/testing/selftests/bpf/progs/test_fill_link_info.c    |   6 +++
 10 files changed, 432 insertions(+), 39 deletions(-)

