Return-Path: <bpf+bounces-31422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038918FC770
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 11:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA58B21E2E
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDDA18FC66;
	Wed,  5 Jun 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NROz737X"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073549645;
	Wed,  5 Jun 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578937; cv=none; b=j9h1CSt6lRExRA90gTN2grbGVbS0kieepFkxkZChy80JnGGQ6KrACeYYyCwvgFS/wNtGIwKayWsmMuH7DvCVWv3BG040rtcxpMS11lWq7m9YcujAnx2hKIeR/Z66UzKfeOEJYfiVlEk8NIZ1K9n9d4USAOJGUrPrznwrKUn9BoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578937; c=relaxed/simple;
	bh=EgmMbyOlJ77obyN8WUQzwN67ZchBNjDVil+6qkZwJEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZFZd5EEcUlT7RELpDMr6whJJTzxHYmDbr513Lcd1LJpHHt6+fmFRb9FZIX9ioyG/UjYbhsWx/Gyzfh4m+n/Ski54znjL3CQxHoSMc5E09C7SpsZkQVJhygWNdF3/eIyoRJsQCvBs+TS79MvENMlx4rYiqyrac54qEOvxlIGrTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NROz737X; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=viCEZODsD67i7SMAhYHlCEmO7JjUJsBwOLxfiqzNs0M=; b=NROz737XOH+t0l9lSUGm1Lo7m3
	NnutKYQZ95moKWxBelXRxJw4JEETPC3yWN4rTsehTO2q6oM+hUwJsWRNU0GXeCtJPn1FwUB5l58rN
	kvW4rC+NGuA+zKFYznAmXcfQtghwPwmvuhl9+TF9NDU7SblL4DPuOz3nJEuaN+DfeFzj81MRHQkqu
	DE/Rlyz6nWbOaTqDQdpUHLKqealSSxv4Hr27WpRjJaac7Q3Vijctse7Vu8ypP2S+UX5bEW9b47kz/
	+foxqH1OckR1JkDJhHhtReGm2PQuBzhXhO4tSEzSC59E54+iOe/IY6WaVaUAf5msLCeU1yn8KSubf
	UB0rvKUw==;
Received: from 29.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.29] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sEmjt-0009s4-SE; Wed, 05 Jun 2024 11:15:25 +0200
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
Subject: pull-request: bpf 2024-06-05
Date: Wed,  5 Jun 2024 11:15:25 +0200
Message-Id: <20240605091525.22628-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27296/Tue Jun  4 10:29:18 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 8 non-merge commits during the last 6 day(s) which contain
a total of 9 files changed, 34 insertions(+), 35 deletions(-).

The main changes are:

1) Fix a potential use-after-free in bpf_link_free when the link uses
   dealloc_deferred to free the link object but later still tests for
   presence of link->ops->dealloc, from Cong Wang.

2) Fix BPF test infra to set the run context for rawtp test_run callback
   where syzbot reported a crash, from Jiri Olsa.

3) Fix bpf_session_cookie BTF_ID in the special_kfunc_set list to exclude
   it for the case of !CONFIG_FPROBE, also from Jiri Olsa.

4) Fix a Coverity static analysis report to not close() a link_fd of -1 in
   the multi-uprobe feature detector, from Andrii Nakryiko.

5) Revert support for redirect to any xsk socket bound to the same umem
   as it can result in corrupted ring state which can lead to a crash when
   flushing rings. A different approach will be pursued for bpf-next to
   address it safely, from Magnus Karlsson.

6) Fix inet_csk_accept prototype in test_sk_storage_tracing.c which caused
   BPF CI failure after the last tree fast forwarding, from Andrii Nakryiko.

7) Fix a coccicheck warning in BPF devmap that iterator variable cannot
   be NULL, from Thorsten Blum.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jiri Olsa, Sebastian Andrzej Siewior, Toke Høiland-Jørgensen, Yuval 
El-Hanany

----------------------------------------------------------------

The following changes since commit d8ec19857b095b39d114ae299713bd8ea6c1e66a:

  Merge tag 'net-6.10-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-05-30 08:33:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 03e38d315f3c5258270ad50f2ae784b6372e87c3:

  Revert "xsk: Document ability to redirect to any socket bound to the same umem" (2024-06-05 09:43:05 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Andrii Nakryiko (2):
      selftests/bpf: fix inet_csk_accept prototype in test_sk_storage_tracing.c
      libbpf: don't close(-1) in multi-uprobe feature detector

Cong Wang (1):
      bpf: Fix a potential use-after-free in bpf_link_free()

Jiri Olsa (2):
      bpf: Fix bpf_session_cookie BTF_ID in special_kfunc_set list
      bpf: Set run context for rawtp test_run callback

Magnus Karlsson (2):
      Revert "xsk: Support redirect to any socket bound to the same umem"
      Revert "xsk: Document ability to redirect to any socket bound to the same umem"

Thorsten Blum (1):
      bpf, devmap: Remove unnecessary if check in for loop

 Documentation/networking/af_xdp.rst                | 33 +++++++++-------------
 kernel/bpf/devmap.c                                |  3 --
 kernel/bpf/syscall.c                               | 11 ++++----
 kernel/bpf/verifier.c                              |  4 +++
 kernel/trace/bpf_trace.c                           |  2 --
 net/bpf/test_run.c                                 |  6 ++++
 net/xdp/xsk.c                                      |  5 +---
 tools/lib/bpf/features.c                           |  3 +-
 .../selftests/bpf/progs/test_sk_storage_tracing.c  |  2 +-
 9 files changed, 34 insertions(+), 35 deletions(-)

