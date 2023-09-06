Return-Path: <bpf+bounces-9325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B3C7938DE
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F612813AD
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF046B6;
	Wed,  6 Sep 2023 09:51:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D7ED6;
	Wed,  6 Sep 2023 09:51:21 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB1CFF;
	Wed,  6 Sep 2023 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=VShVyvDE81pUc6DastFwuDdrUE7FLRfbrH8EYlvmp+c=; b=ig7KeUlEDfW97pHu7HfKOBQ+7f
	ZVTOA/f3vIvL5pJLQzPTAuebyDoLSDdmjO+GUVWuqiQO8ysXYR9wkPbxuRKnsueebbClZNfLdAAHZ
	TTljTOFpz29SLTXq9h8aSnGjrYemBz8Prmjgf18MJm/9pPmujkYSMdyWi+yGyDfDOa+Wp26X1N0wJ
	QrZ+4H51lsJLT8fLcSqBCQOrIGEIrG5LSCX3QC+EP4zzKsQebVk6x4B53VA/zL0Z1b0XB+W2kyu/H
	HJTWPnEhQkAHnAfRivt8kTAy/wIjG1suF14XIzHnxGASSQcm0oRck01x7iEdegqJIRJTv+BST+gtB
	Fisr0MdQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qdpBt-000N2k-G4; Wed, 06 Sep 2023 11:51:17 +0200
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
Subject: pull-request: bpf 2023-09-06
Date: Wed,  6 Sep 2023 11:51:17 +0200
Message-Id: <20230906095117.16941-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27023/Wed Sep  6 09:38:27 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 9 non-merge commits during the last 6 day(s) which contain
a total of 12 files changed, 189 insertions(+), 44 deletions(-).

The main changes are:

1) Fix bpf_sk_storage to address an invalid wait context lockdep report and
   another one to address missing omem uncharge, from Martin KaFai Lau.

2) Two BPF recursion detection related fixes, from Sebastian Andrzej Siewior.

3) Fix tailcall limit enforcement in trampolines for s390 JIT, from Ilya Leoshkevich.

4) Fix a sockmap refcount race where skbs in sk_psock_backlog can be referenced
   after user space side has already skb_consumed them, from John Fastabend.

5) Fix BPF CI flake/race wrt sockmap vsock write test where the transport
   endpoint is not connected, from Xu Kuohai.

6) Follow-up doc fix to address a cross-link warning, from Eduard Zingerman.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jiri Olsa, kernel test robot, Leon Hwang, Xu Kuohai

----------------------------------------------------------------

The following changes since commit ae074e2b2fd410bf54d56509a7e48fb83873af3b:

  sfc: check for zero length in EF10 RX prefix (2023-09-01 08:14:57 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to a96d1cfb2da040bdf692d22022371b249742abb2:

  selftests/bpf: Check bpf_sk_storage has uncharged sk_omem_alloc (2023-09-06 11:08:47 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Eduard Zingerman (1):
      docs/bpf: Fix "file doesn't exist" warnings in {llvm_reloc,btf}.rst

Ilya Leoshkevich (1):
      s390/bpf: Pass through tail call counter in trampolines

John Fastabend (1):
      bpf, sockmap: Fix skb refcnt race after locking changes

Martin KaFai Lau (3):
      bpf: bpf_sk_storage: Fix invalid wait context lockdep report
      bpf: bpf_sk_storage: Fix the missing uncharge in sk_omem_alloc
      selftests/bpf: Check bpf_sk_storage has uncharged sk_omem_alloc

Sebastian Andrzej Siewior (2):
      bpf: Invoke __bpf_prog_exit_sleepable_recur() on recursion in kern_sys_bpf().
      bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before recursion check.

Xu Kuohai (1):
      selftests/bpf: Fix a CI failure caused by vsock write

 Documentation/bpf/btf.rst                          |  2 +-
 Documentation/bpf/llvm_reloc.rst                   |  2 +-
 arch/s390/net/bpf_jit_comp.c                       | 10 ++++
 kernel/bpf/bpf_local_storage.c                     | 49 ++++++-----------
 kernel/bpf/syscall.c                               |  2 +-
 kernel/bpf/trampoline.c                            |  5 +-
 net/core/skmsg.c                                   | 12 +++--
 .../bpf/prog_tests/sk_storage_omem_uncharge.c      | 56 ++++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 26 +++++++++
 .../selftests/bpf/prog_tests/sockmap_listen.c      |  7 +++
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |  1 +
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c | 61 ++++++++++++++++++++++
 12 files changed, 189 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_storage_omem_uncharge.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c

