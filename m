Return-Path: <bpf+bounces-29778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF68C6A34
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6696281496
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8275A156256;
	Wed, 15 May 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6NR1mc+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F113EFE5;
	Wed, 15 May 2024 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789358; cv=none; b=aLmv7qbwAN4POs+bBJRlSkoVHaiDoO0Ga42pnPWCOp0ad/UvL4sARHK1rk0PKNvE44TZkpF8pvOHH4haG0PVuYguEzYovU9fMS63oZ8PQUF56rxbCTIPbbI0vRIS3TArKuwRGpkgRP1I91uyzfqoRRxKfhlTYxlZlBI8L0DJX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789358; c=relaxed/simple;
	bh=nTVevPGzNWh4s9PReJpsEP/R9Arj6uGdwElEHpIpPH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwzsIIpTl02Uwaf70e8SbruV/lKJIiDJIGyoUxteupJazcOFbg9GtZ1lkcPjmhmDp5OGslLAWnLA39p0CiPTekHKSsCnj19aF01lMhjMbF0c+MDlQn2cbcI6Cu+5FEqz+aGGu4a8fC85r2x2bmv7RyXaNLQ7XKc7qg4cGP1izR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6NR1mc+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715789356; x=1747325356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nTVevPGzNWh4s9PReJpsEP/R9Arj6uGdwElEHpIpPH4=;
  b=n6NR1mc+iJMElevA92dvPV+cMFuEmxJqIHsp5v2YpBHo86XxOWEWh8Oh
   haohwcXGHQqDT1VtODWIM7cusR4HcfLeve52HHJDOiHDguLGSlwdGfMN2
   q1rVmnPkglf19obkOvfX9Rittzis9SG3SDyucUDBK2k/8H0Ywms4N2ERS
   uKiHl2GUKhwNALjyH1fddNVVc20f4GDcPhxoRXabolN2XEJGMbccR5ouc
   pCTUwnxSzs5mzBNV5i9N6QDbbwXhOaqsPwmMNGL6lD+Oqd1U3DMrTMxFg
   RDGOpYCIjTSXHQu1hriKjV1oeupZn+aGRgwYoUOQyjlE5CKNIBjpllN7a
   Q==;
X-CSE-ConnectionGUID: 7Y/CP5g9RCKzQPCyzNGBDw==
X-CSE-MsgGUID: kzul5gNeS7SB/2kxCgINJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11666344"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="11666344"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:09:15 -0700
X-CSE-ConnectionGUID: GANiKUvAR7uiRZ8GlOHq8g==
X-CSE-MsgGUID: 72pTt72QRii18KEvAsm9hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="62297177"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 May 2024 09:09:11 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3DA332878C;
	Wed, 15 May 2024 17:09:05 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	maciej.fijalkowski@intel.com,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	igor.bagnucki@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net 0/3] Fix AF_XDP problems after changing queue number
Date: Wed, 15 May 2024 18:02:13 +0200
Message-ID: <20240515160246.5181-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Presented fixes address the following test-case:
* Run xdpsock on queue 10
* change number of combined channels to 20
* observe an error on xdpsock side

The first 2 patches deal with errors, the last one addresses the lack of
traffic.

Larysa Zaremba (3):
  ice: remove af_xdp_zc_qps bitmap
  ice: add flag to distinguish reset from .ndo_bpf in XDP rings config
  ice: map XDP queues to vectors in ice_vsi_map_rings_to_vectors()

 drivers/net/ethernet/intel/ice/ice.h      |  44 +++++---
 drivers/net/ethernet/intel/ice/ice_base.c |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c  |  27 ++---
 drivers/net/ethernet/intel/ice/ice_main.c | 118 +++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  13 ++-
 5 files changed, 119 insertions(+), 86 deletions(-)

-- 
2.43.0


