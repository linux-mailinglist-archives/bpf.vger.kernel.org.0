Return-Path: <bpf+bounces-72916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45ABC1D920
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D783AD871
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D87A31A062;
	Wed, 29 Oct 2025 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bhz9PdNc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6122DF154;
	Wed, 29 Oct 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776003; cv=none; b=rkgN9QyFM7sNnIbNvfHCKcZdqZ11/Nfb+8XFwog3KCNzZ5XR+R5GfhbIUZ7SHhENzYWOi+N8+67n+rOVGVd+prW/N8SbN4HoNl4LjYT2o+uWGt2OSvOLCC6qrimwajDpdSulbNfNcCuzLXK/V33WgSPHRyST9fJG8qRve85Uyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776003; c=relaxed/simple;
	bh=tk0EdzYrP4+xqhr8LtNnIX9Zuv7CyrISAzv6c4S1qMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+T1wjn7/XVPIOALRh1ol+hzplj4d8axZfmYbwNZfa//3aPaPCXGUdSI/qIKNl26C7BF9W01T4WC4Y4qH/NgdSZUbHno6OcV1nvwlCEg59jF7d9GHDj6Y49g6yPPe21bL82wZ0mHCgyY0RXnJmzFsZmp/hvVdJgn4JpwKkYzyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bhz9PdNc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761776003; x=1793312003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tk0EdzYrP4+xqhr8LtNnIX9Zuv7CyrISAzv6c4S1qMk=;
  b=Bhz9PdNcrFPUuC75WoD8NPLxC+UKNBtN2IdGaZ+KpJcIw2KUSvpsTrwp
   zQrcjBQfHfUHwht/HGof2Xkpt5epoTXCUkUkH9Bd4reixVD6A+PBUnf/c
   C7CY41butooDQlW3h8pz6HEw87CSh2OJfbE/Z5OeYC71WJxoixY5vAKtx
   s4mvD3300XWsK5J8CylQSJtrRA56eTU2TyPeOpl2HkQ/r3bY2To6d4g05
   d0N05bxxda7yd0WfVc+98QSVk4EixcPmOJ076sBx3XPe4n1ZSnL43mMG2
   C4e790FDaOvYMY2UhbbqfOP7K6hY1ys9NNQ2tP7sDbd6W6v2gbSMaGdcN
   g==;
X-CSE-ConnectionGUID: /fTJndcTQ0iCONGuw16OZw==
X-CSE-MsgGUID: 9PhySgQnQh+rgzuyLPjHvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63820764"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="63820764"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:13:22 -0700
X-CSE-ConnectionGUID: XHg/0hAZRsaARltw0wiWfQ==
X-CSE-MsgGUID: jSw/KGG6RryUgYXfmVbAUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216643387"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 29 Oct 2025 15:13:19 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	kuba@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 bpf 0/2] xdp: fix page_pool leaks
Date: Wed, 29 Oct 2025 23:13:13 +0100
Message-Id: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1:
https://lore.kernel.org/bpf/20251003140243.2534865-1-maciej.fijalkowski@intel.com/
v1->v2:
- add skb to xdp_buff converter (Jakub)
- postpone restoration of veth's xdp_rxq_info mem model (AI)

v2:
https://lore.kernel.org/bpf/20251017143103.2620164-1-maciej.fijalkowski@intel.com/T/
v2->v3:
- make skb->xdp_buff conversion agnostic of current skb->data position
  (Toke)
- do not pull mac header in veth (Toke)
- use virt_to_head_page() when checking if xdp->data comes from
  page_pool (Olek)
- add ack from Toke

v3:
https://lore.kernel.org/bpf/20251022125209.2649287-1-maciej.fijalkowski@intel.com/
v3->v4:
- include skb->head when calculating packet length (Toke, lkp)

v4:
https://lore.kernel.org/bpf/20251027121318.2679226-1-maciej.fijalkowski@intel.com/
v4->v5:
- rely again on sk_buff::pp_recycle when setting mem type on rxq
  (Jesper, Jakub)
- add ack from Toke on patch 2 and restore it on patch 1


Hi,

here we fix page_pool leaks which happen when fragment is released
within XDP program and memory type is set incorrectly. The reports come
from syzbot and AF_XDP test suite.

Most of the changes are about pulling out the common code for
init/prepare xdp_buff based on existing skb and supplying it with
correct xdp_rxq_info's mem_type that is assigned to xdp_buff. A bit more
stuff, page_pool related, had to be done on veth side.

Originally, this work was started by Octavian Purdila.

Thanks!


Maciej Fijalkowski (2):
  xdp: introduce xdp_convert_skb_to_buff()
  veth: update mem type in xdp_buff

 drivers/net/veth.c | 43 ++++++++++++++++++++++++++-----------------
 include/net/xdp.h  | 25 +++++++++++++++++++++++++
 net/core/dev.c     | 25 ++++---------------------
 3 files changed, 55 insertions(+), 38 deletions(-)

-- 
2.43.0


