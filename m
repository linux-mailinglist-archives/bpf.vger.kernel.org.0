Return-Path: <bpf+bounces-16028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53F77FB5C6
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229C21C21115
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557F48CC0;
	Tue, 28 Nov 2023 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjrh8hhi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9652E3F2
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 09:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FE6C433C7;
	Tue, 28 Nov 2023 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701163737;
	bh=kxBNI5QVkMLYX76nh1bVOHUQSeRudTuaTCKeEv4kibU=;
	h=From:To:Cc:Subject:Date:From;
	b=Vjrh8hhiZyU9lv6pBOoXORDiNjqEY0VVmo+eIIqIHLZTglroAFBnLJNwn2pTRKmvG
	 XOfVqA3Kjt6PC2G6LCKuDmWAQzFuP0v7LjvEbhp7BEYtYCCL0Ext7r3ysM3FHFr1Fy
	 dk+lGrrfgeZPkPTeUbC5MRJdur+rdwYAdXUY5sVvj240dnUUZTnpRhhpjX4c/U+8J0
	 RW6/I51w5LHRGf+UQGqAYg/0Dmj+xKhpPVdzC0AF20To5C95eLudL1kdBBE8Au63/b
	 6bu5pYUTXBvL4arLXh8U0cJyZtQx/hL2oEKXsjNlH1ubzfGlnKtLuRsMK0XW6xeNYW
	 PZ8ZJfU5O5S5A==
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
	Xu Kuohai <xukuohai@huawei.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCHv2 bpf 0/2] bpf: Fix prog_array_map_poke_run map poke update
Date: Tue, 28 Nov 2023 10:28:48 +0100
Message-ID: <20231128092850.1545199-1-jolsa@kernel.org>
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

For the actual fix in patch 2 I'm changing bpf_arch_text_poke to allow to skip
ip address check in patch 1. I considered adding separate function for that,
but because each arch implementation is bit different, adding extra arg seemed
like better option.

v2 changes:
  - make it work for other archs

thanks,
jirka


[0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
---
Jiri Olsa (2):
      bpf: Add checkip argument to bpf_arch_text_poke
      bpf, x64: Fix prog_array_map_poke_run map poke update

 arch/arm64/net/bpf_jit_comp.c   |  3 ++-
 arch/riscv/net/bpf_jit_comp64.c |  5 +++--
 arch/s390/net/bpf_jit_comp.c    |  3 ++-
 arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
 include/linux/bpf.h             |  2 +-
 kernel/bpf/arraymap.c           | 31 +++++++++++--------------------
 kernel/bpf/core.c               |  2 +-
 kernel/bpf/trampoline.c         | 12 ++++++------
 8 files changed, 39 insertions(+), 43 deletions(-)

