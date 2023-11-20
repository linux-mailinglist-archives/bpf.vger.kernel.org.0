Return-Path: <bpf+bounces-15362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92547F167E
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 15:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AACA1F24D35
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2F1C698;
	Mon, 20 Nov 2023 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqginl3L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8081C2BB
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 14:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F1BC433C8;
	Mon, 20 Nov 2023 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700492205;
	bh=Nh36ocvg8GauaMIy7YUgadLrZbmioc9ZXetNDodAXZE=;
	h=From:To:Cc:Subject:Date:From;
	b=nqginl3LrTnnGSrjN2J+6srY7RV5XVMpeiniBIDg+8rJGa2tZeUKWyxny8nN8cmm+
	 Xf8b4eEIM3PdJxN59KpyXzASGI5rKsiZQ9z7xzEEkCmr6pz5YftV1sCW4/7U7BSBOI
	 B3Gw1azXvJujgFxys8G1pC0x7LDoQNCnGhnMmiWZtJa6GxJ2NCPnIUMCNzMxZvC9w9
	 ovd2YBrs4DvPRX+Y9eefDxEHmGCMY9iYQ4DG7BaBsCgt7vey8YfcBaKYlfejCWhbB1
	 fhK91w6vKuWxfXOpNMEq1fJn+RfohqetVOEMja59n1R1kzj5ccALTRFZL7kWPZL6Ld
	 f1xTAswOXhn/w==
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
Subject: [PATCHv3 bpf-next 0/6] bpf: Add link_info support for uprobe multi link
Date: Mon, 20 Nov 2023 15:56:33 +0100
Message-ID: <20231120145639.3179656-1-jolsa@kernel.org>
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

v3 changes:
  - allow to return offset/ref_ctr_offset/cookies independently
    and changed the test accordingly [Andrii]
  - use path_size also as out argument [Andrii]

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
 kernel/trace/bpf_trace.c                                   |  86 +++++++++++++++++++++++++++++-----
 tools/bpf/bpftool/link.c                                   | 105 ++++++++++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h                             |  10 ++++
 tools/lib/bpf/elf.c                                        |   5 +-
 tools/lib/bpf/libbpf.c                                     |   2 +-
 tools/lib/bpf/libbpf_internal.h                            |   3 +-
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c    | 235 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c |   2 +-
 tools/testing/selftests/bpf/progs/test_fill_link_info.c    |   6 +++
 10 files changed, 425 insertions(+), 39 deletions(-)

