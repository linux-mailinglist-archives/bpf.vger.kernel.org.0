Return-Path: <bpf+bounces-9094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D3C78F454
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 23:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D703A28171A
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 21:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449E1AA6F;
	Thu, 31 Aug 2023 21:00:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2653AE;
	Thu, 31 Aug 2023 21:00:24 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC32C0;
	Thu, 31 Aug 2023 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Yt7S8X5fXxodIT5fvunkb9YkKBJ9hnjzut/UZHVO4Bw=; b=SOUrZiwyj6Wse/0WhOjorrB0eP
	xwo/D5E5GoeFtMMjQDQNVKps2anMGWMTEpADamQGChbxXc2DQ3R6ic0mLMQferyXFxuaDglMftpU3
	Kj1KDZy/touZnf1uZ+SdQSdXRGIgCzkr2r0kyBrQnH+df4b52OE1nYyv/j+7830Bg1+xgEtPHOfpD
	9OjaLRPlftCh/CsqVSvhSaYg8VwlS89XGrm2R3hxgz1QNHm07v5h2ky8lMPUK+q1pMkBLuJLLMSBH
	zp13W7OLi8rjnnIJfiL0wbFR+ypP++upga0kns9McpS/Yt55voxaMMVrBLctqgW8fEjth9PUgTpFK
	qvXHJ3Ig==;
Received: from 54.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.54] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbom3-0008nZ-Sh; Thu, 31 Aug 2023 23:00:20 +0200
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
Subject: pull-request: bpf 2023-08-31
Date: Thu, 31 Aug 2023 23:00:19 +0200
Message-Id: <20230831210019.14417-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27017/Thu Aug 31 09:40:48 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 15 non-merge commits during the last 3 day(s) which contain
a total of 17 files changed, 468 insertions(+), 97 deletions(-).

The main changes are:

1) BPF selftest fixes: one flake and one related to clang18 testing, from Yonghong Song.

2) Fix a d_path BPF selftest failure after fast-forward from Linus' tree, from Jiri Olsa.

3) Fix a preempt_rt splat in sockmap when using raw_spin_lock_t, from John Fastabend.

4) Fix a xsk_diag_fill use-after-free race during socket cleanup, from Magnus Karlsson.

5) Fix xsk_build_skb to address a buggy dereference of an ERR_PTR(), from Tirthendu Sarkar.

6) Fix a bpftool build warning when compiled with -Wtype-limits, from Yafang Shao.

7) Several misc fixes and cleanups in standardization docs, from David Vernet.

8) Fix BPF selftest install to consider no_alu32/cpuv4/bpf-gcc flavors, from Björn Töpel.

9) Annotate a data race in bpf_long_memcpy for KCSAN, from Daniel Borkmann.

10) Extend documentation with a description for CO-RE relocations, from Eduard Zingerman.

11) Fix several invalid escape sequence warnings in bpf_doc.py script, from Vishal Chourasia.

12) Fix the instruction set doc wrt offset of BPF-to-BPF call, from Will Hawkins.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Dan Carpenter, David Vernet, Eduard Zingerman, kernel test robot, Maciej 
Fijalkowski, Magnus Karlsson, Marco Elver, Quentin Monnet, Srikar 
Dronamraju, Yonghong Song

----------------------------------------------------------------

The following changes since commit bd6c11bc43c496cddfc6cf603b5d45365606dbd5:

  Merge tag 'net-next-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2023-08-29 11:33:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to be8e754cbfac698d6304bb8382c8d18ac74424d3:

  selftests/bpf: Include build flavors for install target (2023-08-31 22:01:53 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Björn Töpel (1):
      selftests/bpf: Include build flavors for install target

Daniel Borkmann (1):
      bpf: Annotate bpf_long_memcpy with data_race

David Vernet (3):
      bpf, docs: Move linux-notes.rst to root bpf docs tree
      bpf, docs: Add abi.rst document to standardization subdirectory
      bpf, docs: s/eBPF/BPF in standards documents

Eduard Zingerman (1):
      docs/bpf: Add description for CO-RE relocations

Jiri Olsa (1):
      selftests/bpf: Fix d_path test

John Fastabend (1):
      bpf, sockmap: Fix preempt_rt splat when using raw_spin_lock_t

Magnus Karlsson (1):
      xsk: Fix xsk_diag use-after-free error during socket cleanup

Tirthendu Sarkar (1):
      xsk: Fix xsk_build_skb() error: 'skb' dereferencing possible ERR_PTR()

Vishal Chourasia (1):
      bpf, docs: Fix invalid escape sequence warnings in bpf_doc.py

Will Hawkins (1):
      bpf, docs: Correct source of offset for program-local call

Yafang Shao (1):
      bpftool: Fix build warnings with -Wtype-limits

Yonghong Song (2):
      bpf: Prevent inlining of bpf_fentry_test7()
      selftests/bpf: Fix flaky cgroup_iter_sleepable subtest

 Documentation/bpf/btf.rst                          |  31 ++-
 Documentation/bpf/index.rst                        |   1 +
 .../bpf/{standardization => }/linux-notes.rst      |   0
 Documentation/bpf/llvm_reloc.rst                   | 304 +++++++++++++++++++++
 Documentation/bpf/standardization/abi.rst          |  25 ++
 Documentation/bpf/standardization/index.rst        |   2 +-
 .../bpf/standardization/instruction-set.rst        |  44 +--
 include/linux/bpf.h                                |   2 +-
 net/bpf/test_run.c                                 |   1 +
 net/core/sock_map.c                                |  36 +--
 net/xdp/xsk.c                                      |  22 +-
 net/xdp/xsk_diag.c                                 |   3 +
 scripts/bpf_doc.py                                 |  56 ++--
 tools/bpf/bpftool/link.c                           |   2 +-
 tools/testing/selftests/bpf/Makefile               |  12 +
 .../selftests/bpf/prog_tests/bpf_obj_pinning.c     |   5 +-
 tools/testing/selftests/bpf/prog_tests/d_path.c    |  19 +-
 17 files changed, 468 insertions(+), 97 deletions(-)
 rename Documentation/bpf/{standardization => }/linux-notes.rst (100%)
 create mode 100644 Documentation/bpf/standardization/abi.rst

