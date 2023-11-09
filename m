Return-Path: <bpf+bounces-14568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE887E66B9
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 10:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5581EB20DED
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA534125BB;
	Thu,  9 Nov 2023 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okmuw2R4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727911C97
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4F0C433C8;
	Thu,  9 Nov 2023 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699522123;
	bh=Q3aIWw7qExUp1r0Q7cgnXrFxSidvorHP1AtvZOB4JmE=;
	h=From:To:Cc:Subject:Date:From;
	b=okmuw2R46I1RvYk1kod1gSxTAiqsHXu5NFTvQKyeQv/uDu5hSRdlIWNxBsnHXCzFW
	 4bHki/lH5lRFvEGgaEMNCZTQzQH0EdO5fZPuVcEViNSEQVuMeWIdjUsqRsQttf947k
	 SJXTazD4ue0d+TQ3QAvjhAMnxwjl5MiB6lhZKm0CP/BfGvY4ub4voAR3UpfEQr4SPf
	 sPlra5pOB0p8SGbG8Ea0BSGmIyfxXsMj8xjlC2Az7CtuWp6ecyFZxJV9bf0itBGxZY
	 5QTuXc7ZSFtUWdOZrte41wiXxzjydd6CsHifCZ4VA5GrFyONbkBoA4NmkGgSPqGpSc
	 cI7sVAgMlwV/A==
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
Subject: [PATCHv2 bpf-next 0/6] bpf: Add link_info support for uprobe multi link
Date: Thu,  9 Nov 2023 10:28:32 +0100
Message-ID: <20231109092838.721233-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
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

v2 changes:
  - added acks
  - renamed path_max to path_size [Quentin]
  - don't fail when path_max is bigger PATH_MAX [Song]
  - asorted smaller fixes [Song,Andrii]
  - return pid in caller's namespace [Andrii]
  - use extra link fill_link_info tests [Andrii]

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

 include/uapi/linux/bpf.h                                   |  10 +++++
 kernel/trace/bpf_trace.c                                   |  83 +++++++++++++++++++++++++++++-----
 tools/bpf/bpftool/link.c                                   | 105 ++++++++++++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h                             |  10 +++++
 tools/lib/bpf/elf.c                                        |   5 ++-
 tools/lib/bpf/libbpf.c                                     |   2 +-
 tools/lib/bpf/libbpf_internal.h                            |   3 +-
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c    | 223 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c |   2 +-
 tools/testing/selftests/bpf/progs/test_fill_link_info.c    |   6 +++
 10 files changed, 410 insertions(+), 39 deletions(-)

