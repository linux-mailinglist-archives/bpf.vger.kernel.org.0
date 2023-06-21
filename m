Return-Path: <bpf+bounces-2994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D489E737F53
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E88C280F06
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ADBDF6F;
	Wed, 21 Jun 2023 10:11:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9044C8D7;
	Wed, 21 Jun 2023 10:11:37 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F800210D;
	Wed, 21 Jun 2023 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=UVbv8VVSUNeWoPkXuNSC/yPOTPULonyDYBh7TllQm/0=; b=RHT88/9KV8+k4Gdf59yOAM60r7
	FoPeKeGhyLbcbR9yq1Q6mF3BwL28LGY+2la/wXw2KR917ItyOwCYTzNV2byQPJUBwKMPFy4PyQYcc
	9UK2cwzTDNk7PPeVGgGYcSGKEUpyRMfjqDjjUCowcUMQ6YV6f8PQJ/C0scoz2tu9pDoWmR/xQRkpu
	Wo/k9YEGpHOqG0Yu9sG8iwEURTbfxuOfKTAvdyo34SwVngMPEfUDH0iMqBLPlov50yK6ngX63e6TD
	r5VIcg+vKq61+5Tljuwph3GPQ7PBKK9YDuNYen0tYzwhtIcjq5ZtBCZuru6pgTP+OWE30/mwDAd4Q
	ytCnUojg==;
Received: from 44.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.44] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qBuo1-000Fcr-2N; Wed, 21 Jun 2023 12:11:17 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2023-06-21
Date: Wed, 21 Jun 2023 12:11:16 +0200
Message-Id: <20230621101116.16122-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26946/Wed Jun 21 09:30:19 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 7 non-merge commits during the last 14 day(s) which contain
a total of 7 files changed, 181 insertions(+), 15 deletions(-).

The main changes are:

1) Fix a verifier id tracking issue with scalars upon spill, from Maxim Mikityanskiy.

2) Fix NULL dereference if an exception is generated while a BPF subprogram is running,
   from Krister Johansen.

3) Fix a BTF verification failure when compiling kernel with LLVM_IAS=0, from Florent Revest.

4) Fix expected_attach_type enforcement for kprobe_multi link, from Jiri Olsa.

5) Fix a bpf_jit_dump issue for x86_64 to pick the correct JITed image, from Yonghong Song.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Ilya Leoshkevich, Song Liu, Yonghong Song

----------------------------------------------------------------

The following changes since commit 182620ab3660c5a9098ffaa0e8a898e41b164987:

  Merge tag 'batadv-net-pullrequest-20230607' of git://git.open-mesh.org/linux-merge (2023-06-07 21:56:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to db8eae6bc5c702d8e3ab2d0c6bb5976c131576eb:

  bpf: Force kprobe multi expected_attach_type for kprobe_multi link (2023-06-21 10:40:26 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'bpf: fix NULL dereference during extable search'

Florent Revest (1):
      bpf/btf: Accept function names that contain dots

Jiri Olsa (1):
      bpf: Force kprobe multi expected_attach_type for kprobe_multi link

Krister Johansen (2):
      bpf: ensure main program has an extable
      selftests/bpf: add a test for subprogram extables

Maxim Mikityanskiy (2):
      bpf: Fix verifier id tracking of scalars on spill
      selftests/bpf: Add test cases to assert proper ID tracking on spill

Yonghong Song (1):
      bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl bpf_jit_enable.

 arch/x86/net/bpf_jit_comp.c                        |  2 +-
 kernel/bpf/btf.c                                   | 20 +++---
 kernel/bpf/syscall.c                               |  5 ++
 kernel/bpf/verifier.c                              | 10 ++-
 .../selftests/bpf/prog_tests/subprogs_extable.c    | 29 ++++++++
 .../selftests/bpf/progs/test_subprogs_extable.c    | 51 ++++++++++++++
 .../selftests/bpf/progs/verifier_spill_fill.c      | 79 ++++++++++++++++++++++
 7 files changed, 181 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

