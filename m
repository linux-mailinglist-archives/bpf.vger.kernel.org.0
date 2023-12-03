Return-Path: <bpf+bounces-16552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C4B80278B
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 21:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E361C2097D
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047BE1799E;
	Sun,  3 Dec 2023 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/icPfWI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB50DDCD
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 20:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E664C433C8;
	Sun,  3 Dec 2023 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701636537;
	bh=/5zreeq7QK1Ra/mJQixmlYHMxA2+MV9/meNc9OrdgGA=;
	h=From:To:Cc:Subject:Date:From;
	b=j/icPfWIysFbTV/GCiZkC1h2THX9bRTYApSENUW6Ir0Lq20tCW8HRCcRstuwrSt/g
	 C+lNtf8XJe4tQQSpW56cUISPzywhq2hML/2FIXGbnBtrxDyCsWdfHOxHgTQ3vhbCO3
	 ddgxAWaJVrcAsNVMWefFd3ac/SrFjRnrxdDK71QBHPuUpscskqoudrvR9onZH6Y6ig
	 QCuxS7SUQ6frnEgWhC/9rDaZ+zXDF+vWXtGEx9/iRwxyks/D4l7LlV0+FtXZF8AaF3
	 Qml8i6hD65krYW/ATB/Do6ZrFpY9fzr00vpBLoY4CyrS6X3shnmW9q7W24UEaHeuLH
	 tTHDgodigV3Sg==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf 0/2] bpf: Fix map poke update
Date: Sun,  3 Dec 2023 21:48:49 +0100
Message-ID: <20231203204851.388654-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset fixes the issue reported in [0].

v3 changes:
  - moving the update logic to arch function
  - added test [Ilya]

thanks,
jirka


[0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
---
Jiri Olsa (2):
      bpf: Fix prog_array_map_poke_run map poke update
      selftests/bpf: Add test for early update in prog_array_map_poke_run

 arch/x86/net/bpf_jit_comp.c                            | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/arraymap.c                                  | 58 ++++++++++------------------------------------------------
 tools/testing/selftests/bpf/prog_tests/tailcall_poke.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tailcall_poke.c      | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_poke.c

