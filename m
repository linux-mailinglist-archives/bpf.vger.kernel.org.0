Return-Path: <bpf+bounces-38569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DCC9666C0
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D09E2837AB
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B47B1B9B26;
	Fri, 30 Aug 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XY/HOHjs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA081B81B4;
	Fri, 30 Aug 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035143; cv=none; b=dD0LpuFrnp22dzlcM8r/egJfrNkuEzmx8BpK2npmdXcowcWux4rBHFLnXNQLbu/lFra/VhjLf75MpJrFPtWeKUe56pRjY+tWxoW4E+UuKpSefhuq+nV5f69BH6S7xEKh74iuLaWLma5LuJ6qzkU1g/ZrnaPGpyJLPesQ7NYwT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035143; c=relaxed/simple;
	bh=jcA9U7OKabMeHIJY0Zn6UT9mfWJf+XLAQpUH7kwaMnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzRJKr18Zk6dC0awbnAxPuEqPfmANSQOv5Q0OhJE6awW+9ubgUodGM9zI7DfmYz+HBuab/CL48e65bZZitDgVWE2DpJA6IlqNtaTpCoY4g4eAl+aueJKTlCLGY8cRNTZA/isMI0spXS+LBySPhDE4hqIBoPBDqJVeon29+xbqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XY/HOHjs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035142; x=1756571142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcA9U7OKabMeHIJY0Zn6UT9mfWJf+XLAQpUH7kwaMnQ=;
  b=XY/HOHjsTpzmaCDNU6SXfh20x75ZZZ2BzExfyIO/OGCTUMZCqufF6tSS
   rPs4WdeJritBxX6StDFKOMWr9OHHbfpnmDQ/dkZv71l6A3pa58UrxWesi
   0VShzdPvNUkE7jxbhpWnsMkKZlz4yHgDivDA6ro0pd2/7NGkBJ1c+9RMa
   nMWrtzYcsdlV7oIEBkc4jhqU4fSK5npy53RZeepzful+pCjZgeDqo0iIz
   RJtdNgYtL+MoQlxqt6Mhf3TphI4fSN9GvIi0fQbFh+ZW/BfSCwCJ9W1jt
   2XxWxQ8EwSoocZO915jxfQOAmdiFy1YVBrac5gI4qn94CUZ0ZuEq9KtEl
   Q==;
X-CSE-ConnectionGUID: 755w5N9cTcGB68mnNmqDwg==
X-CSE-MsgGUID: 5QJE7LQ7TnSzZbkMFJ4m3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49068878"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49068878"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:25:42 -0700
X-CSE-ConnectionGUID: MWh4kfuJS42GLauEUYyTvw==
X-CSE-MsgGUID: UDm8HCqnSBaAwilaLVSrAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996434"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:25:38 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/9] firmware/psci: fix missing '%u' format literal in kthread_create_on_cpu()
Date: Fri, 30 Aug 2024 18:25:00 +0200
Message-ID: <20240830162508.1009458-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kthread_create_on_cpu() always requires format string to contain one
'%u' at the end, as it automatically adds the CPU ID when passing it
to kthread_create_on_node(). The former doesn't marked as __printf()
as it's not printf-like itself, which effectively hides this from
the compiler.
If you convert this function to printf-like, you'll see the following:

In file included from drivers/firmware/psci/psci_checker.c:15:
drivers/firmware/psci/psci_checker.c: In function 'suspend_tests':
drivers/firmware/psci/psci_checker.c:401:48: warning: too many arguments for format [-Wformat-extra-args]
     401 |                                                "psci_suspend_test");
         |                                                ^~~~~~~~~~~~~~~~~~~
drivers/firmware/psci/psci_checker.c:400:32: warning: data argument not used by format string [-Wformat-extra-args]
     400 |                                                (void *)(long)cpu, cpu,
         |                                                                   ^
     401 |                                                "psci_suspend_test");
         |                                                ~~~~~~~~~~~~~~~~~~~

Add the missing format literal to fix this. Now the corresponding
kthread will be named as "psci_suspend_test-<cpuid>", as it's meant by
kthread_create_on_cpu().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408141012.KhvKaxoh-lkp@intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202408141243.eQiEOQQe-lkp@intel.com
Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
Cc: stable@vger.kernel.org # 4.10+
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/firmware/psci/psci_checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 116eb465cdb4..ecc511c745ce 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -398,7 +398,7 @@ static int suspend_tests(void)
 
 		thread = kthread_create_on_cpu(suspend_test_thread,
 					       (void *)(long)cpu, cpu,
-					       "psci_suspend_test");
+					       "psci_suspend_test-%u");
 		if (IS_ERR(thread))
 			pr_err("Failed to create kthread on CPU %d\n", cpu);
 		else
-- 
2.46.0


