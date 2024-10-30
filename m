Return-Path: <bpf+bounces-43573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0779B69A5
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB961C20C59
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822A21745C;
	Wed, 30 Oct 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQpsGetu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337621503E;
	Wed, 30 Oct 2024 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307219; cv=none; b=VosBSbKYXAcd8Rewv3yhor36aHXnPxHnccULPmuaj2Zj0EzCyGvk04TLHPnEP88v8jJkS7CsuoB1VFQEAysM3y8dQWv99nJSRBIsBuCXBtnXYx2H9BrGiA3fGMRTS/+m6nbjPILnYH10YsV4aoGArw0lvTxOdT5vSUQbAjqalDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307219; c=relaxed/simple;
	bh=4IC24vmZl6WDvgMu457OvjBdl317Y6deaK2gkmSPzBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp7AcEjzUrdj3O44uS4SvCOpcViFaBUqT5GfqShn6PvZxizEsVp2z280+ncSgQXrXF4Z53qY5kg1y8lkpyL94UjZXNo0qLBFvNi1UMXUIyYhEZ/lKsKsq+BcuHWzofkKH/ZKUNL0aSW1xHeGQCtG8BZc2NfNtq7NA2bbbxjdJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQpsGetu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730307214; x=1761843214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4IC24vmZl6WDvgMu457OvjBdl317Y6deaK2gkmSPzBk=;
  b=PQpsGetudLQEvkIVDPOLgCdAU3ZmwUUIS9932qb/olgAeFoxqGYFUmMH
   A6OJAaSKortCHpeejnDYpwdWIAU14+jbDt5nonilDmsLctzvI+P7bP0M3
   lBoz9nDFgpRfYypk6UQyVLImWnK5nADNIX7VqJ3A3ptzqI0O+5ZNngAic
   dcfcT2n8lnGMkiHMPO5p1FBXnNWtCe0gozI+IhXS7wh3/Ph8Eq+bV/xUr
   rAzlZBnLehP4mKqmSM2qVakbVgCi+yad/5zxdSXcl1O491N3to4vrWJKx
   53aF+1z5jSz3klYxQeFK9elD+Q6jF4UXP8NTLfwtwJ2SSTB+XnbXmZcef
   g==;
X-CSE-ConnectionGUID: /7WIL5u7SviqIPlzoIUlUg==
X-CSE-MsgGUID: jGjZ9hEuSc+0JEKD794j2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41389578"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41389578"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:53:34 -0700
X-CSE-ConnectionGUID: BOTqG3KhRzyfxhaFYlAdig==
X-CSE-MsgGUID: qKryydcOQSWwx42agsRs1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87524431"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 09:53:30 -0700
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
Subject: [PATCH net-next v3 01/18] jump_label: export static_key_slow_{inc,dec}_cpuslocked()
Date: Wed, 30 Oct 2024 17:51:44 +0100
Message-ID: <20241030165201.442301-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030165201.442301-1-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
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


