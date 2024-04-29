Return-Path: <bpf+bounces-28074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82398B5748
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1411F21D50
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C40535AA;
	Mon, 29 Apr 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1rWMRgP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1BB4D5A2;
	Mon, 29 Apr 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392026; cv=none; b=C8Yyo9gwM0Zk/JjC8noMe+tzzrN1TjKDUt2r5+XVPS4y0R1Y7YHtanjT7HVqKM/Dn2nqUh7PCP2lEjiBpuPGGAtBnrgvYT8gG6yq80ioOAocvTOCfiqsC8FuKRVF/e/HLYv7ykbDcI+ZyvWE89FcXQmjyJZnSve2+QtbnqS+q70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392026; c=relaxed/simple;
	bh=hNReNeYTpfIULcJuF2gEsqCmdOprPMwUabi9ZhnESwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/1/Fqfe4wXdDOIyjxRQa/MLTKymDjSHocD61qgXXonzN3xrOar0U8WhZ5p/mWyqzMxxKuzisRnP9sMhICyAvxeAmtH/o/J4OUbFjAjHh3YDk7dCr56ehUA/6GqaPwiAPDY2BriUZgjSuvUThpjcRrZXNbSY18zyz1zCLnN8n4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1rWMRgP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392025; x=1745928025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hNReNeYTpfIULcJuF2gEsqCmdOprPMwUabi9ZhnESwQ=;
  b=V1rWMRgPTAPI59RwBaLA/IndQl+PzAGD0ls4+8TPg0xemW71ytaLi8nH
   MiYkGv0nIj6EUle8jUjj9q20OYs+dE1tmX2VxiyiT13j+jxrZ7tAjX9md
   65m5X7yWUbur02/iDdjjeDEqafLbWPOVROQBcXYMwDsvNioauzmQCdmuM
   zkrAI9y1dDgT3S6waLK2R6+52HBmb3yJfIb3OvL0wO/jSFl0YP1rroHKc
   6/G/9047W8jJsTRA9NVAbtcwkfPaTvqHqzWzG9CFkW/qUhQcYiYR8Hzvz
   yP7z65tka7qNUMlBbdaHot6Cex73TYiQn3I0jXiPTby4p+WKW5HTsw5iY
   w==;
X-CSE-ConnectionGUID: IQ7jTKWuTeyZ4+Qpx/LOuA==
X-CSE-MsgGUID: WhU1MuiIQNWI8/hJXa98wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9876776"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9876776"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:00:21 -0700
X-CSE-ConnectionGUID: guqDvAGkROiAQGdhFIY/lA==
X-CSE-MsgGUID: OotK0ZcCQbiSV6fjkutl2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="49300112"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 29 Apr 2024 05:00:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3CBA215B; Mon, 29 Apr 2024 15:00:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] bpf: Switch to krealloc_array()
Date: Mon, 29 Apr 2024 15:00:05 +0300
Message-ID: <20240429120005.3539116-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the krealloc_array() copy the original data and
check for a multiplication overflow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 466c2deeecff..778775bdbb2e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -849,7 +849,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 		return -EINVAL;
 	}
 
-	tab = krealloc(tab, size * sizeof(*poke), GFP_KERNEL);
+	tab = krealloc_array(tab, size, sizeof(*poke), GFP_KERNEL);
 	if (!tab)
 		return -ENOMEM;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


