Return-Path: <bpf+bounces-16859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87558069A7
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 09:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A98D1C20A60
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D301947C;
	Wed,  6 Dec 2023 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbMNivia"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB2199A3
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 08:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F584C433C7;
	Wed,  6 Dec 2023 08:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701851448;
	bh=dc3pVmyzZBrnF0NpqXATrtdx/KScoUI/tRoWVA3uWXA=;
	h=From:To:Cc:Subject:Date:From;
	b=MbMNiviafvVFg/7Dt0jjM0kGIDCXdtyWeQZh0V2T1phJp2EEAU7vDMpl8rUi/6hC7
	 iMoEdfkmkpyk7O5Bn7aDm3MqOrDbUCboFhQj07aLlBbeP1EdRfQL/f81ma5YZoI3em
	 wIbMH7REVUM7JSOFJ9WBfs1DI7xo4MOngPffjDymlj7JAN27hp/679Sj8QRIp7+jsX
	 8WBcUXSbV2TUff958UbhHfKbRdZ73I+fRzUYtK2AUJBHv6QpjozZCTEgK9Z3N3lkul
	 im0tb2306HUqaU5xjIlLB5MnBWZ6xhSWPodvQO6Q1ypUEDUjs5J2PHUS7AU+LMHQsO
	 qQVpFn3c9SgYA==
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
Subject: [PATCHv4 bpf 0/2] bpf: Fix map poke update
Date: Wed,  6 Dec 2023 09:30:39 +0100
Message-ID: <20231206083041.1306660-1-jolsa@kernel.org>
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

v4 changes:
  - added missing bpf_arch_poke_desc_update prototype [lkp]
  - added comments to the test
  - moved the test under prog_tests/tailcalls.c

thanks,
jirka


[0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
---
Jiri Olsa (2):
      bpf: Fix prog_array_map_poke_run map poke update
      selftests/bpf: Add test for early update in prog_array_map_poke_run

 arch/x86/net/bpf_jit_comp.c                        | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/bpf.h                                |  3 +++
 kernel/bpf/arraymap.c                              | 58 ++++++++++------------------------------------------------
 tools/testing/selftests/bpf/prog_tests/tailcalls.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tailcall_poke.c  | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 175 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_poke.c

