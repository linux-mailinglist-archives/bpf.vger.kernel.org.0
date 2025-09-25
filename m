Return-Path: <bpf+bounces-69740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 442C9BA0851
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 149F14E3A7C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391BF302CDB;
	Thu, 25 Sep 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIDBEOCR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F3CA6F;
	Thu, 25 Sep 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816045; cv=none; b=KEZXDsqjywJITmT4Uzyahv47EGsc6qyF/Hi8OhPdynV/J7Cf30C8gLAH9EYEk4nwc+Emqhivku3EU4UdUEZ5yBN0QBLzUpPihmy6TJsiCkSl0rUh0Lcvl/u51BIMU/gdzP9GoqnMySz+BNl4NZaAQu6v0kouTr3vyXj7izpzdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816045; c=relaxed/simple;
	bh=GXfTPMg7gxQOcThYbKkT6WxHPc6iF/vQm35JdWkgPaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UAuzNK5nkZWOffJ1ck60My7SjISX1iHhsucAeYEWELCDe56k/C8P7f/4WlvUJKIUwsD8bDHNYzYb3ZHLt8CIb2tV/611RBV6D5bQ42Er530rLWaTmt3Ua/eLDwcKj9EdTf/tOhkYnbmAOiBG0EEM3nliB5AMCNyvqBhhUh/KvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIDBEOCR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758816044; x=1790352044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GXfTPMg7gxQOcThYbKkT6WxHPc6iF/vQm35JdWkgPaY=;
  b=cIDBEOCRnysNsaE8z74dpeeXnBVAhJzPQqhyMkwF+juGUEk9HABf7GBe
   kMXVOLP2MPZM7WcA3D1SiZDGy5QdrdYbQF+QGGDvNWall98KlKuEbAZ1T
   /AzKY6Fgl1jYIqvTzJwWPznWv6+KfwalYF/7WWXK9AotsVt0OWTcbWoOH
   29mC86OGRRgEV6I/faX0gwr/qGWHdZk6S8+R4ahBSmGe9uTnBut9ZKh5B
   duyJVnBRR+oII+9LjhcOypjAeiT6eqLKCWRG/fbke+UyoEaRXcgr1kRAW
   bz/zQ/72XvCaT9E+8Je0Pnt6sB1A0tQcoRGYfBfT55IzxLdAhkqd+oqRj
   A==;
X-CSE-ConnectionGUID: i7TAoV45SyuZNJVPLANYGg==
X-CSE-MsgGUID: OnQVwH/ETHy4mEBIwjBXPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71759823"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="71759823"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 09:00:43 -0700
X-CSE-ConnectionGUID: 2IGNXq7kSmiRhA0cowx1Dg==
X-CSE-MsgGUID: yjl31236RJuYTujLoxYmUg==
X-ExtLoop1: 1
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 25 Sep 2025 09:00:41 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 bpf-next 0/3] xsk: refactors around generic xmit side
Date: Thu, 25 Sep 2025 18:00:06 +0200
Message-Id: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this small patchset is about refactoring code around xsk_build_skb() as
it became pretty heavy. Generic xmit is a bit hard to follow so here are
three clean ups to start with making this code more friendly.

Thanks,
Maciej

v1 link:
https://lore.kernel.org/bpf/20250922152600.2455136-1-maciej.fijalkowski@intel.com/T/#u

v1->v2:
* fix IFF_TX_SKB_NO_LINEAR path in patch 1 (Stan, Jason)
* fix IFF_TX_SKB_NO_LINEAR path in patch 2 (Stan, Jason)
* enable metadata for IFF_TX_SKB_NO_LINEAR
* add acks


Maciej Fijalkowski (3):
  xsk: avoid overwriting skb fields for multi-buffer traffic
  xsk: remove @first_frag from xsk_build_skb()
  xsk: wrap generic metadata handling onto separate function

 net/xdp/xsk.c | 113 ++++++++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 50 deletions(-)

-- 
2.43.0


