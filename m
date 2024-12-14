Return-Path: <bpf+bounces-46993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B484B9F20B4
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 21:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443281885679
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711F01B1D61;
	Sat, 14 Dec 2024 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="kr+71RBv"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F9946C;
	Sat, 14 Dec 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734208573; cv=none; b=bXqULuak1LK29nOwTohxLiuF8uWwc8jEkZQjg7exGfXoUV+djFvm5ybbs35OaWlM70zSdY3fJrv8bpay93YMWyA8ldChJ29gdSnFc72WV+WukKiTbmyGuDGAwUlINfrCpkL3F7+hGNS2phHQ9lFAvFNUiVK+QOy6Y6bELX0LX00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734208573; c=relaxed/simple;
	bh=Fw6QJcH3L2doFqLAFp2Ouu5NGImvw2n4Y/vk6uGnWqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ReCIaoJPF7DPaF9LxoVl6uIpPk+hZTplYraOR/OoCTcwDmZqnm9mVur/mdNvDhAthU/BncDT0tfnsICv3q269h5kbMdWC+KnzYZZjDoW/vtAcyPL0coz2CPth271M8GG2EH757F9nzb+WJUDRD4Osu+mdefyrMgsbup6bo1TeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=kr+71RBv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=rR+Yrouj1+O5b7xyhmVd9wGORsufXEKccs2LOnaW6DQ=; b=kr+71RBvrAGsgW0flniyjj348i
	rKqcBSnfHtgtUEFg/S2iBQ9ZHYhML83CQ7GNzU/JLqZi9Zdt1ElB36KDY1REwl9R97ShXwN89xu1O
	NLnIgU8iapVUXub1ZdsPHFGAETJwCwoXbf73MByJu/wag4Z+hc9ybmnvPeQdGT+ZsuCjjLayB7INZ
	hgvOqwgqqsqqbXzaO+YImDDZHyxdrUH5Jkhch6C1VfsrKe4o8nswNorWlkTOsfH8iMfKft9dBfBDG
	+qYQxgGhhPRlZPN47IhdjGePPDsPVZBNWBUqNcMY/Mlthl2H0NPfGvTSkUp5sdFTcUCpsLJw83pP3
	W634JFVA==;
Received: from mob-194-230-148-237.cgn.sunrise.net ([194.230.148.237] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tMYrp-000Ais-Hk; Sat, 14 Dec 2024 21:36:01 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.13-rc3
Date: Sat, 14 Dec 2024 21:36:00 +0100
Message-ID: <20241214203600.423120-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27487/Sat Dec 14 10:38:46 2024)

Hi Linus,

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to c83508da5620ef89232cb614fb9e02dfdfef2b8f:

  bpf: Avoid deadlock caused by nested kprobe and fentry bpf programs (2024-12-14 09:49:27 -0800)

----------------------------------------------------------------
BPF fixes:

- Fix a bug in the BPF verifier to track changes to packet data
  property for global functions (Eduard Zingerman)

- Fix a theoretical BPF prog_array use-after-free in RCU handling
  of __uprobe_perf_func (Jann Horn)

- Fix BPF tracing to have an explicit list of tracepoints and
  their arguments which need to be annotated as PTR_MAYBE_NULL
  (Kumar Kartikeya Dwivedi)

- Fix a logic bug in the bpf_remove_insns code where a potential
  error would have been wrongly propagated (Anton Protopopov)

- Avoid deadlock scenarios caused by nested kprobe and fentry
  BPF programs (Priya Bala Govindasamy)

- Fix a bug in BPF verifier which was missing a size check for
  BTF-based context access (Kumar Kartikeya Dwivedi)

- Fix a crash found by syzbot through an invalid BPF prog_array
  access in perf_event_detach_bpf_prog (Jiri Olsa)

- Fix several BPF sockmap bugs including a race causing a
  refcount imbalance upon element replace (Michal Luczaj)

- Fix a use-after-free from mismatching BPF program/attachment
  RCU flavors (Jann Horn)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'bpf-track-changes_pkt_data-property-for-global-functions'
      Merge branch 'add-missing-size-check-for-btf-based-ctx-access'
      Merge branch 'explicit-raw_tp-null-arguments'

Anton Protopopov (1):
      bpf: fix potential error return

Eduard Zingerman (10):
      bpf: add find_containing_subprog() utility function
      bpf: refactor bpf_helper_changes_pkt_data to use helper number
      bpf: track changes_pkt_data property for global functions
      selftests/bpf: test for changing packet data from global functions
      bpf: check changes_pkt_data property for extension programs
      selftests/bpf: freplace tests for tracking of changes_packet_data
      bpf: consider that tail calls invalidate packet pointers
      selftests/bpf: validate that tail call invalidates packet pointers
      bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs
      selftests/bpf: extend changes_pkt_data with cases w/o subprograms

Jann Horn (2):
      bpf: Fix UAF via mismatching bpf_prog/attachment RCU flavors
      bpf: Fix theoretical prog_array UAF in __uprobe_perf_func()

Jiri Olsa (1):
      bpf,perf: Fix invalid prog_array access in perf_event_detach_bpf_prog

Kumar Kartikeya Dwivedi (5):
      bpf: Check size for BTF-based ctx access of pointer members
      selftests/bpf: Add test for narrow ctx load for pointer args
      bpf: Revert "bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"
      bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
      selftests/bpf: Add tests for raw_tp NULL args

Michal Luczaj (3):
      bpf, sockmap: Fix update element with same
      bpf, sockmap: Fix race between element replace and close()
      selftests/bpf: Extend test for sockmap update with same

Priya Bala Govindasamy (1):
      bpf: Avoid deadlock caused by nested kprobe and fentry bpf programs

 include/linux/bpf.h                                |  20 +--
 include/linux/bpf_verifier.h                       |   1 +
 include/linux/filter.h                             |   2 +-
 kernel/bpf/Makefile                                |   6 +
 kernel/bpf/btf.c                                   | 149 ++++++++++++++++++-
 kernel/bpf/core.c                                  |   8 +-
 kernel/bpf/verifier.c                              | 160 ++++++++++-----------
 kernel/trace/bpf_trace.c                           |  11 ++
 kernel/trace/trace_uprobe.c                        |   6 +-
 net/core/filter.c                                  |  65 ++++-----
 net/core/sock_map.c                                |   6 +-
 .../selftests/bpf/prog_tests/changes_pkt_data.c    | 107 ++++++++++++++
 .../testing/selftests/bpf/prog_tests/raw_tp_null.c |   3 +
 .../selftests/bpf/prog_tests/sockmap_basic.c       |   8 +-
 .../testing/selftests/bpf/progs/changes_pkt_data.c |  39 +++++
 .../bpf/progs/changes_pkt_data_freplace.c          |  18 +++
 tools/testing/selftests/bpf/progs/raw_tp_null.c    |  19 ++-
 .../testing/selftests/bpf/progs/raw_tp_null_fail.c |  24 ++++
 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c     |   2 +
 .../selftests/bpf/progs/test_tp_btf_nullable.c     |   6 +-
 .../selftests/bpf/progs/verifier_btf_ctx_access.c  |  40 +++++-
 .../testing/selftests/bpf/progs/verifier_d_path.c  |   4 +-
 tools/testing/selftests/bpf/progs/verifier_sock.c  |  56 ++++++++
 23 files changed, 596 insertions(+), 164 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null_fail.c

