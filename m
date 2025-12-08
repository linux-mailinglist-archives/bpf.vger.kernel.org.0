Return-Path: <bpf+bounces-76291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3EFCADA56
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 16:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70455306BD44
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B22686A0;
	Mon,  8 Dec 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/WQd5n7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55502226D18;
	Mon,  8 Dec 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208962; cv=none; b=IdXjgxyrq/PtgY7P8ZpHkvyhdWSdC3Wu1x8MSL1dTETdXgVp69YFY/cO6/xcyemeUEPfIYFT2/KE9iG7gD1oaxKAVFqhA6Ojtm6ZlgCh2P62c5Uf9jp963MlCOpOSrDZk8z8nF8NNI8MnvJ6klBpfe7SkC/Dv9+NoErGqYYMCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208962; c=relaxed/simple;
	bh=UDGd+yc9VyT/yH0pg75CPihHtLwXBfn3T3uCtCQGuFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EQYPZ4tMypb6EavPGFlgwlBqIT36sevmos6fzcIC4GsPR5xLaA6Mv45idn6NTCL91d1SievYO85DeQKbF878lCzWu7xl5UphWKTLAu3T200Twuc8fir5Hln+dJrRti+EYwMh0rg622GT2k9lsA5BT4/XItStn3Ltg5l++W30PTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/WQd5n7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765208960; x=1796744960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UDGd+yc9VyT/yH0pg75CPihHtLwXBfn3T3uCtCQGuFQ=;
  b=a/WQd5n7xBRr1EHMxmjBLO3McTunsAdDF8DPCTe0pCRLi0uoDU4DZC7z
   LRreWbVGZWxNW0QbgwBvx3X8iBLXz5QRsGSi70xtsFneY8wpWKy45MHsl
   sRx3F12q4ZolhxTuaKoozDz4dvz47MoYHBghwOEtA9dBPkGyTivCzTmYY
   Y0qL9hF49FlNUDAqSti70DPUbu1Wj4Nm6l+xMorPdunqEQqGxQH1Ol1xp
   ccqtzhTviU2blpWJ1qTgunCBu72EPKs0dzBoOM0Z+MWyBo8lCM0z6Ch+g
   XokgdvsT/MTWOi/mltUa28YbsZpLBtYyTi53JJhHuOsU36r4rw6QvZwGU
   w==;
X-CSE-ConnectionGUID: XAHbLj/CQuKc/iFG8x4x1g==
X-CSE-MsgGUID: GzWORqoXT2+M9LVrjCfkuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67187902"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="67187902"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:48:54 -0800
X-CSE-ConnectionGUID: S7AvIw4/ScW8cgmDwh6zCg==
X-CSE-MsgGUID: GVphQdSETt+Yk5YdOyskBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="195760916"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 08 Dec 2025 07:48:49 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9753298; Mon, 08 Dec 2025 16:48:47 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mirsad Todorovac <mtodorovac69@yahoo.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] bpf: Mark bpf_stream_vprintk_impl() with __printf() attribute
Date: Mon,  8 Dec 2025 16:48:46 +0100
Message-ID: <20251208154846.2901693-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_stream_vprintk_impl() is using printf() type of format, and compiler
is not happy about them as is:

kernel/bpf/stream.c:241:9: error: function ‘bpf_stream_vprintk_impl’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
  241 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin_args);
      |         ^~~

Fix the compilation errors by adding __printf() attribute.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/bpf/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 0b6bc3f30335..4bff72e3c16f 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -212,6 +212,7 @@ __bpf_kfunc_start_defs();
  * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
  * enum in headers.
  */
+__printf(2, 0)
 __bpf_kfunc int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
 					u32 len__sz, void *aux__prog)
 {
-- 
2.50.1


