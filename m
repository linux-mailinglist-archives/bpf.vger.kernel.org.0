Return-Path: <bpf+bounces-13265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB17D756A
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 22:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624E21C20E26
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F2C328CF;
	Wed, 25 Oct 2023 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewZ0iakY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196D328D5
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 20:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D4AC433CC;
	Wed, 25 Oct 2023 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698265466;
	bh=b8YYn5Lv5K5zSiFuXcSBSJdjX4aYLE7CR2wKv+Xf/K4=;
	h=From:To:Cc:Subject:Date:From;
	b=ewZ0iakYuhjFpYJqNWQiEzZc0yuBct2pNWwUb7EaIgdl7hldTKNbq+K+rDZ7tJKbp
	 kq35VGg1u8VrW+G6Qt2i4MFBOqhTjUyapAodjp483sOFMzI9d8/LSINCMrU4APZbFK
	 JcedGppusWQmEcxaB1osC0yUI02DoJtN3Xlf87JyxcgaCJy4835cIZHi6j8zgWsTWg
	 ECg3Slvk5wWxFJMj8NqXjRuF+BHDXsIJqSD6ecx0YHs45pSSNBjazFlW6pp44bX63E
	 YArQGZ1xluZtirnsyoatGckLM/oRXCoGjxT5UzzCiP3S+3/nQqgixcaSbHEcHllTRs
	 IUObvwAb55HZA==
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
Subject: [PATCH bpf-next 0/6] bpf: Add link_info support for uprobe multi link
Date: Wed, 25 Oct 2023 22:24:14 +0200
Message-ID: <20231025202420.390702-1-jolsa@kernel.org>
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
 kernel/trace/bpf_trace.c                                   |  82 ++++++++++++++++++++++++++++++++-----
 tools/bpf/bpftool/link.c                                   | 102 +++++++++++++++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h                             |  10 +++++
 tools/lib/bpf/elf.c                                        |   5 ++-
 tools/lib/bpf/libbpf.c                                     |   2 +-
 tools/lib/bpf/libbpf_internal.h                            |   3 +-
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c    | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c |   2 +-
 tools/testing/selftests/bpf/progs/test_fill_link_info.c    |   6 +++
 10 files changed, 402 insertions(+), 22 deletions(-)

