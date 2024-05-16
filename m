Return-Path: <bpf+bounces-29845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1498C7446
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954411F24786
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE014388B;
	Thu, 16 May 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJECdNHv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CF143880;
	Thu, 16 May 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853678; cv=none; b=a2wHoEU6OByCXdC5gcvmR2jGP1iurTYxpOP2UTi49hghBmv629t96j8aOA3qZK6qjJQQieTOnf1urGuH6T72pr02zw3FyuJ6NUNTroIRkZatkGUx7q0LIoH0mog1CNWEY9tm6XkM3xY1RNbjovOdXb35onhV4YpePo9kEXrNxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853678; c=relaxed/simple;
	bh=JLPwevbZr7qyG05/ysC6iuRNGwXqdjfIgp7fbEN99Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VytLfL7GNry4d6hglix22AylqGbLhyP5dXIlnzJOW3PGGh7HM8i6kcpMH0xw8pByIMFThRygg3oKhjbR38/06gwBG9YfOorAo1C3YogdYOPgEpKIDv1f0bw+EB3ONTXUUVYiOcIhpem7hjURljUC8ScXv1dAWOmHA+cUwtQx3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJECdNHv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715853677; x=1747389677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JLPwevbZr7qyG05/ysC6iuRNGwXqdjfIgp7fbEN99Og=;
  b=RJECdNHvCEL5+AcGvQ2KXToO2xo2vX8bWOwlOYR8QflyG3Es8OIrChDI
   AyOS6eolm28/EMUr5+W3iFPWN9NHTbvtJTEfdNRRqeToIPrLEpRe+rg2T
   PEAvh1EJPxSn1nYGB2fxNPYL56X9tDhhZfwbAiPrMYAT4XQFoSC2qSxAw
   hyrR7++OzRNC0DgobE4sgMLhVysnA263cZ3eVgIaWweT7HUX62GBJIPYI
   G+6nQYWkbjNJBKM3FpkbC3icrVO+g+sZsKMBE1t3+C9PHgem+NmAoDARV
   jZ5hnN2vwQSTGiBG4vACk7epb8r6Cq5hY5Q2BcoHuZHStYeIpVdoHcB/u
   g==;
X-CSE-ConnectionGUID: yTF68hfmQmuESq0uVNgcCQ==
X-CSE-MsgGUID: 1JlLBk9YTtaOP3QQ+9GduQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="14904542"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="14904542"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:01:15 -0700
X-CSE-ConnectionGUID: iFfmqHnZTvWBzGzC4IR4PQ==
X-CSE-MsgGUID: 08gnIcHCTqunVJDmnlbing==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="35813173"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa005.fm.intel.com with ESMTP; 16 May 2024 03:01:11 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: larysa.zaremba@intel.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	igor.bagnucki@intel.com,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH iwl-net 2/3] ice: add flag to distinguish reset from .ndo_bpf in XDP rings config
Date: Thu, 16 May 2024 12:00:39 +0200
Message-Id: <20240516100039.88189-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240515160246.5181-3-larysa.zaremba@intel.com>
References: <20240515160246.5181-3-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

This patch also fixes an issue when XDP programs become detached from the RX rings on channel number reconfiguration

Regards,
Sergey

