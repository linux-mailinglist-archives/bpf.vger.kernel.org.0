Return-Path: <bpf+bounces-20313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8909F83BC37
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 09:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399E31F28DFA
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43011B951;
	Thu, 25 Jan 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JbQaa1Qv"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E01BC20;
	Thu, 25 Jan 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172264; cv=none; b=ehDLzaXFHBBkbUOks2dQoDHuRrl6AVP8wyvE0YUaOtRzU3odBdJsnpexn60EeFTvRthhHYChJvi5z6oBFovNlXKM8UPlPls9LctUzD3KngYA4Ou1bdA/e4uBomYKBfQUfBM0kjqUBbOyYgC3cCOG04vmo0YS7VBtyspOsDdSlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172264; c=relaxed/simple;
	bh=bIAqh3O/SJZ40uz8p+xJYJ/m9ym/SnLIQi9cPGspif8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UVz/e8PdIdGIXSKExB3yjJrf7XfJ9DxllWVgdyD7opYLcqJe7MZMuaGlb0iHLZGdVkRC5ov9PBSVeMfBVES+qTNQ77z/FDweBR8YX7HK1Z3ChLgsBjgjYbq+yajn2H+Vu4jc+06qxGdmOtm0B2xX8vZiK4vORlIfGCU1aIsa+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JbQaa1Qv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=veQ/CK0jTuc04jePgKpivFqI1zg8kgnliwMvdizlimM=; b=JbQaa1QvOSVbjuLMVFRPsKUfrJ
	DunKlGHuS5VWr05VsNaBKVNT9GozhlS1oZLBmeM/tgl66ZMAvOwaIq/pMe2iCHhZtLHdhLphbIDZL
	Hyog0yQy0Dh0EXn/QPdsPLDsRZBH8hcEteCzFubiRGlxxvpSUHeLzzXP3ztKbI2LCJSYDQxWE/nYB
	IzQxH/Hy+RwrVQRvv4OYTzV8HkPS9lEEj63PTqQbAkeDpExVv3TxmEiLZu24Uz/jwpBjIT13t5POu
	pvRQd1KbNog0qGjGYWtYivDU5zabhuXdWq0ZfmUUy7pi71gANsuoE9R1D3HgF0jd85BdzNqKgKUVw
	sqmHPqlg==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSvLN-000Iaj-PL; Thu, 25 Jan 2024 09:44:17 +0100
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
Subject: pull-request: bpf 2024-01-25
Date: Thu, 25 Jan 2024 09:44:16 +0100
Message-Id: <20240125084416.10876-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27164/Wed Jan 24 10:45:32 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 12 non-merge commits during the last 2 day(s) which contain
a total of 13 files changed, 190 insertions(+), 91 deletions(-).

The main changes are:

1) Fix bpf_xdp_adjust_tail() in context of XSK zero-copy drivers which
   support XDP multi-buffer. The former triggered a NULL pointer
   dereference upon shrinking, from Maciej Fijalkowski & Tirthendu Sarkar.

2) Fix a bug in riscv64 BPF JIT which emitted a wrong prologue and
   epilogue for struct_ops programs, from Pu Lehui.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Björn Töpel, Maciej Fijalkowski, Magnus Karlsson

----------------------------------------------------------------

The following changes since commit 1347775dea7f62798b4d5ef60771cdd7cfff25d8:

  Merge tag 'wireless-2024-01-22' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-01-23 08:38:13 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 9d71bc833f57a6549c753e37ce47136d35b67fc4:

  Merge branch 'net-bpf_xdp_adjust_tail-and-intel-mbuf-fixes' (2024-01-24 16:24:07 -0800)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'net-bpf_xdp_adjust_tail-and-intel-mbuf-fixes'

Maciej Fijalkowski (10):
      xsk: recycle buffer in case Rx queue was full
      xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
      xsk: fix usage of multi-buffer BPF helpers for ZC XDP
      ice: work on pre-XDP prog frag count
      ice: remove redundant xdp_rxq_info registration
      intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
      ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
      xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
      i40e: set xdp_rxq_info::frag_size
      i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue

Pu Lehui (1):
      riscv, bpf: Fix unpredictable kernel crash about RV64 struct_ops

Tirthendu Sarkar (1):
      i40e: handle multi-buffer packets that are shrunk by xdp prog

 arch/riscv/net/bpf_jit_comp64.c               |  5 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 47 ++++++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 49 +++++++++++++--------------
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 +--
 drivers/net/ethernet/intel/ice/ice_base.c     | 37 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 19 +++++------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 ++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 +--
 include/net/xdp_sock_drv.h                    | 27 +++++++++++++++
 net/core/filter.c                             | 44 ++++++++++++++++++++----
 net/xdp/xsk.c                                 | 12 ++++---
 net/xdp/xsk_buff_pool.c                       |  1 +
 13 files changed, 190 insertions(+), 91 deletions(-)

