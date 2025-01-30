Return-Path: <bpf+bounces-50179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD3A23803
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 00:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF13A73F1
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 23:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49D1F236A;
	Thu, 30 Jan 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njBD4Cqe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CD1537C6;
	Thu, 30 Jan 2025 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738280565; cv=none; b=Z+qiGuLARqZHt8OAlL0yRv339yMcz/ySJXPpzfjrsp013IAwXvc13WliwOKafT1tL/1X5ngV3ytviBOYkFQXhM99rzX3/YNkTodIFM+yU0LmD8PYJJEmF+Ckcv1ypekJD1lmVl1DGjFDtBGVrfj+glq0hQwFSuJBCmEONcgbpf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738280565; c=relaxed/simple;
	bh=SNgWdW0+w8g7zWzmvBJ6hqxTIrMFupouLSnDTRPedqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J0Cf9nrwbfYy1nk/OPvNKgmUxvVCpf1YGyn6cb2AZiHbMd7YNcxJHdu8ePWpuObn6tDGsA590kB/e3gqJf18T1JVX/oeB7+ggUpJPutMGJ5+BwO+viR+3O9Q7J5/RAlSqPu6mWalSOZfunnJLukeAIVZBfYEhhrew1Rze2UvkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njBD4Cqe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738280564; x=1769816564;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SNgWdW0+w8g7zWzmvBJ6hqxTIrMFupouLSnDTRPedqs=;
  b=njBD4CqeB5D6xy51Tc8bVyUbpf5GhYjisE/+RIUI25Dnsi7knQt37i8z
   //ijX4l6nYKHHS0knmhUaRKBvco9pV0iarSJuxZiyu+5SezGAvDMIM5Wp
   ZebOAruyR7yqYNWyBgB+8QvxPNhS3svWXqCR+52c2YqLUYR74D8l2Q84/
   pCmMfO0mKFOpQ4vocePBpmNlezhf/mtWNCM/Q5G0aJVj2IkyYocXzXbar
   06Z5WWdawqfu5mnVYRxKJXPqZqq7Ygu8v0fokcd9mA1JmlvYZoLDXEzUk
   r+kX2xXFiXUlnvL0BF162Gw11lvWf2qEnJ6vCpVf8UpKOR8sRFWDMd6QT
   w==;
X-CSE-ConnectionGUID: MFZdPN7BRiOJxwDUgsSmuA==
X-CSE-MsgGUID: osTrCAaoTqugUPDE/80O4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="56392369"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="56392369"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 15:42:43 -0800
X-CSE-ConnectionGUID: AX6mNGHhQwWBZd3qMSmH6A==
X-CSE-MsgGUID: tg0EZPT9SgeNGo2EEfp3cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114081720"
Received: from johunt-mobl9.ger.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.4])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 15:42:41 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Zdenek Bouska <zdenek.bouska@siemens.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Florian Bezdeka
 <florian.bezdeka@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, Song
 Yoong Siang <yoong.siang.song@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Zdenek Bouska
 <zdenek.bouska@siemens.com>
Subject: Re: [PATCH] igc: Fix HW RX timestamp when passed by ZC XDP
In-Reply-To: <20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
References: <20250128-igc-fix-hw-rx-timestamp-when-passed-by-zc-xdp-v1-1-b765d3e972de@siemens.com>
Date: Thu, 30 Jan 2025 15:42:41 -0800
Message-ID: <87r04jc1hq.fsf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zdenek Bouska <zdenek.bouska@siemens.com> writes:

> Fixes HW RX timestamp in the following scenario:
> - AF_PACKET socket with enabled HW RX timestamps is created
> - AF_XDP socket with enabled zero copy is created
> - frame is forwarded to the BPF program, where the timestamp should
>   still be readable (extracted by igc_xdp_rx_timestamp(), kfunc
>   behind bpf_xdp_metadata_rx_timestamp())
> - the frame got XDP_PASS from BPF program, redirecting to the stack
> - AF_PACKET socket receives the frame with HW RX timestamp
>
> Moves the skb timestamp setting from igc_dispatch_skb_zc() to
> igc_construct_skb_zc() so that igc_construct_skb_zc() is similar to
> igc_construct_skb().
>
> This issue can also be reproduced by running:
>  # tools/testing/selftests/bpf/xdp_hw_metadata enp1s0
> When a frame with the wrong port 9092 (instead of 9091) is used:
>  # echo -n xdp | nc -u -q1 192.168.10.9 9092
> then the RX timestamp is missing and xdp_hw_metadata prints:
>  skb hwtstamp is not found!
>
> With this fix or when copy mode is used:
>  # tools/testing/selftests/bpf/xdp_hw_metadata -c enp1s0
> then RX timestamp is found and xdp_hw_metadata prints:
>  found skb hwtstamp = 1736509937.852786132
>
> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

