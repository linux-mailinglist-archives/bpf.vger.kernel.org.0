Return-Path: <bpf+bounces-46648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B6E9ED376
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F2828397F
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6BA1FF1B2;
	Wed, 11 Dec 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDHbnwSV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C71FECCA;
	Wed, 11 Dec 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938118; cv=none; b=pwSk1GZ7GhzyyWCCVZR6COokw8HgjYEWQ/06vmDzQfrC6+7Nlz7nIOdmuQRy43cTyWXf2ZKi405DJ56myRxjIx2JdXfhI9G4KH/zrpHILKmqcWazBMF7u4pqhlJmtzt93BbPSZnnUZ+rFgx1w3LJvQyF18C8x4eXxRHTrvJOmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938118; c=relaxed/simple;
	bh=xHFhp5DyCPpbZ795gtyNF5QT0rN9g88SLOPHzB3XgIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aofWA24ZdDS/5MZW+HRDmLlZfAf0kF+Tq2AvEm2r69xB8wQ0pQitbfx9v7RP9VVnd4tiqypEktbt+00cq8JNAHEwL0j3d4GOfz7UHQUZLLr1XKW5yjfEnjOZ6TBs9KkltfLwCXq/bGxboD679o57FMX9/vtnHFCAapcDNrq+0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDHbnwSV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733938117; x=1765474117;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xHFhp5DyCPpbZ795gtyNF5QT0rN9g88SLOPHzB3XgIs=;
  b=fDHbnwSVeQ63AzPtJj5UxAOylwooIwgD1l2jQeiTY1p9gc6mNpb5yLqt
   l2PY22aKbIAoa5SCDUd78BPPn1/jnaQFEuPHJ/AlNextqKltRtURzLoj5
   KNNKcee4hxhBjdrnXal4bQHzfXY8tF9TWuyqq3m4X7mpaXb9FujdxGxcK
   a8ucvlSKwCISgYNc1hAzG/vjMTEERNjcjdjVnavz/YWOKHQTga3Cp4eVn
   XTqY9sA21rpWbP5ryChx6zG3PozCJsqae/IV+qcEWgZ4jSzaERyCCstJI
   j+QqEsow4Vk66w5WegsjGCjGOgrRut9JRtdhE2Iepxm9N/cLyFG7TpdK/
   Q==;
X-CSE-ConnectionGUID: 0yaY5se8QSaVn88yh359nw==
X-CSE-MsgGUID: aUm9zrHoScyjCd97mKvmbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51859433"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51859433"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:28:36 -0800
X-CSE-ConnectionGUID: whRgg8oRQOuRIuR0v66ebw==
X-CSE-MsgGUID: 5qIaA6OLTvO/ayqDoEBkzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119122067"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 09:28:30 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/12] xdp: a fistful of generic changes pt. II
Date: Wed, 11 Dec 2024 18:26:37 +0100
Message-ID: <20241211172649.761483-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

XDP for idpf is currently 5.5 chapters:
* convert Rx to libeth;
* convert Tx and stats to libeth;
* generic XDP and XSk code changes;
* generic XDP and XSk code additions (you are here);
* actual XDP for idpf via new libeth_xdp;
* XSk for idpf (via ^).

Part III.2 does the following:
* allows mixing pages from several Page Pools within one XDP frame;
* optimizes &xdp_frame structure and removes no-more-used field;
* adds generic functions to build skbs from xdp_buffs (regular and
  XSk) and attach frags to xdp_buffs (regular and XSk);
* adds helper to optimize XSk xmit in drivers;
* makes XDP core and Page Pool a bit more netmem-friendly.

Everything is prereq for libeth_xdp, but will be useful standalone
as well: faster xdp_return_frame_bulk() and xdp_frame fields access,
less code in drivers, faster XSk XDP_PASS, smaller object code.

Alexander Lobakin (12):
  page_pool: allow mixing PPs within one bulk
  xdp: get rid of xdp_frame::mem.id
  xdp: make __xdp_return() MP-agnostic
  xdp: add generic xdp_buff_add_frag()
  xdp: add generic xdp_build_skb_from_buff()
  xsk: make xsk_buff_add_frag really add the frag via
    __xdp_buff_add_frag()
  xsk: add generic XSk &xdp_buff -> skb conversion
  xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
  page_pool: add a couple of netmem counterparts
  skbuff: allow 2-4-argument skb_frag_dma_map()
  jump_label: export static_key_slow_{inc,dec}_cpuslocked()
  unroll: add generic loop unroll helpers

 include/net/page_pool/types.h                 |   6 +-
 include/linux/skbuff.h                        |  47 ++-
 include/linux/unroll.h                        |  44 +++
 include/net/page_pool/helpers.h               |  46 ++-
 include/net/xdp.h                             | 130 +++++++-
 include/net/xdp_sock_drv.h                    |  41 ++-
 include/net/xsk_buff_pool.h                   |   8 +
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  30 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  32 +-
 drivers/net/veth.c                            |   4 +-
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/jump_label.c                           |   2 +
 net/bpf/test_run.c                            |   4 +-
 net/core/filter.c                             |  17 +-
 net/core/page_pool.c                          | 109 ++++---
 net/core/xdp.c                                | 290 ++++++++++++++----
 net/xdp/xsk_buff_pool.c                       |  40 +++
 18 files changed, 645 insertions(+), 209 deletions(-)

---
Each patch except trivial 0003 and 0009 was on the lists already.

* 0001 now includes Jakub's suggestions (pre-pass + while(count));
* 0004 doesn't leak refcounts anymore (also Jakub).
-- 
2.47.1


