Return-Path: <bpf+bounces-44254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821ED9C0B23
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44391C2358C
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FAF2178F8;
	Thu,  7 Nov 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIIEBd86"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDDF217650;
	Thu,  7 Nov 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996030; cv=none; b=i8tc39vrEHOIQfmuaHVMVUQIJNmfsfSAoBh4BxJobI6F19QQsWllhomIAiRAk7F26FgmYe/a18knfGRU9VhLo45vz4hRLW8KAyPmW8vO5zhx/mW6+ibt2A8SDIkZUJJ/4UVX+I1B471EC3v3tFUBzneO/tpmWLJVSFUz2saozRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996030; c=relaxed/simple;
	bh=4IC24vmZl6WDvgMu457OvjBdl317Y6deaK2gkmSPzBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld74aP/yUIhBPpW6aOSDCgi6EKIIuRp7KrgFcDU+vQ2GBY5cpZ14IAFcvvbUAb6nIkQnT3njTNa/zzTv5mtCq1d9Dh4U3BKg7l7MvkUK/utRmN8M6RVyKqGLsUOGomzulnFuNlH4yJvuAFd2hilMogEDXuGJJukhOpRC8gWPBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIIEBd86; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996028; x=1762532028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4IC24vmZl6WDvgMu457OvjBdl317Y6deaK2gkmSPzBk=;
  b=hIIEBd86mvgDYBts8Lx2WzNsG0oHYkALaKVFWGanFeo8TwHlJrdIAsXV
   j3uzwlsciZaQj1wzXeDiiODli0KSedc/iwjJ4MXAkXApscCZXegcdCQo9
   lRtQcIx3mObEXwZjHnlWWsQiNmlhvoTiaLhu9ImHzvv502ow/Lq+lpuU6
   /R0H3EQudSA1YCpUmrkca61Nf0/6P/YypXxSkyryewsrX6W8obOMrBXgm
   NLxchf3kNIKpX5Uds4RJBVKX7GXAzWXFEqdk01Lh9X1tNkU0nnOoAR2i3
   L6Ik4CsenCF1dDun8Q+h9LXXP32F7ubVilPPZDMABWUxmKfkR71gBzaST
   A==;
X-CSE-ConnectionGUID: tkTQiD4yTSyKXMbASqQBiw==
X-CSE-MsgGUID: 9JGz6hz6TxK9Edt7YMXO+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41955690"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41955690"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:13:48 -0800
X-CSE-ConnectionGUID: ISf04XLKSruvBqVGFSYWCg==
X-CSE-MsgGUID: 71ITT835QxO0RrQpnn6sIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258135"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:13:45 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 01/19] jump_label: export static_key_slow_{inc,dec}_cpuslocked()
Date: Thu,  7 Nov 2024 17:10:08 +0100
Message-ID: <20241107161026.2903044-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, there's a need to modify a lot of static keys or modify the
same key multiple times in a loop. In that case, it seems more optimal
to lock cpu_read_lock once and then call _cpuslocked() variants.
The enable/disable functions are already exported, the refcounted
counterparts however are not. Fix that to allow modules to save some
cycles.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/jump_label.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 93a822d3c468..1034c0348995 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -182,6 +182,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 	}
 	return true;
 }
+EXPORT_SYMBOL_GPL(static_key_slow_inc_cpuslocked);
 
 bool static_key_slow_inc(struct static_key *key)
 {
@@ -342,6 +343,7 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
 	STATIC_KEY_CHECK_USE(key);
 	__static_key_slow_dec_cpuslocked(key);
 }
+EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);
 
 void __static_key_slow_dec_deferred(struct static_key *key,
 				    struct delayed_work *work,
-- 
2.47.0


