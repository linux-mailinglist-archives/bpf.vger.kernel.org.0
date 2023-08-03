Return-Path: <bpf+bounces-6887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E9576F195
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 20:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC1C1C21604
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8825910;
	Thu,  3 Aug 2023 18:14:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3FB25908
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 18:14:53 +0000 (UTC)
Received: from out-84.mta1.migadu.com (out-84.mta1.migadu.com [95.215.58.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B0E1BF9
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 11:14:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691086489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ltTUhuKm9ofoFkjvCQJ7syFdAhDqM+nZ1aeHnQ0WYL4=;
	b=Y2FTabbECaxji0yG29+toYqGUaDBv4Np6aig1uS2JzEf8HE57BZb6HUGXRW2OmBubn2Psd
	bBpkBKpcEZBSyCKB+dij4r+g1ze4NyukXYvcPnHpSplOLwUkKIZFCTNISQORhqVGwAnfv3
	tt1S/ksG9QAPx2H+wx3q+wDiDU/4LXo=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2023-08-03
Date: Thu,  3 Aug 2023 11:14:29 -0700
Message-Id: <20230803181429.994607-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 5 non-merge commits during the last 7 day(s) which contain
a total of 3 files changed, 37 insertions(+), 20 deletions(-).

The main changes are:

1) Disable preemption in perf_event_output helpers code from Jiri Olsa

2) Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing from Lin Ma

3) Multiple warning splat fixes in cpumap from Hou Tao

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Hou Tao, Jakub Kicinski, Jesper Dangaard Brouer, Oleg Popov, Pu Lehui

----------------------------------------------------------------

The following changes since commit 284779dbf4e98753458708783af8c35630674a21:

  net: stmmac: Apply redundant write work around on 4.xx too (2023-07-25 11:03:55 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 4c9fbff54297471d4e2bbfe9c27e80067c722eae:

  Merge branch 'Two fixes for cpu-map' (2023-07-31 15:45:38 -0700)

----------------------------------------------------------------
pull-request: bpf 2023-08-03

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'bpf-disable-preemption-in-perf_event_output-helpers-code'

Hou Tao (2):
      bpf, cpumap: Make sure kthread is running before map update returns
      bpf, cpumap: Handle skb as well when clean up ptr_ring

Jiri Olsa (2):
      bpf: Disable preemption in bpf_perf_event_output
      bpf: Disable preemption in bpf_event_output

Lin Ma (1):
      bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing

Martin KaFai Lau (1):
      Merge branch 'Two fixes for cpu-map'

 kernel/bpf/cpumap.c       | 35 +++++++++++++++++++++--------------
 kernel/trace/bpf_trace.c  | 17 ++++++++++++-----
 net/core/bpf_sk_storage.c |  5 ++++-
 3 files changed, 37 insertions(+), 20 deletions(-)

