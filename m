Return-Path: <bpf+bounces-20452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B083EADC
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 05:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897E61F2553A
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 04:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDECE125C3;
	Sat, 27 Jan 2024 04:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WlZNQTes"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1311CAE;
	Sat, 27 Jan 2024 04:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328295; cv=none; b=Mss9CLXtm21pWYHUskSLtchF9sE5XrveEoqFqfUf6Ed4P30fOmiq7BMNmFj4EInaVlJ9BghR1AaqFbO5mNcAwhbd4d2TwEOFflFAsp0m88SrvOWXXpb4dWoWnlwP3o6p6zw/7R5LX/RPHBLMi68qwvVaV24vpJR58DTrHMLlZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328295; c=relaxed/simple;
	bh=GbF14G6YpxSnI2dRMEHZjL9Vnu5yGrLLsZmxi9qC+8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kf0kNP7vxsZxv07v/JRLf+nQ1a3UhEU9HszBym22ppZYG82HWkXjPKoRHXJLl+5tWu++LYTqkO+ErI2pgWgk4twwbXw9z3TlIrZueKVJJbKrYd5KKXNzHY8q20Zz3M9wQDzIfDIRjb3SnlE+rMejtWHoX4uJEEAbDrg5bQbv7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WlZNQTes; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706328293; x=1737864293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GbF14G6YpxSnI2dRMEHZjL9Vnu5yGrLLsZmxi9qC+8c=;
  b=WlZNQTesk2bxX0nJS08GOTuUwNjU6ZgO4u2KGZ2sjKdyWgBn4TTS5Igu
   kIbRLL6XZ+i08JuNQQisbx1LR8KXR2d7ssIX1mdiAHBvUjl1Jm6OaWLxL
   6xSRx+5VQKXw6UoE4ZRgqNxyWEDo2JsI+bCLm20h0dk4iymSIhfk4K8UX
   2c7wV6+za/s5NnVmb1vGL5GHEbP4CZNCIwef7xvgApxFbJP4dGNoJBf3a
   zfy9BkZxGENktJvTESef0+tjKV3DwS4NsTy9wz/TEQaLNzVkxO2V31fWW
   yZtw0mtsR6dfhjk9IdSa6ERz4njlkhM6ktZNuaVszd261a/joQ9MkXR0F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402289588"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="402289588"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 20:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787309780"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787309780"
Received: from ppglcf2090.png.intel.com ([10.126.160.96])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2024 20:04:47 -0800
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next 0/3] net: stmmac: EST conformance support
Date: Sat, 27 Jan 2024 12:04:40 +0800
Message-Id: <20240127040443.24835-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset enables support for queueMaxSDU and transmission overrun
counters which are required for Qbv conformance.

Rohan G Thomas (3):
  net: stmmac: Offload queueMaxSDU from tc-taprio
  net: stmmac: est: Per Tx-queue error count for HLBF
  net: stmmac: Report taprio offload status

 drivers/net/ethernet/stmicro/stmmac/common.h  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_est.c  |  6 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 87 ++++++++++++++++++-
 include/linux/stmmac.h                        |  1 +
 5 files changed, 114 insertions(+), 4 deletions(-)

-- 
2.26.2


