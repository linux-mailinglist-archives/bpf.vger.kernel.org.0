Return-Path: <bpf+bounces-69227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDD9B91E51
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3B6190223C
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AE12E282C;
	Mon, 22 Sep 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHsXG/iP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F57260D;
	Mon, 22 Sep 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554788; cv=none; b=UGDiOFers7QIrRuh3CC/kEunJzqFttnD+33J7f5veK3NRCb9hP4kFfIQ9Aibyj3CQKDLkf06ZuGAJawyXDRj1sWFJgYyyjo0DoRtyedszjaT/HujQXxH6TXmuUpa6cc/ewlSA6vwSFZA1rEeGVbzDpIppnJIrhcaislAluanbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554788; c=relaxed/simple;
	bh=j7fSi2SD0jfG5RGBIM/wh5SHyLFqGezBi5kQ1Rg1+Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B0pbmHg1GGOzuMNjwkOVOjr68f43J/SCgpclFsLpm/IZ+s9TnZT8Y2fqH7cbmjdDElaXeNnu1kRdjZctZChMTcmlWWyOSZ/uc8tS/sUznLLtjWRPy5YLMGEaBlAQ6kz4ar8ZUP4AlayzkFBKsIBiPhn+B7EYddd7qqwQCEyJXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHsXG/iP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758554787; x=1790090787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j7fSi2SD0jfG5RGBIM/wh5SHyLFqGezBi5kQ1Rg1+Ug=;
  b=nHsXG/iPhArW6R1ImER1Wk7VLQ2ijV/0m94MXN8d/Rtj/4cfDjcmpO2n
   wO0paeEk0nUxsxlg8IzuYb3LFeKPsglvbj6dcMSYx7wNnf275sA56kAWM
   AvNrnbE9f48HRCzyVnWcqsD9QNoVr1n6drqFDD0YZpVt+Ze3xXNlcLkNN
   LyjnvCTu73B2teeffiW5J3ouYob1Ii2BFOrXADlGWKiI0gx00zH5QJYBl
   ClOWJ/ENwMgYqEZQnCj6XPpR+MWnY76Zns0+8ZUfc1/tvyuiURFLspfnR
   IqhjUtpS+yeR4aIBCUeRKTP90iabHzkhhD9Rs+4TeOVjJSRbpXZmmhCS4
   w==;
X-CSE-ConnectionGUID: R0i/9yeyT82l6It8za8dEw==
X-CSE-MsgGUID: fBasSbJXQ7K109thkbRAAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="63449202"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="63449202"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:26:26 -0700
X-CSE-ConnectionGUID: /d1kRwBlR4apn6YDY/073A==
X-CSE-MsgGUID: rhlf/03CS9KiJmnY/+VxpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207242195"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 22 Sep 2025 08:26:24 -0700
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
Subject: [PATCH bpf-next 0/3] xsk: refactors around generic xmit side
Date: Mon, 22 Sep 2025 17:25:57 +0200
Message-Id: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
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

Maciej Fijalkowski (3):
  xsk: avoid overwriting skb fields for multi-buffer traffic
  xsk: remove @first_frag from xsk_build_skb()
  xsk: wrap generic metadata handling onto separate function

 net/xdp/xsk.c | 109 +++++++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 49 deletions(-)

-- 
2.43.0


